Return-Path: <netdev+bounces-30780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D11578907F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6321C2104E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58419880;
	Fri, 25 Aug 2023 21:36:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDC1ADD7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:43 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2DB26A2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:41 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-QB8LcFizPY2yw3yo2rWUmA-1; Fri, 25 Aug 2023 17:36:36 -0400
X-MC-Unique: QB8LcFizPY2yw3yo2rWUmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 405F11C07595;
	Fri, 25 Aug 2023 21:36:36 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 726E61678B;
	Fri, 25 Aug 2023 21:36:35 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 10/17] tls: expand use of tls_cipher_desc in tls_set_device_offload
Date: Fri, 25 Aug 2023 23:35:15 +0200
Message-Id: <8ab71b8eca856c7aaf981a45fe91ac649eb0e2e9.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
References: <cover.1692977948.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tls_set_device_offload is already getting iv and rec_seq sizes from
tls_cipher_desc. We can now also check if the cipher_type coming from
userspace is valid and can be offloaded.

We can also remove the runtime check on rec_seq, since we validate it
at compile time.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_device.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 98885d872d4c..8c94c926606a 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1079,29 +1079,15 @@ int tls_set_device_offload(struct sock *sk, struct =
tls_context *ctx)
 =09=09goto release_netdev;
 =09}
=20
-=09switch (crypto_info->cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128:
-=09=09iv =3D ((struct tls12_crypto_info_aes_gcm_128 *)crypto_info)->iv;
-=09=09rec_seq =3D
-=09=09 ((struct tls12_crypto_info_aes_gcm_128 *)crypto_info)->rec_seq;
-=09=09break;
-=09case TLS_CIPHER_AES_GCM_256:
-=09=09iv =3D ((struct tls12_crypto_info_aes_gcm_256 *)crypto_info)->iv;
-=09=09rec_seq =3D
-=09=09 ((struct tls12_crypto_info_aes_gcm_256 *)crypto_info)->rec_seq;
-=09=09break;
-=09default:
-=09=09rc =3D -EINVAL;
-=09=09goto release_netdev;
-=09}
 =09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
-
-=09/* Sanity-check the rec_seq_size for stack allocations */
-=09if (cipher_desc->rec_seq > TLS_MAX_REC_SEQ_SIZE) {
+=09if (!cipher_desc || !cipher_desc->offloadable) {
 =09=09rc =3D -EINVAL;
 =09=09goto release_netdev;
 =09}
=20
+=09iv =3D crypto_info_iv(crypto_info, cipher_desc);
+=09rec_seq =3D crypto_info_rec_seq(crypto_info, cipher_desc);
+
 =09prot->version =3D crypto_info->version;
 =09prot->cipher_type =3D crypto_info->cipher_type;
 =09prot->prepend_size =3D TLS_HEADER_SIZE + cipher_desc->iv;
--=20
2.40.1


