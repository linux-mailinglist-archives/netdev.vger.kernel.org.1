Return-Path: <netdev+bounces-132560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AE9921BA
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAF82812DE
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B038A18A952;
	Sun,  6 Oct 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ZvQws+2e"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DE16F265
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250656; cv=none; b=CNZm0ZTURnrujAOGrzj2eDOMQ/PICO4f6Q0fGyBgHugZEdse5jZumCq0jSjruZ1YAw/2N9NCXo/dxUF2EVE2dX/1AT/AgvyosREvjLqPNN1U3+MZdrydLx04yuLdcAymL7UXvH3GLAMWauda4t02BimrEu8WqaQUQfdNOWjgRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250656; c=relaxed/simple;
	bh=0qwN1XM7CS45F63HiisYwDe8vkYUVAi8YwKzphSBnwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlIqfxgHe29FDrwiD6M9cyAAnRLxwMu4CUiM8hMLtnyOiNUtcKY1Md+xNlcTldWxkPJvTiYY+VNm8whk+HtKox908TtLyvoeRwBb/vCpTchjCp0zI9eiy+mYZWH8qD3CVAXGuYyg709RsSXc3krHrq34jMXON0R14j6ir5fWZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ZvQws+2e; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 68F7D2C0261;
	Mon,  7 Oct 2024 10:29:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728250151;
	bh=o4ZcGwHX5oHRd3GGFxis25uYjqBU5mU2i12SH92q6L4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZvQws+2ey6Xp+la3ZeFRGh4dlRw3KJfT0mSVZ+pFeuJ7jSKWXINABhbwVcceSE0SZ
	 OnE5bLaZlEGJW0zmmqP6MJA6UeCKBrpF6zMmKCeKHckzOa0WqzGYnIHMG6v4NAqTka
	 oTt9oPbUczMMmSKqo1q+6HdBRYMXpxhl6bVUFNDq8CHAXeZY8boZNxziV8NZ0pKGzc
	 s6JXYTo2DY1suMk/wPaWtOUH06Wc5qPX5nCUhQKRzRH7YACsjVmxFz5R3sladq6Syg
	 kLBOgcUxzXRQvxdZ27EHwWeQHKjTXJRwIzZZ4T3iIKnE6tbG+wD/nezXdJSrRnWwK8
	 YxXzisUNZE6Nw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670301270000>; Mon, 07 Oct 2024 10:29:11 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 3AF7513ED6B;
	Mon,  7 Oct 2024 10:29:11 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 353EF2A0C47; Mon,  7 Oct 2024 10:29:11 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: dsa: mv88e6xxx: Add FID map cache
Date: Mon,  7 Oct 2024 10:29:05 +1300
Message-ID: <20241006212905.3142976-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=67030127 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=ODV8NxhS8i4DOMLbpVEA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a cached FID bitmap. This mitigates the need to walk all VTU entries
to find the next free FID.

When flushing the VTU (during init), zero the FID bitmap. Use and
manipulate this bitmap from now on, instead of reading HW for the FID
map.

The repeated VTU walks are costly and can take ~40 mins if ~4000 vlans
are added. Caching the FID map reduces this time to <2 mins.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
Changes in v1:
- Moved initial HW walk to setup

Changes in v2:
- Removed inital HW walk
- Purge cached FID when VTU is flushed

 drivers/net/dsa/mv88e6xxx/chip.c        | 35 +++++--------------------
 drivers/net/dsa/mv88e6xxx/chip.h        |  5 ++--
 drivers/net/dsa/mv88e6xxx/devlink.c     |  9 +------
 drivers/net/dsa/mv88e6xxx/global1_vtu.c |  3 +++
 4 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx=
/chip.c
index ddc832e33f4b..f68233d24f32 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1930,36 +1930,9 @@ static int mv88e6xxx_vtu_loadpurge(struct mv88e6xx=
x_chip *chip,
 	return chip->info->ops->vtu_loadpurge(chip, entry);
 }
=20
-static int mv88e6xxx_fid_map_vlan(struct mv88e6xxx_chip *chip,
-				  const struct mv88e6xxx_vtu_entry *entry,
-				  void *_fid_bitmap)
-{
-	unsigned long *fid_bitmap =3D _fid_bitmap;
-
-	set_bit(entry->fid, fid_bitmap);
-	return 0;
-}
-
-int mv88e6xxx_fid_map(struct mv88e6xxx_chip *chip, unsigned long *fid_bi=
tmap)
-{
-	bitmap_zero(fid_bitmap, MV88E6XXX_N_FID);
-
-	/* Every FID has an associated VID, so walking the VTU
-	 * will discover the full set of FIDs in use.
-	 */
-	return mv88e6xxx_vtu_walk(chip, mv88e6xxx_fid_map_vlan, fid_bitmap);
-}
-
 static int mv88e6xxx_atu_new(struct mv88e6xxx_chip *chip, u16 *fid)
 {
-	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
-	int err;
-
-	err =3D mv88e6xxx_fid_map(chip, fid_bitmap);
-	if (err)
-		return err;
-
-	*fid =3D find_first_zero_bit(fid_bitmap, MV88E6XXX_N_FID);
+	*fid =3D find_first_zero_bit(chip->fid_bitmap, MV88E6XXX_N_FID);
 	if (unlikely(*fid >=3D mv88e6xxx_num_databases(chip)))
 		return -ENOSPC;
=20
@@ -2666,6 +2639,9 @@ static int mv88e6xxx_port_vlan_join(struct mv88e6xx=
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
@@ -2771,6 +2747,9 @@ static int mv88e6xxx_port_vlan_leave(struct mv88e6x=
xx_chip *chip,
 		err =3D mv88e6xxx_mst_put(chip, vlan.sid);
 		if (err)
 			return err;
+
+		/* Record FID freed in SW FID map */
+		bitmap_clear(chip->fid_bitmap, vlan.fid, 1);
 	}
=20
 	return mv88e6xxx_g1_atu_remove(chip, vlan.fid, port, false);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx=
/chip.h
index 8b07e7d83589..00aa59857b64 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -440,6 +440,9 @@ struct mv88e6xxx_chip {
=20
 	/* Bridge MST to SID mappings */
 	struct list_head msts;
+
+	/* FID map */
+	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
 };
=20
 struct mv88e6xxx_bus_ops {
@@ -843,6 +846,4 @@ int mv88e6xxx_vtu_walk(struct mv88e6xxx_chip *chip,
 				 void *priv),
 		       void *priv);
=20
-int mv88e6xxx_fid_map(struct mv88e6xxx_chip *chip, unsigned long *bitmap=
);
-
 #endif /* _MV88E6XXX_CHIP_H */
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
diff --git a/drivers/net/dsa/mv88e6xxx/global1_vtu.c b/drivers/net/dsa/mv=
88e6xxx/global1_vtu.c
index bcfb4a812055..b524f27a2f0d 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_vtu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_vtu.c
@@ -471,6 +471,9 @@ int mv88e6xxx_g1_vtu_flush(struct mv88e6xxx_chip *chi=
p)
 {
 	int err;
=20
+	/* As part of the VTU flush, refresh FID map */
+	bitmap_zero(chip->fid_bitmap, MV88E6XXX_N_FID);
+
 	err =3D mv88e6xxx_g1_vtu_op_wait(chip);
 	if (err)
 		return err;
--=20
2.46.0


