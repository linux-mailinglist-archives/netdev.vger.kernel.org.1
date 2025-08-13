Return-Path: <netdev+bounces-213209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C2B24211
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA917685E60
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7692BF3DB;
	Wed, 13 Aug 2025 06:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F82BD5B0
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068285; cv=none; b=F1f/PB11I23pExm4AtEQMpk2MeypDBL2QblxEN+5nqrVoO50cU1cy8KToI5DYIM2TZSqozIQotW3FQqFQ/+zPx30LQDsGybXOtShYr9cUHUFqek9hyQm7UIqALYavmcI1i04Rw878KQt5PYj6klqZEbksnPHNSb+K8ltzSMt26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068285; c=relaxed/simple;
	bh=DkDUyOiz/kR6bvCZ8Tw/n0SfB0ejb3TJoT1M6KhSoFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGAFmxrRAffEGcRuFk9BQzCUp4jMRyEMJYONqTYwk3PQD+JWHXt1+dloW7SRdWHYjB25G66QILCxBmUaoZ2SNbD1UFN0DAVN45mvkbSNB99LlP4QxRqxRW7ICT2fAR3Su9yKo9xokIMs/MbMGt4BfSKjts6bd4irpNKNa6gvX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d6a5980a781211f0b29709d653e92f7d-20250813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:42e02b1a-083a-491c-a7d5-097caaa4b6f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:d48c7b0e18dfc62dba8ed0aceedafaf9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6a5980a781211f0b29709d653e92f7d-20250813
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1842470353; Wed, 13 Aug 2025 14:57:55 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 3B687160038C0;
	Wed, 13 Aug 2025 14:57:55 +0800 (CST)
X-ns-mid: postfix-689C3771-863832887
Received: from localhost.localdomain (unknown [10.42.12.141])
	by node4.com.cn (NSMail) with ESMTPA id 3C0B216001A03;
	Wed, 13 Aug 2025 06:57:52 +0000 (UTC)
From: heminhong <heminhong@kylinos.cn>
To: idosch@idosch.org
Cc: dsahern@kernel.org,
	edumazet@google.com,
	heminhong@kylinos.cn,
	kuba@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2] ipv6: sr: validate HMAC algorithm ID in seg6_genl_sethmac
Date: Wed, 13 Aug 2025 14:57:37 +0800
Message-Id: <20250813065737.112274-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aJtHOuAc3BM3Aa9l@shredder>
References: <aJtHOuAc3BM3Aa9l@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Minhong He <heminhong@kylinos.cn>

The seg6_genl_sethmac() directly uses the algorithm ID provided by the
userspace without verifying whether it is an HMAC algorithm supported
by the system.
If an unsupported HMAC algorithm ID is configured, packets using SRv6 HMA=
C
will be dropped during encapsulation or decapsulation.

Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structur=
e")

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


