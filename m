Return-Path: <netdev+bounces-100136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ED28D7F16
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221FB285C23
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53F684DF6;
	Mon,  3 Jun 2024 09:37:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63D84DEA
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407455; cv=none; b=TRp+/X5oE2fuhI/nsHNJPJk1CHLTihxdeeATVKBkeOzUuo9FYZKVXtpnoZMimTol7azciOoRZQtL2INYI7uqRnNnDcBfT7dmR/9XjC7PdBLQR15E9T+o5YSPHi871usEgxcFN5xgQSpJbWe9HG7m66wnatjL+ELZ/RH+rj8+ZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407455; c=relaxed/simple;
	bh=q91sOcKYkFlNSQiAz2Kqema/+em7iOFBAJbt+YkbXew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px5I+gfXBWHEJpI1B8nASZHx8pgjTvuejW0GgOOkvBXir1Xt2KDyF8MVW9n3AK+FWdV5rvLZw4N6VcAULpFmPf6W0JASHgjYG7F+RjOHfNjlpKtrN1808iSfO7w5TEVyTxoACPnWbFyQAKaZMjoVVyDXG3gov+QrnKbQzDlETOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sE48C-00013G-D0; Mon, 03 Jun 2024 11:37:32 +0200
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
Subject: [PATCH net-next v6 3/3] tcp: move inet_twsk_schedule helper out of header
Date: Mon,  3 Jun 2024 11:36:12 +0200
Message-ID: <20240603093625.4055-4-fw@strlen.de>
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

Its no longer used outside inet_timewait_sock.c, so move it there.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
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
index 66d9b76595b7..13a66c0b6b2a 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -102,6 +102,11 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
 	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
+static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
+{
+	__inet_twsk_schedule(tw, timeo, false);
+}
+
 /*
  * Enter the time wait state. This is called with locally disabled BH.
  * Essentially we whip up a timewait bucket, copy the relevant info into it
-- 
2.44.2


