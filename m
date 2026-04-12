Return-Path: <netdev+bounces-277798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GNeHKml22meEgkAu9opvQ
	(envelope-from <netdev+bounces-277798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A73E41DB
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA083301AD1B
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC33313E15;
	Sun, 12 Apr 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI5bR30Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9018E025
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002439; cv=none; b=Su/vmJyOGFtC/0suOdqLxBq0Lu2Z9hu5ZYhSL0SOnD1/OuJzGB2SO0hHtMptAufD+b2TZPXU1ELe+cAjmPP8J4wAb2XUWsa+2K6FLQudHrkctuDGkGLWJqiJybEolsAza8xGeL54FGsj/+/ebsBL+nB/5vHRmcNl2rQvPTj9NfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002439; c=relaxed/simple;
	bh=mMaYpBdeS3NrnBsa8EFUtFNqHp0YZ5Ijols8OmB/8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmMCdNP8EUhSm3XiMWfzmvDJIJimk4N+jTjv57NvizzyXit86NzI0qdFevvWtnXt9mtLWDGqQnnt5QZLS5Mvz7AiHzaO61oEHtv+I1kOGqpTNEVpudOAqFkVHZ3l/GfixNlC/FNjsn1fpllpnjiX3e4JM27Ka/c69l2lHGCOhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI5bR30Y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2267168f8f.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002437; x=1776607237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djfGmhcRSmnW5HG+zxzJcYSHSvITdldDVooGPXKJOns=;
        b=QI5bR30YUjbZ5gSlXKisLdrZaqkKT6WWIy8suRZ7zTf654taup1D0826VTYpXQAiZZ
         bupr4Z0cLs4PA3GqHHnvXcIjU2dbJR3X5CV7t0U8lt8h5c80TKMiNP0Z6CbxTZfJG4uV
         H1Av5vM8S0tMFUExGE+yww+aNJU8RyU3R73IAGzKpTXq1trtfl1VE5SeUseQeX17bSrs
         xpoEl1BgtaD7dYWDmJ6be0DBGYW1MbznK3takn5uOLQYGCuPaPw1Z0bSv+w6Ck6yWJ8f
         mFiRQeAvTwrLwgaW0v8BNUdMF0ZdG0T8FxuHAuHT8WGcCdfMnfoYZCNY8LY8d6nFGm+U
         8UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002437; x=1776607237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=djfGmhcRSmnW5HG+zxzJcYSHSvITdldDVooGPXKJOns=;
        b=CuHny2LmG985aG/a6a5j/1k2zfvKm78wb8P6tYpyJzTBFewNy7+mZzjcv9tbSkfBDa
         7R0JB35Cxa1jl3fmFB/XB6jC/dTQX+v4jXDVYkcYBX7k540UAGdAdwLwZMR8RT3gxsQp
         nCVr2nsjF/zSp+lmxQmH/UlP6zCUWa8o3gvx69+BUnRg7l+/kPkwA/+aNJb5+i83ooko
         /7j9bfXtUCOPfghWhE1y8tnmgN1WouLsHaIhjRWeXR+0Oasb4Q00veuy+FQdug9RYrtU
         84Opv/+L9RqpA0l1NvrnLNmaBKkDrtbh04o3tGCCcFncmI+Y5PPPXfO6rs/BfXKWmDGY
         bBIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/p+GviGZAtIQi162Md/H1GdDyy+KQswdcUADUoimygqbzHKGFGp89UhtESKGTWl9zATG7iDgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKEMnHQ29VKJDPO6eedoeqn4oVTuT8wEqSp/swvMjD7LyqB4H
	C4VYjbHJq7TbEwMEDk+qdIY4/dFG9V6wh+/qtGDDHubKTG8IulKjYkYa
X-Gm-Gg: AeBDiesOM2QLU+Ug2c4D+AvBh0Tnj5a6dSCcVP+ZfOQyangb9kzXPdD5K23kHvr3SFE
	hVgAoSi/kEKv4P/V+7Vu2iU8PX0vTL36aRDc44720wNwYQIiQP7GX3BhPBLiHweEkDJf/Y+4ucG
	VHdPyUAtrNLd9fWBuzCyaA4mRJFn8nj4a+NhnLBO/us59YlYLj1nMh/F6k9DB2uMgdpYzqwYCle
	LMJF3FBjkqsy7PR4XVGOz3xMrCp5o4YWnMukLO80DblFFJBJx2V983AjaTymbA7StohzQOjustl
	F1aPznsWOEfAZBCNAV3MDty9M9zEGaBgOO5lOcHhshdbTXelbO54HNq97+jfOl/KxvYckAVViqY
	HemMS4hOJOxFvfnOSTWkhVjWfRKPDNgObpNVyNykw4JqarFxhMKvdTpBPVJNpmb2nta3PF8m3dA
	kSKBZHtGt8K2stYcsbi9Rgoh/Lb9WUxmXN2bqX+9cm6PXqyKNW
X-Received: by 2002:a05:6000:220b:b0:43d:70b3:7ee2 with SMTP id ffacd0b85a97d-43d70b3811emr3827998f8f.1.1776002436522;
        Sun, 12 Apr 2026 07:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:6956:2074:5220:4650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm26127538f8f.27.2026.04.12.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 07:00:36 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/5] net: phy: call phy_init_hw() in phy resume path
Date: Sun, 12 Apr 2026 15:00:23 +0100
Message-ID: <20260412140032.122841-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277798-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,armlinux.org.uk,vger.kernel.org,glider.be,gmail.com,renesas.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: CA4A73E41DB
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
v2->v3:
 * No change,
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


