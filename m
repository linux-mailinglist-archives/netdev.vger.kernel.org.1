Return-Path: <netdev+bounces-158488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E5A1226D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A73ACD3E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC811E991F;
	Wed, 15 Jan 2025 11:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C31E98F7;
	Wed, 15 Jan 2025 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940128; cv=none; b=q6S4+7CLbNMzklPdeEQ+r2FADH0SNgCQpOBC0XpZL21qE9qusq2dAuQf0x82naDpNfrSAf/3lu3qcxB3Lh2nMaTuBCQvRnyJk7bWQqzTqysywaeVa1UE3VElbbMBkBLwT4a3u78KXvHeYZlgki7CwY6n1QXnvyjeulNQibEcuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940128; c=relaxed/simple;
	bh=pwsX18usbktm25mgc4uzTaiIAHaEKB959Q8iZ85JH9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnitFWAuFcAgqOMEJi9uzvKOPSN4ql9Xcap3nruYScehyQ4kZ0zmBY7Bo9Cezm6e6nt9QPrB/1gffsch7OrVth533yGO0YzV1gXTYKuHedC0IXicXhTIp2PSthaI7ozluf7EbF3rQRfeNxVLtxL3vuRmNtlHenwi0t0yM0s0WVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f0719c1ed33211efa216b1d71e6e1362-20250115
X-CID-CACHE: Type:Local,Time:202501151918+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0db3acc2-2ed9-40fc-8862-c947832eab80,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:4d76710ffbe74445e2c240dbcc414b51,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: f0719c1ed33211efa216b1d71e6e1362-20250115
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxiangqian@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 127755485; Wed, 15 Jan 2025 19:22:00 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 83B5616002081;
	Wed, 15 Jan 2025 19:22:00 +0800 (CST)
X-ns-mid: postfix-67879A58-3921841750
Received: from localhost.localdomain (unknown [172.25.83.26])
	by node4.com.cn (NSMail) with ESMTPA id BD7F816002081;
	Wed, 15 Jan 2025 11:21:59 +0000 (UTC)
From: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Subject: [PATCH v3 RESEND] net: mii: Fix the Speed display when the network cable is not connected
Date: Wed, 15 Jan 2025 19:21:57 +0800
Message-Id: <20250115112157.3894984-1-zhangxiangqian@kylinos.cn>
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
linux 3.10, 4.19, and 5.4. Both drivers call
mii_ethtool_get_link_ksettings, but the value of cmd->base.speed in this
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


