Return-Path: <netdev+bounces-61881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C2825262
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671481C231DD
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1624B5F;
	Fri,  5 Jan 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="Bo/BxEMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2D28DDD
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helmholz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fL1ghI7iUYwGQh9orX52saHzGZphxKonKtUrxZw/k6Y=; b=Bo/BxEMvSGO+qiUyt8sqQ9Vl8e
	ZgRYAmx/up1Zm/KSyPAIop/1c05EAVFkyPKVxvsjQ27SDz/NKG3MvnpJ0YdjYZuLg3Nf2cEqMjsYb
	UppfvVzhsGAmrF7eWpU0StRa/KED7RvF1V7eX7uLhIUC7qNCHPh1VuLu+ncAoC+CJTFZW6eSXJg5X
	TYXXtUJaMtHSedpoNGKj5/jvtxPDVLJ5m0DCe7hx9+xh9MYo9c1v9nfqSRq9peE+ikEJhgm5a6Aob
	pW89E102z7lq+wOBD0ku2GS7yaT5YbW1KhAhi3ODUEoVEO/5E28DPPL3ywuPiTpdJ0GyQHEqGEzX+
	cOSIIjfw==;
Received: from [192.168.1.4] (port=44819 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rLhic-0000fk-28;
	Fri, 05 Jan 2024 11:46:26 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 5 Jan 2024 11:46:26 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ante.knezic@helmholz.de>
Subject: [RFC PATCH net-next 6/6] net: dsa: mv88e6xxx add cross-chip mirroring
Date: Fri, 5 Jan 2024 11:46:19 +0100
Message-ID: <cacf47599957ac92edddfa372bac5ac9890e4e85.1704449760.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1704449760.git.ante.knezic@helmholz.de>
References: <cover.1704449760.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

modify mv88e6xxx port mirroring to support cross-chip mirroring.
Remove mirror_ingress and mirror_egress as they are no longer
needed.
Do not allow setting dsa ports as mirror source port as
recommended by the Switch Functional Specification.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 77 +++++++++++++++++++++++++---------------
 drivers/net/dsa/mv88e6xxx/chip.h |  2 --
 drivers/net/dsa/mv88e6xxx/port.c |  5 ---
 3 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ce3a5d61edb4..fab92c3cb511 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3568,6 +3568,28 @@ static int mv88e6xxx_stats_setup(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_stats_clear(chip);
 }
 
+static int mv88e6xxx_mirror_setup(struct mv88e6xxx_chip *chip)
+{
+	int err, port, i;
+	const enum mv88e6xxx_egress_direction direction[] = {
+		MV88E6XXX_EGRESS_DIR_INGRESS, MV88E6XXX_EGRESS_DIR_EGRESS};
+
+	for (i = 0; i < ARRAY_SIZE(direction); i++) {
+		err = mv88e6xxx_set_egress_port(chip, i,
+						MV88E6XXX_EGRESS_DEST_DISABLE);
+		if (err)
+			return err;
+
+		for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+			err = mv88e6xxx_port_set_mirror(chip, port, i, false);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 /* Check if the errata has already been applied. */
 static bool mv88e6390_setup_errata_applied(struct mv88e6xxx_chip *chip)
 {
@@ -3966,6 +3988,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
+	err = mv88e6xxx_mirror_setup(chip);
+	if (err)
+		goto unlock;
+
 unlock:
 	mv88e6xxx_reg_unlock(chip);
 
@@ -6488,31 +6514,26 @@ static int mv88e6xxx_port_mirror_add(struct dsa_switch *ds, int from_port,
 						MV88E6XXX_EGRESS_DIR_INGRESS :
 						MV88E6XXX_EGRESS_DIR_EGRESS;
 	struct mv88e6xxx_chip *chip = ds->priv;
-	bool other_mirrors = false;
-	int i;
+	int *dest_port;
 	int err;
 
 	mutex_lock(&chip->reg_lock);
-	if ((ingress ? chip->ingress_dest_port : chip->egress_dest_port) !=
-	    to_port) {
-		for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
-			other_mirrors |= ingress ?
-					 chip->ports[i].mirror_ingress :
-					 chip->ports[i].mirror_egress;
-
-		/* Can't change egress port when other mirror is active */
-		if (other_mirrors) {
-			err = -EBUSY;
-			goto out;
-		}
+	dest_port = ingress ? &chip->ingress_dest_port : &chip->egress_dest_port;
 
-		err = mv88e6xxx_set_egress_port(chip, direction,
-						to_port);
-		if (err)
-			goto out;
+	/* Can't change egress port when mirroring is active */
+	if (*dest_port != MV88E6XXX_EGRESS_DEST_DISABLE &&
+	    *dest_port != to_port) {
+		err = -EBUSY;
+		goto out;
 	}
 
-	err = mv88e6xxx_port_set_mirror(chip, from_port, direction, true);
+	err = mv88e6xxx_set_egress_port(chip, direction, to_port);
+	if (err)
+		goto out;
+
+	if (dsa_port_is_user(dsa_to_port(ds, from_port)))
+		err = mv88e6xxx_port_set_mirror(chip, from_port, direction, true);
+
 out:
 	mutex_unlock(&chip->reg_lock);
 
@@ -6527,20 +6548,18 @@ static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int from_port,
 						MV88E6XXX_EGRESS_DIR_INGRESS :
 						MV88E6XXX_EGRESS_DIR_EGRESS;
 	struct mv88e6xxx_chip *chip = ds->priv;
-	bool other_mirrors = false;
-	int i;
+	int *dest_port;
 
 	mutex_lock(&chip->reg_lock);
-	if (mv88e6xxx_port_set_mirror(chip, from_port, direction, false))
-		dev_err(ds->dev, "p%d: failed to disable mirroring\n", from_port);
+	dest_port = ingress ? &chip->ingress_dest_port : &chip->egress_dest_port;
 
-	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
-		other_mirrors |= ingress ?
-				 chip->ports[i].mirror_ingress :
-				 chip->ports[i].mirror_egress;
+	if (!(route_status & DSA_ROUTE_SRC_PORT_BUSY)) {
+		if (mv88e6xxx_port_set_mirror(chip, from_port, direction, false))
+			dev_err(ds->dev, "p%d: failed to disable mirroring\n", from_port);
+	}
 
-	/* Reset egress port when no other mirror is active */
-	if (!other_mirrors) {
+	if (!(route_status & DSA_ROUTE_DEST_PORT_BUSY) &&
+	    *dest_port == to_port) {
 		if (mv88e6xxx_set_egress_port(chip, direction,
 					      MV88E6XXX_EGRESS_DEST_DISABLE))
 			dev_err(ds->dev, "failed to set egress port\n");
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index a73da4e965ec..0000a7aa3fbc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -284,8 +284,6 @@ struct mv88e6xxx_port {
 	u64 vtu_miss_violation;
 	phy_interface_t interface;
 	u8 cmode;
-	bool mirror_ingress;
-	bool mirror_egress;
 	struct devlink_region *region;
 	void *pcs_private;
 
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..777515ee722b 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1183,7 +1183,6 @@ int mv88e6xxx_port_set_mirror(struct mv88e6xxx_chip *chip, int port,
 			      enum mv88e6xxx_egress_direction direction,
 			      bool mirror)
 {
-	bool *mirror_port;
 	u16 reg;
 	u16 bit;
 	int err;
@@ -1195,11 +1194,9 @@ int mv88e6xxx_port_set_mirror(struct mv88e6xxx_chip *chip, int port,
 	switch (direction) {
 	case MV88E6XXX_EGRESS_DIR_INGRESS:
 		bit = MV88E6XXX_PORT_CTL2_INGRESS_MONITOR;
-		mirror_port = &chip->ports[port].mirror_ingress;
 		break;
 	case MV88E6XXX_EGRESS_DIR_EGRESS:
 		bit = MV88E6XXX_PORT_CTL2_EGRESS_MONITOR;
-		mirror_port = &chip->ports[port].mirror_egress;
 		break;
 	default:
 		return -EINVAL;
@@ -1210,8 +1207,6 @@ int mv88e6xxx_port_set_mirror(struct mv88e6xxx_chip *chip, int port,
 		reg |= bit;
 
 	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_CTL2, reg);
-	if (!err)
-		*mirror_port = mirror;
 
 	return err;
 }
-- 
2.11.0


