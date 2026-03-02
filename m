Return-Path: <netdev+bounces-262489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBhGFCYcpWnk3QUAu9opvQ
	(envelope-from <netdev+bounces-262489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:12:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989E1D309E
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645D43015866
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F930ACF6;
	Mon,  2 Mar 2026 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zo1QAmdZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3530DED1
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428309; cv=none; b=EUK35NwzzjyQu0qJTGkLaFcyrP4daYeC4xcm1vunsOZl1oElRBC2BUZ99xUQIcFnozElaOoY9Z340uMHycGj/REu/zIu+4tf2gfp9ICmhafPtD3PgCXJVX5z4dzCXlsCPyaDNlIknceVvBxKG9RGOZ8qyBiNhUc0kdbfgl9saKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428309; c=relaxed/simple;
	bh=/epSusqq4ZWuN2AJqvX91RNkPtenbZTweDk+VJmMwHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/l2nm9RdXC07wr8kFpQGKKLxar1YxfyQRqg92kxVELmflPnIN0F2EUIDUYM5KIHO9zxl9ikT//8qf7ADDDwnFDDIwJqqW2wRZLrjudsAJa7nZegsO1Sv8AZrT9mvJhlXrPm6J4ZTiPpoiB54ZCKLHdS/La3896UmLkH+h+pnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zo1QAmdZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772428305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zp7u137EsEbeq0EDvtGdC2HHkGhw0fCgkPHcpfQWt0=;
	b=Zo1QAmdZFmQdOIcPPRozS/GIEDgfIGETvX7sHmvzWEfiUfU3dcCpgTDlZx7JxNbzZXZ0bi
	OFVpNVveoSoqiCTiXSl60PBUygwB+BzGPXqBf0YeD2z4VulehM6TcKuJaWZDbJqEjb1sUP
	SkpAGtbl/S+43QetK2UooX8mMhSue6g=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	dsahern@kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 1/2] net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
Date: Mon,  2 Mar 2026 13:11:28 +0800
Message-ID: <20260302051132.66314-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260302051132.66314-1-jiayuan.chen@linux.dev>
References: <20260302051132.66314-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-262489-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,shopee.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 6989E1D309E
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

The reject classification was designed for regular IPv6 routes to prevent
kernel loopback loops, but nexthop objects should not be subject to this
check since they carry no destination information - loop prevention is
handled separately when the route is created.

An alternative approach of unconditionally calling fib_nh_common_init()
for all reject routes was considered, but on large machines (e.g., 256
CPUs) with many routes, this wastes significant memory since
nhc_pcpu_rth_output allocates a per-CPU pointer for each route.

Since fib6_nh_init() is shared by multiple callers (route creation,
nexthop object creation, IPv4 gateway validation), using fc_dst_len to
implicitly distinguish nexthop objects would be fragile. Add an explicit
fc_is_nh flag to fib6_config to clearly identify nexthop object creation
and skip the reject check for this path.

Fixes: 7dd73168e273 ("ipv6: Always allocate pcpu memory in a fib6_nh")
Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 include/net/ip6_fib.h | 1 +
 net/ipv4/nexthop.c    | 1 +
 net/ipv6/route.c      | 8 +++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 88b0dd4d8e09..7710f247b8d9 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -62,6 +62,7 @@ struct fib6_config {
 	struct nlattr	*fc_encap;
 	u16		fc_encap_type;
 	bool		fc_is_fdb;
+	bool		fc_is_nh;
 };
 
 struct fib6_node {
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7b9d70f9b31c..efad2dd27636 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2859,6 +2859,7 @@ static int nh_create_ipv6(struct net *net,  struct nexthop *nh,
 	struct fib6_config fib6_cfg = {
 		.fc_table = l3mdev_fib_table(cfg->dev),
 		.fc_ifindex = cfg->nh_ifindex,
+		.fc_is_nh = true,
 		.fc_gateway = cfg->gw.ipv6,
 		.fc_flags = cfg->nh_flags,
 		.fc_nlinfo = cfg->nlinfo,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c0350d97307e..347f464ce7fe 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3628,7 +3628,13 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	 * they would result in kernel looping; promote them to reject routes
 	 */
 	addr_type = ipv6_addr_type(&cfg->fc_dst);
-	if (fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
+	/*
+	 * Nexthop objects have no destination prefix, so fib6_is_reject()
+	 * will misclassify loopback nexthops as reject routes, causing
+	 * fib_nh_common_init() to be skipped along with its allocation
+	 * of nhc_pcpu_rth_output, which IPv4 routes require.
+	 */
+	if (!cfg->fc_is_nh && fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
 		/* hold loopback dev/idev if we haven't done so. */
 		if (dev != net->loopback_dev) {
 			if (dev) {
-- 
2.43.0


