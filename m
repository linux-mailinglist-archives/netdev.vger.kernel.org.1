Return-Path: <netdev+bounces-238444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C2EC58F9B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9659B34CE85
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623A35BDCF;
	Thu, 13 Nov 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcY7hcHF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820035BDCC
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051613; cv=none; b=H8hdsVv3HVCXl/eOtur7PsXm7bOzJeC1QUm8zAvq+KpFfHmhYlR2GwoWp0ZNXH3M8SS+R3rK/PHbD2gnthb2H1QFmsQg2/9A1hvH1IoKapAt+hS/whV0EBOaqnQjtyTUoD6KPNwYbm7YAmGP+Pt266hC+anJAeRMLtvWPEWtFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051613; c=relaxed/simple;
	bh=jg86UAZlbo0kva6wH/gdGGi5OzEg2qpxgD1ZU1Q6wS4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrWxv4ym5+wFh6UhHBLMdDM1TnFczdvJ2Hi66UijkR/t9Z5WPDXizzeXCpvMPYksHkgDw//SnfTrH/WYjr4AzgD3LzaXmvvv+rKVHAArjaNM824CLDePVGxDCS7qeIFiWFjlMHZ2bW35+yOcYdle8tJ6F6NOgSRNmwtciZA+AYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcY7hcHF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782e93932ffso851682b3a.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051611; x=1763656411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKHAc934kvSRFqWHGkEjU76SDQjUz1tgAFmDQdrl0ZY=;
        b=RcY7hcHFwN6MWNbs5483UjjB3aoH0rzWNMnBw8dzz+XKySNG9HwKRxOvCP4w8VABCk
         V99l/PbRu7FIayFhiUKxtby69mLMYTbCDVtZtDn4OgNDpQUcQ5YMygkJo3tHmJ1yDNoq
         adwt0d2+Un041CDNZemP78tilSyNHFmL2K5nsBvD3KpbYq/UTEWXdsNDyyJRMst4cTmH
         yVCViMDKQrBh+VFlxqP9Fb4RczmsBsj2ji+GphuzBQhwCepcbUyG7cIu374NE2FHSpJJ
         Tmzd8bhwjloTlhqLPRbCLFjpuIGgj9J+FujPHaDDufU1c3w7DAyv//B7z4N5Zc9ps/sU
         rH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051611; x=1763656411;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKHAc934kvSRFqWHGkEjU76SDQjUz1tgAFmDQdrl0ZY=;
        b=idp7QnjXSEcP+mEvFhaBI/AtGVyQhdEe8V6NbTsi+Z8jNS5D2g/YCTD5SN7pZE7UPm
         0wR9rHYtqf6Ttafy0+aT1R1GXJNxqFDzzD5pLZCGY2jez5yHnS8aeV9cRp89/xwG9ltr
         I/fuqJPyCqWf+Ndj0G6AqOvyhTljwo2L2u/rdCGKS9xYVurb37D8x8YUeb/r/IAcsa2p
         m70zjFnVY693mHCQK3P7bYWrqlfMtON654555SqXZo2DuZ09N9tP+C5E3sB05RL4Biqa
         E1R7YHXfL/3SkMixYfbn+LtDQXWXR8LRHdzOd9Zp26epi25btIKC1O5RpQBkGPDNqCFp
         gBDA==
X-Gm-Message-State: AOJu0Yytmr7e1wUR1PMyECnFTm6ELBQndERkAIuLKr31gcPpB1Ku703k
	X84Fbp8jwDZMB2eJkazAXRv3NlB+m13d63leVYumCPfhQvn9KV7LWIGm
X-Gm-Gg: ASbGnctPyRokssYA159uI7W5HLS7PHL71w5+AaOHwWGRm3f0gOyp8ah++BxZzXtXM9B
	LC1mGTva+y1RcLb8VRArL1Wu9dXzxsCzK2dX7MBQxCwZBPJ8bXNAKdeCrbfqoEOfkI+7xS+bsXB
	KpwoSMU5nhySSYm8eYaES1i7HwzVvWsiQGKzZxhVe8+nULol3B3sDsKJ15Tq6HxEZzskyP2UWGc
	7cVmcHTh7uMqWKcJZy5qsfsh5Q8bUT9ARNOaMo8s0/De37nOj5SeiHvkrAkxtuvudqTMXZG4D+l
	jE6I1D5whwxrv45YMfRAgK5IP16n15a6P7sWCkEi9piSYG24VKB1e7VMdAzwHdHYJO6rQHAIfV4
	tsxF633ak1+YMTzkcvfO5AB+9Jh678b6zjhCipiKF9xtof30cOji+kNQMa8rA9k6lDNTvR/gCnL
	3kO1EPFB1mKL8WMmWv2mL4RsKlUPqJ0s7yk/br4iscKaUS
