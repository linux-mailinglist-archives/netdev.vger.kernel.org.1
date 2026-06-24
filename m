Return-Path: <netdev+bounces-301579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tHPWOPiZO2raaAgAu9opvQ
	(envelope-from <netdev+bounces-301579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:48:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1B6BCAC6
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:48:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=atCz2+Qs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301579-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301579-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09EBE303E60A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149DE39A803;
	Wed, 24 Jun 2026 08:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80288399361
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:48:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290903; cv=none; b=hPNdfCeWaqDqDhyqxedbeNTJd54t2pDEIEz626OeWZvsQ2M2g+FEJwiimjd9upbkOmugMd8eezM6WK6P0kIaaTRGH0rJum+rIJ+rOUdNOqtD4Ft2iTisZARNa5Nb06X83E0TaHobpsqiqG3sCFzgBvJCEhMynQr4Ns7fIR40nBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290903; c=relaxed/simple;
	bh=+hoPTClDOAlZNJW9xpaeflSfBReQ8xVFXvz4c5aX2Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPpuUzl+5/8MJbAlbcVieQFH8ef1DPcwbN3AP0EWHDohTIq7v7hRa39D0cwqzohiCudFMpobe51RoKDodcTDOi3V+WY+pWPFJS6wI/QnUB29+7zaSplmpBRrceYxC67GejmgVn/pgrWYO9yNibMd35Pk62Aw2pgBGitVEvAI4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atCz2+Qs; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46255b269c2so524601f8f.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290900; x=1782895700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB90+YCUH0dV66aMdsIbPcNB77SkXK4CkRD/ocilleU=;
        b=atCz2+QsEVVT05ZxkH2od0pNzOmGvAEh60yow7kAluneXemZ2jGQUlUaPrV0mIZVJZ
         0C3SZp9ouc7wpb+TQH+ggVAlD1LlLjzBk+v1gCu1HSvvtnYjp5qtDt8S0tgucBzdQQuo
         TVXxbJkghUNPDOKBj1Mf7K16JGkjMY34+fV+wjHzcbZB1mbVv8RzUKOzpzb3lvupPVpC
         HxWDXSlq9HA2KUnCO/nWRFpw/cBG8bLAoJ+e0oJh4NqdKtim+J3x6ehyFbfLd2+l7AEk
         LPYhKXjcx6nqqOYBfUC/jgExpS/PT4GGt9x9PcVsfKuSAJrSS1in0f8GZ1ILxIQwAIb6
         htOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290900; x=1782895700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SB90+YCUH0dV66aMdsIbPcNB77SkXK4CkRD/ocilleU=;
        b=cU8gCPZ5w3s6xFohid0gbhFVlvJtTm3WWZ3uVLBheWHnJHYAf6eM2Lkew06vRHvSSH
         vq92B8++8tMsE9YguTgNre9iE11i0uhGBWe7fXXW779rxSRq7jaKQDI+jZf6UTlpdNgi
         O5BR7/rOmrF8iTTj1QgLkJ8r3uvw0/g1ouzmwF2SFdqUIlBm3iRUt0n+xqISLwax0Rdn
         BXY95Ec9sCbRkozEuyIQjrLVXne3ODAoSSsWFKOQT1zL4RwaII4kk5ZgUcu1aM6iM2sJ
         h5UXFiL+zSHdV40cGoMILHanO5kHh5pNu1a6kj51bwwb/I6LTbdFMvkX/xLnoQQsOxYy
         Gd0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoLe1DjEhfBNmD9cWrx3X2JwlXKWZMvgiB8RBWwIkp3ZDqmo1KOsHXPc5m7D9UJNiE2xcCsZwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcF8FaLMINSW1R5XfqWnQNHNDxeGGGyC35+rZLXBHqtnTeegE
	h58zB9al8hl3Kyk1gAs19ycAJIY0jmGY3WYa5KW8IWyPrUFmc0Ep5HCO
X-Gm-Gg: AfdE7clg0MaC3Amt9RAY63ddsfs7+7qHHklUQxFkr5Ip1XJpchxYwTienEIMp7lvTqp
	yLhMLhvMN4wpYIJ43X+8DPFey6WAVQslLrezwl8V1NhKOHT4zkhE+bmEAbsxVBI5QUECBt8Qt/B
	25HCT4WEJiK2NCK0wovOsS58AUmXXX45FnSGMV2J2dVCoujAi0CxY3pWgHBXA84LeDwZTrNNYj3
	015Za9VhYE6PDNeAFnh609q8IVKYr+25GjzracxxFvzHnEEHUrcb5pE+mv7ihBEnz2VGSfuGQMO
	oIU8hwzB1iI91ZcXD/JcNQepAGU1evlSpaMeCmhyk3T8vn1Q9gwyBa2gWpstz9jvWEBM5EbHHwA
	Oqwt+hs9YaYL+g8P998zLk2XRsvJgE2fbtvWzolX3EYdIfl0Vn2s7AMHev/W5vRx+9JdgJMORxO
	EaAvJdGVXuYl7+1n3KZHvbJASLGht8pDruo5GrV3oN2llm589vyQqGp/QYrfuakDyvtKCIiPkci
	sMoGEO7IuKOCbS8tg==
X-Received: by 2002:a05:6000:2404:b0:465:81cb:bb20 with SMTP id ffacd0b85a97d-46c04a33d34mr4263361f8f.9.1782290899881;
        Wed, 24 Jun 2026 01:48:19 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9371sm5065849f8f.21.2026.06.24.01.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:48:19 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Bjorn Mork <bjorn@mork.no>,
	Aleksander Bajkowski <olek2@wp.pl>,
	Marek Behun <kabel@kernel.org>,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
Date: Wed, 24 Jun 2026 10:48:14 +0200
Message-ID: <20260624084814.20972-3-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260624084814.20972-1-petr.wozniak@gmail.com>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301579-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,bootlin.com,mork.no,wp.pl,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,wp.pl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ED1B6BCAC6

commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
bridge in mdio-i2c") introduced a regression: the RollBall I2C-to-MDIO
bridge is not yet ready to respond to CMD_READ/CMD_DONE cycles when
sfp_sm_add_mdio_bus() runs in SFP_S_INIT.  The 200 ms probe times out,
i2c_mii_probe_rollball() returns -ENODEV, and sfp_sm_add_mdio_bus()
sets mdio_protocol = MDIO_I2C_NONE.  By the time sfp_sm_probe_for_phy()
runs (up to ~17 s later on affected hardware), the bridge is fully
initialized but PHY probing is skipped because the protocol has already
been changed to NONE.

This affects both modules inserted before boot and hotplugged modules on
hardware where bridge initialization exceeds the 200 ms probe window
(confirmed: FLYPRO SFP-10GT-CS-30M with Aquantia AQR113C, hotplugged).

Move the probe from i2c_mii_init_rollball(), called at bus-creation time,
to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP state
machine module initialization delays.  Export the probe function as
mdio_i2c_probe_rollball() so sfp.c can call it.

For RTL8261BE-based modules the probe correctly returns -ENODEV at PHY
discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
and set MDIO_I2C_NONE, eliminating the 5+ minute PHY probe retry loop.

For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
AQR113C) the probe now runs after initialization is complete and
correctly returns 0, so PHY detection proceeds normally.

