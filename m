Return-Path: <netdev+bounces-157019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE89A08BDC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E757A42AE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6882A209F23;
	Fri, 10 Jan 2025 09:23:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7902594AE;
	Fri, 10 Jan 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500998; cv=none; b=WFurqdODlmoLsNvuAiVecr+OLbGyIlPuMoDMhpsL5t1F/ofi6u/nnN8B+ZYiukYsWk1kw3CvI83+kcwqmQwh9J9IE55A2TTy2IUE94w5iyIvX2YWthvIAGHrZef5kvWxfhapRH5qogXePgZBa8DxvFIzX3UIMEHUEsDaseaNiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500998; c=relaxed/simple;
	bh=fg4/d15PgKSg7hTMCEd07m6T1TMk05AdYUol2uX7yeI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XJdZgV6kwWcSQYxkbyuBalPrOEKq+2ZEOMjvfsuMigQ2uU1XnTFVBOjoR5cFpALYCJeSLo5ogqAfHXsAycQzsO7NWXvwAh7IkGz0xiH0hTNyaY6cDvnsD/6LVmEGgpBNjfp+hspAK9XrzHr9UgopsdmpiJyjb+xF6PWefui4Xl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7fdaa772cf3411efa216b1d71e6e1362-20250110
X-CID-CACHE: Type:Local,Time:202501101704+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0a8bc4ab-ebbd-485f-9cb8-a5da4300f7f3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:6dae1920d211dbf29c6931e5e6bca202,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7fdaa772cf3411efa216b1d71e6e1362-20250110
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxiangqian@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 988853032; Fri, 10 Jan 2025 17:23:06 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 020861600810A;
	Fri, 10 Jan 2025 17:23:06 +0800 (CST)
X-ns-mid: postfix-6780E6F9-7904211467
Received: from localhost.localdomain (unknown [172.25.83.26])
	by node4.com.cn (NSMail) with ESMTPA id 184291600810A;
	Fri, 10 Jan 2025 09:23:05 +0000 (UTC)
From: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Subject: [PATCH RESEND] net: mii: Fix the Speed display when the network cable is not connected
Date: Fri, 10 Jan 2025 17:23:02 +0800
Message-Id: <20250110092302.2717512-1-zhangxiangqian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Speed should be SPEED_UNKNOWN when the network cable is not connected

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


