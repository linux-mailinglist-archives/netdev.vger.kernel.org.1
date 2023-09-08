Return-Path: <netdev+bounces-32597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF8798A19
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 17:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B35281B11
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B71F513;
	Fri,  8 Sep 2023 15:39:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8115694
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 15:39:12 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730291BFF
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:39:11 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-y9NInGZkO2CWy-vMgH0Jcg-1; Fri, 08 Sep 2023 11:38:52 -0400
X-MC-Unique: y9NInGZkO2CWy-vMgH0Jcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0235989CB12;
	Fri,  8 Sep 2023 15:38:52 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D325763F67;
	Fri,  8 Sep 2023 15:38:50 +0000 (UTC)
Date: Fri, 8 Sep 2023 17:38:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Dave Watson <davejwatson@fb.com>, Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <ZPtACbUa9rQz0uFq@hog>
References: <cover.1694018970.git.sd@queasysnail.net>
 <be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
 <20230906204727.08a79e00@kernel.org>
 <ZPm__x5TcsmqagBH@hog>
 <ZPq51KxgmELpTgOs@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZPq51KxgmELpTgOs@gondor.apana.org.au>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

2023-09-08, 14:06:12 +0800, Herbert Xu wrote:
> On Thu, Sep 07, 2023 at 02:21:59PM +0200, Sabrina Dubroca wrote:
> >
> > Herbert, WDYT? We're calling tls_do_decryption twice from the same
> > tls_sw_recvmsg invocation, first with darg->async =3D true, then with
> > darg->async =3D false. Is it ok to use ctx->async_wait for both, or do
> > we need a fresh one as in this patch?
>=20
> Yes I think your patch makes sense and the existing code could
> malfunction if two decryption requests occur during the same
> tls_sw_recvmsg call, with the first being async and the second
> being sync.

Thanks for confirming. I'll add it to v2 of this series.

> However, I'm still unsure about the case where two async decryption
> requests occur during the same tls_sw_recvmsg call.  Or perhaps this
> is not possible due to other constraints that are not obvious?

tls_decrypt_done only runs the completion when decrypt_pending drops
to 0, so this should be covered.


I wonder if this situation could happen:

tls_sw_recvmsg
  process first record
    decrypt_pending =3D 1
                                  CB runs
                                  decrypt_pending =3D 0
                                  complete(&ctx->async_wait.completion);

  process second record
    decrypt_pending =3D 1
  tls_sw_recvmsg reaches "recv_end"
    decrypt_pending !=3D 0
    crypto_wait_req sees the first completion of ctx->async_wait and procee=
ds

                                  CB runs
                                  decrypt_pending =3D 0
                                  complete(&ctx->async_wait.completion);


With my force_async patch I've managed to run into situations where
the CB runs before we reach the crypto_wait_req at the end of
tls_sw_recvmsg (patch 4 of this series [1]). I don't know if it's a
side-effect of my hack or if it's realistic.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/e094325019f7fd9604=
70c10efda41c1b7f9bc54f.1694018970.git.sd@queasysnail.net/

--=20
Sabrina


