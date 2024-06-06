Return-Path: <netdev+bounces-101480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC88FF0AB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CABEB2C5BD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56587198833;
	Thu,  6 Jun 2024 15:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C64195982
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687093; cv=none; b=bTnDQWDqpEgCUPxc5KDU9VI03BsqGlVfv1Z0i61BzWOrSrf1QNdzoNBg+8sXwB/7OfSjJcN2704Ex62Lbf7ZwLQ1xe2oz3yRZONYdD6GSHII596D72KU2mxU9e0TdZNYVUJtBgi004je2lSRjkBySuCr5SOG6sfvJQA9grVgNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687093; c=relaxed/simple;
	bh=r58O1vU1y6fA5EiP6d5T0QdRKD24numImzlAs1MN+9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I52uI81ehK93eHE5N0U7XfCCfG8HWjdDcPvWXSOD4QZGPaL3YLwnVOeHXPabmS8KTj5C2YTe+dELiyhoGcly7Hfa1f4ZIZiz8aUUUTLYgycZSUcw9oWgPcjyMdBWgCtb1+JqqgWhvPrzq2JVF5olyT+la6/xoWG9B4nqTFgo34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sFEsU-0004Cj-Ff; Thu, 06 Jun 2024 17:18:10 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bigeasy@linutronix.de,
	vschneid@redhat.com
Subject: [PATCH net-next v8 3/3] tcp: move inet_twsk_schedule helper out of header
Date: Thu,  6 Jun 2024 17:11:39 +0200
Message-ID: <20240606151332.21384-4-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240606151332.21384-1-fw@strlen.de>
References: <20240606151332.21384-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its no longer used outside inet_timewait_sock.c, so move it there.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 No changes since last version.

 include/net/inet_timewait_sock.h | 5 -----
 net/ipv4/inet_timewait_sock.c    | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 5b43d220243d..f88b68269012 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -101,11 +101,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
 
-static inline void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
-{
-	__inet_twsk_schedule(tw, timeo, false);
-}
-
 static inline void inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo)
 {
 	__inet_twsk_schedule(tw, timeo, true);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index b2d97c816c99..337390ba85b4 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -92,6 +92,11 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
 	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
+static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
+{
+	__inet_twsk_schedule(tw, timeo, false);
+}
+
 /*
  * Enter the time wait state.
  * Essentially we whip up a timewait bucket, copy the relevant info into it
-- 
2.44.2


