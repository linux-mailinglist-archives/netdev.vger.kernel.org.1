Return-Path: <netdev+bounces-69522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B365884B836
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B108282EC7
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D42132C26;
	Tue,  6 Feb 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXXorrOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355E132C25
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230626; cv=none; b=ELYskP7pfMYyxq9fpTabL0iLV3h9wmK/TklRntylkWhIKf+hUcLuUM+SPjvl3/rpUbdGDRmwpaJxImHHRp6EuaoneyG0VScez8xIp87AHCcCr4nuuIyd7axh97XpmZ+SqdRWujP3HST9apiRtjALc4EYVzH0cFpwSSH3G54SHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230626; c=relaxed/simple;
	bh=csHeg8MObnbrWTwmb/ACzdRp8SxPCHEJRSTxWRtqx7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fw5w4cZWorChRhX2xU1+aYjc8JKXlfcK2zH8w2rvPPoMMHEgOxcznQpRrx97a+bAYtxfwxT5G+sHgLI0zOWjIPWWrbL4zQHO85BbbKZgkhxfz9H0AKeKzLsirhjnAJmpGDMQe26qH5rWSipnUebbVeYanCQ+0hgPdr1lYl6c5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXXorrOR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so7266857b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230624; x=1707835424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXhY5RGHHBmKvUK4ilHdwmmgS7mqz+uPImPGBwwU+Es=;
        b=VXXorrORSa2o/G3bEXvMtrNs+FbnApeTaYBk/9J55/0pQeJS2/cormPr/ZPxstgscE
         +onw9hHqm2StaBOsd14zGP5DCqvBBDvjW5MQZ+cIRCXR/rsBdNOYVSC5gB+5D9k5hFKo
         SRC8BJeSdE+pil0iJUFU86E2DCjcVxW8GnoGyCIcjcFX/EIQ9AnHtlZ8CBkpkqrtexKG
         Aac1iZ5alNAMfFZER/Vnde5eHC35wies9G4Gd0cDxFvoGiluballWhn8ZtLmiRBk/PyI
         dq2KFkAI2yH5m7b8qJnrc6R6moogwAK8aa2mXeRfZZcuNNDA3YDEmMCVDUE5Dccb6KIB
         93wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230624; x=1707835424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXhY5RGHHBmKvUK4ilHdwmmgS7mqz+uPImPGBwwU+Es=;
        b=pa/7gbOPLRCYGnVPxfVs6IZyCmprTsqnOU1p0g++7p+PS2jUl3OPWxEZfshg+8egr8
         BTcNRGHiCm2BAjWRgt+dv4FtgrbKljIwRj0wx6vRF2e9U9utY/vGaLLScGAy7aiplZ3O
         ek7mugQhPvohSnOi0NOv9GK1kW+XfLt+POhJ/t/dpi6CC0pDfgQfv+rrJFjsZpn+q5my
         ikJ6Ob8rsLAEoeSfALjJQMNWAXCDMmJpChmGjKvTwWx8tLiQMOUCmY8rOD3IVFMp9CY5
         JfQS73kNZfVY6cjtaaBLneRT58t+YxIZv69z4szYfntc0hObLHUd3PgMwTgyIslgR+xN
         OSBQ==
X-Gm-Message-State: AOJu0Ywks1jGWwy00jfnzGQRXq5raYg7mvLrhEK1grSn53VGzjOA9oCp
	miTJbArLW01hPUuHPCNv2+XZfJ95VUSPZMWhpAT40Z/ZBHhLLSeZ+J4rqq46+w1UeBrjvHpCHUr
	+M75D4QlCug==
X-Google-Smtp-Source: AGHT+IFE85NmfrwgH1+U1MiEOGIviL6ZNR/kXfFExJGWwBnAgAr/WbF57wUQ602ojmXFg+UszJF8deVMisvKzA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:240b:b0:dc2:26f6:fbc8 with SMTP
 id dr11-20020a056902240b00b00dc226f6fbc8mr54939ybb.7.1707230624565; Tue, 06
 Feb 2024 06:43:44 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:12 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-17-edumazet@google.com>
Subject: [PATCH v4 net-next 15/15] xfrm: interface: use exit_batch_rtnl() method
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


