Return-Path: <netdev+bounces-199257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F5ADF933
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE617AA6B9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59827E066;
	Wed, 18 Jun 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMnIeSnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302D2580FF
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284459; cv=none; b=DJJsGw1aQP3C8dLOKfo1knw+BBrGeXM/t4HLXWi8BEETmIArFN8xu1Yo2WmZb1gm5lLE2o/cPzThb5dw9+BBqrahGWyHYrRyqO59wfp+YkrTCEraL1+9EZ7YDwQ1r/gUCUWssYboab4FY+0fr7notlm2J4X/sv+61DEsjgPYhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284459; c=relaxed/simple;
	bh=QOKu7lk8kgaPxuY/IMONXJo14+qY58aqMhkViZbG8v0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMm76DMlhcvZCSgDRDG3PruwPeod9bEXsD9+2Rc0urcUkjqq2rvezxLtmNDnAQqQBhd9YSGpdSAWQnzaCTnQMqoc2bReccqq/uNSImA+FGDNdnCh32a9cOGYw5LxiJPYPvvFsiMLJPNX5P/G4Gt3ar6rnf0zwAIziKalhaugNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMnIeSnj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234b9dfb842so2108145ad.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284457; x=1750889257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xnk5Ipa9mN5lqV5s0VEFSw9LlfkWrrwBVuRWcxw3vAI=;
        b=dMnIeSnjxDyEFLGraUryobWaEGNL6gykyvSy9RqEKXEHVrprVhU2JC/8yzW51l2F34
         5kHrwpSFMzeJeDi8+yk/cZXD3BCEikMtKPhST+K839088Ko061UhVo1m4zZM7fsK0flW
         0vGt0QGCsp6tHNbqU7xXkvnqIxpjaVgacfP13MIrCFI/xxqnmzF65reCrHc/c15Ai5SF
         rkFqVkUogO522PIZTDwGsUp/GrdFaMKc/CFjy69aJRISDYlVuhp+qtS70/e29cKKLca+
         /WiEzbsvsNnI7kARmidjGlfrniFJIc4v67+sS15yJl82YSaj0G/2Kloc6vDzU3FefLBh
         +PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284457; x=1750889257;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnk5Ipa9mN5lqV5s0VEFSw9LlfkWrrwBVuRWcxw3vAI=;
        b=Wqj9fqRt6EFtn6VA6NkzHiYuEcjZT0z5kL8abO+PJzOAXMj+WpFUx8Ku5rcSAcCHS2
         NkDoxSee2wseOnlIM/KmugkGQoDWfNqsuN7nuybk/zGBHt1P6+IEFCSvejqiddS5kuU6
         OebNugkXmCqht6HjOq3LbNcLhFqqJJkt0fHUI5GwZU4rCw4nZOb0HoOjK65KqnpiUheO
         hj7mXytkbtak0HA+p3VaDLUmesiDMyjoZEgE4qyctdFH2k9bJJOzs3X3Z6B7ha7w4c5k
         tQYXzcgcwnZjRUxRDcmaW7mHzLeiptU1Bm/h016nzhMkxhFFYBxWy5PGLI3UKj9O2iz+
         Tnxg==
X-Gm-Message-State: AOJu0YxcJmfonipc9bOw5PTd1/HVp2ZMo5zA2TdmJDCdCwxTveB04wlR
	kctp3WRDevcHruRYS7dIT8/ULcyU0GTzrjpGYxldWomx87zVGj9TOi8Y
X-Gm-Gg: ASbGncuDyl7CYzbzQFBw5lIvvyt0KY2jD+B/45CHtklaNvJoSh5Kw7y4TbIKkyGOCJB
	Z8F7MBSW1cjioQhnQlOaliaozOZWlT8Lyv0h5Q10AFNOXErWhNsKT6QJVO9ckxdGt103kT0Lqsf
	5uZEdc1Yhbz8FesQtqy66rc/fo7tKDbgjLqeCotdALgBPPRsvbo1U1PkW0J2Oz+zuSw599j69Q6
	kLJhmbSFCFdZ0ejadURrPqrOa7BoUBjlj67/1+v8B3Zs/syh+SVZTAWPWhz+1cHTyqRk0h3lQwN
	KyLD8Su1pFPIzUAZocf72SBvyrLrWiF5LlniFf5shENiw9hfSR2nnmMW37CHh3dfvx4HYCYjxKR
	hgUiiZUVmUVkS5g==
X-Google-Smtp-Source: AGHT+IGhIbr/DOF205MdgO4ObhsNv1wNXdrCqVBA51r5tDbOp0NHWzLOX850cb7ziUGmyLmwOETWIA==
X-Received: by 2002:a17:903:3a83:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-2366b3e34f0mr318926355ad.53.1750284456964;
        Wed, 18 Jun 2025 15:07:36 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.35.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781dfsm106410985ad.131.2025.06.18.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:07:36 -0700 (PDT)
