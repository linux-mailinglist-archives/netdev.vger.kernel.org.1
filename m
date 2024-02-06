Return-Path: <netdev+bounces-69519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3984B852
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4EB2DB30
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB913340D;
	Tue,  6 Feb 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6Q2+uSo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453C13342D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230622; cv=none; b=g5z3AXv93WR3Cp9WvBW5omcxS2soodUlomqG27zchHMZkfEPD+qQgpWzronVT41HKxtWdrPoSLa0T2+D9baBVJ3gNzwduN5vNrMnqmbQyXGFPpKxp/zj9NvdqHQJP01B1zFgeqm2UAgqmU9OzNDDbEaaV7B1FiFdnEtfntGquR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230622; c=relaxed/simple;
	bh=dCEVgCNsMJ2NjQ+g5ztXuI1Y/3IDivH/bTr3p3ZJ0Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=loMWabi+2ftkDRAfDvwUWHwdT6l9hg7qhIHa6T4UG45LYinLojJAKZZMT6DufphFjMoZg8+jnpNJvva7XlrRyPv/F157je7l+0EpoLe96R3u9zlLaeswHrsRh72pc82HO+shfaD6e9K9Uki6GhuwEAo/nzOw8LCHc1/EGce7lm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6Q2+uSo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc7165d7ca3so2576641276.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230619; x=1707835419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=up2PGM8Lh/PoX2yMsKcFPD+yGGD2E1QRR7UMzVqvJpM=;
        b=i6Q2+uSoDCW1JWmTj8mYvynRoiIsq5Q2IyPjPdUsVf/dZdq58wzE1a1GGi+3mGc8BO
         yQX2zvAcSJZLVD3jvA0JQnwFoueDbj4QTk3+8pDycNGtxYNFaij4ZFBfMxMw3w8G4ERb
         JVma/1wCJ9JP3/LBgix2erLirPUqKeGVfAHJosK0WF+jfHiIrXU9MBHTCt3NCLkNf7jM
         g52aUHOTF816gk5UQ7GUX8cfisezRBMKSBOw2lJ7a4FcnVtUU3D5YiS+CJjzgUxD4GrJ
         qle2p1SShLI17pWN6abKtlp4WYcDPU2vSJNV5YIrMkB8gPg4vtTZUpa/4tVN8y06Fs7v
         Pzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230619; x=1707835419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up2PGM8Lh/PoX2yMsKcFPD+yGGD2E1QRR7UMzVqvJpM=;
        b=h1HdL20wHuvjmLOpppNxu4hd79UaAhI1V+Q2K1LcHdT97gxxYZi/Cglypxa8nb1qq/
         tVdNJi0kunmtYrysfc3P9f1Z70QH29/U2KxwhROtlh21T+mF7AGFMW5jqiDf+HUXlJbO
         +YIJT32iWMk6c2ahgoUkTrzXOZv3fyeiX31d3jezqYeAfF0IhSIwEd1KqOX9+jmMgBKt
         pdD9wvdC2NWADbjM11KY4TUSpjiEshuzLKOBzErimIueV9yBRQjD3gnoGVEXr9oJpoLB
         snOVQUVuiC7cCm57/NqjsSjtL4YN5BcnRRgBxod2Gr4ylUPaKBWP64JaPW1dggRDsXDa
         FVRA==
X-Gm-Message-State: AOJu0YzGttup/DvzcwGWQ+mV882LrMqLcNALNI49yZQwVT4/oLJkZzDy
	x4AZ+tDJTw+evOHliGSszYrSTchQBjeLOrgVfPe0u52S4wWuE/00XhCO63QZPhIicd8cpyshnYR
	Hkol1uaiDdQ==
X-Google-Smtp-Source: AGHT+IGKQEC64kkKsTos+8NxeinUnP6TNNF0Zvja+gPaCGkouPIbCqPfqIXItychJ3aFZaJuK999G1lX99FSaw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2512:b0:dc6:9f32:59ae with SMTP
 id dt18-20020a056902251200b00dc69f3259aemr54446ybb.12.1707230619658; Tue, 06
 Feb 2024 06:43:39 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:09 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-14-edumazet@google.com>
Subject: [PATCH v4 net-next 12/15] sit: use exit_batch_rtnl() method
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


