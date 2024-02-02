Return-Path: <netdev+bounces-68620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77984765C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4811C22A94
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F214AD24;
	Fri,  2 Feb 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFyZzAxC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407514D43C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895621; cv=none; b=FOd0O8xXKgLTnCsgDpm4PpmQs7eZ/EY0QIFEfY7Tu+TCftmYdlPt5YIETErwYxUNg+jaJjMwoDzNIl4lka35QH4yIQOYrYPBA61c/0f2qugyg0UbHC2Nra+0jtqV38njVp1CXFokB+2C5RlrS/++9V74nt0SDRg03BycdO/GFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895621; c=relaxed/simple;
	bh=vieDUHajw9g9bI48TCXDZok68ePYZRrGPwH2sUEDu2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TPdByVBVEx6Q4H9FIYK6FT1t4SSffdb6pMinEc0EVmZIRdOEY3w0kLTU4OIMn7+FpQsYWm9xmx7JKXtKpp81P1+efSLynzIMpfaTUdKT4r/3lMlWkGs0YM2XaUnWx4y6d+IEkokCrJsu7o+Eo3fckY23YS5/5pR3rk4xFNQ7ozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFyZzAxC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6bea4c8b9so3184981276.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895619; x=1707500419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwMkZajDKB3tGfY3+yic7STHRhzWz7YpyyPaMIumdYU=;
        b=cFyZzAxCmxroPfg47M+pywjnP1Y8mhuR7CJx7lfDFrZ/G5OkzntJ1loNEmyZp0JOvK
         0ZDdmWEpVHmhHrUgP38Uzjua/+NDmPvkY2d8/p1RtAuZirPep7OYeWWHfPokMB2DcgJZ
         AQPiVP3y7+NE+WSd503mqJhbgmARAaQaatnJSvpGNIWqnMTaoroD3dROmdAW3XDQigYm
         fRmyhhGOKpbsJrSuQdXfQGCnr+yWivxsL3fGXuKRgj5ZyNh35sR/gJUpw/jjwKr01md9
         qTTxKC/DfFKui7uiJdmVtTpTF8HaYURt1cVCnwcGGCeEhYkSPEut4/RQNn3Qgd1lNFJ5
         6AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895619; x=1707500419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwMkZajDKB3tGfY3+yic7STHRhzWz7YpyyPaMIumdYU=;
        b=dqnR07IfWwzA+B/DtsPbF1A70kqo8eOW1ruUApEW8QyFcYU49rWXp/UzjobISSxY87
         36Qw0EdA5nsuPszffLozwenU/rtDLo82FabtCmL6jEAjYy59IrLWV9yY895qMW5pjD0X
         flYI54CsCjoUjUyL4VAVIYq9ZB7gZLvjcN7klvDSUV+0mLZ2dostqURaTpLlMnNJ2l0P
         0laJPWgXzWaaZsQ09Zs8hpb6XZT0WxigIpAbuLBBa1chYzJQ/mpVXs7aHErwJernCdYm
         UI8GDzPFHDrLrUiXy4L1NL5fufbgHb8Hq1YyZikr3ygEfxpuXv60dthQ5n/OdtzaiZzd
         JulQ==
X-Gm-Message-State: AOJu0YySySoS33gF7qQi0MZKvHJxLtKuEu8NFkc9WsopHHYXjsBHhoIe
	EiatDbM1N0Pgx9vmoTUXBOLy8ELlfQmcc70aGZaiYmhg27coSPTbGe10D71NdfvZ4I9N0Iejx4Z
	jii+JM7/VbQ==
X-Google-Smtp-Source: AGHT+IHKxSy31X8Lf1RcAN1texwFFQ7y48wqMHVpiJKP/GsfSwXWirJhXzxfQEVfHfgGw3rcL0iMxMbz0l/7bA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:108d:b0:dc6:d9eb:6422 with SMTP
 id v13-20020a056902108d00b00dc6d9eb6422mr144081ybu.10.1706895619062; Fri, 02
 Feb 2024 09:40:19 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:53 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/16] ipv4: add __unregister_nexthop_notifier()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
2.43.0.594.gd9cf4e227d-goog


