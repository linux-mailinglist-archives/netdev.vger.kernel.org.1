Return-Path: <netdev+bounces-100608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D948FB4E0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B11F1C22425
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31793CF74;
	Tue,  4 Jun 2024 14:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916584055
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510301; cv=none; b=j5E8JUYKTVc96KP3I248tvNoeqMCzy/Nx7GIj6pAHjxzF0SqQZztbQNPUJ7/lbEM06MJDWTNqEd6opBcNWOfZGB9S+EX4OxKyYPbKGEoyfuu01QFOcPXlG1jFTFeVvbbXMWBob3UznUW63Ti4XIqvmHvi3JnmjiBwVSXcVeaUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510301; c=relaxed/simple;
	bh=O8zCPgUf2OG/q4RG+mMzSgXzSLqYSMND9IPGvCwxRE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQdsV1kMFX6I5F9xIuP2l/EToOOvHrLhLwgBpdWu1mF9C1LAqWwMyyokqcxnhy5AjgC+lBj5rMD5yE1f/FYYql39JeeUG3eqhxn1hRkKrspvhKHydEPW4F5A+oEkCbjuJi0WflDEAP29iqVhoeglWyPSPBFH7EdZtJAaFM+nd7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sEUsx-0002Hm-Sm; Tue, 04 Jun 2024 16:11:35 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	vschneid@redhat.com,
	tglozar@redhat.com,
	bigeasy@linutronix.de,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v7 2/3] net: tcp: un-pin the tw_timer
Date: Tue,  4 Jun 2024 16:08:48 +0200
Message-ID: <20240604140903.31939-3-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240604140903.31939-1-fw@strlen.de>
References: <20240604140903.31939-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After previous patch, even if timer fires immediately on another CPU,
context that schedules the timer now holds the ehash spinlock, so timer
cannot reap tw socket until ehash lock is released.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 no changes.

 net/ipv4/inet_timewait_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 628d33a41ce5..3e89b927ee61 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -203,7 +203,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
+		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
-- 
2.44.2


