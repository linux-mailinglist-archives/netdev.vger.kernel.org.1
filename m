Return-Path: <netdev+bounces-105089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D27890FA40
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D557A2824C8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CF812;
	Thu, 20 Jun 2024 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="cp2tc/uL"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6C803
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843320; cv=none; b=QTkWLSBeyRQ0MLPjELwYYYvT6uvhq2+vL6zPy8tIwIDlXD1XW41YynDu7GxwyozRJiY+ATxDNcQcdpebEOX1TMBsaTmlbhkMD2ZPxcAX16sVsdeVbYTOHzpvk09bTNu8H+D2AUer0KwjXYVw8R9f7l+p5lSfNl7meSTyro6hdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843320; c=relaxed/simple;
	bh=orcpOtdaVS8Lt/7nnK/nb+mz8CnEu5zIl3alpK03zTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmqIbWi4OstAhPxmg4hCkMg/p3j0Vuevrl402TtVOG4V1eSbgQDJxMCWLyCMe/r1/rBFPCrQN6047Ryt7n4tXYrX7sw34x+W76Ak59VXQ3qnFTv1UDtZtktT5kDRV1qnvxXiSp1LH9jvVLXrdhvZ/vjBKYE558kBuEfb2uEy974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=cp2tc/uL; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BD9F12C0240;
	Thu, 20 Jun 2024 12:28:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718843315;
	bh=Lp0DNFqLPHML0eGPT5nW0MrIY2TAE9vKBYzLLBAqySw=;
	h=From:To:Cc:Subject:Date:From;
	b=cp2tc/uLVhYDT+l1Kd9iDU6pIc016zYPed3iQ22252Y0LWI6b0gOQtRus7wteeKQU
	 KHtzfANv+av3xBY7/Uo2fmSchk3lSSga9nWDRSfZfK0Tn65zFgPE9zZCLcoOGZWwWA
	 O4XtXCBNQsG/mnu3B6EKg2QVX+yuHskDvnBtVSQQs2PrWSGVpdgf98MQ7DjKNevCR3
	 Ei7GrpZMWyVSRmEQDsoc1iUB1Cn5BSST+vwVhkz44S1MkMHcBIp4tUOw2/11vcTjrL
	 QkdyjJA65x5iMJ+R7xhp5MKzNC85nn7zk/Fckn2js7DOGuRRBxkIG7YXrMYAkIAZIW
	 bxLkPc/Uh2VWA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B667377b30000>; Thu, 20 Jun 2024 12:28:35 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 7FB0613ED63;
	Thu, 20 Jun 2024 12:28:35 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 7BBDD2A0FF5; Thu, 20 Jun 2024 12:28:35 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: dsa: mv88e6xxx: Add FID map cache
Date: Thu, 20 Jun 2024 12:28:26 +1200
Message-ID: <20240620002826.213013-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=667377b3 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=d04kM7kIrsN5wIaQCncA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a cached FID bitmap. This mitigates the need to walk all VTU entries
to find the next free FID.

Walk VTU once, then store read FID map into bitmap. Use and manipulate
this bitmap from now on, instead of re-reading HW for the FID map.

The repeatedly VTU walks are costly can result in taking ~40 mins if
~4000 vlans are added. Caching the FID map reduces this time to <2
mins.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 37 +++++++++++++++++++----------
 drivers/net/dsa/mv88e6xxx/chip.h    |  3 +++
 drivers/net/dsa/mv88e6xxx/devlink.c |  9 +------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx=
/chip.c
index e5bac87941f6..38426434707c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1726,14 +1726,6 @@ static void mv88e6xxx_port_fast_age(struct dsa_swi=
tch *ds, int port)
 			port, err);
 }
