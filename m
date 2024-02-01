Return-Path: <netdev+bounces-68131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8CB845E2F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5321C27345
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A0E16087F;
	Thu,  1 Feb 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZyuJOgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B677A00
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807399; cv=none; b=JngQULa/PY0T5pSW/+aNo/ckohNkTfzJTOf9qN7QjhNwKBmN8z15zq8AUs2s+d4cpwmqajDmLoEVyEc+D4vKrF8q4tQFcJmhj063UV/TukVgNFPBCwNZgtxDjNkb9i7rzeY7ngEtWI9l2mIjWY4O7k8Bl6AhMI+T6xl9RvM77Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807399; c=relaxed/simple;
	bh=wdRWmYFd/B/sg55mHWO/kT0DC1cVUEGHXYIUf5sUu/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uu4KbGeotoC/FGmDkZkGZAlDWtzSjgY6INOEIiOBNef0lSHaRBULZdFjOnkjdZRARN7VqiEDuHFi/VOIeKHa5Mh8lN3cCIxOxVVlVyCbyRPRh1wUcxsLngdZp08p0BSsbCNk4grrosodXi99QrdjydWyIMaLkq5KqH4OPf3DIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZyuJOgg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604186a5775so14165947b3.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807393; x=1707412193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ibB0EoV+cMOFWJnnctDmwb0Z4jS3sETFpm2A5Ydve0=;
        b=wZyuJOgg5HZNnGB2lT7iA2BXHW8whyN2zpxuZkyjNrsjwLaaoFeEKT2VkATe71G2Oq
         VXqbQOzEovzS/cJDyFsFGPcJiBm4VyAfJlyQylGU89X2h0IPfNomE3KEcOM1pOfeJjte
         9GdKiShs57RUiCV5vn6XMazkQnrk3SHenxqSG+GqBBow0NHxXSB0oKOD42X+XbnQYAxU
         CbLHVRn9xGlD28bPQDVSzoAz5v8c6azGjuLmz1mXVD9J0w4emncUBkDpKvgEsoAVO2CS
         CemGC57iIGteh+MBMPBPyMupEEq4aB57QYP1/+EFz7LyO8Yoft92Z9OQp+GLXnRXOEYS
         NxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807393; x=1707412193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ibB0EoV+cMOFWJnnctDmwb0Z4jS3sETFpm2A5Ydve0=;
        b=BBqBkYk/8YDR3ZN6isuuhoBFCWU6Aq/Yzfx+YTCrfHQFvJeXS5ZVifigF2Os+E6isu
         R7Az61KSyr3vhOx+mbLaFoH++Z38ts8gwE8PU5GrJpIm+qC5UfGASKpDsu3+mq6Ml05O
         drwYOBp5853NlLYPcTz/XGBiUrcXlgfEhb+vP6Xge8UWObpfsAsF/1OLrJsAuFkTf6iy
         AEkmyXtjLkqk9Qjxg0mpsxC5FuannebtHwhn1hYYuRP/UO9yrzn4Mf71j2Gz3JcaJZff
         kZPXzLklMJwBkI+SnTIolILeYGN65ujUF7eQekI5aISlLyzULTkkT6uDkNavZmUL1D6M
         chSA==
X-Gm-Message-State: AOJu0YzGSiK1GJGmfl5QoFkJCG5oYA4KgKtr1EBQdP6IOhcpHMSlnFlC
	Nk5qiedPZ5hsBy/bCeEI9w5q9YqfJGCDG8sUkJXzo5jb8ovgXhO9DuqYpndhlQ2H9f2Y6JlXgnl
	DkwlhDTcuiw==
X-Google-Smtp-Source: AGHT+IFPy3/4ZgaSfoEMN1Nd3CdxfnQ6IY/K/lT0QedPtvIgK6Q1nKrXykrpyNNG5eENmdwYRGaqEqjglpGCNw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ed01:0:b0:602:c1e2:c6f7 with SMTP id
 k1-20020a81ed01000000b00602c1e2c6f7mr1560814ywm.2.1706807393533; Thu, 01 Feb
 2024 09:09:53 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:32 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-12-edumazet@google.com>
Subject: [PATCH net-next 11/16] ip6_tunnel: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_tunnel.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 46c19bd4899011d53b4feb84e25013c01ddce701..fd5217e890ecd4281db03cc6e5ca3ac4394f7e7c 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2267,21 +2267,19 @@ static int __net_init ip6_tnl_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6_tnl_exit_batch_net(struct list_head *net_list)
+static void __net_exit ip6_tnl_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
-		ip6_tnl_destroy_tunnels(net, &list);
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		ip6_tnl_destroy_tunnels(net, dev_to_kill);
 }
 
 static struct pernet_operations ip6_tnl_net_ops = {
 	.init = ip6_tnl_init_net,
-	.exit_batch = ip6_tnl_exit_batch_net,
+	.exit_batch_rtnl = ip6_tnl_exit_batch_rtnl,
 	.id   = &ip6_tnl_net_id,
 	.size = sizeof(struct ip6_tnl_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


