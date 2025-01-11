Return-Path: <netdev+bounces-157409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4E5A0A3E1
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A21E1647D4
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A381F16B;
	Sat, 11 Jan 2025 13:23:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67BBE46;
	Sat, 11 Jan 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601799; cv=none; b=N4XpTUmJncWsZI9L3XQ9Dm5SPvxt7PBsgUjsLkPVqphNfGIzl/sqq6AsbR+bebAArzOSUsgvUwd7m+dqj9yAetKw3IXcw6vRJ9+EJSuUodzTXLiWDQi66nAuHCWInFCo9b/7KJ+DR6Tj33CialR/4VhRtNJeYmz4zlqw7gf7TWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601799; c=relaxed/simple;
	bh=e3sBP68SGjh/CoP3Zx8DOvkfCjX6IshjN2naL5L0wfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TR3uVyspCI6WbWkIUzzmTRN1moAT8V/JvN7KQxoz9NJ96fD0nC3mOwCUY78VbJflvU5okZ0i6Yx849wLeSmr18U94xei5o8hzmNs0UKywleaAqmFoP5v5wNwKnkDxmMstJMkxFJh1P5D8FzAIst2Ruoi1OAPaIkeHlsjUp5NXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d9316e8d01f11efa216b1d71e6e1362-20250111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a3658b62-616e-492c-8e61-ced4f545029d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:20baf57f6e81f45cf163fd765baf0b70,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d9316e8d01f11efa216b1d71e6e1362-20250111
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxiangqian@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1145010215; Sat, 11 Jan 2025 21:22:59 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id ABD7016001CC7;
	Sat, 11 Jan 2025 21:22:59 +0800 (CST)
X-ns-mid: postfix-678270B3-4907711
Received: from localhost.localdomain (unknown [172.25.83.26])
	by node4.com.cn (NSMail) with ESMTPA id 4CF3516001CC7;
	Sat, 11 Jan 2025 13:22:57 +0000 (UTC)
From: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zhangxiangqian@kylinos.cn
Subject: [PATCH v2] net: mii: Fix the Speed display when the network cable is not connected
Date: Sat, 11 Jan 2025 21:22:42 +0800
Message-Id: <20250111132242.3327654-1-zhangxiangqian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b80d02e7-3eae-4485-bf54-84720dbb6a5d@lunn.ch>
References: <b80d02e7-3eae-4485-bf54-84720dbb6a5d@lunn.ch>
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

Signed-off-by: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
---
 drivers/net/mii.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 22680f47385d..297a0cc3682f 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -213,6 +213,9 @@ void mii_ethtool_get_link_ksettings(struct mii_if_inf=
o *mii,
 		lp_advertising =3D 0;
 	}
=20
+	if (!mii_link_ok(mii))
+		cmd->base.speed =3D SPEED_UNKNOWN;
+
 	mii->full_duplex =3D cmd->base.duplex;
=20
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
--=20
2.25.1


