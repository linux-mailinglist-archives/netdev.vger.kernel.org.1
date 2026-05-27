Return-Path: <netdev+bounces-292383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MA2H1QfF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0515E7F2E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB82430C153E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856633CF671;
	Wed, 27 May 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="tMv/fe24"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F442E004
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899728; cv=none; b=LfHkgO7kI2+Dw+WsLBu3Fhp6TtelQE39J5zolwp3+2s890vXf9b2PxdoIf9p0C9OKh7c4Xl+V2nc3b2/NlQbNhVFiuLVqYOmeGCeVANz265v72mdop15X+WhhqaHzwRYxooAMAHouXTpgNhr0SL2OwAv55I+ajg+lPC+PCj2Icw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899728; c=relaxed/simple;
	bh=CmAd2GRzcWaTS7gWz2/jR6asi8PA1Zl+twIv/jLOEjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciXwU+40gn1G0jVvw/7H/CeyxolEUvQlMX4DjDkomQk115bfObPTg5+IhE7bdVSeztewBi80p4LQVv+ThvEMgzVPVnZZAZ74bV1A6c5MloGqbf1lf6D65Ite9YCm4OU4pwTkPQedbD889w20+/UUYm/3DSI06i2DLX5rfjmtRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=tMv/fe24; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779899707; x=1780504507;
	i=markus.stockhausen@gmx.de;
	bh=yNOO7NM4JjP2L+keORb+6ev06g5kfGoRw+XtVdsWbfA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tMv/fe24G0W+//T3JHmbkeaXak9zF3Qu2QRZQ8Tjmwgxf18NLllqyNMHmbJE30KP
	 kZyn//xAPrfR/xTRXaH52PGYfmQk1shQ5m4npTezyg8Eghupe89DLCcss49NVsrGh
	 x3ubmgNkIjJc7sTL+mvdYFHORE63tCnNhNpM9irrofqmJXmTShf4+J8fa0Y3rMEcB
	 smN6KY9p/Xk3ky1j+XcOAw2YqRD1oBRE+BTEh3WRj6t/oUlnhNs8+LORcM/cLVw5W
	 LXEFWBNyJSlMDrl9RBuf7/1cipVmFMmFWcCxHwXNG8STOFMbq29v7j5S2SJBHybRj
	 K2rs4pRBPodgl1wnsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1xFwzX2XIC-00tFQe; Wed, 27
 May 2026 18:35:07 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 1/4] net: mdio: realtek-rtl9300: provide generic command runner
Date: Wed, 27 May 2026 18:34:46 +0200
Message-ID: <20260527163449.1294961-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7jTMN1ZZMgoageEUmH+knnBR90POaAy7/dgFsmqLiHEK42aFDIo
 SPaPNJA68ZSerRFNfHbF42u12hzha/6OOXiicJhwq/zb2w4skisab2mUPiWLnDq+zwyz6dY
 L7SHkBp2ykLmfQ9WdECQdoVFtXqgKfsu3YmkRKBEkgpDFqyBZV/hG/v5Lk/qbsx65wTNSuQ
 t6H0BkT8bmJVkh97MMmxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HTFfXSpQmpY=;w0u8ZOvvQOqmQewydwodP05dUjM
 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
 ibSs6c7HEIgvu2uMYy+L3mCMF67hRvuwS7Q8HoZ
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-292383-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: CC0515E7F2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current bus read/write commands for C22/C45 are RTL930x specific.
Avoid to duplicate those 200 lines of code for the RTL838x, RTL839x and
RTL931x targets. Instead provide a generic command runner that is SoC
independent. The implementation works as follows:

The runner will take a prepared list of the four MDIO registers. It will
feed the data into the registers. This generic write to all registers
(or to say "a little bit too much") is no issue. The hardware looks at
the to be executed command and will only take the pieces of data that
are really required. No side effects have been observed on any of the
four SoCs during the time this mechanism exists in downstream OpenWrt.

The last fed register is the C22/command register. This will be enriched
with the proper command flags from the caller. The hardware issues the
command and the runner will wait for its finalization.

Besides from feeding all registers the runner emulates the behaviour of
the old code as best as possible

- check defensively for a running command in advance
- Before this commit the driver had different MMIO timeout values.
  1000s for command preparation, 100us after writes and 1000us after
  reads. The new version uses a consistent 1000us timeout for all
  of these.
- return -ENXIO in case of hardware failure (fail bit)

As a first consumer of this runner convert the write_c45() function.
This is realized in a multi stage approach

- a generic otto_emdio_write_c45() will be called by the bus
- this will forward the request to the device specific writer. In this
  case otto_emdio_9300_write_c45().
- There the command data is filled in and the additional helper
  otto_emdio_write_cmd() will be called
- That adds the write flag and issues the generic command runner.

