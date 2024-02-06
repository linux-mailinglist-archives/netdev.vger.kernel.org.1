Return-Path: <netdev+bounces-69518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C884B83C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95166B2994B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DBF133414;
	Tue,  6 Feb 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9i6kdvX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075F13249A
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230620; cv=none; b=UO7MQRQxYGk52tF+FAKx/xXqwhF7ogvX6PUCYOxeQrpKNmsy1Yy310X3T6WLeEzARtNdXN6HPQeYDwUt9rZDx8KNx3mWOqjxYeF3TEvlb44S6BETl53ZQRO5p3JGsXBfn6ZVAAW9doDvuOPtYnDPLJcZiSItZmLbPBU4rIDOPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230620; c=relaxed/simple;
	bh=JMN+6+qy7+2YBgl8bpl2o9VZJSrVMjIkLeNGM71Q5u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kTPYddbUjWpzFSAm/J7W99b/FB6r/kJLIcY7Vpofg/Sg1JVaHAaeG5YTW5l5sS1+9onIW8ZKjXSxppBpXT7pEf2CsGPcDx0hT3qKLmuqMZAHEZBg5Q6NxJf4fSi8/+ozKPxh6bzZ70bxTi81egE62tNydpCnawtw8R6KF9o6lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9i6kdvX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-603c0e020a6so72869697b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230618; x=1707835418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNq7fovMjY+uQyu+qQl8ejtpYY0RqTC2Fjxd4aNS7Fw=;
        b=v9i6kdvXejhOHiUldInuBvIiH2sYIf3l1tSDdNM3vtGALDig3zqM23RRQIBgYdHhhD
         Fwi5151HXVKNz1Rj6TNDSWlbtvejj36wJdSjifKesCrAn7vQKTdr9vD/89U1Qh/aqA+a
         iXSHgFGnjAiSiDItF3DIqiV8/VTTZ2+Cq3IBqvoEPqF6oMQHpbgwJvBkqslZy0hmB3Gd
         HVmu0z26nzC1PmTISQX6VTVvgTfNRl3QOrDYKmaPtdMHTrEqS6BPQfW+0jd24krOZ51S
         73X7Hb3Rn96g99DArqPBcyeKv3og3PzJkNMTDjddMRjTImEae59PySH6cp0Cr3bHjoxr
         0HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230618; x=1707835418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNq7fovMjY+uQyu+qQl8ejtpYY0RqTC2Fjxd4aNS7Fw=;
        b=FRee5iAEZJ01yHzmpxZsQEmgBsFUDMmruKgy1CaWU4k+KpUgHaEqDL9rFum9r2gKIP
         VQExnssnrvNMkwT4k8NjNcRA43UtCivvrqPns0DwdpcLJUPQQxfOkcptJdwhBvH+4SjF
         fs1JOg85BJAqkOr3NM7fESwEzgF9CRWWQzy84AgwsQqKYkf3nBkiirhqvCO0ZaIDgPzG
         cfUtofTQv8voR+zfApI4PEL7Jv+3WzKfCb2bDTTe3YMcKNVLhs3X/PYPh8rEMa+AskmW
         /PszDC5uVrcPwiT746giracAnJn8i//od5SQJhRLvG7a1Tet7mGo7lnnPkqDlfZJtJtv
         sv9Q==
X-Gm-Message-State: AOJu0YxPhtB3YBI/SBVjl198DiijPbykzylHwADHMb4wancPhlD0EHDC
	R8kiXsUGnevNF85fb8n0lLV6lFGZjJ3PGjAqoS9dy9vQj/7q2XEiPCT2ifg64rU9eH0ZxKfDheu
	5UxUuTZdqkw==
X-Google-Smtp-Source: AGHT+IFfl0S5qDVIdXlxpmG4nz0V75oNoIbfCoM2HApZALjK9bdqMnK8PO8jPV8yzthR8ef5yLfjoNhUx/npJg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:15:b0:5ff:f6eb:8916 with SMTP id
 bc21-20020a05690c001500b005fff6eb8916mr303182ywb.9.1707230618001; Tue, 06 Feb
 2024 06:43:38 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:08 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-13-edumazet@google.com>
Subject: [PATCH v4 net-next 11/15] ip6_vti: use exit_batch_rtnl() method
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
 net/ipv6/ip6_vti.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index e550240c85e1c9f2fe2b835e903de28e1f08b3bc..cfe1b1ad4d85d303597784d5eeb3077383978d95 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1174,24 +1174,22 @@ static int __net_init vti6_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit vti6_exit_batch_net(struct list_head *net_list)
+static void __net_exit vti6_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
 	struct vti6_net *ip6n;
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		ip6n = net_generic(net, vti6_net_id);
-		vti6_destroy_tunnels(ip6n, &list);
+		vti6_destroy_tunnels(ip6n, dev_to_kill);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations vti6_net_ops = {
 	.init = vti6_init_net,
-	.exit_batch = vti6_exit_batch_net,
+	.exit_batch_rtnl = vti6_exit_batch_rtnl,
 	.id   = &vti6_net_id,
 	.size = sizeof(struct vti6_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


