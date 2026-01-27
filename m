Return-Path: <netdev+bounces-253831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDJkDAGkeGmGrgEAu9opvQ
	(envelope-from <netdev+bounces-253831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:39:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF393B51
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05599303AF2A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF332ED846;
	Tue, 27 Jan 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FrRKbbTy"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBF3491C2
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513943; cv=none; b=rin9q7Qez496IrtRKT0kON5yqIodfyp8bk4/ftucilqBu4lfBkkwjpDjq7LTL+sJUwDCN8YApEpoQBLOWQB5OPZoiI7yM6Q1xajPcdCLdxSfY0CrvOM0wMH1Vy9IB1GdWvJkVxuUltVDlxvVx/F+QF0B8u6tLL5m3hVSn2elvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513943; c=relaxed/simple;
	bh=YndkXdYV0N/C4fArMSOXeYZVJJPmFaHnZATRPKoaNYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tcOVovaWQ5nUNv8xb6LHFHJeZTKnd2PZQJ02aLOouC4j8sXBvlPj2miNd/U8Pmo1CJA0IrXMWpUkdC7+g4AfhDzS/pA7HaeIQ9RAgYX9z2yfPh71UKO7M4Kh9XiK6hT0o5vo0w8PI9GWiQ5T3p/PLcqCKjQSg2el9zUxaaz7v4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FrRKbbTy; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769513937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ZMTsq7fOpGJcCZLbL5YgF26AxhamEVetXbo0T+NZo4=;
	b=FrRKbbTyyhTQyK6SadpbiENH/pagc+sFIa1SEvKL7TCzH+TKGELhvj+uxKB5O5cUCWG63z
	0pvUgMd9M2F99DQBRgx2X2+3Er0bbnDOX3qDDHsqaKB794SlCCMuypEZpp/j/0zj4s7ZTo
	RurIl9Uv9OWGF3/0ekVx0F5MLcrMohY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
Date: Tue, 27 Jan 2026 19:38:44 +0800
Message-ID: <20260127113845.219468-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-253831-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,e136d86d34b42399a8b1];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 92FF393B51
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

xfrm6_get_saddr() does not check the return value of
ipv6_dev_get_saddr(). When ipv6_dev_get_saddr() fails to find a suitable
source address (returns -EADDRNOTAVAIL), saddr->in6 is left
uninitialized, but xfrm6_get_saddr() still returns 0 (success).

This causes the caller xfrm_tmpl_resolve_one() to use the uninitialized
address in xfrm_state_find(), triggering KMSAN warning:

=====================================================
BUG: KMSAN: uninit-value in xfrm_state_find+0x2424/0xa940
 xfrm_state_find+0x2424/0xa940
 xfrm_resolve_and_create_bundle+0x906/0x5a20
 xfrm_lookup_with_ifid+0xcc0/0x3770
 xfrm_lookup_route+0x63/0x2b0
 ip_route_output_flow+0x1ce/0x270
 udp_sendmsg+0x2ce1/0x3400
 inet_sendmsg+0x1ef/0x2a0
 __sock_sendmsg+0x278/0x3d0
 __sys_sendto+0x593/0x720
 __x64_sys_sendto+0x130/0x200
 x64_sys_call+0x332b/0x3e70
 do_syscall_64+0xd3/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp.i.i created at:
 xfrm_resolve_and_create_bundle+0x3e3/0x5a20
 xfrm_lookup_with_ifid+0xcc0/0x3770
=====================================================

Fix by checking the return value of ipv6_dev_get_saddr() and propagating
the error.

Fixes: a1e59abf8249 ("[XFRM]: Fix wildcard as tunnel source")
Reported-by: syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68bf1024.a70a0220.7a912.02c2.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/xfrm6_policy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 1f19b6f14484..125ea9a5b8a0 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -57,6 +57,7 @@ static int xfrm6_get_saddr(xfrm_address_t *saddr,
 	struct dst_entry *dst;
 	struct net_device *dev;
 	struct inet6_dev *idev;
+	int err;
 
 	dst = xfrm6_dst_lookup(params);
 	if (IS_ERR(dst))
@@ -68,9 +69,11 @@ static int xfrm6_get_saddr(xfrm_address_t *saddr,
 		return -EHOSTUNREACH;
 	}
 	dev = idev->dev;
-	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
-			   &saddr->in6);
+	err = ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
+				 &saddr->in6);
 	dst_release(dst);
+	if (err)
+		return -EHOSTUNREACH;
 	return 0;
 }
 
-- 
2.43.0


