Return-Path: <netdev+bounces-275710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLx2I7wE1Gl0pgcAu9opvQ
	(envelope-from <netdev+bounces-275710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:08:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65D3A67FB
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DE29300D32C
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 19:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4872ED141;
	Mon,  6 Apr 2026 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wunMr7fL"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33206353EC1
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502509; cv=none; b=vEVUwxU22BYjQQaVac6gatGERSMDrJwPyyIVMdJ70SBYweNvkaNuyhV13vq7wTRk1M/MaS2rceiOIHAVNlyKnV5QZ0BqWGtxcACaLFOUUVh8E+jkE0GWklF/Ak9IYukVSUjEK3J4x6vkClLxhfeKNnQru8dl6ILOA3gvJv7K6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502509; c=relaxed/simple;
	bh=gQfjPpc3BEhznOAGD8z+RizuOdBUMLui/gaYUJ/julc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIoN6E1lnyhVCUPfvzfVRECSQ4ILlom4YD/qjpNp0bwIBif9vqU7sgIrkmNocUqsnffsbF1CX4dkrcYeVCKK92ho3FXtszR4bFddxPn23E1XCzio547+H0+goCxm74svLhnFvqaKUKc9eDKeGfxGKkfBMgzZYdUkOG+H9NsJ9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wunMr7fL; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a41259c-bf69-49d5-9cba-80a5feb8ee8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775502496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFapA+/+f9Y8DbS4JFAzR2c+AXc075dwW6fUywslDic=;
	b=wunMr7fLL/+q3D6zujH47arhZ40hzscKc6Aq6mymRAr+Z1NJEN8M+H0Bwtgjg0bY1XfBCR
	PU48LBBhPkyHoYVFAaOYuP5cvKma0xtO5ecSzzC5wv8xLRYmON7MzZjJwZcqxoQy9yVlnQ
	CkE0BmEC1SWLn1iLWMkvkrviHQB1K1c=
Date: Mon, 6 Apr 2026 12:07:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm/vmpressure: skip socket pressure for costly order
 reclaim
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org,
 david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, riel@surriel.com, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260406174425.61692-1-jp.kobryn@linux.dev>
 <20260406105417.28fda9587146a011af2fb876@linux-foundation.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <20260406105417.28fda9587146a011af2fb876@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275710-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E65D3A67FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 10:54 AM, Andrew Morton wrote:
> On Mon,  6 Apr 2026 10:44:25 -0700 "JP Kobryn (Meta)" <jp.kobryn@linux.dev> wrote:
> 
>> When reclaim is triggered by high order allocations on a fragmented system,
>> vmpressure() can report poor reclaim efficiency even though the system has
>> plenty of free memory. This is because many pages are scanned, but few are
>> found to actually reclaim - the pages are actively in use and don't need to
>> be freed. The resulting scan:reclaim ratio causes vmpressure() to assert
>> socket pressure, throttling TCP throughput unnecessarily.
>>
>> Costly order allocations (above PAGE_ALLOC_COSTLY_ORDER) rely heavily on
>> compaction to succeed, so poor reclaim efficiency at these orders does not
>> necessarily indicate memory pressure. The kernel already treats this order
>> as the boundary where reclaim is no longer expected to succeed and
>> compaction may take over.
>>
>> Make vmpressure() order-aware through an additional parameter sourced from
>> scan_control at existing call sites. Socket pressure is now only asserted
>> when order <= PAGE_ALLOC_COSTLY_ORDER.
>>
>> Memcg reclaim is unaffected since try_to_free_mem_cgroup_pages() always
>> uses order 0, which passes the filter unconditionally. Similarly,
>> vmpressure_prio() now passes order 0 internally when calling vmpressure(),
>> ensuring critical pressure from low reclaim priority is not suppressed by
>> the order filter.
> 
> Thanks.  I'd prefer to park this until after next -rc1.  I could be
> argued with, but....
> 
> What I'm not understanding from the above is how beneficial this patch
> is.  Some description of observed before-and-after behavior, preferably
> with impressive measurements?

Let me know if this data helps, and if you'd like this added to the
changelog.

On one affected host with impacted net throughput, the memory state at
the time showed ~15GB available, zero cgroup pressure, and the following
buddyinfo state:

Order FreePages
0:    133,970
1:    29,230
2:    17,351
3:    18,984
7+:   0

Using bpf, it was found that 94% of vmpressure calls on this host were
from order-7 kswapd reclaim.

TCP minimum recv window is rcv_ssthresh:19712.

Before patch:
723 out of 3,843 (19%) TCP connections stuck at minimum recv window

After live-patching and ~30min elapsed:
0 out of 3,470 TCP connections stuck at minimum recv window

