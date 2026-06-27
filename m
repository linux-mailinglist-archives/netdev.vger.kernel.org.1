Return-Path: <netdev+bounces-302344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y34SGoIJQGpwbQkAu9opvQ
	(envelope-from <netdev+bounces-302344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:33:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FA6D268D
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:33:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PzHEn63H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302344-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302344-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934D53030B1E
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A58342CB2;
	Sat, 27 Jun 2026 17:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28933BBC5
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 17:32:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581570; cv=none; b=uC9udZulVpOlahNfGuC1YuxqN9J7HFXvYpbjW6oeQC/2zmgnFfL+YHUgDxzMe43Yu5tmC/HilFsejVkR+kQ0JCbLT/nV3a2CbDN6sARZOyXuNo5E/XIy2D1rbQmkTyjBMGslbVo3cytVQT2508/fr/SevFHsUf/5zuQMTA2Y77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581570; c=relaxed/simple;
	bh=rbmqPwpC3e4x+Jf/TJ0Hk1KC0XrQ+JExfDo7nN4hLGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXwWIffbSqwoRX1fBUG6OnaoxpQUYATnfhWeivAOtVnqKmcYXdhbF0HINzotJPB0FYbc38Bq+3khFr7uf9+X+CgN1bU7JkK7rBRcA+ejfL2BvExVbAU0RSWQ5HkS26NVyPujdMsCCZjLzIYkJ8d6pZu+Z8W1RfM8ubdrZ3Slq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzHEn63H; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so407658f8f.1
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581568; x=1783186368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1aN455wbY+gBMKG0va4b7E6TK1scGzAIW5By15W7kI=;
        b=PzHEn63HdIbmaOUqm9VlesN+uN5881BDh8HgijlDMZ3MTM5wTl/78ZohNlnU1IeF+w
         lK/T16wz0Stoc7/Fk4ZEVzlqVgjq2N06jmFc2K3YGUA6hwzmn6TWXw7ObVa/WwjCcI3p
         d0J8BeQaILKPQajNLkfdmA9eh/GTh0rKMB9wdjJql0FlpCSSX5fNlbGIoaHH5PtQPp06
         R7lHcFc9laZbZ8P0VCfCmS/LEXu9KSdzhLNLSLkKb8KmVWU8uAiak8Qfn5iFbrhGQExp
         I+/AdfEI/Q8ZOrTQbzeEkL+152tfmISvRp98K7g2pIOA1r59IibgBcu7T6WhZ7dDJrIO
         k1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581568; x=1783186368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r1aN455wbY+gBMKG0va4b7E6TK1scGzAIW5By15W7kI=;
        b=LcG40Hj5tkBAi2O5HkHgKpMHbIScBIPi0I1uSUN3cowCj1c0Q2CdhoKmOPINw5w0pB
         HE/Yun7eBaTshULhl8ws0oCtXTeX9OZV08jxUMT4PUc9D1ncxZfunZwFRWiNTf9qI+Ck
         P7IVu5PfGJZHgtQFawpZkagg9Mhs/7eQQNL1DUraZNwCW7ol1r1DKlgwRIuhYDXeJanX
         CSuwnKD78/UjEYYzeWFljfjxslDnuttzqCrw6i59aB7jN+tSboPmZan4GbXFx/TOgHgO
         /qAD3hjYLlQ/huIZx9yJICw9HueB0dJo0iD2NC4N8gLAWyklkZEA4RKcKG+cMNmQ1nar
         qx4g==
X-Forwarded-Encrypted: i=1; AFNElJ8cVwotD/YhILKu8I7acqzuud7nOoMgGx4USA7Ue4iGvgQO3u0+jI4qyUlXn0TI3vIigNY7KNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQL4nVpWRLtT4T7AHiYP1Q25k6moJ0U3ibnAExJhaq5gZdAzVo
	PtnHNeQo9CLg/4HabMbuxXvGr3Ii7M6nNk5TbG100EPEilyUdWkR7M9+
X-Gm-Gg: AfdE7cnPOk0jQFdEwAMDG+RDY8Trpz1lmS2yXUBJuKpA2flxCcn5cu17gOTMuebJNil
	Gajs1L0jbYnpOBGAEv6xSMgdE5Caz9hu8ro04M/Gr2dchkUKpYcGz6Xkz62starLneK1n6iJD0K
	nWiY2s3q5Xhz6TKTkqNXlMCWb817jhDOA2SSfkwhTjOm17udg1jEisa16h5BTPh4DFnTo+b67dh
	e/ZnMJFD+RT47oNLz5gVNvnryHHDu/I/Mu/n85X/MFgJ5YG4GvoNsEcRfk30IG0L1ld1mOCQRy7
	JrKNzwbrNBWlQRYly+o/EQnkzPT1geXXUj7TyMRtiX3wljoceqNBP+mui4tgFMMqwzxksaszPIY
	ko3cEzbLytQHXPixuRz1CC8XIbb0EGahGe1WTN3EB95BqkM5TOeFRRCFip97FOwzKrsyNKbRPww
	cbnHp57OcI4OnU58sOoJL+akluy6SuGu+x2kvl/dyyYtfCPs/o7DJr+m9XXK+yp15h2TuB8BvEi
	ng1LMA=
X-Received: by 2002:a05:600c:b96:b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-4926686b3f3mr167318845e9.6.1782581567642;
        Sat, 27 Jun 2026 10:32:47 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4932f100e4asm64505955e9.1.2026.06.27.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:32:47 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	olek2@wp.pl,
	kabel@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v5 2/2] Revert "net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c"
