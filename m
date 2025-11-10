Return-Path: <netdev+bounces-237261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF71C47CE3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE39B18957FF
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13627586C;
	Mon, 10 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbUfC07Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC1266B67
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790520; cv=none; b=oqF4ZcEdBwHFlhUc43IlsdlKBIGrnUSzgW4IwadsdL+IrKjPPHgJjwu3p2/ibpZtSIDEOhSdgu68n43qhyZFD3qv0aSqpzPksmYDgyU/CyEkvJ7Nju+RWwEFULkOk+LHhotI0ANMwFglGwMzbtKJzxM1ly5covLV0qpy8t6lTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790520; c=relaxed/simple;
	bh=7leYNXo1PDbOZQ2gAgGBsoiZa4y0u9rMWMBHESb2mJA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFIkqwGVfnlX3yhtN+/BpE8BvLIeN5BifbKHD7NuFWI0BXKu+UIlWj3uSEMod9JB5hnffv4i3UzMwDscEFqmIUI7+EatiVNwmNjNHJBR2cahlKUh+VTiZ6fUqU/tR8j2AtrLELoSo3kdyUauWr39QNamBV9MwunUKZZ5RtmIhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbUfC07Q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2957850c63bso31925155ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790518; x=1763395318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GIjPMBWcXrHpzcycCBxtvnjtYSxYnrX3oqg5pRXkRd4=;
        b=EbUfC07QzhnB8J9dCO8dnYqnGM3djBzc6+nzmPM7BpX3h96GciWiJLmieWwl4fxbu+
         sUMLXfssscG9ZsFBUriO8Ms5sJUJT0xVSXQDcj6E6/JgZKQiyJZs4w5K8JeufHK1+Qx4
         oHPXxyZLm9r8phb1Abl1jW7LpXECEhtidtWm6dpzFaruG3Tf4G6NoG/GNngtHUzYpt2O
         L6ocEe3KdogJpjwH6jCEV1sfIDQvaL0EF0YevCkt27Glau5aH3V6bnFM9Oc+CKZjwPO/
         baFfUXHI0RY9T/2OQOFFSQjQTDhrqUa3tC2rpIeo/zbHqu2AY8G5x/IGKQnlTstQU2Q5
         cofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790518; x=1763395318;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIjPMBWcXrHpzcycCBxtvnjtYSxYnrX3oqg5pRXkRd4=;
        b=nfleo84HGtANZc9DvEm0znOHHPVKwRaprq5yCHAJRAglPUSJQ/X42SlcxVdILwveSq
         OPwTILmN7cDzAkeqqAy09taqJyP/lEDxCOsY97nkCDm6wPo/QE5y/J2eXDN/QGtygKjO
         QPreaTKw60BdlOj6xsb9AZ8GjlH7iRLtpf0J2sIfZ2nV/++uSlXeJXh9TysNQEfOLkMx
         iAZszIo4ZAg/Jk/9kVEbTaD4y6g6SmLqM8uPZKjmp0Q5+WyobkRP1LjwISxueb9rJbUr
         y6l0JnPTOKtSNPvU5uc48/7lOWdTkrflN7YcG+LnAqdB2u9/1dSImgEt3iiLgGRdDyqR
         g8lg==
X-Gm-Message-State: AOJu0Yy/9ga67CBkwWtZcLC7kVD7lUMjvMgujTsqqFZ7EUMeo1cMS7h8
	9C/5q/aoMzZGfUbgjWI/PIbesFhwawRqGp2/r0s3HJN9TlxEFDPsWRhh0audYg==
