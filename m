Return-Path: <netdev+bounces-293031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNt9MmhFGWrzuAgAu9opvQ
	(envelope-from <netdev+bounces-293031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6865FECEE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840153232632
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28303AFCF5;
	Fri, 29 May 2026 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="F237WIcV"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DA33F5A4;
	Fri, 29 May 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040731; cv=none; b=YJT+9OOyS4K377QAKAFk2eBqp9LhjipP5S4goHrlkWjLslVAkc2ofhJRTOmsG5GnEgvz3bRfjDYSyhkgFSTEhsiqXsx/KaO33bqCkIG17O8AVKzNg9fyq/gjF9dzTu5Hw+PUWqazQmwe8LfwJbeTChDbyOtfBP8CGm44bUUBdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040731; c=relaxed/simple;
	bh=mEM95G3WNy6plziLguYpsnPOf7PAIL0711uhgZK4fMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxdRGKQT4O4M62I9yU7V6TayjVHAXlbGitU3Cn1WMPSQSkViu24EiiHBdTfulbC/MwerQ/LTcrqiY2rp9ScMhcVSYXXw1ypYo86sZrLgFOJ5fnHxaZcuKEcmd9SM81nlnX7bORzbytevxR46YM/bXfKPbcKSc5b1Siod4400QKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=F237WIcV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Y2P1ayzVY7FwXmEpq+5FJne3BKpnMFMzUXsWtT6mEVY=; b=F237WIcV+KEddYQm8+bL3fQgQm
	YfiVTG72OVAKiDnUh/A+nhE/5LANGS3glUsyWwktOhew4/SqZ3JiO/KdgxOAcaDGHDHzYSDcoiX7x
	vyQSR7J8O0U2PHTz0sx4dwCZhKDDLtsrz0ITkTzq1D5d3AgHKB+/trLpnvcYhqjBo2NUGHZSPAh7j
	maUqdLGkB/O2o6nABbkEb91B3ZVjE8wDZXIumyGcpIwWRzaLpfETy3fEhjKgKPN1UhHU/Ysg5vUSQ
	JQre4Vq5UGDjLgyONoyVI24szXvquoHsbKBMGyMnWWvIdLHf083Q/iaQYjyfK45TWu5ZPAw4+ez12
	bdrPnfvA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSruD-004kM5-1g;
	Fri, 29 May 2026 07:45:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 29 May 2026 03:45:12 -0400
Subject: [PATCH net 2/3] netconsole: do not dequeue pooled skbs that cannot
 satisfy len
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-netcons_fix_before_move-v1-2-cb2d1426dd75@debian.org>
References: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
In-Reply-To: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neil Horman <nhorman@tuxdriver.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4366; i=leitao@debian.org;
 h=from:subject:message-id; bh=mEM95G3WNy6plziLguYpsnPOf7PAIL0711uhgZK4fMw=;
 b=owEBbQKS/ZANAwAKATWjk5/8eHdtAcsmYgBqGUQMSS85VJvrhxKGQlisDTMktYQdRMPcdjnHI
 qZRT0b01mSJAjMEAAEKAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahlEDAAKCRA1o5Of/Hh3
 bfp1EACPmTE08kNbFONb4I4Gr8l+veHNfFq7Tg4A8uyIaxgk50m5PCVvEAhcYZsWHDAWMcSqGU3
 /Z3IXKbPe1Fr8R0EInMtREyn+snbQJ3a4I4zCodul0AxJq+0ErjzwyKbvildSLxOVwXomwCi/SS
 eNbWklgXxRYnP4eh41g3lUGCcAFO1Qqw8rM0f4epezgSMvrt7xEoYotzRjguG3pqYfHfyrJVEXZ
 ZpYd4XRRZo9FR8h7Iw5LskegTkKFu5u5TfVlR/1EFYYShBkd6yUq12wmiexV0vaZ4CQvauS5ae2
 sHRVEA1SeGPqfGiuPRE7rfVnO1ZPehbL5EJTwGbPKaYgT1uCojziUsnwwRhEtGXUvE3knrZjGA6
 5ufFsT2/6QTHqXtNGiH1sug+IBq/PjF2kO8vuJUS87THets36/6smIjk8UKa3O3c2yUht8YS2X0
 kQ/naZvCVQvmjoB2VCe0tR115k3KJO8ykzNkWni5u3ZQ1e59ZXF1+E1v42AActj0ltAXqb4+j5O
 C8sdBnKijxUe59xuvMPVCpPbDXHvS02svg3L441o/Q8UgxnRTN5TUMBUJnEhqPtJc7Bs7T1odB2
 dfdJikbcW+KKCiQj2sCKI2m2P7S9HCrPikKj9sBULZ7kWQEsfwb29Msts5FvUDVEFRl1UFHeg6Y
 24nRM2Hbn34UJNw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293031-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,tuxdriver.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2D6865FECEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

find_skb() falls back to np->skb_pool when the GFP_ATOMIC alloc_skb()
fails. The pool is refilled by refill_skbs(), which always allocates
buffers of MAX_SKB_SIZE (ethhdr + iphdr + udphdr + MAX_UDP_CHUNK ==
1502 bytes).

netconsole, however, computes the requested length dynamically as

        total_len + np->dev->needed_tailroom

If the egress device declares a non-zero needed_tailroom (e.g. some
tunnel or hardware accelerator devices), the required length can exceed
MAX_SKB_SIZE. The pooled skb is then handed back to the caller, which
immediately performs skb_put(skb, len), trips the tail > end check, and
triggers skb_over_panic().

Leave the normal alloc_skb(len, GFP_ATOMIC) path untouched -- the slab
allocator can still satisfy oversized requests when memory is available,
so senders to devices with non-zero needed_tailroom keep working in the
common case. Only the pool fallback is gated: when alloc_skb() failed
and len exceeds the pool buffer size, skip the skb_dequeue() instead of
burning a pre-allocated skb on a request that would later trip
skb_over_panic(). Reserving pool entries for requests they can actually
satisfy also keeps the panic path, which depends on the pool being
primed, intact.

When that drop happens, emit a rate-limited net_warn() so the user
notices that netconsole is unable to push messages on the egress device.
The warn is skipped under in_nmi() for the same reason schedule_work()
is: printk machinery taken by net_warn_ratelimited() is not NMI-safe and
would risk recursing into the same nbcon console we are servicing.

MAX_SKB_SIZE / MAX_UDP_CHUNK were private to net/core/netpoll.c. Move
them to include/linux/netpoll.h so netconsole can reference the same
definition that refill_skbs() uses, keeping the two in sync by
construction. The header now pulls in <linux/ip.h> and <linux/udp.h>
explicitly so MAX_SKB_SIZE remains self-contained for any future user.

Fixes: 954fba027405 ("netpoll: fix netpoll_send_udp() bugs")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c |  7 ++++++-
 include/linux/netpoll.h  | 16 ++++++++++++++++
 net/core/netpoll.c       |  7 -------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 699bdfa1fb45..a3dcbe713a0b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1680,8 +1680,13 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb)
