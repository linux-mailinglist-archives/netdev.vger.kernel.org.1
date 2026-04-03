Return-Path: <netdev+bounces-274850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHp0B1slz2notAYAu9opvQ
	(envelope-from <netdev+bounces-274850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3763905EC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBCC03019537
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A93331200;
	Fri,  3 Apr 2026 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CqBsiHG7"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797B348875
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183102; cv=none; b=LR8DvWUbqqDhTO7skl9xJbp+3VfqGF3cfgmNJIY85Qfuuy1uVip+O7w6DOn6Tqd0uAX+kUU+Z3oFpUjOZC8n5khoCypWKlrCfmYl+wJnaWL+a8pPT6ZJN8gdaCvc7LlhDNaa+WDipibEWc6nGwT8did6WjGJOjLLGCU2RWw5eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183102; c=relaxed/simple;
	bh=alk/kf4nEs2ekllBrJ9RY3OwJQL+zBhGjAetoSpxwD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jposrs5xXsrs3AEUmWJv+aqK3oJdl+3DZ+a14jOt/SANtb2ZmeuQqCKLAHFonDTIBeJ7xQ5uQobkGQWqC0NhnrqOb60mY2BsOfCDZ2KKEZe4ewC2sA3mqHM17WabEQNOwd59lEksVo9ApRomWssq2V19YFo8iXFy/IC7Lq4Qtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CqBsiHG7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1775183098;
	bh=MPEm3EcIKFZlWz1OSLnOAzWrEDlCM63fBdzJ9/rTvnA=;
	h=From:Date:Subject:To:Cc;
	b=CqBsiHG7xE/vGDYF+CeMCCrSXkK3v2X+xj1GvNvOh5283PBqlasY0JHhUm+WGDtf6
	 aT009Ol+inHMJGfdesR/Qap1vfKzJyxP1jVmqdt70eVZ4cL+B1eq5lKJI0wr8yaWel
	 YHAn3UOt1xVhBubwcZRvA16iOXdlvrJW+DvPPBkGuDIl2EOA3ohyWpH9eoVkaPsj8j
	 xh0LF0cf3M0qvbSQalAxqUpOBRHWWVJ5ZpIITbvms0SqzSWpquT8Z+SlQItIRKngnF
	 VWlDj2WQLjeLLftHOrgxn4kstQ3dgqO1tXaOgHD+C+19o6Xg7/aEKZWY2CL5ptrAd6
	 ojPbHq+Ge79Fg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id A260765FEE; Fri,  3 Apr 2026 10:24:58 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Apr 2026 10:24:51 +0800
Subject: [PATCH net-next] net: mctp: defer creation of dst after
 source-address check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-dev-mctp-dst-defer-v1-1-9c2c55faf9e9@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAPMkz2kC/yXM0QqCQBCF4VeRuW5gU4m1V4kubOdYE7TJ7iiC+
 O5tevlxOP9KGUmR6VqtlDBr1m8sOJ8qCq8+PsEqxVS7+uJa17Bg5k+wkSVbwYDEXQPvpfctpKN
 yHBMGXfbojSKMIxaj+7Hk6fFGsH+Ttu0HtJA3AYAAAAA=
X-Change-ID: 20260403-dev-mctp-dst-defer-93e88da84ed9
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274850-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid]
X-Rspamd-Queue-Id: 6F3763905EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reports:

> mctp_dst_from_route() increments the device reference count by calling
> mctp_dev_hold(). When a valid route is found and dst is NULL, the
> structure copy is bypassed and rc is set to 0.

Instead of optimistically creating a dst from the final route (then
releasing it if the saddr is invalid), perform the saddr check first.

This means we don't have an unuecessary hold/release on the dev, which
could leak if the dst pointer is NULL. No caller passes a NULL dst at
present though (so the leak is not possible), but this is an intended
use of mctp_dst_from_route().

Fixes: 22cb45afd221 ("net: mctp: perform source address lookups when we populate our dst")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 78263e7ae423..26fb8c6bbad2 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -897,7 +897,8 @@ static mctp_eid_t mctp_dev_saddr(struct mctp_dev *dev)
 
 /* must only be called on a direct route, as the final output hop */
 static void mctp_dst_from_route(struct mctp_dst *dst, mctp_eid_t eid,
-				unsigned int mtu, struct mctp_route *route)
+				mctp_eid_t saddr, unsigned int mtu,
+				struct mctp_route *route)
 {
 	mctp_dev_hold(route->dev);
 	dst->nexthop = eid;
@@ -907,7 +908,7 @@ static void mctp_dst_from_route(struct mctp_dst *dst, mctp_eid_t eid,
 		dst->mtu = min(dst->mtu, mtu);
 	dst->halen = 0;
 	dst->output = route->output;
-	dst->saddr = mctp_dev_saddr(route->dev);
+	dst->saddr = saddr;
 }
 
 int mctp_dst_from_extaddr(struct mctp_dst *dst, struct net *net, int ifindex,
@@ -975,7 +976,6 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 {
 	const unsigned int max_depth = 32;
 	unsigned int depth, mtu = 0;
-	struct mctp_dst dst_tmp;
 	int rc = -EHOSTUNREACH;
 
 	rcu_read_lock();
@@ -996,15 +996,15 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 			mtu = mtu ?: rt->mtu;
 
 		if (rt->dst_type == MCTP_ROUTE_DIRECT) {
-			mctp_dst_from_route(&dst_tmp, daddr, mtu, rt);
+			mctp_eid_t saddr = mctp_dev_saddr(rt->dev);
+
 			/* cannot do gateway-ed routes without a src  */
-			if (dst_tmp.saddr == MCTP_ADDR_NULL && depth != 0) {
-				mctp_dst_release(&dst_tmp);
-			} else {
-				if (dst)
-					*dst = dst_tmp;
-				rc = 0;
-			}
+			if (saddr == MCTP_ADDR_NULL && depth != 0)
+				break;
+
+			if (dst)
+				mctp_dst_from_route(dst, daddr, saddr, mtu, rt);
+			rc = 0;
 			break;
 
 		} else if (rt->dst_type == MCTP_ROUTE_GATEWAY) {

---
base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
change-id: 20260403-dev-mctp-dst-defer-93e88da84ed9

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>


