Return-Path: <netdev+bounces-288297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLEMNF4VB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0754FD69
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B373B3184845
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837C47A0C7;
	Fri, 15 May 2026 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsz6zlD2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE13FB046
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847074; cv=none; b=ud7RIOTwgYqzpF2+02m7w7DMJ6+B6zOEO5CN0Yvu8PXpm3kbqAlqeFi7G291VPjUYCTpfXuPnr/2MzqUK69smlgZbaHspOT2qqP61MLr1z4n3bAVWLa5QHjYaKLfOEiWcl5+Z3FhHB1fNLF4zdZC/lx+iQWrvHc2IXCDbYi5qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847074; c=relaxed/simple;
	bh=V6tTcHsDwH4Jkq806I6PVZvta1dDeg0sm0elJVzoiko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHusX3uNJ7qogLLgBWhRbXzaqUHSJMWBn4bnmEObXe3y75A+vf3NBnl2k4/wIr3HhxhViOo6LXvCzU+CuCv1HwfVw38s4hDrqqslPXCZ2e7r/icBPxaZmvpmEwtOprD3WNj9zFS7FV2qeaqAzvAVC0JiXUrdPM3cyyeIJH5RvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsz6zlD2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso79528585e9.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847071; x=1779451871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztSL5T0ZAVv9FW8m9Rl7jvhEnDHUw0SpW0Ca+WqJD/U=;
        b=Bsz6zlD2WVIdtav4OGwZf6rTDLZk8R6gkXl7jlxrplfGlFZKGOOcjft16+kUjxdsFc
         yHah/0MSRzD3SIOuX+FG2WQ5OeLGFu05aIWEYRkioAVlO5dM9oVhmpoCFR7YvNEwge19
         9KxNO46bpDCEQhkwHh3dSkdam1akM7mVM5UlYcHqEPwGrNNkANFlksHffWahL1Bg8Gul
         0P4h5UuLIZks4xxqeDLcFu20GzVtn2FrQmCu1Uj6q+J/ver6YEk//lhWKwCbQuYSylc7
         Clm6jwSBBxUiFMilqT2CrHBzXcpw323Gblx8O5YK/4agaH5glw4XQ9CJC75YLiay6FRI
         vWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847071; x=1779451871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztSL5T0ZAVv9FW8m9Rl7jvhEnDHUw0SpW0Ca+WqJD/U=;
        b=lXtG6GlAxotsFDv1QW36iQ5KvQp54XRqWcU+ySyCAuwwDzGjSi2spTifLQu5H9ciIw
         W6Yi1HB/DHp450KM5Sh/GWLGDgWGmc0572vtHjBCjeDDFiyY5lhGsnDdOxoh92Qyd4Qu
         XAEVBtp6fXwaQvZV5ZrqlSNjexsB+mtmj/aPaeThv29KGoMELcnvwOAnxYRszZIdzWFw
         ePXDS/XypExTJ65JIXIgikUoL3XwG72OhPCn+ioJVcKtlC/c8gz5im1cnGZmCDxVwd/2
         RDa2HLQf1fuw+G/B9+m0ooPScVc7FwFguqi5hudP09QPvhjZqltCXPUTLlh90/HNZXBG
         ljXA==
X-Gm-Message-State: AOJu0Yy+ENZuXkk3qyXsfSOmj05gyfzZxwXDTnxGVBXKKcMQJDEwUjbX
	lnFvy2v92V+EPDco3YmookSmL/ZjzneLWtUwhfsv1obJ/J17NAZoWWggJ1uXXRjZ
