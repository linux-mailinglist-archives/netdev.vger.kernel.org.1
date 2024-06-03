Return-Path: <netdev+bounces-100135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E008D7F14
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ACB1F22886
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD6284D07;
	Mon,  3 Jun 2024 09:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA584D3C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407451; cv=none; b=k0MU8St9bHjtsCIEDx21DFxPY6DfzT/bxUVX8thpK6JaVm7ZaEKgoe1rxlUE/bYgnggOCqpGSlhCqIAMu8pppBVlK5WMlKccGn76KFa+6H6bCWJz0c23O3uSRRVImjUkWI8njBhe3YCgptXc9OE3IzXHWMGZYDu3QI/yWHxCZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407451; c=relaxed/simple;
	bh=gsmyQIjO+w7dxCugBlO3h+RZ/0LlWj06uqNxID2B+vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVmDkkpNxjG8jkxu6PYKOR1pDUfistWyf66eM61eRdHOoNpMsVhbvElBWOW84s763J7c4uk4v3U3G89YCDHgyn6PVpfk+oo6tHrGk+wa99rFVmJr5dcKPIhafZ4cmvXns0HU7ASJU9g0tJdWBjRfAIQ/Ho7O9l3DEW/4EdxGA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sE488-00012y-As; Mon, 03 Jun 2024 11:37:28 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mleitner@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	tglozar@redhat.com,
	dsahern@kernel.org,
	bigeasy@linutronix.de,
	tglx@linutronix.de
Subject: [PATCH net-next v6 2/3] net: tcp: un-pin the tw_timer
Date: Mon,  3 Jun 2024 11:36:11 +0200
Message-ID: <20240603093625.4055-3-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240603093625.4055-1-fw@strlen.de>
References: <20240603093625.4055-1-fw@strlen.de>
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
 net/ipv4/inet_timewait_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 2b1d836df64e..66d9b76595b7 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -213,7 +213,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
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


