Return-Path: <netdev+bounces-192901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C01AC18C7
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED334E0E13
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346842D4B60;
	Thu, 22 May 2025 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9q1bbPT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBEA2D1931
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958275; cv=none; b=SzgTIxH/CDS/dU4mn5PQabemRA/RCPXnR2UGQttoMjX3WPWcVDnA9dPflI5t4oaarYQSU9Kb1o3POsSOjvwwuidbGP3MOLBxvfM8JNHFSe6HcVsCYdK0pELMi3Sn2KIYkWD+oGuDrxyEyPTP/St+OqEdkR3mgWLRTV1PMDT2ciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958275; c=relaxed/simple;
	bh=n7plbbr3BamoK04MEHPsC9Ph7jXzjScsO/2sdM4WRGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9yYtjL7Y30oH5OHdx4Zy7c3xtV95MdwDMg+E45+iC9G7snJzgXz+hbhCsdS6Ij5sm1yt/RH8J2z1u6Rqcqf6IL6IpxHMUhPx6dePNWECDCEDZipfdM01bLkCO2Rc4Pd6glYSoLqnNu7XoTPTTAqTjTWciL2ZACzM/stMNDh8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9q1bbPT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742b6705a52so8684517b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747958273; x=1748563073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/VPvTyzliorplqyqZgQq6p842HQ3UDgPCj4kwriHPY=;
        b=U9q1bbPTGydBLtdPmYrMbXhZk7UVEaIDz9tyJvJzUjvSzS1B48hmf5txEEoFmxWFIb
         as+zcIzZqqnuURF8lRbQmPH0ucMnbvyX//pjlH/S6JZnQJjnwNhLBiJCAX3e5/I1Iz2y
         B1gkUBt2zw/6yfjjz0Vu0stYP3V614SYe2Wrvg4vMFWGtQ3U44qbqYPZDBgrZ6hp/wdA
         23NqinWoIITfGzqJsaSf/Gs75QGjqPbxonRHrboTTY7cVJTPh20ybK5isRfTt8wkeHR9
         Ah4Yz/bumil6oGy8LNhF+gO643lYa3cnd9eumIbw/CFfPobRIoWxvZ/fyJxLlx9Tpkrb
         nbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747958273; x=1748563073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/VPvTyzliorplqyqZgQq6p842HQ3UDgPCj4kwriHPY=;
        b=pJD/Uj4DbwrOAk88WC+dZ68UISlBQGGHaP0ceApeDogA8N0PRKC+/5gTjC61xIfu/o
         qWauDH0spvuEbYd0LkzWzJGHSyMXTkwDlJFnX+j6+j2p0mX707AfyU6kgc6TT6O6XN/K
         jVYjGooQyspHeB5UYTIPfwHJ/am2ZK4Ka25Q+LnUX3oXx29/pH85mKtUlHgJPS/PfddM
         OMZfMq6zm89AZtAVnLpIiCMjf5Ri7yij0zN3vUdgwYCqKowlU6/wzadhCMudLUgCkuiT
         Wm/jY1EwSwuW6Krb3pD8oJPfITAzNFb2j9yit4EK07mhRJvGuKRCZXy1Q6ol99KTZe3c
         d10w==
X-Gm-Message-State: AOJu0YxxF5j5vewrerq5Ei9wrZtapdjHBHEl2lKbBGZWG95m43DQhZOP
	WnVtOr5YM46R+N6DugF0WUVrlWnUvKlyqnB182zgZ4ZnDWZ3w4XH2AlHheOd7WiXwACDTAM1vFw
	x/DxkrlKAhvCWyrFWuZ6QolH+0mh8gfTJ3H50uee61lAWXyVkHkptWWM0pEAUnvSnR04rs2EqKT
	vXhhI8jU6eLU/abTzzZWMi8t2o2FcIOk+HAeX9AzoSdRCHgCs2MyN5FJ+fqaRtlyc=
X-Google-Smtp-Source: AGHT+IGRbiFjtwSUPW8s7GKRtSvt9yqUiRl0Vl8/e3DcdCtRazY1SO6dT+VmE+wGSTd34cWUBb/TsuUBtxHTV2eMzA==
X-Received: from pfhm3.prod.google.com ([2002:a62:f203:0:b0:736:3e92:66d7])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:391a:b0:740:a879:4f7b with SMTP id d2e1a72fcca58-742acd5115amr35613613b3a.18.1747958272916;
 Thu, 22 May 2025 16:57:52 -0700 (PDT)
Date: Thu, 22 May 2025 23:57:37 +0000
In-Reply-To: <20250522235737.1925605-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235737.1925605-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235737.1925605-9-hramamurthy@google.com>
Subject: [PATCH net-next v3 8/8] gve: Advertise support for rx hardware timestamping
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Expand the get_ts_info ethtool handler with the new gve_get_ts_info
which advertises support for rx hardware timestamping.

With this patch, the driver now fully supports rx hardware timestamping.

Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index d0628e25a82d..043d1959fb9d 100644
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
2.49.0.1143.g0be31eac6b-goog


