Return-Path: <netdev+bounces-68626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DFE847663
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2ED28D3AF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9EA14E2FD;
	Fri,  2 Feb 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APJFBdWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3F14E2E6
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895629; cv=none; b=T6bN0oMMR4NGvMkoSKUX8+ObRXk5v3FyB2kmSyXTcNNBwj60p2FSENQTNQ9hiDQnVCt0zs0Wra36TGa0EIx1uCQt6/SaLNdTN4KVO8J34VJv7g1pMNFYXRj/rP/aKwdhEI19MoNWnwN4bogGjszfeQ69z4U3fdoBpkEGW5fYqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895629; c=relaxed/simple;
	bh=dCEVgCNsMJ2NjQ+g5ztXuI1Y/3IDivH/bTr3p3ZJ0Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OiKNMsjj9K033aNIrIL4qK4mlT+GT2H++xCqGIyxs9j4KKPfkvtNdxEiJcEq6Zr7bWhEiRfwedvJb21IwxS+3F0OoQFNl5frIbVWMXrDp4nyshDQNYL2+K7MG4+PBoyTdALlZFseGaOFeUZwJiZba9KC542+IB6oHIZfg407I34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APJFBdWu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso3271293276.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895626; x=1707500426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=up2PGM8Lh/PoX2yMsKcFPD+yGGD2E1QRR7UMzVqvJpM=;
        b=APJFBdWuv8Z4mQ9cyFRNVK3/ArYD78JE8EkUp1sQhk5MdVJP0IQK3ojeMXeR6ohnj7
         fwE+ALTUu3yd1HSMcTYlzp2sieyfwDtzvN8sinPyrGrIDHMCCdz5to5NBYSctEVLnjqO
         xeDUmWaVROso9QvVI88WcXFXyscZvDaoRTDa8l96/jMBJIv7VcGnS8GOPqTcHc1KeLW5
         uHW5weiUw27zor7NpK/m7MoKFREs53m7p4XQ4CL9ZqnQgLoReExDRzTllwY9B7uZMv0J
         O8cfVhwLDd/Er6fwOua/vMEWJWftLxkuijT3gyWH0z7h1z7ypGg6iUIIxvPp35SNDFvb
         yD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895626; x=1707500426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up2PGM8Lh/PoX2yMsKcFPD+yGGD2E1QRR7UMzVqvJpM=;
        b=orAFvJ/ur3yrt7ZM3prhpt8L+2vXcClXxG6fuigtQ8JMdRKubMQWSDFgXUqbsTgN1h
         uP3PnE+j5MVaQqQuLp4HZLPYYrQEFvwu7zpSh6HsCvV17tqX7XOnhjufx4nxO143GJNf
         jyMEfgY+a39sWFDprXWDPZU/A6UEy/wc2AOe4Qpl7F0pyiYym1MUSX7lhITXkQ/6mHDm
         3aJX8gcXxL46H78Jef60KijdnKXxdxeqEzBGrqoj5/n75WKNVm7y8DpCtCma+2cD5qXA
         2hmqSjUg1d1DH4K3j7ZMRJaiyLID09Xanw6aQPUflXjvsLgxhIqn58kh5jaLePX/tcUB
         0Ymw==
X-Gm-Message-State: AOJu0YwiYyMXNTizQ3+bCqYAup0/zYpHjBLGoTqx9lfxUjejvvXJkhbn
	T9j5CHcJ7qtJbgMHO/7JpC/KyGa6D2vEnSTPVJqTDYW7RiIoBJ7qmFEqAYwAWnGP5f9G0rNqrAP
	FfdlqjBB7Dw==
X-Google-Smtp-Source: AGHT+IGIpA9HpTHlXKttSFubP22izAVXNSMGrdkvrHQUn8eDJRFRDLgdEtCLoEJxdtadm9zeXqqk5EilkuXTJQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1691:b0:dc2:23db:1bc8 with SMTP
 id bx17-20020a056902169100b00dc223db1bc8mr259396ybb.3.1706895626660; Fri, 02
 Feb 2024 09:40:26 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:58 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/16] sit: use exit_batch_rtnl() method
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
2.43.0.594.gd9cf4e227d-goog


