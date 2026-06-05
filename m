Return-Path: <netdev+bounces-295562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3KdNxEqImp1TQEAu9opvQ
	(envelope-from <netdev+bounces-295562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:44:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 432636447EA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:44:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JmWnJ3wT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 214A03159796
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA929B78F;
	Fri,  5 Jun 2026 01:43:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12B248896
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:43:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623824; cv=none; b=bHJihyqNMgt3aWisgWPmD/5hpgy28iBs10aCvrKDF01jgIQ7u7GYsL9TgLqANZJ99p36CBh5FpTDQ36Fu+E0hzpWGzRh2RJwVm7Dgh154Bg2jKIs4WfZ7VXMEVUjJT9mbBRddyAtZ/gFJpHpmM6C/WdKMEkEXG0Ui/iC6+IICaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623824; c=relaxed/simple;
	bh=POCX/luQ74bLFaAzEt7GsC53FXksW1Gp1JHWey+4Dnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UbvTvgZ2rLo52wAAs7oxhe5s50V+6HhOkEOxZMwj7+1IC7dN2eV+v4nGyS/x5iim9IO6WpQfpJac1Kpj6swtI1cncrhXmS3H6IWzW9zvvapCyKUI9v4Lxn7v54xV/pPtOljMlb0+ki02V1uG2orT8GB/j9PbqfbjB0Ac0YbxEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmWnJ3wT; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842692bf60aso1977444b3a.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 18:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780623813; x=1781228613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/x5HRip2Kp59j/zU6/XZTTx4Pvu5aw0vss9ccMmg6o=;
        b=JmWnJ3wTptHmb1wGS4YYFpbfMndqQTfLrchC2paMsTbn9MAyzFmX+E6NqjT2TY3iQy
         u6Tk1k4TFQS2WxOdux7JlESkOqymrVqI0j1TfVmtZUoi3AhVMHoaEAbhmCIGfHPBz/Cf
         TMBYqUdwRQ4TG3keHsyocDZVHuu8zzkcSZYgF0U591dDTllq+dzhf1cJ5AGbrUcAFR5B
         5VbVwnj03o9Oty1KKkKXTis3jXbH8LYSF44YesDMxvMm3zCxEGL2JSOIyVHuxz22zX9d
         cZflwNfoRq3lNCug5RF/ALw1f+ZREmrav93/qoXad8qgNd76Bdl9m9PZwJHsBBAXBvWl
         FaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780623813; x=1781228613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/x5HRip2Kp59j/zU6/XZTTx4Pvu5aw0vss9ccMmg6o=;
        b=V4UzUO337y/WFvHk0m4sV//DoMDwNFD0SedK6VHBkT5WSxvPF5aVS5xLXwRhiqAqZg
         VEKC+hkLH7e5xiDDMvhQswuXyIkQjVt3J10J6M8ku9dhU7fhJrBO9cCy2MzuDpIDJK2q
         KwXNrNWhjrm5idLoNzJDXm0koIWcWSnhf8hmgSgrzOS0EN2g6ykbe+E53rDTaLlGY1wr
         k4EUJ59SIaglL6NjZ38NPdyb1wagGvPzZmenNGs57859KjEdpIi5vk/Uh2ec+SssSo5y
         VK4iXLX/479CO60YS4GU5TfZT8tKzcwOUk5/j5zSWsZk45SuOgFw/WXbTb6dY1c7e2dB
         MMww==
X-Forwarded-Encrypted: i=1; AFNElJ9b1DAO1E+NNEi+sY/EDqNgUdQjQ9RlPT6oj3vzY1v8IUG2VCT0lWYAa3PkLWm5FFaqQ8Zri2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZnXHoQr35BSkgZpxJmajeEGTNia8ggofElmspFxf7tUGfZQ9
	CxoxwqQvo9WPpG6RZqW326HfU8rgEaWCChTl0JnwPymTFTQVDuIb9n2ruefrNcQZgGkoUqn7VNQ
	NS1BcD5cHcnBRho7RMo3f7jdo1g==
X-Received: from pfva8.prod.google.com ([2002:a05:6a00:c88:b0:842:5989:fb63])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8d0:b0:842:77ab:35df with SMTP id d2e1a72fcca58-842b0e4c733mr1128059b3a.11.1780623812365;
 Thu, 04 Jun 2026 18:43:32 -0700 (PDT)
Date: Fri,  5 Jun 2026 10:43:18 +0900
In-Reply-To: <20260605014318.3890804-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605014318.3890804-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605014318.3890804-3-yuyanghuang@google.com>
Subject: [PATCH net-next v2 2/2] ipv4: igmp: annotate data-races around
 timer-related fields
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295562-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 432636447EA

/proc/net/igmp walks the multicast list locklessly under RCU and reads
timer-related fields (im->tm_running, im->reporter, im->timer.expires)
to print the timer state of multicast memberships. Concurrently, these
fields are modified under im->lock spinlock in timer management paths
(igmp_stop_timer(), igmp_start_timer(), and igmp_timer_expire()). Fix this
intentional lockless snapshot by annotating the lockless reads with
READ_ONCE() and the updates with WRITE_ONCE().

Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/igmp.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index fd0faf042fa6..b6337a47c141 100644
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
@@ -2963,6 +2963,7 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
 		struct ip_mc_list *im = v;
 		struct igmp_mc_iter_state *state = igmp_mc_seq_private(seq);
 		char   *querier;
+		int tm_running;
 		long delta;
 
 #ifdef CONFIG_IP_MULTICAST
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
2.54.0.1032.g2f8565e1d1-goog


