Return-Path: <netdev+bounces-159204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E006A14C4E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC2B188B490
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536A1FA25C;
	Fri, 17 Jan 2025 09:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49B1F91F4;
	Fri, 17 Jan 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107180; cv=none; b=A/zNKDlOfQ7al2V8RlccdO1m0C4VKPyzOjwRIYdvUKNEpYAqy6Gz2p2O+uUCgXlrYOV2O/oEpAJ82dfWFxn1DMAawAE5zMllTUwM/Vfw5al+nZPcl4nVnTp7ETAt7SW1ZVCYE5dBVxYt9zHhln/KC8PLjaPOzPqfDR3U0RJlPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107180; c=relaxed/simple;
	bh=Y2R/gRux9tTa2vVhYhRCF98euH7ElbrCrtfFtV6DQ84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFEe/JMiLJ+ZAwFmnDrmYBO4v7rzFaOPmJ8NT0ztECIijXRndIvqsjsg8NsybSucbjxxcnI/MFmMQi0pwvwWhcXmNqlL+zXxdnozAeuNJHLz45KakqjsYnBYdd5zSV0xdAcJ0eeE8N4fUJYGf8umB9eBrPph7fkbNavwnyIB6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e17986d2d4b711efa216b1d71e6e1362-20250117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0477f391-dc0f-4b3f-ad6b-a3fc6d3f837e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:e7bcdace73a38cac33a251ba04c516bf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e17986d2d4b711efa216b1d71e6e1362-20250117
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxiangqian@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 556801855; Fri, 17 Jan 2025 17:46:09 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id ABAE516002081;
	Fri, 17 Jan 2025 17:46:09 +0800 (CST)
X-ns-mid: postfix-678A26E1-5384812483
Received: from localhost.localdomain (unknown [172.25.83.26])
	by node4.com.cn (NSMail) with ESMTPA id A735B16002081;
	Fri, 17 Jan 2025 09:46:07 +0000 (UTC)
From: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Subject: [PATCH v4] net: mii: Fix the Speed display when the network cable is not connected
Date: Fri, 17 Jan 2025 17:46:03 +0800
Message-Id: <20250117094603.4192594-1-zhangxiangqian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two different models of usb card, the drivers are r8152 and asix. If no
network cable is connected, Speed =3D 10Mb/s. This problem is repeated in
linux 3.10, 4.19, 5.4, 6.12. This problem also exists on the latest
kernel. Both drivers call mii_ethtool_get_link_ksettings,
but the value of cmd->base.speed in this
function can only be SPEED_1000 or SPEED_100 or SPEED_10.
When the network cable is not connected, set cmd->base.speed
=3DSPEED_UNKNOWN.

v2:
https://lore.kernel.org/20250111132242.3327654-1-zhangxiangqian@kylinos.c=
n

Signed-off-by: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
---
 drivers/net/mii.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 22680f47385d..37bc3131d31a 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -213,6 +213,9 @@ void mii_ethtool_get_link_ksettings(struct mii_if_inf=
o *mii,
 		lp_advertising =3D 0;
 	}
=20
+	if (!(bmsr & BMSR_LSTATUS))
+		cmd->base.speed =3D SPEED_UNKNOWN;
+
 	mii->full_duplex =3D cmd->base.duplex;
=20
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
--=20
2.25.1


