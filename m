Return-Path: <netdev+bounces-69126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D095849B09
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64E31F26203
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455B487A3;
	Mon,  5 Feb 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPik5m55"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4348787
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137293; cv=none; b=OMEN3M6UN+/JDvKjxZW1+hYJqKdnvrFkLaZ93d6h6i99dnyJ/+iWq7qwG5frVF/RhlnrI7KBZkhQPCAG/FhUyUEQTf4ziDtNiI/zUPreSFEaEcPL9cJZ+7WJASbJZ3SNsu2bpZTcs36t0wX3GkUrwlgkz0Te+r5MmepYD+VgQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137293; c=relaxed/simple;
	bh=3kdCeRYsyI0ajFHIAb5IAbcYoMO+hdbkYa02jDl5grY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FBD6eThelGiYP40z2tn0EZfnehrabrEYzamWC//d/uONNdru5wvCjUjocqENRA7dxTFUbi999imotI9ABBo9whUX91K1gGOr6kyPmHvkHHtU6Lwg0aPBT1WFoi+AocsuANekdx64jDmvZfw5IRXBcMWcIkO9acHgHr5zd6+ezaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPik5m55; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041bb56dbfso59685697b3.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137291; x=1707742091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3crcVTsghXsSywbMFzI5MYM02CM47kPTeW36cEIF42M=;
        b=KPik5m55mbkduuaG7jY1nnbic0Ah0GIcwHm3Dcztkeur3UHlzTpmWY/3lNnJXHOk9w
         2iLrhMW0hCamZI3v4LHnq6nZd044mT0uiI8+2GIR/bkL3PJIzEWTgptr8ZUUQlAqWT4k
         GRuetnYPavLT3JaC0RL8q7tkCEoLmQScmxrmQ5IA8bbluG1K9/0FtcrmGQrbr80wAQN2
         7Z7aB6g1n4ycgnRL7aYQWe0Mxrm32hqJV2/HN4nihNFqSpDP1mJX+jVZYIi0jyRCtMvz
         JvFwLRrWOK8YFaOWg35Fwt4TcXuA6xR0zf6oYvCPwTK8sPSfEezGJIIc792tibmvpnxC
         DvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137291; x=1707742091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3crcVTsghXsSywbMFzI5MYM02CM47kPTeW36cEIF42M=;
        b=sJjtIOLzsIFvDH5WP6IOaAn422ZWsXrJB816je3Bshj3we0VKiCcXYqPW2TOz7f2kw
         v5Hb+w3H5KcE5eZTUaSOI9sh5lxdrLczr8kzf64lqzHtdZB7U0y/846qM6nHEyHG0Duq
         36PYksUt7BC3vT+mie/eiETzQLi22bM2WpKB/zjj/i3n6AIaLucXGgZRLT0RfuTOBeNI
         Gk2FdVauLf4tpcTFLkuUo/cuvfjB2JwfSICo7z1E24vR3x8i+oOKTa1r+SH4NA+fTMb+
         m+tX1LuaUEHLGnyF7e+bl1lkLzC/a7h/qnSzmDJiSzIfuwhipwIcofDtugdpn5R55jC9
         fg9Q==
X-Gm-Message-State: AOJu0YxaSOf+S2BTnmFzH/NjEY/kT92IwhHFwqoIE8HXhjcxdw5EHGsz
	Y1Q8yNK7cyInRJ+F+R3/wJHc220HC9gLME2wyK+vi0RIPbV7XKbm5d8wjAI3WWF20WcKvP247aP
	YXgwn55nwbA==
X-Google-Smtp-Source: AGHT+IEkAC9OjmPv1Msim+MK+1NZ8kxzzWJFVeodraGfax5XdVWY28yC3oLsh1dHMDkreDrOH1aO8kRSXsZ6iw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:f8d:b0:5ff:b07b:fb83 with SMTP
 id df13-20020a05690c0f8d00b005ffb07bfb83mr2257419ywb.4.1707137291387; Mon, 05
 Feb 2024 04:48:11 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:45 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-9-edumazet@google.com>
Subject: [PATCH v3 net-next 08/15] vxlan: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 16106e088c6301d3aaa47dd73985107945735b6e..df664de4b2b6cc361363b804e7ad531d59e2cdfa 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4846,23 +4846,25 @@ static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
 
 }
 
-static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+static void __net_exit vxlan_exit_batch_rtnl(struct list_head *net_list,
+					     struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
-	unsigned int h;
 
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 
-		unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+		__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+
+		vxlan_destroy_tunnels(net, dev_to_kill);
 	}
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		vxlan_destroy_tunnels(net, &list);
+}
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+{
+	struct net *net;
+	unsigned int h;
 
 	list_for_each_entry(net, net_list, exit_list) {
 		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
@@ -4875,6 +4877,7 @@ static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
 static struct pernet_operations vxlan_net_ops = {
 	.init = vxlan_init_net,
 	.exit_batch = vxlan_exit_batch_net,
+	.exit_batch_rtnl = vxlan_exit_batch_rtnl,
 	.id   = &vxlan_net_id,
 	.size = sizeof(struct vxlan_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


