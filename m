Return-Path: <netdev+bounces-276680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFl5NHui1mlUGwgAu9opvQ
	(envelope-from <netdev+bounces-276680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A9C3C1799
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EFA930EA6FE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5DB3B0ADA;
	Wed,  8 Apr 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="U1H9nldK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35423537EF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672938; cv=none; b=VEVaqOhCLS9mZlzSSuQE19CyXX5FgHdkh0RjZXAzSEGJA03vztdvQgF/Pu+RNE70hQuRehHzxl1t0cKT/JCO+mEW4OO1t5cvo8VLPM4VZEyMX+4Qq/aalcTMYtS4eiuV1caOJ08JVB3bqP8iq7CtlegbPGiscLv6SGmlbs1QxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672938; c=relaxed/simple;
	bh=SGDfiZOrq6eTuVnrv85EUrpQzLjCKY6D/wmUS6pMUDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRML1pFlBU4zh1NC0DD4YmKUvG1izJn3nVoXKzaK9x7lFvUH3suZePrHUcHRWwVjm0enhIliiamaB0DnV+UP0n7WAAp9hHw9By70zQav9BFgAmFjfLhXkNAZyahu5e6w8Wfhw/Zic/5pVEXrBnoIvvuNI99bV1k3G6f9i8z3zPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=U1H9nldK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso70643a91.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775672936; x=1776277736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtYpYVe6IbYxCTgeUoql4WGa/gQA9Rw19LJX4Br61fg=;
        b=U1H9nldKCn8N8HUFUelOSvZHt/+IQH4iNaSoa+Gv7IO9qY/g8OUbfGMkxa2aLShRKP
         rFcItVyGq8Ed8Yt7oELqWfhugIqdPMY6mYP0QcW6pZQ28n7GEIIdUAAoCge+aoPxMIDv
         PJlDpaytpaNQH+AW/PcuOPmY5DGj+7CkkEMsJp8v0WkDOaVwTAVLEW31haJeyW7wWyqF
         RBIPQ+EiwzFxL2F3oArHDpEMC9NvPKRDKFkU+EP+VGVRpkpyXc8XqqChlxjOOVRfOt7h
         feeeb4jJZRgwsg8i79loj9PU1uc6NbGPyGJW7CYjqqVa1hsNsdfIxCDfnI3t3DVs2sby
         15fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672936; x=1776277736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtYpYVe6IbYxCTgeUoql4WGa/gQA9Rw19LJX4Br61fg=;
        b=Z6DcKRirnuABJyC4/1tquJPptw40Kq1hq1bNH0zuWSqG1wPKFIPMxltnZPnVm1WFDB
         +SgnorqGFzZFAfbQohUozjFkOtNUwPFrXxPa6QSi9TuCF5xcO7zAhKrkFL49ezbzBxw7
         MlIqGvqSdfymGzfhQYF5iczcb7HC/JFQ0qYLLcNf473EYi9X/B8cigK76uJFvDyQjzvf
         AcBnQCSNleAn1pxle1Wn+WrtEO6G4n7LO3YF/s58zlZBPa4MhPgJ8xx4Mzfnl5GKhlda
         wbfjXhVOTqfY0c0Ak5ZeauYVNtChjdJRNPILmP17iBmWjNdaXrln6XPskUZ7gA/JLkgT
         49ig==
X-Gm-Message-State: AOJu0YxG7v5SCYrlxhQw/gVWkvXWFmJMxYqdPu/MbmTtvQJN1MDQuPx/
	3A6CCHuXVTJNqxXRgSDTME6zM3vAlThZXX8fny+f5l34KCnO+oFGbYNcDow2/VF/y3D86z0OEuu
	zU6Nibg==
X-Gm-Gg: AeBDietfnkyMKonsznljPRyd0QzNxaL4Jp/XcoAtaPXWbN/51yYJHxjLqW16psyEfqy
	9tYbzhggWzsOxwF6OGkiSZMYHQ+h2YRdfl4hL81piVLwTohszep0WPd7uTq5aiNWA7+S4T7i56A
	A9WPZ/t3e87cEEZEwAb3nNQ+5ea3dZTgdy0+FTsD6pZPEANjGn0u/9KZGoMMkab4Q5Sq8vnEpVZ
	cEe3LU7lRQN3zXCeM9b/VPGvTusG6Fyb/eH5/Qk+RVbinDDMUqSYyY7CZYUhESYZ/plGFzJoPvF
	ANAl3yWays2RPUaXefgaVIPOcMNDzkKMx7aWGaE3fDTVQQ/JP3ly0mN17NXSthhehOn639IpOR7
	0miTjEfdcxAmuz6FVbswvYIfwg4+maGvlhu9/NiDYkbv6Wy2SWTem4ZZkq2CLOBAqEhrU0GVsP5
	lcMj3Myd58tiMPl6obaAUR2vIZiE4sh17L9OidvS313Z15rgz6R4aHsg==
X-Received: by 2002:a05:7301:1e90:b0:2d2:d7b7:5c70 with SMTP id 5a478bee46e88-2d40d906c33mr362507eec.15.1775672935771;
        Wed, 08 Apr 2026 11:28:55 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2cb4a7cdbsm6591734eec.19.2026.04.08.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:28:55 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] ipv4: nexthop: update has_v4 flag for any family change in replace_nexthop_single()
Date: Wed,  8 Apr 2026 11:28:50 -0700
Message-ID: <20260408182850.2618488-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276680-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 32A9C3C1799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a nexthop within a group is replaced, nh_group_v4_update() is only
called when the old nexthop is AF_INET and the new one is AF_INET6. The
reverse direction (AF_INET6 to AF_INET) is not handled, leaving the
group's has_v4 flag stale at false.

This causes fib6_check_nexthop() to incorrectly accept an IPv6 route
referencing a group that now contains an AF_INET nexthop. During route
lookup, nexthop_fib6_nh() returns NULL for the AF_INET nexthop and the
subsequent dereference in rt6_find_cached_rt() crashes with a general
protection fault:

 Oops: general protection fault, probably for non-canonical address [...]
 KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
 RIP: 0010:ip6_pol_route
 Call Trace:
  fib6_rule_lookup
  ip6_route_output_flags
  inet6_rtm_getroute
  rtnetlink_rcv_msg
  [...]

Fix by calling nh_group_v4_update() whenever the old and new nexthops
have different address families, not just for AF_INET to AF_INET6.
Using a general inequality is safe here: individual nexthops can only
be AF_INET or AF_INET6 (enforced at parse time), so the only family
transitions possible are between these two, and nh_group_v4_update()
is a full rescan that always produces the correct has_v4 value.

Fixes: 885a3b15791d ("ipv4: nexthop: Correctly update nexthop group when replacing a nexthop")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/ipv4/nexthop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 2c9036c719b6..b2ea15446cd2 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2466,10 +2466,10 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 			goto err_notify;
 	}
 
-	/* When replacing an IPv4 nexthop with an IPv6 nexthop, potentially
-	 * update IPv4 indication in all the groups using the nexthop.
+	/* When the nexthop family changes, update the IPv4 indication in all
+	 * the groups using the nexthop.
 	 */
-	if (oldi->family == AF_INET && newi->family == AF_INET6) {
+	if (oldi->family != newi->family) {
 		list_for_each_entry(nhge, &old->grp_list, nh_list) {
 			struct nexthop *nhp = nhge->nh_parent;
 			struct nh_group *nhg;
-- 
2.43.0


