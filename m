Return-Path: <netdev+bounces-155883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5733BA04308
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6535918819A4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EB11F2C39;
	Tue,  7 Jan 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zq13Um6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E31F131F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261225; cv=none; b=jy3BJd590AFM1jyMA5OgKc/5Ah2NdWLEsb+RATzyMgGrvUJmI0wT/vTaGknaXqdSEk4BJlBLlvCsFTtWS+XnMW+DFctixaV06UTSQBs0ZJlP4UCohLa1uBdbKWNkyNX9CWna6ukc4++CWuHyTPa0CjwAc1udz6LlfOOSabZAsdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261225; c=relaxed/simple;
	bh=e7MdDX9nFQdqEAek16QFOwlRpkgl1pQTolqf9sIIn3s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NLPvcwVmn7GGe4u58KP3jceohpp9VE5QYN7bvQb0s5lwZdlg3leBENRSZOaCQwPiYfef32R/qd3uOscY/SbQvBxDHZuZbO1cBZe/Jv0Q+DqdNhOR8P09WX7LXNVlNtXKSWVH6y6mgEKRus9U0Bpm6Hz5iVdU3M4aCff5XNdEkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zq13Um6S; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467a3c0c8f6so320778961cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736261223; x=1736866023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uS2hnMqL9awRPvXIOg49Kr0BqSUTd1pzsRQe+n8Ywrc=;
        b=Zq13Um6SZeo+2uJtKTK+z0gBBlJSbFb+BwNJ105I+SWIUc3GKYcLlvGx80BURy6BaA
         Qsvd2nqVkEG6l5YOya9cp4e1g3kSmiSnyd2USELcYkxO7qD1eazhXuYjB8QnT5+o0g/u
         hPCV9w4gcobdKcaRUZO1ek2A9vJwIaubv7cfJum+L2moWs0zyyWthZf39SvHSmQzbKct
         Y6Jx4UG6V9YeyYJ649/SeGUeaO1g2XJWmQY3gsqTVo5o+EnygyZePfDUbjZ1dRnkzTrY
         nLkt86d0v2VmQnwtwW3nNVzDm9z5AdZkE1AOTA5QMHGPkWDf0J8aa1MMt+J85qfPUz2/
         pQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261223; x=1736866023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uS2hnMqL9awRPvXIOg49Kr0BqSUTd1pzsRQe+n8Ywrc=;
        b=j/d9NY9vzRCA2IjAhqRAFq5pgB3iNZmdtTWuDKytWJ6EEWhRs9/tUbnsYactD0MPNo
         +SEqWO6upwQ135VbU85AJpreNmbOduG/vw4V4RvuBsiTu/SQRtMB/E3pXQdxSSkejRpk
         996XlPGJ6eRfPOalK/H9354JbyAJIiq/CrHIUvSAWlnlVT64Au1o2sV3YY1wHt5j+Mys
         Z2Xds9/AJLaslp2Hryg9EfbJAUfaBFs74VSFKbBtlM8XL3ygLGf59/dwnd7CcxdlDcqw
         C9UsVyvXqgvmn6S1w75ITGgHT+YMYuq6w2Qrxj3toRGhzJK5snSe7slHHvVjtiss2Nk+
         W3Xw==
X-Gm-Message-State: AOJu0Yyyj4o4h30tTG/hmh0QT5vFf4NtuLz4W663I2Axv1M7YT+KpBrz
	XhBDDuEUrkNx+RnL6g23aJTgi8kSdbkkMjdixCi1aALf3P8J4cjo8zi4oy/g1QJrBkg1IVgUeaj
	HQIDwIhsMZw==
X-Google-Smtp-Source: AGHT+IFBCewguVHKTyvzM7Eb9oRzK91bUkL/HaD28UyHsl1dALi+pb84MRLR1irgsx4XwozuYhv09VOkf11SfA==
X-Received: from qtbhj3.prod.google.com ([2002:a05:622a:6203:b0:467:478b:fbd1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a0d:0:b0:467:8651:40a2 with SMTP id d75a77b69052e-46a4a8cd01fmr1078635901cf.13.1736261223013;
 Tue, 07 Jan 2025 06:47:03 -0800 (PST)
Date: Tue,  7 Jan 2025 14:47:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107144701.503884-1-edumazet@google.com>
Subject: [PATCH net-next] net: hsr: remove synchronize_rcu() from hsr_add_port()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

A synchronize_rcu() was added by mistake in commit
c5a759117210 ("net/hsr: Use list_head (and rcu) instead
of array for slave devices.")

RCU does not mandate to observe a grace period after
list_add_tail_rcu().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/hsr/hsr_slave.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 006d6ef97e53f4077eb16f08077ee366d8cb4bbd..2a802a5de2acca1d87ad475b3c96d2464a1faad0 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -204,7 +204,6 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	}
 
 	list_add_tail_rcu(&port->port_list, &hsr->ports);
-	synchronize_rcu();
 
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_update_features(master->dev);
-- 
2.47.1.613.gc27f4b7a9f-goog


