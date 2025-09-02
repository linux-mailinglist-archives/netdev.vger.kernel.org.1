Return-Path: <netdev+bounces-219203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2584B40725
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568894E49E7
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474932ED47;
	Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D12324B38;
	Tue,  2 Sep 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823813; cv=none; b=unACDbl+UixNH4m4/Ip9j7PnVZYpO+HGw94rqMlvwOH1Fo/CQGg1+1U7EYdr3OU83B2kaxrxvALr1yF+dMY/YUxR8dYwVR1CMXsomI+keMvs94eqhDNNyXuEBQQLB75+npmTHROT97AZ3ku6kiQZlF6tZGVok46qct02OXgG8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823813; c=relaxed/simple;
	bh=fBTiCfurI7dxZQKPkwQFVbTBFADCdtM6FvMkk97zj/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIG9eftbB/auRlqGUrJwyy5FruBogf9RY4/U8ciH5PAM3rGmVsqE+x9xE0drSBcvYJiTX0Whq1xqC59ubx56W+mNHjmIVx3U2MUoGIZmXTGifKQoMIIPkTgicjr14KSSA0HtkBo2DDnLwoP8i2bXaIEft+W8s9dixC+Rga4mf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cd3748c6dso11315136a12.3;
        Tue, 02 Sep 2025 07:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823809; x=1757428609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdT0QyqHw8TFh37W3ZGyN5wTJOSamT7r/yaGCZKnaWk=;
        b=t9KMHiQqEIT5szHnA0dNkPaKUrNMWAoIsO6xyMv0G6LBGgglJZ9qfrbYCGBRM9CC66
         Ay/oDvLDLYKSKsdHv+YhD9iqD9l8M9uMMhjV2QrceJ8hwy/uq/+TGYDbFnTFvb3Gvp59
         B9j8MbfyJ+ECMdg3pfykT2iparFk/38MR+rr2KVZ6X2DCdEvxkOcRx7f9209d6CU2qyG
         0i/iyIO85wSW4Mz8eZsIMTGiJwXqZuATCZl9u4gyJaO/7oirY3Tazuh2TfcgY3y//FU+
         I4EtkmC+IYmt5DEg9YGzidyV5Khh0lta86SbTLKWJg9NW4AaNbXWubDW4cbCBdxP0xEm
         TCbA==
X-Forwarded-Encrypted: i=1; AJvYcCXmbkgDuI9N2ydvuA/2ixh+aF7Va3OcMSfqmOH874vPo8QuVnQk8hiJDjdtE2qbFXxBCJKWsJ1arS+ddhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1LQZFhvftFTU5QNhHOAIBumaBm2H4PouWI6CDBVelwOIewnt
	mpreaortMaPyQnDvwkoHUsANBJmB9FmBsd8gFn3wFjSLRFyeC1wHLd6Z
X-Gm-Gg: ASbGncsU916/QMIQmtAEaM1EC9eBzhBRMiBDY0mq6Bepmx63YZ8qlRhzT0uBNRIOnGU
	2kGwBwID6IxZuZ418Ba/AmU2nw0/OYkdCOSyw/im2oMyMvT89AHteV3tFRpa7L0LXkaMkQK7ENK
	kJY0MymziC2HK6F2dAImNwIk8CTClCSBm/gRynU59M1TKVoDYNIRBiN26hkSOkaGrBHwHLfieaW
	35v7zuZr3RdDeEgokAmwufS+5caxIuB8aXrSvDiWTOPZA78Au5xd3qNR1g7aZAzSbOexmcD2niO
	WQDsfAMuwPQsrKIzSF+bJx7+3IjG/wzqp1iZ77cGON+SIRXtZrlTABXOGn8u3sUcu3zp6/OTqOP
	VuUjGO1x8vA==
X-Google-Smtp-Source: AGHT+IEHuzvAoaTJbReKihr4Y0+Pz01K1SXjkSISpeaK7d+VFZby3xDPxx5UZ48jlE8bdq8epjBMog==
X-Received: by 2002:a17:906:6a04:b0:b04:37c4:115f with SMTP id a640c23a62f3a-b0437c41a5dmr683227466b.39.1756823809191;
        Tue, 02 Sep 2025 07:36:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042dcb9105sm504898266b.2.2025.09.02.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:26 -0700
Subject: [PATCH 4/7] netpoll: Export zap_completion_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, 
 calvin@wbinvd.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=leitao@debian.org;
 h=from:subject:message-id; bh=fBTiCfurI7dxZQKPkwQFVbTBFADCdtM6FvMkk97zj/A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5A2uswZH86oyEbSVUftlref/NBbjXIxRCb
 j8dbNrtpDaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bTnpEACaL/WY9SZPtvR2SrvKuVhDen4RCN5P/smxFwX/+Pj56tSnTIZHDAVXdKbQpovFZwA6+12
 pJmDybLaqffBt5AooIimbU/u95I7B511jO0rfU0oW78qXqgNFtq2Af31gjqGVMUpT3JW9E8KjDs
 nvQtDUF5TV/hXVE5ts8WQKHHp/c8xPyY80swiyeeEGX90UYPrjxV/PQGLLfnDiUiBecLU3M+hDO
 eDibeFkvbxt3m4T2FiFrcpdXIVnMGnpbJZa1KtVLKxhmTGoF1l/ezvHSKLILPOhjFu5ZSpN4kUG
 AUIKkaNgunm3Dt7tlOVm7DLNv6+Wpdk7KCf53N3lr3+F/kiOL9GQoIpR8OhMeZN3De7ZUwqRfqX
 ziMcq8CQEgQ+wbJnsr04Lm/pR5h6IgeGjQ57KgE8BLnh1eU8E/6eDl90QeVIT56ivszzf31HikQ
 ENcaqowI93CrDbVWCo2IH+wFA2EHbZBrqJscJYadl2hd96hBrpc+5tvB2E4E4o+HeawdX4GJXM+
 9Ik2YrwFZIwcpGjMLOB1hS2rU/LvnE+4w9h0MpOGfI+S7NNrvtV3kE/+ZoD01ltF16IxZdFh0cU
 mAsXne+MJBbDTQVVgoEy6TJ4zRO2qP7XKECKRCuWYMPiOSeTaeJPSBar3fuHGmWJP1Kf9VUwoyj
 n5OJ9rJtI2zDzqQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Make zap_completion_queue() a globally visible symbol by changing its
linkage to non-static and adding EXPORT_SYMBOL_GPL.

This is a true netpoll function that will be needed by non-netpoll
functions that will be moved away from netpoll.

This will allow moving the skb pool management to netconsole, mainly
find_skb(), which invokes zap_completion_queue(), and will be moved to
netconsole.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 1 +
 net/core/netpoll.c      | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 65bfade025f09..7f8b4d758a1e7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -75,6 +75,7 @@ void __netpoll_free(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
+void zap_completion_queue(void);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 9e12a667a5f0a..04a55ec392fd2 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -50,8 +50,6 @@
 	 sizeof(struct udphdr) +					\
 	 MAX_UDP_CHUNK)
 
-static void zap_completion_queue(void);
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
@@ -240,7 +238,7 @@ static void refill_skbs(struct netpoll *np)
 	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 
-static void zap_completion_queue(void)
+void zap_completion_queue(void)
 {
 	unsigned long flags;
 	struct softnet_data *sd = &get_cpu_var(softnet_data);
@@ -267,6 +265,7 @@ static void zap_completion_queue(void)
 
 	put_cpu_var(softnet_data);
 }
+EXPORT_SYMBOL_GPL(zap_completion_queue);
 
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {

-- 
2.47.3


