Return-Path: <netdev+bounces-64776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB19B83715E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BB1F2B1BE
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080774F5E5;
	Mon, 22 Jan 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCfTQgH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877974EB34
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948044; cv=none; b=g8S8wxRw2AA2GpHzGE+qp8lzgMLBqULK3GiKt18KroYRs1X105EcbHr+55uAngqH8rdFBoLMweFhYC3c7hTD1pUvTL1kAYymfSVoDPEb7zjZedgbiJ+6ainOzr0tUJPQN0rJkt7CUeePxv7hHIfZKLgwJbHO76FbIosHIqqjowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948044; c=relaxed/simple;
	bh=AoWisGCCyxI21UFrT75HOcEOrhmNkEdYKooDXVMNsrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tFZQ2rQ3fYqNI2EiD+oLZM2PpcU6aSXH7SCh2g0mCsctzcmM4YFRfPVl8dWi45j71LEflwl8stNAqe4xrS2pdGTxJyz+8WNXddz2I3PeLvBNEuRJxNiJ+YwORm5x2aXEuXPbCe/HyBFCmFV9FZUxY0qQG+bK7vyoF/PFFA9xu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCfTQgH8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5efe82b835fso55710327b3.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705948042; x=1706552842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R02rVSahn7nXV4ulzVCybKwH4H/mMYLbLGUAL9YTiVI=;
        b=hCfTQgH80ru5tBSYErahppnE5/uvlFNXaIHtgfFcFtLCapGmZn8BXQcZNP5NdcDb+S
         NEJZ+DlQcxYeLlAvRnk3wdsYsyA2zu0QOOE74hNXHfjdmYWBmy+dNHHOvx2oz/80HKqg
         rsIQ2Y92uQ44qatQL1amwyQtGX2YoKMEzQSrbap2bV9LDUznZ3IRWQY0E97cRwo0CypP
         fByDipbWG0wLBFH5VJkKtU3QCJ6XIskbVZFtFCQOiHNR6y050LjqBLD2mWqqUqFsMwWJ
         gpMy/Y2qeMGRAeGROHFp9sJO90wg6uf5x6CElu/GhwEOHerk+LY5Z0KLI2WTT1y3bQwW
         5Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948042; x=1706552842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R02rVSahn7nXV4ulzVCybKwH4H/mMYLbLGUAL9YTiVI=;
        b=C4cTv0wQf0So1cd1ZvKh8F9L91Aw40uSFc0k9EmVWomAhOA5ff9ZLegQi6r+O5Xp9h
         OJ9s94ll1WZhbqzDecAvZUameHUlWrnoQTL9sPPYwmiuNxnqwC37sYN1kpWftv+J9TM9
         4uPRjqcsxhumTYn3RAz5FEjvQ+AN/6lILjpgqkBINx04tL1E32LtIG19PKBrp4TiZvzB
         cnXoMGPfD/LZ919z4jrXQpq0hSUDXYn5klKQ9tUWc8p6iYqI3qnCF3p5cp4m9xMeyZzN
         w3Amn6uek8N1RyROQKkwajX6RSVUaAHS8dopmWoB/wTDqdcBt8qgcbmJoxP0Y5uze1NQ
         J/8Q==
X-Gm-Message-State: AOJu0YxXS4YpX+TlIJDiGVXuBiedTmEiWmZorh51ra8nM4iQkSKOAW0n
	0pJmIIRs5Rjn+olvB13CWUYELmnN24k35jo+sS1OZSYpj7eCx7td4kV3ZkDNJ0gja3+eKx5aq7Z
	uFTOJq51nGOMFvAw5lsJiaPIHWgo5o9iw7HhuOEdx7pIF55tMAT//OZoyCfluMWOVBT6NLO1C7p
	5T9frj/BFFbp2kRcbRIALIr0nNA1w76uKWPRl4xkD3EHc=
X-Google-Smtp-Source: AGHT+IF/m+7mZMj7pnzkvoJGEMbDp88WTnKhc6YXkMo5FrxkVmoO4WHGLQ8hHQCzzD/sEoKFIrolWS2RgThXgQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a81:9808:0:b0:5d3:a348:b0c0 with SMTP id
 p8-20020a819808000000b005d3a348b0c0mr2240300ywg.5.1705948042669; Mon, 22 Jan
 2024 10:27:22 -0800 (PST)
Date: Mon, 22 Jan 2024 18:26:32 +0000
In-Reply-To: <20240122182632.1102721-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122182632.1102721-1-shailend@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122182632.1102721-7-shailend@google.com>
Subject: [PATCH net-next 6/6] gve: Alloc before freeing when changing features
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, existing queues were being freed before the resources for
the new queues were being allocated. This would take down the interface
if someone were to attempt to change feature flags under a resource
crunch.

Signed-off-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 41 +++++++++++-----------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 78c9cdf1511f..db6d9ae7cd78 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2069,36 +2069,37 @@ static int gve_set_features(struct net_device *netdev,
 			    netdev_features_t features)
 {
 	const netdev_features_t orig_features = netdev->features;
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 	struct gve_priv *priv = netdev_priv(netdev);
+	struct gve_qpl_config new_qpl_cfg;
 	int err;
 
+	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
+				&tx_alloc_cfg, &rx_alloc_cfg);
+	/* qpl_cfg is not read-only, it contains a map that gets updated as
+	 * rings are allocated, which is why we cannot use the yet unreleased
+	 * one in priv.
+	 */
+	qpls_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+	tx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+	rx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+
 	if ((netdev->features & NETIF_F_LRO) != (features & NETIF_F_LRO)) {
 		netdev->features ^= NETIF_F_LRO;
 		if (netif_carrier_ok(netdev)) {
-			/* To make this process as simple as possible we
-			 * teardown the device, set the new configuration,
-			 * and then bring the device up again.
-			 */
-			err = gve_close(netdev);
-			/* We have already tried to reset in close, just fail
-			 * at this point.
-			 */
-			if (err)
-				goto err;
-
-			err = gve_open(netdev);
-			if (err)
-				goto err;
+			err = gve_adjust_config(priv, &qpls_alloc_cfg,
+						&tx_alloc_cfg, &rx_alloc_cfg);
+			if (err) {
+				/* Revert the change on error. */
+				netdev->features = orig_features;
+				return err;
+			}
 		}
 	}
 
 	return 0;
-err:
-	/* Reverts the change on error. */
-	netdev->features = orig_features;
-	netif_err(priv, drv, netdev,
-		  "Set features failed! !!! DISABLING ALL QUEUES !!!\n");
-	return err;
 }
 
 static const struct net_device_ops gve_netdev_ops = {
-- 
2.43.0.429.g432eaa2c6b-goog


