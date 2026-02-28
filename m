Return-Path: <netdev+bounces-262259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBrxON94o2lvEAUAu9opvQ
	(envelope-from <netdev+bounces-262259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52E1C9A97
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72FE4301BA64
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98C368948;
	Sat, 28 Feb 2026 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb86NN1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66562D2481
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320986; cv=none; b=R478YwC4CGbbq9Jg9q6Cir1qV1Lv4HOrdfjMEPH5QlfUH0XCVOe4VtXA8Q+ck3hyMpGFu2QLVLKRA+LKybwCuhHfu9CANGBOiombl9Wxe84V1Xt4J16A9Sg2Flfn/g5BOfeRpS8euv1cOUnEFbs8MFmIpE3vfOfpQfqKqAOwk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320986; c=relaxed/simple;
	bh=LO39Axnq6iF8iPb7VGpGZoLs2F2b7LqrK7p8ZPbk8gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOKHhrwWLNThRH5GYzP+y55LD1ksGFtRr8CQ+jJ6mWcU6tc/+oGGTcTRhrCY3Xb+kz6t1qrZySkw0N60VhSPXyTwKOJ6sAQsfEPl/0R8AFbWoL8TOTIX52c6yuQO0Mz99IUSKEacgvsXaVommVa6ZkCC3EMFYqfOVUEqVFSEehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb86NN1z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso35123375e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772320983; x=1772925783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvI9rfVkeg68adZAPqkcXmdhi9It9JA2cusW9CSADLE=;
        b=gb86NN1znZB3caC61tvZawVeL+gPO9PC+xx5AL7XZWT4dvt8/iUeKOoZzmi9Gf/Z1R
         oFLo9HNOx1atI80oHdRWej53qWkwQHS6kT6MJuwy8PC45dFPCMcCmvTekAXWqHBe8CSz
         Lv4BkRWpyjvmMAlDoxNTGkYjrEnszB3H54VL4Fy39nomyBIjK5CK+qY7RYaK5Cuxei0q
         lEBUbx2jaxSVV/HCS/3eTbIW8+WsT0/wQat5sz1wW4QCywR/kqcOlmLCcAd2bedOQG7B
         /1CP5jAwaZEp4OqGQPE89SueR5FYnNqAQtDf1yfiqyGPd9NmDlfK/IgiOQTvy49+WojV
         zEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772320983; x=1772925783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AvI9rfVkeg68adZAPqkcXmdhi9It9JA2cusW9CSADLE=;
        b=X06z1qj+PuJbVhyv/DHAgs1difu9MFuonvUHUaOAeAujB7h9Hs4JKxOSS5PXpH8FL9
         3oCgwAu2L8nbLb6RM2PbGz3QN3sNpKwOQE8PulpDD8wVFOPZqPV/SbPwx5AFg3XRinql
         2LJDquhsmyZlIAqDkJy+ntWmUvFFsFR9GaLnqz7cdFnPHe8XHRPwqcP1IeJ2lPPKO3lp
         r0g9uaEieclOmvdsx3Zzsuq4F4F+DU5lyFpkhc7vZU/vBhEOBZyOCxPaDVUMPKEvDbkX
         ctdblFB7pdpgSdeppL+3duNVbf4wilfmF00KnuB8xgoezMF0tDWsY+khZDuutBZKejsV
         ns4A==
X-Forwarded-Encrypted: i=1; AJvYcCX8q8l3VCc2bQvg/aT1z7aErnvQapxfIc/jW5OkhutCeOy7Eouh+eoFbZRRqoNdWQeFHXWlW74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygh9cJmpas7SrVvnaBcZkBlJEnF62Ygoi5RluToOPcUBxKbKCr
	lfQDuc/1l5jQQngpUek+peJBbmNBZ3J6XqRYnhcvENIuEBTRHl9jyYQEX44LOSlaNyc=
X-Gm-Gg: ATEYQzxJNjyrWXDlESZEu1cASnko+jrFVQ38RCvmI6aO4b/P84cgCIKt4fbsd3z9qWb
	Vgb0htkVHkM7/d3QdmidSKxZIKSYUAKth/ImNGxKWauss/ttwYh1mxl9ol+UOsS9kNnAoBgK+gJ
	0iogUoswobBYFciwo9E1sVL8XnqppoflRWLTpC2Djew/WBJ4IkGGNCFiDNf/ACXze/OdRrI5Fnk
	AcbQgl9BAh6B8LFTkPWqIEVT1c5JkIVW1kqgzqcm+p8jaTCLxyRIKGtva05Xm/LxsbV+E8pIbFO
	GKU23vLo7E0BA0CWpzhuL/H9ZmTWMR89EFbfH5ogWOwJ7ni3K9Vhl+eLlQOBB9ro0jziCSJmMkz
	Hi9D5t6NozJVKGsSfn/lr0FaBD6iXEq8yxeTJyqnIwf8maBWLt9bgyeuuoxY0ZxhIl8Wiqkva8Q
	AmEbbfxl1aV3k7CwRlOQxYpo7KD9IRHK7PbnjIrJcLGvGJL1R8bwjdNeLdDVnjbsA4mMM2x0Ayz
	ZP1V3axxcHaFyFPhQ==
X-Received: by 2002:a05:600c:46d5:b0:483:5310:dc67 with SMTP id 5b1f17b1804b1-483c9bbbe77mr110176085e9.20.1772320983185;
        Sat, 28 Feb 2026 15:23:03 -0800 (PST)
Received: from pc-kuba-l13.. (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ed47sm18515680f8f.11.2026.02.28.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:23:02 -0800 (PST)
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
Subject: [PATCH net-next v2 1/5] net: mdiobus: Scan buses in reverse order (31 -> 0)
Date: Sun,  1 Mar 2026 00:22:37 +0100
Message-ID: <20260228232241.1274236-2-linuxtardis@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262259-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:email]
X-Rspamd-Queue-Id: 2C52E1C9A97
X-Rspamd-Action: no action

Some PHY devices incorrectly treat address 0 as a broadcast address.
As a result, accesses to address 0 may cause multiple PHYs to respond,
making one or both PHYs work unreliably. In other cases, the PHY may be
detected twice by Linux: once at address 0 and once at its actual
address).

