Return-Path: <netdev+bounces-102149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3277901A1F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F0AB20C5F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED54B65E;
	Mon, 10 Jun 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="oLIeIxCB"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5AB645
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717996070; cv=none; b=d9R3+T9bTYe4ErYHhyW3mafUXuTu4Aj/F06HIuRWh9mvuOHl/isOf3+6gZxT3pDfdGSoi0jXH7NV9s99DanELvFlFCv05trpzPrNrvtodDStDq73LtmbcwJlH1yRwr5Ci5nCLDTJpWCkuTwzQZLl8n7DEUZ3eJIQedqyQQifkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717996070; c=relaxed/simple;
	bh=+lCXsNSPdHORdkSn7RwEEwtPCP8V/j8aKbfQGRFmWQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piyXxEokgiiiLtlxATCB5pTUR7UHCdsQBeftonuNT2a8CSN8Ogb1lNyy7O8pW+KXNtW9zLJgoPSSH1AF9qABCOiHoNPQAVn8EEqQewSoSv5+hNhAuLdGQplnjn3//9ZU5TQqw9brW9zNM0+0PhO13YdPRoygi7+gZpyn/O0CO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=oLIeIxCB; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C54442C04C9;
	Mon, 10 Jun 2024 17:07:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717996064;
	bh=GCjCcG0qd1PndBkV0c2OpqdW3auENo4im4S6llh54d8=;
	h=From:To:Cc:Subject:Date:From;
	b=oLIeIxCBbpoXawfZcUvMy1mQnA74uGu0o7uB0mBPw0cWfjIfWqYXdphuxSJzYwcEG
	 SFs5pwVoM/qOQ4+SYbWD0xaVU4gE8e/g0+rp4kb2sZKdnctshDobnqyudAyTQCJ6QP
	 MNDpUkIqF/hnbbPjZk9YSWi4rZ60ZapVoDrCiUBg/gEHjwgVGkGlBkHu/GRbLw2SA0
	 fMeYLawaaxBUsO0u85yZvr98PCaI41L438PZE30bEIdJ5z0ZSZdQq0TTuoGsgmdViY
	 p62wqKIxNMzKwwfM//6e9mYxRRpivfB5vEmIlsTUSoyGNxbRLlyKuxYyHMIx/6DHVF
	 Wy9z7VktPFyRg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66668a200000>; Mon, 10 Jun 2024 17:07:44 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 8E7BF13EE2B;
	Mon, 10 Jun 2024 17:07:44 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 87BF22A2270; Mon, 10 Jun 2024 17:07:44 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v0] net: dsa: mv88e6xxx: Add FID map cache
Date: Mon, 10 Jun 2024 17:07:23 +1200
Message-ID: <20240610050724.2439780-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=66668a20 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=vjRDvl-ZFQDR-u-TRfYA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a cached FID bitmap. This mitigates the need to
walk all VTU entries to find the next free FID.

Walk VTU once, then store read FID map into bitmap. Use
and manipulate this bitmap from now on, instead of re-reading
HW for the FID map.

The repeatedly VTU walks are costly can result in taking ~40 mins
if ~4000 vlans are added. Caching the FID map reduces this time
to <2 mins.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 25 +++++++++++++++++++------
 drivers/net/dsa/mv88e6xxx/chip.h |  4 ++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx=
/chip.c
index e5bac87941f6..91816e3e35ed 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1815,14 +1815,17 @@ int mv88e6xxx_fid_map(struct mv88e6xxx_chip *chip=
, unsigned long *fid_bitmap)
=20
 static int mv88e6xxx_atu_new(struct mv88e6xxx_chip *chip, u16 *fid)
 {
-	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
 	int err;
=20
-	err =3D mv88e6xxx_fid_map(chip, fid_bitmap);
-	if (err)
-		return err;
+	if (!chip->fid_populated) {
+		err =3D mv88e6xxx_fid_map(chip, chip->fid_bitmap);
+		if (err)
+			return err;
=20
-	*fid =3D find_first_zero_bit(fid_bitmap, MV88E6XXX_N_FID);
+		chip->fid_populated =3D true;
+	}
+
+	*fid =3D find_first_zero_bit(chip->fid_bitmap, MV88E6XXX_N_FID);
 	if (unlikely(*fid >=3D mv88e6xxx_num_databases(chip)))
 		return -ENOSPC;
=20
@@ -2529,6 +2532,9 @@ static int mv88e6xxx_port_vlan_join(struct mv88e6xx=
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
@@ -2636,7 +2642,14 @@ static int mv88e6xxx_port_vlan_leave(struct mv88e6=
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
index c54d305a1d83..2abe6f09c8df 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -421,6 +421,10 @@ struct mv88e6xxx_chip {
=20
 	/* Bridge MST to SID mappings */
 	struct list_head msts;
+
+	/* FID map */
+	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
+	bool fid_populated;
 };
=20
 struct mv88e6xxx_bus_ops {
--=20
2.43.2