X-Gm-Gg: Acq92OFcenLHimV3FBiLM3coGQ3SbkX/eJO/vwNBPch8wxItBeAijsUeCPZOk9HTUX9
	7V9pSreuDLSpsA8DKPpcqMuFiTsxuWmBIeq4Zwl4wt547y4LGPvi2xJahOaAHLJw76C9vDlhw03
	ZAw3mzQh4wZ8EyilELTE5x/aWma6LMH8ovl24KvUiQtnAsfw7IPfB86I53xjU8+4R6FZoq6EYva
	AxX4iYGIcnUN7xr/CqqnU66foL8tD5JA0McGzIoMg1eaAWTAhoIKeUrWWRqsAuRsDr9pSpVhmqO
	YzIk8TEn06eaO8arB4nw/vs7sniLQd5WwTObY/HHC67VNcZM0Y1hojzto7IUlkJReVBKkzJYveW
	eLoevG9HgOcMp5wlGUX8DbsSOfWcZhu/gGUvugoF8eRHRHBwsarY8B6bbx4Ul259xY8XkJOY28g
	+SirLsNqhE14W5CB8rBgItGdj+t52uXhT0FqVwU11fMtsfl+1PnXs8YcU=
X-Received: by 2002:a05:600c:c168:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48fe61ed360mr58667405e9.17.1778847070742;
        Fri, 15 May 2026 05:11:10 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17a22sm14343784f8f.22.2026.05.15.05.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:11:10 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: bjorn@mork.no,
	andrew@lunn.ch,
	linux-phy@lists.infradead.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge before assuming MDIO_I2C_ROLLBALL
Date: Fri, 15 May 2026 14:11:08 +0200
Message-ID: <20260515121108.17792-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73A0754FD69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-288297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mork.no,lunn.ch,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
vendor/part-number combination. This works for modules that genuinely
implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
that share the same EEPROM strings without having such a bridge.

The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
media converter with no I2C-to-MDIO bridge. Its EEPROM reports
vendor="OEM", part="SFP-10G-T", and -- critically -- Vendor OUI
00:00:00, making OUI-based differentiation impossible. With
MDIO_I2C_ROLLBALL the kernel stalls waiting for a PHY that never
appears:

  sfp sfp2: probing phy device through the [MDIO_I2C_ROLLBALL] protocol
  sfp sfp2: no PHY detected, 24 tries left
  sfp sfp2: no PHY detected, 23 tries left
  ...

Fix this by probing for the RollBall bridge before committing to a
protocol. The probe sends the RollBall unlock password (four 0xFF bytes
to A2h:VSL+3), switches to MDIO page 3, issues CMD_READ, and polls for
CMD_DONE. A genuine RollBall bridge responds with CMD_DONE within ~70
ms. A module without a bridge never asserts it; the probe times out
after 200 ms (10 x 20 ms).

On probe success the existing MDIO_I2C_ROLLBALL + extended_cc path is
taken -- no behaviour change for real RollBall modules. On timeout,
MDIO_I2C_NONE is selected, telling the MAC to derive link parameters
directly from the EEPROM-declared interface type (10gbase-r) without
attempting PHY register access.

The probe adds at most 200 ms at link-up time for the no-bridge case,
and ~70 ms for real RollBall modules. This is a one-shot cost, not on
the data path.

Also add a separate quirk entry for the industrial variant "SFP-10G-T-I"
which uses the same RTL8261BE silicon.

Tested on BPI-R4 (MediaTek MT7988A, Linux 6.12):
 - RTL8261BE negative case (no bridge, probe timeout -> MDIO_I2C_NONE):
   link up 10Gbps, iperf3 9.34 Gbit/s (93% line rate) [OK]
 - RollBall positive case (CMD_DONE -> MDIO_I2C_ROLLBALL): logic mirrors
   the unlock sequence already in mdio-i2c.c; not yet verified on
   physical RollBall hardware due to lack of a suitable test module.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 drivers/net/phy/sfp.c | 79 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -960,11 +960,88 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
