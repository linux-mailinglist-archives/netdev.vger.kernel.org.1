Return-Path: <netdev+bounces-212777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D571B21E2B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDE0502DD3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9022C21C2;
	Tue, 12 Aug 2025 06:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8E15383A
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979599; cv=none; b=MbgLAw+siub0s8LmTD+BVlRM3LLAbXmmfBdJIukJF7D9S4K8eWHNhL6cnvy0w8AyqKYMOnuaXt00donNYcBFtsxB1g4YksWJVkRJSCo1gN1rVEsrYy8sLABXrMjTl85Tjz7HzJNuRw0DX7dKgPHJJNBgDfVOWtOKEase3i63cCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979599; c=relaxed/simple;
	bh=hWvl6sFiurrG5on6UGayYfVb/95zEYweB1Ipgr38NrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IRhfSJPP/ZVJhL3Sh3iFGaZV9t9SzQdNfugo2w6oAtD2d0Xqbt5ifm/PoQBKz5iK3pthzJCZr1+Va7VcnOeYwpQezmhodUc50Uv8QwKZFoRoDZm0n80xyRZaVYHjYgrS24W4xThRQ7T7yaNF59WJlsgGlteOMAHZeO0gZOxyBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5a29e070774411f0b29709d653e92f7d-20250812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:34eee76c-63a0-4c7d-8ebe-3706aa666c13,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:b3dcb2d5d2ba933f21f407e5b035cae6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5a29e070774411f0b29709d653e92f7d-20250812
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 771294797; Tue, 12 Aug 2025 14:19:50 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id F051816001A03;
	Tue, 12 Aug 2025 14:19:49 +0800 (CST)
X-ns-mid: postfix-689ADD04-6669681806
Received: from localhost.localdomain (unknown [10.42.12.141])
	by node4.com.cn (NSMail) with ESMTPA id 48AA916001A01;
	Tue, 12 Aug 2025 06:19:48 +0000 (UTC)
From: heminhong <heminhong@kylinos.cn>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	kuniyu@google.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: [PATCH] ipv6: sr: add validity check for algorithm ID
Date: Tue, 12 Aug 2025 14:19:44 +0800
Message-Id: <20250812061944.76781-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Minhong He <heminhong@kylinos.cn>

The seg6_genl_sethmac() directly uses the algid passed in by the user
without checking whether it is an HMAC algorithm supported by the
system. If the algid is invalid, unknown errors may occur during
subsequent use of the HMAC information.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 include/net/seg6_hmac.h | 1 +
 net/ipv6/seg6.c         | 5 +++++
 net/ipv6/seg6_hmac.c    | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
index 24f733b3e3fe..c34e86c99de3 100644
--- a/include/net/seg6_hmac.h
+++ b/include/net/seg6_hmac.h
@@ -49,6 +49,7 @@ extern int seg6_hmac_info_del(struct net *net, u32 key)=
;
 extern int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
 			  struct ipv6_sr_hdr *srh);
 extern bool seg6_hmac_validate_skb(struct sk_buff *skb);
+extern struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id);
 #ifdef CONFIG_IPV6_SEG6_HMAC
 extern int seg6_hmac_init(void);
 extern void seg6_hmac_exit(void);
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 180da19c148c..33c1481ca50a 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -152,6 +152,7 @@ static int seg6_genl_sethmac(struct sk_buff *skb, str=
uct genl_info *info)
 	struct net *net =3D genl_info_net(info);
 	struct seg6_pernet_data *sdata;
 	struct seg6_hmac_info *hinfo;
+	struct seg6_hmac_algo *algo;
 	u32 hmackeyid;
 	char *secret;
 	int err =3D 0;
@@ -175,6 +176,10 @@ static int seg6_genl_sethmac(struct sk_buff *skb, st=
ruct genl_info *info)
 	if (slen > SEG6_HMAC_SECRET_LEN)
 		return -EINVAL;
=20
+	algo =3D __hmac_get_algo(algid);
+	if (!algo)
+		return -EINVAL;
+
 	mutex_lock(&sdata->lock);
 	hinfo =3D seg6_hmac_info_lookup(net, hmackeyid);
=20
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index f78ecb6ad838..1c4858195613 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -107,7 +107,7 @@ static struct sr6_tlv_hmac *seg6_get_tlv_hmac(struct =
ipv6_sr_hdr *srh)
 	return tlv;
 }
=20
-static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
+struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
 {
 	struct seg6_hmac_algo *algo;
 	int i, alg_count;
--=20
2.25.1