=20
-static int mv88e6xxx_vtu_setup(struct mv88e6xxx_chip *chip)
-{
-	if (!mv88e6xxx_max_vid(chip))
-		return 0;
-
-	return mv88e6xxx_g1_vtu_flush(chip);
-}
-
 static int mv88e6xxx_vtu_get(struct mv88e6xxx_chip *chip, u16 vid,
 			     struct mv88e6xxx_vtu_entry *entry)
 {
@@ -1813,16 +1805,25 @@ int mv88e6xxx_fid_map(struct mv88e6xxx_chip *chip=
, unsigned long *fid_bitmap)
 	return mv88e6xxx_vtu_walk(chip, mv88e6xxx_fid_map_vlan, fid_bitmap);
 }
=20
-static int mv88e6xxx_atu_new(struct mv88e6xxx_chip *chip, u16 *fid)
+static int mv88e6xxx_vtu_setup(struct mv88e6xxx_chip *chip)
 {
-	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
 	int err;
=20
-	err =3D mv88e6xxx_fid_map(chip, fid_bitmap);
+	if (!mv88e6xxx_max_vid(chip))
+		return 0;
+
+	err =3D mv88e6xxx_g1_vtu_flush(chip);
 	if (err)
 		return err;
=20
-	*fid =3D find_first_zero_bit(fid_bitmap, MV88E6XXX_N_FID);
+	return mv88e6xxx_fid_map(chip, chip->fid_bitmap);
+}
+
+static int mv88e6xxx_atu_new(struct mv88e6xxx_chip *chip, u16 *fid)
+{
+	int err;
+
+	*fid =3D find_first_zero_bit(chip->fid_bitmap, MV88E6XXX_N_FID);
 	if (unlikely(*fid >=3D mv88e6xxx_num_databases(chip)))
 		return -ENOSPC;
=20
@@ -2529,6 +2530,9 @@ static int mv88e6xxx_port_vlan_join(struct mv88e6xx=
x_chip *chip, int port,
 			 port, vid);
 	}
=20
+	/* Record FID used in SW FID map */
+	bitmap_set(chip->fid_bitmap, vlan.fid, 1);
+
 	return 0;
 }
=20
@@ -2636,7 +2640,14 @@ static int mv88e6xxx_port_vlan_leave(struct mv88e6=
xxx_chip *chip,
 			return err;
 	}
=20
-	return mv88e6xxx_g1_atu_remove(chip, vlan.fid, port, false);
+	err =3D mv88e6xxx_g1_atu_remove(chip, vlan.fid, port, false);
+	if (err)
+		return err;
+
+	/* Record FID freed in SW FID map */
+	bitmap_clear(chip->fid_bitmap, vlan.fid, 1);
+
+	return err;
 }
=20
 static int mv88e6xxx_port_vlan_del(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx=
/chip.h
index c54d305a1d83..37958a016a3f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -421,6 +421,9 @@ struct mv88e6xxx_chip {
=20
 	/* Bridge MST to SID mappings */
 	struct list_head msts;
+
+	/* FID map */
+	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
 };
=20
 struct mv88e6xxx_bus_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6=
xxx/devlink.c
index a08dab75e0c0..ef3643bc43db 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -374,7 +374,6 @@ static int mv88e6xxx_region_atu_snapshot(struct devli=
nk *dl,
 					 u8 **data)
 {
 	struct dsa_switch *ds =3D dsa_devlink_to_ds(dl);
-	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
 	struct mv88e6xxx_devlink_atu_entry *table;
 	struct mv88e6xxx_chip *chip =3D ds->priv;
 	int fid =3D -1, count, err;
@@ -392,14 +391,8 @@ static int mv88e6xxx_region_atu_snapshot(struct devl=
ink *dl,
=20
 	mv88e6xxx_reg_lock(chip);
=20
-	err =3D mv88e6xxx_fid_map(chip, fid_bitmap);
-	if (err) {
-		kfree(table);
-		goto out;
-	}
-
 	while (1) {
-		fid =3D find_next_bit(fid_bitmap, MV88E6XXX_N_FID, fid + 1);
+		fid =3D find_next_bit(chip->fid_bitmap, MV88E6XXX_N_FID, fid + 1);
 		if (fid =3D=3D MV88E6XXX_N_FID)
 			break;
=20
--=20
2.43.2


