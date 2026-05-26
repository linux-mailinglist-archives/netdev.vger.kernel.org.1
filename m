Return-Path: <netdev+bounces-291869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHkVNgzcFWpzdQcAu9opvQ
	(envelope-from <netdev+bounces-291869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12D5DAE0D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96B403039C65
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F541B366;
	Tue, 26 May 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="N0Lp7J/a"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B36421885
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817452; cv=none; b=ssp1OsfLov8uppfCSulQ02RLSwOZYHQq/tkwRyiTAN5qf6tzo4d0TPDu/ClK8jsYduw1L4+Dd/idwN1kSyRl8c0xBNCl9b96e3cLWsYwsgHm4BDo5UI2bc2kPSKsfColoIfuZ3acgQfYHOptA6U/fyasyltotwSpr2KI9jM4e4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817452; c=relaxed/simple;
	bh=lxLqeV18OsIbhFpiIDWUnsCUyN+MIJrhkDFwSeYL/8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYaZSxl9TTIYbjNjcs0AFvbiPh/3RAHbbObEf6vevCnD4gmbusZsXmVAu4QjHm9XaV5lMuCw8Lc0imv9rlnoXYPsowvvrnW9OswjvjzZPIaGpgSo3bCXcmroKuymcF0HQUqJ8/CcmcfAcnn7yZlFUW+c1tUwI+GU+Fg0og8JSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=N0Lp7J/a; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779817445; x=1780422245;
	i=markus.stockhausen@gmx.de;
	bh=2nh9XNX2+ubq/cVQYBoNW+fEulYR808mD9I4pGU1G2A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N0Lp7J/aplf7/8d9+uzlfFNgpWwZqRg3ZClHnHJwOaHVnjNWGlO4thyrGfcKSTkY
	 OVjU9qgRN0hFYETo1Ow9MdfJsXn+QoxLjs/iVLzKXprsdw714D/5GKGGeux3aUCHU
	 F51bfLGPgXoZ3VkCZUNKQ8xhx4Sj5RTxYAW2ldnUPyadjAQnwNrcLrGnvU10dtu09
	 tMk9IpKtGdyUzavqrWfGaXCX5wtz73+I/OWEpdBtCzA9s0mHV/JrKC/GcBTVNvz8J
	 jNl/JG3oRfLsZUVhHS/U6ZHgP/1rYz3SnHKVns5SHfZ4XceROXgcnNNY1H4JSmKcb
	 0p1X/l2NyWFTu4DHRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1whmed1nq6-00IgCe; Tue, 26
 May 2026 19:44:05 +0200
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
Subject: [PATCH net-next 5/5] net: mdio: realtek-rtl9300: use command runner for read_c22()
Date: Tue, 26 May 2026 19:43:44 +0200
Message-ID: <20260526174344.1186832-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
References: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qtDwbZoleJSx3pXwrCy9ryXwEW/iS1V3NaANIiJaQWDtOoGZTbB
 9XeYFX+ahqZGAVPFO5WbsZzwJ269wie9Y8jOlRZeMPgtemY332XitflrXKJYGrAGG8P4VFW
 5/KRjYEYyuKB5eetdNzxk/16jf0C5YP96rK24+coACe7TXRaK5XD2V7Jdg3HNgsSQtlfa6t
 BCVLNv5mTq8fquCnl2npQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oHKtZMkBAAo=;7xpBVDk5/161pd+j6fB8n15sCpg
 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
 i9PXOTezyGyzqR7CEzXwVJcEP9yYrtTOwBPHmkr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-291869-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 7A12D5DAE0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the final missing read_c22() path to the new read enabled command
runner. Do it the same way as other implementations.

- bus calls otto_emdio_read_c22()
- this hands over to SoC specific otto_emdio_9300_read_c22()
- finally the registers are filled and the runner issued

With this cleanup remove the obsolete helper otto_emdio_wait_ready()

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 86 ++++++++-----------------
 1 file changed, 27 insertions(+), 59 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 10a433e497a1..c2cda08fc455 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -95,7 +95,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
-	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
+	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
 	int (*write_c22)(struct mii_bus *bus, int port, int regnum, u16 value);
 	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
@@ -191,66 +191,18 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u=
32 cmd,
 	return 0;
 }
=20
-static int otto_emdio_wait_ready(struct otto_emdio_priv *priv)
+static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
-	struct regmap *regmap =3D priv->regmap;
-	u32 cmd_reg, val;
-
-	lockdep_assert_held(&priv->lock);
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
-
-	return regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_C=
MD), 10, 1000);
-}
-
-static int otto_emdio_9300_read_c22(struct mii_bus *bus, int phy_id, int =
regnum)
-{
-	struct otto_emdio_chan *chan =3D bus->priv;
-	struct otto_emdio_priv *priv;
-	u32 io_reg, cmd_reg, val;
-	struct regmap *regmap;
-	int port;
-	int err;
-
-	priv =3D chan->priv;
-	regmap =3D priv->regmap;
-	io_reg =3D priv->info->cmd_regs.io_data;
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
-
-	port =3D otto_emdio_phy_to_port(bus, phy_id);
-	if (port < 0)
-		return port;
-
-	mutex_lock(&priv->lock);
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, io_reg, FIELD_PREP(PHY_CTRL_INDATA, port));
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
-	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
-	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
-	err =3D regmap_write(regmap, cmd_reg, val);
-	if (err)
-		goto out_err;
-
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_read(regmap, io_reg, &val);
-	if (err)
-		goto out_err;
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
=20
-	mutex_unlock(&priv->lock);
-	return FIELD_GET(PHY_CTRL_DATA, val);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, port),
+	};
=20
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C22 | PHY_CTRL_READ, &cmd_d=
ata, value);
 }
=20
 static int otto_emdio_9300_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
@@ -293,6 +245,22 @@ static int otto_emdio_9300_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE, &cmd_=
regs, NULL);
 }
=20
+static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnu=
m)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
+	u32 value;
+
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
+	if (port < 0)
+		return port;
+
+	scoped_guard(mutex, &priv->lock)
+		ret =3D (*priv->info->read_c22)(bus, port, regnum, &value);
+
+	return ret ? ret : value;
+}
+
 static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -416,7 +384,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		bus->read_c45 =3D otto_emdio_read_c45;
 		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
-		bus->read =3D priv->info->read_c22;
+		bus->read =3D otto_emdio_read_c22;
 		bus->write =3D otto_emdio_write_c22;
 	}
 	bus->parent =3D dev;
=2D-=20
2.54.0