Subject: [net-next PATCH v3 3/8] fbnic: Retire "AUTO" flags and cleanup
 handling of FW link settings
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:07:35 -0700
Message-ID: 
 <175028445548.625704.1367708155813490215.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
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

There were several issues in the way we were handling the link info coming
from firmware.

First is the fact that we were carrying around "AUTO" flags to indicate
that we needed to populate the values. We can just drop this and assume
that we will always be populating the settings from firmware. With this we
can also clean up the masking as the "AUTO" flags were just there to be
stripped anyway.

Second since we are getting rid of the "AUTO" setting we still need a way
to report that the link is not configured. We convert the link_mode "AUTO"
to "UNKNOWN" to do this. With this we can avoid reporting link up in the
phylink_pcs_get_state call as we will just set link to 0 and return without
updating the link speed. This is preferred versus the driver just forcing
50G which makes it harder to recover when the FW does start providing valid
settings.

With this the plan is to eventually replace the link_mode we use with the
interface_mode from phylink for all intents and purposes and have the two
be interchangeable. At that point we can convert the FW provided settings
over to something closer to link partner settings and give phylink greater
control of the interface allowing for user override of the settings and an
asynchronous setup of the link versus having to pull early settings from
firmware.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   89 ++++++++++-------------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |    6 --
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    2 -
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   17 ++--
 4 files changed, 48 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index ea5ea7e329cb..56b429c96a7c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -452,7 +452,7 @@ static u32 __fbnic_mac_cmd_config_asic(struct fbnic_dev *fbd,
 		command_config |= FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS;
 
 	/* Disable fault handling if no FEC is requested */
-	if ((fbn->fec & FBNIC_FEC_MODE_MASK) == FBNIC_FEC_OFF)
+	if (fbn->fec == FBNIC_FEC_OFF)
 		command_config |= FBNIC_MAC_COMMAND_CONFIG_FLT_HDL_DIS;
 
 	return command_config;
@@ -468,7 +468,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 		return false;
 
 	/* Define the expected lane mask for the status bits we need to check */
-	switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
+	switch (fbn->link_mode) {
 	case FBNIC_LINK_100R2:
 		lane_mask = 0xf;
 		break;
@@ -476,7 +476,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 		lane_mask = 3;
 		break;
 	case FBNIC_LINK_50R2:
-		switch (fbn->fec & FBNIC_FEC_MODE_MASK) {
+		switch (fbn->fec) {
 		case FBNIC_FEC_OFF:
 			lane_mask = 0x63;
 			break;
@@ -494,7 +494,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 	}
 
 	/* Use an XOR to remove the bits we expect to see set */
-	switch (fbn->fec & FBNIC_FEC_MODE_MASK) {
+	switch (fbn->fec) {
 	case FBNIC_FEC_OFF:
 		lane_mask ^= FIELD_GET(FBNIC_SIG_PCS_OUT0_BLOCK_LOCK,
 				       pcs_status);
@@ -540,64 +540,55 @@ static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
 	return link;
 }
 
-static void fbnic_pcs_get_fw_settings(struct fbnic_dev *fbd)
+static void
+fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *link_mode, u8 *fec)
 {
-	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
-	u8 link_mode = fbn->link_mode;
-	u8 fec = fbn->fec;
-
-	/* Update FEC first to reflect FW current mode */
-	if (fbn->fec & FBNIC_FEC_AUTO) {
-		switch (fbd->fw_cap.link_fec) {
-		case FBNIC_FW_LINK_FEC_NONE:
-			fec = FBNIC_FEC_OFF;
-			break;
-		case FBNIC_FW_LINK_FEC_RS:
-			fec = FBNIC_FEC_RS;
-			break;
-		case FBNIC_FW_LINK_FEC_BASER:
-			fec = FBNIC_FEC_BASER;
-			break;
-		default:
-			return;
-		}
-
-		fbn->fec = fec;
+	/* Retrieve default speed from FW */
+	switch (fbd->fw_cap.link_speed) {
+	case FBNIC_FW_LINK_SPEED_25R1:
+		*link_mode = FBNIC_LINK_25R1;
+		break;
+	case FBNIC_FW_LINK_SPEED_50R2:
+		*link_mode = FBNIC_LINK_50R2;
+		break;
+	case FBNIC_FW_LINK_SPEED_50R1:
+		*link_mode = FBNIC_LINK_50R1;
+		*fec = FBNIC_FEC_RS;
+		return;
+	case FBNIC_FW_LINK_SPEED_100R2:
+		*link_mode = FBNIC_LINK_100R2;
+		*fec = FBNIC_FEC_RS;
+		return;
+	default:
+		*link_mode = FBNIC_LINK_UNKONWN;
+		return;
 	}
 
-	/* Do nothing if AUTO mode is not engaged */
-	if (fbn->link_mode & FBNIC_LINK_AUTO) {
-		switch (fbd->fw_cap.link_speed) {
-		case FBNIC_FW_LINK_SPEED_25R1:
-			link_mode = FBNIC_LINK_25R1;
-			break;
-		case FBNIC_FW_LINK_SPEED_50R2:
-			link_mode = FBNIC_LINK_50R2;
-			break;
-		case FBNIC_FW_LINK_SPEED_50R1:
-			link_mode = FBNIC_LINK_50R1;
-			fec = FBNIC_FEC_RS;
-			break;
-		case FBNIC_FW_LINK_SPEED_100R2:
-			link_mode = FBNIC_LINK_100R2;
-			fec = FBNIC_FEC_RS;
-			break;
-		default:
-			return;
-		}
-
-		fbn->link_mode = link_mode;
+	/* Update FEC first to reflect FW current mode */
+	switch (fbd->fw_cap.link_fec) {
+	case FBNIC_FW_LINK_FEC_NONE:
+		*fec = FBNIC_FEC_OFF;
+		break;
+	case FBNIC_FW_LINK_FEC_RS:
+	default:
+		*fec = FBNIC_FEC_RS;
+		break;
+	case FBNIC_FW_LINK_FEC_BASER:
+		*fec = FBNIC_FEC_BASER;
+		break;
 	}
 }
 
 static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
 {
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
 	/* Mask and clear the PCS interrupt, will be enabled by link handler */
 	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
 
 	/* Pull in settings from FW */
-	fbnic_pcs_get_fw_settings(fbd);
+	fbnic_mac_get_fw_settings(fbd, &fbn->link_mode, &fbn->fec);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 4d508e1e2151..f4e75530a939 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -25,11 +25,8 @@ enum {
 	FBNIC_FEC_OFF		= 0,
 	FBNIC_FEC_RS		= 1,
 	FBNIC_FEC_BASER		= 2,
-	FBNIC_FEC_AUTO		= 4,
 };
 
-#define FBNIC_FEC_MODE_MASK	(FBNIC_FEC_AUTO - 1)
-
 /* Treat the link modes as a set of modulation/lanes bitmask:
  * Bit 0: Lane Count, 0 = R1, 1 = R2
  * Bit 1: Modulation, 0 = NRZ, 1 = PAM4
@@ -40,12 +37,11 @@ enum {
 	FBNIC_LINK_50R2		= 1,
 	FBNIC_LINK_50R1		= 2,
 	FBNIC_LINK_100R2	= 3,
-	FBNIC_LINK_AUTO		= 4,
+	FBNIC_LINK_UNKONWN	= 4,
 };
 
 #define FBNIC_LINK_MODE_R2	(FBNIC_LINK_50R2)
 #define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
-#define FBNIC_LINK_MODE_MASK	(FBNIC_LINK_AUTO - 1)
 
 enum fbnic_sensor_id {
 	FBNIC_SENSOR_TEMP,		/* Temp in millidegrees Centigrade */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index aa812c63d5af..7bd7812d9c06 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -736,8 +736,6 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	 */
 	netdev->ethtool->wol_enabled = true;
 
-	fbn->fec = FBNIC_FEC_AUTO | FBNIC_FEC_RS;
-	fbn->link_mode = FBNIC_LINK_AUTO | FBNIC_LINK_50R2;
 	netif_carrier_off(netdev);
 
 	netif_tx_stop_all_queues(netdev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 860b02b22c15..cb375a3dafe8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -21,23 +21,20 @@ fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
 	struct fbnic_dev *fbd = fbn->fbd;
 
-	/* For now we use hard-coded defaults and FW config to determine
-	 * the current values. In future patches we will add support for
-	 * reconfiguring these values and changing link settings.
-	 */
-	switch (fbd->fw_cap.link_speed) {
-	case FBNIC_FW_LINK_SPEED_25R1:
+	switch (fbn->link_mode) {
+	case FBNIC_LINK_25R1:
 		state->speed = SPEED_25000;
 		break;
-	case FBNIC_FW_LINK_SPEED_50R2:
+	case FBNIC_LINK_50R2:
+	case FBNIC_LINK_50R1:
 		state->speed = SPEED_50000;
 		break;
-	case FBNIC_FW_LINK_SPEED_100R2:
+	case FBNIC_LINK_100R2:
 		state->speed = SPEED_100000;
 		break;
 	default:
-		state->speed = SPEED_UNKNOWN;
-		break;
+		state->link = 0;
+		return;
 	}
 
 	state->duplex = DUPLEX_FULL;



