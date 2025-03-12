Return-Path: <netdev+bounces-174071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE3FA5D4B7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 04:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2553E160559
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023B191F77;
	Wed, 12 Mar 2025 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vtv1aZn9"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635115855E
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741749790; cv=none; b=TE+0vjBltD5AyXBqaQ2kiD5kyR18AYk6mU/LzZNMof9j3zHdPiiOpkIjxKpCEMOIti99ho9F/qPZl/U2rFbQpazJeLQ322rQMy2ZzlBCWUkdN/jisqnuygRNW9r98LJheCGyhDZDsrpgYkHzhg0kwrLR6MJ/+RGuKPjQyBRmr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741749790; c=relaxed/simple;
	bh=wnD0JAmJVHtgp4c7OQaP93fSmDAlMq8j8jAmSXYggiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/3OUSJmcd52WFtP9jeSbND95UNE34gu/4uWbEB0mSEh/C3YQ0uQaT7xsJICVriujF7ehOrl+POxcCORNH3D5LRAezZ1odCXZRDHeCugYGOGn+qy+PP5jPZ2u4w5Y6Ow0GF2MnbZ2RkIyExVbLNUx62LUacIUTb68clvmdhcMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=vtv1aZn9; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D99E02C03CA;
	Wed, 12 Mar 2025 16:22:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741749777;
	bh=QwG6z8grGkJxE/FiYYDWxMFV+VNB7Xv16WuuoJFtwgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=vtv1aZn9ZOsel/Vubz0sfTWvZxafC+7G9HPmI67GYY2z5PH4JpB/dJlL0zHVjH00k
	 gMj4vkNFB0hZoGZULudaOUPfEYRFc9Nqaawwl0wv2GvBQGJfwZ2CfefLdnCzMXY6ly
	 NlO8Krq8emDT70+yCHPf+6MBD8nbkYTN220APQdYXOcbJIfjYoOZF3HjJCIwyf8ETz
	 buu40FRXn3n3Bl9phUPZ4b33bGuuzKvFvkNpbIQQNt2Oh7QIOFPujbM+KeO+Qxgtm2
	 u9AHnejr4UfaF0Nr8gKj5B0WYM+gxuKkLrhAC1h0WnHRgndp/K3Xv1FQWQlN4s0VrL
	 jQonORjqnbzjw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d0fe110000>; Wed, 12 Mar 2025 16:22:57 +1300
Received: from hamishm-dl.ws.atlnz.lc (hamishm-dl.ws.atlnz.lc [10.33.24.10])
	by pat.atlnz.lc (Postfix) with ESMTP id AF99213EE4B;
	Wed, 12 Mar 2025 16:22:57 +1300 (NZDT)
Received: by hamishm-dl.ws.atlnz.lc (Postfix, from userid 1133)
	id AC305240364; Wed, 12 Mar 2025 16:22:57 +1300 (NZDT)
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH net] igb: Prevent IPCFGN write resetting autoneg advertisement register
Date: Wed, 12 Mar 2025 16:22:50 +1300
Message-ID: <20250312032251.2259794-1-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ccpxrWDM c=1 sm=1 tr=0 ts=67d0fe11 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Vs1iUdzkB0EA:10 a=j5V92D-ZtT2g-DOZFCwA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

An issue is observed on the i210 when autonegotiation advertisement is se=
t
to a specific subset of the supported speeds but the requested settings
are not correctly set in the Copper Auto-Negotiation Advertisement Regist=
er
(Page 0, Register 4).
Initially, the advertisement register is correctly set by the driver code
(in igb_phy_setup_autoneg()) but this register's contents are modified as=
 a
result of a later write to the IPCNFG register in igb_set_eee_i350(). It =
is
unclear what the mechanism is for the write of the IPCNFG register to lea=
d
to the change in the autoneg advertisement register.
The issue can be observed by, for example, restricting the advertised spe=
ed
to just 10MFull. The expected result would be that the link would come up
at 10MFull, but actually the phy ends up advertising a full suite of spee=
ds
and the link will come up at 100MFull.

The problem is avoided by ensuring that the write to the IPCNFG register
occurs before the write to the autoneg advertisement register.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 32 ++++++++++++-----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
index d368b753a467..f0c5ffa8450d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2382,6 +2382,23 @@ void igb_reset(struct igb_adapter *adapter)
 	    (adapter->flags & IGB_FLAG_MAS_ENABLE)) {
 		igb_enable_mas(adapter);
 	}
+
+	/* Re-establish EEE setting */
+	if (hw->phy.media_type =3D=3D e1000_media_type_copper) {
+		switch (mac->type) {
+		case e1000_i350:
+		case e1000_i210:
+		case e1000_i211:
+			igb_set_eee_i350(hw, true, true);
+			break;
+		case e1000_i354:
+			igb_set_eee_i354(hw, true, true);
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (hw->mac.ops.init_hw(hw))
 		dev_err(&pdev->dev, "Hardware Error\n");
=20
@@ -2412,21 +2429,6 @@ void igb_reset(struct igb_adapter *adapter)
 		}
 	}
 #endif
-	/* Re-establish EEE setting */
-	if (hw->phy.media_type =3D=3D e1000_media_type_copper) {
-		switch (mac->type) {
-		case e1000_i350:
-		case e1000_i210:
-		case e1000_i211:
-			igb_set_eee_i350(hw, true, true);
-			break;
-		case e1000_i354:
-			igb_set_eee_i354(hw, true, true);
-			break;
-		default:
-			break;
-		}
-	}
 	if (!netif_running(adapter->netdev))
 		igb_power_down_link(adapter);
=20
--=20
2.48.1


