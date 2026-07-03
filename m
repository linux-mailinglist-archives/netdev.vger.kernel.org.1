Return-Path: <netdev+bounces-304431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C1u4IKxqR2rvXwAAu9opvQ
	(envelope-from <netdev+bounces-304431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B8A6FFC71
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:54:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=W5vwThmt;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304431-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304431-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52D4630DFD18
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFD37206B;
	Fri,  3 Jul 2026 07:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708537204D;
	Fri,  3 Jul 2026 07:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064851; cv=none; b=pOFCwmJ6onOU9QEtlw04bQowGXCQrA0jtBe/rzMKICCjRe2BIAgfW4DT8erSZ30P8q94O1+SqkTa/Ss+coKmvP0CZ0aQRKCrm3px1FWCQMM9sfjU+ipmN2KbbMYApjHfFkdYQUgV719BaSm3tGTTMEC0H0b577KrSARfDIox2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064851; c=relaxed/simple;
	bh=FUUr2yWy/5iE7TcJjVKBa6vDGofl68brxZYutgbmlY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKu38R+pQmQtKU5mKY0p8TODGB9Oh+3ZAQNtwuKN35IAySmIoeJBe64pgb724Y1iPHVyUn1aPx+VzCebfUrfGA5xpoKAwGEu/cD/w5CSD3EbE3DxAcGJhqndLUsK3euAdW2VuJRpHH7mWOBdHgKZoGX8Nrm79W6uCb6fLxiD9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=W5vwThmt; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 666EB60C0B;
	Fri,  3 Jul 2026 03:47:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064848; bh=nAto9NeW/C7cC6BuVyUDlRw1a0zYBlv45XNij2/SW4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W5vwThmtWr4av/COwzfz0DpV7bOY95nkOTxNNe7HzBnwdIgH/o3MY/wNWeiBwbnQ9
	 UvyBLsyxOntv+PRBjzFyda39BvXki98ycCvmKEKBcuW994EHpy52Ol2nIuvSIeGeUs
	 E5n1sMFspium1bPK0XK5dele0Sz6YuSDmtE53wweAe9DGLUXhi338f0X0wrHpTDkSn
	 d4GuRZnBdz6ogQbTee8sborY0JCKidXvp082Hl+ToqqRp/7RV5CAmTAiAp+ya0Xi8T
	 /EL8sYPahJYBRSKXLeNJu7FbflBbHe97nFYrwSQaC7pgHRF+ugyDlloyMbxGpUa1Mz
	 wOc0NwyWp8ATQ==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:44 +1000
Subject: [PATCH net-next 10/17] net: dsa: mv88e6xxx: Add RMU register
 read/write/wait for bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-10-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=10232;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=Pm/fXqqy8wqnHkkTnljAXo8pCLKze8EfU3O+1Za1M/8=;
 b=n2iQ5FLzl77mtGNf0BexD0cWN8jhOulqjqIlbVmTdPP6V9E6S2HXMIENWRfXHbzu12hW2peet
 6A9jQpmcoGgCLP+TD4xZTgeCQKLA6yynMUoWEjx+7M3osc0r71Dci/h
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304431-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0B8A6FFC71

From: Andrew Lunn <andrew@lunn.ch>

Add support for reading a register, writing a register, and waiting
for a bit in a register to change, via the remote management unit.

If the RMU is not enabled, return -EOPNOTSUPP, and fall back to MDIO.
Additionally, if the operation times out, fall back to MDIO. Other
errors, such as protocol errors are however reported, rather than
falling back to MDIO.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    |  18 +++--
 drivers/net/dsa/mv88e6xxx/global2.c |   1 +
 drivers/net/dsa/mv88e6xxx/rmu.c     | 139 ++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/rmu.h     |  54 +++++++++++++-
 4 files changed, 207 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 88cc2326ecc0c..6431d25f3cfa2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -65,7 +65,9 @@ int mv88e6xxx_read(struct mv88e6xxx_chip *chip, int addr, int reg, u16 *val)
 
 	assert_reg_lock(chip);
 
-	err = mv88e6xxx_smi_read(chip, addr, reg, val);
+	err = mv88e6xxx_rmu_read(chip, addr, reg, val);
+	if (mv88e6xxx_rmu_can_mdio_fallback(chip, err))
+		err = mv88e6xxx_smi_read(chip, addr, reg, val);
 	if (err)
 		return err;
 
@@ -81,7 +83,9 @@ int mv88e6xxx_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val)
 
 	assert_reg_lock(chip);
 
