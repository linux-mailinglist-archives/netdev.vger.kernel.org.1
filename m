Return-Path: <netdev+bounces-69127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9F7849B0A
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687E8281812
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707348CCD;
	Mon,  5 Feb 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GScOYvHF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655E2D056
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137295; cv=none; b=CV/zZtT3Yxjz3o8Tr5ADic+eG7lkpF38464YLWVQgPgVbgsMh4AowVASq8P1sZHKhrP02Nbks/LnHpzRH9LNm5xU/h3JIru515LBFvplZOaAKTwnxIMYxigh7q4wyL4oEH9BHu8xJReg/6jD90gOAuxW4oZJi2CS+pj7jY9TnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137295; c=relaxed/simple;
	bh=JHINC854ia98PUJGcuLobWS/goCDxB+drerbt4+vUfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ee3TBORulkGyzz4MLhCLbPMw+b8zmmIvL+P8kttDBxPECq0cA2ULv2mLcfIEQ3ZCH3S5ow9VvwzQ0/XY6feDTHZiG/7hjf8XyzRefntj++CA15FJSCKMPvZGphynTLkgLOMUrw4+hzmmopX+PsIMgnH2pwvLYA4JFV/BVYQtdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GScOYvHF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so7214596276.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137293; x=1707742093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ5+OvkCx7q7sa2Wuj/YvUBwdeuOFa3Bfx0+2rdMfyo=;
        b=GScOYvHFZEayZCvJWEs6Wyu11Y5X+6J+UuBQ8ON0FXXN1ALKdE+NiXTA8e6bu+fmYU
         bkqSTf3L0qnGr+VpVhe08I7vK5xhwvoi38ff6V8oP3OGamPCluyH4Z/YodrbA3txP8yd
         4jmO9uk6OIdKds3YW7zG5q7zVaKygT+YD4IXnl+U5bxF0nbAkhDKUyKk4PYSSXbNVl3r
         6t7TzMQDrZFImFGIkIbfuPa3WFKRI7nzfT0+UkKLUhGXo+9FSMRex+tJl9TqoKfgHzhC
         xxZVxeSgAOTZxQxOED2BbJaYUN/93Owi3lR29FCO0t+lzRp0qI1iuA3WYO/lG/1fAvIU
         js7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137293; x=1707742093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ5+OvkCx7q7sa2Wuj/YvUBwdeuOFa3Bfx0+2rdMfyo=;
        b=dgGsZMAX90SbGDVcgVRrUGEg5D3IIhpmGR6kT9+YwTtlgUzzvQTWiZ2TqLeyGgVnaq
         BHFkIrMVTbW2pku4ABj447m9ny+tPJmvtOJWy4myahue4GJrDGEnb2sHM70CaN6nMIhS
         QoPySnFBTR6uElnCrkyKYCdnzQnojLtLTI8lJ2uidBkaNyBHrGipBpllZI02qWLWl+Nx
         8E041WzrwKEGAGbM8L9Ic7Rgi6EL7mnZdB/x2t1jR+NvrfHeJ4zUu/Cbb7LIo7lWjPtm
         vKOd21hGKQFzthIyX3/Tuwo4Lv8fi3wK+zKj7JKUUQXrc3wb8A7fdCWM4QRQ9iKhlqqS
         NR2A==
X-Gm-Message-State: AOJu0Yz0mylgxjI5oCGVXUR8vLSms2VDLu8ICIojPloVRuzr9FcIOKOz
	RRlebkZX2rvNSLJauaWiu8UI7WL8oJpI2tziTuQk0rzRcbJz8XUORSADnO2FnhPs253O/wZoaGQ
	2CXmAldb0Eg==
X-Google-Smtp-Source: AGHT+IHO+v48v0LdMpUfb3AYjp4NL/rhFKCWzNnyG92iD78QxCqZ6qPRf5Ki/1B/df5ZJlVwS+3bAuo8DW8AYQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1611:b0:dc2:550b:a4f4 with SMTP
 id bw17-20020a056902161100b00dc2550ba4f4mr2919222ybb.1.1707137292842; Mon, 05
 Feb 2024 04:48:12 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:46 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-10-edumazet@google.com>
Subject: [PATCH v3 net-next 09/15] ip6_gre: use exit_batch_rtnl() method
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
 net/ipv6/ip6_gre.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 070d87abf7c0284aa23043391aab080534e144a7..428f03e9da45ac323aa357b5a9d299fb7f3d3a5b 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1632,21 +1632,19 @@ static int __net_init ip6gre_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6gre_exit_batch_net(struct list_head *net_list)
+static void __net_exit ip6gre_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
-		ip6gre_destroy_tunnels(net, &list);
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		ip6gre_destroy_tunnels(net, dev_to_kill);
 }
 
 static struct pernet_operations ip6gre_net_ops = {
 	.init = ip6gre_init_net,
-	.exit_batch = ip6gre_exit_batch_net,
+	.exit_batch_rtnl = ip6gre_exit_batch_rtnl,
 	.id   = &ip6gre_net_id,
 	.size = sizeof(struct ip6gre_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


