Return-Path: <netdev+bounces-68135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3D6845E35
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF591C28F94
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6591161B5C;
	Thu,  1 Feb 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yt63Tc5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3315A486
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807402; cv=none; b=jfQQLvHsYMTrofIBWEYQkW9CY87rOykAnOvK8m22q5bzyIDdVFeYI0G3bBsaLsJBrELx14Xjfsw97mJ0MCu8WFKouNb7d2nK64gcptgmSqz4zn/eq7kFsWbqqHzy22HWlxxZKvkWjqZxbc8o9yxY7Jye/4RuNjEo8j5u/hEyzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807402; c=relaxed/simple;
	bh=X7sSqGkp3yUZ+StfoztG2Rkj2cplEOY2gXyiFaBQs9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U8l5fvUH3zARaFhsc7aYO7a5n3+LRBnbI+QRy2a3YrmgIW47KGo/M+IYgIDsQiAzZnt5jE6OEFBiX5MmyA3zbcFLqsgUS8GYjGBfB94BkeamU69AQ6swX+YI8POaUBl9rG6bjGWH/VLFZaxfCxS2JfDJTvKViD2pNpUIB8q9pnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yt63Tc5M; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so1596797276.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807397; x=1707412197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mq5GottCqbKF6YINfxq0mHy5tSoPsLAfqPz7IIKtkrM=;
        b=yt63Tc5MXgkRFdQS/dW6tzehkGOYO/23QapXj4m54/yfT3yWi6QYulmhVHnzvwLoig
         bLQ1B9ZNJzUTy1UpxHv9ywkRMgPv2kylg8Av5EN7+Evz8srX0T9zDR3yGz01HOqqICxR
         rE4ON9rKoinnfuX3tuLbzGur5sirU+Xaalw4RIYUGywh41w6Cvqxc+iS3Dzu1+u3rB9Z
         TnyYXrTHygZhxo3bifmNhwg+n4NqoNQXPIgJwloT+5rZ+704Lguoh0Tv0BFbPRoiIcqg
         fepZzj58U3cjW81TidbMRo/eFuts8RhLq8MH/uadWDwXYWGOQHTU1Si2JJHWtIbMcxkR
         wiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807397; x=1707412197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq5GottCqbKF6YINfxq0mHy5tSoPsLAfqPz7IIKtkrM=;
        b=XY7eHQDnkQuSKVTm3Qu/YPINY7mrHBEPs9zS7SCjFI0hRwniYZhDBwLP9CRuXQLfJ9
         RxXuSaPPRXqUqvnrtegKy+Ua7ZH4QN5Zjht50jIKifW/1My+t+PAeBJ6AbMIYP6A+xwH
         IUeNf7MD/ACu0dWuiW0SRGtG0BwCaKWnE4lPFRFowQ7IWOChfD7YCEfRld8pAUwRzt+h
         qHwpbKILZIYxJzzcCtHeHAGlbQesLToezgztGKI9cq58C+pDV3Fq557eI9Mf/KIqG8Ym
         Q8Hh1yYN7q0uRXMndcR/I4+72PT8BzjCcPAr1+FGK/PceCf2EDaUO1hCBh0w+da3ZLTy
         l86g==
X-Gm-Message-State: AOJu0Yz4+afkkUX8lDbTIyol1eMt2jdxvdWfpMJV3SE9ariGWf9Nj3RD
	Gp39r6/hacMijlpJ0XhWPsGuDsP19ueyQHyw3Wiox6PBDIpDuXwaI7MD/GF7uA+3115FiPmhrdX
	e3VRBOUOiYQ==
X-Google-Smtp-Source: AGHT+IEXCz4cGDQioB9JJpQmbKopHn/ajuA/o+pP2NgHp1BT2FwTVxEsrbWAAB6xGdqrI0InAX1W+A5le02Nlg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:db82:0:b0:dc6:d890:1a97 with SMTP id
 g124-20020a25db82000000b00dc6d8901a97mr71116ybf.9.1706807396820; Thu, 01 Feb
 2024 09:09:56 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:34 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-14-edumazet@google.com>
Subject: [PATCH net-next 13/16] sit: use exit_batch_rtnl() method
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
 net/ipv6/sit.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cc24cefdb85c0944c03c019b1c4214302d18e2c8..61b2b71fa8bedea6d185348ff781356652434b33 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1875,22 +1875,19 @@ static int __net_init sit_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit sit_exit_batch_net(struct list_head *net_list)
+static void __net_exit sit_exit_batch_rtnl(struct list_head *net_list,
+					   struct list_head *dev_to_kill)
 {
-	LIST_HEAD(list);
 	struct net *net;
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
-		sit_destroy_tunnels(net, &list);
-
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		sit_destroy_tunnels(net, dev_to_kill);
 }
 
 static struct pernet_operations sit_net_ops = {
 	.init = sit_init_net,
-	.exit_batch = sit_exit_batch_net,
+	.exit_batch_rtnl = sit_exit_batch_rtnl,
 	.id   = &sit_net_id,
 	.size = sizeof(struct sit_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