Reported-by: Aleksander Bajkowski <olek2@wp.pl>
Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
 drivers/net/phy/sfp.c         | 22 ++++++++++++++--------
 include/linux/mdio/mdio-i2c.h |  1 +
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index b88f63234b4e..2a3a418c1369 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -419,7 +419,7 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
 	return 0;
 }
 
-static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
+int mdio_i2c_probe_rollball(struct i2c_adapter *i2c)
 {
 	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
 	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
@@ -462,9 +462,13 @@ static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(mdio_i2c_probe_rollball);
 
 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
+	/* Send the RollBall unlock password; bridge presence is verified
+	 * later, in sfp_sm_probe_for_phy(), after module initialization.
+	 */
 	struct i2c_msg msg;
 	u8 pw[5];
 	int ret;
@@ -486,7 +490,7 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 	if (ret != 1)
 		return -EIO;
 
-	return i2c_mii_probe_rollball(i2c);
+	return 0;
 }
 
 static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
@@ -531,10 +535,9 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 	case MDIO_I2C_ROLLBALL:
 		ret = i2c_mii_init_rollball(i2c);
 		if (ret < 0) {
-			if (ret != -ENODEV)
-				dev_err(parent,
-					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
-					ret);
+			dev_err(parent,
+				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
+				ret);
 			mdiobus_free(mii);
 			return ERR_PTR(ret);
 		}
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index c4d274ab651e..01b941a38eed 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2174,17 +2174,10 @@ static void sfp_sm_fault(struct sfp *sfp, unsigned int next_state, bool warn)
 
 static int sfp_sm_add_mdio_bus(struct sfp *sfp)
 {
-	int ret;
-
 	if (sfp->mdio_protocol == MDIO_I2C_NONE)
 		return 0;
 
-	ret = sfp_i2c_mdiobus_create(sfp);
-	if (ret == -ENODEV) {
-		sfp->mdio_protocol = MDIO_I2C_NONE;
-		return 0;
-	}
-	return ret;
+	return sfp_i2c_mdiobus_create(sfp);
 }
 
 /* Probe a SFP for a PHY device if the module supports copper - the PHY
@@ -2215,6 +2208,19 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)
 		break;
 
 	case MDIO_I2C_ROLLBALL:
+		/* Probe here, after module initialization delays, so that
+		 * genuine RollBall bridges have had time to start up.
+		 * Modules without a bridge (e.g. RTL8261BE) return -ENODEV.
+		 */
+		err = mdio_i2c_probe_rollball(sfp->i2c);
+		if (err == -ENODEV) {
+			sfp_i2c_mdiobus_destroy(sfp);
+			sfp->mdio_protocol = MDIO_I2C_NONE;
+			err = 0;
+			break;
+		}
+		if (err)
+			break;
 		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
 		break;
 	}
diff --git a/include/linux/mdio/mdio-i2c.h b/include/linux/mdio/mdio-i2c.h
index 65b550a6fc32..5cf14f45c94b 100644
--- a/include/linux/mdio/mdio-i2c.h
+++ b/include/linux/mdio/mdio-i2c.h
@@ -20,5 +20,6 @@ enum mdio_i2c_proto {
 
 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 			       enum mdio_i2c_proto protocol);
+int mdio_i2c_probe_rollball(struct i2c_adapter *i2c);
 
 #endif
-- 
2.51.0