-	err = mv88e6xxx_smi_write(chip, addr, reg, val);
+	err = mv88e6xxx_rmu_write(chip, addr, reg, val);
+	if (mv88e6xxx_rmu_can_mdio_fallback(chip, err))
+		err = mv88e6xxx_smi_write(chip, addr, reg, val);
 	if (err)
 		return err;
 
@@ -131,8 +135,14 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 int mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
 		       int bit, int val)
 {
-	return mv88e6xxx_wait_mask(chip, addr, reg, BIT(bit),
-				   val ? BIT(bit) : 0x0000);
+	int err;
+
+	err = mv88e6xxx_rmu_wait_bit(chip, addr, reg, bit, val);
+
+	if (mv88e6xxx_rmu_can_mdio_fallback(chip, err))
+		err = mv88e6xxx_wait_mask(chip, addr, reg, BIT(bit),
+					  val ? BIT(bit) : 0x0000);
+	return err;
 }
 
 struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 30a6ffa7817b0..834fdb3503f1c 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -855,6 +855,7 @@ static void mv88e6097_watchdog_free(struct mv88e6xxx_chip *chip)
 static int mv88e6097_watchdog_setup(struct mv88e6xxx_chip *chip)
 {
 	return mv88e6xxx_g2_write(chip, MV88E6352_G2_WDOG_CTL,
+				  MV88E6352_G2_WDOG_CTL_RMU_TIMEOUT |
 				  MV88E6352_G2_WDOG_CTL_EGRESS_ENABLE |
 				  MV88E6352_G2_WDOG_CTL_QC_ENABLE |
 				  MV88E6352_G2_WDOG_CTL_SWRESET);
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index 65e6bcf4ca938..03c6f47814c85 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -105,6 +105,145 @@ static int mv88e6xxx_rmu_request(struct mv88e6xxx_chip *chip,
 				  resp, resp_len, timeout_ms);
 }
 
