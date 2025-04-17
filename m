Return-Path: <netdev+bounces-183981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D4A92E79
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82269443B58
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC0222571;
	Thu, 17 Apr 2025 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khD7ELE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D521506E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934190; cv=none; b=hIjNPh9y040RFA65LvSNTlcni80rWr+w73X2oYujeA+WmWvH2I7zHkbqEXhlq83p49wgNDWM/+3R2Uw9ZT6mMX4F+KfnksSm8CYLDSieMGuCRj9FZEKfuGN/sxDCr1FJcZR25g3kURs80apeciat3tBHxqUjzvazPBPvoNos+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934190; c=relaxed/simple;
	bh=7HgyII6hWwDSoOyWDpgKkv4HK5XbSpUbeRrTdrcV1TY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW0Vy+vnCADxXgcTUs6T+Uqum8n0T27kKtHZo+8dI2bHsx4SKOcE6J4xrr84yOi2y/LsjSS66EdpY3iYnK4YJgCwwtH01bTINR2hS4ZzYUD6dn9CTIZ/lL37b4iKsWcNp9lHsRRnMGmj+dRsLr2ZModuvElvJSG2SUV7GejugSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khD7ELE6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so1077464a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744934188; x=1745538988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VvwZypbYLFQ9t71BScjshElT3ykX2mGCSjC/DDyhSGw=;
        b=khD7ELE66fhgTVELC4vpBQDffNgFP27zJQ09nK/BDPeJVDxxjA/bCHudj0ecFRVjdC
         6tFkcqSNDoBj6NeECPVpFlvF1TuHH+PQrHSm23VaBRLGbCqyttxegdexzXG9Vr5pH3dT
         TT4Q26awkub0xNJ42LhmguQTi6bvTN0QrA6plEVJSGc1wkpJztWDvScNocFTl96lYGN5
         9RS9xy0T2yoOmbywtAG9FZk3SttuTP70AP3qDazQdsuVQyXnHNl/o1vX9UqjsRR+FdbT
         EgxFgarjaImArbMs3VPpgROEeXF8PKsIR6qWPX0mP4FRQmYTUkZiWGOPYoRS5IAIODNt
         9J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934188; x=1745538988;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvwZypbYLFQ9t71BScjshElT3ykX2mGCSjC/DDyhSGw=;
        b=Je/SQN+1YaaCqOClTuShyoWqekw0y8Zsfgssph2e5IQ0YMv+libRZvuRUg7ap2S7f+
         r6UUea45LkoE7eUHD0gADBfjqt5Jf4oQGUWSDgKrAYgDTLEJZu4PeGBkpEbYs/JS5sOx
         p0fp/mAdbKisYqzow8MdNr40HNzTaD2sfnuemTqKKfofNS41Fg6L8se69Yd3eAs6Mhlm
         PkZDzmpqILHWHv6ZazOC2NxixT4v+YjYZVhceVhbFUoZtmzajSxFxXHTfy/W6wOowhNr
         CYpDKZIHLgU2clWnv7lAoAjM81UmZ/MnhRPktxPb5m6PDHp9xDsr70WFB1NWvgkk7TkU
         CCng==
X-Gm-Message-State: AOJu0Yy3wVQpe1tAojtUywBferrRltQ8vqVL5sLj/Va1xYCfkX0fXSv/
	e79fBXuyKUULNyTFMYReE9tb/VVF72q/Kkw9s2gZdETtKPKRXj7I
X-Gm-Gg: ASbGncvEW/pQTDao02T1WLf8E8yLJz3nBlUH9tlXaTGx5A5/uIcAhw6lTmTZfC7jtRF
	sziFOFUfHStxEKPVyQEZfhLkOtRFcNTzybV6dZTzMShaBLKMcN590hMS93HdvGOY6LwG2STTF4U
	17dG9I/Y0L8W9hBuC+FcBhpu1L2MOuDA3NEpqMXgDDZcBCwwPPVQX18K1w+vSB1ikTQI6nxO2Tc
	rCgCfxcuG3RYq5JqyNzXbW3xRWNTkTcy1PJvPkRiUpyX2zv/0zAepOvaY4DKcHSY28NWu+opx6G
	bkw1n+cSmgqfoznAoLuKWulehgWJR0po6feJI/IbjTz2uCDHzGX8b+SvhpCmdYuQ/WHesrpmGUv
	90xYc
