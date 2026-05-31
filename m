Return-Path: <netdev+bounces-293376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w662EgmmG2p8FAkAu9opvQ
	(envelope-from <netdev+bounces-293376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 05:07:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C832C61445C
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 05:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDB363016C5D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 03:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA5344036;
	Sun, 31 May 2026 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFxu6+Wj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B53612ED
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780196838; cv=none; b=GvdsAgcnxU/mmvGFbbD7EI1vKmG+tP6E1dR7sDEEoWMvhzOijyWAgIX/jFGPWM+64JrN/2eMf6g70kZDRrgE7/rdoIekDj2lSPGBV//MN73hQ/YPCSWJG73XIEdq4RbLnm3AdUchyVk0OG0U8FueAnCFpbIoZtsBSwZNqsuW9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780196838; c=relaxed/simple;
	bh=r7jHWy3rqTxJY1sKvw/JEXrPrLy0VTqs8er4fh0Y210=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bNi+/HhRyi77KemfK0g9KG1yZef91n2WmCn0HViafIiF9tcW/dYsbky/5ZpyHLSM5UphkSm896ZG0SBIplaEHkVVXHZfPgnDgchx6Tkou/3od01hvf7fPZvfUtMRYt8BuXhnna/5Sz/u4A2GbCRN3njktV3rgFs9WGmiyFiDrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFxu6+Wj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf281d523eso8762235ad.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 20:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780196836; x=1780801636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XGHTHkWccB92iEs3+aiLHcXw/qjbvnaI33XklcMc4g=;
        b=lFxu6+WjxTmqqQDMDLgtViXgpXCmWHviH/Ol9+WVi6Ai7c4aR+TwOo05WHYb154eSC
         H9hU4hr2foLa/21ORuM47T54qVu0AiQOmVNgnFyfEck5FJVgOkMWgVq64HqAr2aY8qqH
         cXd0e+gLFGGUt5oMUsx8aaMglG4y4z8s83UTt2FAqvsqeiG6NUIRwjRimxFHf9Av9R7a
         WlSOPwgJtdt5XI6e1SB/gnNqoy8J39lAdpk73XFIRlizn2PMQ5iDmnwtfMTrsyCbd0Oh
         Sgg5QUrlg+x4J0oT3sBBE+Fs1QLA+1awnt7N0S7htf7cp+L27Z5itkfDbnW38zipKtJA
         H7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780196836; x=1780801636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XGHTHkWccB92iEs3+aiLHcXw/qjbvnaI33XklcMc4g=;
        b=LrDY6z1OG8qfleTl3cALPGUK+zgKDvO2ocap/HFaYe7vx5iVm8DeuDHj7NGgqFgUeN
         sI6Sj2DRErQNbfk/J+R+3oZdteF4YYIqTC49GOhyYaABHNLvDVURC6CcEBdv/FOSfxqf
         B+jwYViPaXHlQ5DciyKva7P2hxXaGHpo/76Pj5FzKJ2PG4byM9KY1qbX22Rh2dSsmZQ1
         7tDSExyAIsbNDujwTHqY2ZiuFhXVhuiUOGj1uxYit9MCXVSquB6BOMr8M8fX+5k+UhRz
         zhUuH9Peuw/+uu97ddiUoHvXoDMCRSnncFndRR0OHnrMkpqKUJnkRngQI9C7JfV4319Z
         E+YQ==
X-Forwarded-Encrypted: i=1; AFNElJ++ZMfIjgFoqh3OcnZo/Hy8sV8NLKXRlwE9BE68XJ5ESX1y6dyG9zrxq1pptnbrbW+hIcNlHGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHC58cWbxPwmwcGFrYIxfwK9G7ipUuEgBBjI/96tF58UWHGRX
	bjJeqjlTtZW40sq+O2WEWFjIlrb0dT1OiciGiGWijDnovcmlcnLj++B//00/c1Qi7N4wCdehz0V
	L9wNnTqS7GkucAj0TXdYns33JiQ==
X-Received: from plnz4.prod.google.com ([2002:a17:902:8344:b0:2bf:1748:aa9b])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c9:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2bf36370f35mr67308815ad.0.1780196835789;
 Sat, 30 May 2026 20:07:15 -0700 (PDT)
Date: Sun, 31 May 2026 11:07:04 +0800
In-Reply-To: <20260531030705.3754389-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531030705.3754389-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531030705.3754389-3-yuyanghuang@google.com>
Subject: [PATCH 2/2] ipv4: igmp: annotate data-races around timer-related fields
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-293376-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C832C61445C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

/proc/net/igmp walks the multicast list locklessly under RCU and reads
timer-related fields (im->tm_running, im->reporter, im->timer.expires)
to print the timer state of multicast memberships. Concurrently, these
fields are modified under im->lock spinlock in timer management paths
(igmp_stop_timer(), igmp_start_timer(), and igmp_timer_expire()). Fix this
intentional lockless snapshot by annotating the lockless reads with
READ_ONCE() and the updates with WRITE_ONCE().

Fixes: 1d7138de878d ("igmp: RCU conversion of in_dev->mc_list")
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/ipv4/igmp.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index fd0faf042fa6..1e958027068b 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -220,8 +220,8 @@ static void igmp_stop_timer(struct ip_mc_list *im)
 	spin_lock_bh(&im->lock);
 	if (timer_delete(&im->timer))
 		refcount_dec(&im->refcnt);
-	im->tm_running = 0;
-	im->reporter = 0;
+	WRITE_ONCE(im->tm_running, 0);
+	WRITE_ONCE(im->reporter, 0);
 	im->unsolicit_count = 0;
 	spin_unlock_bh(&im->lock);
 }
