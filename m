Return-Path: <netdev+bounces-264038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFsuF/eTqGkLvwAAu9opvQ
	(envelope-from <netdev+bounces-264038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:20:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FC52078C3
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5536309803E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827CB346FA5;
	Wed,  4 Mar 2026 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSI/sAex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E7334C1C
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655453; cv=none; b=YqnDVNnt2S6wFf6OT45CKFq0sJGgxtVZ5NFYdVyy/5Uvvx8oQG/ajY+MuMSUr+vWnWRjkXa41NdNlijAtl7+a5G2tqI+uOUHkk6y9t97OBSFQW+2Joi0KJLEJhis0zD7DtMGp2+zepGs5l3qYuQ2vlQo/LlNYU/tFXw4TTPwLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655453; c=relaxed/simple;
	bh=mAeq/Lvmnq4vfTyPQpphZySQXPxxdqBgMTfGklGW2KA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tev3Mgnzf6opVKVqAdmawWgzpzh9sR7CsMgAkV5FtRIK1qcJr2+p1ijvjPOVXHbdZaHQfb/H4yMxtESyKGKsKKt0HutTogviK2DIW4ltn8jzUpLihq09kSsyUE2JlSsSWkWMCQ1yvP9FL0mLmP6Rh/QELHWpnde4AxhCh8DG4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSI/sAex; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so87598275e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772655450; x=1773260250; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8Jo25Ckk2nq8L5mN3TF3tjqWplTuNulinGl5vOGIbw=;
        b=DSI/sAex8v3fx0QFVPWqmdTRMt4Y7jB/SGZ48I+BzC6lOiTcmeKqIUzEHgceOIlO38
         oS7chgeentG91HB/d9/Rp5NDgtPMLaeFIPzeGBrbFpHMp0X3KuiBAk4NG0S3orPnnxjS
         sAhpe99AWO7W736eP38rIpBKqlt9YHCqloOse/cBq8lIiORpa0OWaeWywhJ/pzJoWZIP
         Ytow9Dze1zKzOb6N+Nnf0Ev7Fqr9e2mmf2Ac+tpuvRXGrsy0fhkxuOsGebxFyGNSnjBm
         0AXuO3CQUMUjcjAOtlrGJGT7TARtuaxZd39udntmJ70LQeej26e7B4Wdd75JHduljnlA
         ozVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772655450; x=1773260250;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8Jo25Ckk2nq8L5mN3TF3tjqWplTuNulinGl5vOGIbw=;
        b=Qr2rbaESndLsTjoWCL6V35SVPFKrG6BoslFmfkHnSTzAQKm6Ew3H9TPakmf2ZirNA0
         jlvrlBUHusFK3iNkMJiq3repk6h+Pb5RueVrK+1+VoQKW38ciRImr1RXb2Dz0aNEkZbS
         5s5SYzVyA44tZOxWGL4I0VRek4zlFRIXMarQ8VVlpT1fcT7bE5m7NUu82rdJygVKZm00
         NTj+VfN29E5a0/ZJhVYdW4j1WBu7NENQasjTtFz9mIwTtBeMAfPzJnMmoZzFe2x0A82H
         uj9LIfGbyAOowkwbpvQjkT5pU3/2k+ByHYnkj5VNr8CgF5HQh9tsK7Oj7OynTv5bioL4
         jA+g==
X-Gm-Message-State: AOJu0YxvpAXye9lClFPBBpKgMSk7Sqp93/iQbzEnpYCYAj8alA7FaO4N
	h+dtxjxZraM9hLXQN3CnJ/FiAjqCgrXmABDMQzSvmZbm50kgO8O4/q6e
X-Gm-Gg: ATEYQzzdZmza2jnmCOolFX74JKIfXKkkSGYpkWuRFTBjw7k0v/Xc3/W143pNPc95PCP
	yoNIY80LjkA3TbAzcgrC3jHdzng1Gz5EwvIvpHx+2B9OsSGizY8FwIBg0yLtPqmKeYSiLO6PLYt
	0CcqRCgEK+zR4fDJ6UL/ORYdzeEBTYLaxOHZZ1T7xsZhGXr/3g4BX/e8H7o+BmeD+NuKZl3tShq
	PnlxZ9sZDFCAAVrKXUuGtx2WeqtjB5Qi7WXd0lL/gpVeA5O3X9oOKPcr/4MDQfB8W6o5xvQoP5+
	ylFQtrl8Ar+Co/7b53GoGorXK/4Gz32bCL9WVyoTf6gPg1R7ny5GifPQ/r1Q9vX03iYTu+wCbhM
	0ZtzveHp/QC4KOWI4UoefufJhbtojXQK+MhUOfCMTgETUfPROEV/3lw+ZX8a+Z287MFCWtEeaR3
	A8O9MQMkAPbFGE+n2FvTkutvioVIYb7iSvAcjDqYwpAsD8bH3om+AgAOMm+xqdjZN5zkmel2KZ4
	z8yYMTQmcenOm8M09XpgOGVkb1lIfe5HHSk3FmK/Qe+vEBJPAXGs1y/KXzGNrtfrA==
X-Received: by 2002:a05:600c:a51:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-48519889928mr52264795e9.25.1772655450012;
        Wed, 04 Mar 2026 12:17:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:5c00:3037:1150:282e:5094? (p200300ea8f245c0030371150282e5094.dip0.t-ipconnect.de. [2003:ea:8f24:5c00:3037:1150:282e:5094])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485186747a0sm144499975e9.0.2026.03.04.12.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 12:17:29 -0800 (PST)
Message-ID: <8812176a-e319-4e9f-815d-99ea339df8b2@gmail.com>
Date: Wed, 4 Mar 2026 21:17:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove phy_attach
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D5FC52078C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

378e6523ebb1 ("net: bcmgenet: remove unused platform code") removed
the last user of phy_attach(). So remove this function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 38 ------------------------------------
 include/linux/phy.h          |  2 --
 2 files changed, 40 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c99ca5d3f6f..0edff47478c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1895,44 +1895,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_attach_direct);
 
-/**
- * phy_attach - attach a network device to a particular PHY device
- * @dev: network device to attach
- * @bus_id: Bus ID of PHY device to attach
- * @interface: PHY device's interface
- *
- * Description: Same as phy_attach_direct() except that a PHY bus_id
- *     string is passed instead of a pointer to a struct phy_device.
- */
-struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
-			      phy_interface_t interface)
-{
-	struct phy_device *phydev;
-	struct device *d;
-	int rc;
-
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
-	/* Search the list of PHY devices on the mdio bus for the
-	 * PHY with the requested name
-	 */
-	d = bus_find_device_by_name(&mdio_bus_type, NULL, bus_id);
-	if (!d) {
-		pr_err("PHY %s not found\n", bus_id);
-		return ERR_PTR(-ENODEV);
-	}
-	phydev = to_phy_device(d);
-
-	rc = phy_attach_direct(dev, phydev, phydev->dev_flags, interface);
-	put_device(d);
-	if (rc)
-		return ERR_PTR(rc);
-
-	return phydev;
-}
-EXPORT_SYMBOL(phy_attach);
-
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index d065ebef659..5de4b172cd0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2152,8 +2152,6 @@ int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable, int speed);
-struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
-			      phy_interface_t interface);
 struct phy_device *phy_find_next(struct mii_bus *bus, struct phy_device *pos);
 int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		      u32 flags, phy_interface_t interface);
-- 
2.53.0


