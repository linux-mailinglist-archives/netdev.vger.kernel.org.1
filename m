Return-Path: <netdev+bounces-297855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2MA7MgjuKWoZfwMAu9opvQ
	(envelope-from <netdev+bounces-297855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:06:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190366D4E0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:06:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="ifd/hahV";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297855-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297855-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1846831D575F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D237C90E;
	Wed, 10 Jun 2026 23:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48E36A340;
	Wed, 10 Jun 2026 23:04:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132662; cv=none; b=rDKw81Hnuc+nVJod7D1WPF8d2WBAhhDbpz2EAbzOVM6isHK7o6A/pbxatz3BxAqxYDnFG6PeTgWOSPWZaTRQU2XS4TRac+ISTBDie8bt4Wj5H+BKZWLUo/i+il0tmU8dABpnyZevWoS/nSy+6O+sBRITvufDMaVeIVQY9RIC/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132662; c=relaxed/simple;
	bh=e05wYXuo6Rnig5sVWE/a8UtaGwRE8fbO63Dp2L1ubI4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=YlolV+nMgeML9SxJ3I/+/id9z3Pm3vYztkPnghoVfxnjxXPF42xdTYUC6ndHjgfa6mbLiOlp/TfVVeHIHuTFljIhqJgZpIZAddXUaKTaK6f/k9H6LTVoQqztRO556BmAlEjoXoWmUrbNCWbILTRpleBQDkflJKNmkvOqCSP76mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifd/hahV; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781132659; x=1812668659;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=e05wYXuo6Rnig5sVWE/a8UtaGwRE8fbO63Dp2L1ubI4=;
  b=ifd/hahVtqXSNWVEyxUhLJMSEvcPP5LJTlXD7O10Ulh8iFCqG6+Z9k56
   Yv+XShjtUjyqzbSrtK83SRl3HG5xvzG2ug4CnOIBkGnHk5MrdJTKobCSt
   74+/PohiUlhclWKItLW/fn++zMR1EPIhmgfv6Mo47MqIglfHqJP4a85F0
   lHNszj1u8xyOSSZykZR3ckCilGOEL7ffOu7/TRRJc4YS3xF2VARcEGwFt
   +rRY586F3Rdlvz/7s63SNo+uKuVu0Gb6L8zvYa8/Yi0WnkV7URVJtsbcV
   4cMoNipEVFlfKd4KPSBH2N3jnNto/Qv0bqiiMLwm9BDmF+n0abYeabxOb
   g==;
X-CSE-ConnectionGUID: UcCc195VRGyxCgY4FY0InQ==
X-CSE-MsgGUID: /VLjG0u8SOistW8aI+8+aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81074116"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81074116"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 16:04:18 -0700
X-CSE-ConnectionGUID: IfwMSswuQKeXR78Inw71jg==
X-CSE-MsgGUID: 2UPwDDKpRauG9v11yWy1NA==
X-ExtLoop1: 1
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2026 16:04:17 -0700
Subject: [PATCH v2 4/5] binder: Remove mmap_lock fallback
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arve Hjønnevåg <arve@android.com>, Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 10 Jun 2026 16:04:17 -0700
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
Message-Id: <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297855-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2190366D4E0


From: Dave Hansen <dave.hansen@linux.intel.com>

Previously, the per-VMA locking could fail in the face of writers
which necessitate a fallback to mmap_lock. The new
vma_start_read_unlocked() will wait for writers instead of failing.

Use the new helper. Wait for writers. Remove the fallback to mmap_lock.

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

 b/drivers/android/binder_alloc.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff -puN drivers/android/binder_alloc.c~binder-vma-waiter drivers/android/binder_alloc.c
--- a/drivers/android/binder_alloc.c~binder-vma-waiter	2026-06-10 15:57:56.419452721 -0700
+++ b/drivers/android/binder_alloc.c	2026-06-10 15:57:56.423452863 -0700
@@ -259,21 +259,14 @@ static int binder_page_insert(struct bin
 	struct vm_area_struct *vma;
 	int ret = -ESRCH;
 
-	/* attempt per-vma lock first */
-	vma = lock_vma_under_rcu(mm, addr);
-	if (vma) {
-		if (binder_alloc_is_mapped(alloc))
-			ret = vm_insert_page(vma, addr, page);
-		vma_end_read(vma);
+	vma = vma_start_read_unlocked(mm, addr);
+	if (!vma)
 		return ret;
-	}
 
-	/* fall back to mmap_lock */
-	mmap_read_lock(mm);
-	vma = vma_lookup(mm, addr);
-	if (vma && binder_alloc_is_mapped(alloc))
+	if (binder_alloc_is_mapped(alloc))
 		ret = vm_insert_page(vma, addr, page);
-	mmap_read_unlock(mm);
+
+	vma_end_read(vma);
 
 	return ret;
 }
_

