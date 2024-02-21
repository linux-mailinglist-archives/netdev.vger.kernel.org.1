Return-Path: <netdev+bounces-73627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C885D647
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4696FB232E7
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31DB41776;
	Wed, 21 Feb 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5ho4xaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0B3FB22
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513179; cv=none; b=jGsXqpo03aPKTs3WWRGLax1ryJzMUgRTtxlMuIn8e3CMOngJIrwxLj9E0lYSLy1JCoCHMQoRoOwrHo9HMUlD9UtqztWIT4vOlfPUU/++IAmGYlu4zGusn8IPSYJ1WAXw0c11bduMeGv9cgEkzlmPoIu71bjcJ1RdHRIoPEHEhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513179; c=relaxed/simple;
	bh=vOLe3bg0tRXIFmKpzHwgXmIPPTfHKKHk3L3/HNjTD28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t9zAIdPszaTcd0VInaePEm5iSsorWUfhqEZRzJ+l+vOJD3kVZn1G1tLYJW3hBAbugcV0jPLasKVtPkimLel7Dl9bTf0OmZiIL/bKWKBpHFKWmNPUAOKhD5gLL3TeO6oH9vfsXhAMk6SnvNG/+8tjiMQ82WTwxw6UMfKcHnwfyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5ho4xaE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so938505276.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513177; x=1709117977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sVU0GIN3o9YbvdKGN4zAa6quKptpEydRku+6jdZ/QI=;
        b=g5ho4xaE7T+vxiuBCEP3nPgjqOlIcVb56XSXBLJawGP//NZe44f2PSk1536pfAjYSL
         baV9VqNDIR8drwVjbI+la0pEZbycsiQ1GTtNX+NzWfkWMYO8Z95kjcO+85f3+Pkxy859
         HtZQQriuGFdW36aN2oJLjm/s971o2HXo4X2dBdjXldg9P2kHlBbLEobDmOvUNTXMF11H
         Ac+BrPT2tF7hlVC5QXYvkn4AN8qWqFBCMFNFW41mgQaRybWPAx16PZOx6TNI5e4/lx3+
         Sot+HPe4SM4tEM1X8Q4QzcDtSC0EwtziQnK3zsC14OvtH80nj2xEJfM7Z/Ftm6xD7vF0
         wgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513177; x=1709117977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sVU0GIN3o9YbvdKGN4zAa6quKptpEydRku+6jdZ/QI=;
        b=gBQX7DIq+wjhB/8jyXtIrDmA5CYTJwgrl1Vkn9PV7RvTWo3uV2xWhsCJY0Wo8tOm/y
         28Vjx1HJfpN1qFYFrc4jxRuIvjLOwV0f7UgYCMMioHGztxLTrdKAm+/JuZBS+4WWH+QW
         8BS665++QvWRDV/96bfeGdHykRuKcRiYTyeIbq17Dmp0icHfq0iGNoCFWHkCc2Q1BTWk
         h7fIwkPIjb6ep6Sz9j6l+Ygt7GY+MP9UAfvGntS2OGgy5aIIg2xp8OzmP4V2uSdTeYtq
         b8xF+DrGy+YUSTSYW85lARSoBQ6FBo5wFfuLeNPUaM5Jr4oTjSmwU7IlT75Krg5EfIaw
         DSwg==
X-Gm-Message-State: AOJu0Yz3lm8l0R35by1iijc1sK7fW165XfxAH9Oktng3mW+Z4PqTGkhB
	DMACZhi7YScgoMCd+SpvXsZqV7IIuwM/dLczDM9X+n6/zVIfPZc64oSZznFVITwPXAC8ZzP8StM
	bY9f5++oL8w==
X-Google-Smtp-Source: AGHT+IGA8Xl2wHNAOn24MgSj6nut2crct/U6FS9WFAEhRs7znk0upBrqT8Jw7f2lrhnMhrlz9YjpJHvQlLxldA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1209:b0:dc6:9e4a:f950 with SMTP
 id s9-20020a056902120900b00dc69e4af950mr4489487ybu.3.1708513177138; Wed, 21
 Feb 2024 02:59:37 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:14 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-13-edumazet@google.com>
Subject: [PATCH net-next 12/13] rtnetlink: make rtnl_fill_link_ifmap() RCU ready
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() to read the following device fields:

	dev->mem_start
	dev->mem_end
	dev->base_addr
	dev->irq
	dev->dma
	dev->if_port

Provide IFLA_MAP attribute only if at least one of these fields
is not zero. This saves some space in the output skb for most devices.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1b26dfa5668d22fb2e30ceefbf143e98df13ae29..b91ec216c593aaebf97ea69aa0d2d265ab61c098 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1455,19 +1455,21 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 	return 0;
 }
 
-static int rtnl_fill_link_ifmap(struct sk_buff *skb, struct net_device *dev)
+static int rtnl_fill_link_ifmap(struct sk_buff *skb,
+				const struct net_device *dev)
 {
 	struct rtnl_link_ifmap map;
 
 	memset(&map, 0, sizeof(map));
-	map.mem_start   = dev->mem_start;
-	map.mem_end     = dev->mem_end;
-	map.base_addr   = dev->base_addr;
-	map.irq         = dev->irq;
-	map.dma         = dev->dma;
-	map.port        = dev->if_port;
-
-	if (nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
+	map.mem_start = READ_ONCE(dev->mem_start);
+	map.mem_end   = READ_ONCE(dev->mem_end);
+	map.base_addr = READ_ONCE(dev->base_addr);
+	map.irq       = READ_ONCE(dev->irq);
+	map.dma       = READ_ONCE(dev->dma);
+	map.port      = READ_ONCE(dev->if_port);
+	/* Only report non zero information. */
+	if (memchr_inv(&map, 0, sizeof(map)) &&
+	    nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
 		return -EMSGSIZE;
 
 	return 0;
@@ -1875,9 +1877,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			goto nla_put_failure;
 	}
 
-	if (rtnl_fill_link_ifmap(skb, dev))
-		goto nla_put_failure;
-
 	if (dev->addr_len) {
 		if (nla_put(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr) ||
 		    nla_put(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast))
@@ -1927,6 +1926,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	rcu_read_lock();
 	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))
 		goto nla_put_failure_rcu;
+	if (rtnl_fill_link_ifmap(skb, dev))
+		goto nla_put_failure_rcu;
+
 	rcu_read_unlock();
 
 	if (rtnl_fill_prop_list(skb, dev))
-- 
2.44.0.rc0.258.g7320e95886-goog


