Return-Path: <netdev+bounces-158487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C84CA12253
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F82188EF72
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61C1E7C38;
	Wed, 15 Jan 2025 11:18:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37699248BAF;
	Wed, 15 Jan 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939904; cv=none; b=FloLWf4DVlqtQNWAYxRStOrPAxqvdmatrF/ebSUCYJD4O5xGmM1uiR33ayAFLJAOF9Ilq2ounlOYH1oeoDeUnXaZD5ha555r56GEpeJYSG4ICHPXuBVblLSZUlBOAnwAD3AI9BxbOivpC70l5qcrkGcrYbemNMZVm6y5Thh02T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939904; c=relaxed/simple;
	bh=pwsX18usbktm25mgc4uzTaiIAHaEKB959Q8iZ85JH9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVDtC+QFf9TaShbawsZGoAQXUJPLNe6x9VvK5INJ0/o5bAyuErennGjuQNvbgxWkmqA8yxZfI51rM0UKOEmqghKG3g8Q13/B4DTPmCkoXdBPyYm9ZREbZFh6FSny7hKzxXgLVPueO24lXLfUWfvUF4Oi26N0KqSsjQKpIxm9fVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 66ce4facd33211efa216b1d71e6e1362-20250115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0b01e704-e624-4ff4-adf1-1a736c75150b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:4d76710ffbe74445e2c240dbcc414b51,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 66ce4facd33211efa216b1d71e6e1362-20250115
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxiangqian@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1977798110; Wed, 15 Jan 2025 19:18:09 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id A142316002081;
	Wed, 15 Jan 2025 19:18:09 +0800 (CST)
X-ns-mid: postfix-67879971-5119731743
Received: from localhost.localdomain (unknown [172.25.83.26])
	by node4.com.cn (NSMail) with ESMTPA id DBE5B16002081;
	Wed, 15 Jan 2025 11:18:07 +0000 (UTC)
From: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Subject: [PATCH] net: mii: Fix the Speed display when the network cable is not connected
Date: Wed, 15 Jan 2025 19:18:05 +0800
Message-Id: <20250115111805.3894377-1-zhangxiangqian@kylinos.cn>
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


