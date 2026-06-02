Return-Path: <netdev+bounces-294471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id doHrE3ZuH2qVlwAAu9opvQ
	(envelope-from <netdev+bounces-294471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DABA36330AB
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:59:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="FV/IDnpc";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294471-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62ACD3081129
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222C3D3CEB;
	Tue,  2 Jun 2026 23:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593C3BCD39
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:59:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444748; cv=none; b=VfjRGKRY3qxHl0NZ8bSh9Pa4u2n7ptN5SC2QeeiUlnIuQkriqBpRyBFl0XBTpk3WkfXJvyLY6pJhCcYddz3uqy6qcRzgLqdZUYVm2qzPVF/1453+3ZDvZOmE1nkPi/Vu4hn8jccOeNgghxjdwONll+zIQn5+PTRRfIPZztJn5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444748; c=relaxed/simple;
	bh=jwyRvZ/+qHHJpwn/eKpo09IX4NL3rKOUxSltYeKc8n0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JiJkfRUdsFoLpgN6bXn8gaSSgd4rBzaa/nZlyFzbGkoGNEVaL16sEnxjrMPAQvEXV1vx71akE6/zA/MyV3iWrcfUdTfA42/r1ECw+gunht9dhXqcjjAkwbxyik4enDBqFhSbqUWGzsRKwZQSEwmgYTcLNZDyFJIjJPx7MS7qHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FV/IDnpc; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so845235ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444745; x=1781049545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1UNzlhiTlzST26pj+RRE5Kxk1lz3fpGKLNeH2a+Ysk=;
        b=FV/IDnpcrE6ljFI9irhaDWrlHUQtlr5V/JTM/AVojKKnbG+oQGCTIzBfBiaUyI1GIU
         Xtz+MjzEmOiTab/gFgSnjIqmHrVNpHCV0vciK3ze9Ac/iUwtMg3VjvUCGwnNeWbs6QU/
         X3jqD3ySGHXD8H2DBxEa5I+UC8JC3dhByzUZXXZlimFAh8/H7WPjF9fp+pbY5rFrC2Sk
         t8jo3TInPDkh5whHxoCScoT2AlEJs1OJ3myEbgkX/7GemzxrGVxycKrKfNgJE2pE5Ego
         Io65FxF3O+iEIKLUwfCRMBbbOERX3p3Okb3AAlGGPZBwDoD2TUdf1HAh3XHy6FO+wYKs
         AIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444745; x=1781049545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1UNzlhiTlzST26pj+RRE5Kxk1lz3fpGKLNeH2a+Ysk=;
        b=QOE+f9IH4ll59zi/WxPelivydD9GElfwHSf+82KH1SUutfmglLNCjgkkN8aIGkKkyM
         1ddYEo8//wb4v11qV64tFuGEoixjlhduk0/jSk8O7zNA8yIWidSR7Jk1GSdzXNojIsiw
         Uy5jGg8CtKVzqRlBdfBfT9BXCn+1TEQ7NsJ7iQkZolYPWkxCVsRJSyQJzMTTcv2YK7RM
         NRgYLNCxISRfOmYRgymm1kdkz8nTKCaUgmemyah8S5Awmb6DOfIxEqIW9Zwy0OQh1bwf
         wjsTbiCZ9dDSXRg1r7xPxvtc5ylnpS/C1W4TXFJdlnGikQxyEzk3fMrnQr42XqHa/7sp
         nlDg==
X-Gm-Message-State: AOJu0Yx9w8jJE4Tg4QZNks1lDDegSswFa7EtxqPICPEs9lZt2X0Duu7h
	ciZJF3F8RnvfChcNNB+D3A8ZZLzVJw8930vgbcyJKKqL6D3bQtocq24+aN2yk75n4/HrYFSFp8q
	TNRNhEtVrj0VV4iwV/nj8NmNpHkXrX/KhPylKlY0q4Rwf+vj+0/s3jOr5SC7t/BX5KAHGyFUcKB
	GX1Jmx2imCi3hqyPukFlSn8taUpwPf8oPu16iwCBao9wTvNZchAbaFEpTWUiLrbMU=
X-Received: from plss9.prod.google.com ([2002:a17:902:c649:b0:2bf:1316:821e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2409:b0:2c0:a858:8128 with SMTP id d9443c01a7336-2c1640b37bemr7670815ad.1.1780444744546;
 Tue, 02 Jun 2026 16:59:04 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:47 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-4-hramamurthy@google.com>
Subject: [PATCH net-next v2 03/15] gve: introduce gve_adminq_get_device_properties()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294471-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DABA36330AB

Introduce gve_adminq_get_device_properties() which executes the first
two Adminq commands: VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE
so that this can be called during initialization.

Move these to Adminq specific files. This is just code movement, no
functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  2 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 66 ++++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h |  5 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 59 +----------------
 4 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1d66d3834f7e..645175a5dfae 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index dfeabddfb396..860d43650c6a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1144,6 +1144,27 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	return err;
 }
 
+int gve_adminq_get_device_properties(struct gve_priv *priv)
+{
+	int err;
+
+	err = gve_adminq_verify_driver_compatibility(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not verify driver compatibility: err=%d\n", err);
+		return err;
+	}
+
+	/* Get the initial information we need from the device */
+	err = gve_adminq_describe_device(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not get device information: err=%d\n", err);
+		return err;
+	}
+	return 0;
+}
+
 int gve_adminq_register_page_list(struct gve_priv *priv,
 				  struct gve_queue_page_list *qpl)
 {
@@ -1206,20 +1227,53 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
-					   u64 driver_info_len,
-					   dma_addr_t driver_info_addr)
+int gve_adminq_verify_driver_compatibility(struct gve_priv *priv)
 {
+	struct gve_driver_info *driver_info;
 	union gve_adminq_command cmd;
+	dma_addr_t driver_info_bus;
+	int err;
+
+	driver_info = dma_alloc_coherent(&priv->pdev->dev,
+					 sizeof(struct gve_driver_info),
+					 &driver_info_bus, GFP_KERNEL);
+	if (!driver_info)
+		return -ENOMEM;
+
+	*driver_info = (struct gve_driver_info) {
+		.os_type = 1, /* Linux */
+		.os_version_major = cpu_to_be32(LINUX_VERSION_MAJOR),
+		.os_version_minor = cpu_to_be32(LINUX_VERSION_SUBLEVEL),
+		.os_version_sub = cpu_to_be32(LINUX_VERSION_PATCHLEVEL),
+		.driver_capability_flags = {
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS1),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS2),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS3),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS4),
+		},
+	};
+	strscpy(driver_info->os_version_str1, utsname()->release,
+		sizeof(driver_info->os_version_str1));
+	strscpy(driver_info->os_version_str2, utsname()->version,
+		sizeof(driver_info->os_version_str2));
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = cpu_to_be32(GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY);
 	cmd.verify_driver_compatibility = (struct gve_adminq_verify_driver_compatibility) {
-		.driver_info_len = cpu_to_be64(driver_info_len),
-		.driver_info_addr = cpu_to_be64(driver_info_addr),
+		.driver_info_len = cpu_to_be64(sizeof(struct gve_driver_info)),
+		.driver_info_addr = cpu_to_be64(driver_info_bus),
 	};
 
