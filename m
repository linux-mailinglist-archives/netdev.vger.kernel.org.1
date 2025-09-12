Return-Path: <netdev+bounces-222740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C665B559CF
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 01:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B2A00E49
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269BA2550CA;
	Fri, 12 Sep 2025 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ2Eoclz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A4235072;
	Fri, 12 Sep 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718416; cv=none; b=AU5hLJdMytldWqVVlp2t+t+6OIpu2q/8rQ5gUd0fmdb2L1MbGepABsNgcMJpSV5nMKoDJzQ92K0z7dwndgZE4gBsIXMsMQ3dsOipRqfs00z7C7AcP50/Vs+TFCEvJQNw1hUM78mrZOcgqwuNrC4vREhPwYsr1QKnI2e8+0Ja8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718416; c=relaxed/simple;
	bh=F3pBgbTa0bRUXPXmhmfpIhfIO30jxsVYPUgnnhy9Y18=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f77DedfCayfPH+oglZD0aofGTHb0CtQOYzuQ+1DXUp5SJp8jKCDPKl8DOdOG6oB+cKAdcEy48LT1KAZELGLmKJxjaYVfHAfgcwoxt/iUwa41WWrxIkLi93aeGJ0jqZhpIHZLXevHZjnZzVxcyDMFPlRkVZjjkTMQzkp+poDmnIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ2Eoclz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC7AC4CEF1;
	Fri, 12 Sep 2025 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757718415;
	bh=F3pBgbTa0bRUXPXmhmfpIhfIO30jxsVYPUgnnhy9Y18=;
	h=Date:From:To:Subject:From;
	b=fQ2Eoclz/+9dBGme9L3HXsCXZRZ8IfcA3TxKv8pbT8dWjxZOB3qIFtkaRkIXuMBmf
	 FH31OuWoycWblj5KrZS4ZXFJcyOlVfCpHecUJ87B9N+d5ZpP+a5Z4mcFHEpniNRDCA
	 V2Nk2UyZWgvcnHqcLoHU59CLZtnY42qkxMVoQ1zZozppVimX1aVUJAZ2V4rghglur8
	 +UwPapXLx2NUk2Rg8e5ZZNQWvQyj7tI+duK5MOHE4+y7c5xx6PKxe8LehQJ+YGtccA
	 fvHQFjQQ+7/N4lyd4euHA0WMpRbPVgVkvpOZEIcNIHQbfxLgarBJpMY5MSELkAk8QD
	 MoDy4ZDW8cdEg==
Date: Sat, 13 Sep 2025 01:06:51 +0200
From: Helge Deller <deller@kernel.org>
To: David Hildenbrand <david@redhat.com>,
	Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Memory Management List <linux-mm@kvack.org>,
	netdev@vger.kernel.org,
	Linux parisc List <linux-parisc@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate
 page_pool_page_is_pp()
Message-ID: <aMSni79s6vCCVCFO@p100>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when
destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0xc000007c on
32-bit platforms.

The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identify page pool
pages, but the remaining bits are not sufficient to unambiguously identify
such pages any longer.

So page_pool_page_is_pp() now sometimes wrongly reports pages as page pool
pages and as such triggers a kernel BUG as it believes it found a page pool
leak.

There are patches upcoming where page_pool_page_is_pp() will not depend on
PP_MAGIC_MASK and instead use page flags to identify page pool pages. Until
those patches are merged, the easiest temporary fix is to disable the check
on 32-bit platforms.

Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>
Cc: netdev@vger.kernel.org
Cc: Linux parisc List <linux-parisc@vger.kernel.org>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Helge Deller <deller@gmx.de>
Link: https://www.spinics.net/lists/kernel/msg5849623.html
Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..f3822ae70a81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4190,7 +4190,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  */
 #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
 
-#ifdef CONFIG_PAGE_POOL
+#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_64BIT)
 static inline bool page_pool_page_is_pp(const struct page *page)
 {
 	treturn (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;

----- End forwarded message -----

