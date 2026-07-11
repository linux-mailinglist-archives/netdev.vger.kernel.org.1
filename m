Return-Path: <netdev+bounces-306729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GfO7JJSVUWrfGQMAu9opvQ
	(envelope-from <netdev+bounces-306729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 03:00:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C964B73FE4A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 03:00:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=mMHMjjk+;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306729-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306729-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE31C301F987
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230651D5AD4;
	Sat, 11 Jul 2026 01:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE6136358
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 00:59:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731601; cv=none; b=ibKPpBWwOYYPPIjIvYd5niB4mfidA0+WU/eMBqjClW64Jc9qZX6HM/7e2aJl/AtrIJdaugQeGRzjIpuY+VdqxLF1MTzy4HHIIl3uy2TU0z3kT24+L1oNACWRNsry92vN7Y4w9a+fZ9Lm6IC0FpJ48QNeFMRVmxQwAKp2rtFvc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731601; c=relaxed/simple;
	bh=82SoBqnaIxAoeSCM9PbSU27JsN6zntgpw9VOQQJ8jTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWR9B3Mk8fpdrr6Ao53OE5lwXlG3QK3NWftDAiJMdjKdoDHRJP7ACFNDX1gWyvlgPuyfA/irjaeBdBl3AqVL8KH3tQcYvS3b+eg5C3c52sPRAT/j2328O3zafkDXgDZrN6MbxsI72emzHcSeYkpmMskH6bvo74dDL5Btc1FlY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=mMHMjjk+; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so1947652a91.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783731599; x=1784336399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewnBcrKa6mMH9C1p0ajQh0jRLidOfV8+aIS9AjhukVE=;
        b=mMHMjjk+Nzf6X8kIR7C7XGrCEDoL3//fW/34bdSTvsIFnFr1sMokjZsHwB/vQoImuy
         pX4UQOIkOpqAYAV5roHrTtHu5GCtvdkHuypsrZUOY8HA3AwOl20zcMAAYggu7qdOLGqj
         bdkew1YOX5nK7QNtmAP6IMdpGO5szs9Ef0h0V/ujr8AsmTk0/h75ETN+mraYVkzHP5Ux
         TzrJsfQ+1zrsVUR4tmEW+PoxLxlPk85kVndNuaqGCgChZ4hQWbk++/mK9h0wMC1ib0Ji
         hd9+hsEtkCl0tZhpqqOfU2/I8Xlmnn0ApM0HHfQiUtHc3MZ2prye8efe0GhuDtegZNnu
         pufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783731599; x=1784336399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewnBcrKa6mMH9C1p0ajQh0jRLidOfV8+aIS9AjhukVE=;
        b=I0QkPs1Z2xu6Q599sQpkAoO8/CjEg3V/hH409OqSntCiEIVQTFJX8sr2fDuqFoI7Eh
         qK/u8yjOyKJOTnr006sLyElTKSBO6AjVWkKrYB+d+ekA/0L7eb94hus/EqEJbgTdNZNP
         ASJMi6WeVvoYR8NuXV1r+M2D/sVMRyOF4/mPuS/zf8Xf9D+CxpiF07Ck4tm0I3opQiya
         JC6cqi1lHCILHzislJSIs1VAI1b6l9dbZKGrqaXXYpONs3sKV6IfBvwhZscghq85FbHj
         FZzhWVID09I+Y4QRLTiZXK90OLl7MiqLc2r/t/EgfW5W6OdUrCZydSvnaV++2k0cLeFa
         LQvg==
X-Forwarded-Encrypted: i=1; AHgh+RrXwC5h+yKudruiFrhMdOHfN51Q6YgTPi2z+mdUXxS0jYlFyKpSVPp/c8sl8ZjpnbpDSTEV08A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTwi+nR++ps+F4NKqVBpil58S++kX09O9AQ+TQqLiWYGHi3z8
	Lsbs7GaGzyS43rCjx4OxwfouNORMwLtGdfIfXMtf9o1a+3xRIcKDm3U2zqKK+lvBJA==
X-Gm-Gg: AfdE7cmwThfZi9sXi/csOtqILM9pBi1EAW4FoPb+zuK/FkBW9xe/QZx1LDI9UHphfnm
	X3WTPEv9Ch2atgKU/n+aLTQGuZ7WZGrmlkpq2RVEnm4/xuGkvTLAYLqwoovu9ok3p4lJf5PxvL5
	4eYNkaT+emryHwK/QgvFMTLqWcCeVEVxNV2gQQsYnN7NT6In8QG4zzXPWXeZgUfF8189QlCsJSs
	PSea+mwtEXloSi4xUXn3zhIiaPCitQMmc3ilG/3WJkE6wztn9ry3clBKZt/y/AB42drwipoxGtN
	km29h1By0yriX/G4NxG85NxwGkQsahw1/BX87Ckst1GYiSdNs+titRYqhEUxtZwChKDnWTS0imG
	0v392c2RQDcTUd07Nno2R/5EHQoKmvympPraRgDZhy4B4NYB72lawjk8+c6/OEJegYpz92dtl1j
	HWGKlO3/Gj88XHqYZY4Q==
X-Received: by 2002:a17:90b:4a43:b0:37f:9ce1:cda4 with SMTP id 98e67ed59e1d1-38dc773bf14mr1140147a91.26.1783731599048;
        Fri, 10 Jul 2026 17:59:59 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm48926157eec.0.2026.07.10.17.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 17:59:58 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weiwan@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] net: sock: prevent integer overflow in sock_reserve_memory()
Date: Sat, 11 Jul 2026 00:59:55 +0000
Message-ID: <20260711005955.1467140-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:weiwan@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C964B73FE4A

sock_reserve_memory() adds 'pages << PAGE_SHIFT' (a plain int) to the int
sk->sk_forward_alloc. An unprivileged SO_RESERVE_MEM caller can drive the
accumulating counter past INT_MAX and wrap it negative, either in one
INT_MAX request (0x80000000) or across several smaller ones.
The corrupted sk_forward_alloc then trips WARN_ON_ONCE() in
inet_sock_destruct() on close (a panic under panic_on_warn/oops=panic).

Bound the field that overflows: compute the new sk_forward_alloc in u64 and
reject with -EINVAL anything exceeding INT_MAX.

  Kernel panic - not syncing: kernel: panic_on_warn set ...
   __warn (kernel/panic.c:1054)
   ...
  RIP: 0010:inet_sock_destruct (net/ipv4/af_inet.c:161)
   __sk_destruct (net/core/sock.c:2357)
   inet_release (net/ipv4/af_inet.c:442)
   sock_close (net/socket.c:1501)
   __fput (fs/file_table.c:512)
   __x64_sys_close (fs/open.c:1511)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)

Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8a59bfaa8096..2ba95bead1ae 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1042,6 +1042,9 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 
 	pages = sk_mem_pages(bytes);
 
+	if ((u64)sk->sk_forward_alloc + ((u64)pages << PAGE_SHIFT) > INT_MAX)
+		return -EINVAL;
+
 	/* pre-charge to memcg */
 	charged = mem_cgroup_sk_charge(sk, pages,
 				       GFP_KERNEL | __GFP_RETRY_MAYFAIL);
-- 
2.43.0