On several PHYs (e.g. Motorcomm YT8821 and Realtek RTL8221B), this
behavior can be disabled via a vendor-specific internal register.
However, for that to be useful, that register would have to be
programmed before address 0 is accessed for the first time.

On non-Device Tree systems, MDIO buses are typically scanned in
mdiobus_register(). Change the address scan order from 0->31 to 31->0
so that PHY fixups are applied to addresses 1-31 before address 0
is probed. This way the address collision can be avoided.

The change is implemented separately for Clause 22 and Clause 45 PHYs.
This approach might still leave some collisions at address 0 unhandled,
but it is much easier to implement.

Device Tree-based systems also require a different approach. In that case,
of_mdiobus_register() probes only the addresses explicitly described
in the Device Tree. Handling for DT-based systems is implemented in
a separate commit.

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
---
 drivers/net/phy/mdio_bus_provider.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index 4b0637405740..d3454d229795 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -208,7 +208,12 @@ static int mdiobus_scan_bus_c22(struct mii_bus *bus)
 {
 	int i;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
+	/* Scan address 0 last. Some vendors consider it a broadcast address
+	 * and so their PHYs respond at it in addition to the actual PHY address.
+	 * Scanning addresses 1-31 first allows PHY fixups to reconfigure these
+	 * PHYs to not respond at address 0 before we try to scan it.
+	 */
+	for (i = PHY_MAX_ADDR - 1; i >= 0; i--) {
 		if ((bus->phy_mask & BIT(i)) == 0) {
 			struct phy_device *phydev;
 
@@ -224,7 +229,12 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
 {
 	int i;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
+	/* Scan address 0 last. Some vendors consider it a broadcast address
+	 * and so their PHYs respond at it in addition to the actual PHY address.
+	 * Scanning addresses 1-31 first allows PHY fixups to reconfigure these
+	 * PHYs to not respond at address 0 before we try to scan it.
+	 */
+	for (i = PHY_MAX_ADDR - 1; i >= 0; i--) {
 		if ((bus->phy_mask & BIT(i)) == 0) {
 			struct phy_device *phydev;
 
-- 
2.43.0


