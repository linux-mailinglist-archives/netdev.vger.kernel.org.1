Return-Path: <netdev+bounces-140135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620A9B5560
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B741C2127E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3E209F24;
	Tue, 29 Oct 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej++XLRo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C8208987;
	Tue, 29 Oct 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238939; cv=none; b=DLccfXcq3ssENZsOYFJ3HbdZEVQaTGERCIXAkNd7c0OZpEx5Fs5+JQCgkVZtQ7Ba/d77CKu5CEblJFifE+2cJbOV5PxhpQ1rDEuyL56L+Xdw3QISkZWUfhzSpg973QzVmuui08s8y04+2LUUFqVc2JHO7n40BupdjMLkg/Kb8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238939; c=relaxed/simple;
	bh=MRLrmTepWw6yRn2iVG9OiSxDCUDgCrRnrv/CAMIhUb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fei/YDm2CIc5SSBSLvI0vUYYwncwV42tbevvvA02Gxvh2KCmXrl6/fzFgBYYpDnUvj5/ixuxnk6Lm41wmVn4S+L9kuMb61lIYYXx9Lkiijpxrx0AN8ScPXLtX8IfZcCDJHW4VuUdwGejfU3XVebA7PW6F3GYmWG5kW7ofPJWzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej++XLRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56331C4CECD;
	Tue, 29 Oct 2024 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730238938;
	bh=MRLrmTepWw6yRn2iVG9OiSxDCUDgCrRnrv/CAMIhUb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ej++XLRol8clWFkMSB8Wn8h2KkbtUqvN3wxRLth4ZCU6Wxhj58Bcv+3lJjsoTIgCs
	 93/A5kMvg3ajCWLsNX5T62BAuvdj5euuyNBE+F1rgovxf6wsNBbI3yEU0gHIGCc0wv
	 Lz0i1GSPQnwmNYw5esh7mkimXH8fg4Dv3A7mbcOtIT0GchSFd4xnplKWAntBRFCEWm
	 +cUuJ+LEApzAKSxA2FY/WDZdKDpHawtjECwQqsb+TW/VLI/BykByxZcEhHyTGyFqhB
	 uTfttfpAfE0yUNGzIpOsCrO/1oTIgFGjGsMOMuYG/llBlpfmXzvgmV1RBWszxHtEKl
	 6U6x56WMtb2nQ==
Date: Tue, 29 Oct 2024 15:55:35 -0600
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
Subject: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in struct
 ethtool_link_settings
Message-ID: <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
References: <cover.1730238285.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730238285.git.gustavoars@kernel.org>

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
Changes in v2:
 - None.

v1:
 - Link: https://lore.kernel.org/linux-hardening/e9ccb0cd7e490bfa270a7c20979e16ff84ac91e2.1729536776.git.gustavoars@kernel.org/

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
2.43.0


