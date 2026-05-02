Return-Path: <netdev+bounces-283492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CZ2Mg+I9mkUWAIAu9opvQ
	(envelope-from <netdev+bounces-283492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 01:26:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769634B39E5
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 01:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A59E30131EE
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 23:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E88313535;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+IuxdTE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9B186A;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777764337; cv=none; b=eoBkygfKY80qseBue3x92PeFb4Nik0zz2Pc/a5sz7CBbsf02E44MIlnu3wscGG6cnUK2ylyJi8gQ1PSnNU+DzRirHhGFlWuRF8kUUkJB0mQb2B7HLnMT2JrQdlUNRsozmTcsdJo+GMut3dROIw89m04VtME3OF7RAkYk+7Ph4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777764337; c=relaxed/simple;
	bh=IpSw53TOh/n7IS6SsjWLenMx6OMEcXR4c08TD6yYtic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFDJNziuK6ul9RHxaai0bMxWBlBE8kCslaM7mFuPpALi4mBKoLbBL5ZTdFjhcSFr+E+F9yqESb/plmvaVzl2tlqvJ32QMg/60QPH5lCfEnnaNcD9DcmG9DECOkmaG9PrkMXEaIWBRhT5ygQ9/XZ9IGPN7uIbejN+Quctt3LWfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+IuxdTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A80C2BCB9;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777764337;
	bh=IpSw53TOh/n7IS6SsjWLenMx6OMEcXR4c08TD6yYtic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K+IuxdTEywD5QY+rQWZ5rG9iS5aAQ6JgK3t5rb4sav/TpCDyOFdDV4b6onzLb/Idl
	 BDJ9xb6qJSNKmIM6Px8Ovgx+5Ow7JE0/irGTH3dogSgZZ6jXlIZcscjvldymaLH2G/
	 NoK3c6twlqZxD8lHP+wOiWAFR7mQPRQ/qofaflsDlFkeH+TQlM68OV1zn7MbKYuqY6
	 jU71ze3g3B3B4fs7+ABaKcpgrNZ9/LIlmkzfw/Wn6wyJOZGQ5sy3jmDKTMmIrrnU/7
	 fbIbysvyrRDvn2RjnyTZFFePqGE+uoWeqKM4Y6WkBp21s+EWvocpxO8kk7m2ji+ZM3
	 8ltXg5r50D/9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176DBCD3426;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Sun, 03 May 2026 02:24:50 +0300
Subject: [PATCH net-next 1/5] net: ethernet: oa_tc6: Handle the OA TC6 SPI
 protected mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-adin1140-driver-v1-1-dd043cdd88f0@analog.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
In-Reply-To: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777764335; l=8778;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=smd/ALBtlVdeWdMQcAG2kvWHkVX9YyfLReANHzFrjYA=;
 b=NgfRGoWt8KE67G6lRWZb1Ea1QUW1DMXqpn2nuURz9Uy0/fttF0/WI/FJp0hgkjR6YkutURFiR
 o6O1K0tt6zoCj9ktDT1nEyqhWrapNUHQFKi69YfpTPE0z3TciutYAol
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Queue-Id: 769634B39E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283492-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]

From: Ciprian Regus <ciprian.regus@analog.com>

Implement the OA TC6 standard defined protected mode for control (register
access) transactions. In addition to the current register access formats
the oa_tc6 driver handles, 1's complement values of the data field
are included (by both the host and the MACPHY) in the SPI transfer frames.
This feature acts as an integrity check.

Control write transactions look like this:

          |<- 32 bits ->|<--- data_size --->|<- 32 bits ->|
    MOSI: | ctrl header | reg write data    | ignored     |
    MISO: | (discard)   | echoed ctrl hdr   | echoed data |

    data_size (LEN = number of registers to read in a sequence):
      Unprotected: 32 x (LEN + 1) bits
      Protected:   2 x 32 x (LEN + 1) bits

Control read transaction:

          |<- 32 bits ->|<--- 32 bits --> |<- data_size ->|
    MOSI: | ctrl header | ignored ...                     |
    MISO: | (discard)   | echoed ctrl hdr | reg read data |

    data_size (LEN = number of registers to read in a sequence):
      Unprotected: 32 x (LEN + 1) bits
      Protected:   2 x 32 x (LEN + 1) bits

