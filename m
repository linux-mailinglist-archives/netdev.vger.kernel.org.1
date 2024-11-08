Return-Path: <netdev+bounces-143158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C59C1489
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BB11F223CE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200613BAD7;
	Fri,  8 Nov 2024 03:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hdtPcW/q"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B464369A
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036286; cv=none; b=K5/sHXChHMB2E/Bkf6sez2O4KWDJuFaGKfj+3m7/har3rWvkkpmsnCWfCa7ulBEQzXXfYXjF522tV6zendiuoxNuWRkfolTjo1cJbyd2G/m6Lnd26dU0tmLEYLJ28jYDC98QXhACbGypDCVOxKEzIvjo/aTmoXLOW9dY4TDSlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036286; c=relaxed/simple;
	bh=rrlpa2EfaD1v4W4s1kcW7rUHx6iyeY+PqPoCCEoIstg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvdW/T8QKtrS+uKBgmUo355efr9hEh93FuAC8kdyy/sk51ZJRc5w86GL04LeHhlmUHJklgPDfYt2oBMHgMoG/wtqgwDrHwY5oqyCcdPhWyNnLqSdncCKOaFWr6L71s2wSw+HUQm2aoCCnOiXL4q0dFLIIEk+/K4su5HIILQkD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=hdtPcW/q; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 87FC92C05E0;
	Fri,  8 Nov 2024 16:24:42 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731036282;
	bh=KUc7PnPF5kFIMD0pZLX6wkw6c4UzwDmWHga1YlzKITM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdtPcW/qBu9mAPnhrmIZMhZJII/sazdNV6mhzT/mgUxn+ojv4Uu+At76EdouSd7Di
	 R92NrD1+TYSedVZOUU4keAXxp2pHWzxb9d1k62iwoeCu1b2rOUT+2Ycj8YpRLQWRTm
	 jPp5U+hGHypXCBhVVSSAOgt+Y63y2p3G5XvoIqdtBHrLVlJl0nQnNGIiMJ1+DZmcON
	 3FULrgDVhR3NJ0laA+wEfHn2Lk2pJi7Kq/HbViHG7S3t3SAckr+Ryt+J/GzGh5mUZ4
	 69QGcNBUMZlrddhCSmdWUqa7k+zGiWQovUan4kG4t2mrTMM2zeoOUyYlx8paLCpSsP
	 FK5CrcZKIpdLA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672d847a0000>; Fri, 08 Nov 2024 16:24:42 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 609FF13ECD2;
	Fri,  8 Nov 2024 16:24:42 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 5EB253C0261; Fri,  8 Nov 2024 16:24:42 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 4/4] net: dsa: mv88e6xxx: cache fid-to-vid association
Date: Fri,  8 Nov 2024 16:24:21 +1300
Message-ID: <20241108032422.2011802-5-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672d847a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=cYZQHHvv430f9PQrUU0A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

When servicing ATU violations we need to walk the VTU to find the vlan
id for the ATU's FID which is inefficient.

Add a cache for this association and replace the VTU walk so we don't
have to do this costly operation all the time.

Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 drivers/net/dsa/mv88e6xxx/chip.h        |  2 ++
 drivers/net/dsa/mv88e6xxx/global1_vtu.c |  6 ++++-
 drivers/net/dsa/mv88e6xxx/switchdev.c   | 35 ++-----------------------
 3 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx=
/chip.h
index 48399ab5355a..91c3e4b304cf 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -445,6 +445,8 @@ struct mv88e6xxx_chip {
=20
 	/* FID map */
 	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
+
+	u16 vid_cache[MV88E6XXX_N_FID];
 };
=20
 struct mv88e6xxx_bus_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/global1_vtu.c b/drivers/net/dsa/mv=
88e6xxx/global1_vtu.c
index b524f27a2f0d..af1c40480303 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_vtu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_vtu.c
@@ -464,7 +464,11 @@ int mv88e6390_g1_vtu_loadpurge(struct mv88e6xxx_chip=
 *chip,
 	}
=20
 	/* Load/Purge VTU entry */
-	return mv88e6xxx_g1_vtu_op(chip, MV88E6XXX_G1_VTU_OP_VTU_LOAD_PURGE);
+	err =3D mv88e6xxx_g1_vtu_op(chip, MV88E6XXX_G1_VTU_OP_VTU_LOAD_PURGE);
+	if (err =3D=3D 0)
+		chip->vid_cache[entry->fid] =3D entry->valid ? entry->vid : 0;
+
+	return err;
 }
=20
 int mv88e6xxx_g1_vtu_flush(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/switchdev.c b/drivers/net/dsa/mv88=
e6xxx/switchdev.c
index 88761677ff10..e96daa2dcaf4 100644
--- a/drivers/net/dsa/mv88e6xxx/switchdev.c
+++ b/drivers/net/dsa/mv88e6xxx/switchdev.c
@@ -12,42 +12,11 @@
 #include "global1.h"
 #include "switchdev.h"
=20
-struct mv88e6xxx_fid_search_ctx {
-	u16 fid_search;
-	u16 vid_found;
-};
-
-static int __mv88e6xxx_find_vid(struct mv88e6xxx_chip *chip,
-				const struct mv88e6xxx_vtu_entry *entry,
-				void *priv)
-{
-	struct mv88e6xxx_fid_search_ctx *ctx =3D priv;
-
-	if (ctx->fid_search =3D=3D entry->fid) {
-		ctx->vid_found =3D entry->vid;
-		return 1;
-	}
-
-	return 0;
-}
-
 static int mv88e6xxx_find_vid(struct mv88e6xxx_chip *chip, u16 fid, u16 =
*vid)
 {
-	struct mv88e6xxx_fid_search_ctx ctx;
-	int err;
-
-	ctx.fid_search =3D fid;
-	mv88e6xxx_reg_lock(chip);
-	err =3D mv88e6xxx_vtu_walk(chip, __mv88e6xxx_find_vid, &ctx);
-	mv88e6xxx_reg_unlock(chip);
-	if (err < 0)
-		return err;
-	if (err =3D=3D 1)
-		*vid =3D ctx.vid_found;
-	else
-		return -ENOENT;
+	*vid =3D chip->vid_cache[fid];
=20
-	return 0;
+	return *vid ? 0 : -ENOENT;
 }
=20
 int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_chip *chip, int por=
t,

