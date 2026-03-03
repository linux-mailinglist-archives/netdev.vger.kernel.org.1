Return-Path: <netdev+bounces-263019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG+NFy9SpmkbOAAAu9opvQ
	(envelope-from <netdev+bounces-263019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:14:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F11E85F6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F0C5305BF4D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429A37DEA9;
	Tue,  3 Mar 2026 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYQZQfIg"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9137DE9F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507646; cv=none; b=ZD8Fjj5rxgB7IiI+tQDP1wj/SWggf1uDy373ChVihQ5XP4XHSt7tdXTI66AvE9+tPx1W6fD2NqXHvgdRKWC9o234ZIcp5zXT7koxJcnQ+AXCrnTUkSWbasEMH89pcPPnVd1e8m13ncuLHrFiqat0zpf8xewpPL/IJfh5ks23+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507646; c=relaxed/simple;
	bh=6NgLZkrn/en76d0nf4FPpkbssd38IwZDwAUCw/j/LHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c562aS1A+tF3HVKhWCRg20p81ggk/sDs2Y1ZS0zbau2MUJxPtV3g5Qf2R4Z6CwJIPi58xcYxr9r47y2HDehd5trBHatvVcRWI422t9MbK7GPF/ZCoHG6N5cNECdbTxZQztvUZakdFwZyyTSEpRHGUG+9t+qbVINwcEhb2ei4gWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYQZQfIg; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772507643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI8iXclF7RaufctE1X5VYEFApryvJN02XwcHLb3hN8k=;
	b=LYQZQfIgcPqVW+hgP/MXBUMr+PIV43BVi1qQGRrcgjHbCVjk1baPhIJ60igB8nI9JZvGdc
	gmBtVGBdgRm98Ug3EIUekmNjOQ72yF1UNLJ3cQ24ryTtch3pQmIHg63yBfiVaD/opx7JYQ
	5791HlizcSHXsXRciA1nav6yX8eQAdQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuna.chen@linux.dev,
	jiayuna.chen@shopee.com,
	idosch@nvidia.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 1/2] net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
Date: Tue,  3 Mar 2026 11:13:14 +0800
Message-ID: <20260303031318.339716-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260303031318.339716-1-jiayuan.chen@linux.dev>
References: <20260303031318.339716-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1F6F11E85F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-263019-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,shopee.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

When a standalone IPv6 nexthop object is created with a loopback device
(e.g., "ip -6 nexthop add id 100 dev lo"), fib6_nh_init() misclassifies
it as a reject route. This is because nexthop objects have no destination
prefix (fc_dst=::), causing fib6_is_reject() to match any loopback
nexthop. The reject path skips fib_nh_common_init(), leaving
nhc_pcpu_rth_output unallocated. If an IPv4 route later references this
nexthop, __mkroute_output() dereferences NULL nhc_pcpu_rth_output and
panics.

Simplify the check in fib6_nh_init() to only match explicit reject
routes (RTF_REJECT) instead of using fib6_is_reject(). The loopback
promotion heuristic in fib6_is_reject() is handled separately by
ip6_route_info_create(). After this change, the three cases behave as
follows:

1. Explicit reject route ("ip -6 route add unreachable 2001:db8::/64"):
   RTF_REJECT is set, enters reject path, skips fib_nh_common_init().
   No behavior change.

2. Implicit loopback reject route ("ip -6 route add 2001:db8::/32 dev lo"):
   RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
   called. ip6_route_info_create() still promotes it to reject afterward.
   nhc_pcpu_rth_output is allocated but unused, which is harmless.

3. Standalone nexthop object ("ip -6 nexthop add id 100 dev lo"):
   RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
   called. nhc_pcpu_rth_output is properly allocated, fixing the crash
   when IPv4 routes reference this nexthop.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Fixes: 7dd73168e273 ("ipv6: Always allocate pcpu memory in a fib6_nh")
Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/ipv6/route.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c0350d97307e..fb588a351609 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3582,7 +3582,6 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	netdevice_tracker *dev_tracker = &fib6_nh->fib_nh_dev_tracker;
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev = NULL;
-	int addr_type;
 	int err;
 
 	fib6_nh->fib_nh_family = AF_INET6;
@@ -3624,11 +3623,10 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 
 	fib6_nh->fib_nh_weight = 1;
 
-	/* We cannot add true routes via loopback here,
-	 * they would result in kernel looping; promote them to reject routes
+	/* Only check RTF_REJECT, not fib6_is_reject(): the loopback
+	 * promotion heuristic is handled by ip6_route_info_create().
 	 */
-	addr_type = ipv6_addr_type(&cfg->fc_dst);
-	if (fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
+	if (cfg->fc_flags & RTF_REJECT) {
 		/* hold loopback dev/idev if we haven't done so. */
 		if (dev != net->loopback_dev) {
 			if (dev) {
-- 
2.43.0


