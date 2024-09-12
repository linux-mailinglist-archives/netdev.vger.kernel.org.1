Return-Path: <netdev+bounces-127901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53C976F9F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E243EB231F0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE51B654F;
	Thu, 12 Sep 2024 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="gUPUzZ1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1361B1402
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162626; cv=none; b=a28oxH2ZXa9dHzKEYQ5fn/ANVllDqHJ2OHFzh8GLf/0Gg9QmRySYkKakzjFR/WSUYpD2+pfOvNUo9QhNw7FbOYpSjYjw1kxBFqNBt2UW+5R7cxqUhUM/r1ZfbKqsVAzQawjcYjPKaTWeXv1P1M5La/Ea6uo1FEp0iHGH8hAa6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162626; c=relaxed/simple;
	bh=PVTyuqOVvCFzOUDK9Tn5EdThlcDl9bLWiPrCn58va4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCt2gfJFz59jKLnM6H6CBWdjGz+pqH8MHL7HwFKh/YLdLi75D+1JcnKlhs9eXr5ph/yL6G6FNxXrr2R3KEnUp/JvUz3YTQkOts6k1Gg7BMaiGd/6FkWpig2sQkiAQnLyvdgJFTbGAG40DgVojJC0lfDiRMd8hSNVrXOrOj8w5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=gUPUzZ1C; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710f388621fso669633a34.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1726162623; x=1726767423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOtRJrcxw3dtqnfY3QlAGbA9nOsusxHIxdHYZ/jMLnU=;
        b=gUPUzZ1C72WGEoxJcwEOLYrHvt2XNgVJfQ07UliaQVB2bCCdY811Jv3rxLPVYdwDu7
         1b72JhktAu4tbP7icWc5oDe5JhurPg/joBRE2twRpxyeo80bcof5EHdsoG72v2tPUp4Q
         3yfNuSKYGFi835R4DcAhHk+1eVWf+iC2hNtU3LLKn7xeJJG05YeBuTd9knjV9NR0klTA
         YcRf3AenAl6AGxjwf5scvCySrWWUVun6HucX5CtoEqfGDLIiEWDJfhecjVlojyh8AtJ6
         axXcb1T7fpHKe+WxehoyKi4gjLrgQp8QTvISpKOwsp0EZMC101xnsg7H5Q3L0SDxhLe3
         638w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162623; x=1726767423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOtRJrcxw3dtqnfY3QlAGbA9nOsusxHIxdHYZ/jMLnU=;
        b=osjX6pgSiKtdQSImHBQ3hxFcCILTzx+SdFfnXyWZ7ONNGQe7RcUboK5Mvf6o1/Dej/
         D/3ki4OKI75WeRu6aNcZDoaK2R3Q5K3JrFUeDFmc1CqvLh4P5dPXL06aSUka+vZ+MIaS
         +cXvnweccOxZtNGrS32oSTgmo9d+v4GSX4jWVpNaRNz+O1GYd/lQgVEeph4uMF0zltb6
         jRn2/6x3CuTzopn4fzztGIvVbPvq0VshVK2IbTw/x8CyigBAKhSOq1JdAs6mFLTijtEV
         nnXkOSC0xQyUfrp89QY3M64ttra2w2lZ9v3J7FBsjaHAQPLOaaq2EBuXQ2DGVs19Dtbj
         wpmg==
X-Gm-Message-State: AOJu0Yz6W3WstvZpwXxcfgj70poSSqYkeRXgcS7xgRU3ts41UeAx8sze
	s8OYY9xj0v8co5xOQ9ZBrV+olq0oyZATVhtAbnVE2dQGyoxW/y/d9vbXDDXG37o=
X-Google-Smtp-Source: AGHT+IFuJFPYZKz2lBRgAmDoR4knbI5REkie9iGjp3ZmQl7NVnWQuED7nT2O2sgZCjPhkrwXzU9mRw==
X-Received: by 2002:a05:6358:60cc:b0:1b8:6074:b53 with SMTP id e5c5f4694b2df-1bb14e31b2amr243669755d.10.1726162623037;
        Thu, 12 Sep 2024 10:37:03 -0700 (PDT)
Received: from devbig254.ash8.facebook.com (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534773619sm56605626d6.106.2024.09.12.10.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:37:02 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maksym Kutsevol <max@kutsevol.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] netpoll: Make netpoll_send_udp return status instead of void
Date: Thu, 12 Sep 2024 10:28:51 -0700
Message-ID: <20240912173608.1821083-1-max@kutsevol.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll_send_udp can return if send was successful.
It will allow client code to be aware of the send status.

Possible return values are the result of __netpoll_send_skb (cast to int)
and -ENOMEM. This doesn't cover the case when TX was not successful
instantaneously and was scheduled for later, __netpoll__send_skb returns
success in that case.

Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
Changelog:

 v3: No changes, resend.

 v2: No changes, resend.
  * https://lore.kernel.org/netdev/20240828214524.1867954-1-max@kutsevol.com/
 v1:
  * https://lore.kernel.org/netdev/20240824215130.2134153-1-max@kutsevol.com/

 include/linux/netpoll.h | 2 +-
 net/core/netpoll.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index cd4e28db0cbd..b1ba8d6331a5 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -56,7 +56,7 @@ static inline void netpoll_poll_disable(struct net_device *dev) { return; }
 static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
-void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 void netpoll_print_options(struct netpoll *np);
 int netpoll_parse_options(struct netpoll *np, char *opt);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index ca52cbe0f63c..4719db36ff25 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -390,7 +390,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
@@ -414,7 +414,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb = find_skb(np, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
-		return;
+		return -ENOMEM;
 
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
@@ -490,7 +490,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 
 	skb->dev = np->dev;
 
-	netpoll_send_skb(np, skb);
+	return (int)netpoll_send_skb(np, skb);
 }
 EXPORT_SYMBOL(netpoll_send_udp);
 

base-commit: bf73478b539b4a13e0b4e104c82fe3c2833db562
-- 
2.43.5


