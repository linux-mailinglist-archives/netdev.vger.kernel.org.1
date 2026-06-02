Return-Path: <netdev+bounces-294482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lZb+DbdwH2rilwAAu9opvQ
	(envelope-from <netdev+bounces-294482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:09:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F963319B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rR0oSDbj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294482-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294482-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28FC53126F61
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 00:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1373F9A05;
	Tue,  2 Jun 2026 23:59:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F353DB961
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:59:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444758; cv=none; b=vApiUQ8vXObUt+s3M/rEvbR335RERjjqDROLfDEh60X4hCKm9cm4ZCXeSrzCOh+ZY+DOwtDeG0TODF+lIyMB2w94edcrD5xo7ApZPLBVnslOQkgSOkpceIdxKfY8oATLEFixgqCj+mJn9SJ62M22pxcMMl404t+WtSdhd2G/ZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444758; c=relaxed/simple;
	bh=DGCE98+sf3gtOgL0DfJ4/GGRQT0Y2b64WXkjR4uZqZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVSYYg2sgucjJsaHmHNhwrmr3MroSFFzXgtOhIYBGS2gmIPpMnwPk/WD9A4gbPO+Vi5TVrdoR3ZvvOmOKEJPDaCO8csydEQUxO0ZDufZr943TNCH8bzqVlNNCu9YAaE6TrE6XFwxaUihl5jXqf5vrTqE6nMPTeo7lPIIKsiURFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rR0oSDbj; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c1e112dfso41764695ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444755; x=1781049555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sds0BjBHqkbHWS41aSKBXAbeImqpSn/zS8nv8MxHFhE=;
        b=rR0oSDbjypnvxj66iG8dsTiTQPJavprJY2J4qcRCr519VOxzYWmdQq6UTimC1PM426
         TlnjjwUZxZsHBwGp2dJKTtP0sXLgwNz7KzUpWTuuXsD7+Gvl5VLUugR1wYQLdx5GBDiz
         kuqRyXuitPRFd+U4ixP0f9JtDO0RtcT6T4M4NdxzjksqIGBQ4oCykV25QYaR0Lribcgw
         JEm/CN7zBH5wHhb1oCNkCWRS2u2kD45wIcE7sf/CW9dJoqXNkCyyECOqEkag8MDIzHmO
         JbkovzBqGvGe3uNLRdbMQ1wz3kNqQE5YCetyZ6ayF5yKApOXieyOccW9OVfkMNjWznwJ
         Cmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444755; x=1781049555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sds0BjBHqkbHWS41aSKBXAbeImqpSn/zS8nv8MxHFhE=;
        b=PhfEA7SbVvxcjks837MyvZQjeeAVBqwyATx+CHOAFHQ26Mv9Y5H4qCnWEfxce5nPMF
         pO7ytg7g6vGVh2BmShPgLaWAdGO1YFxAVxaq7jIJ3DQ82oqxMfnyOX9MNK8x78Z2nRde
         m9yTwsYSVFFcWIxM8fXBjZEf4oJGPPJVmfeDrom/90RnoWNoJLf7Ym7fQzHIgu3qok3x
         Fs4NC7b7mzYnH7jIfQJkLg4TvmrllLbgjl/rG2FdQpwzQN4KEqrnoCtWpP9Yqy9nDPh6
         xKufjnlTbI0xBN6VL5FRa6zgVQI+jRQBhgOKE+Xyw+dykSH7v4/r49ak5F10qNpwuWe9
         GI/w==
X-Gm-Message-State: AOJu0YzL84q6S/Vj2DsMVJDnSgMwtnS8oyImoz44idr4pNwGgG4xNq4/
	6MXrW/XFjNpwNzjh1iOdqdCwJzvZmamKQ2UkAImwFQvEgwdg1jkb2LAP7wiYl4YYwnX3lBvAhd5
	NJA40QNFXEn/CDi0SDm3KF2jI8q8BNK2Z23fbSoepelgyWNWrym++C2IiS0WeMUhO0zI4yu57Bt
	Mur4b1U2q6Z3rXRwluFLu1lZdMAo+r0MrTHs11e3MF61sqK3p+GdcYb8Gy3qGpfoA=
X-Received: from plpp10.prod.google.com ([2002:a17:902:c70a:b0:2bd:56ce:d8ea])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea0d:b0:2c0:ee6c:c53c with SMTP id d9443c01a7336-2c163a28b90mr9147755ad.1.1780444754952;
 Tue, 02 Jun 2026 16:59:14 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:59 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-16-hramamurthy@google.com>
Subject: [PATCH net-next v2 15/15] gve: add link status/speed ctrl ops
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:joshwash@google.com,m:hramamurthy@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D2F963319B

From: Joshua Washington <joshwash@google.com>

Refactor link status check to use a control plane op. Introduce
new op for retrieving the link status in AQ mode. This op reads
the link status from the device status register and stores the
value in priv.

Also add an op for retrieving link speed in AQ mode which calls into
gve_adminq_report_link_speed.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  5 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c  |  9 ++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  |  1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c    | 23 +++++++++++--------
 5 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 4283cb9b49de..c8ebbbb93942 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -843,6 +843,8 @@ struct gve_device_info {
  * @reset_flow_rules: Flush all flow rules from device
  * @create_queues: Sends commands to the device to create TX/RX queues.
  * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
+ * @report_link_status: Set link status into @priv->link_up
+ * @report_link_speed: Set link status into @priv->link_speed
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -863,6 +865,8 @@ struct gve_ctrl_ops {
 	int (*reset_flow_rules)(struct gve_priv *priv);
 	int (*create_queues)(struct gve_priv *priv);
 	int (*destroy_queues)(struct gve_priv *priv);
+	int (*report_link_status)(struct gve_priv *priv);
+	int (*report_link_speed)(struct gve_priv *priv);
 };
 
 struct gve_priv {
@@ -964,6 +968,7 @@ struct gve_priv {
 
 	/* Gvnic device link speed from hypervisor. */
 	u64 link_speed;
+	bool link_up;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
 	bool mgmt_irq_requested;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 799381d24c71..b33633555b71 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1872,3 +1872,12 @@ int gve_adminq_create_queues(struct gve_priv *priv)
 
 	return err;
 }
+
+int gve_adminq_report_link_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	status = ioread32be(&priv->reg_bar0->device_status);
+	priv->link_up = !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	return 0;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 03e8318f7327..82413369dec9 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -643,6 +643,7 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval);
 int gve_adminq_verify_driver_compatibility(struct gve_priv *priv);
 int gve_adminq_get_device_properties(struct gve_priv *priv);
+int gve_adminq_report_link_status(struct gve_priv *priv);
 int gve_adminq_report_link_speed(struct gve_priv *priv);
 int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 54b623b678ce..aaf5b8b1671b 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 	int err = 0;
 
 	if (priv->link_speed == 0)
-		err = gve_adminq_report_link_speed(priv);
+		err = priv->ctrl_ops->report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
 
 	cmd->base.duplex = DUPLEX_FULL;
-
 	return err;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index dfc734d8bec9..181ec6919051 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1475,15 +1475,15 @@ static int gve_close(struct net_device *dev)
 	return err;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
+static void gve_handle_link_status(struct gve_priv *priv)
 {
 	if (!gve_get_napi_enabled(priv))
 		return;
 
-	if (link_status == netif_carrier_ok(priv->dev))
+	if (priv->link_up == netif_carrier_ok(priv->dev))
 		return;
 
-	if (link_status) {
+	if (priv->link_up) {
 		netdev_info(priv->dev, "Device link is up.\n");
 		netif_carrier_on(priv->dev);
 	} else {
@@ -1510,7 +1510,6 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 {
 	struct bpf_prog *old_prog;
 	int err = 0;
-	u32 status;
 
 	old_prog = READ_ONCE(priv->xdp_prog);
 	if (!netif_running(priv->dev)) {
@@ -1537,8 +1536,8 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 out:
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	priv->ctrl_ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 	return err;
 }
 
@@ -1971,11 +1970,11 @@ static void gve_turnup(struct gve_priv *priv)
 
 static void gve_turnup_and_check_status(struct gve_priv *priv)
 {
-	u32 status;
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 
 	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 }
 
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
@@ -2299,12 +2298,14 @@ static void gve_service_task(struct work_struct *work)
 {
 	struct gve_priv *priv = container_of(work, struct gve_priv,
 					     service_task);
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	u32 status = ioread32be(&priv->reg_bar0->device_status);
 
 	gve_handle_status(priv, status);
 
 	gve_handle_reset(priv);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 }
 
 static void gve_set_netdev_xdp_features(struct gve_priv *priv)
@@ -2427,6 +2428,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 	.create_queues		= gve_adminq_create_queues,
 	.destroy_queues		= gve_adminq_destroy_queues,
+	.report_link_status	= gve_adminq_report_link_status,
+	.report_link_speed	= gve_adminq_report_link_speed,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.54.0.1013.g208068f2d8-goog


