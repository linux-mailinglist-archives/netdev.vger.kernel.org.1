Return-Path: <netdev+bounces-32232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E381793A95
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23282812C1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C9B111E;
	Wed,  6 Sep 2023 11:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A57E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:03:01 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F3F9
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:02:59 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-v5yco5_CMvqNho2P1iiCJQ-1; Wed, 06 Sep 2023 07:02:41 -0400
X-MC-Unique: v5yco5_CMvqNho2P1iiCJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 732A28030A9;
	Wed,  6 Sep 2023 11:02:40 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD725200BC49;
	Wed,  6 Sep 2023 11:02:38 +0000 (UTC)
Date: Wed, 6 Sep 2023 13:02:37 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Liu Jian <liujian56@huawei.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vfedorenko@novek.ru, netdev@vger.kernel.org
Subject: Re: [PATCH net] tls: do not return error when the tls_bigint
 overflows in tls_advance_record_sn()
Message-ID: <ZPhcTQ3mFQYmTHet@hog>
References: <20230906065237.2180187-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230906065237.2180187-1-liujian56@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-06, 14:52:37 +0800, Liu Jian wrote:
> This is because the value of rec_seq of tls_crypto_info configured by the
> user program is too large, for example, 0xffffffffffffff. In addition, TL=
S
> is asynchronously accelerated. When tls_do_encryption() returns
> -EINPROGRESS and sk->sk_err is set to EBADMSG due to rec_seq overflow,
> skmsg is released before the asynchronous encryption process ends. As a
> result, the UAF problem occurs during the asynchronous processing of the
> encryption module.
>=20
> I didn't see the rec_seq overflow causing other problems, so let's get ri=
d
> of the overflow error here.
>=20
> Fixes: 635d93981786 ("net/tls: free record only on encryption error")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  net/tls/tls.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 28a8c0e80e3c..3f0e10df8053 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -304,8 +304,7 @@ static inline void
>  tls_advance_record_sn(struct sock *sk, struct tls_prot_info *prot,
>  =09=09      struct cipher_context *ctx)
>  {
> -=09if (tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size))
> -=09=09tls_err_abort(sk, -EBADMSG);
> +=09tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size);

That seems wrong. We can't allow the record number to wrap, if breaks
the crypto. See for example:
https://datatracker.ietf.org/doc/html/rfc5288#section-6.1

The real fix would be to stop the caller from freeing the skmsg and
record if we go async. Once we go through async crypto, the record etc
don't belong to the caller anymore, they've been transfered to the
async callback. I'd say we need both tests in bpf_exec_tx_verdict:
-EINPROGRESS (from before 635d93981786) and EBADMSG (from
635d93981786).

Actually we need to check for both -EINPROGRESS and -EBUSY as I've
recently found out.

I've been running the selftests with async crypto and have collected a
few fixes that I was going to post this week (but not this one, since
we don't have a selftest for wrapping rec_seq). One of the patches
adds -EBUSY checks for all existing -EINPROGRESS, since the crypto API
can return -EBUSY as well if we're going through the backlog queue.

--=20
Sabrina


