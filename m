Return-Path: <netdev+bounces-275671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFfxJ67u02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:34:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF43A5BAB
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7D6630154B6
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FFF341062;
	Mon,  6 Apr 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VAfNgKcS"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530A27702D
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496876; cv=none; b=FneHG4LNyNGbVJ4ovWARyQLOT5ghgBywaXtX+coppg1sCQwDKLt/lBsBBXGJutpPbaR40//TxxohAAukOUc8+YIAYaNWY+r5wV0Yl0uIW0CHBkJjWWC6XuKfaggIYjDePMWZX5df+jkzq5A4dEtL3Vu5SmvwchaknrzZ4gwmYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496876; c=relaxed/simple;
	bh=2crBVysFiLlip09kpdtR1lArplIGy4UDN7J0fSyGU2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgCLa28RvuMKn57NVPNu2N6A7psgpXp3L0CDDqQMOezvjlsqj01a8BJ95m5q7ejg/odCfWhB/lvRoYhfTrMd0jUJCoHPUDlzij5hbdx5IOJ5QXEyeVNj+j6O33CwSIBAsjMklI8RyU6M2u+hxMRMKJY8QlZx+Q0Os355Yx+2Jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VAfNgKcS; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5bb568ea-d025-49ae-880b-a053f79cb8ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775496869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DodrdiUpriuDp59DhRdN5UuAknsgE+ERRDCHM8OyPpE=;
	b=VAfNgKcSAJjZEZko0Jw2TSBjsZ5UMbZ0fqzXUZFVqAbq5oudvBg/NQrQNTnt77jdbqbrws
	KyIHmV6bdh+ka/Wi4q+BVyAdFUZvFLcEUFdzTAg6Ks1ljONpr0UIgAZgJDKlwFd5FT+9dq
	cIhX7VoNzipf9xA+82rCuUrl6eldgAg=
Date: Mon, 6 Apr 2026 10:34:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/vmpressure: skip socket pressure for costly order
 reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, riel@surriel.com, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260402232511.17246-1-jp.kobryn@linux.dev>
 <ac8DEuZhb_aQA4ez@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <ac8DEuZhb_aQA4ez@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275671-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 18EF43A5BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 6:03 PM, Shakeel Butt wrote:
> On Thu, Apr 02, 2026 at 04:25:11PM -0700, JP Kobryn (Meta) wrote:
>> When kswapd reclaims at high order due to fragmentation,
> 
> * kswapd is woken up for the higher order reclaim request
> 
> But this can be direct reclaim as well.

Good call.

> 
>> vmpressure() can
>> report poor reclaim efficiency even though the system has plenty of free
>> memory. This is because kswapd scans many pages but finds little to reclaim
>> - the pages are actively in use and don't need to be freed. The resulting
>> scan:reclaim ratio triggers socket pressure, throttling TCP throughput
>> unnecessarily.
>>
>> Net allocations do not exceed order 3 (PAGE_ALLOC_COSTLY_ORDER),
> 
> Net not doing costly order allocations is irrelevant here. IIUC you want all
> costly order allocations (like THPs) to not raise vmpressure as those don't
> necessarily represents the memory pressure.

The supporting context I included was based on the investigation that
led to the patch. But as you and Rik both noted, the patch has
greater implications.

> 
>> so high
>> order reclaim difficulty should not trigger socket pressure. The kernel
>> already treats this order as the boundary where reclaim is no longer
>> expected to succeed and compaction may take over.
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
>>
>> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
> 
> The patch looks good. I think we can ask Andrew to just adjust the commit
> message and then you don't need to resend.

It's no problem for me. I'll send a v3 with an updated commit message.


