Return-Path: <netdev+bounces-297856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPP1H0LuKWohfwMAu9opvQ
	(envelope-from <netdev+bounces-297856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:07:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89A66D4EC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:07:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hGjF75fm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297856-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297856-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E94D320955A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAADD3822A1;
	Wed, 10 Jun 2026 23:04:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE1336885;
	Wed, 10 Jun 2026 23:04:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132663; cv=none; b=Urw1Lb+jM3hqxD5uP2I23ei5RfE5qwoc7A1FZnSuHQevJtWMqzEaLTSNHNzkSbehR0JmYpDJjcRX4lQlB265GHwzmBzkYbrcTqVGNgcCYwgiBMm/DzQxJq5Z/p04cOSDsAEw4jkNu3xMsSQ8vKDDs97p3q7SSO3jJJdGaA7Alao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132663; c=relaxed/simple;
	bh=19BDK6BwhTcrHnLv8z8OKRfT+e/osIT4EuXdhKNAOnI=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=LeSBl3ZLehAd1V71FikEYtchEODwssA2XWnoX2LgpL1RKzjHt+P404epJCj7TAhQA/NZze7RaSX/Vjl6v5mpYZgolJfXMP+/8I7/fxcXTeeNy3pytoXfvRQQQgAPmiGZHkswJd7TlDm1vERBHSudbQJkwB6PEG9WNgyITb6Yuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGjF75fm; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781132661; x=1812668661;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=19BDK6BwhTcrHnLv8z8OKRfT+e/osIT4EuXdhKNAOnI=;
  b=hGjF75fmLba8sDPFoag1qtULw3jGf/Cn6bd/2ljXMC2I4PZEjM2lGv4j
   pIxRhZF8VM7+BaZS5lC9rc+5vhgtXxK1RZdrWS8mq8edR6wUpppu+myOX
   YkB2nn7liGpfcjIDxJdOdunhCwixX8AJZ1i9JlMM+NpNpWbutDdmo8CFO
   lflhwGNv+Yy+HsoBpT7J28A5GMD88biuku5uINeS1dm3yziMGgZCrCmzV
   wgDG+48+yoHLhGder5xZvduilQQSeRHzKJBjUct+1Q2m+v2wAlQd7JC4l
   VVaVco4gwcEtYASyqe07n+L8g/X9nZL5pblqBjutLFktvt8NQ5UBOn8iU
   g==;
X-CSE-ConnectionGUID: rtPwktqSS3e5ElvhiXfChw==
X-CSE-MsgGUID: cu6I0EV1TgKplS/4VDvc5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81074128"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81074128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 16:04:20 -0700
X-CSE-ConnectionGUID: aXawu264TMWGTsm2tch8Qw==
X-CSE-MsgGUID: m2ctBtL5SS6Rmntdy+Cwzg==
X-ExtLoop1: 1
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2026 16:04:19 -0700
Subject: [PATCH v2 5/5] tcp: Remove mmap_lock fallback path
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arve Hjønnevåg <arve@android.com>, Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 10 Jun 2026 16:04:19 -0700
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
Message-Id: <20260610230419.F746395F@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297856-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[dave.hansen@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:dave.hansen@linux.intel.com,m:aliceryhl@google.com,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:surenb@google.com,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF89A66D4EC


From: Dave Hansen <dave.hansen@linux.intel.com>

Previously, the per-VMA locking could fail in the face of writers
which necessitates a fallback to mmap_lock. The new
lock_vma_under_rcu_wait() will wait for writers instead of failing.

Use the new helper. Wait for writers. Remove the fallback to mmap_lock.

This really is a nice cleanup. It removes the need to pass the lock
state back and forth to find_tcp_vma().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
---

 b/net/ipv4/tcp.c |   31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff -puN net/ipv4/tcp.c~ipv4-tcp-vma-waiter net/ipv4/tcp.c
--- a/net/ipv4/tcp.c~ipv4-tcp-vma-waiter	2026-06-10 15:57:56.972472379 -0700
+++ b/net/ipv4/tcp.c	2026-06-10 15:57:56.976472521 -0700
@@ -2171,27 +2171,18 @@ static void tcp_zc_finalize_rx_tstamp(st
 }
 
 static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
-					   unsigned long address,
-					   bool *mmap_locked)
+					   unsigned long address)
 {
-	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
+	struct vm_area_struct *vma = vma_start_read_unlocked(mm, address);
 
-	if (vma) {
-		if (vma->vm_ops != &tcp_vm_ops) {
-			vma_end_read(vma);
-			return NULL;
-		}
-		*mmap_locked = false;
-		return vma;
-	}
+	if (!vma)
+		return NULL;
 
-	mmap_read_lock(mm);
-	vma = vma_lookup(mm, address);
-	if (!vma || vma->vm_ops != &tcp_vm_ops) {
-		mmap_read_unlock(mm);
+	if (vma->vm_ops != &tcp_vm_ops) {
+		vma_end_read(vma);
 		return NULL;
 	}
-	*mmap_locked = true;
+
 	return vma;
 }
 
@@ -2212,7 +2203,6 @@ static int tcp_zerocopy_receive(struct s
 	u32 seq = tp->copied_seq;
 	u32 total_bytes_to_map;
 	int inq = tcp_inq(sk);
-	bool mmap_locked;
 	int ret;
 
 	zc->copybuf_len = 0;
@@ -2237,7 +2227,7 @@ static int tcp_zerocopy_receive(struct s
 		return 0;
 	}
 
-	vma = find_tcp_vma(current->mm, address, &mmap_locked);
+	vma = find_tcp_vma(current->mm, address);
 	if (!vma)
 		return -EINVAL;
 
@@ -2319,10 +2309,7 @@ static int tcp_zerocopy_receive(struct s
 						   zc, total_bytes_to_map);
 	}
 out:
-	if (mmap_locked)
-		mmap_read_unlock(current->mm);
-	else
-		vma_end_read(vma);
+	vma_end_read(vma);
 	/* Try to copy straggler data. */
 	if (!ret)
 		copylen = tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);
_

