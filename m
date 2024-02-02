Return-Path: <netdev+bounces-68622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF784765E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC0F28D234
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F814D451;
	Fri,  2 Feb 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsXkzCVE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9914D42A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895624; cv=none; b=bzl68iqT283J87hMX24UvTA+fbZrtfOtEs6e1bE5VeohkT9tWD7NMw35yPGDIYwJzGcqr+u7qDMeGiAZ3EpRkopxtPLCP4VghCUNrMlWswMwLTv76UaVHP0JR2W0MvK9xrltjZ7Zxw2FUX+5l76bbcvK+Of3MDanejReDuGtj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895624; c=relaxed/simple;
	bh=D4zdKYgEI8SANhLoeqnPAi4IZHnljQAAsNLd75I1ZM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tV+bZoWMBATl+oYmNyvLlKccXwqaggc4Bv3bHuebw3f1fyiG6OeXg1u7eQEmAdOVHGOP3llsjiuBCZOMbR3dUZ8e92GqIUhoPyIsJ7lQMdVpcj51IoPGc6uTckxxpfb5mDWf/4rqzE/9+0FRHtZ6EewcwPIYWPrB4+NzA0zygWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsXkzCVE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso3229236276.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895617; x=1707500417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyZCd8Hb1FDN7k6tGmc5xiWirDlutdqrradrH80psE0=;
        b=OsXkzCVEKyYkfsNkV+6DciBvkq9QDe8Ytg5kqywmJkFLTPGUIPxBLTilVrvURFoKgs
         AdAjr8tLccCMYyu5wi8kuItvJYED/N0pqiGZYSdGf619JIEuTBxjkCTHj4hNywqvNO2e
         q8WRDOVIqsiHUuZ54WxrEbap6P6tIw5TLDYKqNF/qYJZ7Jgv+Z1xUUMxqIOF9WtQJPkC
         i8lhTrJU+c7cDaXXFFvs8WtsTS9bSkycyR3/mrQXSP+BMoNOncsBRpKh+oGhkz2vpNfw
         s/UEzjnEtRs5gWfeYyFylGFu2koPJclhUa+R+DwKLl/T1mlHamtbkIy7+5IuB2cn6DGF
         n0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895617; x=1707500417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyZCd8Hb1FDN7k6tGmc5xiWirDlutdqrradrH80psE0=;
        b=gEVwWHATm7Ur8hR/16sZoQcJXYTZbpssRzeBsGF5uZoJEXFiOJuTFSYBdOAVGoyW8+
         OrzYISeulqCYCKacUK+9zRqHL6W8vfIy1b1R8QV3/NLXXPxf3pg2vnm52rlxCPJZ4WZy
         UB3Ola32A8JhA48Qgy2PxbOOOODIMZKbMzIrOUqcjRS9qFrYj3+Lo+29PijmBGhYOQGS
         Be6iyunjsUbec9WjpD1wGcNacrr7bBbawgw6R5M7i08bjV3i1woY209Jltt5tQPo/aC5
         leRpZJZAg9pEmjI5DIgzw8KuUdm95tswluHrkf4utrVwZLZGPFCuMB0a9gZF84+aXlr+
         fZJQ==
X-Gm-Message-State: AOJu0Yyw2xcpdYFiWZBEunDBflzJnSL4ClaGBuIR+gLigfTpKDdMSZWZ
	g5FACiLJul23FpyT+InBh3lc4i7PDiuVTvovjHEV5QkuPLEOlylV5klPXo+OSwfDz/2XDStC0Ly
	6oW0zvmOb+A==
X-Google-Smtp-Source: AGHT+IEqiB1Eq7aDRpeS4fuwJZEf+pnZrYxnduutBz4ocYgchDsSkfkqDweYlbCLxSKI7kS7AINuhp1FAdAIMw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:15c9:b0:dc2:3268:e9e7 with SMTP
 id l9-20020a05690215c900b00dc23268e9e7mr259155ybu.10.1706895617702; Fri, 02
 Feb 2024 09:40:17 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:52 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/16] gtp: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call per netns.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/gtp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index b1919278e931f4e9fb6b2d2ec2feb2193b2cda61..62c601d9f7528d456dc6695814bf01a4d756d2da 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1876,23 +1876,23 @@ static int __net_init gtp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit gtp_net_exit(struct net *net)
+static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
-	struct gtp_net *gn = net_generic(net, gtp_net_id);
-	struct gtp_dev *gtp;
-	LIST_HEAD(list);
+	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(gtp, &gn->gtp_dev_list, list)
-		gtp_dellink(gtp->dev, &list);
+	list_for_each_entry(net, net_list, exit_list) {
+		struct gtp_net *gn = net_generic(net, gtp_net_id);
+		struct gtp_dev *gtp;
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		list_for_each_entry(gtp, &gn->gtp_dev_list, list)
+			gtp_dellink(gtp->dev, dev_to_kill);
+	}
 }
 
 static struct pernet_operations gtp_net_ops = {
 	.init	= gtp_net_init,
-	.exit	= gtp_net_exit,
+	.exit_batch_rtnl = gtp_net_exit_batch_rtnl,
 	.id	= &gtp_net_id,
 	.size	= sizeof(struct gtp_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


