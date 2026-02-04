Return-Path: <netdev+bounces-256658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEGaGqQYg2n+hgMAu9opvQ
	(envelope-from <netdev+bounces-256658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:00:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D51EDE4338
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8CD4300C81A
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAC3D332A;
	Wed,  4 Feb 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsgGnYNN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlbQN4e4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B33AEF5F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199129; cv=none; b=lfnQIPEqeDPR3eIj2nlE5CpPjidmdHm8cmqyjm1RZvSgV3UOR2u906U0ft7viqHxlPIJlrhXX7ovyAz+7sP9APtl1nGuxk676Hlib5gG62K6H1TpOP9h1aNapxTx6gBMYaQb2Y08q3ly+/hBzGNprTBK/GO636FYHyA6GkzPm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199129; c=relaxed/simple;
	bh=eB548WQNruuJyt8SWKdhFBWgHN6mgQJ7JmOuOsqsT3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bx+EzRySRW0acypXGBVlenwAWzHkPSjNFRHgO+bR5nWjijKtykwpSQhzwwXlALeEr3+bL+3UQJpJg6Bc6NZU7e7zpQebThrStciptOqQiLkcAZPy+z5EuJoMpCELHrPcmkNtPLskN2IgcFiWWkWqhQxUEf22rhpvG2qGzshmfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsgGnYNN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlbQN4e4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770199128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0anI2bZTa7dZYuMM7JyWvb8JCNUMjiOmOSamvAfMS3s=;
	b=KsgGnYNNQqqzS1sNe+s/EWtZAe59jDV4fDt6H21Jb4W2Bc1utxsafKAdaIKbEiBQS1nsWa
	vn1yNvrFm0vws6AXtdbvrEymEbZo19OaUQ4gFf+JK5bmT05ZGg1Z56MKPDU0qQMqVdmc18
	mLT+lGvF1b91r4kq08NioILt7v/7RTk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-skunlvubOKOwFdlpNsXgfg-1; Wed, 04 Feb 2026 04:58:47 -0500
X-MC-Unique: skunlvubOKOwFdlpNsXgfg-1
X-Mimecast-MFC-AGG-ID: skunlvubOKOwFdlpNsXgfg_1770199126
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82184c384aeso9579334b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 01:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770199126; x=1770803926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0anI2bZTa7dZYuMM7JyWvb8JCNUMjiOmOSamvAfMS3s=;
        b=DlbQN4e4giBmtyyb3soSp7IH2MkmIB65CLmlmsf4Kq+faI0LbRZ3UbDYFw94FHQvCx
         hBp6gIXBSm+NL0s0nevxZ0Ec3hjyP4hfyq9UmrLoJDgyeg1fnHYy33UXmCECFRyz/7Tf
         pX/UVZMo7M9Icwky+XQ0OS8ZEYY+JOrVB+pbyh3/RGWLkg7J15hFGn9e9j3ncEezV0dQ
         IEjcXYDWfaKJUer5T3aYkTy/RLtz8ZXF11yVUFLoI8QXyp4QqqrR83b4xt/6B2ATp1iO
         LiwtP81w+F2jDOny/iG2xON7DxSezF/0Pzv2lvzaCGiRxEgM+7asoDASOpOT8HJExOxT
         jW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770199126; x=1770803926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0anI2bZTa7dZYuMM7JyWvb8JCNUMjiOmOSamvAfMS3s=;
        b=w6BJd1PBcEjvvrOgBrOVHBeN9S1Hf7iKys+KRnjf3OzvWgf7Ak4TWrbV4txYCUccHn
         h/Mo86DcjzjoF+pewLRAnL1g/irKGdVrJCxQ+LHHOkKaoO4AyRF+RYPAhkVKUvof+Dpa
         1bLvcaAj4H8NaAu40y3ii1ljWoiQ/Bvg0j1CSx+0JOnlLik87q+90byWnnnH7M6JkdBM
         E0G8dCTPCtomnMbBI+JLgZRZD03MUVyD32nMpcMzBP46DMDFLMDhDOAHPpf5eujpJxnO
         xrcQMSdwDZ2xm+aRhAU5e8HdYpluEn4G1tdG9xpDyZI3IeVjXEdtPnM5wknO1SFji+RC
         PQpQ==
X-Gm-Message-State: AOJu0Yz3Pk3CG9oC68ADsCIgBRTAIxvHe8jkgEXyo8NdsROlhZts0azm
	wSy6wxlfHCzeDWYwC2LoknvRwXkNfe6N1KE5gClOHmC2Kaat0SZvO/HJGhAF8zKWW6/6RsHAsi1
	s1LHBF12oIxlY9wKhvzApdrey1wtTkwjfqrkSc1mpnFXismFAIxNYEyJBdspvCE0w1g==
X-Gm-Gg: AZuq6aI/nyrQlNJyZ34WZBie3IkkBLPD7U5I8dWCXMlk7c4eEB3X3JJlWY7sp7NX20s
	WlI4vpqDXG2SqNOAnr4053s9AUnw8nWt3kK/XGa5mxr+M/Mu8wZkdPVA9DCtNjvnB6p+c8osbS1
	QCc5oZijZw9pq/ROtirMObsAYHHlFVsIMnF1RiC8+bUB7pq1hFS+YZLLFRhxs1Y7azentpEgH4z
	Sc99bmaEy5gLQSh4ts8cLpUdAp5BTciQv3dAq7+HmedBXywtlHLytwCR3ANDNuynQaeR3P/AvPK
	U1cqVRNNEOjTc4c8MDHZ8j9dwSY6GOItYY+kJECecH2/61klSg/jM6kOjVmIpDql9VXFkcIgkbr
	I63jb/h2EoEfV+yQZVZ9p86credX1bZ+Yow==
X-Received: by 2002:a05:6a00:3cd6:b0:7f7:5d81:172b with SMTP id d2e1a72fcca58-8241c4c4babmr2683574b3a.42.1770199126235;
        Wed, 04 Feb 2026 01:58:46 -0800 (PST)
X-Received: by 2002:a05:6a00:3cd6:b0:7f7:5d81:172b with SMTP id d2e1a72fcca58-8241c4c4babmr2683547b3a.42.1770199125856;
        Wed, 04 Feb 2026 01:58:45 -0800 (PST)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d45b3f8sm2326797b3a.47.2026.02.04.01.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:58:45 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	fmancera@suse.de
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
Subject: [PATCH net] ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF
Date: Wed,  4 Feb 2026 18:58:37 +0900
Message-ID: <20260204095837.1285552-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[syoshida@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256658-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev,cb809def1baaac68ab92];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: D51EDE4338
X-Rspamd-Action: no action

syzbot reported a kernel BUG in fib6_add_rt2node() when adding an IPv6
route. [0]

Commit f72514b3c569 ("ipv6: clear RA flags when adding a static
route") introduced logic to clear RTF_ADDRCONF from existing routes
when a static route with the same nexthop is added. However, this
causes a problem when the existing route has a gateway.

When RTF_ADDRCONF is cleared from a route that has a gateway, that
route becomes eligible for ECMP, i.e. rt6_qualify_for_ecmp() returns
true. The issue is that this route was never added to the
fib6_siblings list.

This leads to a mismatch between the following counts:

- The sibling count computed by iterating fib6_next chain, which
  includes the newly ECMP-eligible route

- The actual siblings in fib6_siblings list, which does not include
  that route

When a subsequent ECMP route is added, fib6_add_rt2node() hits
BUG_ON(sibling->fib6_nsiblings != rt->fib6_nsiblings) because the
counts don't match.

Fix this by only clearing RTF_ADDRCONF when the existing route does
not have a gateway. Routes without a gateway cannot qualify for ECMP
anyway (rt6_qualify_for_ecmp() requires fib_nh_gw_family), so clearing
RTF_ADDRCONF on them is safe and matches the original intent of the
commit.

[0]:
kernel BUG at net/ipv6/ip6_fib.c:1217!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6010 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:fib6_add_rt2node+0x3433/0x3470 net/ipv6/ip6_fib.c:1217
[...]
Call Trace:
 <TASK>
 fib6_add+0x8da/0x18a0 net/ipv6/ip6_fib.c:1532
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3946
 ipv6_route_ioctl+0x35c/0x480 net/ipv6/route.c:4571
 inet6_ioctl+0x219/0x280 net/ipv6/af_inet6.c:577
 sock_do_ioctl+0xdc/0x300 net/socket.c:1245
 sock_ioctl+0x576/0x790 net/socket.c:1366
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: f72514b3c569 ("ipv6: clear RA flags when adding a static route")
Reported-by: syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb809def1baaac68ab92
Tested-by: syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/ipv6/ip6_fib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 2111af022d94..c6439e30e892 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1138,7 +1138,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					fib6_set_expires(iter, rt->expires);
 					fib6_add_gc_list(iter);
 				}
-				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
+				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT)) &&
+				    !iter->fib6_nh->fib_nh_gw_family) {
 					iter->fib6_flags &= ~RTF_ADDRCONF;
 					iter->fib6_flags &= ~RTF_PREFIX_RT;
 				}
-- 
2.52.0


