Return-Path: <netdev+bounces-73628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659A85D648
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226101F240E8
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677793E494;
	Wed, 21 Feb 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpOwCMTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F594177B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513181; cv=none; b=CKLwyWXPyQxXsg3d9u1XuE6Kq5G+IPZRpey9fqAUwZweb6xW904V6r2j0LFUWf2LmeAn2DhyNWn8B9WfkhOHWyeL32Uj5fB5KjiZwWrBarPDB/dm+hCtmjPZOSFGv8JB9oB/WoWvIat0nwZrrmcHd2ZRyEaXCRpYl8nt43uJvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513181; c=relaxed/simple;
	bh=MCmeJUN9MGwXSLJpYrOsUpVJmNc9pnUbftUQ4SscTsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQ1DDA7NqtcuQwe/s9pFsbShESdzpaOnu7bEA3SyYsNJa/Uyx91KGJTP8QGtjrZXx6QIFxlT4lZ2IaI0Qxj9XBqspUeZGWKwIBkycWR8urNuF3yOYnzJonxx1v8BXRdghqUjQFFQ84yoS3OSQFSFnXG/UBtSHIv739RC79iX6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpOwCMTe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607cd6c11d7so95432397b3.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513179; x=1709117979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsZx506jUftdWvgOdSZWW4VlpaXV+yZD55s1/BJrbnQ=;
        b=NpOwCMTeR5fFVPBQ0M0R4nzFztRwRIDFsKGwFHo82j9aSEcV61/JpdPdd48Ud2fLQ8
         MIjg4ejKD13j32P64cbiWvs9u74WxdgmzA+Lo8wwUxE6WsF/UJRFKv83qfA1OyPdeXgT
         vSTlUe1uooYxNINryy5tLk57gaa9Zsr1R/YQWK6GxOPCYCqec9q+jEtL/Snpvs5kn20L
         nL5Kh7upqo/ZQa5AJgN2hNI6Q2/7jb+zOUdj9fOrgLgoZ4oyIsX/RlmqpwvWAZd6J6v3
         m8hxvZmYZGvWmNdzLyfJgMYLnNUMRe/SpRXBCUOyl7eUZkcQJquhFpzMk2yH5+nIyiE8
         jVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513179; x=1709117979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsZx506jUftdWvgOdSZWW4VlpaXV+yZD55s1/BJrbnQ=;
        b=e90a2GynMLoyf2sebvD9tGRWR3Jv80I+7LJwLk5zwIdmb1wurb+gmuslS6xDf1xkBo
         YHCEpoeyi9pvrUG4T1keoODVtWsvh5WrUNfKi/d8eBp63qD+nxHBseLw3f6tIY4FFxZe
         iAH8T1V8TFhAAQikQHTaaeJxGxZ5BtIsWiCkjr3KBwy1y1gmnSADY4PJP0dQ1by0AF3X
         GmmCx5hKDspNvhRE+BgcQOLlGKCj9cSidIQzo3DUuQkR53E3TQy//7FNmAh/+j52FCSt
         eOtRQZ1BACUK46sq16D4hM3cqpnWRyeHztuhzja9zBFv2pJv5C1Wl9s/KgVQEHTqus6m
         Lxpw==
X-Gm-Message-State: AOJu0Ywcd1gCenbf5XjhS+T/VoDxrgy0UDr8I+RLA3at+E1uhLpkY106
	sWjb/o3ja+JKeNTFwpkasHc2DyMB7OAKe4By1JBakF4QV+n2J6mrjzDdRAdXrsDxYUm7i6MJzQB
	SczOdmxAaYw==
X-Google-Smtp-Source: AGHT+IHaobFhgwK0ONJnsENU/GI2getCTTb5SWhfzHgfWH7B8kIrr5mfFLAfggoiIzIQAjTBpAJzgpLIeSjXMw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP
 id w1-20020a056902100100b00dcc79abe522mr731229ybt.11.1708513178881; Wed, 21
 Feb 2024 02:59:38 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:15 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-14-edumazet@google.com>
Subject: [PATCH net-next 13/13] rtnetlink: provide RCU protection to rtnl_fill_prop_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to be able to run rtnl_fill_ifinfo() under RCU protection
instead of RTNL in the future.

dev->name_node items are already rcu protected.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b91ec216c593aaebf97ea69aa0d2d265ab61c098..59b64febb244b51969651bb37740a799376ad35f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1700,7 +1700,7 @@ static int rtnl_fill_alt_ifnames(struct sk_buff *skb,
 	struct netdev_name_node *name_node;
 	int count = 0;
 
-	list_for_each_entry(name_node, &dev->name_node->list, list) {
+	list_for_each_entry_rcu(name_node, &dev->name_node->list, list) {
 		if (nla_put_string(skb, IFLA_ALT_IFNAME, name_node->name))
 			return -EMSGSIZE;
 		count++;
@@ -1708,6 +1708,7 @@ static int rtnl_fill_alt_ifnames(struct sk_buff *skb,
 	return count;
 }
 
+/* RCU protected. */
 static int rtnl_fill_prop_list(struct sk_buff *skb,
 			       const struct net_device *dev)
 {
@@ -1928,11 +1929,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		goto nla_put_failure_rcu;
 	if (rtnl_fill_link_ifmap(skb, dev))
 		goto nla_put_failure_rcu;
-
-	rcu_read_unlock();
-
 	if (rtnl_fill_prop_list(skb, dev))
-		goto nla_put_failure;
+		goto nla_put_failure_rcu;
+	rcu_read_unlock();
 
 	if (dev->dev.parent &&
 	    nla_put_string(skb, IFLA_PARENT_DEV_NAME,
-- 
2.44.0.rc0.258.g7320e95886-goog


