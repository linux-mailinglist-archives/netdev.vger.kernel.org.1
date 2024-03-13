Return-Path: <netdev+bounces-79732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE3687B14C
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 20:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1269287BE7
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9D626D2;
	Wed, 13 Mar 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CQYFQ+Yz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659C62169
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355093; cv=none; b=i22f2EVcwiMEeV4qqpBWnXn1IKdUdaB4flQgkqurHVflAt8dNCNElm9wODgYztX2BRzlL1R0O73bsXNlK8VSRe/QFDGsrPnaJBouvtMDvph6b9w6XPrJiO2Uty4Rvkfd6fLIahsYLVnOPQAm3nsUE0ySP1M3lrZfvDBEUq4SAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355093; c=relaxed/simple;
	bh=LYGpyaWqI4OQkRsCPAAXmseCCeLi0JUL+iyC+D7H+Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tc4vgNirs4C6Q98BoFXLhbAB0PW6K979oAWZpZfMHdmJi0oBeo4iaUb5qdAsFJZOxDkTdHORvN3GqzJ7YQSD5AGMRLX0LA4gNt67ENZbgyaQoQEG8bAqJ/uMc5+CIrF0ALlB+nSX39lMVnqjo1OUk3L+HSLKnCVUHHtYnyiay2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CQYFQ+Yz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e285a33bdso53075f8f.2
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710355089; x=1710959889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c0sFhJjgBhsQMOE20vyPSAZJsUFrGi6WAMxacs9oBQ=;
        b=CQYFQ+Yzxn6pLmxLnhJwOaeXB/BG1n06YQgDQa4MJqgCNLfXu4zr2cVktNIkPbGZu9
         rryinNnPHuLaeMMuWpcVOUao+mA0UtYsraepeFsVPecUAdU/k2qdw70opMxG82ln0PIG
         Nrvc0eRPPuKzghDjromGgxoPk2ZbHT/B3k/y6FksuE5YAVvRLbrbA+ng+aQjDGwkxeq6
         rfUDW2SbtWNS7qKhqXb9IOqxXzu4ie1R/7z+CDf4z3L6+9xojvQmwlk6/VDNkCF3jQcI
         jZdT5TqH+ZDC7cnnqquuXQETxSDcDvQAgGhK7lG467XMr3BFoJsSBXpfR+2JgnH6tHjO
         /dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355089; x=1710959889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0c0sFhJjgBhsQMOE20vyPSAZJsUFrGi6WAMxacs9oBQ=;
        b=Rhctw4P19nrpXc+dZ7TGZxrvqv6r0MKoZl6Ie+h95G+s2w/6Pbf2h8q/33Mvf9fd2m
         3Rrn8JYEtgY6Kv+S4HG7wxKTcDFzK/Fm3zCmKJkY6Uh1rXlRtQq+t+fichhFTxPzWYRO
         UbWc1snpLoAped3LwUkl4unQhabXGOnnlAMIThz+DPefKKcBTUgEg0hRpuVr1A0nl6hW
         eEA6HUQvLg7v5+/YGkFyMhEYqDiDKfT3EwUsmAseapAYu5xpHD2KKwpgAf588Rmy9KsW
         2PV9ZCElP+wvYxjias6OF7Ar3dy09n5kQ/+/c5oI/ef8a1LG3BaQFXGgrhwwFjVuNxwj
         Osew==
X-Forwarded-Encrypted: i=1; AJvYcCXi1v/93kYNIVbHlu+S51vW1g1mDMZZ7Dd3uG5NPGZYy/iPmT/s1/XW54B0YLMsPpt8jIZaXziclBp1WyjP+zd6xUR6v7Xy
X-Gm-Message-State: AOJu0YzkPaBspUwxGqcDFLnCvJW5DGfHZ5T4TNkg6spRYBtVhF9uzX4Y
	6z+GnHvJlc4C0nKdz0SuOg+PazjX+IeRSqSeKgOkd06y6dQXVmBnrt887P7XS3I=
X-Google-Smtp-Source: AGHT+IGvZdVzX7cZUBTQWk4I9lu5wA25oxEffhaDZlKzbZvau8rDsJLNNubcHLpAMZooVioyfMNW4A==
X-Received: by 2002:a5d:4a87:0:b0:33d:679d:a033 with SMTP id o7-20020a5d4a87000000b0033d679da033mr1940524wrq.36.1710355089303;
        Wed, 13 Mar 2024 11:38:09 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.85])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b0033e9d9f891csm7089876wrb.58.2024.03.13.11.38.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Mar 2024 11:38:08 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net v3 1/2] net: veth: do not manipulate GRO when using XDP
Date: Wed, 13 Mar 2024 19:37:58 +0100
Message-Id: <20240313183759.87923-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240313183759.87923-1-ignat@cloudflare.com>
References: <20240313183759.87923-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit d3256efd8e8b ("veth: allow enabling NAPI even without XDP") tried to fix
the fact that GRO was not possible without XDP, because veth did not use NAPI
without XDP. However, it also introduced the behaviour that GRO is always
enabled, when XDP is enabled.

While it might be desired for most cases, it is confusing for the user at best
as the GRO flag suddenly changes, when an XDP program is attached. It also
introduces some complexities in state management as was partially addressed in
commit fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down").

But the biggest problem is that it is not possible to disable GRO at all, when
an XDP program is attached, which might be needed for some use cases.

Fix this by not touching the GRO flag on XDP enable/disable as the code already
supports switching to NAPI if either GRO or XDP is requested.

Link: https://lore.kernel.org/lkml/20240311124015.38106-1-ignat@cloudflare.com/
Fixes: d3256efd8e8b ("veth: allow enabling NAPI even without XDP")
Fixes: fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/veth.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 13d902462d8e..bcdfbf61eb66 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1464,8 +1464,6 @@ static netdev_features_t veth_fix_features(struct net_device *dev,
 		if (peer_priv->_xdp_prog)
 			features &= ~NETIF_F_GSO_SOFTWARE;
 	}
-	if (priv->_xdp_prog)
-		features |= NETIF_F_GRO;
 
 	return features;
 }
@@ -1569,14 +1567,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 
 		if (!old_prog) {
-			if (!veth_gro_requested(dev)) {
-				/* user-space did not require GRO, but adding
-				 * XDP is supposed to get GRO working
-				 */
-				dev->features |= NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
-
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 			peer->max_mtu = max_mtu;
 		}
@@ -1592,14 +1582,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			if (dev->flags & IFF_UP)
 				veth_disable_xdp(dev);
 
-			/* if user-space did not require GRO, since adding XDP
-			 * enabled it, clear it now
-			 */
-			if (!veth_gro_requested(dev)) {
-				dev->features &= ~NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
-
 			if (peer) {
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
 				peer->max_mtu = ETH_MAX_MTU;
-- 
2.39.2


