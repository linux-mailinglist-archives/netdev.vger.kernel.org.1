Return-Path: <netdev+bounces-277703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHIdD+9a2mmB0ggAu9opvQ
	(envelope-from <netdev+bounces-277703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 16:30:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC493E0545
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D28133008989
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E983C2DA749;
	Sat, 11 Apr 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZczkzRqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78EE385503
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917803; cv=none; b=ltohukvsH7Fc+KDmKewObPmgjj9EpHcaDwnXK4bhq2r0p3qZTbWnGfjI3tVPbk8l9yXAriKl+E0ZOinayGeaJ+SuBfuZFDyi3zU9KLBgqWW9h8fPh8u3dtdR+1kWoe5kaySscSIWEcm6jid9OXG+xCMHP4OnIHD3XzQNkCJ02tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917803; c=relaxed/simple;
	bh=I7otHS2UuBibAyk7ztbchnygQDdAGqIo613LgXlwUo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qdXsff/O2D05wavwm6mE3mxLNYcxWyEbfESUX13qiPOzANGmuv/0oefGkeJYXgYwqI2QgjrupTD567mBKwFHkDKIhYFbMCmGxBJkfi6wyAK/Pp4CQh/mtGtk2CfUHE8bhaAi3e6A6xE8i63fvIAwwtL2ZSCs99s6OijgJtWvjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZczkzRqQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so28253465e9.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775917799; x=1776522599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfsfBk1yzNdC/+yEaYnXqko1EBtHRLDfqU2U7CZrU+k=;
        b=ZczkzRqQMKa1cCeHcr4QKh4IVLcWKs8b5c2UnZZzW6TM6tGTlNQmYJx2XgQCpJS1dA
         WXKduUoOWttSIlwYkkH7+xXbix55QMltQbxqKyuxYNVW19HznOTENe+qhoYKWwRIciyw
         P2bbf+YT2fztRbnS4nHUNaZG6Qd3nMAKCHQvChTADn6bfIu4IxdeePGF+tsWjUx9FcNh
         0Yg18GxDw/l11N11ztP7sMZRC3ABhf3LkHoVQIkOUuop/vIcDdoDqjEj4DX8N3VGwSig
         ZDK3rIPNos6LEHAT9Gk6nceZLHAk69ywMvIV+mKMAvppzHX35HhY7qR2DFcQei8g12A+
         eKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775917799; x=1776522599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfsfBk1yzNdC/+yEaYnXqko1EBtHRLDfqU2U7CZrU+k=;
        b=CORM36zJl5jdzUS+Lg3NAN4aFCqMj18skC13dPBtj94aYd1nvdyvzBqvzyIe+khlQH
         68U0zrp8Us4r7qAEIiPn2NFDnarvp6ZgEl/OZNFXLbbBrA62GF9sExzHuO6E2VifukNW
         c8j30j2c9cHe176YGQ5YCNDJXe3IVKcA3TezpNxPeuom/Kx9VUX1Gl05W/AEDelKdtCh
         NwnCmhrpVe4j6RW7KSkeitVfbYtO6NfnMR/kfh7HZzE1mBn+SNMlTn/Pssqn4WUo14u0
         Q3Gr4SHthPtgXyTA/G1IA7uM491wgs6LnobCioe9CVHY9Z1SNw3rMUM3ZvhDCAD1Iq5b
         u8rA==
X-Forwarded-Encrypted: i=1; AJvYcCXK4hlZ9LYtoB3G0EZDBOZLPVN3rjS81QLunrMJMZ0b8Yas6LA5fv/X3+w7+eFt4b3zYwLFqI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGF901AhrQwBs+ewdNF/M6/btrHbZw8V8cdYBLvX6815MRGJF
	217sH8VFAoc3Qc/wizJolHpzVTBvCxjhdNb81dbbo1vQXdDeoLeSyZ3y
X-Gm-Gg: AeBDievqw36B+/gRtQ5bjqHNI2J8MFxaSIQCQ+qN/93byDUePxYdcVe/8wca87a5+Qs
	iouvE3TKhNToQpluzLqIG9qQ5oPKk8ikXfp3oN0HDl07BUziMUA+JLoKWpej2IQt4kC5ZASdBYN
	20/EYnBo5FNVAJBFQkrcIhDTwRM96Fnhu8IvqOBRoJnq9OaEnOi/BDw7lp4bF92sakXbq0+Lv4E
	Yyfa9qx9EDOJskw+RtT2osPAxXN88G15G1UpO56iKg4VghgH0YHUF3t0EDYeIEH0I+p+UyCwokz
	Jq+UeydzjO6Ul7NeAQ0uriQ6xbn3Fv5RIGMWypZFTRy5MfuEp/BdFJcpukmYzd2SYAE4kB/HHs2
	9NQJGicAo8M9swKRoO/Z9ks0THLvIXF1aVndY6HY/0YlYL2KzNM6qxw+MnC6q+Mn8TxOEK845gt
	c5XBDNUDdh86MRaPvNSaSLlXZHBWAC7u0=
X-Received: by 2002:a05:600c:314b:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-488d687c076mr80986065e9.26.1775917798783;
        Sat, 11 Apr 2026 07:29:58 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:1ef3:1f1e:3a7e:32e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58a414bsm151270785e9.4.2026.04.11.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:29:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net-next v2] net: phy: call phy_init_hw() in phy resume path