Register data format ("reg write data" and "reg read data"):

    Unprotected:
      | W1 (normal) | W2 (normal) | ... | Wx (normal) |

    Protected:
    | W1 (normal) | W1 (complement) | ... | Wx (normal) | Wx (complement)|

The protected mode state can be read from the bit 5 of CONFIG0 (0x4)
register, and this setting is usually only configured during the
MACPHY's reset (depending on the device it can be done by setting the
state of a pin). We can read the protected mode configuration before any
other register access and since the SPI transfer is initially sized for an
unprotected read, the MACPHY's complement words are never clocked out
and no checking is required. The data transactions (Ethernet frames)
remain unchanged.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 drivers/net/ethernet/oa_tc6.c | 105 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 91a906a7918a..546ca652d974 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -24,6 +24,7 @@
 #define OA_TC6_REG_CONFIG0			0x0004
 #define CONFIG0_SYNC				BIT(15)
 #define CONFIG0_ZARFE_ENABLE			BIT(12)
+#define CONFIG0_PROTE				BIT(5)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
@@ -87,6 +88,7 @@
 #define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
 #define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
 
+#define OA_TC6_CTRL_PROT_REPLY_SIZE		4
 #define OA_TC6_CTRL_HEADER_SIZE			4
 #define OA_TC6_CTRL_REG_VALUE_SIZE		4
 #define OA_TC6_CTRL_IGNORED_SIZE		4
@@ -95,6 +97,13 @@
 						(OA_TC6_CTRL_MAX_REGISTERS *\
 						OA_TC6_CTRL_REG_VALUE_SIZE) +\
 						OA_TC6_CTRL_IGNORED_SIZE)
+
+#define OA_TC6_CTRL_SPI_BUF_PROT_SIZE		(OA_TC6_CTRL_HEADER_SIZE +\
+						(OA_TC6_CTRL_MAX_REGISTERS *\
+						(OA_TC6_CTRL_REG_VALUE_SIZE +\
+						 OA_TC6_CTRL_PROT_REPLY_SIZE)) +\
+						OA_TC6_CTRL_IGNORED_SIZE)
+
 #define OA_TC6_CHUNK_PAYLOAD_SIZE		64
 #define OA_TC6_DATA_HEADER_SIZE			4
 #define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
@@ -129,6 +138,7 @@ struct oa_tc6 {
 	u8 rx_chunks_available;
 	bool rx_buf_overflow;
 	bool int_flag;
+	bool prot_ctrl;
 };
 
 enum oa_tc6_header_type {
@@ -212,25 +222,36 @@ static void oa_tc6_update_ctrl_write_data(struct oa_tc6 *tc6, u32 value[],
 {
 	__be32 *tx_buf = tc6->spi_ctrl_tx_buf + OA_TC6_CTRL_HEADER_SIZE;
 
-	for (int i = 0; i < length; i++)
+	for (int i = 0; i < length; i++) {
 		*tx_buf++ = cpu_to_be32(value[i]);
+		if (tc6->prot_ctrl)
+			*tx_buf++ = cpu_to_be32(~value[i]);
+	}
 }
 
-static u16 oa_tc6_calculate_ctrl_buf_size(u8 length)
+static u16 oa_tc6_calculate_ctrl_buf_size(u8 length, bool ctrl_prot)
 {
+	u32 reply_size = OA_TC6_CTRL_REG_VALUE_SIZE;
+
+	if (ctrl_prot)
+		reply_size += OA_TC6_CTRL_PROT_REPLY_SIZE;
+
 	/* Control command consists 4 bytes header + 4 bytes register value for
-	 * each register + 4 bytes ignored value.
+	 * each register (+ 4 bytes for the register value complement in case
+	 * protected mode is used) + 4 bytes ignored value.
 	 */
-	return OA_TC6_CTRL_HEADER_SIZE + OA_TC6_CTRL_REG_VALUE_SIZE * length +
+	return OA_TC6_CTRL_HEADER_SIZE + reply_size * length +
 	       OA_TC6_CTRL_IGNORED_SIZE;
 }
 
 static void oa_tc6_prepare_ctrl_spi_buf(struct oa_tc6 *tc6, u32 address,
 					u32 value[], u8 length,
-					enum oa_tc6_register_op reg_op)
+					enum oa_tc6_register_op reg_op,
+					u16 buf_size)
 {
 	__be32 *tx_buf = tc6->spi_ctrl_tx_buf;
 
+	memset(tx_buf, 0, buf_size);
 	*tx_buf = oa_tc6_prepare_ctrl_header(address, length, reg_op);
 
 	if (reg_op == OA_TC6_CTRL_REG_WRITE)
@@ -253,10 +274,12 @@ static int oa_tc6_check_ctrl_write_reply(struct oa_tc6 *tc6, u8 size)
 	return 0;
 }
 
-static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
+static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 length)
 {
-	u32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE;
-	u32 *tx_buf = tc6->spi_ctrl_tx_buf;
+	__be32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE;
+	__be32 *tx_buf = tc6->spi_ctrl_tx_buf;
+	u32 complement;
+	u32 reply;
 
 	/* The echoed control read header must match with the one that was
 	 * transmitted.
@@ -264,6 +287,20 @@ static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
 	if (*tx_buf != *rx_buf)
 		return -EPROTO;
 
+	if (tc6->prot_ctrl) {
+		/* Skip past the echoed header to the value/complement pairs */
+		rx_buf += 1;
+		for (int i = 0; i < length; i++) {
+			reply = be32_to_cpu(rx_buf[0]);
+			complement = be32_to_cpu(rx_buf[1]);
+
+			if (complement != ~reply)
+				return -EPROTO;
+
+			rx_buf += 2;
+		}
+	}
+
 	return 0;
 }
 
