Return-Path: <netdev+bounces-289531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOxjCxiXDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:00:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EB582C5B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10ACF307187A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45640910A;
	Tue, 19 May 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="scmHT9uU"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E389409113
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209908; cv=none; b=PEkZmxv1cgGROgixfjl5XpLITgmzwLmMLO3qPti2Y00bd0BPplBB/aVzKKAYDi8cnjs+tkYLlt7ovOCKwd5S/m/eBm72ogDNBXw/b96f7y0HSiNm3xNHZw2QszlohS9yCSJY5ZkEh/pwgckDSIoxUkj4Wbo8TW1JG9/8VpfCOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209908; c=relaxed/simple;
	bh=f1QqwwculTleEdp3yYc19Vct1+Ih9AdNaUsggA+5oqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9lcDZn1HeYmMXJ8p65Esi6yTh7mmAjihI/lFx5en0jZfBclwsCXRND/5HuW82WCcdc29jbnAfDmLp4tku8z6GhPPaxLudh5tubDpjhop49OoteUBDYF1sGFKGIJrugoInKgF9YG9u6ezNhdZ0x9W78yNsC2VTMsGp9OC0mhI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=scmHT9uU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209890; x=1779814690;
	i=markus.stockhausen@gmx.de;
	bh=CVo42oon/Ug8AO2X6a447xER1YUlRbD20ujgcayZtuU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=scmHT9uUV5pgex2qTuJB0AjQdA9AOgtzC2pPnMMiRSMp20MpEnlNRjYMfb6g1cQj
	 1H8a9USDKPNzNwfqMUo6d/ltR7Jqjw76STUds50QaBVMaoBIQNnQ5Md9xWTLGMSyR
	 KNvdN6viZ/Yin+EsTqXNnK4atIHmxyoE2BvtM49pEjnmU3VbeYFVfNc35dxe/sn6D
	 Ed6tLoI5DdhpCvK0Auhtms6stgPoYzEfm4BW+luRS94hOW826POzBkIjelcei1pmS
	 n4XDg9EmOcE7WshrnIzryVQ35TMqY819eVzKIKatfBhyzlXZg08fktoy/uE3nGE9M
	 SXq7YS9UZ1yxZJDbFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1xPDgR2hY9-015bEI; Tue, 19
 May 2026 18:58:10 +0200
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
Subject: [PATCH 8/9] net: mdio: realtek-rtl9300: Add mask register
Date: Tue, 19 May 2026 18:57:46 +0200
Message-ID: <20260519165747.1288903-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JDwk21dLrTBo02moStEWjQ6QjJzAa49xTPKObgLPLFdoupTY5WR
 OkzSwju4AeUKbvRWB1YfsKBF1TktXUNlkt5j0GKbEkkZKRe1NdNMfKMHeLdtLXiGiOGcfzw
 VUlNcnnJMG86GvEFxmIeBZgUaQXQsR2oOgyglqJQuYwoXICe+aRpRCG0eVuUntpUdqc2Vd2
 A8HV1AAQxTm3ADPETr/mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qrw8QyYsum0=;CuY5WiTH6THa2JY++FjyQwMP5IG
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289531-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 9C1EB582C5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MDIO write commands take a register mask that specifies to which PHYs
the data is written. Depending on the SOC type and the number of
supported PHYs this is either one or two mask registers. The driver
currently only supports the 28 port RTL930x SOCs. So provide only the
mask register for the lower 32 ports. Add it to the register structure
and make use of it where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index be6a0cfe4bb8..f43403a7f39a 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -25,7 +25,7 @@
 #define SMI_GLB_CTRL			0xca00
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
 #define SMI_PORT0_15_POLLING_SEL	0xca08
-#define SMI_ACCESS_PHY_CTRL_0		0xcb70
+#define RTL9300_SMI_ACCESS_PHY_CTRL_0	0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1	0xcb74
 #define   PHY_CTRL_REG_ADDR		GENMASK(24, 20)
 #define   PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
@@ -57,6 +57,7 @@ struct rtl_mdio_cmd_regs {
 	u32 c22_data;
 	u32 c45_data;
 	u32 io_data;
+	u32 mask_low;
 };
=20
 struct rtl_mdio_info {
@@ -183,7 +184,7 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bus,=
 int phy_id, int regnum, u
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_0, BIT(port));
+	err =3D regmap_write(regmap, priv->info->cmd_regs.mask_low, BIT(port));
 	if (err)
 		goto out_err;
=20
@@ -294,7 +295,7 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bus,=
 int phy_id, int dev_addr,
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_0, BIT(port));
+	err =3D regmap_write(regmap, priv->info->cmd_regs.mask_low, BIT(port));
 	if (err)
 		goto out_err;
=20
@@ -528,6 +529,7 @@ static const struct rtl_mdio_info rtl9300_mdio_info =
=3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
 		.io_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_2,
+		.mask_low =3D RTL9300_SMI_ACCESS_PHY_CTRL_0,
 	},
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
=2D-=20
2.54.0


