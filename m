Return-Path: <netdev+bounces-69873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2632084CE22
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594011C22394
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372967FBB0;
	Wed,  7 Feb 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rB/gGe4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21827F7D9
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320118; cv=none; b=AysZvxJzDUFxFTbDfEsHmQWwgSz9HVkzNj75IKMSInKVS5+Nn+UvIYcyqP/4b8lQkkWxSX27j4UVs2zgTYHzGkBgFcRYIOQSk0NmcrHG5eL3ko2QpM9F6f400hpGIsB/4NucpI94JMVXqZzjz2fv4yPXgDEwe2hlyJRXoDpJ8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320118; c=relaxed/simple;
	bh=RSKeVl2zA4rvNzWQXKZQx0WniLj9egwkgT9/HowT2tY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h95DzZ24SWvVMwSOAoOkdGV1rr4V+xTBPyv1ZbJWpzvSuP6dABz2xHsDEY8FtefRjxahHQLHz8/q4U2AosJ7ofcY9Ijs3vi/PAB6vEaQef0ld1AsxrTcM1jVaCF+guo+SXTlj0BNpPC0DECqb32TCApRQt/GVmRSkI7W6NAotHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rB/gGe4q; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso14819007b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 07:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707320115; x=1707924915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqT9eH7Kp02gjkWVxXxVQhfc1r1Sa4J9VcrlelPa/qw=;
        b=rB/gGe4qHY1MkxPywRUhhTvBnVhsxjFZPawmV9gdTBdtY24Zikww7wLBg7jtaV9Hn8
         SLBiGU1ycNUpGwDlki22MjmJ21qY0QCkqtOrERVXyrzbtqjTaoaD1JUqhV+zpgMaBM+7
         /IYwvLiD6uAdGwI0rJjrk4ak36q0Cp3fOgkMkU2ZXAj32NUmuG5lGTAlBUDUrxB6SG1T
         O1i8BnRAIoxrMNaMnhlhCDrzMQvfG830+Kdoqzd4CvRlj3ijLs6Fi71JI8SvuRXGoBti
         eWY9V9ZIyzVDo1B1zqU+7IOmFKCCuef4biuC7Xz5QLEi6QGVrbJ5NkWlmt43VD6d86vR
         Ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320115; x=1707924915;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqT9eH7Kp02gjkWVxXxVQhfc1r1Sa4J9VcrlelPa/qw=;
        b=QvwV7sNC5P7DCjv3ttPhXv/W7UyGtpygoX1sZFuTMsCiOIwBkp/zrqXRtgL1bdV45T
         tTPCAmuU1Rz1TusSAGE3nG7o8PT55fZajQ0nyuP+dXouopVvtlMZJY34GQ0NkQZ16u97
         en0ivDJX1fQ9GztIolQbeybi9Ts3klFNGOr+GVntK2xdphmwmYvxbVeYmJT/Yj+jS4yu
         Ub1n2XnhdcHyaFTDKw0+DYPRWvFNbEB+uhw0Dr3vxNDUY3MvPD/h2777hGTz+SqtE48o
         N+C1Oj4rOOUxVW8KNcPlA2l22U7M/wQTOpymmNrD/7jNv5ASCleg3SUnHQv+Zx3rNVEc
         30RQ==
X-Gm-Message-State: AOJu0YyUDU7I0rQGBNSupgFvrWD1UPUaZsnKh/gmEJnANb+19U/n+odQ
	MJtCtZS903kMgRX1L+lE9ZsfJpVx7eLZFtBeqHhmvXxqEyNtUQb1N4uF88hMcwtUKnsnzsgV9kV
	48o2+4EVfaQ==
X-Google-Smtp-Source: AGHT+IGyWGqawNGQPcfuYMS3i+smPCfR7NeKRYiiAP91xlYQntI0REShQZLJKf/QW3vgY0BH80lCVK1Dfxvpww==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:90:b0:604:4072:57fb with SMTP id
 be16-20020a05690c009000b00604407257fbmr1036439ywb.8.1707320115597; Wed, 07
 Feb 2024 07:35:15 -0800 (PST)
Date: Wed,  7 Feb 2024 15:35:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207153514.3640952-1-edumazet@google.com>
Subject: [PATCH net-next] ethtool: do not use rtnl in ethnl_default_dumpit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

for_each_netdev_dump() can be used with RCU protection,
no need for rtnl if we are going to use dev_hold()/dev_put().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ethtool/netlink.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index fe3553f60bf39e64602d932505a0851e692348a0..bd04f28d5cf4bbe368e0eb64717a4f7438e66924 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -477,11 +477,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 	return ret;
 }
 
-/* Default ->dumpit() handler for GET requests. Device iteration copied from
- * rtnl_dump_ifinfo(); we have to be more careful about device hashtable
- * persistence as we cannot guarantee to hold RTNL lock through the whole
- * function as rtnetnlink does.
- */
+/* Default ->dumpit() handler for GET requests. */
 static int ethnl_default_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
@@ -490,14 +486,14 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 	struct net_device *dev;
 	int ret = 0;
 
-	rtnl_lock();
+	rcu_read_lock();
 	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
 		dev_hold(dev);
-		rtnl_unlock();
+		rcu_read_unlock();
 
 		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
 
-		rtnl_lock();
+		rcu_read_lock();
 		dev_put(dev);
 
 		if (ret < 0 && ret != -EOPNOTSUPP) {
@@ -507,7 +503,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 		}
 		ret = 0;
 	}
-	rtnl_unlock();
+	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.43.0.594.gd9cf4e227d-goog


