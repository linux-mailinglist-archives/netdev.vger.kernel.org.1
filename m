Return-Path: <netdev+bounces-156329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE33A061B6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED193A1970
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0201FF1DD;
	Wed,  8 Jan 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3N6Gdrc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA51FF1C0
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353384; cv=none; b=F9bNzSfNx38bhs5IL7GufV4yBOr5bXM/P7ptAF/R0TbK1nxBx3Z7oKHJspcYDUwYbpTbtwPN6CQUUiXjzHWXm+NgDNO5s7jAbGyvaHTeCAqxyHnX+2/eV+kU8RVtuX5eJj77Fj/nI3cf1VkPeOFmT93avpgtlxihwbb7SjEFkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353384; c=relaxed/simple;
	bh=rSqJj4XwTdwc39+3g8QMOFoAWAV1qaibloUAJCEd9D8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z1QIvADRG6CZ9E+fkNsAvNG7QObcRHvFcKZ2LMy4ipAQ4Y4J6vAOhwfJ7TKGripKq8D8LQu8WabFfLaybH+DWJh69jsTAakmehokpj09df5c/OfzXvvfAkhrsLrKt9hWENUgsIt2rmAe9vYqK0jXLlflHEOut+DcWuMFz3jagAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3N6Gdrc; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4679db55860so337860101cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353381; x=1736958181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhbjwta6TiDMc7v+7DNtDB0Tr9ebF3Qj7Hv8pFJ6cq4=;
        b=a3N6GdrcTeXSPnq7XmvG57Y2/9qvhrJfNpY1YasIKnUl0sjlF19W+ewPr+FHyHkH7C
         xMNUeMpj4IVhk93ClMOabQXECpTY7aa9wrUy/qhC7LUqk/uN+CS0iUh/AeYIGam65I2Z
         HVVz+ODb0VZcAttNdSSvXj33aBJ4/fHAgtkzRPZGfxP+XTWquT0YXYSNKy8BEM5cSzCe
         bXobaEG4PeeLncgUzRT92L6OMCz9aWJeH0n9LfrPiDcCDK3vGSKtBb0EaO8om4fJTA3d
         A1ZIPsUmh9pbWNe2Wzo6KwTJKuUQn2CAWMCH9fJWC7kCmuM6gYz6Ps2RbzrerQGisM0d
         WC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353381; x=1736958181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhbjwta6TiDMc7v+7DNtDB0Tr9ebF3Qj7Hv8pFJ6cq4=;
        b=rFFytGNpnEysC8pF3n4OeA5mo4/tn7vdFmVrOTgCnq2DcmTBwq6YWjBB81fkD8FcRg
         eC7Tw1az8GODJfq5TKd1YbGZKIQsJJslYuKRKmIj0rsfSJ15g+rnVWRqrEJG4DerO61T
         Qp0YbMZk46DAAh7xx8srjhHA0g771vBZE+waB0GLSyX4lRqJGk2IFPtqb/tW9IBWnKvV
         0s+MLf5RdgDahI9mRxcovbr7EoemhUcYuCM0kOJs9xARuNTdxIgwhJw10QUeniRXojNZ
         jLMcti2lgNJgfaBdy0w90OkMmWv7/A0eVai17RUUJYYYNCA9OHlddsYk15JJS1uX2MMs
         uPyw==
X-Gm-Message-State: AOJu0YwFj+x8+X8yBqY8/wK9HUYQ+bMTqA1Q937H7oO0GEHbV1MtT+ts
	7alU93hWrBE1c663Uozkf2qzNRKQ2/4wakKQRhpXUDS0p5OcCU01rE9aD+E46rzSk5xleegZIFx
	xjoh5gBJv4Q==
X-Google-Smtp-Source: AGHT+IEv8p0Thx3D4GtVYuFmbhZLcdXVvixTic9daCsqvjXKUpOsi4pJUZ7mazF+JuA9GANCbf61us1JpwPuvA==
X-Received: from qtjw4.prod.google.com ([2002:ac8:7e84:0:b0:467:7076:37d7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5807:0:b0:46c:77bc:ce5e with SMTP id d75a77b69052e-46c77bcd922mr20213391cf.7.1736353381550;
 Wed, 08 Jan 2025 08:23:01 -0800 (PST)
Date: Wed,  8 Jan 2025 16:22:54 +0000
In-Reply-To: <20250108162255.1306392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108162255.1306392-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108162255.1306392-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] net: no longer hold RTNL while calling flush_all_backlogs()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

flush_all_backlogs() is called from unregister_netdevice_many_notify()
as part of netdevice dismantles.

This is currently called under RTNL, and can last up to 20ms on busy hosts.

There is no reason to hold RTNL at this stage, if our caller
is cleanup_net() : netns are no more visible, devices
are in NETREG_UNREGISTERING state and no other thread
could mess our state while RTNL is temporarily released.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8ff288cf25dceb5856496388f83f409fcb6f8e5d..86fa9ae29d31a25dca8204c75fd39974ef84707d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11436,6 +11436,18 @@ static bool from_cleanup_net(void)
 	return current == cleanup_net_task;
 }
 
+static void rtnl_drop_if_cleanup_net(void)
+{
+	if (from_cleanup_net())
+		__rtnl_unlock();
+}
+
+static void rtnl_acquire_if_cleanup_net(void)
+{
+	if (from_cleanup_net())
+		rtnl_lock();
+}
+
 /**
  *	synchronize_net -  Synchronize with packet receive processing
  *
@@ -11548,8 +11560,10 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		unlist_netdevice(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
 	}
-	flush_all_backlogs();
 
+	rtnl_drop_if_cleanup_net();
+	flush_all_backlogs();
+	rtnl_acquire_if_cleanup_net();
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
-- 
2.47.1.613.gc27f4b7a9f-goog


