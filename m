Return-Path: <netdev+bounces-32604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24245798AC9
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C87281B9E
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC4E56D;
	Fri,  8 Sep 2023 16:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E615B6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 16:42:21 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38A19B6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 09:42:20 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-T7lnyLPjP2SGUZjkrk49JA-1; Fri, 08 Sep 2023 12:42:00 -0400
X-MC-Unique: T7lnyLPjP2SGUZjkrk49JA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24B60101CA89;
	Fri,  8 Sep 2023 16:42:00 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D37040C84A5;
	Fri,  8 Sep 2023 16:41:58 +0000 (UTC)
Date: Fri, 8 Sep 2023 18:41:57 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "liujian (CE)" <liujian56@huawei.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vfedorenko@novek.ru, netdev@vger.kernel.org
Subject: Re: [PATCH net] tls: do not return error when the tls_bigint
 overflows in tls_advance_record_sn()
Message-ID: <ZPtO1VDcYSIFVnie@hog>
References: <20230906065237.2180187-1-liujian56@huawei.com>
 <ZPhcTQ3mFQYmTHet@hog>
 <a6dec380-1ebc-d495-da67-7bd61525d4a8@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a6dec380-1ebc-d495-da67-7bd61525d4a8@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

2023-09-07, 20:59:51 +0800, liujian (CE) wrote:
> By the way, does the return of EBADMSG mean that the tls link needs to
> renegotiate the encryption information or re-establish the link?

We currently don't support key updates so closing this socket is the
only option for now. AFAIU when we set EBADMSG, we can't fix that socket.

> And is this okay?

Yes, this is what I had in mind.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 1ed4a611631f..d1fc295b83b5 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -817,7 +817,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg,
> struct sock *sk,
>         psock =3D sk_psock_get(sk);
>         if (!psock || !policy) {
>                 err =3D tls_push_record(sk, flags, record_type);
> -               if (err && sk->sk_err =3D=3D EBADMSG) {
> +               if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBA=
DMSG) {
>                         *copied -=3D sk_msg_free(sk, msg);
>                         tls_free_open_rec(sk);
>                         err =3D -sk->sk_err;
> @@ -846,7 +846,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg,
> struct sock *sk,
>         switch (psock->eval) {
>         case __SK_PASS:
>                 err =3D tls_push_record(sk, flags, record_type);
> -               if (err && sk->sk_err =3D=3D EBADMSG) {
> +               if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBA=
DMSG) {
>                         *copied -=3D sk_msg_free(sk, msg);
>                         tls_free_open_rec(sk);
>                         err =3D -sk->sk_err;

--=20
Sabrina


