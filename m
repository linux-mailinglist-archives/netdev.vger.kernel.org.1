Return-Path: <netdev+bounces-297158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AprBD/VEKGp0BQMAu9opvQ
	(envelope-from <netdev+bounces-297158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:53:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0709662A29
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:53:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BPbQwVNX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297158-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297158-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727253376E5E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103F37207D;
	Tue,  9 Jun 2026 16:20:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341BB3EDE57
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:20:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022016; cv=none; b=CzvQasJp334FM3/qMFZiHlUJDOe4MujSdo/OGG5ninBq4gEdDDtfJijwZ0F4IguIsLK0YNJwgPCqE+e3rGVoSvdGscTWg6k3DeOZR8t3PLhP79tsd3xLV+ryH+momhVMGz8ndeyOmp2p8wJlSQKwgQeHDM+jtl41l20uHaI4G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022016; c=relaxed/simple;
	bh=UBHcYZ64s+XEqC1u/+Yu/XPGxukz4KBbMfIL4HIH8B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lv7VIDKXMi8WGwpDO2jorRyYtp1F3vI3k8R96oJT833kfZ+ZiOQxRc+yLxN72DFQmK13BeonnJPJ/HIEgbcb9Ix125qZ2NfzRXjXYpAxgjgshiyUyjVTwYjlvqAQNaG9Fapb5PCqudLUrYqXf+2xW2FBG8ZatezcNs15yb3b/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPbQwVNX; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so50608885e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022013; x=1781626813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLbnKjJBElbO+83M+imgVwItrnVR6hDvTiuQTQU/vBg=;
        b=BPbQwVNX4bvU7/71ONwU0J8C8QNcSWmSQ8oLQnBMLDhGWg5C+Y2bU2ZTV46MQDF02j
         36YNZ9Cn7B+uiozaDsJzM4NeJWuO42+5ZJL4CfYMtBkNjaGj3YdHvH5h+Br4qKjPZXX7
         YhkV7he2JlEb0xNtXh8vpta6Wy4Dyh/3uRfHmbZ/srA32OCftXrgdK+n19u+xWuK8r00
         jUF/K2rpd07tFcKM81IvAd3czwM/7G/sN3TM+rSmKf+miOzgNZ9b6M+JUvsDjY4Wqtmy
         q3eUUFBPQVVCg+2G1cBAXNQzrLc35zjGxqUgmIJ290kUl/l8OleMShxvFHaag3wVxu65
         lgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022013; x=1781626813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uLbnKjJBElbO+83M+imgVwItrnVR6hDvTiuQTQU/vBg=;
        b=rVaTCtrzqNZW+O7v11qmW4eW0/lsnjb9Cc6jgiOzChBGxry0GwZBzLwgBLS6kKFMnf
         8fY8mMI9xmbnsFiD7AJdi7YNLVADyI9TeFy52VI4atbf9quI0gSniLNSYA6gLpY/KhyG
         4OahoCPkHB1tXBtNxpTVylZUyrsTM0k+n4TcZj+fZ01elFqs6EVd5ydDkdkrWMxA6tSw
         xcIPikyGEjgEsablpLu7IYBBk6h3JsM2qxuebALoY6jHLmfp6rKytQtP7EQP/qOAniHl
         zYG4XcICCtiRkUkFjT1zlVfWTlazdBQv9MDtidPewBUi2tYEjyOsN4CC8e4Y7FQ7HaAB
         GtQA==
X-Forwarded-Encrypted: i=1; AFNElJ8TSGNg1yBrHwh5WEVG96TFFtt7W1ZHXYqP+7lEe9CtlLzeBvWOPoh/qH/07JEaq5ITojv5P+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRX/HWeOgBdzD31j6IktJqLH2qnO1LTOujhjpo9CdW7Uph6JAn
	1NX6u4han9Ef9TAddogaa9jfbtdf041lRR84iFNFitDCaozaVcEmEw+3
X-Gm-Gg: Acq92OERbZvl5tLG8eo5L8O7sAPesKhgfIMQrzzqrnfaLv7Hd737HPNHjwuRdvop+rH
	/GylV98aT+u7bQJyR9mhgvVa2aanaaXMaotDzRUzzspOAjHWUYjbApovm1WMiMY4oWOIJ+9fI6Q
	aBcc2n31VEKNt1yehJq1uGauCQyaoS5IIHy+V5mfOsI2gl2efkrJUfzNbriW0vLvRvugs10he6e
	uSIir0jD7FAuKRC1PH/5BVsYC5Z2aRyeP97zq3K2SlOttCZAahOQe64LhlzLGioOeGIpx7SFK+U
	Cq95DMzUv8RoATGF0yEq2r658lcrmX3cle+BEievcxq6zx0aKByJb8wzCo+8bZoxuQfo8b9quto
	LTjUqeV/jOdo9GSmtDoGNIXVtINiMFARZTaEfGGlqUbvmbNizPZV4/r4/j5QjoMHJd0QxKY06cA
	ZDb2EwFoXCwLUw/BipGktZJ1cJPmdM0Y0aayCZq3ykstGa3BDLC+12ftgpp0AdVAOCcL4+8CR4o
	QhH6MWoPyADo2XofeJg
X-Received: by 2002:a05:600c:37c9:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-490c262dcb5mr339696835e9.33.1781022012581;
        Tue, 09 Jun 2026 09:20:12 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm569116365e9.1.2026.06.09.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:20:12 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 09 Jun 2026 18:19:56 +0200
Subject: [PATCH net-next v10 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ksz87xx_errata_low_loss_connections-v10-2-9ba4418cf3db@exotec.com>
References: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
In-Reply-To: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
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
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, 
 Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022010; l=3007;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=UBHcYZ64s+XEqC1u/+Yu/XPGxukz4KBbMfIL4HIH8B8=;
 b=/VxUEs27sUOA/D+N+2RdqtvQWtXaJWaH/h5Gqw15VqqeLlXtmsskq7s0RmcT6a5WqFBRpYNvG
 oN5D/ehoROzBnWP4Ih60UHRIJOXeIpMKLTf7LaT3ppx+o0wmf1yQrjm
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marex@denx.de,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:marex@nabladev.com,s:lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297158-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,vger.kernel.org:from_smtp,tipi-net.de:email,nabladev.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0709662A29

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

Reviewed-by: Marek Vasut <marex@nabladev.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 include/uapi/linux/ethtool.h | 3 +++
 net/ethtool/common.c         | 3 +++
 net/ethtool/ioctl.c          | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 1cdfb8341df2..a2091d4e00f3 100644
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
index 84ec88dee05c..a24d3a8a9ec1 100644
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
index bd97f9b9bf18..11d757ba1265 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3114,6 +3114,7 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;
@@ -3123,6 +3124,12 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 		    tuna->type_id != ETHTOOL_TUNABLE_U16)
 			return -EINVAL;
 		break;
+	case ETHTOOL_PHY_LPF_BW:
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		if (tuna->len != sizeof(u32) ||
+		    tuna->type_id != ETHTOOL_TUNABLE_U32)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}

-- 
2.54.0


