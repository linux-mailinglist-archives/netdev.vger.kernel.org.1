Return-Path: <netdev+bounces-148200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42309E0C9A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750C7280F03
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C781DED4D;
	Mon,  2 Dec 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="x8OEk/c4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6F1DE8B3
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169313; cv=none; b=Ew6Etdwj+5Ff6srkwxrfG9FBvqhZZd5Lf5zwH+OLIURYTYfrqugdt9gMUz6568UHI50k0hwOZ0cI+e77Heg5dSz8pN0xyhM0lduViHpeHQr+Lt6bCLPQWZ6PazASm4FPvPsEiyJqCsxs4Gd1L3apArLT/RKlXlpTSSyecgXcWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169313; c=relaxed/simple;
	bh=pxh8grUMvqJBGylhMPYpSUfz6LOHGp0+0GbZkYU8Sto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7kFkmDRAM2qgIadX1S6cCB8Kg5Z0aCVi5Rr8jNS6UjxUi/sb+0s21UxHL/IVoz2mHIGN6FDIuTsa68R098mxlO+jhA2b8jXCMUo4gwoYqUoxFRy5VMQCj3/KEzXC69M++lfexV2G6lXmyg6DOAqRe+U2xCQgkOLIR2RV437vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=x8OEk/c4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b67a94ae87so279951885a.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1733169311; x=1733774111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXntLZOBYToAE4e1z/0kMPS4CzoGHC4HyiF9Kuy9Nlg=;
        b=x8OEk/c48nCRvKmXUfA79UqY+qqWzDCbDya23kdzb4WLONyfEweo04BNh7ll23eZDj
         7hCPFjGRAN+dPsCkvkhdMW7cL/eu1BjD3FPkmB+euEeBDehoVxAHna7w0gHstyAo4zId
         Xhe23QiLcK0IYl3tjXYoJfe31fwbPIUbaTYLCt3p4fngLKmbRPEXIzjy7yvHa61Os3ya
         yNkQD6LPr8l5imc2Pjg1Ioexg336eI9BNGUid68Idkxiu6zbjnuYEeoztjWyroYxxK+T
         MgCzghMvNbmQB5hzTxK7HQ8PByYYr/Qw8WHhiRhVyOdeXO80yOTLZ31tpmrUzE9a42NZ
         9Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169311; x=1733774111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXntLZOBYToAE4e1z/0kMPS4CzoGHC4HyiF9Kuy9Nlg=;
        b=E5Z1poKaw9GH2g6x6m5bD4RWKv4dRDk79T78R2ZjRPN8McSmspor+eYyBeYU8+oCni
         mDjkLx0uHOpQv6ZEBapZEPQ8bYBaqTLJD3Di6CQfnehDGdqmA07V7eBEWOfUBhETUBHO
         sxRUJomr5RSIPx+hd1tJJyTCfZvsXP2SggWzbEgJwR4gsvYMXKeMQGXXyv4egRw/YyvQ
         58YQ/8X0dRiLJplnw7+2gtRDDn15H70C2LrAGdfYaXMHZt8B7De66ubFNdhfOAgWev2Z
         ZEiooxrQQbytvUP/FJt7yrFXRXyQvVbZvTsZUrVtvqcaK0y4NJmCURGYCn0UVZw2IGhv
         Q6ng==
X-Gm-Message-State: AOJu0Yx/s7joTZtNnhDxCTMRddTXRx7GxpAekpG+Zkwgwtt8HABoWYOK
	JuLMkYzTsxarWI0s1Hbg2Q5RhW4TIEVLlqpkBdu50gCZD1oBMM2wheLB1yqM54E=
X-Gm-Gg: ASbGncvaKaot3NTjLVXiSzNd7YL4RCvb7FGhCP0qUoh2P7ms8+pV/h8zyho1PdQTfNy
	JmAYClRiyQyUscBVQ5UMOoMP4pjQXcqZvTV3Imvo0i4vjCpKYtvrZAfwrlz8Moe6aaZNekvGugQ
	jdmZs0bglA2U3zvSuJ9tm3xmU5hvGMk+BjLezTyX2UaB4V6gw1f7BD7H0Gqhbs9fU+VUSgEtSUF
	xSJ/r9XWlaBIPxugZbkD/ndgb3jhx6/HjQeWn8m/bC9w2ht+kz400bGfVVzgC8LPJzzeXpD9GuE
	VMs9lz9kNnbfEN4How==
X-Google-Smtp-Source: AGHT+IH7jMHZuSZZo2PI/NEGFUcGD0IVLK+ivsRBO2IP+SpUjaEZ9qlKTaaCydeh+UEE77QGG32ckQ==
X-Received: by 2002:a05:620a:290a:b0:7b6:6b34:879f with SMTP id af79cd13be357-7b67c28383cmr3468499785a.22.1733169311004;
        Mon, 02 Dec 2024 11:55:11 -0800 (PST)
Received: from localhost.localdomain (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aac8dsm439338585a.77.2024.12.02.11.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:55:10 -0800 (PST)
From: Maksym Kutsevol <max@kutsevol.com>
Date: Mon, 02 Dec 2024 11:55:07 -0800
Subject: [PATCH net-next v5 1/2] netpoll: Make netpoll_send_udp return
 status instead of void
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-1-70e82239f922@kutsevol.com>
References: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-0-70e82239f922@kutsevol.com>
In-Reply-To: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-0-70e82239f922@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Maksym Kutsevol <max@kutsevol.com>
X-Mailer: b4 0.13.0

netpoll_send_udp can return if send was successful.
It will allow client code to be aware of the send status.

Possible return values are the result of __netpoll_send_skb (cast to int)
and -ENOMEM. This doesn't cover the case when TX was not successful
instantaneously and was scheduled for later, __netpoll__send_skb returns
success in that case.

Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
 include/linux/netpoll.h | 2 +-
 net/core/netpoll.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b34301650c47..f91e50a76efd 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -57,7 +57,7 @@ static inline void netpoll_poll_disable(struct net_device *dev) { return; }
 static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
-void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 void netpoll_print_options(struct netpoll *np);
 int netpoll_parse_options(struct netpoll *np, char *opt);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2e459b9d88eb..8ae10306c1a4 100644
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
 

-- 
2.43.5


