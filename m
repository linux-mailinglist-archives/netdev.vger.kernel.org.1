Return-Path: <netdev+bounces-115121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4259453DD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 22:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE22D1C21CF5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699A14AD2C;
	Thu,  1 Aug 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIg/Kt1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A114AD1B
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722545792; cv=none; b=or/VJWU7J704P3edLcXfk8jlL/I4guQF4izDWwcAGZKNHjSMrwcoZ3g9Dc02hPAwIeMnlwwxsLwSixDNSS5VoZQGe3BadwYmBGScHrvkSI3ObuS0cXobyaSb6JOzEs2yg2zEjDFk1Nsux0MsA863B4t1MY0kN65AAt1A2c90IsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722545792; c=relaxed/simple;
	bh=otaAX1/XnwWgJEOiLJvaxNnPgg7DZ+KUPNHAXOB+CNU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uTaOeCvpLxgXZThB0YaJFzy8k40FRXq6tzTuyXsJOFEVK+H7EtEW2Eu3maJ+Q5NXEWA8my5Pii3LD1yoMUKw1bg971vkPc6JfBXEhyvub6Jy8EzgNVLT6grD7Pjmfg/ZL4uB/a6cYUP61JuXBVioeKgnn0xlqko78CV/aBfv3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIg/Kt1/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0879957a99so11219247276.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722545789; x=1723150589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WsI4h97oJOD+Kdzx/B2wn2UbEzgbS0TP5F48gAh3+oE=;
        b=KIg/Kt1/2O+kb7NIkm0ePt6+gE/50w8EC6fa3iSJloHisuMNJ9nlIfidaTOqJPa4VU
         1VeFzfraEBp7xhCQ09QYQ7Qjj1doIIW+3bQTXg0RVMOmbOtzlRRnSj/BXQarhiy61qIY
         5koCm3xoEydeVAStPyVvAdke5HrbcEtw3L+DEZ2SuvRtCWXl3D0zqOyYpHy+HCUhN3j1
         /zFg+5D2kMDOAaWnetByA7WyCZkGB/oDIQ4bTG2i5w22LFn/gp1rKkzoawRoLzYEC2xZ
         a5slgEOpjFm9km8LgHaOz0OjCG1QtSOVBBRrjsYLnoIMiA1BXpxjBymvqecK7xgu+Ihj
         XZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722545789; x=1723150589;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WsI4h97oJOD+Kdzx/B2wn2UbEzgbS0TP5F48gAh3+oE=;
        b=C8sXM35STrXbbfWmPzuSxVp+LgmIwmhDaeVwxOmYTaFR0ieXIkR014WriN2chmy4yl
         DJZx+RJl+uNBHlmOlVcOjBxb9GLPmhV3okhcDYzBsBnft0BPmSjeD5HZkJ4zLUt5M9f3
         ds4Nvrb1UGa5gFLA6ap1taZbOYkwiU7MUWxr8oJ89Mv7LniKL+x2OyMvwKxO4qSht7Mr
         wfxVsEgp5MupgACw19RTL8BLd3Mt+AeN6FMWEvWREDKs0iLgQgKbLF7ARoT/tC6WyVFU
         LYAKR/NwqFwKeR8NeBqj7hl7suDQZ5yKh38fAI+vkvybyTgqPr4xAAijZoBs1QpmWsDK
         jleQ==
X-Gm-Message-State: AOJu0Yxr3T0F0hsZKaxCYS8R5onbWt1xaQV3CFlQyWyOQ3JzTAntECAN
	hx1g2ZGOD9woxCitUBI0jLNhJnLa6Fky3GbuKTd1Z9rLSPgQryVwQZFMj2IDnMLvJ3SYiTn/1gA
	ES1Dwp8SbiZLmhbmUlH9Dg9qy1yuU/E2sh77RAPmmzNoHvDDLd1XfS+3194NXHyWNn4EzQ/mOfD
	dteBEoq8cQGR1ru2D9ASEp8gKsFcfDzLbJrFeINpZvzsQRiTnipl98mSNJ/3EVs7zP
X-Google-Smtp-Source: AGHT+IGFsqqNLP9Fi33ThhrFv4eJa7kvHMXK5BOp2+e5y15M7HTFhDP7nLX1nna5xK4EGfRw67XArfUmt95dZsMtD7c=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:fe4c:233c:119c:cbea])
 (user=pkaligineedi job=sendgmr) by 2002:a05:6902:2b03:b0:e0b:b6e7:7783 with
 SMTP id 3f1490d57ef6-e0bde266500mr2524276.5.1722545788911; Thu, 01 Aug 2024
 13:56:28 -0700 (PDT)
Date: Thu,  1 Aug 2024 13:56:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801205619.987396-1-pkaligineedi@google.com>
Subject: [PATCH net] gve: Fix use of netif_carrier_ok()
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, jfraker@google.com, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

GVE driver wrongly relies on netif_carrier_ok() to check the
interface administrative state when resources are being
allocated/deallocated for queue(s). netif_carrier_ok() needs
to be replaced with netif_running() for all such cases.

Administrative state is the result of "ip link set dev <dev>
up/down". It reflects whether the administrator wants to use
the device for traffic and the corresponding resources have
been allocated.

Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 3480ff5c7ed6..5a8b490ab3ad 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -495,7 +495,7 @@ static int gve_set_channels(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	if (!netif_carrier_ok(netdev)) {
+	if (!netif_running(netdev)) {
 		priv->tx_cfg.num_queues = new_tx;
 		priv->rx_cfg.num_queues = new_rx;
 		return 0;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9744b426940e..661566db68c8 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1566,7 +1566,7 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 	u32 status;
 
 	old_prog = READ_ONCE(priv->xdp_prog);
-	if (!netif_carrier_ok(priv->dev)) {
+	if (!netif_running(priv->dev)) {
 		WRITE_ONCE(priv->xdp_prog, prog);
 		if (old_prog)
 			bpf_prog_put(old_prog);
@@ -1847,7 +1847,7 @@ int gve_adjust_queues(struct gve_priv *priv,
 	rx_alloc_cfg.qcfg = &new_rx_config;
 	tx_alloc_cfg.num_rings = new_tx_config.num_queues;
 
-	if (netif_carrier_ok(priv->dev)) {
+	if (netif_running(priv->dev)) {
 		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 		return err;
 	}
@@ -2064,7 +2064,7 @@ static int gve_set_features(struct net_device *netdev,
 
 	if ((netdev->features & NETIF_F_LRO) != (features & NETIF_F_LRO)) {
 		netdev->features ^= NETIF_F_LRO;
-		if (netif_carrier_ok(netdev)) {
+		if (netif_running(netdev)) {
 			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 			if (err)
 				goto revert_features;
@@ -2359,7 +2359,7 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
 
 int gve_reset(struct gve_priv *priv, bool attempt_teardown)
 {
-	bool was_up = netif_carrier_ok(priv->dev);
+	bool was_up = netif_running(priv->dev);
 	int err;
 
 	dev_info(&priv->pdev->dev, "Performing reset\n");
@@ -2700,7 +2700,7 @@ static void gve_shutdown(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
-	bool was_up = netif_carrier_ok(priv->dev);
+	bool was_up = netif_running(priv->dev);
 
 	rtnl_lock();
 	if (was_up && gve_close(priv->dev)) {
@@ -2718,7 +2718,7 @@ static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
-	bool was_up = netif_carrier_ok(priv->dev);
+	bool was_up = netif_running(priv->dev);
 
 	priv->suspend_cnt++;
 	rtnl_lock();
-- 
2.46.0.rc2.264.g509ed76dc8-goog


