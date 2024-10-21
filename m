Return-Path: <netdev+bounces-137621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7729A72CB
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4502834D2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB81F942D;
	Mon, 21 Oct 2024 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8dMsoLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734B1991D6;
	Mon, 21 Oct 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537319; cv=none; b=uaW1hbEGlplc8gP1j8GS+eZqV7aC74ozME1mmf1Uu0JXLij/mR66C5TzniO0hOfRqtWOVAIsRBrE6eqXirH+UAK+tkCrKGOxoytPSpaBPqo2Jb9wwsw+1gvp0sdN6lIoEp1TssAYAlIY1TgP4ztVhSocHz7JDSLNWiFXMpAYGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537319; c=relaxed/simple;
	bh=rbvYR7DhDGi9yfMapGU4D5xxfWGs30xOWtvyVqT1Cfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfC5faXgaEhmDtOJqVMu4EyhD93yKstd63aiSiQDJ1rl+0171478eMC5Tf2uVBDMlwmOnWyBXJRI5SFmzcHtdo0oGMISO/54cO6d8t3Ku6pR9/fsRCJBiebFQtQx1JAHyMuwviYmMJskgWgUYyV27f+L6qjELd1Y0KD6uUJDqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8dMsoLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0A5C4CEC3;
	Mon, 21 Oct 2024 19:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729537318;
	bh=rbvYR7DhDGi9yfMapGU4D5xxfWGs30xOWtvyVqT1Cfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8dMsoLCBAPTNuU/Np9eLvMmdFhmQ1PTW3AHHwzh7+FM8cdi2ZMnW5A1e402PBlTv
	 PyjcbGfMpbV39jPDuLP1hpyQozBDyO89lQhmUmYdlu+BznzXFSME5NLg0XA1EOUGb9
	 70swI5g2oeDWtnKisY0tAYAZMhDNxxMkD33eM7t1MZW+ULqooI9d4ul3szHajNN5Kf
	 POhmtEG7J1UbrkB3RuMQFJP8D+7shHkpFSEDsgnRSjSe4LUSro42RYG02+aHBlb+MU
	 n+yiRIEcdiw+fON9f9yRSFIrGLuRdMX99g1xBgZCX155fFkDdoI6IMWfsC6ukFHJXK
	 9udNuKYegWEyQ==
Date: Mon, 21 Oct 2024 13:01:55 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] UAPI: ethtool: Use __struct_group() in struct
 ethtool_link_settings
Message-ID: <e9ccb0cd7e490bfa270a7c20979e16ff84ac91e2.1729536776.git.gustavoars@kernel.org>
References: <cover.1729536776.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729536776.git.gustavoars@kernel.org>

Use the `__struct_group()` helper to create a new tagged
`struct ethtool_link_settings_hdr`. This structure groups together
all the members of the flexible `struct ethtool_link_settings`
except the flexible array. As a result, the array is effectively
separated from the rest of the members without modifying the memory
layout of the flexible structure.

This new tagged struct will be used to fix problematic declarations
of middle-flex-arrays in composite structs[1].

[1] https://git.kernel.org/linus/d88cabfd9abc

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/ethtool.h | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index c405ed63acfa..fc1f54b065f9 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2511,21 +2511,24 @@ enum ethtool_reset_flags {
  *	autonegotiation; 0 if unknown or not applicable.  Read-only.
  */
 struct ethtool_link_settings {
-	__u32	cmd;
-	__u32	speed;
-	__u8	duplex;
-	__u8	port;
-	__u8	phy_address;
-	__u8	autoneg;
-	__u8	mdio_support;
-	__u8	eth_tp_mdix;
-	__u8	eth_tp_mdix_ctrl;
-	__s8	link_mode_masks_nwords;
-	__u8	transceiver;
-	__u8	master_slave_cfg;
-	__u8	master_slave_state;
-	__u8	rate_matching;
-	__u32	reserved[7];
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
+		__u32	cmd;
+		__u32	speed;
+		__u8	duplex;
+		__u8	port;
+		__u8	phy_address;
+		__u8	autoneg;
+		__u8	mdio_support;
+		__u8	eth_tp_mdix;
+		__u8	eth_tp_mdix_ctrl;
+		__s8	link_mode_masks_nwords;
+		__u8	transceiver;
+		__u8	master_slave_cfg;
+		__u8	master_slave_state;
+		__u8	rate_matching;
+		__u32	reserved[7];
+	);
 	__u32	link_mode_masks[];
 	/* layout of link_mode_masks fields:
 	 * __u32 map_supported[link_mode_masks_nwords];
-- 
2.34.1