+int mv88e6xxx_rmu_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val)
+{
+	__be16 req[] = {
+		MV88E6XXX_RMU_REQ_FORMAT_SOHO,
+		MV88E6XXX_RMU_REQ_PAD,
+		MV88E6XXX_RMU_REQ_CODE_REG_RW,
+		MV88E6XXX_RMU_REQ_RW_0_WRITE(addr, reg),
+		htons(val),
+		MV88E6XXX_RMU_REQ_RW_0_END,
+		MV88E6XXX_RMU_REQ_RW_1_END,
+	};
+	struct mv88e6xxx_rmu_header resp;
+	int resp_len;
+	int ret = -1;
+
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+		return -EOPNOTSUPP;
+
+	resp_len = sizeof(resp);
+	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
+				    &resp, resp_len,
+				    MV88E6XXX_RMU_REQUEST_TIMEOUT_MS);
+	if (ret < 0) {
+		dev_dbg(chip->dev, "RMU: error for command REQ_RW:WRITE %pe addr %d reg %d val %04x\n",
+			ERR_PTR(ret), addr, reg, val);
+		return ret;
+	}
+
+	if (ret < resp_len) {
+		dev_err(chip->dev, "RMU: write returned wrong length: rx %d expecting %d\n",
+			ret, resp_len);
+		return -EPROTO;
+	}
+
+	if (resp.code != MV88E6XXX_RMU_RESP_CODE_REG_RW) {
+		dev_err(chip->dev, "RMU: write returned wrong code %d\n",
+			be16_to_cpu(resp.code));
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+int mv88e6xxx_rmu_read(struct mv88e6xxx_chip *chip, int addr, int reg,
+		       u16 *val)
+{
+	__be16 req[] = {
+		MV88E6XXX_RMU_REQ_FORMAT_SOHO,
+		MV88E6XXX_RMU_REQ_PAD,
+		MV88E6XXX_RMU_REQ_CODE_REG_RW,
+		MV88E6XXX_RMU_REQ_RW_0_READ(addr, reg),
+		0,
+		MV88E6XXX_RMU_REQ_RW_0_END,
+		MV88E6XXX_RMU_REQ_RW_1_END,
+	};
+	struct mv88e6xxx_rmu_rw_resp resp;
+	int resp_len;
+	int ret = -1;
+
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+		return -EOPNOTSUPP;
+
+	resp_len = sizeof(resp);
+	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
+				    &resp, resp_len,
+				    MV88E6XXX_RMU_REQUEST_TIMEOUT_MS);
+	if (ret < 0) {
+		dev_dbg(chip->dev, "RMU: error for command REQ_RW:READ %pe addr %d reg %d\n",
+			ERR_PTR(ret), addr, reg);
+		return ret;
+	}
+
+	if (ret < resp_len) {
+		dev_err(chip->dev, "RMU: read returned wrong length: rx %d expecting %d\n",
+			ret, resp_len);
+		return -EPROTO;
+	}
+
+	if (resp.rmu_header.code != MV88E6XXX_RMU_RESP_CODE_REG_RW) {
+		dev_err(chip->dev, "RMU: read returned wrong code %d\n",
+			be16_to_cpu(resp.rmu_header.code));
+		return -EPROTO;
+	}
+
+	*val = ntohs(resp.value);
+
+	return 0;
+}
+
+int mv88e6xxx_rmu_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
+			   int bit, int val)
+{
+	__be16 req[] = {
+		MV88E6XXX_RMU_REQ_FORMAT_SOHO,
+		MV88E6XXX_RMU_REQ_PAD,
+		MV88E6XXX_RMU_REQ_CODE_REG_RW,
+		val ? MV88E6XXX_RMU_REQ_RW_0_WAIT_1(addr, reg) :
+		MV88E6XXX_RMU_REQ_RW_0_WAIT_0(addr, reg),
+		htons((bit & 0xf) << 8),
+		MV88E6XXX_RMU_REQ_RW_0_END,
+		MV88E6XXX_RMU_REQ_RW_1_END,
+	};
+	struct mv88e6xxx_rmu_rw_resp resp;
+	int resp_len;
+	int ret = -1;
+
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+		return -EOPNOTSUPP;
+
+	resp_len = sizeof(resp);
+	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
+				    &resp, resp_len,
+				    MV88E6XXX_RMU_WAIT_BIT_TIMEOUT_MS);
+	if (ret < 0) {
+		dev_dbg(chip->dev, "RMU: error for command REQ_RW:WAIT %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	if (ret < resp_len) {
+		dev_err(chip->dev, "RMU: wait on bit returned wrong length: rx %d expecting %d\n",
+			ret, resp_len);
+		return -EPROTO;
+	}
+
+	if (resp.rmu_header.code != MV88E6XXX_RMU_RESP_CODE_REG_RW) {
+		dev_err(chip->dev, "RMU: wait on bit returned wrong code %d\n",
+			be16_to_cpu(resp.rmu_header.code));
+		return -EPROTO;
+	}
+
+	if ((ntohs(resp.value) & 0xff) == 0xff) {
+		dev_err(chip->dev, "RMU: wait on bit timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int mv88e6xxx_rmu_get_id(struct mv88e6xxx_chip *chip)
 {
 	const __be16 req[4] = {
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
index a81af5a1ad762..4b9df3119d517 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.h
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -11,17 +11,45 @@
 
 #define MV88E6XXX_RMU_WAIT_TIME_MS		20
 #define MV88E6XXX_RMU_REQUEST_TIMEOUT_MS	50
+#define MV88E6XXX_RMU_WAIT_BIT_TIMEOUT_MS	1000
 
 #define MV88E6XXX_RMU_REQ_FORMAT_GET_ID		htons(0x0000)
 #define MV88E6XXX_RMU_REQ_FORMAT_SOHO		htons(0x0001)
 #define MV88E6XXX_RMU_REQ_PAD			htons(0x0000)
 #define MV88E6XXX_RMU_REQ_CODE_GET_ID		htons(0x0000)
+#define MV88E6XXX_RMU_REQ_CODE_REG_RW		htons(0x2000)
 #define MV88E6XXX_RMU_REQ_DATA			htons(0x0000)
 
+#define MV88E6XXX_RMU_REQ_RW_0_OP_WAIT_1	(0x7 << 10)
+#define MV88E6XXX_RMU_REQ_RW_0_OP_WAIT_0	(0x4 << 10)
+#define MV88E6XXX_RMU_REQ_RW_0_OP_READ		(0x2 << 10)
+#define MV88E6XXX_RMU_REQ_RW_0_OP_WRITE		(0x1 << 10)
+
+#define MV88E6XXX_RMU_REQ_RW_0_READ(_addr_, _reg_)		 \
+	htons(MV88E6XXX_RMU_REQ_RW_0_OP_READ |			 \
+	      ((_addr_) << 5) |					 \
+	      (_reg_))
+#define MV88E6XXX_RMU_REQ_RW_0_WRITE(_addr_, _reg_)		 \
+	htons(MV88E6XXX_RMU_REQ_RW_0_OP_WRITE |			 \
+	      ((_addr_) << 5) |					 \
+	      (_reg_))
+
+#define MV88E6XXX_RMU_REQ_RW_0_WAIT_0(_addr_, _reg_)		   \
+	htons(MV88E6XXX_RMU_REQ_RW_0_OP_WAIT_0 |		   \
+	      ((_addr_) << 5) |					   \
+	      (_reg_))
+#define MV88E6XXX_RMU_REQ_RW_0_WAIT_1(_addr_, _reg_)		   \
+	htons(MV88E6XXX_RMU_REQ_RW_0_OP_WAIT_1 |		   \
+	      ((_addr_) << 5) |					   \
+	      (_reg_))
+
+#define MV88E6XXX_RMU_REQ_RW_0_END		htons(0xffff)
+#define MV88E6XXX_RMU_REQ_RW_1_END		htons(0xffff)
+
 #define MV88E6XXX_RMU_RESP_FORMAT_1		htons(0x0001)
 #define MV88E6XXX_RMU_RESP_FORMAT_2		htons(0x0002)
-
 #define MV88E6XXX_RMU_RESP_CODE_GOT_ID		htons(0x0000)
+#define MV88E6XXX_RMU_RESP_CODE_REG_RW		htons(0x2000)
 
 struct mv88e6xxx_rmu_header {
 	__be16 format;
@@ -29,10 +57,34 @@ struct mv88e6xxx_rmu_header {
 	__be16 code;
 } __packed;
 
+struct mv88e6xxx_rmu_rw_resp {
+	struct mv88e6xxx_rmu_header rmu_header;
+	__be16 cmd;
+	__be16 value;
+	__be16 end0;
+	__be16 end1;
+} __packed;
+
+int mv88e6xxx_rmu_write(struct mv88e6xxx_chip *chip, int addr, int reg,
+			u16 val);
+int mv88e6xxx_rmu_read(struct mv88e6xxx_chip *chip, int addr, int reg,
+		       u16 *val);
+int mv88e6xxx_rmu_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
+			   int bit, int val);
 void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 					const struct net_device *conduit,
 					bool operational);
 void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
 				     struct sk_buff *skb,
 				     u8 seqno);
+
+/* RMU register access falls back to MDIO when the operation is unsupported or
+ * times out. @chip is unused today, but threading it through here lets a future
+ * RMU-only mode suppress the fallback without touching any of the call sites.
+ */
+static inline bool
+mv88e6xxx_rmu_can_mdio_fallback(struct mv88e6xxx_chip *chip, int err)
+{
+	return err == -EOPNOTSUPP || err == -ETIMEDOUT;
+}
 #endif /* _MV88E6XXX_RMU_H_ */

-- 
2.43.0