Date: Sat, 27 Jun 2026 19:32:42 +0200
Message-ID: <23e3931915c3ed2a14cec95f1490e43d30b225e8.1782581445.git.petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1782581445.git.petr.wozniak@gmail.com>
References: <cover.1782581445.git.petr.wozniak@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302344-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,wp.pl:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C00FA6D268D

This reverts commit 8fe125892f40 ("net: phy: sfp: probe for RollBall
I2C-to-MDIO bridge in mdio-i2c").

That commit added a RollBall bridge probe at MDIO bus creation time, in
i2c_mii_init_rollball(), to avoid a multi-minute PHY probe retry loop on
modules without a bridge (e.g. RTL8261BE). The probe runs in SFP_S_INIT,
before genuine RollBall modules have finished their firmware/bridge
initialization, so the bridge does not yet answer CMD_READ/CMD_DONE. The
probe times out, mdio_protocol is set to MDIO_I2C_NONE, and PHY detection
is then skipped for genuine RollBall modules that worked before the commit.

This was confirmed on hardware by Maxime Chevallier and Aleksander
Bajkowski: their RollBall modules no longer detect a PHY, and work again
on v7.0 (before the bridge probing was introduced). The Sashiko static
review flagged the same path.

Deferring the probe to PHY discovery time does not fix it either: at that
point a slow module may still be initializing, so the probe still returns
-ENODEV. A proper fix needs per-module init timing (a longer module_t_wait
or a per-module quirk, per SFF-8472 the host must also wait at least 300 ms
after insertion), which requires genuine RollBall hardware to develop and
validate. Revert to restore the previous, working behaviour in the meantime.

The RTL8261BE retry-loop latency that the reverted commit addressed is
handled in our downstream tree, so reverting upstream is safe on our side.

Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
Reported-by: Aleksander Bajkowski <olek2@wp.pl>
Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://lore.kernel.org/netdev/20260624084814.20972-1-petr.wozniak@gmail.com/
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 drivers/net/mdio/mdio-i2c.c | 59 +++++--------------------------------
 drivers/net/phy/sfp.c       | 14 ++-------
 2 files changed, 10 insertions(+), 63 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index b88f63234b4e..ed20352a589a 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -419,50 +419,6 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
 	return 0;
 }
 
-static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
-{
-	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
-	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
-	u8 cmd_addr   = ROLLBALL_CMD_ADDR;
-	struct i2c_msg msgs[2];
-	u8 result;
-	int ret;
-	int i;
-
-	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
-	msgs[0].flags = 0;
-	msgs[0].len   = sizeof(data_buf);
-	msgs[0].buf   = data_buf;
-	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
-	msgs[1].flags = 0;
-	msgs[1].len   = sizeof(cmd_buf);
-	msgs[1].buf   = cmd_buf;
-
-	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
-	if (ret < 0)
-		return -ENODEV;
-
-	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
-	msgs[0].flags = 0;
-	msgs[0].len   = 1;
-	msgs[0].buf   = &cmd_addr;
-	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
-	msgs[1].flags = I2C_M_RD;
-	msgs[1].len   = 1;
-	msgs[1].buf   = &result;
-
-	for (i = 0; i < 10; i++) {
-		msleep(20);
-		ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
-		if (ret < 0)
-			return -ENODEV;
-		if (result == ROLLBALL_CMD_DONE)
-			return 0;
-	}
-
-	return -ENODEV;
-}
-
 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
 	struct i2c_msg msg;
@@ -482,11 +438,11 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 
 	ret = i2c_transfer(i2c, &msg, 1);
 	if (ret < 0)
-		return -ENODEV;
-	if (ret != 1)
+		return ret;
+	else if (ret != 1)
 		return -EIO;
-
-	return i2c_mii_probe_rollball(i2c);
+	else
+		return 0;
 }
 
 static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
@@ -531,10 +487,9 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
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
index c4d274ab651e..f520206734da 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -597,7 +597,6 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
-	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
@@ -2174,17 +2173,10 @@ static void sfp_sm_fault(struct sfp *sfp, unsigned int next_state, bool warn)
 
 static int sfp_sm_add_mdio_bus(struct sfp *sfp)
 {
-	int ret;
-
-	if (sfp->mdio_protocol == MDIO_I2C_NONE)
-		return 0;
+	if (sfp->mdio_protocol != MDIO_I2C_NONE)
+		return sfp_i2c_mdiobus_create(sfp);
 
-	ret = sfp_i2c_mdiobus_create(sfp);
-	if (ret == -ENODEV) {
-		sfp->mdio_protocol = MDIO_I2C_NONE;
-		return 0;
-	}
-	return ret;
+	return 0;
 }
 
 /* Probe a SFP for a PHY device if the module supports copper - the PHY
-- 
2.51.0


