Return-Path: <netdev+bounces-151766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52689F0CE0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5044283135
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C81E0081;
	Fri, 13 Dec 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhaGOmlP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A981E00B4
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094943; cv=none; b=oE3k38zF4hXGLvAlYM/hmx/BWyc6ikGJ39B23q+87gAg7zyOk794D1+EEFd6D/yDtQRiWdt76+0vqny9wCcjqVxs+MxeQBu/rJMSZ2JAV8k0ui0nZjVy6J1qNLeelB5B26HZv6SzqIT6Um4XBfm3QPRLuZ2iaqvCl+bvPU06dIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094943; c=relaxed/simple;
	bh=VWA96KoCajBnO8Bt9UhYsE6DvMaR8N7eLH58EmxQ9IQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jUgAkATq61sHmdHH2qXS7xHe87itXu1ZsYwIa8O9089AJLHBYXo4VbQbpbwd2HbJfjJwPmyDB/0nUS+8uWYibupsIX/IFKkj2K/gcPHs7XeoUYlkNxvDpSSDGHQgKPnnnd1HpCS6nQOu12bGIjGNFRBGinOjT80LKMQ/1ERf5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhaGOmlP; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4679becb47eso42072741cf.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734094940; x=1734699740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCFGl37tvk0Dx0wNhWAaFFkdhedhB8ygdRsgH6x2Q6Q=;
        b=QhaGOmlPsjIbfVMCj6dVG+kjVLhrGpvPWsooYDzFvKsacb7YtiIpicldgFxTFfCwX/
         /g8+iER3AOFlkUvzlVAwTAAS4+gvIAUumCG0FrKpegWSvSyvvo8CcapnFDFdSzskaLKb
         sWTUP8Hgb6VabhduRwqnXUuIydvaPiTZSqcJzpJziMV+Fe1wv4OV5GW5CViGquUw3upo
         UiHlTITM2bsPI6ODnTSKtwB90eHWX+6uY+PkiHOBckEJgPwoFW0HaV9GIqD3Hg6ota75
         2gR0dYWUo12BZOvfYo2D3mZiDneNTyVNlS+7aZ6pwIoDTZqjs4xhEwV2boMl/6GAQLWw
         1wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094940; x=1734699740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCFGl37tvk0Dx0wNhWAaFFkdhedhB8ygdRsgH6x2Q6Q=;
        b=Pnjos7Q6viLAamrQmEVbCuCKK3tovP+vNfJv3xRyBk7A0shKwkeSx1kBWeOO1vF5kk
         lpkHxYltNwf9OaZAUbpAV8WC5hoLTFTUbWdt45bslA4ECakaD1o/TWJJD4j2yN1m2EV6
         xT2bI1F4bwfAo2y3wMTyOso4ru3XSkxp7Tdd4Kgp+3lbpAu2PRNuwvgZ8EcavGvKyriQ
         BsGeB9ZMY8YB8Hgq/iEfrfBJGebXGQMUqdrjwLOz0XorLzvOnKQ5XK4yRvxfNH7hixsl
         u0MXoY8Z9BV1SWHfQdu8klBI4CpHlFf+sX72IcXgYUIOr18S/DACAWx4oiOa4leLIIwS
         Sqmw==
X-Gm-Message-State: AOJu0YwqSzgpyHsIZFJWEHGutQx8oWyTNzLGqQvJ6nBMgvdTNewQkFp0
	INj+gps9pNthsPAHrPGhDQmavbQaL0w7xtQl7Y0GFuMeHSz2PuuK44eDj13kmpzt0CRAeJq+27x
	t+8CkjAbKwQ==
X-Google-Smtp-Source: AGHT+IFlXSNuiZIFYarNNwywlgQ1/d8IhHK+Cr4ktZZ3zrpQQADSgjTvYzYhHJxbQilhGDXFNLrXyaP3WxtoDA==
X-Received: from qtbgb4.prod.google.com ([2002:a05:622a:5984:b0:466:928b:3b7c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4c8:b0:467:5836:a9b with SMTP id d75a77b69052e-467a5757da7mr47529261cf.15.1734094940025;
 Fri, 13 Dec 2024 05:02:20 -0800 (PST)
Date: Fri, 13 Dec 2024 13:02:11 +0000
In-Reply-To: <20241213130212.1783302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213130212.1783302-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213130212.1783302-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] inetpeer: update inetpeer timestamp in inet_getpeer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_putpeer() will be removed in the following patch,
because we will no longer use refcounts.

Update inetpeer timetamp (p->dtime) at lookup time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inetpeer.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 58d2805b046d00cd509e2d2343abfb8eacfbdde7..67827c9bf2c8f3ba842ff1dc3b7e1fc2976e6ef1 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -95,6 +95,7 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 {
 	struct rb_node **pp, *parent, *next;
 	struct inet_peer *p;
+	u32 now;
 
 	pp = &base->rb_root.rb_node;
 	parent = NULL;
@@ -110,6 +111,9 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 		if (cmp == 0) {
 			if (!refcount_inc_not_zero(&p->refcnt))
 				break;
+			now = jiffies;
+			if (READ_ONCE(p->dtime) != now)
+				WRITE_ONCE(p->dtime, now);
 			return p;
 		}
 		if (gc_stack) {
@@ -150,9 +154,6 @@ static void inet_peer_gc(struct inet_peer_base *base,
 	for (i = 0; i < gc_cnt; i++) {
 		p = gc_stack[i];
 
-		/* The READ_ONCE() pairs with the WRITE_ONCE()
-		 * in inet_putpeer()
-		 */
 		delta = (__u32)jiffies - READ_ONCE(p->dtime);
 
 		if (delta < ttl || !refcount_dec_if_one(&p->refcnt))
@@ -226,11 +227,6 @@ EXPORT_SYMBOL_GPL(inet_getpeer);
 
 void inet_putpeer(struct inet_peer *p)
 {
-	/* The WRITE_ONCE() pairs with itself (we run lockless)
-	 * and the READ_ONCE() in inet_peer_gc()
-	 */
-	WRITE_ONCE(p->dtime, (__u32)jiffies);
-
 	if (refcount_dec_and_test(&p->refcnt))
 		kfree_rcu(p, rcu);
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


