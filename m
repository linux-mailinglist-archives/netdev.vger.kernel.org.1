Return-Path: <netdev+bounces-69128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E8849B0B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC6E1F263A3
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B6548CD2;
	Mon,  5 Feb 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSRsJ+8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43B48CC5
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137296; cv=none; b=bmSBxbcLaDF81gMq5bO+8XrOdqA9eaTyJelbVG7czeNc8SJsheHxG8UDzp2m6LKaql/rU6aLrlGVK+aSzIJ/ekd56M2yYCxp+Ekjtz594q2MfVk32aaDQ44qL4pmSsTIlCnhmymmy5lY2H7ZQl5Sav7D5bmOq3QnMKC1yglfGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137296; c=relaxed/simple;
	bh=TX5hCwIzQ6iIOYIxH9riWojEbYjAMq8DbhBG3Ph6Hdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9mlHWCkePduq3o0nu9BN5wzxKT0h4Z4Pd0rcuj4d6yJwmwlYBGb5eRH+Jd4npmQ2Qjcp8/D5DypUG3WDPPOVQpZyTqwkTPWGv8zWwSQOfoOXBm6qMy04iOJ5J5qcvhBTIfktuWmBd5syhXOC0eZSeHpV4GSEK8XCy5nABk57/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cSRsJ+8B; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc7165d7ca3so796789276.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137294; x=1707742094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eAACMb1es+ZkiW+70My1HClW3OzH1OhQoyLTBYbBeg=;
        b=cSRsJ+8BjNcqxXcwk8yKxVfdXBWZnUAWUWrAKx1uardaXKwu4cWDXZvd1Lkw2RjPKa
         R3cHLsY1qmv1fyiNtGcVVSNnHdytiDvX8wEwprvveAAQ266fK5XKJ3PEhbzJRMiPot1S
         S/F9PDct6h8alLv2TdIUt4NERly4ma/qzIJBVR/EbpupQfItLz3jhfE4bgHjsNm0FN3r
         XQ1NvW13Xzto4FBGQIhlAtV81oJOFpF1QnBb0OAZrqEzM+slbxH3WgL3KLGL6aGfvh+9
         0V0zfOKQg96VZrNv6nvP9eQAW5A015jSFOP0nnY0CXmHm4E5DI2dF2JHkx6SdV4YchQW
         V7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137294; x=1707742094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eAACMb1es+ZkiW+70My1HClW3OzH1OhQoyLTBYbBeg=;
        b=T+scUixv0Nsm9lq0kaf9o0oxXjx7hQNAwOEGelJUR+iQaUE52dt5pk+Ddsxo0h5alO
         hvdGWt9E8HUdUrg0WjUoTVD2oQzPok9tvZg/hepb45Wac5F7IImH0UTlp6jDWvoFBim1
         i3cu45Uwl8DvUyIGdcUkPwl8J7vDA2wlcmyGIQxwIlUfiLRjR4lj8CeZlw/QpMLQi3GL
         TmNn4WCzjR9ChTlx7c+iloFmSs3LFyqzA5jps3h69ktA++vD84oAFRiZoAhY9p5JiEmK
         +Hb3YhhbaU0pjWfbJBpH9C5UvUi4Kzh62trCpwe59K47khXZnYxY81At4D0u7W/1gv67
         XzBA==
X-Gm-Message-State: AOJu0YwgnVBsMuaVFwIrl5Qlpdm/wmLmuBm0eOVMaG/t7h5hR1I/cs6m
	oKpOA9sJE5EWYJCWjFDIGqRf58KfOh8LoMFhCfxEKzlRoOCeoOzB9pqzWyxdYaVU4Dvm90nezyL
	gYoPeKEM2hw==
X-Google-Smtp-Source: AGHT+IG1BbRp7rHfAWt++3/WQBGa6Jw1kUp1C0pZlRKucTnbaFagxbzstBELhI1SR69q0Dg4rAvLLdvG8Z1bjA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2384:b0:dc6:9f32:59ae with SMTP
 id dp4-20020a056902238400b00dc69f3259aemr543355ybb.12.1707137294259; Mon, 05
 Feb 2024 04:48:14 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:47 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-11-edumazet@google.com>
Subject: [PATCH v3 net-next 10/15] ip6_tunnel: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
index 9bbabf750a21e251d4e8f9e3059c707505f5ce32..bfb0a6c601c119cc38901998c47d0c98be047d90 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2282,21 +2282,19 @@ static int __net_init ip6_tnl_init_net(struct net *net)
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
2.43.0.594.gd9cf4e227d-goog


