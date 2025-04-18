Return-Path: <netdev+bounces-184246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79332A93FC5
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4001916D633
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB5255E2F;
	Fri, 18 Apr 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zV4FFxg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A96254B11
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014388; cv=none; b=WfnFewCa1VZpvYcb3G8uxfIWJRpAGuSOo31mrKMZ0dQU3m1uSRJgMFX2EnJzh+27pEJajcWviiTcU3js3fnyuMX7FrVj66Bgr+xvY9WY8H9hdMEDx8AODrRudiB73HAD9rbsGQ+9vfGlvQOKvpfUib4PNqZLiAvvJKbpAHtWIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014388; c=relaxed/simple;
	bh=loPDuypeVYAq3mG7jBub5MltLGGR1IyQ4B+mIhsZ8Mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=je92C5vAvJWSb8bBiR3S6Gfzd9mHUKQonPFcyc+QPON0AoZ8hiy64Omtj+q3G5t9Y/xhxiffQxmTCQs31ANxLU44dEsHtIRuRPcQJT8AITFD70W8iiwI3UehWYKjrl3cBtfKayav0PsKiNA/QYgm7L3apKpE6sFJD9dv1gye0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zV4FFxg7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22650077995so33454465ad.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745014387; x=1745619187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmpSa9vPgxqGtw2Pb/sSZHf+Ch+PiH7QnNGMEcCsUI8=;
        b=zV4FFxg7EuO1WHN2M8jhZwDLEnsgPTwh3fxOc7c3yOr7X+1eIBCI3N6Q56ncw67qXo
         o+9TeNQaDJENxB20HzWVZfgIrBs02NOduObVpuGNgad3ULhPKK07A0D0lj8XWF8FVWJJ
         uryUroqyI3zItk02HrbLm1dCwkVKVSIg4Mv136xiPJPDaLX5voryLe9fkNltFvi9dGpQ
         YM5eAMFQIJsMyfAFFafpqOWXi8+3smAZZeM32Whf0oMV3iqD+vKKN2qEpVux3w5NGgic
         x4l+8ZER7M0FivKTQOEu9vaXzguZIDaMJ1uI8lsdH44SZq9X8wzFNQUEpwlBhS0WG1vN
         hQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014387; x=1745619187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmpSa9vPgxqGtw2Pb/sSZHf+Ch+PiH7QnNGMEcCsUI8=;
        b=qa0RkAxN6QCiFR5TazP7F/IYJU1ByCGNd6mhcFb46E39TUB9kfVbvlG4bcDHKc6Wte
         +ODF68KT1Y/L9TFRnw2QDJcVqHh3gPphzUbzf0rW0eflEM+B4vUygIETJuQnXsbtFafN
         CZIpfnbZkwMFVPxPaS68xxU0Bib0SE7jT2+PnMh8/ttz1fzH2HLWe+PlgD2blfq6nVZA
         SgnMmkMPRPHfK+mIq99/5vYUdDCZhRPwAmXjgrbCUv+RM5poV4mJALsk9IeXoabY1f7Q
         BLz5021tqNaYS/vH2sjZXeWNXYfJ0h8ZzQckCoJ9zaUS92HNT2rSLnNez6vosXvLrxVp
         xnNg==
X-Gm-Message-State: AOJu0YxwndV+lveRKHaQD9n+CU8R7RWcYxFAeRoP9DV1fCX1WHoi4mRe
	DvkACbbT3gGbpG9084bfdTAHwXSOfLbWzaM+Rr6kgSgLFe6KKSeIEBE3TNCo7yZNCjYbiw06b1w
	j4SPYbEfhU1HiRqTx/tesUqnPs+iwNRdb3YTSvWxkYbrh5OA4DjYeMZ41kpDyguhb69bPLsgmCt
	Z+Ot6PSu9GgpZYGLuc9vmMnhXkBOZbBcbUK+P9wgqMntcIilMW9xG9NYaUKj8=
X-Google-Smtp-Source: AGHT+IG3lVPqU7fvkkyM2LJbiF75yVGwcAeROVZnXCXwIg2K49ux/hb1YMySnaNgbNo+R2UijIsSgo4CyG790fQKwA==
X-Received: from pfbfm7.prod.google.com ([2002:a05:6a00:2f87:b0:739:8c87:ed18])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db0f:b0:21b:d105:26b8 with SMTP id d9443c01a7336-22c5357a7d7mr53482605ad.7.1745014386582;
 Fri, 18 Apr 2025 15:13:06 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:12:54 +0000
In-Reply-To: <20250418221254.112433-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418221254.112433-7-hramamurthy@google.com>
Subject: [PATCH net-next 6/6] gve: Advertise support for rx hardware timestamping
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

This patch expands our get_ts_info ethtool handler with the new
gve_get_ts_info which advertises support for rx hardware timestamping.

With this patch, the driver now fully supports rx hardware timestamping.

Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 76f759309196..ba838e5b7d53 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -929,6 +929,24 @@ static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rx
 	return 0;
 }
 
+static int gve_get_ts_info(struct net_device *netdev,
+			   struct kernel_ethtool_ts_info *info)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	ethtool_op_get_ts_info(netdev, info);
+
+	if (priv->nic_timestamp_supported) {
+		info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
+					 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+		info->rx_filters |= BIT(HWTSTAMP_FILTER_NONE) |
+				    BIT(HWTSTAMP_FILTER_ALL);
+	}
+
+	return 0;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -957,5 +975,5 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_priv_flags = gve_get_priv_flags,
 	.set_priv_flags = gve_set_priv_flags,
 	.get_link_ksettings = gve_get_link_ksettings,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = gve_get_ts_info,
 };
-- 
2.49.0.805.g082f7c87e0-goog