Date: Sat, 11 Apr 2026 15:29:53 +0100
Message-ID: <20260411142956.88343-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[bp.renesas.com:server fail,sto.lore.kernel.org:server fail,renesas.com:server fail];
	TAGGED_FROM(0.00)[bounces-277703-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[bp.renesas.com,armlinux.org.uk,vger.kernel.org,glider.be,gmail.com,renesas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: AFC493E0545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

When mac_managed_pm flag is set, mdio_bus_phy_resume() is skipped, so
phy_init_hw(), which performs soft_reset and config_init, is not called
during resume.

This is inconsistent with the non-mac_managed_pm path, where
mdio_bus_phy_resume() calls phy_init_hw() before phy_resume() on every
resume.

To align both paths, move the phy_init_hw() call into phy_resume() itself,
before invoking the driver's resume callback. This ensures PHY soft reset
and re-initialization happen unconditionally, regardless of whether PM is
managed by the MAC or the MDIO bus. As a result, drop the redundant
phy_init_hw() call in mdio_bus_phy_resume().

Additionally, in phy_attach_direct(), replace the separate phy_init_hw()
and phy_resume() calls with a single phy_resume() call, since
phy_init_hw() is now handled inside phy_resume().

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description.
 * phy_init_hw() is moved from __phy_resume() -> phy_resume() to make it
   lock-free.
 * Dropped redundant phy_init_hw() call from mdio_bus_phy_resume() and
   phy_attach_direct().
---
 drivers/net/phy/phy_device.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0edff47478c2..4a2b19d39373 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -396,10 +396,6 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
 		phydev->state != PHY_UP);
 
-	ret = phy_init_hw(phydev);
-	if (ret < 0)
-		return ret;
-
 	ret = phy_resume(phydev);
 	if (ret < 0)
 		return ret;
@@ -1857,16 +1853,14 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	if (dev)
 		netif_carrier_off(phydev->attached_dev);
 
-	/* Do initial configuration here, now that
+	/* Do initial configuration inside phy_init_hw(), now that
 	 * we have certain key parameters
 	 * (dev_flags and interface)
 	 */
-	err = phy_init_hw(phydev);
+	err = phy_resume(phydev);
 	if (err)
 		goto error;
 
-	phy_resume(phydev);
-
 	/**
 	 * If the external phy used by current mac interface is managed by
 	 * another mac interface, so we should create a device link between
@@ -2020,6 +2014,10 @@ int phy_resume(struct phy_device *phydev)
 {
 	int ret;
 
+	ret = phy_init_hw(phydev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&phydev->lock);
 	ret = __phy_resume(phydev);
 	mutex_unlock(&phydev->lock);
-- 
2.43.0


