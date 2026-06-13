Return-Path: <netdev+bounces-299091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I/rPBmHmLWqkmQQAu9opvQ
	(envelope-from <netdev+bounces-299091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67103680085
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:23:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=SRX1r4O+;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=GifYbI04;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299091-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299091-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C35302A2CE
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175838BF8D;
	Sat, 13 Jun 2026 23:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-17.smtp-out.amazonses.com (a9-17.smtp-out.amazonses.com [54.240.9.17])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412F37B409;
	Sat, 13 Jun 2026 23:22:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392933; cv=none; b=sk+WdTw3RLl8KAvRer15dtifke+30ad6QyWx+b7nDubcpkHyFMO8TdCdT8DHL+doIMFCk9C8uDc2claAeEVkYEQES2z8p9qbdxbLhgPSvxi0rvQCxau6IwSn+wE8kojoFKJ7gtUYSRyn0iZBDrZShw3ETyGTh77PZ3VGR0B2B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392933; c=relaxed/simple;
	bh=+5LYoNP1eG5vrm2j3tw8o4jKTNEBr/JqbbckNMfB9/k=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OCb9w/NSXZusk/scEvn2kfA/MpVG6Pa5vqQaeKDuu2Q+zY5GBdf5ChmKMLQ1eHfvVvugOJ063hhdTXzefdB5NOJJ2ON/PaMKQcPmv/VlnEgyB9LOVv3/NaTCCMSUsx/PgHee5JyKqPR2Ok3KBCqW2Yk0K0tdMFOZBfDE+QWv9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=SRX1r4O+; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=GifYbI04; arc=none smtp.client-ip=54.240.9.17
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781392931;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=+5LYoNP1eG5vrm2j3tw8o4jKTNEBr/JqbbckNMfB9/k=;
	b=SRX1r4O+AvOsiRYStwWwrovPSVKCW8+gM4Dbc2M5EHtHcdGTEeUk9JLOybQy3x0l
	C0KdYvcYRXW2uKk9NVzE0rbhzVa0/g+hUpNW5s8yrko6q0z73qDAM3RnQyCWocJ3onF
	t1AU/M/AUtTCjSBh0t9TpaFiRk58FcI7K6NkXKbs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781392931;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=+5LYoNP1eG5vrm2j3tw8o4jKTNEBr/JqbbckNMfB9/k=;
	b=GifYbI045NHJXG+3J9nuwQLtuDGYvjlvO6VP4FHz+ZJJEp2b+f7v+IHSKpYYabYb
	dgHtWgR2yEPW6Az1O6DmVRlOhefXSyFXrjgKY42e6IJbGxq2mm+0v3IhTSkvxFaybQo
	FVm6VYzoj9UlUHaSTJSdFnWGPBEDF1WcGQOmIo7k=
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613232136.24246-1-contact@c127.dev>
References: <20260613232136.24246-1-contact@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, namiltd@yahoo.com, luizluca@gmail.com, 
	linux-kernel@vger.kernel.org, contact@c127.dev
Subject: [PATCH net-next v3 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
Message-ID: <0100019ec34af78a-7a3b914f-6c41-4993-a9e0-d863bfabc7cd-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 23:22:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.13-54.240.9.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[c127.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299091-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[armlinux.org.uk,yahoo.com,gmail.com,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c127.dev:dkim,c127.dev:email,c127.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazonses.com:dkim,email.amazonses.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67103680085

In addition to SGMII, the RTL8367S SerDes also supports HSGMII, which
carries 2.5 Gbps with the same signaling as SGMII at 2.5x clock rate.
The chip info table already declares HSGMII as a supported interface
mode for external interface 1.

Extend the SGMII configuration path to =
handle HSGMII, which phylink
represents as 2500base-x:

 - Use the HSGMII SerDes tuning parameters and external interface mode,
   and mux the SerDes to MAC8 in HSGMII mode. The parameters are again
   lifted from the GPL-licensed Realtek rtl8367c vendor driver.

 - Advertise 2500base-x and MAC_2500FD on ports whose external
   interface supports HSGMII.

 - Accept SPEED_2500 in the force mode =
configuration. The MAC speed
   field has no 2.5 Gbps value: the rate is =
determined by the HSGMII
   SerDes configuration, and the vendor driver =
programs the 1 Gbps
   value here, so do the same.

Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
the SoC over HSGMII.

Signed-off-by: Johan Alvarado <contact@c127.dev>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 66 ++++++++++++++++++------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c =
b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 89b7608aaa3a..ac5348f505b9=
 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -41,7 +41,7 @@
  * matter.
  *
  * NOTE: Currently, only the RGMII interface is =
implemented in this driver. On
- * the RTL8367S, the SGMII interface is =
also supported.
+ * the RTL8367S, the SGMII and HSGMII interfaces are also =
supported.
  *
  * The interrupt line is asserted on link UP/DOWN events. =
The driver creates a
  * custom irqchip to handle this interrupt and =
demultiplex the events by reading
@@ -603,6 +603,13 @@ static const struct =
rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_sgmii[] =3D {
 	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
 };
=20
+/* HSGMII SerDes tuning =
parameters, lifted from the vendor driver sources */
+static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] =3D=
 {
+	{ 0x0500, 0x82F0 }, { 0x0501, 0xF195 }, { 0x0502, 0x31A2 },
+	{ 0x0503, 0x7960 }, { 0x0504, 0x9728 }, { 0x0423, 0x9D85 },
+	{ 0x0424, 0xD810 }, { 0x0001, 0x0F80 }, { 0x002E, 0x83F2 },
+};
+
 enum rtl8365mb_phy_interface_mode {
 	RTL8365MB_PHY_INTERFACE_MODE_INVAL =
=3D 0,
 	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL =3D BIT(0),
@@ -1150,10 +1157,14 @@ static int rtl8365mb_sds_read(struct realtek_priv =
*priv, int sds, u16 addr,
 	return 0;
 }
=20
-static int =
rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port)
+static int rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port,
+				      phy_interface_t interface)
 {
 	const struct rtl8365mb_extint =
*extint =3D
 		rtl8365mb_get_port_extint(priv, port);
+	const struct rtl8365mb_jam_tbl_entry *sds_jam;
+	size_t sds_jam_size;
+	u32 mode;
 	u16 val;
 	int ret;
 	int i;
@@ -1165,6 +1176,16 @@ static =
int rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port)
 	if (extint->id !=3D 1)
 		return -EOPNOTSUPP;
=20
+	if (interface =3D=3D PHY_INTERFACE_MODE_2500BASEX) {
+		sds_jam =3D rtl8365mb_sds_jam_hsgmii;
+		sds_jam_size =3D =
ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
+		mode =3D RTL8365MB_EXT_PORT_MODE_H=
SGMII;
+	} else {
+		sds_jam =3D rtl8365mb_sds_jam_sgmii;
+		sds_jam_size =3D ARRAY_SIZE(rtl8365mb_sds_jam_sgmii);
+		mode =3D RTL8365MB_EXT_PORT_MODE_SGMII;
+	}
+
 	/* Hold the embedded =
DW8051 microcontroller in reset and keep it
 	 * disabled. The vendor =
driver loads firmware into it to manage the
 	 * SerDes link, but the =
firmware only duplicates work that phylink
@@ -1192,28 +1213,28 @@ static =
int rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port)
 		return ret;
=20
 	/* Tune the SerDes with vendor-prescribed parameters =
*/
-	for (i =3D 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
-		ret =3D rtl8365mb_sds_write(priv, 0,
-					  rtl8365mb_sds_jam_sgmii[i].=
reg,
-					  rtl8365mb_sds_jam_sgmii[i].val);
+	for (i =3D 0; i < =
sds_jam_size; i++) {
+		ret =3D rtl8365mb_sds_write(priv, 0, sds_jam[i].reg=
,
+					  sds_jam[i].val);
 		if (ret)
 			return ret;
 	}
=20
-	/* Mux the SerDes to MAC8 in SGMII mode */
+	/* Mux the SerDes to MAC8 in=
 the requested mode */
 	ret =3D regmap_update_bits(priv->map, =
RTL8365MB_SDS_MISC_REG,
 				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
 					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
-				 =
RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK);
+				 mode =3D=3D =
RTL8365MB_EXT_PORT_MODE_SGMII ?
+					 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MA=
SK :
+					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK);
 	if (ret)
 		return ret;
=20
 	ret =3D regmap_update_bits(
 		priv->map, =
RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
 		RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
-		RTL8365MB_EXT_PORT_MODE_SGMII
-			<< RTL8365MB_DIGITAL_INTERFACE_SELECT_=
MODE_OFFSET(
-				   extint->id));
+		mode << RTL8365MB_DIGITAL_INTERFACE_S=
ELECT_MODE_OFFSET(
+			       extint->id));
 	if (ret)
 		return ret;
=20
@@ -1255,7 +1276,8 @@ static int rtl8365mb_ext_config_sgmii(struct =
realtek_priv *priv, int port)
=20
 static bool rtl8365mb_interface_is_serde=
s(phy_interface_t interface)
 {
-	return interface =3D=3D =
PHY_INTERFACE_MODE_SGMII;
+	return interface =3D=3D =
PHY_INTERFACE_MODE_SGMII ||
+	       interface =3D=3D =
PHY_INTERFACE_MODE_2500BASEX;
 }
=20
 static int rtl8365mb_sds_config_force=
mode(struct realtek_priv *priv, bool link,
@@ -1271,7 +1293,11 @@ static =
int rtl8365mb_sds_config_forcemode(struct realtek_priv *priv, bool link,
 	u32 r_speed;
=20
 	if (link) {
-		if (speed =3D=3D SPEED_1000) {
+		/* The speed field has no value for 2.5 Gbps: the rate is
+		 * determined by the HSGMII SerDes configuration, and the
+		 * vendor driver programs the 1 Gbps value here.
+		 */
+		if (speed =3D=3D SPEED_2500 || speed =3D=3D SPEED_1000) {
 			r_speed =3D RTL8365MB_PORT_SPEED_1000M;
 		} else if (speed =3D=3D =
SPEED_100) {
 			r_speed =3D RTL8365MB_PORT_SPEED_100M;
@@ -1323,7 +1349,11 @@ static int rtl8365mb_ext_config_forcemode(struct =
realtek_priv *priv, int port,
 		r_rx_pause =3D rx_pause ? 1 : 0;
 		r_tx_pause =3D tx_pause ? 1 : 0;
=20
-		if (speed =3D=3D SPEED_1000) {
+		/* The speed field has no value for 2.5 Gbps: the rate is
+		 * determined by the HSGMII SerDes configuration, and the
+		 * vendor driver programs the 1 Gbps value here.
+		 */
+		if (speed =3D=3D SPEED_2500 || speed =3D=3D SPEED_1000) {
 			r_speed =3D RTL8365MB_PORT_SPEED_1000M;
 		} else if (speed =3D=3D =
SPEED_100) {
 			r_speed =3D RTL8365MB_PORT_SPEED_100M;
@@ -1403,6 +1433,12 @@ static void rtl8365mb_phylink_get_caps(struct =
dsa_switch *ds, int port,
 	if (extint->supported_interfaces & =
RTL8365MB_PHY_INTERFACE_MODE_SGMII)
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
+
+	if (extint->supported_interfaces &=
 RTL8365MB_PHY_INTERFACE_MODE_HSGMII) {
+		__set_bit(PHY_INTERFACE_MODE_250=
0BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities =
|=3D MAC_2500FD;
+	}
 }
=20
 static void rtl8365mb_phylink_mac_config(struc=
t phylink_config *config,
@@ -1431,7 +1467,7 @@ static void =
rtl8365mb_phylink_mac_config(struct phylink_config *config,
 	}
=20
 	if (rtl8365mb_interface_is_serdes(state->interface)) {
-		ret =3D rtl8365mb_ext_config_sgmii(priv, port);
+		ret =3D =
rtl8365mb_ext_config_sgmii(priv, port, state->interface);
 		if (ret)
 			dev_err(priv->dev,
 				"failed to configure SGMII mode on port %d: =
%d\n",
--=20
2.54.0


