Return-Path: <netdev+bounces-262260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP9nCwt5o2lvEAUAu9opvQ
	(envelope-from <netdev+bounces-262260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56821C9AC3
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B70DE3046BAC
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4D3BA257;
	Sat, 28 Feb 2026 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2wm6cPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859534FF5D
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320987; cv=none; b=t/OjEBhaIqabGH/gINbeTR16k2VGpGhhUltWLoS/MrnBECNYNHtj5mmrJEriWIySaAdWj5nVdikSmSTJqxgg2mo+anrCYoG7m2bDnqG5tJafuPFL7npEDKQCoREDUvj+SbLSrcfUlC2qWUylnbnrEcUL6QQ/igNqYZe18NBMYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320987; c=relaxed/simple;
	bh=Z7bSopnXsEHjGorY9KUB86YcxCDj7BOcmMab+g55N+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeQgDAMBsoHAtIyrg4QCAnUfp68MtcAr3//JwYoynVsNQzBrvUwKzzZn/lr3/vn1veQ5VcaDrvUFKlLkNAqTBENY+lz1KEVVNCid+ywc5KgT6kZ9+yLT2aGynonWgaM3/mtQXdSWbes57c/QBVnci6393lK4gtOD9n+6ABH66ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2wm6cPQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439afc58ac7so270525f8f.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772320984; x=1772925784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QSUk/O1YaQrNE2KB+afVPAquqS3lddYamh9fKT5kIM=;
        b=K2wm6cPQnu7VVaEt3mzmNyYy13GWk2qu7J3Qku5C3R/EDvSrVAaethS/zeGG9IV47+
         lVvs8ybKjzHckmzpifN0t0lwSfE4EwNC5fTx8Ex+0oTU1TldmrXLBiworuLdpIl1x6cc
         DENW9hsrTuUw4xDQimdQo9e06+8gVfIQxYIeQ8EY3foP49uUJl5OU2zDhxlfP2KTIf9S
         a4aUrzPrz/4s0thNT9/ICcWK6ydjQRoCvCeSGGzgy5hW7tu91w4zPs6CHdTfJ8F9jzKs
         awVbkBDFoyW4GRxE7sv+xN5CKjgInvdTupjtHGafMgxp+FnX93x9vrgpxZnt1yMklzHf
         Rh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772320984; x=1772925784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4QSUk/O1YaQrNE2KB+afVPAquqS3lddYamh9fKT5kIM=;
        b=tvgFtH3cKPEXKpZxDIzaRCE8Z97UdZVOIpQCCndy4pvs4AwnrcmEq+sBJZYyJ6oV7O
         5ugDRihsdM4Noq5i0ZYc4wxlTFnYmSHSjySd+7TtscAjB+Z5Tw1NAyzu2R36+wZXI79b
         d6179VAYDFigEzJyq/IhXFjPakVXnhnOgboNj8kygsi5ueitdWgzNxrsIcZuCG5gTtJX
         XH6GwW1DwYLT3fTz+zIxEqohCtwpdS+rjDEHSFuxNpG+vXe+hoewOs3cPOAQD5H1qppL
         QTJSaFQWTZ2hZyLkMXmC9cavr2CdToxSA/wDSK38TDUcNUqtRgln40UjGmarzI+6AV4B
         5JLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ppR/8S/ZcU5M6IeeBk+BE6ZUK5u/vLPLZpsCfNW4SkLWQ7IQLYL5D6PNhxdWDOsAvlpuX6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+R5fHFTGd8RYW4w8aWJx9CaQgq2SDW3eLqkKwK6+iZ9sNVx1i
	uGKQb+G6k+KC1PHIgc5vUP4hWTGAgNKaWOotl0EJQPKV7L6G9RBhRPxh
X-Gm-Gg: ATEYQzxPJ20MxwE6n830LFDNIO9VfkArNEk1luvyZX3W+UEzLfi07a0R8to21z8s47M
	OHJUij/5eZ2Cu/TrparLQQdwWrzO+0YuMhmtpgjMaYPiQJ+AHZq7y2GNVAqVE72Utb3R3B+heOd
	EOjeHNkh0PDBlP8kxBq2R9Ju+ypaaVNjjr0WeC6z6CV+HO4/v09wS/WZDTK5dA0JCoGb2OTMtKF
	xUMq1IzXxzNG111FuEr+1gYE+dpYQMVD6DP/2Behp7kZR0S0cZImjYouBXpGw97QOJA7b6IWpM1
	0kIqE2qj7Dr3l40APrs0r3nb/vZNMUJKDiUtZM2HYHju9S1ot7Srf0aO4LeP4+kyXbw5Clf62Bj
	c1kw1vXETR7WkCmJtpBMdxBSc5bbNVEKpNesb92f+amozZ91QnWhpOMA3macuOdfRS1W4oTrYvB
	3DVKLuER+VJqBAaKi1nxeZmvPFIXTdMpmNeM49g5fVUqXiVAMv3uN2aZZRuDCTDFHG49UXmiWIa
	zmusw0=
X-Received: by 2002:a5d:5d81:0:b0:439:872f:b495 with SMTP id ffacd0b85a97d-4399de4a779mr11175104f8f.42.1772320984427;
        Sat, 28 Feb 2026 15:23:04 -0800 (PST)
Received: from pc-kuba-l13.. (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ed47sm18515680f8f.11.2026.02.28.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:23:04 -0800 (PST)
From: =?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
Subject: [PATCH net-next v2 2/5] of: mdio: Scan PHY address 0 last
Date: Sun,  1 Mar 2026 00:22:38 +0100
Message-ID: <20260228232241.1274236-3-linuxtardis@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228232241.1274236-1-linuxtardis@gmail.com>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262260-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secretlab.ca:email]
X-Rspamd-Queue-Id: A56821C9AC3
X-Rspamd-Action: no action

Some PHY devices incorrectly treat address 0 as a broadcast address.
As a result, accesses to address 0 may cause multiple PHYs to respond,
making one or both PHYs work unreliably.

On several PHYs (e.g. Motorcomm YT8821 and Realtek RTL8221B), this
behavior can be disabled via a vendor-specific internal register.
However, for that to be useful, that register would have to be
programmed before address 0 is accessed for the first time.

Device Tree-based systems scan MDIO buses via of_mdiobus_register().
Modify the scanning order so that address 0 is scanned last. This
ensures PHY fixups for addresses 1-31 are applied before address 0
is accessed, allowing the collision to be prevented.

However, preserve the original probing order for one edge case: when
the Device Tree does not explicitly specify PHY addresses. In that
scenario, PHY DT nodes appear to be matched to devices based on a
sequential bus scan. Changing the scanning sequence could change
the association between DT nodes and PHY devices and potentially break
existing setups.

For example, with:

    mdio-bus {
        phy0: ethernet-phy {
            compatible = "ethernet-phy-id1234.5678";
        };
        phy1: ethernet-phy {
            compatible = "ethernet-phy-id90AB.CDEF";
        };
    };

scanning address 0 last could cause the PHY on address 0 to be associated
with the phy1 node.

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index b8d298c04d3f..a705991f6b04 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -27,6 +27,11 @@ MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("OpenFirmware MDIO bus (Ethernet PHY) accessors");
 
+enum scan_phase {
+	SCAN_PHASE_NOT_PHYAD_0,
+	SCAN_PHASE_PHYAD_0,
+};
+
 /* Extract the clause 22 phy ID from the compatible string of the form
  * ethernet-phy-idAAAA.BBBB */
 static int of_get_phy_id(struct device_node *device, u32 *phy_id)
@@ -137,7 +142,7 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
 static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
-				   bool *scanphys)
+				   bool *scanphys, enum scan_phase phase)
 {
 	struct device_node *child;
 	int addr, rc = 0;
@@ -149,7 +154,7 @@ static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
 			if (!of_property_present(child, "reg"))
 				continue;
 
-			rc = __of_mdiobus_parse_phys(mdio, child, NULL);
+			rc = __of_mdiobus_parse_phys(mdio, child, NULL, phase);
 			if (rc && rc != -ENODEV)
 				goto exit;
 
@@ -164,6 +169,12 @@ static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
 			continue;
 		}
 
