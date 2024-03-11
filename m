Return-Path: <netdev+bounces-79148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CBD878013
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDD3B21495
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4502E64E;
	Mon, 11 Mar 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KWjn9wkd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880022F07
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160842; cv=none; b=TsmYIA8TxkqYzyeuM+XL45BNrrYUbXMiNjQZDwmyup/yN4br8ueM2xqzECcmy9dLLUVasMOk6YK0TfODNcKZZ4SwSwgf0jSb28KHLKLFBUGLGkSGp2yxVPnfwpoE0egNcf4p5bmkRPSRzM180r0IB4k2jcZkDOtsExFHmlxS/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160842; c=relaxed/simple;
	bh=7iyN0obiYCS+6q+ebCFwc+JmlfO9przc4D5Z134DvjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/3r6Re6tNFJu5dHpFk2GOTrxsDnUvOdHF1SpkJ71bOYnh9JfN7ONdAoRbOy866dK+5qDeXU7rVpXOQX4yY3bh7/JA1ECD0w/+14MPJq7zC4844uPXeE5V2ynBkjXyangvCrrBg5ufr0QX15Mmns8YHn/LotJP2lp5Rq4HtDW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KWjn9wkd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4132cc37e21so3172395e9.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710160838; x=1710765638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUeKqYGVxUsunuJQG4tec02NEsEnm7zmFbvtCQVCYHg=;
        b=KWjn9wkdgjPZq1ztzOIEVSE13iOZsXsTh5/YI8IZDivNa4MjLRiLEEMeABVrAKzl0A
         jKf9+nudKWBe1fiBGwzYtsTIYFKP03YfzI6aXpYHU7Hi9xHC/a6iLkmEkfzCevG2jwt2
         FyvpDz8SsstPvhPnDksUZ3hJMgl1NtC3VBDLgdeWolwojqfj0p1C3AVWhW+cdw4KpYoJ
         9pXJA2uRqrlk7ADdwCKezhNYeEFLic/FNZ29tdTYS9fSEscLjY14Ap7sJ7bmkoHVL9Ze
         cMB752GZXnwq5Uvqdd3x7SRiJwVmPkN/Xs19y++G4cVnFdIE4FEeL8YFftEFVXN98/HD
         GB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710160838; x=1710765638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUeKqYGVxUsunuJQG4tec02NEsEnm7zmFbvtCQVCYHg=;
        b=uZ+0rXsLmJKhXKEEkJyhm0iHORGuimtHJy8AY1ViEeywU6TXg0AABn3HBsIqr05Z/Q
         fIN/PaDaqla3T8nl6Y/ZLmNiGdg6su9NuWJ7OWmSTsDpRFb+7oEqYttgDHK2W2eteEBY
         os8+Sp/U/MkBxTbeb7p1glRoOBiNNc/PUzNhdVipKAorqDX19kriNJvCDiRZfLjNW9ZE
         QTeaPhgk2prjy4gDI4zH2YORc157u5rZ09H9vbEwnR+4RIhc55SntDU/6ePZpV97xNCX
         1UVOeOZNcPqd7HTtANfXZK5NHVJVXXLgqHyuyl8Id6BS3kcH58keQZ0zO+62MugQjYkN
         blKg==
X-Forwarded-Encrypted: i=1; AJvYcCV3PlOv2TIApEiLoW3hh/AMj5Bnx/iXH+eC6cG/JL0+GU+sYEkOcZyjI8vZJexbOcB1AsfSwYPLXmCJ0i16dw5nmCsDBc9A
X-Gm-Message-State: AOJu0Yzq9L7Npahz88A06uCjrILQdQtxU0PTQGybv+ipJvlhfi7+BsfM
	8qjGcyeUoN8ws9geeMtoP7kED0eAq5XrVvEAmAF8Lxr2ccfbrPbKXJaTAGthw+I=
X-Google-Smtp-Source: AGHT+IGrWrKeOoeIXZ88Juws7JMAQU223c+6sOcyECtWdOTk8c7M3KTrvXuOfFZ0ZFTmwCOXsQgdNg==
X-Received: by 2002:a05:600c:358f:b0:413:216c:9d67 with SMTP id p15-20020a05600c358f00b00413216c9d67mr4729237wmq.14.1710160838502;
        Mon, 11 Mar 2024 05:40:38 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.6])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b00412d4c8b743sm8983383wmq.30.2024.03.11.05.40.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Mar 2024 05:40:37 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH] net: veth: do not manipulate GRO when using XDP
Date: Mon, 11 Mar 2024 12:40:15 +0000
Message-Id: <20240311124015.38106-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d3256efd8e8b ("veth: allow enabling NAPI even without XDP") tried to fix
the fact that GRO was not possible without XDP, because veth did not use NAPI
without XDP. However, it also introduced the behaviour that GRO is always
enabled, when XDP is enabled.

While it might be desired for most cases, it is confusing for the user at best
as the GRO flag sudddenly changes, when an XDP program is attached. It also
introduces some complexities in state management as was partially addressed in
commit fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down").

But the biggest problem is that it is not possible to disable GRO at all, when
an XDP program is attached, which might be needed for some use cases.

Fix this by not touching the GRO flag on XDP enable/disable as the code already
supports switching to NAPI if either GRO or XDP is requested.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 drivers/net/veth.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index cd4a6fe458f9..f0b2c4d5fe43 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1533,8 +1533,6 @@ static netdev_features_t veth_fix_features(struct net_device *dev,
 		if (peer_priv->_xdp_prog)
 			features &= ~NETIF_F_GSO_SOFTWARE;
 	}
-	if (priv->_xdp_prog)
-		features |= NETIF_F_GRO;
 
 	return features;
 }
@@ -1638,14 +1636,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
@@ -1661,14 +1651,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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


