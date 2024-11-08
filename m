Return-Path: <netdev+bounces-143167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D809C14F7
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731EE1F245A5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577601CCEF2;
	Fri,  8 Nov 2024 03:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0vjejqCt"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A811C5799
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038155; cv=none; b=Iuvg+398Lx32r240uBW2+bAfjj+nwRQZl8GOKj3VqhbEBYycCNMXpMU5yi5uHTwfwvAkCYglieeSfGth1MWco0DRdnh/PFEjOPotpvy+XpYuUTBj59tSECVlHED8H0ZvxIerkFNY3D1khPux9qttIhAhnjciuiAqORuKZyKaRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038155; c=relaxed/simple;
	bh=eBgAq/qDGNP/dpK5Fb4HKu3Lz5EllCeHK+xKD73ije0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIvCuTFMeOqPmOdPyXuLx7sQ/dwS3DdDczrGpSiqcMG8/BiIvW/VgIwKLIKQMjYSA9rY9G2JG2X3fHYGEbrnxgHYmZ4W5mmgoznH9uU1hGBVzxSFcFxTECT2SGNr7D2KsUp9OY9p5xrlTloWYYi7wMoQnxJ+TlFWmWettlUE1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0vjejqCt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 529E22C05E0;
	Fri,  8 Nov 2024 16:55:51 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731038151;
	bh=ftrLcPlz9V3DRDChzBL87+QFEXscgHbCfuL/ZkuXTEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0vjejqCts9Kb2wrHXHXzVOYNsH9JxlHo2I2PIHwQk5CcroX9eWmi8GiEdGvpVUu/O
	 et5Cqjp7JijvUUNss56nRSHv4x38Qy28KvuGfL+JDu2VRHwAGFjig+OTm/8Dghv9MM
	 PwUbYn81de0N+V9kcAlEFFcVkK0mdTiJxwFDz4hdK8XnnGGlnET6LvIvWks+S/KU3+
	 DdPcRO7spaMxgmbnWccdc/H150CvoAyaXhRehtP0XpkmRc0iVp4ygYHPsm/7ZL1eyS
	 DYTBz056CCpgTlRwLdrTsKyY4cpzc1SFZxMAOL5iyBBk3DPBoNMDEaZt8jRprBOKFg
	 5dydrg1YE+h4Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672d8bc60001>; Fri, 08 Nov 2024 16:55:50 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id C97CD13ECD2;
	Fri,  8 Nov 2024 16:55:50 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id C7DD63C0263; Fri,  8 Nov 2024 16:55:50 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Subject: [RFC net-next (resend) 3/4] net: dsa: mv88e6xxx: handle member-violations
Date: Fri,  8 Nov 2024 16:55:45 +1300
Message-ID: <20241108035546.2055996-4-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672d8bc6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=8i6-b8GgAAAA:8 a=WYMWzFLixRnFLzZ6b-kA:9 a=3ZKOabzyN94A:10 a=XAGLwFu5sp1jj7jejlXE:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a handler for servicing member-violations to the mv88e6xxx switch
driver.

When we receive a member-violation from the hardware first check the
ATU for the corresponding entry and only service the interrupt if the
ATU entry has a non-zero DPV and the new port that raised the
interrupt is not in the DPV.

Servicing this interrupt will send a switchdev notification for the
new port.

Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 38 +++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/switchdev.c   | 33 ++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/switchdev.h   |  2 ++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv=
88e6xxx/global1_atu.c
index c47f068f56b3..5c5c53cb2ad0 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -399,12 +399,36 @@ int mv88e6xxx_g1_atu_remove(struct mv88e6xxx_chip *=
chip, u16 fid, int port,
 	return mv88e6xxx_g1_atu_move(chip, fid, from_port, to_port, all);
 }
