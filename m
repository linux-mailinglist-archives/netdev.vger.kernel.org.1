Return-Path: <netdev+bounces-183354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63685A907C1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B8163671
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970520A5C2;
	Wed, 16 Apr 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJNTDSnL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0B207A06
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817343; cv=none; b=XF5AshVH9nfrNIQuBMSrbpQVMxMNZTV6LRkhAyYyNBZ6F4gu9Fxdspx9kWXUYUENdA5TYN2m4TRGZFcUt+ACe/OLCSDMnmG2dm4RCQMSUl0FJUY6XZw8Ev2toWxwq2vhg9hy9EJPoBVl8WhIgImk/eYgCT7ymin7ZuBF3YGju2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817343; c=relaxed/simple;
	bh=oYVCWGy1hQTp/Qo7gB9o3fNjJ8KjSuYr8vc8sHjChKw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkmT79MB1EkdGUr8QfJyqVAAMtPIIXLffDZP5V7lIsii+pfwlqUzO+aqHHpv2SgV+nlen6WAdv41G9pXOwyfxt7BHBrUOsBcKfCowk3HEog2QZzA/GBTPcKCRwCwOLjzZiiQMkPi3o1jOaE6xzNJQik+R4caW6MxiEfIVeHohmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJNTDSnL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227b828de00so66660375ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744817341; x=1745422141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cjIPEpBHZsLJAGzzgyfjTAzSgVkOowHvw7Ct8eAojvs=;
        b=GJNTDSnLmVlFxEGVsBMmIHZ7A/Sa3KSxwS0uWv3U+VqlZLuKamAbaqgaTTyZ6avrUa
         cCzfnjRfwU4L/++GsBPvtYOHNOeku+I6B+46K2lZQT90KchlHhhLGzX1leS0gNojJVC9
         60ezDSx5YitTzhpDzbj7xDSNq3UkDF33fTI17+ofZsfdz1X/5eqAFUwZCxytgPIs27b4
         arlTPAJ92CRrAbe6Q0VjQ8v2cYhqILA8ClAhw04GGsr+xg3Ixw3uCUUyEFHZ+ClNUgNA
         C5wpESVLCO1nOWx3OhfQ0qFhgLzzGM9C+Hzrtqy9pVEtLGo9Q9LhuC9uGGGifnESe5bi
         2rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817341; x=1745422141;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjIPEpBHZsLJAGzzgyfjTAzSgVkOowHvw7Ct8eAojvs=;
        b=fl75iP5FGDUsuRWEtMsnrRdHhcd+o5UsJ343TMfxUmGJ/dqIO2mZC5qSyOkddHq70b
         jJ1wGBKLmvFnI2ZAa6YnF1pV9Me++ftAM8sB2wy8LxJGiyqAs0+0BQEVYzB46Rt3HpUY
         Je6fOYvNbCcXwZj3tOsaj2Tc13hs2lGF+NPkyG7J1Pu3TSpuw7n1OUhY8GuPjKE22iAM
         0KJ+MsdiPKlNaWy0BnIYoDy7WpU72CAtKABgWHZFtE6xwOVRoZeW5wqqDCvthp2fkCOe
         +hGxcZ0xa0letYl7cL8Xfou2JkKkioNfEnL7nDZt8jDwNhUVHw1jfDtcTzFHQdP2d0Gt
         aj0g==
X-Gm-Message-State: AOJu0YxGtq4D0iAR4Sq3TUX/RW0lOSOWcoQB8fFolY+zbHyLiSHTfdW4
	aGWfDRcqlIiM7YZDJfLDnH4ax82OchunJCqYCsbfLO5E/sAzBsyW
X-Gm-Gg: ASbGncvyvZZcBFOBo5nQ12H9vaUvl/jlj8jjJlSiw2PuD6t6xXLHC7Ka0SxFFLFMiJq
	LFnI6qf+0/dpi68iVaie1oTA1jcdKcYfwMkuOgFzecS0dCwvdCUTAiZvK1XuBuS9veL5WnbaqUr
	zgDC4lrqS/cDb8MVAPQv/2db5ZXZlVzZcLQNfyBmBgCS4WsqYwGBFaD9nOj4/9Z6BZgUQwGLQkZ
	DwnKM18hNnoOZoQlgTFBx/oi32KzHdSMXPbVy4Vq5f0TfrQtDpOWCZv7VXqgOKHeW29XBxblfJL
	DkKmWs0tmZmXtEmJEWzIDTq7QCor850Llq/wu/zmvh3d+CytWQ1K2jJLFhdPwZsnq0UeCsGseug
	=
