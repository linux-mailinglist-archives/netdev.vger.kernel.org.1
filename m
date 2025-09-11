Return-Path: <netdev+bounces-221966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE7B526DF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD971BC6B40
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5B023815D;
	Thu, 11 Sep 2025 03:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rThgvsrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952B23A9BD
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560000; cv=none; b=AbWtDugRAvukFM4Wh8iyHbRrFJLwhAvpGa5uUX02pgZCBlcDEOuT92ZV4NeyiMelSx6ryWnKVUMEweK7dMV9izMnbHy3CRH8k6+f86mJKwsBJZhAc+wRTfh7B8kGzDhctGR3nY7eJ6Z/aw+1XIBN0U8eMnAVE7j3cTZaf0VrO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560000; c=relaxed/simple;
	bh=0fMu0saZm8zafCe4M85SBXktV9w+eneSFBPMyme/Rn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bx/ZWWMmptm9LjTEDB9lYb7ekd3GChu5oSpfAmr6Ad3iic/dc/9oWiM7hdDDhsPLXskO85O3YjKAOESLBvL6ZOsouzm8VwtU/QaPdaa1DA8Xt65O0ZzWzt5jpiZM5YyOqi3bkILfl7+b5MZOI6KETrqrfUVbyNMXyOIXt2Jpn3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rThgvsrW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77429fb6ce4so275324b3a.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757559998; x=1758164798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6VV9gv5LOXzwKK5uoO7aMjImTTj16ciigxjLmCn48A=;
        b=rThgvsrWZRWFlHrq8vsbfo6+e+/no38LWX3CdZftdsVM8uI3o7QS6PJT93PIzHh0A1
         V8Q6L+KkXH192k3Ht31G0o02Y+kt2DsaJDDxf5YGCj8wQa2t2yQIM1YA3QV/h1Ja1Pzj
         W0qDrXap9lLXiCTZbK6zV/IddwISYs6H2itgcPWEuwTweEUORAWMpdRjJFlPICy7aHbU
         B8K8OGsefuURhJdEfYLYoglVz/iLQUUFWyfI7teK4k4kZw4HZHOuXpQK3CYo1zBfnfA6
         T0QELqxRktFT5jgFxR6bYyC2eNtKRK8YhkgkN/G0JeJZqr86N7+k/4P7rub38cEq2kjE
         GclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559998; x=1758164798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6VV9gv5LOXzwKK5uoO7aMjImTTj16ciigxjLmCn48A=;
        b=h5pPZn9z32agaJ5cg5fer0Zyjpb9rMVhOpjn9j6JJUVQhg5I81lER2EbjEmdrzftvO
         kBTSz2yHylL/CgWWS/HRdl7H0B6KIRvoRIFVg6l4PLb0L9Z9azXcLWsF1lF/JEazxRK1
         VjZ0J/2uzNIVi3aHc5yVPzkT3fy4J5Q3miYGduuZLdD8geKZkoam3Rd0+xds9FaAdhSL
         uUQiYXfUfZQtsTXymPbU+1r1TYW0uaf6u9tf7E401RRQr42TsXt+nnpiJRnHyFxcwKJ7
         JxfkANo03aqoGJu147mqVUlMFJjvykuNo2pSnN6Yf7WxNEWdwv3S6m3J1l4yLo0qdW+f
         h9sg==
X-Forwarded-Encrypted: i=1; AJvYcCXavcDbZzKtrsERAlj2aMcgewNXRTmpTwSm33cnDbu4CMc7z84a32P6N5sdpJLWfT7psvE6BwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/DhtGx3tbDO+m8tNg6KpBgPh5879iRPh7VV7k8/3UunbCkfz
	QvMTo2chQSP3WFo9KEhQW7KpR5E+tma+Acn+VFZ2oJuj/7F4AH7UOq/qhRYkKnrkuqZu8ZZKWRL
	kWzXG4Q==
X-Google-Smtp-Source: AGHT+IHTB/e/+fgrPiKtnRLFu9X1Izpcbe3fqIjhd+jc8GOtZ25NUK7s/Bt494DaBA3ARzA8CVA2Fvhpp7Y=
X-Received: from pjbee7.prod.google.com ([2002:a17:90a:fc47:b0:32d:d510:f898])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734d:b0:240:1ad8:1821
 with SMTP id adf61e73a8af0-2533e94d11bmr26997541637.19.1757559998544; Wed, 10
 Sep 2025 20:06:38 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:35 +0000
In-Reply-To: <20250911030620.1284754-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-8-kuniyu@google.com>
Subject: [PATCH v1 net 7/8] tls: Use sk_dst_dev_rcu() in get_netdev_for_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Ilya Lesokhin <ilyal@mellanox.com>
Content-Type: text/plain; charset="UTF-8"

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use sk_dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Ilya Lesokhin <ilyal@mellanox.com>
---
 net/tls/tls_device.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..cacc1709e945 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -123,17 +123,17 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
+	rcu_read_lock();
+	dev = sk_dst_dev_rcu(sk);
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.51.0.384.g4c02a37b29-goog


