Return-Path: <netdev+bounces-262058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIAWBptdomm12QQAu9opvQ
	(envelope-from <netdev+bounces-262058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:14:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 714971C018A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277323032068
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7F2C11E3;
	Sat, 28 Feb 2026 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VKZgd+Ux"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD292BEFE7
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248472; cv=none; b=HgItPzLWMJN3+75wtHEEBGHkSgdIkR1caBjxj5IlDQfMRyxktv1t7JPUmm5Wj52nNbPyWRTCNGCSaVVogc2OKEsIvU/NQBiVtbsWD3nXaNtSbSDyPZbZbxFCALE8sdIQfzXjBNPRHDJEopqamA6QpWCFXojWB6HsbbzDpXB5M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248472; c=relaxed/simple;
	bh=D8biCTlSTEqTgNRAyZ11YJT4nk5vNVS6u9YDnBIb0Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rmbm6SeAPQ2sRUyyzIR4JwONi+ei2zpnowFCBgCj4+r4awnDpCtptqNcHcuRGS3PN9PDXtJnfWBfsIrCGvrE1LkE9msNTPrm15zHuMwD9yGb/8NgTsNOEZP6qAKqoIXFXQV91qN18Yy6CmWJPAWutkWXq2yLveIUGHdhtasZ2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VKZgd+Ux; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772248469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTKaRJ4X6Pkk7FYFhsEZ0KaU1kgwJZU13Iz4NGl7a3c=;
	b=VKZgd+UxhYL4OAzWN5JvdO3rG62JTbm8LWoAe8RIYCfj+O4ZKBac5zUXYwetGGOP1wy/4P
	BwQVVuDDo21W0E/bdv4JExyRda+oc+jFYMcPLI3Pfx+EH4MpJUrgRmcAeOrwZcv2t9lJ2W
	wk7XM3BBgRutVLZVcxeUWSiC46lOOVM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] net: nexthop: fix panic when IPv4 route references IPv6 nexthop
Date: Sat, 28 Feb 2026 11:13:59 +0800
Message-ID: <20260228031400.163009-1-jiayuan.chen@linux.dev>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262058-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 714971C018A
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

fib_check_nexthop() does not validate that the nexthop family matches
the route family. This allows an IPv4 route to reference an IPv6
nexthop object. When the IPv4 route is looked up, __mkroute_output()
accesses nhc->nhc_pcpu_rth_output which is never allocated for IPv6
nexthops (fib6_nh_init does not call fib_nh_common_init), causing a
NULL pointer dereference.

Note that this is not about IPv4 routes with IPv6 gateways (RFC 5549),
which uses an AF_INET nexthop with nhc_gw_family=AF_INET6 and properly
allocates nhc_pcpu_rth_output via fib_nh_common_init(). The bug here
is an AF_INET6 nexthop object being directly referenced by an IPv4
route, which is an invalid combination.

Add the missing family check in fib_check_nexthop(), mirroring what
fib6_check_nexthop() already does for the reverse direction (rejecting
IPv6 routes that reference IPv4 nexthop objects).

Reproducer:

  unshare -rn
  ip link set lo up
  ip nexthop add id 100 via fe80::1 dev lo
  ip route add 172.20.20.0/24 nhid 100
  ping -c1 172.20.20.1

After fix:
...
$ ip route add 172.20.20.0/24 nhid 100
Error: IPv4 routes can not use an IPv6 nexthop.

Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/
Fixes: 4c7e8084fd46 ("ipv4: Plumb support for nexthop object in a fib_info")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/ipv4/nexthop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7b9d70f9b31c..0f236110cd58 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1634,6 +1634,12 @@ int fib_check_nexthop(struct nexthop *nh, u8 scope,
 			goto out;
 		}
 
+		if (!nhg->has_v4) {
+			NL_SET_ERR_MSG(extack, "IPv4 routes can not use an IPv6 nexthop");
+			err = -EINVAL;
+			goto out;
+		}
+
 		if (scope == RT_SCOPE_HOST) {
 			NL_SET_ERR_MSG(extack, "Route with host scope can not have multiple nexthops");
 			err = -EINVAL;
@@ -1650,6 +1656,11 @@ int fib_check_nexthop(struct nexthop *nh, u8 scope,
 			err = -EINVAL;
 			goto out;
 		}
+		if (nhi->family != AF_INET) {
+			NL_SET_ERR_MSG(extack, "IPv4 routes can not use an IPv6 nexthop");
+			err = -EINVAL;
+			goto out;
+		}
 		err = nexthop_check_scope(nhi, scope, extack);
 	}
 
-- 
2.43.0


