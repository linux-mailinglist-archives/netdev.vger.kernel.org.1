Return-Path: <netdev+bounces-233414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F900C12C6D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8DAD4E42F0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A22868A6;
	Tue, 28 Oct 2025 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jO+M7QVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A62857CA
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622725; cv=none; b=gzLVgw6kTpSvlFhq2znxQXJ/u0X2MqSwFF6De3zz21Na+sPXZ93o5Ccr21G6xEpa+mgPOHoAhmwOtxDrVezmc9yPvplOwfHFz5+jpPHcKZtVWKbxgvhxETIfhQ/tVW90WJyaCsaObepQ5BJ4b+lIeoI4ktMGG9XOh78cRzJiVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622725; c=relaxed/simple;
	bh=5lQ5VQFxdfZoE7RND3HuMXHpyaxx4tP+od8v23xoTlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZCe4yZqRd6pb93tDSckuQfGDbBWJA2dLyA6hirCl2NKpkuFa4AGHDBr3QwVlAUHLXTJC+K15LciEiXrmgSG5Ckoy8kw/+uobYd00OOrVimksOaQK/DJOwlNgvHxLC/vgt9go8eNRGUw63XwIFV0Ibgk0tQi2AoMmUYSnYjrA5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jO+M7QVS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2698b5fbe5bso73876675ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622723; x=1762227523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpLeceQtfput3QA6qTItvVlgj/C32DrQhLkKLk5V5ZU=;
        b=jO+M7QVSLQJdu3Kp1u5LqKLX+vrc+FV9vz46S8b5DlOUg3ABdA2z9hHQt+0ygsb8kK
         ynYg4h/Fttv6LzpifTurbpBOrMST1LBzAHoOGDnJlwL0QrXKCtTlZYWlXYDDz43lADeh
         Fcg6itRBRcvVEEJjQRcePH+zIH5J4l7PFjwdYrqz7V31+04SSlrMEKOdc3H+X9BMvR1j
         ucj67b9N8IIOqgnhLw40Wz9W/QMmydMwhZsjBjUkvEgJkAsm0YrFf1xNJuR3qZh+ysC2
         7l+KXBWUiE9lgFxMi205snJtT3GQkVL8hijUtpJ7M8YEuK6GN9NGfNqa6jnjbzKZH2Dv
         qtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622723; x=1762227523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpLeceQtfput3QA6qTItvVlgj/C32DrQhLkKLk5V5ZU=;
        b=Bs8+veAS3bTQ4sU5uM28aNlZVwAVUO6S0K+UuVBsSdkmiCCV63wah+qxIHYbMYn3PS
         g2ZfoUjfcQxIGU0s1aFRR1WdmbLG9ZngduO4twKxnx8PRW4H8fwKE7UwsmMezI+T96Eb
         7tfU999VM1TNJ8DESQDnbJmdlERErD2d3Nk8d+370eFqEAu8Rlk0qsjf9SxojssInqUW
         8zooWIiBDRvOmcqId3didzZuW3IKD8Jy2lTej99aAtMhCpkVG9cptDcp/RGNejNbLAM1
         Nm4a0GkGK+g3/GdKDth2ywt3NKJRA1CfxXsBX1SCyyXfzXbvGlNSTnxuSm0y6W5j9+eS
         4ORQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9YKLuLPGmZPlzghP4LgydUbJVVQAoQ1i19Xml3b/GPFgHMW/5jcpSwNWgpLxZONLpkRlo0ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgikeMaB+OZpyUV5tWHB1kpgUku0eJl4lAOq6Whq+OCvKShHKT
	epz1XG9IC+HzHDlYUSLF+uAnlySIZtf+UJIvvX/VTzJ/cyh0cqIrgukutwOkd0qEpUfaDJK5Dn5
	9BjD1iA==
X-Google-Smtp-Source: AGHT+IHbUPsV5rTWZ+R0/Eb80Hyv3J2Jl5ABf7ZRdUlcVGM/6H63YL68mlbSFTZ91wSTF4ChGoiBOow+aiY=
X-Received: from plgi3.prod.google.com ([2002:a17:902:cf03:b0:290:28e2:ce65])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c1:b0:269:b6c8:4a4b
 with SMTP id d9443c01a7336-294cb36c161mr28602105ad.6.1761622723192; Mon, 27
 Oct 2025 20:38:43 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:06 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/13] mpls: Convert RTM_GETNETCONF to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_netconf_get_devconf() calls __dev_get_by_index(),
and this only depends on RTNL.

Let's convert mpls_netconf_get_devconf() to RCU and use
dev_get_by_index_rcu().

Note that nlmsg_new() is moved ahead to use GFP_KERNEL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index f6cf38673742..ffd8bc96be55 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1282,23 +1282,32 @@ static int mpls_netconf_get_devconf(struct sk_buff *in_skb,
 	if (err < 0)
 		goto errout;
 
-	err = -EINVAL;
-	if (!tb[NETCONFA_IFINDEX])
+	if (!tb[NETCONFA_IFINDEX]) {
+		err = -EINVAL;
 		goto errout;
+	}
 
 	ifindex = nla_get_s32(tb[NETCONFA_IFINDEX]);
-	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
-		goto errout;
-
-	mdev = mpls_dev_get(net, dev);
-	if (!mdev)
-		goto errout;
 
-	err = -ENOBUFS;
 	skb = nlmsg_new(mpls_netconf_msgsize_devconf(NETCONFA_ALL), GFP_KERNEL);
-	if (!skb)
+	if (!skb) {
+		err = -ENOBUFS;
 		goto errout;
+	}
+
+	rcu_read_lock();
+
+	dev = dev_get_by_index_rcu(net, ifindex);
+	if (!dev) {
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	mdev = mpls_dev_rcu(dev);
+	if (!mdev) {
+		err = -EINVAL;
+		goto errout_unlock;
+	}
 
 	err = mpls_netconf_fill_devconf(skb, mdev,
 					NETLINK_CB(in_skb).portid,
@@ -1307,12 +1316,19 @@ static int mpls_netconf_get_devconf(struct sk_buff *in_skb,
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in mpls_netconf_msgsize_devconf() */
 		WARN_ON(err == -EMSGSIZE);
-		kfree_skb(skb);
-		goto errout;
+		goto errout_unlock;
 	}
+
 	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+
+	rcu_read_unlock();
 errout:
 	return err;
+
+errout_unlock:
+	rcu_read_unlock();
+	kfree_skb(skb);
+	goto errout;
 }
 
 static int mpls_netconf_dump_devconf(struct sk_buff *skb,
@@ -2777,7 +2793,7 @@ static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_modu
 	 RTNL_FLAG_DUMP_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
 	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
-	 RTNL_FLAG_DUMP_UNLOCKED},
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 };
 
 static int __init mpls_init(void)
-- 
2.51.1.838.g19442a804e-goog


