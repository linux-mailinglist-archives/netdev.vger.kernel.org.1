Return-Path: <netdev+bounces-186570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45DA9FC8B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3FB1A85C92
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B251FDE12;
	Mon, 28 Apr 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zmHzXYAh"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDD14A62B
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876975; cv=none; b=VEfOPGc0YxSa37xT4pb8iMkX273EDXsudoqYedCjxQKwgsM2oF8PeThDQ8aZKBV6KgKoKdHMiOxhSjPKi/1TnfJfzCYlQrX8AS+uU+uHOSTGwraZcF8rjHMJ0sJkQsZFTz5rncpPzLTMJNMZSFJV+AGMQHYfvulAzg8y3/MpUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876975; c=relaxed/simple;
	bh=eWsY05CzJqSwBxdMxo6Ea+w8Ut1aDujAiJz0QkMp598=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mn8fgeLq6Wm1DQxIUyxtPtBkMw1h211Yya/lEsLD6opAT3T55LnDCLHkgCBb/5d57CRjHNlz2ChvaQSGGZGSDubIjjXvNZrvClnIr9USdqQkJIhUulY3lCBc8aC/43DcAqIyUlFu4unmjqLTuebtKCiLhMXmnF2e9SGNNANzWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=zmHzXYAh; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 15A162C01C1;
	Tue, 29 Apr 2025 09:49:23 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1745876963;
	bh=8qG8LlOJaxTPLFpH0dmSE8zwbVw+MRq9KB8xAQj+vjA=;
	h=From:To:Cc:Subject:Date:From;
	b=zmHzXYAh+d73sR0DeWK/s4IWM8xgHTXu9W7nwjxrtHflWwaSwu6YnaDY5rUnYLH98
	 aq/lKmAWxYqKaSBanK3K9IUoUsbxqE92WPc3/USDUJBlRa2XdXvcxNlrT+7VNNnXPv
	 giTiW4nZFLECq1DhaZMdbWVishZYub2z7rmDSRGs2oUV7yhXclE/ZxlQjOk40yexVz
	 DfLjmiy/peAdQ7BFKPuJD8j/P+McRil/pg1bjtLLeWPgTot6aHQF7VitdnX/SFj/NW
	 sBCNiE3vngjboJ6H8L7mxAyvmW+vOhmb+cTdSKRDyH/r1uqsZACxPMiDKm8gjlygci
	 w07L88ffwkiVA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B680ff7e20000>; Tue, 29 Apr 2025 09:49:22 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 9DF4713EDA9;
	Tue, 29 Apr 2025 09:49:22 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 9AAE72A0B24; Tue, 29 Apr 2025 09:49:22 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hans-Frieder Vogt <hfdevel@gmx.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v0] net: phy: aquantia: fix commenting format
Date: Tue, 29 Apr 2025 09:49:20 +1200
Message-ID: <20250428214920.813038-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=W+WbVgWk c=1 sm=1 tr=0 ts=680ff7e2 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=4pPyy3GM_lJK_al_TTsA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Comment was erroneously added with /**, amend this to use /* as it is
not a kernel-doc.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504262247.1UBrDBVN-lkp@i=
ntel.com/
Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/phy/aquantia/aquantia_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
index 08b1c9cc902b..77a48635d7bf 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -516,8 +516,7 @@ static int aqr105_read_status(struct phy_device *phyd=
ev)
 	if (!phydev->link || phydev->autoneg =3D=3D AUTONEG_DISABLE)
 		return 0;
=20
-	/**
-	 * The status register is not immediately correct on line side link up.
+	/* The status register is not immediately correct on line side link up.
 	 * Poll periodically until it reflects the correct ON state.
 	 * Only return fail for read error, timeout defaults to OFF state.
 	 */
@@ -634,8 +633,7 @@ static int aqr107_read_status(struct phy_device *phyd=
ev)
 	if (!phydev->link || phydev->autoneg =3D=3D AUTONEG_DISABLE)
 		return 0;
=20
-	/**
-	 * The status register is not immediately correct on line side link up.
+	/* The status register is not immediately correct on line side link up.
 	 * Poll periodically until it reflects the correct ON state.
 	 * Only return fail for read error, timeout defaults to OFF state.
 	 */
--=20
2.49.0


