Return-Path: <netdev+bounces-276972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AzqBpma12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:24:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619B3CA5FA
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A9CD3007F77
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115B3BF66E;
	Thu,  9 Apr 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2cYqF75"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB43B7756;
	Thu,  9 Apr 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737468; cv=none; b=YZFGD8OQ7kjzL6XveAXOiLXDXZHxYcUZMMIBs+QOKPATl/uzdF6KjZwTtE/qrxivtfEMHKsycebWDtPtfDUrBKOOsoqECcqc7/C8psROsz9LUShrbMlbNdODgQJG7mLoQ7tO2II/z6EVvo+re0ATTsy2ZDw65kl1a6ElmXmuRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737468; c=relaxed/simple;
	bh=fBTfRQqFhKeXUAFRuAg3wvuxeu46K2mxZlXpU5U1ZnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lhhvhw/3AI0bnoXgd1Pj6FxopPlsuUyFqv8qv4NOLlqhbihu+HaJnodbSMHNFcvRuLizVoqVCHsYmFgfjrX+jxzonn4aoJQ33TAMpjA87CyHaVkZlXmhT4CF0Gbp4mTKJKU0UQFZERGJjL20STVayZhgIn7koImY+/Y2tjMPFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2cYqF75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18FEC4CEF7;
	Thu,  9 Apr 2026 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775737468;
	bh=fBTfRQqFhKeXUAFRuAg3wvuxeu46K2mxZlXpU5U1ZnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l2cYqF75xpVjq5ArP3+qpb7TGko+QkdgQ00Si6Qj2xLK3NzjIATCMoGl47gk6ierl
	 5HL8Vn4wkNYdXQDrmvLRSxqt0t5FR3+6aagQyI6btzwMa3n6cgwew0u/SdVQECMs5H
	 Bdbh+rKb26cO9JK4hlJU6Sq/WlzDxfBpGaTx7MSnk2nU6ULJDLa0jZosS5Ac+y9SoY
	 lHYyjvxkZehs6G1lBIu93HyhReESpBnCn33jYMhOveGV8HOeiECvUpAtzawtX1ys04
	 GsW1VUKCB2+JdqIrpwNN9EzWlnjlRyFvSIamlw3EvvduYzV+zxP3KGetqF5P2H+GRN
	 0p763Mlk7iIFg==
Message-ID: <1bcb477c-a9b8-4615-a5c2-2aa6468935f7@kernel.org>
Date: Thu, 9 Apr 2026 14:24:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/vmpressure: skip socket pressure for costly order
 reclaim
Content-Language: en-US
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>, linux-mm@kvack.org,
 willy@infradead.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, riel@surriel.com, kuba@kernel.org,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260406195014.112521-1-jp.kobryn@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260406195014.112521-1-jp.kobryn@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276972-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,surriel.com:email]
X-Rspamd-Queue-Id: 6619B3CA5FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 21:50, JP Kobryn (Meta) wrote:
> When reclaim is triggered by high order allocations on a fragmented system,
> vmpressure() can report poor reclaim efficiency even though the system has
> plenty of free memory. This is because many pages are scanned, but few are
> found to actually reclaim - the pages are actively in use and don't need to
> be freed. The resulting scan:reclaim ratio causes vmpressure() to assert
> socket pressure, throttling TCP throughput unnecessarily.
> 
> Costly order allocations (above PAGE_ALLOC_COSTLY_ORDER) rely heavily on
> compaction to succeed, so poor reclaim efficiency at these orders does not
> necessarily indicate memory pressure. The kernel already treats this order
> as the boundary where reclaim is no longer expected to succeed and
> compaction may take over.
> 
> Make vmpressure() order-aware through an additional parameter sourced from
> scan_control at existing call sites. Socket pressure is now only asserted
> when order <= PAGE_ALLOC_COSTLY_ORDER.
> 
> Memcg reclaim is unaffected since try_to_free_mem_cgroup_pages() always
> uses order 0, which passes the filter unconditionally. Similarly,
> vmpressure_prio() now passes order 0 internally when calling vmpressure(),
> ensuring critical pressure from low reclaim priority is not suppressed by
> the order filter.
> 
> The patch was motivated by a case of impacted net throughput in production.
> On one affected host, the memory state at the time showed ~15GB available,
> zero cgroup pressure, and the following buddyinfo state:
> 
> Order FreePages
> 0:    133,970
> 1:    29,230
> 2:    17,351
> 3:    18,984
> 7+:   0
> 
> Using bpf, it was found that 94% of vmpressure calls on this host were from
> order-7 kswapd reclaim.
> 
> TCP minimum recv window is rcv_ssthresh:19712.
> 
> Before patch:
> 723 out of 3,843 (19%) TCP connections stuck at minimum recv window
> 
> After live-patching and ~30min elapsed:
> 0 out of 3,470 TCP connections stuck at minimum recv window
> 
> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


