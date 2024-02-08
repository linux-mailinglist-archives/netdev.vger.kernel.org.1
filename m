Return-Path: <netdev+bounces-70177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9E84DF88
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8781C283A7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACBC6EB54;
	Thu,  8 Feb 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZDoPRY3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9B6EB56
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391013; cv=none; b=gMtLtFLFms/BFuu81wvGryNWNJ+Zxf0IrW+U2CcEoD8Ef75TFPd7YwffrjlJ/iBALHUJWikWxKTQV6BaDZkxI67hlkKYmm+01UezFB+S3cf2ZXWK3UQu3Q4VO33HOPGyHJ5gSnR9tA29w3+xTbdkjOHX6kVAsm2K3/mS9NVlobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391013; c=relaxed/simple;
	bh=7mz87wY0j23imRQ6QFVIdhb3tG1hg6idztU7a/rsL00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rCTrGCHCnwXlrwJu1xX3uanDjYc+Lj6AU2A3iWe6nEJf36uB2JfcYrYNajPa5SC3vStoC6hge4/snZaVonEvxfn4M/UYDJgN5TVqu3i0wA0+AfwDg50L2RDHMqgpbWb/nh+FhroEiCw/wV5JJwcQXI4xJWb/Nb2V/2aEtseLbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZDoPRY3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604ab15463aso4729147b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707391010; x=1707995810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxxA6UvNfV7hUeEnldPFFLLQTuouWFZjT82OWNibbxE=;
        b=PZDoPRY3NtN467qDZUBHQ0MMYOpUz5SIQKxRzI+fEVYOerCUQnWbST/ntS35NsDmhj
         o4gVTk4JroVE9/P2kOzxNVlPq5201wB5vCJqyV3h1tNNIOUDbGaPySbw/3kgTxPHQjxQ
         Kok0rM/SItODjgenqI8gOGNM/DLAW805QpXeQ9Kbii7PJ1cw4z7dQi9HfW5DYs7Eohhn
         GblvhDAQQ65Bom7URC2bDabnF89Yh3MvOTe4eK6zis55tpu5ysyb13KWQ7acGWqBp7RL
         v3TXkcUnmWIp+PNDZ78nvRIC5g2nne4xVtGwUbs//PALRVMUkB8AQjq3wM7BJpZL543W
         kP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707391010; x=1707995810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxxA6UvNfV7hUeEnldPFFLLQTuouWFZjT82OWNibbxE=;
        b=Il+DEyHl4i5dUCcMZkS4aOtXb67i32Z2ATrRo7pBhsAZ+w5KzCB7J57jtk82eJtsVR
         tVpv4ZwQUnnF9Me55rmeWUpf9Rg7O0TGdw6jbycRXkeb70GI+YRy0E5A9sKWjyqbs+l4
         u2LZvYzLA+V7qIm4AslAhpfiY1Ng++/PPnQ8kR6xo+dczsJMTV3GGfSuGT4n8OPAKKW5
         H7wbEXftpEzQkNqQUpQU+ajQo5nqsAom72WhttkifFY/MH30yPFvaKPmbeeW1fRakqXd
         OTVAcXXJ8V65LZ/JF910vS9ZyjeByEI3iyl3UKXtmgwLm1q5iA+9gqrmo7fE2fCYm/xi
         TscA==
X-Forwarded-Encrypted: i=1; AJvYcCW1MWFBDW0sXVQgav3EwBApcQbaFVWPL4Kqv7xTZYj+u6+2PVmM501lD7j6ro8SwvunCpYt0xvuCrhR64eF3swmDl+xU+Vh
X-Gm-Message-State: AOJu0YxVBNY/JBPv9nSbuODgqu3zO0FRV9TP4ApSflxIkNdh0gVjdjkB
	obY+0Ll4Fw+NWUBAwWfgO3lh5pkxh3nE3NlSe5z4sqeXTC7DhQKO4nDUriCq0YNw7adas9lzMoq
	JA9WLEXD4yg==
X-Google-Smtp-Source: AGHT+IEUg88PAL8oKvRK9TK0ramiGqN8SiVbAHc6Bx5UoGigHPTYGOpeYRNxHQEjk4bCjT4aODDwyMLMobPs8Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4f87:0:b0:604:9a6e:5c9c with SMTP id
 d129-20020a814f87000000b006049a6e5c9cmr568933ywb.10.1707391010699; Thu, 08
 Feb 2024 03:16:50 -0800 (PST)
Date: Thu,  8 Feb 2024 11:16:44 +0000
In-Reply-To: <20240208111646.535705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208111646.535705-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208111646.535705-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] ipv6: fib6: use exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using exit_batch_rtnl method instead of exit_batch avoids
one rtnl_lock()/rtnl_unlock() pair in netns dismantle.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/fib6_rules.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 7523c4baef35e23d39e9537943593107a79ff551..44194332ee09f673d993271f2e1f278bd6f2c5a2 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -493,21 +493,20 @@ static int __net_init fib6_rules_net_init(struct net *net)
 	goto out;
 }
 
-static void __net_exit fib6_rules_net_exit_batch(struct list_head *net_list)
+static void __net_exit fib6_rules_exit_batch_rtnl(struct list_head *net_list,
+						  struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		fib_rules_unregister(net->ipv6.fib6_rules_ops);
 		cond_resched();
 	}
-	rtnl_unlock();
 }
 
 static struct pernet_operations fib6_rules_net_ops = {
 	.init = fib6_rules_net_init,
-	.exit_batch = fib6_rules_net_exit_batch,
+	.exit_batch_rtnl = fib6_rules_exit_batch_rtnl,
 };
 
 int __init fib6_rules_init(void)
-- 
2.43.0.594.gd9cf4e227d-goog


