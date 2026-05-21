Return-Path: <netdev+bounces-290581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN2NDQ9KD2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:08:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D9D5AACAE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 672DB3095E86
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11B3FA5D5;
	Thu, 21 May 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="qVRLXT/1"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072A223323
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386394; cv=none; b=UgzcbUDdkYMIw9gDmm7YL2yIPrW+K8NZgt+FEgzoiYYGgeMyFak04P711LhkwEg4GiqcUM8N9NH+ZcvYEl+ISdbwZv4DVhIvFCQD15r6cmlH3s/I8KGRC4m62xMsI27XMQlyuUxQ7t0P97eTjCyW/E1hnvVTMs5r0JIsf6zvOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386394; c=relaxed/simple;
	bh=h6RV2BvR45msish5YNsbRhMf2Kl41K8MrGvF+zAIUNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnU8Oab5tjLXF1AFxUyP6Zz8EqRt+xkFQNk9adWxnNT1v063KyUaRsDUw3PQF3Rd7TkbkzpDHULtlR5+mOS7p+kZ4g5HhZEg1lZWVk0hWwA/4SUh16Vf8RU1Hi/li6GAgtaQPYpdr2UB68L4epk6JpZcLhO/5lct56xOhtamBFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=qVRLXT/1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386378; x=1779991178;
	i=markus.stockhausen@gmx.de;
	bh=18v1z7xvKJHiWmmBpZo/nclo6WF4LOhQP872dkEoo5A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qVRLXT/1dviVTrsAnhKtnn1IOh6iEngirqThhL/Butq4Xbkoyac0cypKBx0BxoV/
	 A6LVddoBMp0W1G6fgV4zGYinC1xA+T+PS5i70qkrBpDQpbyskHLVLfXEMmRu4cP+h
	 cRrY0lT21JrlWR4CYpHgzNQPrOFTTel01QjSknDDODHAdiIninBwja0EYXbr/Wqkr
	 KeNpOxY8zwg5U5BNBIunbextoGCikYtUstE4YDRqV6XLONxN7fft2EmnB7vAkK8+M
	 CJBBqVl9ijGLMDZiXUbUjw+Ic8cHmoELeaxGitqLPlW3z1ZEQEE8J+CJ8ZyPVCl3p
	 FI/QDonukPwTiH1+RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1xHHR03yKl-00zrMb; Thu, 21
 May 2026 19:59:38 +0200
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
Subject: [PATCH net-next v2 9/9] net: mdio: realtek-rtl9300: Link I/O functions in info structure
Date: Thu, 21 May 2026 19:59:18 +0200
Message-ID: <20260521175918.1494797-10-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YPd9Dpil25TXFNKLjAcyYLV5YcN3Efgh9ZHyrk5L4Y/f/gYms8n
 7s/geCBH2gZH7PkK5Zk8fmluFGhZVOPc33yxMO8Hk3V+zMhp878QWGJFDkri9dQ/rpqzFhJ
 eEp4fJS5Aumjj5Y/M4FIUoJzW4A+zt6LRJ41ciwI9+jbQvjREwtDOJXJo9N3gvDswTfYNfn
 dMq1HvsZvVu0KNy9hToXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ezu1mF4GDcI=;hPU/Xx9y0cUWbBU+1zoVbTDLRY5
 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
 872SZ9u94LoAss5P1Fa4SWMZvehjBPRiq2AIaB6
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
	TAGGED_FROM(0.00)[bounces-290581-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A7D9D5AACAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MDIO controller registers of the different devices of the
Realtek Otto switch series are very similar. Nevertheless each
device will need to feed the whole command data distributed over
the controller registers slightly different.

E.g. the combined C22/command register has different field layouts.
On RTL930x bits 24-20 define the to-be-accessed C22 register number
while on RTL839x this is stored in bits 9-5.

Thus there need to be device specific read/write functions that
are called dynamically. Add them into the info structure and make
use of them where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 8130e376b59b..65c59b8457d4 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -94,6 +94,10 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
+	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
+	int (*write_c22)(struct mii_bus *bus, int phy_id, int regnum, u16 value)=
;
+	int (*write_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regn=
um, u16 value);
 };
=20
 struct otto_emdio_priv {
@@ -433,11 +437,11 @@ static int otto_emdio_probe_one(struct device *dev, =
struct otto_emdio_priv *priv
=20
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
-		bus->read_c45 =3D otto_emdio_9300_read_c45;
-		bus->write_c45 =3D otto_emdio_9300_write_c45;
+		bus->read_c45 =3D priv->info->read_c45;
+		bus->write_c45 =3D priv->info->write_c45;
 	} else {
-		bus->read =3D otto_emdio_9300_read_c22;
-		bus->write =3D otto_emdio_9300_write_c22;
+		bus->read =3D priv->info->read_c22;
+		bus->write =3D priv->info->write_c22;
 	}
 	bus->parent =3D dev;
 	chan =3D bus->priv;
@@ -563,6 +567,10 @@ static const struct otto_emdio_info otto_emdio_9300_i=
nfo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.read_c22 =3D otto_emdio_9300_read_c22,
+	.read_c45 =3D otto_emdio_9300_read_c45,
+	.write_c22 =3D otto_emdio_9300_write_c22,
+	.write_c45 =3D otto_emdio_9300_write_c45,
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
=2D-=20
2.54.0


