Return-Path: <netdev+bounces-300401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FzMrBTrMM2rEGQYAu9opvQ
	(envelope-from <netdev+bounces-300401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:45:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7369F78B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:45:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=kktMerFg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300401-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300401-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60F76301FB0A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196A39936D;
	Thu, 18 Jun 2026 10:44:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F23ED3C7
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:44:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779447; cv=none; b=tRpibzHsPSMDXtLLkhRlOvi8aXY9mSGeaxzzsxfnsVvwsS7lx4Vuc5m8H68Q5tZKchhNGllafj7xSWhhPCEp2ru8eopsPdTYIbOFxNlIS7pBg/WljyoFkejr7w34Fg7fj09XCbdqCJoHgk21VerSqito4/IL+X1NoGsQfeexbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779447; c=relaxed/simple;
	bh=ucjYGr8pNKEHaj+rF0Gag5G2k8FsAe4TroNxCrJmkKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bT1chDMGO6KpXNYqGlQAXZwTxOPsYaf1z73B9cMdBDDZKSq8/7aQDrEy/PfDo4S61+q6yS22xy/x7tSU4E/dEfZeK2bUdToIAZCp4nVpiAN+l//aQ+nDxRxkkhwfYTEo1S/ZfY++E5FSL9hn5B6o/3OpwTGSCXx2rSwSIi4IBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kktMerFg; arc=none smtp.client-ip=91.218.175.177
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781779433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4m+QIolsijUmNZ+eK6O0c5+dFdyhuN4Lg53Q00/bIs0=;
	b=kktMerFgSqNkyayoMsTczD/iYMYE4mh+Bwyi8c86nVy1QYAuVFjbnaMkDEXv6JmvJL0iEs
	szlIfld9QGgyjHNgb0YEkUH8d8dba8WcVd5k+YBfZNT+lUfdTqrBc3H0gyu3RYSrOsEMxB
	haeYSpxP7eHExtpd1z8GD3UX5frccwY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Justin Iurman <justin.iurman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ipv6: ioam: fix type confusion of dst_entry
Date: Thu, 18 Jun 2026 18:43:35 +0800
Message-ID: <20260618104336.48934-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300401-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiayuan.chen@linux.dev,m:justin.iurman@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79C7369F78B

IOAM uses a dummy dst_entry(null_dst) to mark that the destination should
not be changed after the transformation. This dst is stored in the IOAM lwt
state and may be passed to dst_cache_set_ip6().

However, the IPv6 dst cache path eventually calls rt6_get_cookie(), which
treats the dst_entry as part of a struct rt6_info. Since the null_dst was
embedded directly as a struct dst_entry in struct ioam6_lwt, this resulted
in an invalid cast and rt6_get_cookie() reading fields from the wrong
object.

In practice, the wrong cookie is not used while dst->obsolete is zero, but
rt6_get_cookie() may also access per-cpu value when rt->sernum is
zero. In this case, rt->sernum aliases ioam6_lwt::cache::reset_ts, which
can become zero, making this a potential invalid pointer access.

Fix this by embedding a full struct rt6_info for the dummy IPv6 route and
passing its dst member to the dst APIs.

Fixes: 47ce7c854563 ("net: ipv6: ioam6: fix double reallocation")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/ioam6_iptunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index b9f6d892a566..cfb2c41634a0 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -35,7 +35,7 @@ struct ioam6_lwt_freq {
 };
 
 struct ioam6_lwt {
-	struct dst_entry null_dst;
+	struct rt6_info null_rt;
 	struct dst_cache cache;
 	struct ioam6_lwt_freq freq;
 	atomic_t pkt_cnt;
@@ -176,7 +176,7 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	 * it is stored in the cache. Then, +1/-1 each time we read the cache
 	 * and release it. Long story short, we're fine.
 	 */
-	dst_init(&ilwt->null_dst, NULL, NULL, DST_OBSOLETE_NONE, DST_NOCOUNT);
+	dst_init(&ilwt->null_rt.dst, NULL, NULL, DST_OBSOLETE_NONE, DST_NOCOUNT);
 
 	atomic_set(&ilwt->pkt_cnt, 0);
 	ilwt->freq.k = freq_k;
@@ -360,7 +360,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	/* This is how we notify that the destination does not change after
 	 * transformation and that we need to use orig_dst instead of the cache
 	 */
-	if (dst == &ilwt->null_dst) {
+	if (dst == &ilwt->null_rt.dst) {
 		dst_release(dst);
 
 		dst = orig_dst;
@@ -429,7 +429,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		local_bh_disable();
 		if (orig_dst->lwtstate == dst->lwtstate)
 			dst_cache_set_ip6(&ilwt->cache,
-					  &ilwt->null_dst, &fl6.saddr);
+					  &ilwt->null_rt.dst, &fl6.saddr);
 		else
 			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
 		local_bh_enable();
-- 
2.43.0


