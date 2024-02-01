Return-Path: <netdev+bounces-68137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A7845E38
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B258BB28450
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C2161B5B;
	Thu,  1 Feb 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O350cbXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B1161B63
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807404; cv=none; b=iX4b85ZBcGiBUAYEqzqy+QBdqayJUxxbtR9nS1EECVUH+/30zHAkN4ewsKZL0dU1Ue0LVDFdOf39D22C4LZBqfCcr0WimSsbAzbClJVO+2C4KBX1i45bfM41KOeTmRBXjutjXN7cy47DZYFhqOeJopTMEbbLfaJR2ZPWl6X4Q3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807404; c=relaxed/simple;
	bh=tIuUHEiTAyNoogXhr1fPfKvWp3GOsNFmlGQo6c4DLcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B8Y2GQcm7S4qZ0+vaQXAqTTIQLyE6uX1qfEI8R6I/PsL1KICA9ttUcxeJKiz12Zlo75koBfsfwcWRtiyoA8XA5XSfhFRFVWNHqH5I6Bo+WdpBUyC2wHh1tGsfK3hJAKRPKwLRBX6+Moj3bgX9Uv/uH+siTcrmcmKcN3Jl0HJ79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O350cbXh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ba5fdf1aso1580441276.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807402; x=1707412202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYHPXhTKrhLq5KSpWdX/0gb12Fsu7f5tuc69AnEURmI=;
        b=O350cbXh56CFPUaGVHyMNc3pj2S15o+bMuyWJytz6Ku9qkLFs7Hh6tBFqvzTJ4xip6
         szBPVN0OrZkgih3OCuQrctsLWbyryU93ybBLuvaRfBaws3JxWgeShFZa8OemCh64pazC
         hRNZJxDhlLShhLCjEcneQX9pVDw69UY4PfYqEEEvAn6HpzImwKT1QI1JxSxi/c8mkF6V
         tJFA51jEeECo8X2CvemLtcd1uieUGpcSVgCXpaDPZ2vQTEicB2Wam7yTY82cFqI1Gr0u
         k3muDLmFhoGbEIWHA56kLeAHMTwB+Pj/b+ENyzDVPOZXRWLGZTIi3wdAA2GmzBmX7733
         Pt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807402; x=1707412202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYHPXhTKrhLq5KSpWdX/0gb12Fsu7f5tuc69AnEURmI=;
        b=FBjzA61xyTXsavj4A2IlGzVNXY9iCWHjtX3m/s32MTNDYXVJfTgu7IBJwZa4YL+I0e
         NeenhRrlzF12P5O+LYr/i7pptWX9ZkQM0BW2Wuh3o4amWJ+1BfScveFf6jPeGh9THm4s
         k8aynSfio2MTFxms7eaQP1Vo9tz/sm8XsZYHdB9u4TUmUBWeqH3bj8f8WONbGt0rbicx
         NKRVc1mjmyupcU3xE+V8JLf89hU8QjwPlxEHM6ADHPUXqAXZVTnmeLnUsmcwPyPjC8fI
         kqiXReD7KONqrHlf19OdF4sYMVxuHx3NlpV5iAOdk5dW0kiM3GQwDHejODfnYxwPeFHO
         mkgQ==
X-Gm-Message-State: AOJu0YxtyJNaaDlIRd2TecAq0NcdhGPNrwNGuobYMrM73xE1eV2JMn5L
	vEGXbTBSDwWDSy9sx3ocVq9yHIZkQ3EwR1BRPfZJDlpX5eLHXQubR/OARDVC9532QNKYHtX9KAG
	YxrlnX2jVdQ==
X-Google-Smtp-Source: AGHT+IHIzKVQkUClFuD/rDCLjIQW8AK3j+JeSkzVkeoNikvjRS/4fto9Kkhf10IutEsEK4a/ZULGUBNCFCHhLg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2602:b0:dc2:3426:c9ee with SMTP
 id dw2-20020a056902260200b00dc23426c9eemr192334ybb.11.1706807401889; Thu, 01
 Feb 2024 09:10:01 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:37 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-17-edumazet@google.com>
Subject: [PATCH net-next 16/16] xfrm: interface: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/xfrm/xfrm_interface_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 21d50d75c26088063538d9b9da5cba93db181a1f..dafefef3cf51a79fd6701a8b78c3f8fcfd10615d 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -957,12 +957,12 @@ static struct rtnl_link_ops xfrmi_link_ops __read_mostly = {
 	.get_link_net	= xfrmi_get_link_net,
 };
 
-static void __net_exit xfrmi_exit_batch_net(struct list_head *net_exit_list)
+static void __net_exit xfrmi_exit_batch_rtnl(struct list_head *net_exit_list,
+					     struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_exit_list, exit_list) {
 		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 		struct xfrm_if __rcu **xip;
@@ -973,18 +973,16 @@ static void __net_exit xfrmi_exit_batch_net(struct list_head *net_exit_list)
 			for (xip = &xfrmn->xfrmi[i];
 			     (xi = rtnl_dereference(*xip)) != NULL;
 			     xip = &xi->next)
-				unregister_netdevice_queue(xi->dev, &list);
+				unregister_netdevice_queue(xi->dev, dev_to_kill);
 		}
 		xi = rtnl_dereference(xfrmn->collect_md_xfrmi);
 		if (xi)
-			unregister_netdevice_queue(xi->dev, &list);
+			unregister_netdevice_queue(xi->dev, dev_to_kill);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations xfrmi_net_ops = {
-	.exit_batch = xfrmi_exit_batch_net,
+	.exit_batch_rtnl = xfrmi_exit_batch_rtnl,
 	.id   = &xfrmi_net_id,
 	.size = sizeof(struct xfrmi_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


