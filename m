Return-Path: <netdev+bounces-292382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGL4IEYfF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F04835E7F18
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068C230BF329
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE4D436344;
	Wed, 27 May 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="uSjnCuv0"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354813FEE
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899726; cv=none; b=KKtc30o58XoacNOYMJJxn/qde1oeWqpmxyCPswA0mP0ckzdokoypTVF/H2ONhcNbNJhIAjw0JxsYVWi35eqKcfbUsy43Ey5GRHVGlq6w5dah/hWC+49nudQA0yEULgwRR2kheqks+CKylOQL53ngWwOHwaOfN68GK35aYqekhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899726; c=relaxed/simple;
	bh=iQImpEUZOOH0Rs24eoLd2ZGRkTPOzUzulxrfYw0269s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itNnl4PkO6yd6S/JbHaWfXi4wOHB5fqzIk7kIyUqD5Wl/SNo2YSr/FQkDgRTBq0c8VXoOhejUeQqBeWLRTthCV8M8QkW4TZIAd/C7QziNBGpG1ijRxhzuzOg8rse4mqHppObVvIa0d0W5Duu+xev3Q9z1psbJY2uerApH/h4AtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=uSjnCuv0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779899708; x=1780504508;
	i=markus.stockhausen@gmx.de;
	bh=Yp6Fqk10xgxcQ2gdMzR8ZbZ5oKpxa4G04795mM7xb9U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uSjnCuv0IqOEn5bbtw5tksBA4BPkIDlsiPOqbkQf6g0FwJbMP6MOIsGIsbHcto90
	 yMrt6b2Q7+tAhTfEpopHxSBsW6O0jmuUSi9YX6MUJ4FXwNXqbUasWSkvIsM9Milnx
	 y6rn3umid0w0K7EaE0/XJCf55Cjx7TxwIteCJcoz+bRKZsr3DM+Apms2baPiL+PWM
	 OI4CQ46wS7aErXWrsEWbgmVm5NZPs7+dxIjdMXWuzRtNtS8ywJPE0RAdBXBz9Inpm
	 JYbF7hSly5lGRzCFvF7b/Xv6ZON+LaSgdu0X9eremm6qc8KLZyqgsoCVYr9EygHMQ
	 1BlwMKHgHWD7doutoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V4P-1xSNS03RVP-017FmN; Wed, 27
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
Subject: [PATCH net-next v2 2/4] net: mdio: realtek-rtl9300: use command runner for write_c22()
Date: Wed, 27 May 2026 18:34:47 +0200
Message-ID: <20260527163449.1294961-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:YivNyjSWYIFS4iJfkX2J7PhC3k7Aa+xlHo/AHISR4xatQ12SG9c
 N0I/VFh7bRoSffTyyQ+P6pKh57vapQIEhp7jL+a8gNM+22MEmcGr+uUrG31G+ECyJcIWDQ3
 riZD5m4l6wwRvaw0tDrI6M55Byn6zEdqP88q82e79svWqjB71NskWPtAhAqnZLzrSbrK9Vo
 MsNsjPeWZMkauzrhfMYHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MFMrUxcMfXY=;ESz++EmA/4uUhhO8VYItIl0L/n/
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-292382-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F04835E7F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that the driver has a generic command runner make use of it in the
write_c22() path. For this.

- add generic otto_emdio_write_c22() helper that will be called by bus
- convert otto_emdio_9300_write_c22() to new command runner logic

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 81 +++++++++----------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index b8a627ba33da..e2685a169952 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -98,7 +98,7 @@ struct otto_emdio_info {
 	u16 num_pages;
 	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
 	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
-	int (*write_c22)(struct mii_bus *bus, int phy_id, int regnum, u16 value)=
;
+	int (*write_c22)(struct mii_bus *bus, int port, int regnum, u16 value);
 	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
 };
=20
@@ -254,60 +254,18 @@ static int otto_emdio_9300_read_c22(struct mii_bus *=
bus, int phy_id, int regnum)
 	return err;
 }
=20
-static int otto_emdio_9300_write_c22(struct mii_bus *bus, int phy_id, int=
 regnum, u16 value)
+static int otto_emdio_9300_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
 {
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
-	err =3D regmap_write(regmap, priv->info->cmd_regs.port_mask_low, BIT(por=
t));
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, io_reg, FIELD_PREP(PHY_CTRL_INDATA, value))=
;
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
-	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
-	      PHY_CTRL_WRITE | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
-	err =3D regmap_write(regmap, cmd_reg, val);
-	if (err)
-		goto out_err;
-
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
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
=20
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return otto_emdio_write_cmd(bus, PHY_CTRL_TYPE_C22, &cmd_data);
 }
=20
 static int otto_emdio_9300_read_c45(struct mii_bus *bus, int phy_id, int =
dev_addr, int regnum)
@@ -377,6 +335,21 @@ static int otto_emdio_9300_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
+
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
+	if (port < 0)
+		return port;
+
+	scoped_guard(mutex, &priv->lock)
+		ret =3D priv->info->write_c22(bus, port, regnum, value);
+
+	return ret;
+}
+
 static int otto_emdio_write_c45(struct mii_bus *bus, int phy_id,
 				int dev_addr, int regnum, u16 value)
 {
@@ -470,7 +443,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
 		bus->read =3D priv->info->read_c22;
-		bus->write =3D priv->info->write_c22;
+		bus->write =3D otto_emdio_write_c22;
 	}
 	bus->parent =3D dev;
 	chan =3D bus->priv;
=2D-=20
2.54.0


