Return-Path: <netdev+bounces-69120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5525849AFF
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B1A1C22232
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989252C859;
	Mon,  5 Feb 2024 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfcAd1gs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3072C6AD
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137285; cv=none; b=ACIIiIF52BUncZR0MwrBb/5lxmEtGuJx5R4YBhlC54qEgzcT67nqI+XarpeR+vClSlQHBzomC4JGE7RDgNBUfZqSvrguGoG07rPslaDIeKt1tTYLzt67OZVV6pRTkbBAo/TMYQ53arP47035ViyoGuv0WXomMDNToAubDR5XysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137285; c=relaxed/simple;
	bh=vPm6pRfPkizcwo9J6YgQaA07StlJsDdt+GI12hUd+jg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z/+oajGSl+vG73z8R+fgH6jK/EVnxLdScz42kTxUY3qDGEsNpqfVWPnhEwzRegcZeqqtbWgIkzCmXxwakYKYzCPeKg0PLjfUqIzDOwGr/Y9pi6DBzgL8L0h1b4wY6VNSXgdaR6QrM0nZaT/piA+UsuME4AdHfWO3tnx/PuFXAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zfcAd1gs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso7046858276.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137283; x=1707742083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fia+sb8RWUNVXU3q1v1Z4jGJuuRjbjpwW2R8X5o5BY=;
        b=zfcAd1gsehXYoE8dOVETmCk+4y/oDhzAcp1+xgrf3gvDeL8cfJ7Xvwjs9uK7LpLuJF
         vX9ipiQaLK4YLMAWopuovR7OXw0QLKNd0R//ScDDPaSsXNZZgWhqk+hTcx/2iU0+59au
         jeoYTO1sm+QYKwzYrpyaEF9xjlm+jjQEEV3/37yqDiCBmgakdWecQE9Xdtys2A1cvu3c
         +7LqJwEa5GrKrHvkTkG+uKGH1/K+aBneMYSijzQLPv5kzzAZ41PrQa2RuInzR/btjeEn
         5Gp9GLbLGSz7ZeEi6FhUQuKOIfKSLeXDHbp7anro7oVcDvdKteA3w8oO0jfYWfFbovSZ
         zPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137283; x=1707742083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fia+sb8RWUNVXU3q1v1Z4jGJuuRjbjpwW2R8X5o5BY=;
        b=jp3tob7D4epXl1iTTlcc+3B71RpicbxbC2bWgQPKAK6CEWuZGc/DsjNftWx71VHg3X
         ugQlPzzDfO5VIu1A0xzlTfe3YveSU6M/+F+fGreuqefRs3Q0M/ELtYx4Mhy1pOO0tDCN
         pQWSzAfc5iwT4o1yO5sSghYJhBd98IjYCNspoGnlq+iB7QAsgTfikJZQ4Qjy87RVfyNp
         ZKhGhyxe/oOGwilO4Ch6+o3GWe+LuizJpJz+CrKqFZ1RXjHQFf8mXjTc40X/NXTpXDtE
         oBsarVgg58//nDWSQWGI7lpkrupmkzb6RMgRgtiDXSEoVPfw4/wTTZI+ion2SUdgwZRF
         K0iQ==
X-Gm-Message-State: AOJu0YwFfFwRk5igY+fXGSV1gPXnJnmD350pEYKTaPzvxczYkDk3+Q6g
	hF6NVrynq7nt0J+zpFCiJZDBAGUGh2jTbONejo2np7lSqWBkDgwp2X5Z24eVfbyAaMC1f5OFC8z
	sbtzTJbvaNA==
X-Google-Smtp-Source: AGHT+IE9i2I2w0zxwswndjSqncI0GDyUaR3QwVPEHdhDmkp8ydOCKucvQR+qu/iAewovGQ3WH0MEdjmfmSd4fw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:dc9:b0:dbe:d0a9:2be3 with SMTP
 id de9-20020a0569020dc900b00dbed0a92be3mr1853568ybb.3.1707137282995; Mon, 05
 Feb 2024 04:48:02 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:39 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-3-edumazet@google.com>
Subject: [PATCH v3 net-next 02/15] nexthop: convert nexthop_net_exit_batch to
 exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held.

This saves one rtnl_lock()/rtnl_unlock() pair.

We also need to create nexthop_net_exit()
to make sure net->nexthop.devhash is not freed too soon,
otherwise we will not be able to unregister netdev
from exit_batch_rtnl() methods.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/nexthop.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bbff68b5b5d4a1d835c9785fbe84f4cab32a1db0..7270a8631406c508eebf85c42eb29a5268d7d7cf 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3737,16 +3737,20 @@ void nexthop_res_grp_activity_update(struct net *net, u32 id, u16 num_buckets,
 }
 EXPORT_SYMBOL(nexthop_res_grp_activity_update);
 
-static void __net_exit nexthop_net_exit_batch(struct list_head *net_list)
+static void __net_exit nexthop_net_exit_batch_rtnl(struct list_head *net_list,
+						   struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
+	ASSERT_RTNL();
+	list_for_each_entry(net, net_list, exit_list)
 		flush_all_nexthops(net);
-		kfree(net->nexthop.devhash);
-	}
-	rtnl_unlock();
+}
+
+static void __net_exit nexthop_net_exit(struct net *net)
+{
+	kfree(net->nexthop.devhash);
+	net->nexthop.devhash = NULL;
 }
 
 static int __net_init nexthop_net_init(struct net *net)
@@ -3764,7 +3768,8 @@ static int __net_init nexthop_net_init(struct net *net)
 
 static struct pernet_operations nexthop_net_ops = {
 	.init = nexthop_net_init,
-	.exit_batch = nexthop_net_exit_batch,
+	.exit = nexthop_net_exit,
+	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
 };
 
 static int __init nexthop_init(void)
-- 
2.43.0.594.gd9cf4e227d-goog


