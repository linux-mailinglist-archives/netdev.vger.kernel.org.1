Return-Path: <netdev+bounces-276177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBL2Hj111WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E2C3B4F8C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F10B302E0CD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4737CD2D;
	Tue,  7 Apr 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GB0VwqBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0737D120
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596828; cv=none; b=pb03i6V8jzFqdYa2QibTe3uS5S8ahRAOkE4qp601LzhbCfC3GYh+TMKCHjkQ5Ma8PSvL0239sOoYuTG1ZgUDEanTiflw9OsjrBS8myIBH4mZG6Vk6tRf4UsaL11QXDZtNnJHIhxWBdKirquG6nHD89nOo7/gUuCJQJ4bxmOYXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596828; c=relaxed/simple;
	bh=bTQ2mlCxawXnmL+ThIaSTZnMS2nzDwLeaPO68Fc3H0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q4o1lKPSI74d5HSe9QF9rdAVtjybwzWTflRCjNMdyRtFa8cDnydQaULOjrOr2Fc99Hc+R/THvjvSohVW86OILzrDwU8MjU9kdXifTf6ASa2ObPqdd6l3XM3lrnjDbrLikREYCYla5O8hSkFuIXFgd0AbUBObsiKJXjvW13Blxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GB0VwqBw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c6929bd26so7062575b3a.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596826; x=1776201626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv9b4YiGBPnEsejWBXQzZLWNVqvFGfYl6wcecJpWEI4=;
        b=GB0VwqBw+AKIoJLvWnZaUfOeprAGZjOVL6ra1GMCzNTICiWG0PxIVE+pGAzAQYVfSl
         uGrOzffY4QYcZ/P80t+G8Agj3oLuIXKUL0R0T2K5PBVTc6/UVzXPEdsDRrNaxIq3Dssx
         gUPAYa0xySixEviLqCd18tQIw+yUhHDMxvOjiL3DLem7xsx5hoh/bV8EELK1sIY61vLd
         7gxrxfWxA1pgKk/mLnjc2Ktr503qbOUvAtu+37qyx9sEsIvpYteMj5lKSFFe5bVk5fld
         FfaZzrzJRwewCIA/y+BmdNiOUS95LXvzOB/B6bUZ/kvqBJPit1AE1hzjNb9YzdfNNK6O
         42qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596826; x=1776201626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv9b4YiGBPnEsejWBXQzZLWNVqvFGfYl6wcecJpWEI4=;
        b=EtjN7uZ7WtzKr1Go3fYAV1/X4pDI9EVuD2UKTWjJLh0ohw8T6+bYzM61/hSoY8p5Rn
         Q6oalEayJqqPq1XB2Sdpp8LXuZ6hrOG9VP+rq3620B1LCKAspPU2yj4UpgXqa2Yb38I7
         7LzBOgbRy0RdG7Td5PvO96G0ufPYpvzWjB6u40fxVFrqFF80b4MzvimOrAIssI98NsT1
         mQ6quk1ZGOTrB11+MudFvonz1uE9HCx/ZyYriH1U2F6MBZSxfEwXW7LcQ8LckAfYaFBD
         PfvwAF5I6sxYebOlZJHhiPe+OxeHfZy4P8+lAqB24YrhnEmwLDfXngY6dU1Yjs500MfE
         gB2A==
X-Forwarded-Encrypted: i=1; AJvYcCXB0KmBhMGlXnSIplLLMhL6EkSwS4fNh+8/xTwIrZW5Lbysct1ARQE9Gm/PJUjL18SFTtTxOFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMA0KDcAIQsicvUJ2ox+UlYzoFzadoZeClYbC22ECz85dkWnB
	aTlWAsxOfFSbVPBJ+LVM9nh2c9n4RbiZu+dTJMO1TKPYTeD/2zGI8mSZo6p7i4lgMCqIfj4O54a
	o1iR4fg==
X-Received: from pfcp1.prod.google.com ([2002:a05:6a00:a241:b0:82c:5b7c:f4ce])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab87:b0:82c:e227:e9c
 with SMTP id d2e1a72fcca58-82d0dbcf9eamr18824584b3a.51.1775596826340; Tue, 07
 Apr 2026 14:20:26 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:47 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-15-kuniyu@google.com>
Subject: [PATCH v3 net-next 14/15] ip6mr: Define net->ipv6.{ip6mr_notifier_ops,ipmr_seq}
 under CONFIG_IP_MROUTE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276177-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25E2C3B4F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net->ipv6.ip6mr_notifier_ops and net->ipv6.ipmr_seq are used
only in net/ipv6/ip6mr.c.

Let's move these definitions under CONFIG_IP_MROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e4288170f..df00567374f4 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -112,13 +112,13 @@ struct netns_ipv6 {
 	struct list_head	mr6_tables;
 	struct fib_rules_ops	*mr6_rules_ops;
 #endif
+	struct fib_notifier_ops	*ip6mr_notifier_ops;
+	atomic_t		ipmr_seq;
 #endif
 	atomic_t		dev_addr_genid;
 	atomic_t		fib6_sernum;
 	struct seg6_pernet_data *seg6_data;
 	struct fib_notifier_ops	*notifier_ops;
-	struct fib_notifier_ops	*ip6mr_notifier_ops;
-	atomic_t		ipmr_seq;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
-- 
2.53.0.1213.gd9a14994de-goog


