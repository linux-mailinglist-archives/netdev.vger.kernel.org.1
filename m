Return-Path: <netdev+bounces-152009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58AD9F252A
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61531886155
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C41B6D04;
	Sun, 15 Dec 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5FB3jxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533C1B395D
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285425; cv=none; b=Jz4T3OrLGhXY/f65jurTSCnntr4GonJbfhQDzr77GqWdQfuXY/7+44TP39N35Joa+wipKc+I/WDzMXtEoe1f5zsZKxuMkTbKjMFKFSGRtl2X7ZbmVZJV1OmwGLGlJHbHqnS20UOrQzDgnRpmjRT0c6bmbN+JktX0TuNz+dMFU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285425; c=relaxed/simple;
	bh=xMhOhgfx9iC1wqcSP9QSIgaVGRXV5Imtz4jU5vk/ndY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sCMehvYK9Hin6jPY50fHuzauKwmLJAGvV61x6vnWqQ03JYk5YmCn7MiIg8CzDXD6/ktECgDDiubwT4dcSfk5WQ0YAFy5CPMNyYz/vBcwEoPQuKPUi7mIs5ANqcfuVFGiRTc7YsL//hUxPcvsyBhEo4Iv6I9ElQ15K9H7hOCH3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5FB3jxO; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b35758d690so623206285a.1
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 09:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734285423; x=1734890223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhdvF0J0cV225/R+s8FXsA7IsRr6ZvjPGG6itEHAJk0=;
        b=K5FB3jxO/t7v02vyO9Fh72h9dSh+9Wogmux2v2c0Y44yLmeDN9Yb27tpa7FLptG/aK
         GH7AS0IxbUSQ4JlEUJogOO8ED1SN8ae0P2zQPBfEfAHcg3srFMn3OgAKMj/0G/bqk+/S
         9FZhErtkAvHe1b4RoGGNhlbi6LYdvevY6p9zRC47UYsgsQ94//Li5cN0v5ozDjkkIHje
         MtnFeXXM6sj5Y40pX+BX1ldxMX0QotNH1K2+52jbKXd0y83MTG0y9BuPgJ7xzWcoD3OE
         N4GHoW/rAGI6rWJcMjBl63wffAni4hmB9qjD+SGptAm+5Y9zQNXSfaL6QdnBPSLDuJIE
         oAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734285423; x=1734890223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhdvF0J0cV225/R+s8FXsA7IsRr6ZvjPGG6itEHAJk0=;
        b=HfvweVj7w09TMLkLOJHFzxHARL25gxjo6uEhR5tNLcUDmiDPnTdub0btTZ+xVUZQkl
         PD5J4hNyrJhpm7m7IkP4HUnKZjlkBxaqrBRJaMzF50h/1zxdoVI3MxmlqkGc8bvWf8yc
         vIdhJ13S+4M1PQ8GYV4FyBtYkSrl3JlxSFnqQvxvU7kFOQIX8c/rqxQGhMCHuuWThJMZ
         o49XhJzfHZbTWsB0i2rEZZHKhViA0sd0XBOk0ir3RSY9qzikY4mmBJ7ACziCBLTsYIuQ
         WKMTH5IgCtq2VNwxWIGyllv4NCAiqpH9S5aTJI2EDPPuhlOjmCmNaH1mt4CSm3QP9neT
         1URg==
X-Gm-Message-State: AOJu0YygZMeGJjizgP8KXjSE875ZOPpqCEpJVh7CAdb9iOlGYjRohS8Z
	QZt0GaxH61vTSriKOx8fh73AHgBC8OoDP7ocWVzl5zC2JPpCVg9MQWZXd1BTgPw2xcm5W/+cQtg
	5tentWH5h0g==
X-Google-Smtp-Source: AGHT+IFCEtJi1acsdkMP6HvSdiF2ahIRKFnhYDPlsGbqzrhCliAZKDVmgz2UPYzD2z28L9UHIpdGIIO3sSIx9A==
X-Received: from qtbfz20.prod.google.com ([2002:a05:622a:5a94:b0:463:5373:b17c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4408:b0:7b6:dd9c:fac1 with SMTP id af79cd13be357-7b6fbf3d9eemr1384086285a.49.1734285423298;
 Sun, 15 Dec 2024 09:57:03 -0800 (PST)
Date: Sun, 15 Dec 2024 17:56:28 +0000
In-Reply-To: <20241215175629.1248773-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241215175629.1248773-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215175629.1248773-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] inetpeer: update inetpeer timestamp in inet_getpeer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_putpeer() will be removed in the following patch,
because we will no longer use refcounts.

Update inetpeer timestamp (p->dtime) at lookup time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inetpeer.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index bc79cc9d13ebb4691660f51babbc748900b8f6db..28c3ae5bc4a0b62030bd190dbe5284632ea23efd 100644
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
@@ -224,11 +225,6 @@ EXPORT_SYMBOL_GPL(inet_getpeer);
 
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