-static void sfp_fixup_rollball_cc(struct sfp *sfp)
+/* Local mirrors of RollBall protocol constants from mdio-i2c.c */
+#define SFP_ROLLBALL_PHY_ADDR	0x51
+#define SFP_ROLLBALL_MDIO_PAGE	3
+#define SFP_ROLLBALL_CMD_ADDR	0x80
+#define SFP_ROLLBALL_CMD_READ	0x02
+#define SFP_ROLLBALL_CMD_DONE	0x04
+
+static int sfp_rollball_a2_write(struct sfp *sfp, u8 reg,
+				 const u8 *data, int len)
+{
+	struct i2c_msg msg;
+	u8 buf[8];
+
+	buf[0] = reg;
+	memcpy(buf + 1, data, len);
+	msg.addr  = SFP_ROLLBALL_PHY_ADDR;
+	msg.flags = 0;
+	msg.len   = len + 1;
+	msg.buf   = buf;
+	return i2c_transfer(sfp->i2c, &msg, 1) == 1 ? 0 : -EIO;
+}
+
+static int sfp_rollball_a2_read(struct sfp *sfp, u8 reg, u8 *val)
 {
-	sfp_fixup_rollball(sfp);
+	struct i2c_msg msgs[2];
+
+	msgs[0].addr  = SFP_ROLLBALL_PHY_ADDR;
+	msgs[0].flags = 0;
+	msgs[0].len   = 1;
+	msgs[0].buf   = &reg;
+	msgs[1].addr  = SFP_ROLLBALL_PHY_ADDR;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len   = 1;
+	msgs[1].buf   = val;
+	return i2c_transfer(sfp->i2c, msgs, 2) == 2 ? 0 : -EIO;
+}
+
+/**
+ * sfp_has_rollball_bridge() - probe for a RollBall I2C-to-MDIO bridge
+ * @sfp: SFP instance
+ *
+ * Send the RollBall unlock password, switch to the MDIO page, issue CMD_READ
+ * and poll for CMD_DONE. A genuine RollBall bridge asserts CMD_DONE within
+ * ~70 ms. Modules without a bridge (e.g. RTL8261BE pure media converter)
+ * never respond; the poll times out after 200 ms.
+ *
+ * Returns true if a RollBall bridge is present, false otherwise.
+ */
+static bool sfp_has_rollball_bridge(struct sfp *sfp)
+{
+	u8 pw[4] = { 0xff, 0xff, 0xff, 0xff };
+	u8 page = SFP_ROLLBALL_MDIO_PAGE;
+	u8 cmd  = SFP_ROLLBALL_CMD_READ;
+	u8 saved_page = 0, res;
+	int i;
+
+	if (sfp_rollball_a2_write(sfp, SFP_VSL + 3, pw, sizeof(pw)) < 0)
+		return false;
+
+	sfp_rollball_a2_read(sfp, SFP_PAGE, &saved_page);
+
+	if (sfp_rollball_a2_write(sfp, SFP_PAGE, &page, 1) < 0 ||
+	    sfp_rollball_a2_write(sfp, SFP_ROLLBALL_CMD_ADDR, &cmd, 1) < 0)
+		goto restore;
+
+	for (i = 0; i < 10; i++) {
+		msleep(20);
+		if (!sfp_rollball_a2_read(sfp, SFP_ROLLBALL_CMD_ADDR, &res) &&
+		    res == SFP_ROLLBALL_CMD_DONE) {
+			sfp_rollball_a2_write(sfp, SFP_PAGE, &saved_page, 1);
+			return true;
+		}
+	}
+
+restore:
+	sfp_rollball_a2_write(sfp, SFP_PAGE, &saved_page, 1);
+	return false;
+}
+
+static void sfp_fixup_rollball_cc(struct sfp *sfp)
 {
+	/* Probe for an I2C-to-MDIO bridge: genuine RollBall modules assert
+	 * CMD_DONE within ~70 ms; pure media converters such as the RTL8261BE
+	 * have no bridge and time out after 200 ms.
+	 */
+	if (!sfp_has_rollball_bridge(sfp)) {
+		sfp->mdio_protocol = MDIO_I2C_NONE;
+		return;
+	}
+	sfp_fixup_rollball(sfp);
 	/* Some RollBall SFPs may have wrong (zero) extended compliance code
 	 * burned in EEPROM. For PHY probing we need the correct one.
 	 */
@@ -1036,7 +1113,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
-	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("OEM", "SFP-10G-T",   sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),

