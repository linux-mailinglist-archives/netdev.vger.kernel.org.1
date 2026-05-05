Return-Path: <netdev+bounces-284355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKNjHKrX+WmbEgMAu9opvQ
	(envelope-from <netdev+bounces-284355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:42:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 153644CCDB8
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C83B3010663
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FB83921D6;
	Tue,  5 May 2026 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erBGyO8a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AC38E5C8
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981339; cv=none; b=VtWbofTtfsIelIeqGsNQoPWGdRxZZ8TaggnOVIqKUDLhhv5yw0BfOLNcCZSyLdtn6DB1O89aR2KsVoYe8+bxg6NwSsP7NjReD8gB0C3V23R79vOzAO13ri1Zjdb863mr0fTSGrKx/acqP6gDDbiLB0c49yMTzOungPU+7swzXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981339; c=relaxed/simple;
	bh=gx7A00isc7RmHttEx52KE0RV6KvQzLxU1Ys+dmiy2c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INiWHtwK7uAFy//6kqXuYpKYDLm0yZ3I/JCpnChf8nwpN5IVhbyBz6/b9RVmc7p0s9jU6+brMM/yCn/SSBWSuT0nmSuvM6WDGpKw8/YLxHrPKLUtI8hlSkwuI7BylhyC8Qm2LTLZehQKpRzYDeyzM8uRB0rAsN3wWWe/NHW1RzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erBGyO8a; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so32495765e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777981336; x=1778586136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4cXplLEpKYnCchclmkDMqifsuTXLnl5XMB3nAYB268=;
        b=erBGyO8anYU3l3LJ6uzJTLLdWGkNAc1dBLWu5FUDiJdYsFKiL5yEysNp5vnQvT5/jZ
         aMvr/eYERgd4/YA6th5tuT6AmJVoEarJxoTp/im36GwrAzVgCUjmFEsar3T99dxJf1Aa
         ABXYM+DmruRn8k2/HpEwIQcsH1kgqwpaUWn7ASR5v7OV48XnTLx2Fmz/8yvIDQtrIJtT
         QdtV8zk5Zpa+gc2Xr/uvZfHe2+UvvNKKY8Q5e7Qu7oFROMi+qdUP0Zg1TYf8NbKSc+Wy
         b+b0fF9TwW5tMOZJ1lbuw6OIyyHxo+SQTqCwC3UkpRys0WILJBOkpMHQ474vusQeJFOe
         9yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777981336; x=1778586136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x4cXplLEpKYnCchclmkDMqifsuTXLnl5XMB3nAYB268=;
        b=VdWbZGpy6eETiHZQQ8X7vb9VZaQq4yCfFsY/hGFbUtvmgF7NY0yNJTgjzzMWq5+2D4
         lpIqiNCgk68BvZFLVW4FZRfASceSCdLRVkI9fejhDnLo8Yr41CseYm+TAJ9KrdIZkIxE
         ArsCnWFWxNa8UCvYGU7BxuFhjJhA4L4wgAoYH5rVNG/E2XhFpYkcPqSM5tbBrHE4TnMe
         Iwea2ixgJUewqFpWfzinEs7RCQZFC3AZ843CT52WunaH1i2E/snZDY70vo18pYjF9SRw
         zguBh8gaUr9pkjozFTzfvqHSA3EOSBO4IqZj/W6+KU5ZtK0wZTkQb2nMn2fXl/o7ydLh
         Q6Bg==
X-Forwarded-Encrypted: i=1; AFNElJ+ijBoo4ht6WIfyxU+kqHpgFLxF+yHcWg7VsqUkiaG7iAkSJiMwshZxkXneDPDT2jtsN/VPK7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5mdycCsUYXBOGs+zlf66bKTTZAt5ra8IjuXZ7odbhLgWKZ62
	lyJ4IojJQKcdPLJzomvnzpSVZUfA+cbAJ4I+YXQWH6MNDWbbkFBWbmUh
X-Gm-Gg: AeBDies0D8mYjfvsBDu8tphOBrxxK3ioUVt2DAj8QO5vZpxMJ4OlLmK6+90UWY0X6ue
	Sg692MhY/rnJ8HAOBiLu9hgrmjZ66MO24YJSqV8df2xpnsMImUsXe64CSZOfH4W4AwFGGO7m7O9
	ixAFUMkjXY/E/eWFqSUKeJSmCpoK/P5q/gHd/ntLLNnSiXiU8EgzRQZ1qmx3rGdug8CArLtOwls
	T148VklhmvcgZkwt9bX81M2b76JVuX7inb94mhTYAgPQwt7RaRY6AK439RR5IeLfGiD5yPAVsJe
	otsyWt+El82aLvh+ivw9/o4BD45cjhU5ybN4Ger7lKId7VsAkT0IW6inxsaLAewumsmpM4Rqu8X
	ohnWcLbr/oxmv4/ngQLFUN7lbzsDZRmj0I9EweZ/2OUkWgOB5LhJ+0ZkDZ5iqC+ftxKbTIPBXQm
	WwT0CY9qcg3teEFIQfKfSOa0Enev66Ha5eeIxGWh/NK7SQzPR9MO5swgR+h5TrZJNofcZyHgswy
	iTN8qKGWnN0rofUSmgFVCf4B5bCuEoK67UyKKAXNK4=
X-Received: by 2002:a05:600c:3496:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48d186dc879mr43982575e9.1.1777981336111;
        Tue, 05 May 2026 04:42:16 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8434-6628-bc01-577d-da52-626d-d378.rev.sfr.net. [2a02:8434:6628:bc01:577d:da52:626d:d378])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm616575105e9.1.2026.05.05.04.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:42:15 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 05 May 2026 13:42:11 +0200
