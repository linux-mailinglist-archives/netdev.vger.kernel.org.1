Return-Path: <netdev+bounces-70602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7284FBAA
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 19:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06BC1C20E06
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB87F48A;
	Fri,  9 Feb 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nY2E4+Lx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F97EF01
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502372; cv=none; b=i1TRLIDwo7ccLwYKdy9wjujk1FRkFt9Cv7FwY3yzwbdSKuvo4PRVTFC17vpjYQeLfnbDoVC29DyZmsh+5D+nIe4HK3hDU3bIOKFtT765+7HhDkV3d9KiH4gCMzjzUbZU9RVR23wwb1Lx/BwlYLgNO+qAYU0uoJvisvswbin+018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502372; c=relaxed/simple;
	bh=y/D7T1Hk8xeL6YNSBEAKHWA1563VOMdwmJGHlVhgdg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FTfxdl3DDznxuMooA2Y1YPgGh0iff773oLm09z9kBIszBReHeXd8lFa2bgSMnQWQ86EJvxGCSn0CKeQdyFTgOdfjb+Q1CwzwxDuPsDiKdvU4zQhH83w7FobnDf6PpQFgx/mZM59RbDvGu96vkc9cjN18+tFUErS0/Ak+GPa1jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nY2E4+Lx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269b172so2980566276.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 10:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707502370; x=1708107170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msmJ/Ga/k+7ofqljyH8JRau4T2QojeKCgUi/MFG/Dkw=;
        b=nY2E4+LxiYpvpoN7y7M1oPYOX3erTYECE5Xxjcrn8RQDpMlnddWmPPQXi4tRwBlx94
         AOxTkuJ5e+je2bIHkz3h4ULk9BciU+wx4HI9MgA6DRBW2xyFu2y9jzubWfWwVS8ag/Jj
         oR457QgCLO2XPkeBUxmDTWtr9Rj9Jq7ylXtbdeUWHzFL4HVkhXkdwW8NRJB7nD9VX+To
         /3tSYi+uUpOrsPCUEsiudMfsaiBhMcmWUUYxB1yVj/adk6PR1Urd2/qviwrL6gScH+BQ
         7AHqzTonVMIztQE4Ga55TiL3zJ5iiM3BjRIuH0qYCtU+wQsI2T3phIBPWMmBb4+SIxol
         wqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707502370; x=1708107170;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msmJ/Ga/k+7ofqljyH8JRau4T2QojeKCgUi/MFG/Dkw=;
        b=YGNxv+O+sS+7buHtA2WTaXFQvs1f+uot52izqViJAxuYcIkfvXKeWcG/tcFgVgv7JK
         tk2j1V1czIifGwagAGFkFTndR9RTDyiGy6/JfgborSjmqH3OxEjdaHijT/ag9mhGq8X7
         3orIH2WoCYnjY1lkO1jmbsdDKy8mQYjbfjZOfmwpsL1t/YygPt3zHQBc25XYpIZ8Trqj
         fdVJhnBQ5KaJti3b0z9zvaUZoKasBqQ+k2jItdMSlWGiRX3Y4kx8ShBZAncptNtW1T+7
         hjBq54p+Dxr4A0nDExnpRnDFoumQdXjs6zp5igCjtSl7RsqN38I1cfzFpbvh9saUy/al
         rhFQ==
X-Gm-Message-State: AOJu0Yw0pdzHoh3mrFP7YYSY3+n0FlrUEFZe8A7Sn3XCCgkSLTGOt0Tk
	lEnObfT797MCyGF0rH9ocVetoo29RTWcNS5Dkr9BMoP9AW3V7j8PfF92R+6Xg2Gj/HaglLE+zUP
	/Q06Fr3uHaQ==
X-Google-Smtp-Source: AGHT+IGJdLuB8BtHgyhxxDVempguntqm+acQNax5cRC663AQwAuGGsTqsuj0bNfHjJFRQeChWGTyE1gaClYW5w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2288:b0:dc6:deca:8122 with SMTP
 id dn8-20020a056902228800b00dc6deca8122mr324914ybb.5.1707502369887; Fri, 09
 Feb 2024 10:12:49 -0800 (PST)
Date: Fri,  9 Feb 2024 18:12:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209181248.96637-1-edumazet@google.com>
Subject: [PATCH net] net: add rcu safety to rtnl_prop_list_size()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

rtnl_prop_list_size() can be called while alternative names
are added or removed concurrently.

if_nlmsg_size() / rtnl_calcit() can indeed be called
without RTNL held.

Use explicit RCU protection to avoid UAF.

Fixes: 88f4fb0c7496 ("net: rtnetlink: put alternative names to getlink message")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 net/core/dev.c       |  2 +-
 net/core/rtnetlink.c | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cb2dab0feee0abe758479a7a001342bf6613df08..75c4ac51302b5b3c3aa7dcc3dcfa31dbcf0c8ac9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -336,7 +336,7 @@ int netdev_name_node_alt_create(struct net_device *dev, const char *name)
 		return -ENOMEM;
 	netdev_name_node_add(net, name_node);
 	/* The node that holds dev->name acts as a head of per-device list. */
-	list_add_tail(&name_node->list, &dev->name_node->list);
+	list_add_tail_rcu(&name_node->list, &dev->name_node->list);
 
 	return 0;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f6f29eb03ec277a1ea17ccc220fa7624bf6db092..9c4f427f3a5057b52ec05405e8b15b8ca2246b4b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1020,14 +1020,17 @@ static size_t rtnl_xdp_size(void)
 static size_t rtnl_prop_list_size(const struct net_device *dev)
 {
 	struct netdev_name_node *name_node;
-	size_t size;
+	unsigned int cnt = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(name_node, &dev->name_node->list, list)
+		cnt++;
+	rcu_read_unlock();
 
-	if (list_empty(&dev->name_node->list))
+	if (!cnt)
 		return 0;
-	size = nla_total_size(0);
-	list_for_each_entry(name_node, &dev->name_node->list, list)
-		size += nla_total_size(ALTIFNAMSIZ);
-	return size;
+
+	return nla_total_size(0) + cnt * nla_total_size(ALTIFNAMSIZ);
 }
 
 static size_t rtnl_proto_down_size(const struct net_device *dev)
-- 
2.43.0.687.g38aa6559b0-goog