X-Google-Smtp-Source: AGHT+IG4IgLUJU4aSdgmoqLhc41FC+GaoOx67m8dClL1AaVH4+5Bur/Xtuyc8UfeVY9kR0o7ak4cPw==
X-Received: by 2002:a05:6a21:33a1:b0:344:8ef7:7a03 with SMTP id adf61e73a8af0-35ba2992e6dmr262042637.56.1763051610753;
        Thu, 13 Nov 2025 08:33:30 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ec7e613sm2610111a12.12.2025.11.13.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:30 -0800 (PST)
Subject: [net-next PATCH v4 05/10] net: pcs: xpcs: Add support for FBNIC 25G,
 50G, 100G PMA
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:29 -0800
Message-ID: 
 <176305160922.3573217.15600715775253171400.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic driver is planning to make use of the XPCS driver to enable
support for PCS and better integration with phylink. To do this though we
will need to enable several workarounds since the PMA/PMD interface for
fbnic is likely to be unique since it is a mix of two different vendor
products with a unique wrapper around the IP.

As such I have generated a PHY identifier based on IEEE 802.3-2022
22.2.4.3.1 using the OUI belonging to Meta Platforms and used with our
NICs. Using this we will provide it as the PHY ID via the SW based MDIO
interface so that the fbnic device can be identified and necessary
workarounds enabled in the XPCS driver.

As an initial workaround this change adds an exception so that soft_reset
is not set when the driver is initially bound to the PCS.

In addition I have added logic to integrate the PMA link state into the
link state for the PCS. With this we can avoid the link coming up too soon
on the FBNIC PHY and as a result we can avoid link flaps.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c   |   23 +++++++++++++++++++++--
 include/linux/pcs/pcs-xpcs.h |    2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 8b5b5b63b74b..69a6c03fd9e7 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -597,7 +597,25 @@ static int xpcs_c45_read_pcs_speed(struct dw_xpcs *xpcs,
 static int xpcs_resolve_pma(struct dw_xpcs *xpcs,
 			    struct phylink_link_state *state)
 {
-	int err = 0;
+	int pma_stat1, err = 0;
+
+	/* The Meta Platforms FBNIC PMD will go into a training state for
+	 * about 4 seconds when the link first comes up. During this time the
+	 * PCS link will bounce. To avoid reporting link up too soon we include
+	 * the PMA/PMD state provided by the driver.
+	 */
+	if (xpcs->info.pma == MP_FBNIC_XPCS_PMA_100G_ID) {
+		pma_stat1 = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_STAT1);
+		if (pma_stat1 < 0) {
+			state->link = false;
+			return pma_stat1;
+		}
+
+		if (!(pma_stat1 & MDIO_STAT1_LSTATUS)) {
+			state->link = false;
+			return 0;
+		}
+	}
 
 	state->pause = MLO_PAUSE_TX | MLO_PAUSE_RX;
 	state->duplex = DUPLEX_FULL;
@@ -1591,7 +1609,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 
 	xpcs_get_interfaces(xpcs, xpcs->pcs.supported_interfaces);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID ||
+	    xpcs->info.pma == MP_FBNIC_XPCS_PMA_100G_ID)
 		xpcs->pcs.poll = false;
 	else
 		xpcs->need_reset = true;
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 4cf6bd611e5a..36073f7b6bb4 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -39,6 +39,8 @@ enum dw_xpcs_pma_id {
 	DW_XPCS_PMA_GEN5_10G_ID,
 	DW_XPCS_PMA_GEN5_12G_ID,
 	WX_TXGBE_XPCS_PMA_10G_ID = 0xfc806000,
+	/* Meta Platforms OUI 88:25:08, model 0, revision 0 */
+	MP_FBNIC_XPCS_PMA_100G_ID = 0x46904000,
 };
 
 struct dw_xpcs_info {