@@ -273,8 +310,13 @@ static void oa_tc6_copy_ctrl_read_data(struct oa_tc6 *tc6, u32 value[],
 	__be32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE +
 			 OA_TC6_CTRL_HEADER_SIZE;
 
-	for (int i = 0; i < length; i++)
+	for (int i = 0; i < length; i++) {
 		value[i] = be32_to_cpu(*rx_buf++);
+
+		/* skip complement word */
+		if (tc6->prot_ctrl)
+			rx_buf++;
+	}
 }
 
 static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
@@ -283,10 +325,10 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
 	u16 size;
 	int ret;
 
-	/* Prepare control command and copy to SPI control buffer */
-	oa_tc6_prepare_ctrl_spi_buf(tc6, address, value, length, reg_op);
+	size = oa_tc6_calculate_ctrl_buf_size(length, tc6->prot_ctrl);
 
-	size = oa_tc6_calculate_ctrl_buf_size(length);
+	/* Prepare control command and copy to SPI control buffer */
+	oa_tc6_prepare_ctrl_spi_buf(tc6, address, value, length, reg_op, size);
 
 	/* Perform SPI transfer */
 	ret = oa_tc6_spi_transfer(tc6, OA_TC6_CTRL_HEADER, size);
@@ -301,7 +343,7 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
 		return oa_tc6_check_ctrl_write_reply(tc6, size);
 
 	/* Check echoed/received control read command reply for errors */
-	ret = oa_tc6_check_ctrl_read_reply(tc6, size);
+	ret = oa_tc6_check_ctrl_read_reply(tc6, length);
 	if (ret)
 		return ret;
 
@@ -1224,6 +1266,20 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_start_xmit);
 
+static int oa_tc6_check_ctrl_protection(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &regval);
+	if (ret)
+		return ret;
+
+	tc6->prot_ctrl = FIELD_GET(CONFIG0_PROTE, regval);
+
+	return 0;
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -1276,6 +1332,29 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	if (!tc6->spi_data_rx_buf)
 		return NULL;
 
+	ret = oa_tc6_check_ctrl_protection(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"Failed to check the protection mode: %d\n", ret);
+		return NULL;
+	}
+
+	if (tc6->prot_ctrl) {
+		tc6->spi_ctrl_tx_buf = devm_krealloc(&tc6->spi->dev,
+						     tc6->spi_ctrl_tx_buf,
+						     OA_TC6_CTRL_SPI_BUF_PROT_SIZE,
+						     GFP_KERNEL);
+		if (!tc6->spi_ctrl_tx_buf)
+			return NULL;
+
+		tc6->spi_ctrl_rx_buf = devm_krealloc(&tc6->spi->dev,
+						     tc6->spi_ctrl_rx_buf,
+						     OA_TC6_CTRL_SPI_BUF_PROT_SIZE,
+						     GFP_KERNEL);
+		if (!tc6->spi_ctrl_rx_buf)
+			return NULL;
+	}
+
 	ret = oa_tc6_sw_reset_macphy(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,

-- 
2.43.0