With all the above mentioned in place, there is not much left to do in
otto_emdio_9300_write_c45(). It just fills the register fields and
calls the write helper with the right command bits.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 135 +++++++++++++++---------
 1 file changed, 83 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 65c59b8457d4..b8a627ba33da 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -90,6 +90,8 @@ struct otto_emdio_cmd_regs {
 };
=20
 struct otto_emdio_info {
+	u32 cmd_fail;
+	u32 cmd_write;
 	struct otto_emdio_cmd_regs cmd_regs;
 	u8 num_buses;
 	u8 num_ports;
@@ -97,7 +99,7 @@ struct otto_emdio_info {
 	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
 	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
 	int (*write_c22)(struct mii_bus *bus, int phy_id, int regnum, u16 value)=
;
-	int (*write_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regn=
um, u16 value);
+	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
 };
=20
 struct otto_emdio_priv {
@@ -132,6 +134,64 @@ static int otto_emdio_phy_to_port(struct mii_bus *bus=
, int phy_id)
 	return -ENOENT;
 }
=20
+static struct otto_emdio_priv *otto_emdio_bus_to_priv(struct mii_bus *bus=
)
+{
+	struct otto_emdio_chan *chan =3D bus->priv;
+
+	return chan->priv;
+}
+
+static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
+			      struct otto_emdio_cmd_regs *cmd_data)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	const struct otto_emdio_info *info =3D priv->info;
+	u32 cmdstate;
+	int ret;
+
+	/* Defensive pre check just in case something goes horrible wrong */
+	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+	if (ret)
+		return ret;
+
+	/* Fill all registers. Hardware will read only the needed bits depending=
 on command */
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.port_mask_low, cmd_dat=
a->port_mask_low);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.io_data, cmd_data->io_=
data);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.c45_data, cmd_data->c4=
5_data);
+	if (ret)
+		return ret;
+
+	/* C22 data and command bits share the same register. */
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.c22_data,
+			   cmd_data->c22_data | cmd | PHY_CTRL_CMD);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+	if (ret)
+		return ret;
+
+	return cmdstate & info->cmd_fail ? -ENXIO : 0;
+}
+
+static int otto_emdio_write_cmd(struct mii_bus *bus, u32 cmd,
+				struct otto_emdio_cmd_regs *cmd_data)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+
+	lockdep_assert_held(&priv->lock);
+
+	return otto_emdio_run_cmd(bus, cmd | priv->info->cmd_write, cmd_data);
+}
+
 static int otto_emdio_wait_ready(struct otto_emdio_priv *priv)
 {
 	struct regmap *regmap =3D priv->regmap;
@@ -304,64 +364,33 @@ static int otto_emdio_9300_read_c45(struct mii_bus *=
bus, int phy_id, int dev_add
 	return err;
 }
=20
-static int otto_emdio_9300_write_c45(struct mii_bus *bus, int phy_id, int=
 dev_addr,
-				  int regnum, u16 value)
+static int otto_emdio_9300_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
 {
-	struct otto_emdio_chan *chan =3D bus->priv;
-	struct otto_emdio_priv *priv;
-	u32 io_reg, cmd_reg, val;
-	struct regmap *regmap;
-	int port;
-	int err;
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, PHY_CTRL_TYPE_C45, &cmd_data);
+}
=20
-	priv =3D chan->priv;
-	regmap =3D priv->regmap;
-	io_reg =3D priv->info->cmd_regs.io_data;
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
+static int otto_emdio_write_c45(struct mii_bus *bus, int phy_id,
+				int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
-	mutex_lock(&priv->lock);
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, priv->info->cmd_regs.port_mask_low, BIT(por=
t));
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_INDATA, value);
-	err =3D regmap_write(regmap, io_reg, val);
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
-	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, cmd_reg, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE=
 | PHY_CTRL_CMD);
-	if (err)
-		goto out_err;
+	scoped_guard(mutex, &priv->lock)
+		ret =3D priv->info->write_c45(bus, port, dev_addr, regnum, value);
=20
-	err =3D regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_=
CMD), 10, 100);
-	if (err)
-		goto out_err;
-
-	if (val & PHY_CTRL_FAIL) {
-		err =3D -ENXIO;
-		goto out_err;
-	}
-
-	mutex_unlock(&priv->lock);
-	return 0;
-
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return ret;
 }
=20
 static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
@@ -438,7 +467,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
 		bus->read_c45 =3D priv->info->read_c45;
-		bus->write_c45 =3D priv->info->write_c45;
+		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
 		bus->read =3D priv->info->read_c22;
 		bus->write =3D priv->info->write_c22;
@@ -558,6 +587,8 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 }
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
+	.cmd_fail =3D PHY_CTRL_FAIL,
+	.cmd_write =3D PHY_CTRL_WRITE,
 	.cmd_regs =3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
=2D-=20
2.54.0


