Return-Path: <netdev+bounces-279881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EdnMEBy5mlgwgEAu9opvQ
	(envelope-from <netdev+bounces-279881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29343432F0A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD466328D5F2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A63A1A5D;
	Mon, 20 Apr 2026 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRuWm8v1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FA3A16B0
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705529; cv=none; b=XP4BJ2kaqmnfqmah/BPbhf751/3b08bY8OfHQNTpPPoOOJvmytAQcZz+Mn6bVNLVX3QVp30qJ8vnDF+PTQZSq19irF4FtdoIgObmNZZni/+qZmTJnRmjtNWkQzDnfI5fvWT5PcEROnQyPFI1x7MfGy9fuMdISsXkpOTbTDwdxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705529; c=relaxed/simple;
	bh=7HuwCMtFhgkI3i3Cm8hedgvjuhF+HqVN4oV9qkEM0Sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W8obYSaZP44lnXUGNAaZQ/csaHBC0gOfcFrUrWzNNoxlV1vB8kuo7FBKEVE+q6myhKXzx8/w5qv8R7gCuWA9DFJRyAPfDdqSQRgh4M4BiyZev5+lr800hCbJ/UNhIGmdvqg5GzSfxreUzi5F8+Vuo7FfgDEFNfifpM5C4auUuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRuWm8v1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so3075036a91.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705527; x=1777310327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKhjtZffpudnSoigZVFDRJbxGYPsECcpyVW6J8Asv1A=;
        b=LRuWm8v1jk//MkqP3MDX0GqHo6YebJUMYDm8egJFq6FIz7dm8lOSSwSQ4s+EBOuNRt
         1tzaX58w3Lz+FYAxF50gJ14irrhlheWq6ez+sI5SCOB4dHkqGRjLwxLMbYjlvgWAQcS+
         Vj3eWgif11QzlNTWGIz82At2iO1v/ulKwmBUllQ1st+HIj/XbvU+9Z4sQD8FkhuuzTsV
         RqyAdlYJiWNHmUSwbuvWiQVUUtLYk0Nb6yVhscyUBsbr4FEiS9QeIprfeT+mu0se4AzZ
         SE/AdoczyBwAoFgNS7UE+oz2LsP0EUbooFmrh+4AgbyYwC6oQt1xUWWNc+icgE46Yvrl
         LuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705527; x=1777310327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKhjtZffpudnSoigZVFDRJbxGYPsECcpyVW6J8Asv1A=;
        b=c2G4rvQlawxiGTKAG7uxQPoZoftc5rGRF4LT1fHs/gSiVNyn4GpaM7gY5AN8l2r3YT
         lLoc2LF0aeWwoljq8PeYZO741TNeqSe3duLZenglnilvY1qON7BCdlwuRLzuraJ56ObC
         nla5IQuaeHxTUmro+NdFRQ0Y6LXaforsgoflrbS7jUVgmfvWDzdoZ8uJWqezHESFOLtC
         FmZufySj6VaXRoa0WximRzVNt1cMPMd15O4tkhuBE2SMIxQ7FJA5pTSQZ05OGz04F60d
         L3C8vqWdv+gD8VEmfrvMxHGrhgGhkRqlMdtHiNePS72Z0XK9oqUStWXD7zWpaUFyi21b
         NRBQ==
X-Gm-Message-State: AOJu0YzwqPBQFyZKATKf7xEFR1euA5tYPN3n1pmNbnTyQ9NWBlvwTF8T
	K/jezuWbrvZkEm7MfglOJxRHHxRWNJ3RWjt8DPvgH7UH/nExiFPxcDcxDe9eoOhvMIi4//QFY+B
	o08q983qmM8W2Q0rRZd1rcBArnbfqOGDb3iKlcZ5yuUh5g00Bo8bvPY8atIYYK3I8qVWI39ChVU
	zgoI3CteBrpITzYqSHSSGANLFY9cOWmWC6m6E1S807LLdw0n8TC96sXM9Y4/jH1jI=
X-Received: from pjbev4.prod.google.com ([2002:a17:90a:eac4:b0:35f:b87d:dbd])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7d0:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-361404945e0mr15500805a91.23.1776705526822;
 Mon, 20 Apr 2026 10:18:46 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:37 +0000
In-Reply-To: <20260420171837.455487-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-5-hramamurthy@google.com>
Subject: [PATCH net 4/4] gve: Make ethtool config changes synchronous
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279881-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29343432F0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pin-yen Lin <treapking@google.com>

When modifying device features via ethtool, the driver queues the
carrier status update to its workqueue (gve_wq). This leads to a
short link-down state after running the ethtool command.

Use `gve_turnup_and_check_status()` instead of `gve_turnup()` in
`gve_queues_start()` to update the carrier status before returning to
the userspace.

This was discovered by drivers/net/ping.py selftest. The test calls
ping command right after an ethtool configuration, but the interface
could be down without this fix.

Cc: stable@vger.kernel.org
Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8617782791e0..d3b4bec38de5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1374,6 +1374,33 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	priv->rx = NULL;
 }
 
+static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
+{
+	if (!gve_get_napi_enabled(priv))
+		return;
+
+	if (link_status == netif_carrier_ok(priv->dev))
+		return;
+
+	if (link_status) {
+		netdev_info(priv->dev, "Device link is up.\n");
+		netif_carrier_on(priv->dev);
+	} else {
+		netdev_info(priv->dev, "Device link is down.\n");
+		netif_carrier_off(priv->dev);
+	}
+}
+
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	gve_turnup(priv);
+	status = ioread32be(&priv->reg_bar0->device_status);
+	gve_handle_link_status(priv,
+			       GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+}
+
 /* The passed-in queue memory is stored into priv and the queues are made live.
  * No memory is allocated. Passed-in memory is freed on errors.
  */
@@ -1434,8 +1461,7 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
-	queue_work(priv->gve_wq, &priv->service_task);
+	gve_turnup_and_check_status(priv);
 	priv->interface_up_cnt++;
 	return 0;
 
@@ -1548,23 +1574,6 @@ static int gve_close(struct net_device *dev)
 	return 0;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
-{
-	if (!gve_get_napi_enabled(priv))
-		return;
-
-	if (link_status == netif_carrier_ok(priv->dev))
-		return;
-
-	if (link_status) {
-		netdev_info(priv->dev, "Device link is up.\n");
-		netif_carrier_on(priv->dev);
-	} else {
-		netdev_info(priv->dev, "Device link is down.\n");
-		netif_carrier_off(priv->dev);
-	}
-}
-
 static int gve_configure_rings_xdp(struct gve_priv *priv,
 				   u16 num_xdp_rings)
 {
@@ -2039,15 +2048,6 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
-static void gve_turnup_and_check_status(struct gve_priv *priv)
-{
-	u32 status;
-
-	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
-}
-
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
 							unsigned int txqueue)
 {
-- 
2.54.0.rc0.605.g598a273b03-goog


