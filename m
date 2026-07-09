Return-Path: <netdev+bounces-306367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G94nG94DUGqbrwIAu9opvQ
	(envelope-from <netdev+bounces-306367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ADE735558
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:26:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b="z6/84Fpf";
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=PCQcyRsx;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306367-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306367-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B4393001A59
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF33A9616;
	Thu,  9 Jul 2026 20:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-19.smtp-out.amazonses.com (a9-19.smtp-out.amazonses.com [54.240.9.19])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076D29E116;
	Thu,  9 Jul 2026 20:25:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628760; cv=none; b=dINCFC0HyDWxr2D8jhgbBS5q2Qkh1P7z/0P8lm4XBRWkbPTiuUxX5XM3M7CpdGTFDwJ+SGkUVv1V6pC1x6I/CR1cuUuSfmXNrb8pIM5oXN2M5PkPK439MTbe4KNLt2PdYRqp0P8kpxCFjX1wGNUjFu/VJLnl8KHFZqNZ/xBGt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628760; c=relaxed/simple;
	bh=xH+NbxEBVVo2vlMOYmMIR6vrGsIXnZgrvwLBgd8Prpg=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Ekf1FecjA8sdZ/tKqCefOjFKhEs1MeuEwDV9D8wqEW8r4ZFOr/gc/Bcxdlj7YaO7+WPZNHAbN619b4y7CaliwK3cPJKyoJI6Cvp2uJIJr/oWUcIhoDi1+PJvwcFZVYhp/40McCiaRKhbJsk406nNCVEcBMT1Bf9Cri08xDOeIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=z6/84Fpf; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=PCQcyRsx; arc=none smtp.client-ip=54.240.9.19
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783628757;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=xH+NbxEBVVo2vlMOYmMIR6vrGsIXnZgrvwLBgd8Prpg=;
	b=z6/84FpfY9MVMMMxZxzK3KE6gtQgxHWB601CrCfLVWDeU6EEmGmBdBk3zOu+viCC
	qgQ8bpQPMmh4Xdi9Hu0nSpXNyPGNJTn6IRFy1/Qr8I2YdssXNCbAg4LJ8NNPApUr+cq
	6Aw1gRswhv39D969AUj8mfDt01zVKseF2l/Qnczc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783628757;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=xH+NbxEBVVo2vlMOYmMIR6vrGsIXnZgrvwLBgd8Prpg=;
	b=PCQcyRsx10PrFYJIEPcNqwYx2pJVflC8UjDCCmhakAqUdNXf08qngLAp3BXgts/z
	NvYqC64wwXosXyVWs+uvcirf+GNE4QeF6KXScNIqAZDUQDdCncknwuFFNQZy7QELjsE
	U7d8zeE78Zu5KTuBDdwpO3S2LDRp305gvKgs+Luw=
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709202531.17166-1-contact@c127.dev>
References: <20260709202531.17166-1-contact@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk
Cc: luizluca@gmail.com, maxime.chevallier@bootlin.com, namiltd@yahoo.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	contact@c127.dev
Subject: [PATCH net-next v5 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
Message-ID: <0100019f488ef6e4-80d3756e-7371-4d40-b436-680af5df3bd8-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 9 Jul 2026 20:25:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.09-54.240.9.19
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:maxime.chevallier@bootlin.com,m:namiltd@yahoo.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[c127.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306367-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,yahoo.com,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amazonses.com:dkim,email.amazonses.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63ADE735558

The RTL8367S can mux its embedded SerDes to external interface 1,
which is typically used to connect the switch to a CPU port. The chip
info table already declares SGMII as a supported interface mode for
this chip, but the driver only implements RGMII so far.

Implement SGMII support as a phylink PCS, with the configuration
sequence derived from the GPL-licensed Realtek rtl8367c vendor driver
as distributed in the Mercusys MR80X GPL code drop:

 - Add accessors for the SerDes indirect access registers (SDS_INDACS),
   through which the SerDes internal registers are reached.

 - Register a phylink_pcs for the SerDes, selected from mac_select_pcs
   for the SGMII interface, so the SerDes handling lives in the PCS
   operations rather than in the MAC operations.

 - Probe the SerDes =
tuning variant from the chip option register once
   at setup. The vendor =
driver keeps two sets of SerDes tuning
   parameters and selects between =
them based on this option; only the
   variant for a non-zero option (which=
 all RTL8367S parts seen so far
   report) has been validated on hardware, =
so the SerDes interface
   modes are only advertised in that case. An =
unsupported variant thus
   fails at phylink validation time instead of at =
link configuration
   time.

 - Keep the embedded DW8051 microcontroller in=
 reset and disabled. The
   vendor driver loads firmware into it to manage =
the SerDes link, but
   analysis of that firmware shows it only duplicates =
the link
   management phylink already performs: it polls the port status =
and
   writes the external interface force registers behind the driver's
   back.

 - Clear the line rate bypass bit for the external interface, =
tune the
   SerDes with the vendor-prescribed parameters, mux the SerDes to=
 MAC8
   in SGMII mode and only then take the SerDes out of reset, as the
   vendor driver does.

 - After deasserting the SerDes reset, reset the =
SerDes data path via
   the SerDes BMCR register to flush the FIFOs and =
resync the PLL.
   This mirrors what the vendor firmware does right after =
deasserting
   the SerDes reset, and ensures a clean link state from cold =
boot.

 - Force the SGMII link parameters (link, speed, duplex) in the =
SDS_MISC
   register from pcs_link_up(). SGMII in-band autonegotiation is =
not
   implemented, so only fixed-link and conventional PHY setups are
   supported, just like RGMII. This is reported to phylink through
   pcs_inband_caps() returning LINK_INBAND_DISABLE, so phylink never
   selects an in-band-enabled negotiation mode for this PCS.

 - Program the SerDes pause enables in SDS_MISC from the resolved
   pause modes when forcing the MAC external interface in mac_link_up,
   as the vendor driver does, rather than leaving whatever state the
   boot firmware left there. Flow control testing shows these bits,
   not the MAC force pause bits, gate pause on the SerDes external
   interface. This is done in the MAC layer because pcs_link_up()
   carries no pause information.

 - Implement pcs_get_state() by reading =
the link status from the
   SerDes, with the forced speed and duplex read =
back from SDS_MISC.
   Although the supported fixed-link and conventional =
PHY setups do not
   use it, the PCS owns the SerDes link state, and =
phylink consults
   pcs_get_state() to track the physical link when =
operating in in-band
   mode with autonegotiation disabled. The SerDes has =
no link interrupt
   wired up, so the PCS sets its poll flag.

Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
the SoC over SGMII.

Suggested-by: Luiz Angelo Daros de Luca =
<luizluca@gmail.com>
Suggested-by: Maxime Chevallier <maxime.=
chevallier@bootlin.com>
Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.=
com>
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 515 ++++++++++++++++++++++-
 1 file changed, 511 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c =
b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 5ac091bf93c9..ea03c42d0f1a=
 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -40,7 +40,8 @@
  * driver has only been tested with a fixed-link, but in principle it =
should not
  * matter.
  *
- * NOTE: Currently, only the RGMII interface is=
 implemented in this driver.
+ * NOTE: Currently, only the RGMII and SGMII =
interfaces are implemented in this
+ * driver.
  *
  * The interrupt line =
is asserted on link UP/DOWN events. The driver creates a
  * custom irqchip to handle this interrupt and demultiplex the events by =
reading
@@ -94,11 +95,13 @@
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
+#include <linux/mii.h>
 #include <linux/mutex.h>
 #include <linux/of_irq.=
h>
 #include <linux/regmap.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
+#include <linux/phylink.h>
=20
 #include "realtek.h"
 #include "realtek-smi.h"
@@ -129,6 +132,7 @@
=20
 /* Chip reset register */
 #define RTL8365MB_CHIP_RESET_REG	0x1322
+#define RTL8365MB_CHIP_RESET_DW8051_MASK	0x0010
 #define =
RTL8365MB_CHIP_RESET_SW_MASK	0x0002
 #define RTL8365MB_CHIP_RESET_HW_MASK	=
0x0001
=20
@@ -238,6 +242,76 @@
 #define   RTL8365MB_EXT_RGMXF_RXDELAY_MASK=
	0x0007
 #define   RTL8365MB_EXT_RGMXF_TXDELAY_MASK	0x0008
=20
+/* External interface line rate bypass register - one bit per external
+ * interface, indexed by the external port number with port 5 (the first
+ * external port) as the base. Other RTL8367 families index this register
+ * differently (e.g. the RTL8367R uses (id + 1) % 2), so this mapping only
+ * holds for the RTL8367C-style parts this driver supports.
+ */
+#define RTL8365MB_BYPASS_LINE_RATE_REG		0x03F7
+#define =
RTL8365MB_BYPASS_LINE_RATE_MASK(_port)	BIT((_port) - 5)
+
+/* SerDes indirect access registers */
+#define RTL8365MB_SDS_INDACS_CMD_R=
EG		0x6600
+#define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	0x0100
+#define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	0x0080
+#define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	0x0040
+#define =
RTL8365MB_SDS_INDACS_ADR_REG		0x6601
+#define RTL8365MB_SDS_INDACS_DATA_REG=
		0x6602
+
+/* SerDes miscellaneous configuration register */
+#define RTL8365MB_SDS_MISC_REG				0x1D11
+#define   =
RTL8365MB_SDS_MISC_SGMII_RXFC_MASK		0x4000
+#define   =
RTL8365MB_SDS_MISC_SGMII_TXFC_MASK		0x2000
+#define   =
RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK	0x0800
+#define   =
RTL8365MB_SDS_MISC_SGMII_FDUP_MASK		0x0400
+#define   =
RTL8365MB_SDS_MISC_SGMII_LINK_MASK		0x0200
+#define   =
RTL8365MB_SDS_MISC_SGMII_SPD_MASK		0x0180
+#define   =
RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	0x0040
+
+/* SerDes internal =
registers, accessed via the SDS_INDACS registers. The BMCR
+ * data path reset holds BMCR_ANENABLE | BMCR_ISOLATE while toggling the
+ * vendor-specific low bits from phase 1 to phase 2, which triggers a data=
 path
+ * reset and PLL resync.
+ */
+#define RTL8365MB_SDS_REG_BMCR			=
0x0000
+#define   RTL8365MB_SDS_BMCR_DPRST_PHASE1	(BMCR_ANENABLE | =
BMCR_ISOLATE | 0x1)
+#define   RTL8365MB_SDS_BMCR_DPRST_PHASE2	=
(BMCR_ANENABLE | BMCR_ISOLATE | 0x3)
+#define RTL8365MB_SDS_REG_NWAY			=
0x0002
+#define   RTL8365MB_SDS_NWAY_EN_MASK		0x0200
+#define   RTL8365MB_SDS_NWAY_RESTART_MASK	0x0100
+#define =
RTL8365MB_SDS_REG_RESET			0x0003
+#define   RTL8365MB_SDS_RESET_DEASSERT		=
0x7106
+#define RTL8365MB_SDS_REG_LINK_STATUS		0x003d
+#define   RTL8365MB_SDS_LINK_STATUS_LINK_MASK	0x0010
+
+/* The embedded SerDes can only be muxed to external interface 1 (MAC8),
+ * which is port 6.
+ */
+#define RTL8365MB_SDS_EXT_INTERFACE_ID		1
+#define RTL8365MB_SDS_EXT_INTERFACE_PORT	6
+
+/* Line rate bypass bit for =
the SerDes external interface */
+#define RTL8365MB_SDS_BYPASS_LINE_RATE_MA=
SK \
+	RTL8365MB_BYPASS_LINE_RATE_MASK(RTL8365MB_SDS_EXT_INTERFACE_PORT)
+
+/* SerDes tuning parameter variant selector. The vendor driver picks =
between
+ * two sets of SerDes tuning parameters based on this chip option.=
 Reading it
+ * requires first arming the read by writing a magic key to =
the arm register,
+ * then disarming it afterwards.
+ */
+#define RTL8365MB_SDS_OPTION_ARM_REG		0x13C0
+#define   =
RTL8365MB_SDS_OPTION_ARM_KEY		0x0249
+#define RTL8365MB_SDS_OPTION_REG		=
0x13C1
+
+/* Embedded DW8051 microcontroller control registers. The =
microcontroller
+ * can run firmware to manage the SerDes link, but this =
driver keeps it in
+ * reset and disabled: phylink already performs the =
link management that
+ * the firmware would otherwise do.
+ */
+#define RTL8365MB_MISC_CFG0_REG			0x130C
+#define   =
RTL8365MB_MISC_CFG0_DW8051_EN_MASK	0x0020
+
 /* External interface port =
speed values - used in DIGITAL_INTERFACE_FORCE */
 #define =
RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
@@ -551,6 +625,18 @@ static const struct rtl8365mb_jam_tbl_entry =
rtl8365mb_init_jam_common[] =3D {
 	{ 0x1D32, 0x0002 },
 };
=20
+/* SGMII SerDes tuning parameters, lifted from the vendor driver sources. =
The
+ * vendor driver keeps two variants of this table and selects between =
them
+ * based on the chip option register; these are the values for a =
non-zero
+ * option, which is what RTL8367S parts seen so far report. See
+ * rtl8365mb_sds_probe_option().
+ */
+static const struct =
rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_sgmii[] =3D {
+	{ 0x0480, 0x04D7 }, { 0x0481, 0xF994 }, { 0x0482, 0x2420 },
+	{ 0x0483, 0x6960 }, { 0x0484, 0x9728 }, { 0x0423, 0x9D85 },
+	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
+};
+
 enum =
rtl8365mb_phy_interface_mode {
 	RTL8365MB_PHY_INTERFACE_MODE_INVAL =3D 0,
 	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL =3D BIT(0),
@@ -730,6 +816,9 @@ struct rtl8365mb_port {
  * @cpu: CPU tagging and CPU =
port configuration for this chip
  * @mib_lock: prevent concurrent reads of=
 MIB counters
  * @ports: per-port data
+ * @pcs: PCS for the SerDes =
external interface
+ * @sds_supported: SerDes tuning parameters match the =
chip option, so the
+ *                 SerDes interface modes can be =
advertised
  *
  * Private data for this driver.
  */
@@ -740,8 +829,12 @@ struct rtl8365mb {
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PO=
RTS];
+	struct phylink_pcs pcs;
+	bool sds_supported;
 };
=20
+#define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
+
 static int rtl8365mb_phy_poll_busy(struct realtek_priv *priv)
 {
 	u32 val;
@@ -1042,6 +1135,334 @@ static int rtl8365mb_ext_config_rgmii(st=
ruct realtek_priv *priv, int port,
 	return 0;
 }
=20
+static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 =
data)
+{
+	int ret;
+
+	ret =3D regmap_write(priv->map, =
RTL8365MB_SDS_INDACS_DATA_REG, data);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR_REG, addr);
+	if (ret)
+		return ret;
+
+	/* The SerDes indirect access engine =
completes the command within the
+	 * register write transaction, so there =
is no need to wait or poll for
+	 * completion before the next access, =
matching the vendor driver.
+	 */
+	return regmap_write(priv->map, =
RTL8365MB_SDS_INDACS_CMD_REG,
+			    RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+			    RTL8365MB_SDS_INDACS_CMD_WR_MASK);
+}
+
+static int =
rtl8365mb_sds_read(struct realtek_priv *priv, u16 addr, u16 *data)
+{
+	u32 val;
+	int ret;
+
+	ret =3D regmap_write(priv->map, =
RTL8365MB_SDS_INDACS_ADR_REG, addr);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
+			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK);
+	if (ret)
+		return ret;
+
+	/* Wait for the indirect read to complete: the engine clears the BUSY
+	 * bit once the data register holds the result.
+	 */
+	ret =3D regmap_read_poll_timeout(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
+				       val,
+				       !(val & RTL8365MB_SDS_INDACS_CMD_BUSY_MASK),
+				       10, 1000);
+	if (ret)
+		return ret;
+
+	ret =3D =
regmap_read(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, &val);
+	if (ret)
+		return ret;
+
+	*data =3D val;
+
+	return 0;
+}
+
+/* The vendor driver selects between two sets of SerDes tuning parameters =
based
+ * on the chip option register. Only the variant for a non-zero =
option has been
+ * tested on real hardware - the RTL8367S parts seen so =
far all report 1. The
+ * variant for option 0 uses different tuning values=
 that cannot be verified,
+ * so probe the option once at setup and only =
advertise the SerDes interface
+ * modes when the tuning parameters are =
known to match, so that an unsupported
+ * variant fails at phylink =
validation time rather than when configuring the
+ * link.
+ */
+static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
+{
+	struct rtl8365mb *mb =3D priv->chip_data;
+	const struct rtl8365mb_extint=
 *extint;
+	u32 option;
+	int ret;
+	int i;
+
+	/* Nothing to probe if no =
external interface is wired to the SerDes */
+	for (i =3D 0; i < =
RTL8365MB_MAX_NUM_EXTINTS; i++) {
+		extint =3D &mb->chip_info->extints[i];
+
+		if (extint->supported_interfaces &
+		    (RTL8365MB_PHY_INTERFACE_MOD=
E_SGMII |
+		     RTL8365MB_PHY_INTERFACE_MODE_HSGMII))
+			break;
+	}
+	if (i =3D=3D RTL8365MB_MAX_NUM_EXTINTS)
+		return 0;
+
+	ret =3D regmap_write(priv->map, RTL8365MB_SDS_OPTION_ARM_REG,
+			   RTL8365MB_SDS_OPTION_ARM_KEY);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read(priv->map, RTL8365MB_SDS_OPTION_REG, &option);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->map, =
RTL8365MB_SDS_OPTION_ARM_REG, 0);
+	if (ret)
+		return ret;
+
+	if (option =3D=3D 0) {
+		dev_warn(priv->dev,
+			 "unsupported SerDes =
tuning variant (chip option 0), disabling SerDes interface modes\n");
+		return 0;
+	}
+
+	mb->sds_supported =3D true;
+
+	return 0;
+}
+
+static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int =
neg_mode,
+				phy_interface_t interface,
+				const unsigned long =
*advertising,
+				bool permit_pause_to_mac)
+{
+	const int id =3D =
RTL8365MB_SDS_EXT_INTERFACE_ID;
+	struct rtl8365mb *mb =3D =
pcs_to_rtl8365mb(pcs);
+	struct realtek_priv *priv;
+	u16 val;
+	int ret;
+	int i;
+
+	priv =3D mb->priv;
+
+	/* Hold the embedded DW8051 =
microcontroller in reset and keep it
+	 * disabled. The vendor driver loads=
 firmware into it to manage the
+	 * SerDes link, but the firmware only =
duplicates work that phylink
+	 * already does: it polls the port status =
and forces the external
+	 * interface configuration in the very registers =
this driver manages.
+	 * Letting it run would race with phylink.
+	 */
+	ret =3D regmap_update_bits(priv->map, RTL8365MB_CHIP_RESET_REG,
+				 RTL8365MB_CHIP_RESET_DW8051_MASK,
+				 RTL8365MB_CHIP_RESET_DW8051_M=
ASK);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_update_bits(priv->map, =
RTL8365MB_MISC_CFG0_REG,
+				 RTL8365MB_MISC_CFG0_DW8051_EN_MASK, 0);
+	if (ret)
+		return ret;
+
+	/* The vendor driver clears the line rate =
bypass for all interface
+	 * modes except TMII.
+	 */
+	ret =3D regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
+				 RTL8365MB_SDS_BYPASS_LINE_RATE_MASK, 0);
+	if (ret)
+		return ret;
+
+	/* Tune the SerDes with vendor-prescribed parameters */
+	for (i =3D 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
+		ret =3D rtl8365mb_sds_write(priv,
+					  rtl8365mb_sds_jam_sgmii[i].reg=
,
+					  rtl8365mb_sds_jam_sgmii[i].val);
+		if (ret)
+			return ret;
+	}
+
+	/* Mux the SerDes to MAC8 in SGMII mode */
+	ret =3D =
regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
+				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
+					 =
RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
+				 RTL8365MB_SDS_MISC_MAC8_SEL_=
SGMII_MASK);
+	if (ret)
+		return ret;
+
+	val =3D RTL8365MB_EXT_PORT_MODE_=
SGMII
+	      << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
+	ret =3D regmap_update_bits(priv->map,
+				 RTL8365MB_DIGITAL_INTERFACE_S=
ELECT_REG(id),
+				 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
+				 val);
+	if (ret)
+		return ret;
+
+	/* Take the SerDes out of reset. =
The vendor driver does this only
+	 * after the SerDes mux and the =
interface mode are configured.
+	 */
+	ret =3D rtl8365mb_sds_write(priv, =
RTL8365MB_SDS_REG_RESET,
+				  RTL8365MB_SDS_RESET_DEASSERT);
+	if (ret)
+		return ret;
+
+	/* Reset the SerDes data path and resync its PLL, =
mirroring what the
+	 * vendor firmware does right after deasserting the =
SerDes reset.
+	 * This flushes the FIFOs and ensures a clean state for the=
 link,
+	 * preventing silent drops and CRC errors.
+	 */
+	ret =3D rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_BMCR,
+				  RTL8365MB_SDS_BMCR_DPRST_PHASE1);
+	if (ret)
+		return ret;
+
+	ret =3D rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_BMCR,
+				  RTL8365MB_SDS_BMCR_DPRST_PHASE2);
+	if (ret)
+		return ret;
+
+	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
+	 * forced from rtl8365mb_pcs_link_up() instead.
+	 */
+	ret =3D rtl8365mb_sds_read(priv, RTL8365MB_SDS_REG_NWAY, &val);
+	if (ret)
+		return ret;
+
+	val &=3D ~RTL8365MB_SDS_NWAY_EN_MASK;
+	val |=3D RTL8365MB_SDS_NWAY_RESTART_MASK;
+
+	return =
rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_NWAY, val);
+}
+
+static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
+{
+	return interface =3D=3D PHY_INTERFACE_MODE_SGMII;
+}
+
+static unsigned int rtl8365mb_pcs_inband_caps(struct phylink_pcs *pcs,
+					      phy_interface_t interface)
+{
+	/* In-band autonegotiation is =
not implemented; the link is always
+	 * forced. Report that to phylink so =
that it never selects an
+	 * in-band-enabled negotiation mode for this PCS=
.
+	 */
+	return LINK_INBAND_DISABLE;
+}
+
+static void =
rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
+				    unsigned int =
neg_mode,
+				    struct phylink_link_state *state)
+{
+	struct rtl8365mb *mb =3D pcs_to_rtl8365mb(pcs);
+	struct realtek_priv =
*priv =3D mb->priv;
+	u16 status;
+	u32 val;
+	int ret;
+
+	/* In-band autonegotiation is not implemented, so the link parameters are
+	 * forced from rtl8365mb_pcs_link_up(). The real link state must still be
+	 * read from the SerDes itself: the embedded DW8051 microcontroller that
+	 * the vendor firmware uses to poll the SerDes is kept disabled (see
+	 * rtl8365mb_pcs_config()), so the link status register can be read
+	 * directly through the SDS_INDACS window without racing the auto-poll.
+	 */
+	ret =3D rtl8365mb_sds_read(priv, RTL8365MB_SDS_REG_LINK_STATUS, =
&status);
+	if (ret) {
+		state->link =3D false;
+		return;
+	}
+
+	state->link =3D !!(status & RTL8365MB_SDS_LINK_STATUS_LINK_MASK);
+	state->an_complete =3D state->link;
+	if (!state->link)
+		return;
+
+	/* The speed and duplex are forced; read them back from the values
+	 * programmed into the SerDes MISC register.
+	 */
+	ret =3D regmap_read(priv->map, RTL8365MB_SDS_MISC_REG, &val);
+	if (ret) {
+		state->link =3D false;
+		return;
+	}
+
+	state->duplex =3D (val & RTL8365MB_SDS_MISC_SGMII_FDUP_MASK) ?
+				DUPLEX_FULL : DUPLEX_HALF;
+
+	switch (FIELD_GET(RTL8365MB_SDS_MISC_SG=
MII_SPD_MASK, val)) {
+	case RTL8365MB_PORT_SPEED_1000M:
+		state->speed =3D SPEED_1000;
+		break;
+	case RTL8365MB_PORT_SPEED_100M:
+		state->speed =3D SPEED_100;
+		break;
+	case RTL8365MB_PORT_SPEED_10M:
+		state->speed =3D SPEED_10;
+		break;
+	}
+}
+
+static void =
rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
+				  unsigned int neg_mode=
,
+				  phy_interface_t interface, int speed,
+				  int duplex)
+{
+	struct rtl8365mb *mb =3D pcs_to_rtl8365mb(pcs);
+	struct realtek_priv =
*priv =3D mb->priv;
+	u32 mask =3D RTL8365MB_SDS_MISC_SGMII_FDUP_MASK |
+		   RTL8365MB_SDS_MISC_SGMII_LINK_MASK |
+		   RTL8365MB_SDS_MISC_SGMII_S=
PD_MASK;
+	u32 val =3D RTL8365MB_SDS_MISC_SGMII_LINK_MASK;
+	u32 r_speed;
+	int ret;
+
+	if (speed =3D=3D SPEED_1000) {
+		r_speed =3D =
RTL8365MB_PORT_SPEED_1000M;
+	} else if (speed =3D=3D SPEED_100) {
+		r_speed =3D RTL8365MB_PORT_SPEED_100M;
+	} else if (speed =3D=3D =
SPEED_10) {
+		r_speed =3D RTL8365MB_PORT_SPEED_10M;
+	} else {
+		dev_err(priv->dev, "unsupported SerDes speed %s\n",
+			phy_speed_to_str(speed));
+		return;
+	}
+
+	val |=3D =
FIELD_PREP(RTL8365MB_SDS_MISC_SGMII_SPD_MASK, r_speed);
+
+	if (duplex =3D=3D DUPLEX_FULL)
+		val |=3D RTL8365MB_SDS_MISC_SGMII_FDUP_=
MASK;
+
+	/* pcs_link_up() carries no pause information, so the SerDes flow
+	 * control bits are programmed together with the MAC external interface
+	 * force from rtl8365mb_phylink_mac_link_up(), where the resolved pause
+	 * modes are known.
+	 */
+	ret =3D regmap_update_bits(priv->map, =
RTL8365MB_SDS_MISC_REG, mask, val);
+	if (ret) {
+		dev_err(priv->dev, =
"failed to force SerDes link: %pe\n",
+			ERR_PTR(ret));
+		return;
+	}
+}
+
+static const struct phylink_pcs_ops rtl8365mb_pcs_ops =3D {
+	.pcs_inband_caps =3D rtl8365mb_pcs_inband_caps,
+	.pcs_config =3D =
rtl8365mb_pcs_config,
+	.pcs_get_state =3D rtl8365mb_pcs_get_state,
+	.pcs_link_up =3D rtl8365mb_pcs_link_up,
+};
+
 static int =
rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 					  bool link, int speed, int duplex,
 					  bool tx_pause, bool =
rx_pause)
@@ -1118,6 +1539,8 @@ static void rtl8365mb_phylink_get_caps(stru=
ct dsa_switch *ds, int port,
 {
 	const struct rtl8365mb_extint *extint =3D
 		rtl8365mb_get_port_extint(ds->priv, port);
+	struct realtek_priv *priv =
=3D ds->priv;
+	struct rtl8365mb *mb =3D priv->chip_data;
=20
 	config->mac_capabilities =3D MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD;
@@ -1141,6 +1564,25 @@ static void =
rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
=20
 	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII)
 		phy_interface_set_rgmii(config->supported_interfaces);
+
+	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII &&
+	    mb->sds_supported)
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+}
+
+static struct phylink_pcs *
+rtl8365mb_phylink_mac_select_pcs(struct phylink_config *config,
+				 phy_interface_t interface)
+{
+	struct dsa_port *dp =3D =
dsa_phylink_to_port(config);
+	struct realtek_priv *priv =3D dp->ds->priv;
+	struct rtl8365mb *mb =3D priv->chip_data;
+
+	if (rtl8365mb_interface_is_=
serdes(interface))
+		return &mb->pcs;
+
+	return NULL;
 }
=20
 static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
