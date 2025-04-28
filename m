Return-Path: <netdev+bounces-186326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E9EA9E57C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 02:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2CA7A7CB7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244712AD0C;
	Mon, 28 Apr 2025 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="utGJtFf1"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A23232
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745800395; cv=none; b=hfhS4mUamVleIa6wSLGVZbnODBUaPu3Ka/L4oi7JLXmorpaSN5kd4eG/xME7v0dPXA5wVjDWjQV5CxdiQhsTWtSxiFzP65OJ6jFUbqHxIzJ8m7O5GLsZGMURKoS1EtTZClrC59J+7NaQZvOqzQ0CocIEtwwclA59bzteiuFAal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745800395; c=relaxed/simple;
	bh=KWlpZNyqBeUzgA6DRPgaYYjLPVFnqWdLvr6QQNXuNZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5/4PO7tkd4iiyPCimy7A7ot6q6LDKTgTQ5knLrOjtue3I9Rvo0V/b69/ITjo83aCGsppIeOsvVIx+yzJgArdIZ6DmYD0p6xMIrmXQcArEcaXO2gPajZGs6j0w2INJbHF0TGSiQQqwJOFrekAqmxj50QoGX7qzS9EwSinVZ4KlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=utGJtFf1; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2DDF92C0276;
	Mon, 28 Apr 2025 12:33:09 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1745800389;
	bh=o47hT6+3qTo3CkIy0WeqsTTIvKyfouf/pNOV0L8cppE=;
	h=From:To:Cc:Subject:Date:From;
	b=utGJtFf1gfE7NrsaoEJKTZuBmLgs45VfiXXIL+MC+AkuVG6YeXcT2j1ptdY12EHfC
	 l9ynjHp6XIq2MnvfCDbIOVBCEn+lovVNymWQ22NZB9jbg+VKgVYcBoefjTqWtQno7J
	 kM+rGs3O/DQcfM73QqwIaorMR1leq5c7wAI0kOCqEiBLvEA4CLiMTiIZGrWrK2X5bH
	 I4Ke2nCbib+waYvWZHqfWMyuHwTWL/N3SxJ6nlD7FQbgi1oQj3teXY06XhA36Q+6Im
	 JoCyZF1uiDrOXM6ieg/DtH6la27C0iQGg+KMDEyzacN1QgWg90Qicja+D0MOfhtNMq
	 QsVUPw147/k2g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B680eccc40000>; Mon, 28 Apr 2025 12:33:08 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 9BCDD13EDDC;
	Mon, 28 Apr 2025 12:33:08 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 96FB62A0B24; Mon, 28 Apr 2025 12:33:08 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hans-Frieder Vogt <hfdevel@gmx.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v0] net: phy: aquantia: fix commenting format
Date: Mon, 28 Apr 2025 12:32:48 +1200
Message-ID: <20250428003249.2333650-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=W+WbVgWk c=1 sm=1 tr=0 ts=680eccc4 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=4pPyy3GM_lJK_al_TTsA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Comment was erroneously added with /**, amend this to use /* as it is
not a kernel-doc.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504262247.1UBrDBVN-lkp@i=
ntel.com/
Fixes: 7e5b547cac7a ("net: phy: aquantia: poll status register")
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


