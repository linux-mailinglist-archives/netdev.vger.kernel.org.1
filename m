Return-Path: <netdev+bounces-183982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7985BA92E7A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89783443F4C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743922257D;
	Thu, 17 Apr 2025 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIvnqzt6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B59222571
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934197; cv=none; b=nBUj72WoDLWor/ybN3SUhVx9Xe1aEWEFMHSLRXi80IFI4g9aQIX+2LdXRnLG1LxwTTees3ZIpl6rZArshDDowpgvaZrABYXkFPHUCqbpjtOs/cpQ6Nnv8NF/FYk43xalITxH4eJHULpUQRqpnLZXDOzieB896AmG5ePwmaZSha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934197; c=relaxed/simple;
	bh=CenLiOMEtgVzz9HOrRihlO1iUzThlCTJbH2a34BuKTg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ozharpy3EbwEDR/ox/m/LcoV6A9qvhqm3HeDrHSiCbdI2xIQNhMYF2Iw3iwrn6Tf1CZKvD5epf/0ijPgBRtcpMa1Id/lzN8t0jYdHPxcJAWhDL6ssKqEd2fyWDkHxfWcwpz4O5MAOQlbbKlVK7ryHO6EOHP6EOvnkVphawmZsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIvnqzt6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736a72220edso1348875b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744934194; x=1745538994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6MmRT/Zn1VtRRTUXdSGNQI9jsqOBRVRUU0n/R22O+gw=;
        b=HIvnqzt6a0B1Il5Vm3N+seAkDE7I23R6jr7axhCfYHIbWIOXO47zMp8Zi9+KgQhES5
         vU0ExCr202QssMuqUzfUofiZ4ct/LdPzmoX1Z0wXFsO+VkwxURPkXY6ectDkFyvfGY/x
         aBXZVBIFp9ZnOGHpnZt/gRoSz5xBqR5sLMlf2S9zNO9VaB83J038J56icbCOegjZs3e0
         xSveQJTG8m6fSprpE4pMnAuvtojZVoE7jKnhhKJeo3bWtTuqxtsrTiAYWvdkGXTlSTxY
         RY1zv/7REWUgSxxebeGKFiwtfPT/KGHI/UlyyThTEXCvJJQuinjuaMzfzsykFrK65r5v
         Qo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934194; x=1745538994;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MmRT/Zn1VtRRTUXdSGNQI9jsqOBRVRUU0n/R22O+gw=;
        b=CON5OLczl2/59IFC82fEAEcIxwXjxlTH1KVa3+DEWfEDtj3uXr3iqwtbRGdgY+jFuk
         MjqErY8iGs4WLRK9oLStD64lxCHrB+xxC3Cl9pUxaPCthR/s1NS+qb7BM7WkvIuQK/K8
         ZkTcuwElHYljxFFdTKUfI3cqnp+MUUMKVxiCeikhsZuqnZCtMyBMXeepsFBpQw3sxKiW
         ktknHRSpquQ3k5HsYKggNdO468g8Ko0GoEIJThVWLrrQkFlfQ5lSDbpvqm+AVBislhj3
         +PmpoTAX9zJtgCbzhfaMrBJFUF85atPlKuctbxm3UrNoyZOSkBYtch0dvepP0DwNlEgl
         m5UA==
X-Gm-Message-State: AOJu0YxeFipd4wtQ+j+sNX5gin/Ltb9KHoej8ZOtK6EahywyRCqdWqMe
	Wvb/kSSBY5zuKKqZPh2cquAVG0rX7olby/NoY6Vfs3m/6hc0Sb54
X-Gm-Gg: ASbGnctVtWVaMYKo/5O5OJWTWlaLU11s0qcifd4IxaXEPGxKQ8l3PksPybWm8+RTRTF
	Ois6AqVsZ9gy0IliAvlkGArH/phMjXOx4AFEzNVBgWg63fPCPsSn5qcF9S9pWlHvCZ/jDXhmmZP
	ozoyAvyiHh9aN+K9tUCZiRb/hR03wqpdkNGLFM5SD+1NHqUb+y9eaDO3qSJmtnHWiZ2Ch/MXJPv
	xvajnDktfuLbW7A9La6qpQU/qCrs5KaM3vkAV84p1IVHfO5qpE7vimM7eoXppmd92+GbV4wkV8u
	cFd5sgZAGzYQuRGYLb45jwLeCOp2nrvnmQxB5UkgXzw+wj+tFwKJtS7hwAqQ3vUkrNNquw==
X-Google-Smtp-Source: AGHT+IFEOB71XMGfMS21/4rrqfnTYOHzM6HJ10y/w2JgmLN/5wcXmkIPU0sLbMqBaGBouZXlyHE+ig==
X-Received: by 2002:a05:6a00:21c9:b0:736:457b:9858 with SMTP id d2e1a72fcca58-73dc1497da3mr990923b3a.10.1744934194231;
        Thu, 17 Apr 2025 16:56:34 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa5836bsm469329b3a.119.2025.04.17.16.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:56:33 -0700 (PDT)
Subject: [RFC PATCH 2/2] net: phylink: Extend phylink_suspend to support a
 "rolling stop"
From: Alexander Duyck <alexander.duyck@gmail.com>
To: linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org
Date: Thu, 17 Apr 2025 16:56:32 -0700
Message-ID: 
 <174493419290.1021855.6916017022620646335.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic driver has been abusing the wake-on-lan aspects of
phylink_suspend to leave the MAC up when the driver is unloaded or ifconfig
down is called.

Rather than rely on wake-on-lan we can use the rolling_start flag to
indicate that the device is prone to starting/stopping with the MAC link
up, and repurpose the mac_wol to indicate that we are requesting the
mac_link_up following the suspend.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    5 -----
 drivers/net/phy/phylink.c                      |    9 ++++++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 79a01fdd1dd1..05793811569d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -685,11 +685,6 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
 
-	/* TBD: This is workaround for BMC as phylink doesn't have support
-	 * for leavling the link enabled if a BMC is present.
-	 */
-	netdev->ethtool->wol_enabled = true;
-
 	fbn->fec = FBNIC_FEC_AUTO | FBNIC_FEC_RS;
 	fbn->link_mode = FBNIC_LINK_AUTO | FBNIC_LINK_50R2;
 	netif_carrier_off(netdev);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 66cd866959ef..792f9d512765 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2526,7 +2526,7 @@ EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
 /**
  * phylink_suspend() - handle a network device suspend event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
- * @mac_wol: true if the MAC needs to receive packets for Wake-on-Lan
+ * @mac_link_up: true if the MAC needs to receive packets after suspend
  *
  * Handle a network device suspend event. There are several cases:
  *
@@ -2536,12 +2536,15 @@ EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
  *   can also bring down the link between the MAC and PHY.
  * - If Wake-on-Lan is active, but being handled by the MAC, the MAC
  *   still needs to receive packets, so we can not bring the link down.
+ * - If rolling_start is requested, and the MAC is shared with a BMC, the MAC
+ *   still needs to receive packets, so we can not bring the link down.
  */
-void phylink_suspend(struct phylink *pl, bool mac_wol)
+void phylink_suspend(struct phylink *pl, bool mac_link_up)
 {
 	ASSERT_RTNL();
 
-	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
+	if (mac_link_up && (!pl->netdev || pl->netdev->ethtool->wol_enabled ||
+			    pl->config->rolling_start)) {
 		/* Wake-on-Lan enabled, MAC handling */
 		mutex_lock(&pl->state_mutex);
 