+	if (!skb) {
+		/* The pool is refilled with MAX_SKB_SIZE buffers */
+		if (WARN_ON_ONCE(len > MAX_SKB_SIZE))
+			return NULL;
+
 		skb = netcons_skb_pop(np);
+	}
 
 	if (!skb) {
 		if (++count < 10) {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index e4b8f1f91e54..88f7daa8560e 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -13,12 +13,28 @@
 #include <linux/rcupdate.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
 
 union inet_addr {
 	__be32		ip;
 	struct in6_addr	in6;
 };
 
+/*
+ * Maximum payload netpoll's preallocated skb pool can carry. Keep this in
+ * sync with the buffer size used by refill_skbs() in net/core/netpoll.c;
+ * callers (e.g. netconsole) use it to detect requests the pool can never
+ * satisfy and avoid dequeuing a pooled skb that would later trip
+ * skb_over_panic() in skb_put().
+ */
+#define MAX_UDP_CHUNK	1460
+#define MAX_SKB_SIZE						\
+	(sizeof(struct ethhdr) +				\
+	 sizeof(struct iphdr) +					\
+	 sizeof(struct udphdr) +				\
+	 MAX_UDP_CHUNK)
+
 struct netpoll {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index b3fe59445f2d..229dde818ab3 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -41,16 +41,9 @@
  * message gets out even in extreme OOM situations.
  */
 
-#define MAX_UDP_CHUNK 1460
 #define MAX_SKBS 32
 #define USEC_PER_POLL	50
 
-#define MAX_SKB_SIZE							\
-	(sizeof(struct ethhdr) +					\
-	 sizeof(struct iphdr) +						\
-	 sizeof(struct udphdr) +					\
-	 MAX_UDP_CHUNK)
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 

-- 
2.51.0


