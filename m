Return-Path: <netdev+bounces-68127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B82845E2A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D831C26A87
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55C15F33C;
	Thu,  1 Feb 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfwSOO8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314715F311
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807389; cv=none; b=MCe3FUWSBMqH9e/j+feXiUJ1SWGYdSPlKZ4nDRS0JXxJSeZytM7xSBS3WIctftflU4U2G1q/V7lSwHW2rcDg7c2lUL5MIschnUOQGNaxEbcVrwDN4U/VIpaFbHkga3hHjyb8BfYvrzyW4jHOlqkWEPXUFIBAKuHXMHajkeGtfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807389; c=relaxed/simple;
	bh=q1218h7euvV3oNlID7Q2Agln3B9CZaxoKEXSQDTLv00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eqoiky8aZ4k5kd3mEipzMwUnsS8XLcIUsmTIuHMv4dCzASjEWSXTiSgoUx9uEw3VrwhfFirsH9HR7mTa5MCh+Bfd+eio6Rdglw88xsh4+0B4swXFyDyJWxq5gmk6i25PTO/ZQ0zl9r59JhIqXqkXO89xzhghvqx3XP75+aX4yqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfwSOO8q; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6cd00633dso1630077276.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807387; x=1707412187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATE4F9eHahMFf7jX1oK1J3ZVCxFKAqWpa/8L22+/G8A=;
        b=IfwSOO8qhn6T2imBjU2zi/+QLMhHejDSh7x5VgoFvM/OA6tM2S+uuU1iRIiSweZ+wi
         rMhd1/6zOnwNCp9WWiGON0/V4UjhM5MyOojAL9ololPZGiM2xmHSd7B15Iq5pODJZ5qj
         xjWt/HkKuUcgWfVrLYHUEyR5eK+EsBvfPuIGF9cXte/ZKhS9Ipfx6OhcF3y2IWi02Aov
         qRR/9Zg5rV4U13I5wWIX2ANdiwdTVH4gAEeaOoxAq4hohQ3RoJ3trN1d2TN4Ktmxmmsb
         zsMpq+p/nJQyN4qzHjgPeWjJvgcn7lvh20kr+xFScVwm7PKfd5kqMopCV0SRM2NgJURG
         Sn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807387; x=1707412187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATE4F9eHahMFf7jX1oK1J3ZVCxFKAqWpa/8L22+/G8A=;
        b=GcyjyU9U9rgvsuak3/k9RblRPBFdPnORz+cMtqovr//9vi2oe8BF4hP0F6eajLT6Qj
         Nwt9UP2+mnXYsh1y+dADqmsK0Vb+b06UKyBOgml9Pn7LdcHMJiLwJDqNKxH+0GHrO9zY
         JPCSj4u7gSRbHlagFU0Nb1px8hqC4PNyVVGmbxtyVfhba08BPxNp/Nt2qZsXGWK8arjC
         uUWLHHbHXLYiyUtoAk4zSH9TfMqwS643U/eLMyvV+0q6xddFqoULvPVZKyjBvicgg9hX
         jW2iErrmZN6rUqPbltYDW5+KbBo/kARsTgFGxV6agxKVhXDpM8llXyaGXi2+uQf7DlbJ
         ftbg==
X-Gm-Message-State: AOJu0Yz0Q9E8ixu2NfbPpq/vgIVpsv1lqT6OSVlTwyP226Nhk/KljSj8
	sm9bliJ02wlCqfW2r75JWqjHTTLly8nz5gqUXWovIDAfynHNVk8cZQXClhd6RisiLsaPIbkrmjm
	sd3ADrDhxQA==
X-Google-Smtp-Source: AGHT+IGMSRbZ7iy9E7J09+ztp0g904LK2YwCFX8S9FxSdElFRfIWGuZf9H6YnSxnyVzEVfkSb8X6wLOoc6EXNA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:248c:b0:dc2:3619:e94e with SMTP
 id ds12-20020a056902248c00b00dc23619e94emr167243ybb.6.1706807387017; Thu, 01
 Feb 2024 09:09:47 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:27 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-7-edumazet@google.com>
Subject: [PATCH net-next 06/16] geneve: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 32c51c244153bd760b9f58001906c04c8b0f37ff..f31fc52ef397dfe0eba854385f783fbcad7e870f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1900,18 +1900,13 @@ static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
 	}
 }
 
-static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
+static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
-		geneve_destroy_tunnels(net, &list);
-
-	/* unregister the devices gathered above */
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		geneve_destroy_tunnels(net, dev_to_kill);
 
 	list_for_each_entry(net, net_list, exit_list) {
 		const struct geneve_net *gn = net_generic(net, geneve_net_id);
@@ -1922,7 +1917,7 @@ static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
 
 static struct pernet_operations geneve_net_ops = {
 	.init = geneve_init_net,
-	.exit_batch = geneve_exit_batch_net,
+	.exit_batch_rtnl = geneve_exit_batch_rtnl,
 	.id   = &geneve_net_id,
 	.size = sizeof(struct geneve_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