@@ -231,7 +231,7 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 {
 	int tv = get_random_u32_below(max_delay);
 
-	im->tm_running = 1;
+	WRITE_ONCE(im->tm_running, 1);
 	if (refcount_inc_not_zero(&im->refcnt)) {
 		if (mod_timer(&im->timer, jiffies + tv + 2))
 			ip_ma_put(im);
@@ -267,7 +267,7 @@ static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
 	if (timer_delete(&im->timer)) {
 		if ((long)(im->timer.expires-jiffies) < max_delay) {
 			add_timer(&im->timer);
-			im->tm_running = 1;
+			WRITE_ONCE(im->tm_running, 1);
 			spin_unlock_bh(&im->lock);
 			return;
 		}
@@ -857,12 +857,12 @@ static void igmp_timer_expire(struct timer_list *t)
 	struct in_device *in_dev = im->interface;
 
 	spin_lock(&im->lock);
-	im->tm_running = 0;
+	WRITE_ONCE(im->tm_running, 0);
 
 	if (im->unsolicit_count && --im->unsolicit_count)
 		igmp_start_timer(im, unsolicited_report_interval(in_dev));
 
-	im->reporter = 1;
+	WRITE_ONCE(im->reporter, 1);
 	spin_unlock(&im->lock);
 
 	if (IGMP_V1_SEEN(in_dev))
@@ -1325,7 +1325,7 @@ static void __igmp_group_dropped(struct ip_mc_list *im, gfp_t gfp)
 	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 		return;
 
-	reporter = im->reporter;
+	reporter = READ_ONCE(im->reporter);
 	igmp_stop_timer(im);
 
 	if (!in_dev->dead) {
@@ -2964,6 +2964,7 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
 		struct igmp_mc_iter_state *state = igmp_mc_seq_private(seq);
 		char   *querier;
 		long delta;
+		int tm_running;
 
 #ifdef CONFIG_IP_MULTICAST
 		querier = IGMP_V1_SEEN(state->in_dev) ? "V1" :
@@ -2980,13 +2981,14 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
 				   querier);
 		}
 
-		delta = im->timer.expires - jiffies;
+		tm_running = READ_ONCE(im->tm_running);
+		delta = READ_ONCE(im->timer.expires) - jiffies;
 		seq_printf(seq,
 			   "\t\t\t\t%08X %5d %d:%08lX\t\t%d\n",
 			   im->multiaddr, READ_ONCE(im->users),
-			   im->tm_running,
-			   im->tm_running ? jiffies_delta_to_clock_t(delta) : 0,
-			   im->reporter);
+			   tm_running,
+			   tm_running ? jiffies_delta_to_clock_t(delta) : 0,
+			   READ_ONCE(im->reporter));
 	}
 	return 0;
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog


