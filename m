Return-Path: <netdev+bounces-68629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26F847666
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75F9B22960
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BED1509A8;
	Fri,  2 Feb 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYMtFjIf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6EB15099F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895634; cv=none; b=MsFjfYQCtvWIfDXbqRG02n5n2xZOCQRmZrAzR7MowMYZ6mtoSG8aErTqSSFOKg7fI9lQVZY5VKMI0bPxf0hAnOg9zmdqyKGpMoObu9Vm/Q2pbRzjPSXyCboLxBz1vKTIHyIlHtDnruxn8FdgPoFVRD4s5Nn1VXUM9IEProZwyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895634; c=relaxed/simple;
	bh=csHeg8MObnbrWTwmb/ACzdRp8SxPCHEJRSTxWRtqx7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lnxvcPiXAfudPZTl09ortWpiGp+G4kn/vJryQChJafvvrc/gNbmlPqupo6vhrKS0t5eYJJ08kqXgzvBvBL0GytrVebuGnQ+TrwxnbUtjj25uCO6CT1xsWoMW6rRPPaQIs70Zaz+0Ay47kRcqfC3kv6eqkdsucrIojx/pItQOX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYMtFjIf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2935260276.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895631; x=1707500431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXhY5RGHHBmKvUK4ilHdwmmgS7mqz+uPImPGBwwU+Es=;
        b=uYMtFjIfDjjerwZXHOj198G35ccWtUU+NFhnwHz4JW16MouyYIT/K8M3HZcfB28r+Q
         KXLCVWR9LFcOyLF+83eD/Fq6klhSADoIrmKbowLLMWIoechfceGrbS4c30FDEZLOAF/q
         tP/aPXd0vyK0LzA69VxA3l9v1lIf9CH5gLs+8sFRFxutkM5/pPdAKSmGUN7q/I8/oenE
         aqXbROR4KVx+XvofXUvJ1YGjXkpRknzmsnUnDLgWy+INUXAdl4TVvHQpSG9tTq+SHy31
         YGrCi1t1528HBb2DiJzkp7sPawbjuX0Gcy2Y/3ul1+lf6LyAu+PLDuxsWohMxj7O6ccN
         +3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895631; x=1707500431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXhY5RGHHBmKvUK4ilHdwmmgS7mqz+uPImPGBwwU+Es=;
        b=gS59x4yRjEkllk0HGFITemV6qdnjuZi1Yzv8WFMcMwHN+WE6OcLDnjiVzWHSBbNsIX
         F4RnblqnllxQn6oeCzvy1c0N7qBJYLRijmozY24PESMPXcrVwCS87PL2EtLvcfyBG92x
         1krZP/nYcmXrgocnpFEAK5RwCM3yYwHYCXWBoA2Ue6rbdfQ+FwMSmYQmTY3boWsfnEfH
         bg2cpxcLNpWK3A6Iiy7aIKVFLFYZqTgBZua+67R8iYoOrbiLrb8PT9Io3CAvkKC/i55b
         0oyfri0AmLm5xw6s6xFREnz+aSoTpCHrGFJxYBSvjCSxLsvqaWAIwttvB6Z7GM8thYlO
         ttnw==
X-Gm-Message-State: AOJu0YyMgxpRD9D8eHFkIJk99rZqcZSTgvN5m6eTWjQgHcJ53ejEkJ7T
	5EyccaGaxPJj4F9ONUxSSqkdJG5dy5zV1cMD/NTbxHgbHuIcipW7FK24cE9RyG+RZ0gxOaLuofM
	N4grqsavbaA==
X-Google-Smtp-Source: AGHT+IEUfBW5ybuZ55Xe9CehdG0l+O/jCLh/VJYaBSZPWGpkxtjGTBv5xTWd99mHtO3VyXQQWc3jZtujBM1XvA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2206:b0:dc2:4921:cc0 with SMTP
 id dm6-20020a056902220600b00dc249210cc0mr208915ybb.5.1706895631804; Fri, 02
 Feb 2024 09:40:31 -0800 (PST)
Date: Fri,  2 Feb 2024 17:40:01 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-17-edumazet@google.com>
Subject: [PATCH v2 net-next 16/16] xfrm: interface: use exit_batch_rtnl() method
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


