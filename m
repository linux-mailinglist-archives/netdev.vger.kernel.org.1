Return-Path: <netdev+bounces-21649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276F764177
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DA62817D9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F9CA63;
	Wed, 26 Jul 2023 21:53:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA981BF08
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:53:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6858211C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690408406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYYNLALC24HXACra46BapqSwKx6bYQvG9NeNwuOaFoA=;
	b=C9+uZo9JnZo00eC+K2XureZa/PCrUW9cvNvI4dXZLcGs3pHcg0S4Ss90T8iZv1oBwFeFIT
	6dLgTU2ll8XLdrvDQvpbXXNz61Qnxs14WyzP8eYFVLV14thVRJFT4kUCGW7cUGk1vXwIq2
	rAs9lfmJEGSecO2mXphKH3FYn8ex9Ng=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-BPv7HgEGMKuBxzs7DOfL6Q-1; Wed, 26 Jul 2023 17:53:22 -0400
X-MC-Unique: BPv7HgEGMKuBxzs7DOfL6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9FF71C0754A;
	Wed, 26 Jul 2023 21:53:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC262166B25;
	Wed, 26 Jul 2023 21:53:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
To: =?us-ascii?Q?=3D=3FUTF-8=3FB=3FT25kcmVqIE1vc27DocSNZWs=3D=3F=3D?= <omosnacek@gmail.com>,
    Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Paolo Abeni <pabeni@redhat.com>,
    Sven Schnelle <svens@linux.ibm.com>,
    Harald Freudenberger <freude@linux.vnet.ibm.com>,
    Bagas Sanjaya <bagasdotme@gmail.com>, linux-crypto@vger.kernel.org,
    linux-s390@vger.kernel.org, netdev@vger.kernel.org,
    regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: Fix missing initialisation affecting gcm-aes-s390
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Jul 2023 22:53:19 +0100
Message-ID: <97730.1690408399@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=20=20=20=20
Fix af_alg_alloc_areq() to initialise areq->first_rsgl.sgl.sgt.sgl to point
to the scatterlist array in areq->first_rsgl.sgl.sgl.

Without this, the gcm-aes-s390 driver will oops when it tries to do
gcm_walk_start() on req->dst because req->dst is set to the value of
areq->first_rsgl.sgl.sgl by _aead_recvmsg() calling
aead_request_set_crypt().

The problem comes if an empty ciphertext is passed: the loop in
af_alg_get_rsgl() just passes straight out and doesn't set areq->first_rsgl
up.

This isn't a problem on x86_64 using gcmaes_crypt_by_sg() because, as far
as I can tell, that ignores req->dst and only uses req->src[*].

[*] Is this a bug in aesni-intel_glue.c?

The s390x oops looks something like:

 Unable to handle kernel pointer dereference in virtual kernel address space
 Failing address: 0000000a00000000 TEID: 0000000a00000803
 Fault in home space mode while using kernel ASCE.
 AS:00000000a43a0007 R3:0000000000000024
 Oops: 003b ilc:2 [#1] SMP
 ...
 Call Trace:
  [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
  [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
  [<00000000a2a60888>] aead_recvmsg+0x478/0x698
  [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
  [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
  [<00000000a273e066>] vfs_read+0x26e/0x2a8
  [<00000000a273e8c4>] ksys_read+0xbc/0x100
  [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
  [<00000000a312ff30>] system_call+0x70/0x98
 Last Breaking-Event-Address:
  [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]

Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to create sc=
atterlists")
Reported-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
Link: https://lore.kernel.org/r/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqB=
hubxyk_A@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: Sven Schnelle <svens@linux.ibm.com>
cc: Harald Freudenberger <freude@linux.vnet.ibm.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-crypto@vger.kernel.org
cc: linux-s390@vger.kernel.org
cc: regressions@lists.linux.dev
---
 crypto/af_alg.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 06b15b9f661c..9ee8575d3b1a 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1192,6 +1192,7 @@ struct af_alg_async_req *af_alg_alloc_areq(struct soc=
k *sk,
=20
 	areq->areqlen =3D areqlen;
 	areq->sk =3D sk;
+	areq->first_rsgl.sgl.sgt.sgl =3D areq->first_rsgl.sgl.sgl;
 	areq->last_rsgl =3D NULL;
 	INIT_LIST_HEAD(&areq->rsgl_list);
 	areq->tsgl =3D NULL;


