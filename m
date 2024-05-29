Return-Path: <netdev+bounces-99040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B528D386E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EED01F26444
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C81BC23;
	Wed, 29 May 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UtqdTFpc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ORkpN8SP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BD18EA8;
	Wed, 29 May 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990813; cv=none; b=e6W8IaFsqEb2G+AobPrUmMpd+/IxEAvMrG5k8KJP3vOAMsuSSFPv6eFDrEg1qdtQ7GlfqdcAsAu9/NrKtuiIaSrM5F998l55kSphEHR0y/JTXhoa9U+T/BoMCVBXFQ7OuDmPUrCkZQe//7+kmzWpFtGWNDqawDhiBL6nUEHwfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990813; c=relaxed/simple;
	bh=LHjrLTqNsBqOI9KQ44N+MxEcyGz5e9gq41v2r5ridhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gYwC6QTLqRFcHeLYc7M4mm1nFBushsb0xoid6PtZWzPbuyT5/nOat4DstKLxtCVhDRv0gcncrCF+MpZYXOIFwdvHkl0YOmTVOfioShekIpp+Ix9dmwSdZIoGS8ps9oQssmKJ83g+ZURH7JVM3g96HstG07RAW15hrrhePyo6xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UtqdTFpc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ORkpN8SP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2284220569;
	Wed, 29 May 2024 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716990808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sPjPzk4wyi7sRXpkeEQyWy4W8LtwOVHoR4RZWeLMTFM=;
	b=UtqdTFpcW50xt6d+aGWKqNwbhDhPdGPzea6l4M8NIm9/ETNC13rR4/XNJp1cu5PFh7Mcuz
	nPYk1WaKGhJtznz/UERA4Sa8JRCaP7s3aZUsm5fx6Haq2U+3GGfmzapoAKRH+7uK4IjDcM
	TU+y5mlgVeyin1mSr1+gRPmZL2eLWHE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716990807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sPjPzk4wyi7sRXpkeEQyWy4W8LtwOVHoR4RZWeLMTFM=;
	b=ORkpN8SPMxxAHj87C4Zf8tXD5By/Q51Jp9wG9ijglfvE2RNLK/oxVc78AnjgbnGXgd37Y4
	Tu6Qw8KYHGc1p5Ge82xTtdEnenVDka0H8puaENF6h6LFFyWKV2iPR1eEUJI4UtTSs8cpvc
	gW950GkJ4LHeJLzadPtwXEg4xBKi4ig=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06CB91372E;
	Wed, 29 May 2024 13:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hncxAVczV2YWVAAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Wed, 29 May 2024 13:53:27 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kui-Feng Lee <thinker.li@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH net] net/ipv6: Fix the RT cache flush via sysctl using a previous delay
Date: Wed, 29 May 2024 15:52:51 +0200
Message-Id: <20240529135251.4074-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lctl.data:url,suse.com:email];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

The net.ipv6.route.flush system parameter takes a value which specifies
a delay used during the flush operation for aging exception routes. The
written value is however not used in the currently requested flush and
instead utilized only in the next one.

A problem is that ipv6_sysctl_rtcache_flush() first reads the old value
of net->ipv6.sysctl.flush_delay into a local delay variable and then
calls proc_dointvec() which actually updates the sysctl based on the
provided input.

Fix the problem by removing net->ipv6.sysctl.flush_delay because the
value is never actually used after the flush operation and instead use
a temporary ctl_table in ipv6_sysctl_rtcache_flush() pointing directly
to the local delay variable.

Fixes: 4990509f19e8 ("[NETNS][IPV6]: Make sysctls route per namespace.")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

Note that when testing this fix, I noticed that an aging exception route
(created via ICMP redirect) was not getting removed when triggering the
flush operation unless the associated fib6_info was an expiring route.
It looks the logic introduced in 5eb902b8e719 ("net/ipv6: Remove expired
routes with a separated list of routes.") otherwise missed registering
the fib6_info with the GC. That is potentially a separate issue, just
adding it here in case someone decides to test this patch and possibly
run into this problem too.

 include/net/netns/ipv6.h |  1 -
 net/ipv6/route.c         | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 5f2cfd84570a..2ed7659013a4 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -20,7 +20,6 @@ struct netns_sysctl_ipv6 {
 	struct ctl_table_header *frags_hdr;
 	struct ctl_table_header *xfrm6_hdr;
 #endif
-	int flush_delay;
 	int ip6_rt_max_size;
 	int ip6_rt_gc_min_interval;
 	int ip6_rt_gc_timeout;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bbc2a0dd9314..f07f050003c3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6335,15 +6335,17 @@ static int rt6_stats_seq_show(struct seq_file *seq, void *v)
 static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net;
+	struct net *net = ctl->extra1;
+	struct ctl_table lctl;
 	int delay;
 	int ret;
+
 	if (!write)
 		return -EINVAL;
 
-	net = (struct net *)ctl->extra1;
-	delay = net->ipv6.sysctl.flush_delay;
-	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
+	lctl = *ctl;
+	lctl.data = &delay;
+	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
 	if (ret)
 		return ret;
 
@@ -6368,7 +6370,6 @@ static struct ctl_table ipv6_route_table_template[] = {
 	},
 	{
 		.procname	=	"flush",
-		.data		=	&init_net.ipv6.sysctl.flush_delay,
 		.maxlen		=	sizeof(int),
 		.mode		=	0200,
 		.proc_handler	=	ipv6_sysctl_rtcache_flush
@@ -6444,7 +6445,6 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
 	if (table) {
 		table[0].data = &net->ipv6.sysctl.ip6_rt_max_size;
 		table[1].data = &net->ipv6.ip6_dst_ops.gc_thresh;
-		table[2].data = &net->ipv6.sysctl.flush_delay;
 		table[2].extra1 = net;
 		table[3].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
 		table[4].data = &net->ipv6.sysctl.ip6_rt_gc_timeout;
@@ -6521,7 +6521,6 @@ static int __net_init ip6_route_net_init(struct net *net)
 #endif
 #endif
 
-	net->ipv6.sysctl.flush_delay = 0;
 	net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
 	net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
 	net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;

base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
-- 
2.35.3


