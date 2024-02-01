Return-Path: <netdev+bounces-68128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0903D845E2B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9461291C3C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F6160887;
	Thu,  1 Feb 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pWFm7I/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B215F32F
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807392; cv=none; b=j5HRdlfGzvD2QHjNW282/1RhcRG2kyKV+Yba039OQec3hoU4OEgXaftnTGvYjjgul7UdJiiIp7Bap3Atkfg3w/mb41WbgYCfdX6AspxAWeUmJbt8LzjjSWzOAklORr+xBcb2FWATXBAkIi+7C38gTAGWhve733mEFaGp6Ety8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807392; c=relaxed/simple;
	bh=ySbSnA7KzOFAYo4j/hAxP8kWMkQGj+nzQiBZZakv6DA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oby6nkrpeOMrTCuFlrOuWkeanag0/dS0aOXedhZ7sm+kPFELUeCSrLsDLcN1zItnASwCOYIY2Jqh1kPX1HJXaT+zsKZd2deyapOluBGSrUCqFAHH7e98GwtDsiWVLjP0ZlfBLYcB9FrPMAMzk0TqLAkNxBDG0PGKnDycMpGE8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pWFm7I/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso1680752276.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807388; x=1707412188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fEa0zyZ5Nlvo8UAtPKoL2jk1fVNbTf74UBHu4EW2F8=;
        b=1pWFm7I/n0PAtvUmnVHxe0JFw7x7JXl1VQ1Pnix6syF5qXbeZoVfHVjZNomLBb7ks+
         Lj1WQ4F69viepZM7q8lJCC1WKI4K1Fk8anvwNXThj1Twe79rOdyrpHNIH55vdWgmfUyb
         WebEZsZmYDPeBBB3S3/+JhGwkhdA7mkbXtfbu2nBt7XvlGbjYpL0yNKk9pwxWXosVfw2
         dqBvtCb45WkHQ05G79zQOv4Sy9MKmKkK2rh96vmR3fqrxDGxMZPRKFApx/uSTAxglg2l
         gSFPvuvTfMrx6ywBXiWyLaI9KzQtoN47buYkHqJVRblc9AQeKNwDgz64KgJFDcmuZ8IR
         A4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807388; x=1707412188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fEa0zyZ5Nlvo8UAtPKoL2jk1fVNbTf74UBHu4EW2F8=;
        b=wpLy0GB4AM+99PdI0TaKiC+4hn7SVE3MsevsawKKsCkmtTVnady+83sMt8S7nsYRJX
         DrHJbqt6GqM/d5TTmxdJiyDom+pS4dCwXaUTDddpgxsISLbXF51M7b8YzdvaTAaoi4tY
         x1eNE9ZoH0wcuAGWqtidCIr9zfeaG3+W5U14ofc86t7cfO1EY6wJ0daS/y1EytAK0UfY
         hnrbG/IPQePbDjC+PHPA7phR4Og0zSVhhlDn6BueNUgGjuSljcffbzxc9r6HgfK84R1Z
         hJddmwe4JH4y0W3Hxgm7FqScBryK5jSW9TaDGT1cdRp7Jx8Aad7XKI22nbmdemcHDss9
         O/zg==
X-Gm-Message-State: AOJu0YwjGJp/y9o8r2dDTxOupnjbmm/jY6r12IHo2OcqlxB9jFIdltZq
	dCTMudqZcaPTFOKV4FZYJX32Hk/2sWA/IvrKxaq7thskp8tpJpAqSMe4p6QVNkXdjTUrO+6usXl
	f35NpZrkjIQ==
X-Google-Smtp-Source: AGHT+IH0xfNtwxswScK0p67TZD5WSLxEqwQgUl8lpXFcc7u1qrHG3kOO0Wc/xyeHwl/pVy+r0xzp7vGCehoYrA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b21d:0:b0:dc6:db9b:7a6d with SMTP id
 i29-20020a25b21d000000b00dc6db9b7a6dmr66982ybj.13.1706807388532; Thu, 01 Feb
 2024 09:09:48 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:28 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-8-edumazet@google.com>
Subject: [PATCH net-next 07/16] gtp: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
2.43.0.429.g432eaa2c6b-goog