+		if (phase == SCAN_PHASE_NOT_PHYAD_0 && addr == 0)
+			continue;
+
+		if (phase == SCAN_PHASE_PHYAD_0 && addr != 0)
+			continue;
+
 		if (of_mdiobus_child_is_phy(child))
 			rc = of_mdiobus_register_phy(mdio, child, addr);
 		else
@@ -223,8 +234,19 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 	if (rc)
 		return rc;
 
-	/* Loop over the child nodes and register a phy_device for each phy */
-	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys);
+	/* Loop over the child nodes and register a phy_device for each phy.
+	 * However, scan address 0 last. Some vendors consider it a broadcast
+	 * address and so their PHYs respond at it in addition to the actual PHY
+	 * address. Scanning addresses 1-31 first allows PHY fixups to stop
+	 * the potential collision at address 0 from occurring.
+	 */
+	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys,
+				     SCAN_PHASE_NOT_PHYAD_0);
+	if (rc)
+		goto unregister;
+
+	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys,
+				     SCAN_PHASE_PHYAD_0);
 	if (rc)
 		goto unregister;
 
@@ -238,6 +260,11 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		    of_node_name_eq(child, "ethernet-phy-package"))
 			continue;
 
+		/* Skip the SCAN_PHASE_NOT_PHYAD_0/SCAN_PHASE_PHYAD_0
+		 * stuff here. Some device tree setups may assume linear
+		 * assignment from address 0 onwards and the two-pass probing
+		 * is not worth breaking these setups.
+		 */
 		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
 			/* skip already registered PHYs */
 			if (mdiobus_is_registered_device(mdio, addr))
-- 
2.43.0


