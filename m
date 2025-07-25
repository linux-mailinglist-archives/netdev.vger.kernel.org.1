Return-Path: <netdev+bounces-210057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003A6B11FCA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5787C3B8B5C
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527A1F4CBD;
	Fri, 25 Jul 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xutO+I5y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D422376FD
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452460; cv=none; b=NyoQYy3EirbqoPgoA/OLr7Dlpy6u1rY8Q2WK62H6UNXSdIVf2u//tPnfztvrzLinUb1IBqK/skR7z/oWPbQ3PuGirrY7DSGlVfglaRRxAbn/fq+ITLOAzNxtnGwRx1vEQBDYrztxUbTp8PFbrdpT5RJBsXARpjSEBIZUNLF+WCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452460; c=relaxed/simple;
	bh=Yp4kNtHrbrb12XfeuM8tyPpYiJ+UaKpGZWffFSKQ/3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ONab8B8eqKqRePi8Y7P0BjgfAJnZ1oU5wG9HlM0B2KMdL9urpdkAz4Alp76hIQbZp0hQjzKc22b51kpWHjvGGo4XFxGXBpOpztizvPikD7xC3RTGFs1b4+//oSmqbWdvD2F8WPAT81GElA8W9zzonKWthqc0EfT5QZlrb0hTIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xutO+I5y; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ab87fec9e2so46521431cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753452458; x=1754057258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7ii8ZBSksHUoenWXiIoBguWRbIjsMsuUpBNxSoW5Mk=;
        b=xutO+I5yGJx2qKzkivkCZ8dW8ePzLxTdz8enCHn+y0LLHAUehAxE8vABZrOWZiJEyr
         tOz9+gm+rJzABXEi6WWIF4gcPq/rOcM3pyqtBTOafbwiJC7tIqvJhR1VK/XzSTe2tx79
         fp//YvNTFBqFQ/NRrYiSQl3NRqSrAhRV3Q1Me5pRtXww6hD4e9n2rmWS+A/JRv2lowLR
         Xf2Qb+6DreaoQ8chMqFRwxOQQtwuDdIU6qLuZvT8qDBwuYHsViEvyLh9gmF4BuUQn/uG
         45yKvOCtFxhQisNCqnPwSl7grfZ7CRJ7t5ocPviKAyThZSKAeN7sxE6+76hh9cbuFDVZ
         Metw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452458; x=1754057258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7ii8ZBSksHUoenWXiIoBguWRbIjsMsuUpBNxSoW5Mk=;
        b=Es1gKB0EfZ7sqNJaCFg7rvqXD6o7CBHDrVM9RMy0WzPQbqwKOa/XdKKHAHGyqkg5EN
         FKMfsNS/hPsXA360yE8PkiVeW6nchK6ovaSQ6qD36WlWum9GOLIPNahzcDU1HPD4uBLO
         QnGdaBekY2TqN9F6vpaAhG2I9e0768ZmM7vFx0J+8D72DQjuJ3LhxjBb16X+AmYGqxAI
         38kzItiXxt76659nkXRlTaH8SX0ajSlpVrA4R+aTOoOFRGu5M4PmTRb1NF9EFpeyKwfX
         P+9TDbyl1MeXVgG2Eo6S/kxOIDbhQvhNX92v3SFJBc502UCK5/lFi9CgfJsuqx/gZfeh
         USKA==
X-Forwarded-Encrypted: i=1; AJvYcCWyZe/sbkMn5e9uzfpnQKfM6Zu8Atb1hxTNkZcacsOP5lMYF+CVZZvprAmRhu1hp5yjBpx8V40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAZ6snSN6NbVvxVZ6h8LNNHFgNa2El6hd62jG65TfYnvl4RbO
	1sMxl6vK1+LX1yu+LCfniGgAtiuN1kNwoCo4mO5Z5C1UCveRs0WyOuT+2B3wXK182zHWple9Dfw
	SApOOGWzBI0zs5Q==
X-Google-Smtp-Source: AGHT+IGdqp4vXoWkwJi6HpLZpU8uBS6W5h/87TAPPr1G9oMfT7ltUPZNNBp1t07MrRezWI52hg0ot+IKjCCQ9w==
X-Received: from qtav6.prod.google.com ([2002:ac8:5786:0:b0:4ab:83a3:861])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f53:0:b0:4ae:5be0:9c46 with SMTP id d75a77b69052e-4ae8f0e01acmr24503711cf.41.1753452457771;
 Fri, 25 Jul 2025 07:07:37 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:07:24 +0000
In-Reply-To: <20250725140725.3626540-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725140725.3626540-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725140725.3626540-4-edumazet@google.com>
Subject: [PATCH net 3/4] ipv6: fix possible infinite loop in fib6_info_uses_dev()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

fib6_info_uses_dev() seems to rely on RCU without an explicit
protection.

Like the prior fix in rt6_nlmsg_size(),
we need to make sure fib6_del_route() or fib6_add_rt2node()
have not removed the anchor from the list, or we risk an infinite loop.

Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/route.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6d4e147ae46bc245ccd195e5fb0e254f34ec65a4..04f2b860ca6156776e0cedd18d96877effd287a4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5958,16 +5958,21 @@ static bool fib6_info_uses_dev(const struct fib6_info *f6i,
 	if (f6i->fib6_nh->fib_nh_dev == dev)
 		return true;
 
-	if (f6i->fib6_nsiblings) {
-		struct fib6_info *sibling, *next_sibling;
+	if (READ_ONCE(f6i->fib6_nsiblings)) {
+		const struct fib6_info *sibling;
 
-		list_for_each_entry_safe(sibling, next_sibling,
-					 &f6i->fib6_siblings, fib6_siblings) {
-			if (sibling->fib6_nh->fib_nh_dev == dev)
+		rcu_read_lock();
+		list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+					fib6_siblings) {
+			if (sibling->fib6_nh->fib_nh_dev == dev) {
+				rcu_read_unlock();
 				return true;
+			}
+			if (!READ_ONCE(f6i->fib6_nsiblings))
+				break;
 		}
+		rcu_read_unlock();
 	}
-
 	return false;
 }
 
-- 
2.50.1.470.g6ba607880d-goog