=20
+static int mv88e6xxx_g1_atu_entry_check(struct mv88e6xxx_chip *chip, u16=
 fid, u8 mac[ETH_ALEN],
+					bool *in_atu, u16 *dpv)
+{
+	struct mv88e6xxx_atu_entry entry;
+	int err;
+
+	entry.state =3D 0;
+	ether_addr_copy(entry.mac, mac);
+	eth_addr_dec(entry.mac);
+
+	mv88e6xxx_reg_lock(chip);
+	err =3D mv88e6xxx_g1_atu_getnext(chip, fid, &entry);
+	mv88e6xxx_reg_unlock(chip);
+	if (err)
+		return err;
+
+	*in_atu =3D ether_addr_equal(entry.mac, mac);
+	if (dpv)
+		*dpv =3D entry.portvec;
+
+	return err;
+}
+
 static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *de=
v_id)
 {
 	struct mv88e6xxx_chip *chip =3D dev_id;
 	struct mv88e6xxx_atu_entry entry;
 	int err, spid;
 	u16 val, fid;
+	bool in_atu =3D false;
=20
 	mv88e6xxx_reg_lock(chip);
=20
@@ -437,6 +461,20 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_=
fn(int irq, void *dev_id)
 						     entry.portvec, entry.mac,
 						     fid);
 		chip->ports[spid].atu_member_violation++;
+
+		if (fid !=3D MV88E6XXX_FID_STANDALONE && chip->ports[spid].mab) {
+			u16 dpv =3D 0;
+
+			err =3D mv88e6xxx_g1_atu_entry_check(chip, fid, entry.mac, &in_atu, &=
dpv);
+			if (err)
+				goto out;
+
+			if (in_atu && dpv !=3D 0 && !(dpv & BIT(spid))) {
+				err =3D mv88e6xxx_handle_member_violation(chip, spid, &entry, fid);
+				if (err)
+					goto out;
+			}
+		}
 	}
=20
 	if (val & MV88E6XXX_G1_ATU_OP_MISS_VIOLATION) {
diff --git a/drivers/net/dsa/mv88e6xxx/switchdev.c b/drivers/net/dsa/mv88=
e6xxx/switchdev.c
index 4c346a884fb2..88761677ff10 100644
--- a/drivers/net/dsa/mv88e6xxx/switchdev.c
+++ b/drivers/net/dsa/mv88e6xxx/switchdev.c
@@ -79,5 +79,36 @@ int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_c=
hip *chip, int port,
 				       brport, &info.info, NULL);
 	rtnl_unlock();
=20
-	return err;
+	return notifier_to_errno(err);
+}
+
+int mv88e6xxx_handle_member_violation(struct mv88e6xxx_chip *chip, int p=
ort,
+				      struct mv88e6xxx_atu_entry *entry, u16 fid)
+{
+	struct switchdev_notifier_fdb_info info =3D {
+		.addr =3D entry->mac,
+	};
+	struct net_device *brport;
+	struct dsa_port *dp;
+	u16 vid;
+	int err;
+
+	err =3D mv88e6xxx_find_vid(chip, fid, &vid);
+	if (err)
+		return err;
+
+	info.vid =3D vid;
+	dp =3D dsa_to_port(chip->ds, port);
+
+	rtnl_lock();
+	brport =3D dsa_port_to_bridge_port(dp);
+	if (!brport) {
+		rtnl_unlock();
+		return -ENODEV;
+	}
+	err =3D call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
+				       brport, &info.info, NULL);
+	rtnl_unlock();
+
+	return notifier_to_errno(err);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/switchdev.h b/drivers/net/dsa/mv88=
e6xxx/switchdev.h
index 62214f9d62b0..f718dbfaf45d 100644
--- a/drivers/net/dsa/mv88e6xxx/switchdev.h
+++ b/drivers/net/dsa/mv88e6xxx/switchdev.h
@@ -15,5 +15,7 @@
 int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_chip *chip, int por=
t,
 				    struct mv88e6xxx_atu_entry *entry,
 				    u16 fid);
+int mv88e6xxx_handle_member_violation(struct mv88e6xxx_chip *chip, int p=
ort,
+				      struct mv88e6xxx_atu_entry *entry, u16 fid);
=20
 #endif /* _MV88E6XXX_SWITCHDEV_H_ */