Subject: [PATCH v5 2/3] net: ethtool: add KSZ87xx low-loss cable PHY
 tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-ksz87xx_errata_low_loss_connections-v5-2-da4002b21c42@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
In-Reply-To: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981333; l=2581;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=gx7A00isc7RmHttEx52KE0RV6KvQzLxU1Ys+dmiy2c8=;
 b=/dOqb+MbAD44sY/ssNLfyWqATYjy24hquZlfDrWmurG2RHQC7GCU3+Uo+PHQhybPvs1j248V+
 ExwyDP0EU/5CVctEh6ECvjyZ1m/MZB2iOSSebINjjZrEWuAa88mL5GT
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Queue-Id: 153644CCDB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284355-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Introduce vendor-specific PHY tunable identifiers to control the
KSZ87xx low-loss cable erratum handling through the ethtool PHY
tunable interface.

The following tunables are added:

- a boolean "short-cable" tunable, applying a documented and
  conservative preset intended for short or low-loss Ethernet cables;

- an integer LPF bandwidth tunable, allowing advanced adjustment of the
  receiver low-pass filter bandwidth;

- an integer DSP EQ initial value tunable, allowing advanced tuning of
  the PHY equalizer initialization.

The actual behavior is implemented by the corresponding PHY and switch
drivers.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 include/uapi/linux/ethtool.h | 3 +++
 net/ethtool/common.c         | 3 +++
 net/ethtool/ioctl.c          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..081d8f2191b6 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -291,6 +291,9 @@ enum phy_tunable_id {
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_SHORT_CABLE_PRESET,
+	ETHTOOL_PHY_LPF_BW,
+	ETHTOOL_PHY_DSP_EQ_INIT_VALUE,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..9c2fe5b626d6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -101,6 +101,9 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_SHORT_CABLE_PRESET] = "phy-short-cable-preset",
+	[ETHTOOL_PHY_LPF_BW]	= "phy-lpf-bandwidth",
+	[ETHTOOL_PHY_DSP_EQ_INIT_VALUE] = "phy-dsp-eq-init-value",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ff4b4780d6af..5b66e4a96f67 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3109,6 +3109,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+	case ETHTOOL_PHY_LPF_BW:
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;

-- 
2.54.0


