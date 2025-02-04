Return-Path: <netdev+bounces-162541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE3A27332
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2F0168669
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242E621B19E;
	Tue,  4 Feb 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwZg+0hd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91821B18B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675465; cv=none; b=DcgAAVPFIOlr65qVPhiwmJ+Lvd2B/0iqoHCoVLsjhV4TX3ScfkZzxIwtezB13Kn4AMEHyUWRQhRlONKcHUmki//4HdqNTt9HquWNEtCzZzYOxsCFPapUJsl/k9NJRTDB9PGNaE1RAU5unS7Mk3pCsjvo+TOivS3IafoOE3adHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675465; c=relaxed/simple;
	bh=u+DZYCZ71qEmcoaM8BqYeimI8o1k+MxdZFJa9VQVe5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qhj1AgPAMN4DZaRHvE57P8s+2Em5MlKN5EHXfrBuXyktt8gEWp4wCUqb9yJhdI4H2zUNT40EorMQuFytEjze8t7s7K5g3az3l+TcJi5+v+6bvINQd2KErwWV1/eEamoHV/xEGiSKKsQnsN9fo1v3E7nHmC3Y50P/0dn6QoO7+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwZg+0hd; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6eeef7c38so1270868585a.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675462; x=1739280262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkUZ2e8rWS1eur8t+u5qtaW84WZ8tA0iHVb0xvGzMSA=;
        b=SwZg+0hdXHXbeXt382ZxFj9IDwQwIp8KCcSVbW5NkfZx5p58kd8eYDnc+bfhNTbtRn
         jAMMPh7wMLrmpCPIruhvEatkWYci4mCkoI4WmxtrQY/W1LNJxncCeyXOVZJuMsDZRf/R
         BwidEEwhBk+Aysq6k+Y+3NBCgbAysIzg0bpC8J6X8Gu/l0m99bfFoPV1gwbmrisCowRM
         rJr1u6meybw98AD5iKxUPKJTnr8bLq/5YrdCykRAYF9dHh4Yi4fjBeq0Tf0s3jCnx7N6
         Wg0EzEd+1x9m1CCMyprQpwl5hOeLVcwC5ze1QKsrTpxRk0BYTkdGOT5OB5qp8RH6WuTr
         xa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675462; x=1739280262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkUZ2e8rWS1eur8t+u5qtaW84WZ8tA0iHVb0xvGzMSA=;
        b=gELbnTIU6TL7J9RN+BvCiS8WlJUDrOZmkMeSBGik+osR0bKIoBd1bf2+aAcjzjijzT
         axAOF14y1gGG4VFCs3ht5uy79iR6F7bBXrRj6ueV/f2/zyYRnBnQF+oJvDCsMUoQcgPs
         WV2TnItASUJaWlcwMaJnO0mnaisFQm4UohjddXs++eDIB7E+83K7SZL2QmoozY/02u1h
         bnAB9VqcQWusLQwceqzvJiXka+4ygR1nqNfZnomao5sXKO6oWgjRXPIK3jukij8A51j3
         0mBV8YbK0tqWsJv7119o5tDCzo+JUHpjtX/P2tz2AzNgoZ+hY1wOjewboNYlgNEUOR1m
         5cHQ==
X-Gm-Message-State: AOJu0YyVI8eCODkNOsXJg8i/qhQ3O37DcdVuurms2F6I7NwxNFSVdP/u
	izGm1qmH7wxe+hdJrbbxns4RXteh5xs1rw5cluuW1pfddhvEnLOL6/oymzp3ps0eUlJqzwrZuVj
	hGxSsFWWdrA==
X-Google-Smtp-Source: AGHT+IH00bT162gEv4FBB1T6dKL/GoBih1Z9jPJia9c1W2YdnU4CxbV2JumRpSXvtUqfdKypRpTxIiPA7XzLeQ==
X-Received: from qknpz9.prod.google.com ([2002:a05:620a:6409:b0:7be:5c25:6cf4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f01:b0:7b6:c714:f65c with SMTP id af79cd13be357-7bffcd0e89cmr3491224885a.28.1738675462281;
 Tue, 04 Feb 2025 05:24:22 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:54 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-14-edumazet@google.com>
Subject: [PATCH v3 net 13/16] ipv6: use RCU protection in ip6_default_advmss()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip6_default_advmss() needs rcu protection to make
sure the net structure it reads does not disappear.

Fixes: 5578689a4e3c ("[NETNS][IPV6] route6 - make route6 per namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 78362822b9070df138a0724dc76003b63026f9e2..ef2d23a1e3d532f5db37ca94ca482c5522dddffc 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3196,13 +3196,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
-	struct net *net = dev_net(dev);
+	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
+	rcu_read_unlock();
+
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
-- 
2.48.1.362.g079036d154-goog