X-Google-Smtp-Source: AGHT+IHFAIbcOSgx7xFz65Vs0c6MEWkVylBHZBNAdXO5CUt/7l5hyjgPJSAdRXB67A2z2qw7Su2aYA==
X-Received: by 2002:a17:903:2a85:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-22c357acd80mr39289535ad.0.1744817341541;
        Wed, 16 Apr 2025 08:29:01 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef063fsm15476035ad.26.2025.04.16.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 08:29:01 -0700 (PDT)
Subject: [net-next PATCH 2/2] net: phylink: Fix issues with link balancing w/
 BMC present
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 16 Apr 2025 08:29:00 -0700
Message-ID: 
 <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

This change is meant to address the fact that there are link imbalances
introduced when using phylink on a system with a BMC. Specifically there
are two issues.

The first issue is that if we lose link after the first call to
phylink_start but before it gets to the phylink_resolve we will end up with
the phylink interface assuming the link was always down and not calling
phylink_link_down resulting in a stuck interface.

The second issue is that when a BMC is present we are currently forcing the
link down. This results in us bouncing the link for a fraction of a second
and that will result in dropped packets for the BMC.

The third issue is just an extra "Link Down" message that is seen when
calling phylink_resume. This is addressed by identifying that the link
isn't balanced and just not displaying the down message in such a case.

To resolve these issues this change introduces a new boolean variable
link_balanced. This value will be set to 0 initially when we create the
phylink interface, and again when we bring down the link and unbalance it
in phylink_suspend. When it is set to 0 it will force us to trigger the
phylink_link_up/down call which will have us write to the hardware. As a
result we can avoid the two issues and it should not rearm without another
call to phylink_suspend.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phylink.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 942ce114dabd..2b9ab343942e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -45,6 +45,7 @@ struct phylink {
 	struct phylink_pcs *pcs;
 	struct device *dev;
 	unsigned int old_link_state:1;
+	unsigned int link_balanced:1;
 
 	unsigned long phylink_disable_state; /* bitmask of disables */
 	struct phy_device *phydev;
@@ -1553,7 +1554,8 @@ static void phylink_link_down(struct phylink *pl)
 
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
-	phylink_info(pl, "Link is Down\n");
+	if (pl->link_balanced)
+		phylink_info(pl, "Link is Down\n");
 }
 
 static bool phylink_link_is_up(struct phylink *pl)
@@ -1658,12 +1660,13 @@ static void phylink_resolve(struct work_struct *w)
 	if (pl->major_config_failed)
 		link_state.link = false;
 
-	if (link_state.link != cur_link_state) {
+	if (link_state.link != cur_link_state || !pl->link_balanced) {
 		pl->old_link_state = link_state.link;
 		if (!link_state.link)
 			phylink_link_down(pl);
 		else
 			phylink_link_up(pl, link_state);
+		pl->link_balanced = true;
 	}
 	if (!link_state.link && retrigger) {
 		pl->link_failed = false;
@@ -2546,6 +2549,7 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 			netif_carrier_off(pl->netdev);
 		else
 			pl->old_link_state = false;
+		pl->link_balanced = false;
 
 		/* We do not call mac_link_down() here as we want the
 		 * link to remain up to receive the WoL packets.
@@ -2596,16 +2600,6 @@ void phylink_resume(struct phylink *pl)
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
 
-		/* Call mac_link_down() so we keep the overall state balanced.
-		 * Do this under the state_mutex lock for consistency. This
-		 * will cause a "Link Down" message to be printed during
-		 * resume, which is harmless - the true link state will be
-		 * printed when we run a resolve.
-		 */
-		mutex_lock(&pl->state_mutex);
-		phylink_link_down(pl);
-		mutex_unlock(&pl->state_mutex);
-
 		/* Re-apply the link parameters so that all the settings get
 		 * restored to the MAC.
 		 */



