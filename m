Return-Path: <netdev+bounces-142762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1519C0458
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E40B215CE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DF20B1E7;
	Thu,  7 Nov 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICapijdE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7651D95B0
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979712; cv=none; b=O7hWUpl96rVSjY66ImV0Vv9/nopgVcA2ha1/rmrZzUjY3ysI3GnCE9H6Y+UavuMrqz9QWMkx4Wsv1S+41Ff4MN170etT+BV/+HCNWYFt+d9TvRlsUL+BtYObU+f2TBwG3EXEsBJ7FdSBKHqliCuViMTJIb/tQmdHmCigYREidOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979712; c=relaxed/simple;
	bh=QSKP4T7MGlux6sZkKsYyCHElibFRW+Yc5QWOHaQm2dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nfp+jVZWvo1YEFYilJNpoQYLD/K9uVCSOLQSvYtv0A5EXlMyQwuksG8SB12C2L2Yb71gFX5qnryLcJ3/Suf5QPorzSIy/yq76rxJ0BTNY3ihy4TO3nHr1i9VgfmfX4rFJbJJ6LZ7tp7BMRNAjUPC5VRutTSfmER/gdlOgLRBwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICapijdE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730979710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AAfGWrqcXIa1OtHYOMNVby2KSSNk7+YzeisnDUMkCHo=;
	b=ICapijdEa2AYJfHNZcmqfjGs9ecKEkfWTLuRPxExqOnfTsnrbSNE22nQBrqnsF/yluI8Jl
	ciRaBVB1WnpGxL/UOlf1GyJhbaONCknAheI11nMBsemDSF/Mwi8N44Lv9fGpfRg+vYeGjt
	+nBK8Qga0V23mW2B8h5xqOvbIGUBEzU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-O5IfsVx0Me6QkIYf37XVCg-1; Thu, 07 Nov 2024 06:41:48 -0500
X-MC-Unique: O5IfsVx0Me6QkIYf37XVCg-1
X-Mimecast-MFC-AGG-ID: O5IfsVx0Me6QkIYf37XVCg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316e350d6aso6123805e9.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 03:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979707; x=1731584507;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAfGWrqcXIa1OtHYOMNVby2KSSNk7+YzeisnDUMkCHo=;
        b=epqCEpAFEhQBsp8xqT1Bc88aZfNuFnqzYJBGze9w28ZtGj2NHqbRiwo/A0qOndZeYb
         QtiliEgNWZlDirMoJ+kF+0QZKbZjO8Rhj1iqPV/yLm1JCAIDuR3vuf7UMX2uGWArLkgn
         0XwHfd/UiQObfyaihyf/gENriR5ed14UR8MU2+YTh1uEzRKRZyo0WZu0o9LSSS5/+z+9
         UdhleB1I1TBrzmMYQ++/cRCKZSgKSXstdW8jf3wUxlZLPdq2Aqp7OxuhfhO2W3HXKGb8
         muLOK0dDUtVsu7yYvJ5pPorRh5a4oCs224CgUGweXpwXd7oEJ1BIu0XL0gKE97EGkfXU
         5QrA==
X-Gm-Message-State: AOJu0YwOBlVi2kPTnariajSdjikwzkMquvY7H/SWhEIBtzP9g54FQl1l
	TPsjTMZhRbHYAwnipcXrzi4AMorFv0Lf1BQ8QJ+eM6Wbh+0G8WUfhbp1uibQOhUseBGI8KfD3Dg
	CVxWNPMEjaSZ+8mpNlUrYTbsr6oQQdIcj82K4/jRazRfGIXhi3IYeOETGrbhOYQ==
X-Received: by 2002:a05:600c:3ca1:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-4328327db85mr198590825e9.22.1730979707247;
        Thu, 07 Nov 2024 03:41:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHakl4sGdLa4PxnuLYjasQDldZDkdz5xq5RnUxMrqepZcPmw2huWs2JIWgj2pa+4+PDrpjvnA==
X-Received: by 2002:a05:600c:3ca1:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-4328327db85mr198590595e9.22.1730979706825;
        Thu, 07 Nov 2024 03:41:46 -0800 (PST)
Received: from debian (2a01cb058d23d6008938d5c96193dabb.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:8938:d5c9:6193:dabb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5b7fsm57449745e9.4.2024.11.07.03.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:41:46 -0800 (PST)
Date: Thu, 7 Nov 2024 12:41:44 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next] geneve: Use pcpu stats to update rx_dropped counter.
Message-ID: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the core_stats rx_dropped counter to avoid the cost of atomic
increments.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/geneve.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2f29b1386b1c..671ca5260e92 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -235,7 +235,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 					 vni_to_tunnel_id(gnvh->vni),
 					 gnvh->opt_len * 4);
 		if (!tun_dst) {
-			DEV_STATS_INC(geneve->dev, rx_dropped);
+			dev_core_stats_rx_dropped_inc(geneve->dev);
 			goto drop;
 		}
 		/* Update tunnel dst according to Geneve options. */
@@ -387,14 +387,14 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely((!geneve->cfg.inner_proto_inherit &&
 		      inner_proto != htons(ETH_P_TEB)))) {
-		DEV_STATS_INC(geneve->dev, rx_dropped);
+		dev_core_stats_rx_dropped_inc(geneve->dev);
 		goto drop;
 	}
 
 	opts_len = geneveh->opt_len * 4;
 	if (iptunnel_pull_header(skb, GENEVE_BASE_HLEN + opts_len, inner_proto,
 				 !net_eq(geneve->net, dev_net(geneve->dev)))) {
-		DEV_STATS_INC(geneve->dev, rx_dropped);
+		dev_core_stats_rx_dropped_inc(geneve->dev);
 		goto drop;
 	}
 
@@ -1023,7 +1023,7 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX))) {
 			netdev_dbg(dev, "no tunnel metadata\n");
 			dev_kfree_skb(skb);
-			DEV_STATS_INC(dev, tx_dropped);
+			dev_core_stats_tx_dropped_inc(dev);
 			return NETDEV_TX_OK;
 		}
 	} else {
-- 
2.39.2


