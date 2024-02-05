Return-Path: <netdev+bounces-69133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D673D849B15
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF171F26626
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5932C92;
	Mon,  5 Feb 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2KAMkpj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882334BAB6
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137306; cv=none; b=JTYJBthYJ4N3xwd0YncG08tCUdTYG5/kK6AwrmieG07tSIFaLTD4FvBTgvD5Cjuk9ZFjHtLr/RsPbBWxX5so0wOftwQHBTMh7LTW62qEWhBNgsw1KIvt2G6nB/7tBgCX9Vbo300OiV2Wi8NO/dkEXHuogwOIZTnUqYN3JK5tlqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137306; c=relaxed/simple;
	bh=csHeg8MObnbrWTwmb/ACzdRp8SxPCHEJRSTxWRtqx7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B8SydVyX6V5m3ySIEzSUqfP9eGhj404Sh0NY0U9eEgmeV3nQP4/upElYzdpl3hWmdqmvLI71OEr1Je+LN0ZX5uXR6DawzhTiYr0o2sCiKZDpqGvBnGFY+GGRTA+P58Zcy4mqDtw/p9rlg5wPabnCuyjJ5JqVE+ahDj08A74wra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2KAMkpj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6e6bc4aa3so4125569276.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137303; x=1707742103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXhY5RGHHBmKvUK4ilHdwmmgS7mqz+uPImPGBwwU+Es=;
        b=h2KAMkpjl+PZMP/aFMxj7CLBmGimAnVzhI5QaKetG7RKn55v103T4cN09Gx0rM1GMn
         FvvKYeEVcziW+mBmCfRbTDx/6pRae+339zANzrhJex4KJ6OmfgSIH5nhmn0fAYWuGeZ9
         QYDdnS6TAgglJvCXwHtDETNfU2fzn9LeoGIS6/cIt1aCG3f5uZcRxM8Hk6PUafOCGI4g
         3de6G4QFYEG697Nj6hbjrcndxYocl62iKMEaaW5ktoE74F8neTXhwmAGMdfwWt1eM3xk
         mts18xH2ZbQsBErbthVqZ8pEeSbRMyKeO656QsdjVcXQfl4gD2FmsWkGdQN5LrpB93mu
         iY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137303; x=1707742103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXhY5RGHHBmKvUK4ilHdwmmgS7mqz+uPImPGBwwU+Es=;
        b=BybUWVaGIMjtKuqdUiXwD9JAgZplMM4M4APGZvut7Y9kNbwN2u3YShslbuTLI/sErh
         PH5UVkGLCOodrNzBw5pPekl+TJBBDfi7lnEoy/PhY2Rh9oB2eYj/m8keKhAct+UmAQV4
         3yDMf0o5X5T0XzgZzOctjCrD+T6dF+QOm/YOGVfUYkp5v5KW8sY5j1etJ8Kn0zoEnAyM
         i2icmPz4UuNIhTF3xpQSeiZv72dtvlASmJtDMQP/9G2ABNE6hLP/3CxsoJ/Y9kmt5G7E
         OsPTKENvXng4YB6+vwfvvmdtu6C+qatvCECvENFkWENqybmB8azvIPH6Oum3bk95jxsb
         Sy0A==
X-Gm-Message-State: AOJu0YxazBIllXA34rdX21KwA76zG3zL01DTI2xXtfBiSvxN3OVvVg9P
	eQ4KbQj4cLY0nUA66gVqzmc0gzWB0pT74RrVoro2+fu2XCiJFmXRj/49yZ7/7v7rJiajrAQoMTy
	Oh/GFj0q6yA==
X-Google-Smtp-Source: AGHT+IEQmoArePXLzWWCvHSTYgnLHZ9CwcAagS5U8kV2ITNHvLbo5QDEAEFvusjRi7WzU59+TgKBYyaaIVFpVQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b90:b0:dc6:eb86:c422 with SMTP
 id ei16-20020a0569021b9000b00dc6eb86c422mr360819ybb.5.1707137302921; Mon, 05
 Feb 2024 04:48:22 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:52 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-16-edumazet@google.com>
Subject: [PATCH v3 net-next 15/15] xfrm: interface: use exit_batch_rtnl() method
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
2.43.0.594.gd9cf4e227d-goog


