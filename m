Return-Path: <netdev+bounces-68617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB18847659
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE421C21A0E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB114C59E;
	Fri,  2 Feb 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="099wIuT0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92414C596
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895615; cv=none; b=Wbm0QNq8kV+vCzp3Zj0oBdTdks1o/ExOcG9FpxXN4hrUGb9ajX5A1+1DkaFTqqBk4MMFIMlyEe1ni8any1e0j6srL9mSiOBAhbwNsK3d5ZPfcQGMOqeHEWmY0vK5VQ7xPIdbkTlaj+7C/gBjfGDKLcfq0xp+m1KEWFOY8ugp/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895615; c=relaxed/simple;
	bh=ayxOrI72K6/MWZME44DpehPtpq+P0Zcwx9RlGIOMnUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yh56E9Yp0GWB/UVyv0gOMorPCGHU6+0VOVHfFIf3KLPZu7UE9vvr3H2zHHhZgGRwUNmdJDhb3aa9Zgm2LmUv4piKVEw5mIumRmoCF7+fsTqisx5/yAZ1tGBJFEYhuUvDJb7/7wDSgRAghqSSmzf/5p8j+VoLH7Cj6Rvr8wfa4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=099wIuT0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6042d3a67f8so14706897b3.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895613; x=1707500413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BFeVsJGz6LUPJVJRWx6DWARi15RK/k8eAVyBBsCykA=;
        b=099wIuT0SQtMQDaP+4Hgj95BqUG/8lVF1QuhawckzonZRwA79g8ba0yMevMbuUSrVz
         AC+bhKnRr0ML7dKXs3TBsoHwMV/+V1RE9s0osgyOq3WCW1mc6oVLXDGy55XREK1sdX3y
         IhRDgY2pRopVZRsxBQrqgWiLQXMTZPdT7Oj/nydrXV3MC4lnpFO+wasWpil2LMnu5aYj
         6TrEuH51EJmMazIlQhxm5dY7h9Ft7tmdZPCvXGVyid5kI6bNRRyrjulSnUseabiy00EJ
         IJoUrs3B/TCbbD7AckoF8hILvvbJnzj+QvM/khkqBtoJxrHcPtlYI6fjEIcICW4pmKqB
         CzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895613; x=1707500413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BFeVsJGz6LUPJVJRWx6DWARi15RK/k8eAVyBBsCykA=;
        b=tiU3kRJlblm+badK7cMBuw2a74D0ZLmCzftNA6/4HIJVFCZqgTKO0kM9V7Xz5eYfgR
         rmEfL5GAyevmy6EUgi6EsRGzZgkmn/NlML58CdDk1NjIilp4A+gAVNZf7DS372nQteNF
         d3F14sJMZi9b2GMBkEv1kcmbiSeIKBORh75D/G1wR6hkcKOxvJfsF7ag1fotXmFjj6zq
         au9GBRM4DMijESfm8wTCPZjwFhX/r3nrLyS6Mzdz23yVCIioF+oyaDRYvoZ7KnaIdyLA
         eJwXZvbH75kh7qzx258EAwkgBBcr61gGVhFSdRLEjMWx4BqjZ15xc8D7O2Bx2iRwMDqH
         nKUw==
X-Gm-Message-State: AOJu0YxSjHs/l6Xuj4VClT78J33N/b7oXlLkvpuzG/t3qcb7MSuZkeOO
	dpGE95R0uh/ak2lwemqPSKqyZugMyJ4Fwg+VHF/h0DPbTUxuymt99W9o8+M8splU/fmI3zfMhck
	yO1pb/r/ofw==
X-Google-Smtp-Source: AGHT+IH6qi7voch6Ob0DOxPDZB59JcoEV12ozQDCtq7Lh1530ZOsDTUzMscWmnRoo8TuaCKzrFkLQmD+vG0rOg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2303:b0:dc2:2d2c:962a with SMTP
 id do3-20020a056902230300b00dc22d2c962amr2149246ybb.8.1706895613305; Fri, 02
 Feb 2024 09:40:13 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:49 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/16] bareudp: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bareudp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 31377bb1cc97cba08e02dc7d48761068627af3fb..4db6122c9b43032a36b98916bb4390e3d6f08f68 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -760,23 +760,18 @@ static void bareudp_destroy_tunnels(struct net *net, struct list_head *head)
 		unregister_netdevice_queue(bareudp->dev, head);
 }
 
-static void __net_exit bareudp_exit_batch_net(struct list_head *net_list)
+static void __net_exit bareudp_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_kill_list)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
-		bareudp_destroy_tunnels(net, &list);
-
-	/* unregister the devices gathered above */
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		bareudp_destroy_tunnels(net, dev_kill_list);
 }
 
 static struct pernet_operations bareudp_net_ops = {
 	.init = bareudp_init_net,
-	.exit_batch = bareudp_exit_batch_net,
+	.exit_batch_rtnl = bareudp_exit_batch_rtnl,
 	.id   = &bareudp_net_id,
 	.size = sizeof(struct bareudp_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