@@ -1168,6 +1610,12 @@ static void rtl8365mb_phylink_mac_config(struct =
phylink_config *config,
 		return;
 	}
=20
+	/* SGMII is handled by the =
SerDes PCS, configured through the
+	 * phylink_pcs ops, so there is =
nothing to do here for it.
+	 */
+	if (rtl8365mb_interface_is_serdes(state-=
>interface))
+		return;
+
 	/* TODO: Implement MII and RMII modes, which =
the RTL8365MB-VC also
 	 * supports
 	 */
@@ -1188,7 +1636,13 @@ static =
void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 	p =3D &mb->ports[port];
 	cancel_delayed_work_sync(&p->mib_work);
=20
-	if (phy_interface_mode_is_rgmii(interface)) {
+	/* phylink has no =
pcs_link_down callback, so on the SerDes path only the
+	 * MAC external interface force is reset here. Clearing the MAC force is
+	 * enough to bring the link down; the SerDes keeps presenting its last
+	 * forced state until the next pcs_link_up() reprograms it.
+	 */
+	if (phy_interface_mode_is_rgmii(interface) ||
+	    =
rtl8365mb_interface_is_serdes(interface)) {
 		ret =3D =
rtl8365mb_ext_config_forcemode(priv, port, false, 0, 0,
 						     false, false);
 		if (ret)
@@ -1218,14 +1672,51 @@ static void =
rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 	p =3D &mb->ports[port];
 	schedule_delayed_work(&p->mib_work, 0);
=20
-	if (phy_interface_mode_is_rgmii(interface)) {
+	/* The SerDes forced link=
 state is programmed by the PCS in
+	 * rtl8365mb_pcs_link_up(); here only =
the MAC external interface force
+	 * is configured, for both RGMII and =
SerDes.
+	 */
+	if (phy_interface_mode_is_rgmii(interface) ||
+	    rtl8365mb_interface_is_serdes(interface)) {
 		ret =3D =
rtl8365mb_ext_config_forcemode(priv, port, true, speed,
 						     duplex, tx_pause,
 						     rx_pause);
-		if (ret)
+		if (ret) {
 			dev_err(priv->dev,
 				"failed to force mode on port %d:=
 %pe\n", port,
 				ERR_PTR(ret));
+			return;
+		}
+
+		/* The SerDes has its own pause enables; program them from
+		 * the resolved pause modes, as the vendor driver does when
+		 * forcing the link on a SerDes external interface. These
+		 * bits, not the MAC force pause bits, gate pause on the
+		 * SerDes external interface: flow control testing shows
+		 * that pause frames are only emitted with the SerDes TXFC
+		 * bit set, while the MAC force pause bits alone have no
+		 * effect on this port. This is done here rather than in
+		 * rtl8365mb_pcs_link_up() because pcs_link_up() carries no
+		 * pause information.
+		 */
+		if (rtl8365mb_interface_is_serdes(interf=
ace)) {
+			u32 val =3D 0;
+
+			if (tx_pause)
+				val |=3D =
RTL8365MB_SDS_MISC_SGMII_TXFC_MASK;
+			if (rx_pause)
+				val |=3D RTL8365MB_SDS_MISC_SGMII_RXFC_MASK;
+
+			ret =3D regmap_update_bits(priv->map,
+						 RTL8365MB_SDS_MISC_REG,
+						 RTL8365MB_SDS_MISC_SGMII_TXFC_MASK |
+							 =
RTL8365MB_SDS_MISC_SGMII_RXFC_MASK,
+						 val);
+			if (ret)
+				dev_err(priv->dev,
+					"failed to force SerDes pause modes on port =
%d: %pe\n",
+					port, ERR_PTR(ret));
+		}
=20
 		return;
 	}
@@ -2419,6 +2910,14 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	mb =3D priv->chip_data;
 	cpu =3D &mb->cpu;
=20
+	mb->pcs.ops =3D =
&rtl8365mb_pcs_ops;
+
+	/* The SerDes has no link interrupt wired up, so =
phylink must poll the
+	 * PCS for link changes when it tracks the link =
through pcs_get_state()
+	 * (in-band mode with autonegotiation disabled).
+	 */
+	mb->pcs.poll =3D true;
+
 	ret =3D rtl8365mb_reset_chip(priv);
 	if (ret) {
 		dev_err(priv->dev, "failed to reset chip: %pe\n",
@@ -2426,6 +2925,13 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_error;
 	}
=20
+	ret =3D rtl8365mb_sds_probe_option(priv);
+	if (ret) {
+		dev_err(priv->dev, "failed to probe SerDes chip option: =
%pe\n",
+			ERR_PTR(ret));
+		goto out_error;
+	}
+
 	/* Configure switch to vendor-defined initial state */
 	ret =3D rtl8365mb_switch_init(priv);
 	if (ret) {
@@ -2658,6 +3164,7 @@ static int rtl8365mb_detect(struct realtek_priv =
*priv)
 }
=20
 static const struct phylink_mac_ops rtl8365mb_phylink_mac_op=
s =3D {
+	.mac_select_pcs =3D rtl8365mb_phylink_mac_select_pcs,
 	.mac_config =3D rtl8365mb_phylink_mac_config,
 	.mac_link_down =3D =
rtl8365mb_phylink_mac_link_down,
 	.mac_link_up =3D =
rtl8365mb_phylink_mac_link_up,
--=20
2.55.0


