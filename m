Return-Path: <netdev+bounces-68129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504F845E2C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B1F1C27576
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE857B3E0;
	Thu,  1 Feb 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICJ04jCs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612016087B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807396; cv=none; b=WH1/+SfaPbm7+MTYFxm+wraf7FdKsU63R7bhIDdb13wbN16wnjk4iClPuZcfxENML1jBolNCR9MeiC7X/0Mn4EOQgjxnKVCkVV9NtfVrQPZGablKL5Ow2JQ75b0xZfq334HnabHqDIyfLQRq1IKLziYADaA/L1k8mth1WIAmTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807396; c=relaxed/simple;
	bh=xAxp5xFgVrFA1a6U7eL+MrrbMLGuuL5YASrdAZKQgas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZqvCCYcYXiQMYoWiIOZE5Y2O21lbvHb/+986jl8zsdluOaNNg/Ja4DZEpbtHbg4pumAE+TnpUl5511SDE67myrGdA55BR/N9jKV1AEoNOqRb4lXlala4cM8Q/zi7JGDJIe+bnx6XP9p0dtN9aHLE4hGmUZMhuNkKtw8SqP5maA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICJ04jCs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1749861276.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807389; x=1707412189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=llOERzv0gIhQLAJyNixoUggH/iIEOzRcK8Ng/jiU/7E=;
        b=ICJ04jCs7RpBBQBLTpXxVBMjzw9pL+kGIYxCgh26w3usTTb6k/1rsFj0aBnIKRfwaV
         SQkZqWjBgSru6GmxS4W6saZEu2HEJN+3qrG4TDdRhNYu+0ssyZEUTjJI114ObRMWcatC
         9mpK8TwiMYt+i2UzRgmlGbCRjnpYt+tnaLG4CdrgeYpMih4qsUZbYY5rFVEkTLdSvXWL
         GyCV0ROSUSFZ89aMal+wJwwOxeOw42+QUyqTBeBjseAxi4BCCAVeP0g+IAekMzRqoYhy
         MKLiC/dR73yNSwDD2SMP13UZCxgoo8ZYZyiOquf6/YvD+YVXjIlra7xC8XOqrYEeDudJ
         p6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807389; x=1707412189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llOERzv0gIhQLAJyNixoUggH/iIEOzRcK8Ng/jiU/7E=;
        b=xAz5XNpvIfDLpfLtZfgeA/hNAD0Y94ukKqPt3159uwoHHeK3DjxMGxquRmOUk+dapV
         OpdGAy3az/zg9BYfQPaWqSAAYxIF/tBEv5fG+9w/0m/uP8Jaq8sqLe8A/R3qGUK4uLaj
         dcTZJguj/zN4u+fT1m52+3C30OPV1/5Sxp8/615a6Jmqtn/ALI2xmau7JK/fAUGOR5uB
         Ao0ujhETiU4xmeWn6b2Ok1bMePWKsXIjzNtDqjbn0gthJ241OcQ5Qe1z4nZ7pP9UAqqA
         lT3sVx/ZcdwUoVrTbTrMJ4fdVMJH3Lx8hKYGnXn3j2xGdm0DMPRJ8ELmHTnQpEJB0eIy
         Lw6A==
X-Gm-Message-State: AOJu0YzHkF7WIGmPHwzAkrgY8/lEy1PU3/wBDYA6NGFXIqKpYe2tQStY
	JIGmTUzK+Yz+zGZuM/ylTtY3T2c46vT6vGjhkQs6gnF1Imncvuvr2Nx+RHleAzbiSUwjB1TiT/h
	2WBaZ8vf7tw==
X-Google-Smtp-Source: AGHT+IHNQ5B63wttIgNovCUZnpjrMJsQNt4CuexKJ5mddkPQjDBP6K3NPAairlHoiVTZn5Tqk0+AceLy0RTRdg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:250a:b0:dc2:3247:89d5 with SMTP
 id dt10-20020a056902250a00b00dc2324789d5mr166922ybb.4.1706807389474; Thu, 01
 Feb 2024 09:09:49 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:29 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-9-edumazet@google.com>
Subject: [PATCH net-next 08/16] ipv4: add __unregister_nexthop_notifier()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

unregister_nexthop_notifier() assumes the caller does not hold rtnl.

We need in the following patch to use it from a context
already holding rtnl.

Add __unregister_nexthop_notifier().

unregister_nexthop_notifier() becomes a wrapper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/nexthop.h |  1 +
 net/ipv4/nexthop.c    | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index d92046a4a078250eec528f3cb2c3ab557decad03..6647ad509faa02a9a13d58f3405c4a540abc5077 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -218,6 +218,7 @@ struct nh_notifier_info {
 
 int register_nexthop_notifier(struct net *net, struct notifier_block *nb,
 			      struct netlink_ext_ack *extack);
+int __unregister_nexthop_notifier(struct net *net, struct notifier_block *nb);
 int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb);
 void nexthop_set_hw_flags(struct net *net, u32 id, bool offload, bool trap);
 void nexthop_bucket_set_hw_flags(struct net *net, u32 id, u16 bucket_index,
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7270a8631406c508eebf85c42eb29a5268d7d7cf..70509da4f0806d25b3707835c08888d5e57b782e 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3631,17 +3631,24 @@ int register_nexthop_notifier(struct net *net, struct notifier_block *nb,
 }
 EXPORT_SYMBOL(register_nexthop_notifier);
 
-int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
+int __unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
 {
 	int err;
 
-	rtnl_lock();
 	err = blocking_notifier_chain_unregister(&net->nexthop.notifier_chain,
 						 nb);
-	if (err)
-		goto unlock;
-	nexthops_dump(net, nb, NEXTHOP_EVENT_DEL, NULL);
-unlock:
+	if (!err)
+		nexthops_dump(net, nb, NEXTHOP_EVENT_DEL, NULL);
+	return err;
+}
+EXPORT_SYMBOL(__unregister_nexthop_notifier);
+
+int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
+{
+	int err;
+
+	rtnl_lock();
+	err = __unregister_nexthop_notifier(net, nb);
 	rtnl_unlock();
 	return err;
 }
-- 
2.43.0.429.g432eaa2c6b-goog


