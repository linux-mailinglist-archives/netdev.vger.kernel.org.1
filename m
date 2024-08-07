Return-Path: <netdev+bounces-116589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67E94B19C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A42835BC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B78145FFA;
	Wed,  7 Aug 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b="GD9nAnNn"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C5145B39
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063839; cv=none; b=IvOIO7GhrCXAmPAcqPWHbmePoWOEZobejAvl4ChEzTQav8n3GSDReCLIiY576jk2DhVbSo4Jv5BGCP3jkWwFNq/wqoWN4mVUgqQVpdGbTO0KNOasA691J6mVvwitUpb9BJrAwbAsxtS7pkxZwEimVXOrdKuHtM43P3H96NuJhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063839; c=relaxed/simple;
	bh=f+v4f3mK6kHMcO8CYtGze601q5qgBWUYTCFJnozwiEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vr06WzDYremcA75vjRjGs+GzDTgkTsmHcOuHyRpfK4TwvLNPsj6yJ83BIdxQYAMTX5Zc3ZEmOZhJ6spmq04Ckh4/l5AuAvm+cGLcQOeTeoBtFL3O5ucbvfuhVErebalsXmACyQerKC/HS3NzuDphdQDZTaqHcnN+rfTVQ7gY9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk; spf=pass smtp.mailfrom=martin-whitaker.me.uk; dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b=GD9nAnNn; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin-whitaker.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=martin-whitaker.me.uk; s=s1-ionos; t=1723063819; x=1723668619;
	i=foss@martin-whitaker.me.uk;
	bh=TzO/kkw4/fm/ZdXC5cXInzKhtvW3MnTisW67XRRFAFk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GD9nAnNn4GuOAXVlrsJAWFrEJXDWUXYAupyp1DCCPsFYEGKPK3OT1XCM9d7oUp82
	 cLlhGE+CqkxFbfWgxvwO+bkz/irkG/hsyjBsw8aNMs6qW+pTY5bjsqr8LvbMBxlRr
	 48CVSBEIAV+5s/Tb4Qps8YmE0GO+04opIZ3u2dVlJPQTdBhYp6tCYoI2H8Pkj+V5x
	 IuwM8IZlEQd61a5obGjHIpX69bAABtzinAQgTq+O8go4UmyByr7RUym8OhG3LU3vY
	 0BDg5JFoqesiSw+XF6Wz0ghReF0wdhzNANwLfWX+x4tVetBUHtBjABMH4a5Vf81E4
	 wDwlhtmZA0mkZmdSSg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from thor.lan ([194.120.133.17]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1M8QFi-1sXNlb2Zhg-000ULR; Wed, 07 Aug 2024 22:50:19 +0200
From: Martin Whitaker <foss@martin-whitaker.me.uk>
To: netdev@vger.kernel.org
Cc: UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com,
	o.rempel@pengutronix.de,
	lukma@denx.de,
	Arun.Ramadoss@microchip.com,
	kuba@kernel.org,
	Martin Whitaker <foss@martin-whitaker.me.uk>
Subject: [PATCH net] net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9896/KSZ9897.
Date: Wed,  7 Aug 2024 21:52:09 +0100
Message-ID: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xFeTaqKwZo3anhq6ZWylFt0u5I2Ccsw6ewugUom/ftLa4CjvGKa
 uO0QvTFNpq53mISlaXQB1Un+S3d87mIjSzwIDUByTI22XBNhIVdGfMjADz3ualswmPDOS3V
 JuZx3ZfKWXuIwzbRzUqV3S7VIhoJOD6katNgNalR91Xe7R03ViPy+tffZJrublTjjmTFYFN
 62g0+chfReHqBrOsxSvrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tQOhKtcQszI=;ufTgSl9lGkE0zDFawkfPW7pkceI
 DcQ26zsNkIe3Gy3I/oqsInll/XjAwtWv0IjmnJiPL3OXbT4e9JO/YQwejc2A8LJbn9ndWf0ny
 pmbUU5CeYxyYkxrEsHKs8yYXaA4xgNnEiQFit/YCruxHv5Zwt90hX4R4+TQn4x/63RIJnHcbN
 C74deFRP0jVePWzZI3Yf7JlVoy7iEY9ckM4doImA/X9mHKSrO6eR1WzR64dy/FlxydJLFSIH2
 +B5MoQIfR28pfECw7Q4D3/JMVTP0Gf8aupfrd1Ibf/F1OBxR7+OBJGlhUZrwdkV9iJlP7SOHC
 KFu5UvCs3ndgn8ey0NJC2AIc3npnzVvHhJySyTq/tWGe0Vkia+QyTyB+9dZY5ReWYnAukGO4X
 ZbhA9bgjZk98hkGQDajCVS/8pWtql15AaqK6w8aRdJXQOpmOJPIlTuBH/IJ9+/hBiQ/Nt/50R
 OGrtAdTSBwOyHCtOFYgZW+x7oqigQbrqFYmyt5qDd22kTPaLhcT/TyRmeHecvmFzrGXZMHlgx
 ibRj/iI5DVAKxlWKP1PkRoTevbjytoJldXP1CpiHKOwrDdkofzQEw9iYgDuR1Rd3oDSKCQiQB
 okeGZkEB7hS5sXBcg26zR96y8aGhhQHYj/p6YFvLIO3pxO1r26BK11dXRGGEGGGVzLyrLL9Wu
 rP0MccFivw7ZUTTWSX4wIuY14z9XU/6egbe3wEB8jvj2Sdx9spbsKrxU+uVfMD7OJFZE51PgV
 gSu1k+9hfXpnRrxajEGT15Leqo+/39o6tPR+Trk8HHfjL5Q/U++JlQ=

As noted in the device errata [1-8], EEE support is not fully operational
in the KSZ8567, KSZ9477, KSZ9567, KSZ9896, and KSZ9897 devices, causing
link drops when connected to another device that supports EEE. The patch
series "net: add EEE support for KSZ9477 switch family" merged in commit
9b0bf4f77162 caused EEE support to be enabled in these devices. A fix for
this regression for the KSZ9477 alone was merged in commit 08c6d8bae48c2.
This patch extends this fix to the other affected devices.

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ8567R-Errata-DS80000752.pdf
[2] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ8567S-Errata-DS80000753.pdf
[3] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ9477S-Errata-DS80000754.pdf
[4] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ9567R-Errata-DS80000755.pdf
[5] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ9567S-Errata-DS80000756.pdf
[6] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ9896C-Errata-DS80000757.pdf
[7] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ9897R-Errata-DS80000758.pdf
[8] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Product=
Documents/Errata/KSZ9897S-Errata-DS80000759.pdf

Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") # for KSZ8=
567/KSZ9567/KSZ9896/KSZ9897
Link: https://lore.kernel.org/netdev/137ce1ee-0b68-4c96-a717-c8164b514eec@=
martin-whitaker.me.uk/
Signed-off-by: Martin Whitaker <foss@martin-whitaker.me.uk>
=2D--
 drivers/net/dsa/microchip/ksz_common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/micr=
ochip/ksz_common.c
index b074b4bb0629..cebc6eaa932b 100644
=2D-- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2578,7 +2578,11 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds,=
 int port)
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
 		break;
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
+	case KSZ9567_CHIP_ID:
+	case KSZ9896_CHIP_ID:
+	case KSZ9897_CHIP_ID:
 		/* KSZ9477 Errata DS80000754C
 		 *
 		 * Module 4: Energy Efficient Ethernet (EEE) feature select must
@@ -2588,6 +2592,13 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds,=
 int port)
 		 *   controls. If not disabled, the PHY ports can auto-negotiate
 		 *   to enable EEE, and this feature can cause link drops when
 		 *   linked to another device supporting EEE.
+		 *
+		 * The same item appears in the errata for the KSZ9567, KSZ9896,
+		 * and KSZ9897.
+		 *
+		 * A similar item appears in the errata for the KSZ8567, but
+		 * provides an alternative workaround. For now, use the simple
+		 * workaround of disabling the EEE feature for this device too.
 		 */
 		return MICREL_NO_EEE;
 	}
=2D-
2.41.1

