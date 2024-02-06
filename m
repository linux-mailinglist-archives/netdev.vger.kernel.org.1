Return-Path: <netdev+bounces-69517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2084B82F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2961C22317
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD76133404;
	Tue,  6 Feb 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHQSFKBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B4133414
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230618; cv=none; b=hBGtqa3l6RGCkt0mV/eeWMvHQAgrc1XKIQtQUdRe/FAlWFTRSb21pt75IbfmFi0vQqGJ7I+53vPAHbCGG6JlHcu23wzd8SGfllYvEV6CEk+4JzRQ6cmViphDv3HKdEQvRtjVeBjCQqAgwjm4vJJ1uHdoPO0MOWAlGEKOi4HAozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230618; c=relaxed/simple;
	bh=TX5hCwIzQ6iIOYIxH9riWojEbYjAMq8DbhBG3Ph6Hdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rfoPHbGZI1Qv/MbRoniCIOVnyi+Yb/Ff9ptze2u9x7ov1laTPGN6enwSrxL8Jnlp4n68TTw+2/C3aWGPpUYJdB9wN73aMyXI1B968UWhqWOo1hY45U6lNNu3jtEMcBh6ZwFaxbq7RAevREXe8Nw3qy7QaX1c8bKPmym8u9S5zVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHQSFKBE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6bad01539so6800005276.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230616; x=1707835416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eAACMb1es+ZkiW+70My1HClW3OzH1OhQoyLTBYbBeg=;
        b=XHQSFKBED9VDauV8w4asfI1YE6OfY2PaE2TNTyBjQt34Wsl8GJIqBxzKuL9UIqK5TG
         u61IKywwuOZ9hYltg3GWh59xPxgTZfToAE+isci3Kro+iB/FNz0gmaMAk6E8nS0stQi/
         WTmfK/qmLtaEQf2iShp2XmI6KCs5uk9F0RMcbHByVBttskNt5vI9PrrETEaI3eDIoRpU
         oR6H0ggNrt2j2XG/h0OOE+sUaCDIo0jLcsd7w+z66TFN+msy2kJ1pc8FGEXz+3hrFSxn
         YPBmCySF6juHULHcBDGjFt/MqTrcLnhptB80BD9RyURfIRo2Ll997bsCm7IKSQQNQ6Cn
         CeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230616; x=1707835416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eAACMb1es+ZkiW+70My1HClW3OzH1OhQoyLTBYbBeg=;
        b=sfvsyhkhCzMFwAyUsP5oDApzulKklVR7FczqpDRX0R0zPBUM0NXofgJ7oh4/VpoiMr
         RMwUsdhJ5wOdDnY0yP9ARYLvdjfuLfbw6SIZ6lFtSLdyqEkSXznvdzy3Dr0ItyXGJNg+
         I3Mo8gCWNw3PwNOi9aOBQsQ/sNIRFSdPqqlVXV8qdFLYLrslrSjgure4274a15mB7Eny
         k70nGMGtWQLaV7NzzB6/qzG6tyXP5M1MwMOpnjoJYkH47l5fyAJMQYv8iS+3TCvW9CV/
         sDDEVCxHL2z7xNTgZmkN0xpmdd48XmQ2dMPxdhSNRKxE1NmOfZsFCruIdqTH2Rz+Bvl/
         8nNw==
X-Gm-Message-State: AOJu0Yza7gsxeWxuo7Bn+dwlaqxqFZNJrqVsNcxPlyBJnyAktHr2UnFl
	/PdshK7Irg5iEe9uT9U7HcL+SxeOji1JHKIwohcYAc9/6dyT4YIibpWes++6mHVQN7c1g/sTgMc
	SwTooQN+q5A==
X-Google-Smtp-Source: AGHT+IFRsMfNM4UNWtIvl5RCZ6WesLqwtA/8CcIuAdGdU1LqI5gO88ecUcJ51QaMLHeVv6lqwelZWXWorzqevA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:118f:b0:dc6:c623:ce6f with SMTP
 id m15-20020a056902118f00b00dc6c623ce6fmr47621ybu.13.1707230616186; Tue, 06
 Feb 2024 06:43:36 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:07 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-12-edumazet@google.com>
Subject: [PATCH v4 net-next 10/15] ip6_tunnel: use exit_batch_rtnl() method
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