-	return gve_adminq_execute_cmd(priv, &cmd);
+	err = gve_adminq_execute_cmd(priv, &cmd);
+
+	/* It's ok if the device doesn't support this */
+	if (err == -EOPNOTSUPP)
+		err = 0;
+
+	dma_free_coherent(&priv->pdev->dev,
+			  sizeof(struct gve_driver_info),
+			  driver_info, driver_info_bus);
+	return err;
 }
 
 int gve_adminq_report_link_speed(struct gve_priv *priv)
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 8e80f36116ec..831759d30f44 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -640,9 +640,8 @@ int gve_adminq_register_page_list(struct gve_priv *priv,
 int gve_adminq_unregister_page_list(struct gve_priv *priv, u32 page_list_id);
 int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval);
-int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
-					   u64 driver_info_len,
-					   dma_addr_t driver_info_addr);
+int gve_adminq_verify_driver_compatibility(struct gve_priv *priv);
+int gve_adminq_get_device_properties(struct gve_priv *priv);
 int gve_adminq_report_link_speed(struct gve_priv *priv);
 int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b9542ef36b29..eb2d768e5881 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -17,7 +17,6 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
-#include <linux/utsname.h>
 #include <linux/version.h>
 #include <net/netdev_queues.h>
 #include <net/sch_generic.h>
@@ -41,49 +40,6 @@ char gve_driver_name[] = "gve";
 const char gve_version_str[] = GVE_VERSION;
 static const char gve_version_prefix[] = GVE_VERSION_PREFIX;
 
-static int gve_verify_driver_compatibility(struct gve_priv *priv)
-{
-	int err;
-	struct gve_driver_info *driver_info;
-	dma_addr_t driver_info_bus;
-
-	driver_info = dma_alloc_coherent(&priv->pdev->dev,
-					 sizeof(struct gve_driver_info),
-					 &driver_info_bus, GFP_KERNEL);
-	if (!driver_info)
-		return -ENOMEM;
-
-	*driver_info = (struct gve_driver_info) {
-		.os_type = 1, /* Linux */
-		.os_version_major = cpu_to_be32(LINUX_VERSION_MAJOR),
-		.os_version_minor = cpu_to_be32(LINUX_VERSION_SUBLEVEL),
-		.os_version_sub = cpu_to_be32(LINUX_VERSION_PATCHLEVEL),
-		.driver_capability_flags = {
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS1),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS2),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS3),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS4),
-		},
-	};
-	strscpy(driver_info->os_version_str1, utsname()->release,
-		sizeof(driver_info->os_version_str1));
-	strscpy(driver_info->os_version_str2, utsname()->version,
-		sizeof(driver_info->os_version_str2));
-
-	err = gve_adminq_verify_driver_compatibility(priv,
-						     sizeof(struct gve_driver_info),
-						     driver_info_bus);
-
-	/* It's ok if the device doesn't support this */
-	if (err == -EOPNOTSUPP)
-		err = 0;
-
-	dma_free_coherent(&priv->pdev->dev,
-			  sizeof(struct gve_driver_info),
-			  driver_info, driver_info_bus);
-	return err;
-}
-
 static netdev_features_t gve_features_check(struct sk_buff *skb,
 					    struct net_device *dev,
 					    netdev_features_t features)
@@ -2461,21 +2417,10 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	if (skip_describe_device)
 		goto setup_device;
 
-	err = gve_verify_driver_compatibility(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not verify driver compatibility: err=%d\n", err);
-		goto err;
-	}
-
-	/* Get the initial information we need from the device */
 	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
-	err = gve_adminq_describe_device(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not get device information: err=%d\n", err);
+	err = gve_adminq_get_device_properties(priv);
+	if (err)
 		goto err;
-	}
 
 	err = gve_set_num_ntfy_blks(priv);
 	if (err) {
-- 
2.54.0.1013.g208068f2d8-goog