X-Gm-Gg: ASbGncu/1shhQGimWq0rkLtML4lvLbkDxFzSAf10HdHp7IpwghabnNG4WZXz9Ay++28
	qJouSIb1cfKHpB2i+vIsPdEnp72k7awQvQMtNM3jo5Q8UznSOW1jZsU4Z/14cop1+Rk2qvPcoA4
	8DY50jbFQGa1mXF1OCVw4s53q9+TkLAzPkVOHNmHM/GVujaIGOaaN7KxOHlPwFoNXnqSyWL9XHm
	JUlWdWw+MjlzfkIxIQGXcXFn/+Skfs5uiN83R0Tc+b88QAdAc/09I779giUzx9g6kdQ/Otmw9cw
	EQxcPl7U9E2/bBRxNzO35nAYqF3Uljn2DTUdJTdDiLbY0e9Sfobjkz3HGIUP5PPKVXpss4MZL4t
	hxppR6AiB9rGoVVeOA5fnQY3HSLI5vQGUWiuX+rfbpBHnFSag1T2BxOpWBD9NkSJaL9nZbk8TOP
	MfxhvKO6b2J8UHATzx9m/oCv9o8G4ehfJ3Ww==
X-Google-Smtp-Source: AGHT+IEkjDPlnJUMsEYWlsb3Jdt/2pzZ01yPjFDzOrWg8B3R/4zkBQlslkhC6/NRf9g3j45E9XkmNw==
X-Received: by 2002:a17:903:3884:b0:294:8c99:f318 with SMTP id d9443c01a7336-297e1d76b60mr114985345ad.3.1762790517477;
        Mon, 10 Nov 2025 08:01:57 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93cebsm150562725ad.90.2025.11.10.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:01:56 -0800 (PST)
Subject: [net-next PATCH v3 08/10] fbnic: Cleanup handling for link down event
 statistics
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:01:55 -0800
Message-ID: 
 <176279051573.2130772.15464539424610071720.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
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

The code for handling link down event tracking wasn't working in the
existing code. Specifically we should be tracking unexpected link down
events, not expected ones.

To do this tracking we can use the pmd_state variable and track cases where
we transition from send_data to initialize in the interrupt. These should
be the cases where we would be seeing unexpected link down events.

In addition we have cases where the PCS will reset following the training
due to errors generated while the PMD was training. This will result in a
PCS reset which will flap the link. To avoid counting this link flap as the
NIC has yet to report link up we will only record the link event if the
netif_carrier was already reporeted as present.

In order for the stat to have any value we have to display it so this
change adds logic to display it as a part of the ethtool stats.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    9 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   13 ++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    2 --
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 95fac020eb93..693ebdf38705 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1863,6 +1863,14 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 	*ranges = fbnic_rmon_ranges;
 }
 
+static void fbnic_get_link_ext_stats(struct net_device *netdev,
+				     struct ethtool_link_ext_stats *stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	stats->link_down_events = fbn->link_down_events;
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.cap_link_lanes_supported	= true,
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
@@ -1874,6 +1882,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
 	.get_link			= ethtool_op_get_link,
+	.get_link_ext_stats		= fbnic_get_link_ext_stats,
 	.get_coalesce			= fbnic_get_coalesce,
 	.set_coalesce			= fbnic_set_coalesce,
 	.get_ringparam			= fbnic_get_ringparam,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 9b068b82f30a..73dd10b7a1a8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -122,6 +122,7 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 {
 	struct fbnic_dev *fbd = data;
 	struct fbnic_net *fbn;
+	u64 link_down_event;
 
 	if (fbd->mac->get_link_event(fbd) == FBNIC_LINK_EVENT_NONE) {
 		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
@@ -129,11 +130,21 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 		return IRQ_HANDLED;
 	}
 
+	/* If the link is up this would be a loss event */
+	link_down_event = (fbd->pmd_state == FBNIC_PMD_SEND_DATA) ? 1 : 0;
+
 	fbn = netdev_priv(fbd->netdev);
 
 	/* Record link down events */
-	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec))
+	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec)) {
+		/* Do not count link down events if the PCS has yet to
+		 * acknowledge the link. This allows for the flushing out
+		 * PCS errors generated during link training.
+		 */
+		if (netif_carrier_ok(fbd->netdev))
+			fbn->link_down_events += link_down_event;
 		phylink_pcs_change(&fbn->phylink_pcs, false);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 27e4073d9898..592e9642a418 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -203,8 +203,6 @@ fbnic_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	fbd->mac->link_down(fbd);
-
-	fbn->link_down_events++;
 }
 
 static void



