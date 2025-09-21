Return-Path: <netdev+bounces-225112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5DB8E7C3
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63241189CBCC
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD862D9EFF;
	Sun, 21 Sep 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GruyAGKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B92D8762
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491786; cv=none; b=IEqGA/MP5vsh+cIyxFLJwfVJ8H3IFZqqWrHNUndA0spD7bSbSAA8DFFQ8fMfKbdHmpbiL5cuZaXzGAeSN8oWKPNmVNhNo6XuxdveS13pX7gFF4I53hxK6A0f/kAb4I5y9zi6vDyGKiC3pFLoXGmcjC1ypZ4fvC9WgYe07yDE1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491786; c=relaxed/simple;
	bh=yUxPsW1neulTDSc12DrjlnnLI2RxeIiDkeTBPbs2djs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1z84+6pHKVVBSeo58oEdq5pY1YC/a0oJDlsAj0mZ/pLJ0PEV6PSuHa077gNLEZ5g6xyFjFlp5cPAzwt7Q74IAFRpKUzGpluVJUbbndzQL2GfEpahDmR+iyEg7FpCKjRaIAlQrIjlQa1JkcMIezAhM5GGGTzH7HhtIssNjDAzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GruyAGKO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2099352f8f.2
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491782; x=1759096582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOfYi+evOXJssk3GreSh96Tr6S4alFUvF1o54q0ZtXY=;
        b=GruyAGKOwZLIpP4Lc160v/7prT9B6kNgcOT4tIIhXx6TFVygu2OwKIu3ZUexPLXQE2
         wnBrv2LSC7d56narxHMSRFXDQbiXNJhuFQRPSIYdhuE649cwYnE3WWiBqC9jeu5fCi5v
         9LAdWS3kwIwpesjX98q4k7XLMfltwC/NFa1qhl17L7aw2mLiA8p4Qo3gbs4O2RTd34Uw
         7H6KmJJey2+WbzA3kcY5IslW6vVEs2wE3k8qQkdUm74zb+TP9z7k1lF5q7iam8yC7Dnb
         Clwln0EVjJMrEwfXYBANadSP7vadMOccdVYSJpbuMVBcBQ344jqdo8QKapUBYjEZu0Kp
         qEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491782; x=1759096582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOfYi+evOXJssk3GreSh96Tr6S4alFUvF1o54q0ZtXY=;
        b=oT18FjH1aOm/FfJTUzWejlQ3WSYBGMy1JuH0caufHEpO+NAIJf1VLVuIvmEk190dP5
         JGP1REkhEiN8qrRZYy3R0lVctDuTsaSCEsTncMVzFmDclpL87U8L3KxEL7oWo3iOGB9L
         xXptZTRjUTxW/WyvIeFxTehxMBnYl5Men8mL428dj0RmuVWaa8b5Jaf9zdKQ6q+/12bT
         KCPHxPy/wgfEwG8vTCzBWO1odfOYUr1RkK2FgUC/WHlsB4lmD2CVaxSKxYD/Tv8jyYvZ
         fcqfzHtKExLn7x/DZC9Dzzk/OLj8muPv2awa/tCwnyJpmdwim+mobJyQMAbkhZ6kgDy3
         3qjQ==
X-Gm-Message-State: AOJu0YzN16POUCOqm7yqkyOH1ZRg6kP1CYMTW/B5ezt6SMcfbHSVT8ih
	3BE1AvdL9MWC+p0B9RbVlp5+S3NjzWqCmt5Car4KmjYxtftZxbvjJmtj
X-Gm-Gg: ASbGnct85h8BtGYNkXZrG4Ed4EdeWHJwl34uy5EfJ4xtYzCEeLncsLN6HN99fipXtl+
	stl9sWTeiJUxRhht9PyOwcgVHF+4ps79H+jZQp2K8taFj6Do2JaqgGR6rfov0fHJHtunDgthhvz
	eHHzAuCUWT8nGgwBSUzZil8Ym3ohBqhG1FWaNjR84CMg19eGG4S6yZiJ+VXncdDysfY2dwtdhQv
	BLv19atxGYHHqedJg5jcN6Y5RbRVVZWMxC8stIqOnsmap4L0J5aPV8kq23iBVhNJokUVrsdM6iL
	4a+oxi8o2Or9PWmr/GmKMQbX+G1ymMoNs7w1tWWhUsRFqqnrV1yWELCKYmCHlofcAhpj6rd/zf6
	oZpIwL6Z1ChTVVlKsAPYsxd3CqoU=
X-Google-Smtp-Source: AGHT+IHkY8glqJbAdbx/HQxL8P57QDbgpjHvW7djVIuzTEhF8v7QKu+VXWTwdbbHVgsscAGah8UFmQ==
X-Received: by 2002:a05:6000:1acc:b0:3fa:2316:c21 with SMTP id ffacd0b85a97d-3fa2316187bmr2371046f8f.17.1758491782460;
        Sun, 21 Sep 2025 14:56:22 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:21 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:44 +0100
Subject: [PATCH net-next v2 4/6] netpoll: add wrapper around
 __netpoll_setup with dev reference
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-4-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=2309;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=yUxPsW1neulTDSc12DrjlnnLI2RxeIiDkeTBPbs2djs=;
 b=d2nNT4dGAA6498qUFNrx4Kp0pt0EnCm5K+QmHqWERTvkBThp1hPs+jdrh+xminlvQ1/FIh9Nb
 JRvwqeiYmuhAx7pLVrhPxTRorXRAuN2SpVG5juSaJuNj+g9+5QnxmXi
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce __netpoll_setup_hold() which wraps __netpoll_setup() and
on success holds a reference to the device. This helper requires caller
to already hold RNTL and should be paired with netpoll_cleanup to ensure
proper handling of the reference.

This helper is going to be used by netconsole to setup netpoll in
response to a NETDEV_UP event. Since netconsole always perform cleanup
using netpoll_cleanup, this will ensure that reference counting is
correct and handled entirely inside netpoll.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f22eec4660405eaa654eb7746cbfdc89113fe312..345e741126748c0ee8d55dba594d782bced4eeed 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,6 +69,7 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c2491096f79ea6cf82eeef222c3eac2..bf563c4259f6cb19c31613ff277eb5a0e2165e43 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -608,6 +608,26 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
+/*
+ * Wrapper around __netpoll_setup that holds a reference to the device.
+ * The caller must pair this with netpoll_cleanup() to release the reference.
+ */
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev)
+{
+	int err;
+
+	ASSERT_RTNL();
+
+	err = __netpoll_setup(np, ndev);
+	if (err)
+		return err;
+
+	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__netpoll_setup_hold);
+
 /*
  * Returns a pointer to a string representation of the identifier used
  * to select the egress interface for the given netpoll instance. buf

-- 
2.51.0