X-Google-Smtp-Source: AGHT+IGr3KbjieSfEGKra9FScJtIOtS/qVODSn5AMhhdHfBgsRCMZL4LmDN2yEHWNhhGSHSpI7GJzQ==
X-Received: by 2002:a17:90b:270d:b0:305:2d68:8d91 with SMTP id 98e67ed59e1d1-3087bba1faamr1233970a91.28.1744934187755;
        Thu, 17 Apr 2025 16:56:27 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087dee330bsm37397a91.3.2025.04.17.16.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:56:27 -0700 (PDT)
Subject: [RFC PATCH 1/2] net: phylink: Add support for link initialization w/
 a "rolling start"
From: Alexander Duyck <alexander.duyck@gmail.com>
To: linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org
Date: Thu, 17 Apr 2025 16:56:26 -0700
Message-ID: 
 <174493418638.1021855.3276376104762124654.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174493388712.1021855.5688275689821876896.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174493388712.1021855.5688275689821876896.stgit@ahduyck-xeon-server.home.arpa>
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

This change adds support for what I am referring to as a rolling start to
phylink. The general idea is that when phylink is loading on a MAC/PCS/PHY,
and it already has the link up and is passing traffic for something such as
a BMC, we don't want to disrupt that. To guarantee that a few things are
expected of phylink and of the driver.

From phylink we would expect:
1. phylink_resume must not call mac_link_down to rebalance the link.
2. The first call to phylink_resolve after calling phylink_start/resume
   must trigger a call to phylink_link_up/down to sync up either the
   netdev carrier state, or the MAC link state.

From the driver we would expect:
1. mac_prepare must perform the actions of mac_link_down if configuration
   requires changes that will cause loss of link, even if only temporary.
2. Calls to pcs_link_up, mac_link_up and mac_link_down must be idempotent.

With these changes the current expectation is that without changing any
link settings the link should remain up without any issues. So going
through a driver load/unload or ip link up/down should have no effect on
the BMC link. If link level changes are made such as changing autoneg, flow
control, speed, FEC, or number of lanes then the link should at least
momemtarily drop, and this is to be expected.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    1 +
 drivers/net/phy/phylink.c                       |    8 ++++++--
 include/linux/phylink.h                         |    4 ++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 860b02b22c15..bbd13bf08eff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -142,6 +142,7 @@ int fbnic_phylink_init(struct net_device *netdev)
 					       MAC_40000FD | MAC_50000FD |
 					       MAC_100000FD;
 	fbn->phylink_config.default_an_inband = true;
+	fbn->phylink_config.rolling_start = true;
 
 	__set_bit(PHY_INTERFACE_MODE_XGMII,
 		  fbn->phylink_config.supported_interfaces);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1bdd5d8bb5b0..66cd866959ef 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -52,6 +52,7 @@ struct phylink {
 	struct phylink_pcs *pcs;
 	struct device *dev;
 	unsigned int old_link_state:1;
+	unsigned int rolling_start:1;
 
 	unsigned long phylink_disable_state; /* bitmask of disables */
 	struct phy_device *phydev;
@@ -1666,8 +1667,9 @@ static void phylink_resolve(struct work_struct *w)
 	if (pl->major_config_failed)
 		link_state.link = false;
 
-	if (link_state.link != cur_link_state) {
+	if (link_state.link != cur_link_state || pl->rolling_start) {
 		pl->old_link_state = link_state.link;
+		pl->rolling_start = false;
 		if (!link_state.link)
 			phylink_link_down(pl);
 		else
@@ -2603,10 +2605,12 @@ void phylink_resume(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	pl->rolling_start = pl->config->rolling_start;
+
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
 
-		if (pl->suspend_link_up) {
+		if (pl->suspend_link_up && !pl->rolling_start) {
 			/* Call mac_link_down() so we keep the overall state
 			 * balanced. Do this under the state_mutex lock for
 			 * consistency. This will cause a "Link Down" message
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1f5773ab5660..2d044f1a141c 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -156,6 +156,9 @@ enum phylink_op_type {
  * @lpi_capabilities: MAC speeds which can support LPI signalling
  * @lpi_timer_default: Default EEE LPI timer setting.
  * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
+ * @rolling_start: If set MAC may start in the "up" state, and if possible we
+ * 		   should avoid bringing it down unecessarily during
+ * 		   phylink_start/resume.
  */
 struct phylink_config {
 	struct device *dev;
@@ -165,6 +168,7 @@ struct phylink_config {
 	bool mac_requires_rxc;
 	bool default_an_inband;
 	bool eee_rx_clk_stop_enable;
+	bool rolling_start;
 	void (*get_fixed_state)(struct phylink_config *config,
 				struct phylink_link_state *state);
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);



