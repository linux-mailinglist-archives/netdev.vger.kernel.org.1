Return-Path: <netdev+bounces-69132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B7849B14
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B781F266A0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0122E63C;
	Mon,  5 Feb 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2WtpKSU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3581CA81
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137303; cv=none; b=GN6WS8vWsr9TWDyVFAF4B6dpYE/6YYvJqxioxuL/qyLJC64WBesRHQUBtHYPwzMWN8zjKMWfc6OyhgowrmMjXl5XiiBpIHzoPLrqFSrY3AIOJQglWtkAsmW11s2ZaJUwja1djAomY49N5oMvu/NeISGZkc8/dVxaUHxgmgYE/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137303; c=relaxed/simple;
	bh=4zrgDxfQyQr/MMxBX+zy4rapi5D5t+FXILJZ6E/m2l0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jv12OzzUSQgQYsHvCusq+NcE6neVea55147zqTQtywqUE2YD8HHQ8VRHrr7WiEBWnqaH9GMjFa8ZuuLIFor8LY+oHlkMmV8MWkxjwLkqWAWacAZ8f8QiGgmG4XU6YAVGB+yLHKoUT5e79C+pFKv76UovRWPxjYU//6QRHv1thcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2WtpKSU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040f058d3fso97101097b3.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137301; x=1707742101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucrSInxhM/tToihWu9krdoEfDlDiN1lPApGKi5+rQ0I=;
        b=P2WtpKSUYSPxQtDA84zAx7VhUw9mldFKlhHs25UBXBEmDTHQ4M1/kxp/EfqkLjIC4e
         D1MwkzP0tamDkU+1x3ehuxCiKKO8Io6jlUyl1Fj921WQtrllgjypn0y21zZUKik9f+Zq
         O+IjS2WrWKggQCMVz6FsxpGx3RzX34oMB+vBKd3iBoAo+cdmgnpyFWGGBqY3VHJ2ni6w
         UAAflu2EhXbvfataU6lGiynPLGU+N7vID1ioyegNyEtDMEVHtdf6HsWVgMRbnXWwUGnU
         W08iCxraFTNFuECXhTOJnrHxWR7MHKXEnuG2xvcKzG+vca3lNR0SYw4o4eu5LQvDDjYU
         fIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137301; x=1707742101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucrSInxhM/tToihWu9krdoEfDlDiN1lPApGKi5+rQ0I=;
        b=tPLb2gdH90gtPWE7HvMqIDNArMqCdzotxi8pEfXHOvaqjismoRfOqDh+rUAkDIFCQe
         m5RKx/iJOVFoiKFPZ1eYQMBheizN212IUKabifCuoqSTTpiF8ytxj2QSh7V5gCNmX2Sp
         3IuOiKmyMPvtj+SGDtK53R1v/7GQf6bLL60vJQUg3yuDmO2SCTE8olxoMuc/WFbSM5pN
         CesAidkm1uOQ8MzvyBKZn40NR5yA2Tl9Urd/8YDn9lcJl//2J//tbYEzNC4a7qQhqUS7
         gxztYVPgeNEGvqGskE7XsKJFZw39oB1s4Mn11dMYjOTHK20FrBEszdNMoB5VuMkVXUwM
         GnHw==
X-Gm-Message-State: AOJu0YwqYCbclLECeMcKZhMG/KkPrdriqzpGSyJC8xkvDMJsw+CrpUbd
	KipCGgDYmT/pft7Xezxlsxs1Kku9WBnx+uONII9Jyw7i85UnHv0N+AD98BDLiQmzTQLoN6gm2N9
	4iSv0zl1Itg==
X-Google-Smtp-Source: AGHT+IH+w9seh/a/GYKcbdJf0zHLpBu66OF9aevdyOe+iiL7dojP+SIsIu/jootGlZcpEM8/fF6N2jLl8PUNow==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:10d:b0:5fc:d439:4936 with SMTP
 id bd13-20020a05690c010d00b005fcd4394936mr2566352ywb.8.1707137301138; Mon, 05
 Feb 2024 04:48:21 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:51 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-15-edumazet@google.com>
Subject: [PATCH v3 net-next 14/15] bridge: use exit_batch_rtnl() method
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
 net/bridge/br.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index ac19b797dbece972f236211b9b286c298315df25..2cab878e0a39c99c10952be7d5c732a40c754655 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -356,26 +356,21 @@ void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
 		clear_bit(opt, &br->options);
 }
 
-static void __net_exit br_net_exit_batch(struct list_head *net_list)
+static void __net_exit br_net_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net_device *dev;
 	struct net *net;
-	LIST_HEAD(list);
-
-	rtnl_lock();
 
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
 		for_each_netdev(net, dev)
 			if (netif_is_bridge_master(dev))
-				br_dev_delete(dev, &list);
-
-	unregister_netdevice_many(&list);
-
-	rtnl_unlock();
+				br_dev_delete(dev, dev_to_kill);
 }
 
 static struct pernet_operations br_net_ops = {
-	.exit_batch	= br_net_exit_batch,
+	.exit_batch_rtnl = br_net_exit_batch_rtnl,
 };
 
 static const struct stp_proto br_stp_proto = {
-- 
2.43.0.594.gd9cf4e227d-goog


