Return-Path: <netdev+bounces-213588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACC4B25BD6
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886615C4F07
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5C24E00F;
	Thu, 14 Aug 2025 06:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD024DFE6
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153198; cv=none; b=mhxKkPemvjaML5/s2J/ANQPL4ggywCSGVkpJtTuVkqGyPVzedbNujqjWP1SdtHsBTpD8yu8+zTXVBX81xtalz0WqGMehhdtCfMtwC777JrB/hYxnkPIDn3t1H4X8X1KytVKRBoJcwc6jLXLGNEOlOKVwq41RTahacDm+LjznhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153198; c=relaxed/simple;
	bh=W6uwyd6/PMbtteJTRZv4x7ii8cMYoDvuLniZfcqPkmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKrrOJwPTLK75UXHLgrnt+nmPwUoBoQackXl6hxaZ8V9pnkttI2mh0ozDBaMp1VUpKd4aj36mevdoHVSVt03fhU5W3Vkf+bEFvT7+KrDSoadNqzYJenfBvPlogosHKu18001mIHylDxBd35b6fpRK4L2QF51c/b7BzY8qEwy0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8ab2b63c78d811f0b29709d653e92f7d-20250814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bc2ca6bb-2064-4b67-9941-30a270da3272,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b0d66b71d2d5ac8ad07e0029767130c1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8ab2b63c78d811f0b29709d653e92f7d-20250814
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1948565323; Thu, 14 Aug 2025 14:33:08 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 08E4716004283;
	Thu, 14 Aug 2025 14:33:08 +0800 (CST)
X-ns-mid: postfix-689D8323-767312578
Received: from localhost.localdomain (unknown [10.42.12.141])
	by node4.com.cn (NSMail) with ESMTPA id 0D27D16001A01;
	Thu, 14 Aug 2025 06:33:06 +0000 (UTC)
From: heminhong <heminhong@kylinos.cn>
To: idosch@idosch.org
Cc: dsahern@kernel.org,
	edumazet@google.com,
	heminhong@kylinos.cn,
	kuba@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3] ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add
Date: Thu, 14 Aug 2025 14:33:02 +0800
Message-Id: <20250814063302.112132-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aJx9DPI8dbRUtfGA@shredder>
References: <aJx9DPI8dbRUtfGA@shredder>
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
To keep the HMAC algorithm logic in seg6_hmac.c and perform the check
in seg6_hmac_info_add().

Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structur=
e")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv6/seg6_hmac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index f78ecb6ad838..d77b52523b6a 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -304,6 +304,9 @@ int seg6_hmac_info_add(struct net *net, u32 key, stru=
ct seg6_hmac_info *hinfo)
 	struct seg6_pernet_data *sdata =3D seg6_pernet(net);
 	int err;
=20
+	if (!__hmac_get_algo(hinfo->alg_id))
+		return -EINVAL;
+
 	err =3D rhashtable_lookup_insert_fast(&sdata->hmac_infos, &hinfo->node,
 					    rht_params);
=20
--=20
2.25.1


