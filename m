Return-Path: <netdev+bounces-68624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B5847660
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA411F28551
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED61114AD2F;
	Fri,  2 Feb 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnVddSBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0A14E2CD
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895626; cv=none; b=WHNvVCQTiizzX1z844/T1ZF7zEa7NBiodMkfaBsZDvwodIU02sofps6EcYKrSoALjH4lg5fOiUcoDBN/VWtie6qNZBjiXjZwdfMYwRfnG2cCucblVNtFO6H5fMMxb4HeXe4U63dl788VERUEWpWXib+w91/3kT+jG4EDoSp25hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895626; c=relaxed/simple;
	bh=TX5hCwIzQ6iIOYIxH9riWojEbYjAMq8DbhBG3Ph6Hdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dFvHoLsATB4Txj+DNDboYtCpqthSm/A+ZwuSINi+fM6PcA3jkJZfFy4dFJcJr3ZIK07yzXf6zXLL9gJ0tOX/aA1g5vmK2DlKP/NxS7ocBbgZEz66tKM3rxXw6tvhh3vAaq809WyhU6Juv1xABv7X1R+sxzner9Ltfv/yncbmbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnVddSBu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso3406160276.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895623; x=1707500423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eAACMb1es+ZkiW+70My1HClW3OzH1OhQoyLTBYbBeg=;
        b=JnVddSBu2rAS8G/z62dXx+ntl/NZ/+ZlmhtxqE3mpFAnZTyt7niCYh4QdXcMtSLDII
         rbGBL+TSkeRjjw/R9bHDucMmycRFwhK9sMEKrMNVpiLADHVFNNev3N604kGW1SaKmZsa
         Vg7E22SsxtBZp0EZLAgF3m5hfeRLnguYgvQTSClHkU7hInZTCESguoAghd1F1lah8qz6
         GsrFtcQK7CKAqt6QBBBhI1/3h6YYbGdTGRpJyfSU5IysoNyU0fefuyVo8it7k7WkzA8H
         As4/pY8HnaH1HfOMQlQ+bnWdIYVPrmsBkE9ZP9Q6uzTIviHgHd8jGMF9yD9sySqVNqV2
         oioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895623; x=1707500423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eAACMb1es+ZkiW+70My1HClW3OzH1OhQoyLTBYbBeg=;
        b=Cp5jeOehfwSzhuWEqIsh9VKOfTjHCPTF5ad6W5gMp4a6mt59PfT1cet2aRhAWk3bX/
         m5JSqtzMyhJxNHhQxzYwu/OLn7dcqVZAd9UNsP0zsUFKEmfsSIl9tT2gaLVhAwVqDIFB
         D572jAroM8v8bkZXcIJ6F/uEO9CPya/1goeFewyieYSVBgaLYrz51auIgDwxC73ZfT8g
         1iTUzcCc/Ei2WUoH/zcgh1uHw7UFg+l+0xmhLJYOIvYvhm6CUzfFEm2bIT3iLVMKE4Hu
         jRbBAPyW017p5p8QgJRT764bT4kmXT3SC2y5Mjwid5RD7BmyMMsW+6OeTWkOir//IUC5
         /pIw==
X-Gm-Message-State: AOJu0YziDI2fD01IPsGZtf76ik5FRRlUWLisnebYaBtI7t5pbPH1jjC1
	UjVa2pB8XukH5Xhn4rHBue8eWQ1Zkr1c7Hz3zSLcTQFgkPnw1ar7Q+ZxQ7zW2Cl6NovGDvUmXX8
	vDt34Cztixw==
X-Google-Smtp-Source: AGHT+IFoqDshzRlrKjrb1KyBBx3n1Vh5xW7qXYhlwl3vjzuZoPG2+R2w/mjVPoA1MiNhwdMy8uhjq34Kb9rZZA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:a91:b0:dc6:e7c9:b7d2 with SMTP
 id cd17-20020a0569020a9100b00dc6e7c9b7d2mr145552ybb.10.1706895623368; Fri, 02
 Feb 2024 09:40:23 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:56 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/16] ip6_tunnel: use exit_batch_rtnl() method
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


