Return-Path: <netdev+bounces-282413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGakF6kX8mljnwEAu9opvQ
	(envelope-from <netdev+bounces-282413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:37:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C3495E9F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AE1730DA176
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C832330662;
	Wed, 29 Apr 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY40mc0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700725CC79
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473117; cv=none; b=uCKcvWOo4JbTVsUh+kC4dFvsRtMhqTOZiShT/Re0384GcU5GEllERarq0uSiHYgovD1WK+gHFMYAGubX+eRcLPqOVl9h9zHIe/BZ7olWhPWYB1SKQ1qpCk9Z3C7qlxsVS5yU4bHcWCJ0W9gP+PCIOzYt58h2CqE8VRmz0gGqUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473117; c=relaxed/simple;
	bh=y2HnhOMy4hyLpTmRJAP3RTbsxFjeenv2PvD2f098SG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlCbam5pk3g2P0nbjPAeVOvdF+vW42N9CWGK/fTC+kWnNFhBVRpo8FPM9FX/ZOF+PV0vVyHTpUx+8ilh1pdz8ChmQggliWw3AzJaz/nYmZb/W3EEvhnCG/lvnKACjxtIe9st43eX8BNMDpmYQf6znnReG8dSNuDROojWwPnPvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY40mc0c; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso65953165e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777473115; x=1778077915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NyS+iO9jeCHRrkgdMXm039A3CMe7fQPfQJh8kvEzuwU=;
        b=cY40mc0ceX2lbwrDp24/mbjChViYXMHK959eE6O0aMXVhdVm5q+LT4ew8+KApjgA1k
         IdEW1NYgbA+aEwOzoz50XoPEuDZgAIm6HyM6VaCTzWBFeXDRw/2TvVZGQn2i10oIFenD
         QupGtdOvshdESB20jvC12aJlxU3AUww6OksivxR5j8XRitAh3refLiMCXK3MuorxnaXd
         ietLSAJozplLI7FAiKRahqoKIOPXFZccRPYYE7nt9rXp4Tre5ckPgUSgNKPPhhDFRY96
         bkE6KOa+1YOcpEm7dIs++kfRxfw3OujaoFHQHPMpyfByu2CYimnGYCMLmKY6O5gqjT4p
         9Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473115; x=1778077915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyS+iO9jeCHRrkgdMXm039A3CMe7fQPfQJh8kvEzuwU=;
        b=oo5LTL97asCokFYVwNxWa0++Cw7F3I6rbhRsxxuziduztGyeHE3dFDGvpUG6ZcUZsZ
         QnVT9JD/TjK3N8NDAJH6VMm8yHryK5kwpssdlfMyrCFFZq9L14gBDCzH0lOM3/XfzPF7
         TqkcMIhCb7g9/9rpUYmYIhgABxPRTsTGjo7/XxaUFSF7on7GgOLbxRpi2jXUZEzSBPbE
         GNrQ+3roFhxvkHROFJF17DH4kSBYPaikDhuhijFJm6CTalNALfWNrVsEDLaXcxrkN4Mu
         WxNaZj8jS5Il3COEm8q/YR2BFC9Tg2MVSvxEPCTL7I6NRT+lcbbkd91CBwxFzM09OYUL
         6x5w==
X-Gm-Message-State: AOJu0YxWNJkH845E0r3AzciHjaHGXOKXv9QPYDah9p6h0yPAZQmDIb9L
	WCUr8pWUbTAKK8ehJYp3JxlujcClloE2C/qpBgI5983OWn3GTYbec3df
X-Gm-Gg: AeBDietxR3cW3P3Kv5mVhGOMxzc8KFICks7727X1MlfMyASOJlLQdg0AcfiY24YXukR
	MgWZnQ1p1jict0GBfnnBphXCVevPhshHJFdcqO5F6OqsDBYh0zPLou0QA1z77YPh1cd7SuSJA1W
	WdXMfL9vocpDa/fZwxx5xeFbGWAtbwQCU+oPcS01FhvK+Xr0c9HaJXrReFQ56LH+lX4174CXmic
	8S3KQXxUMz/qe2hiXHi1lBa+vSh7a8gZYBqc6EzLKkahBzZH1sYQdsVfKR43n8BFeBT4gQpaGwB
	ennTUnnz/QfwkmmbGUQHgkmZKXfq1XBCA83HKSqzL0z+QTTk8XyOWziJaoqucsOvgxuab4IDyFl
	2bXk+DQgDccXbBt7b1i/nMaXu9aizItwcf7PLplcXf2exmLOK7Vv7lPPajrge0Polqyf+qyNvEX
	I/JIkm9IdXopDKMrWWQl14B5wjVCT2ySfMu3x5DfAEPU7BwnHS7iFsxrvejyHavPRSKpvZ5dKS+
	fBI0/FR+az7N6ibLp8DyeXGu92r5Yit4wOh/lIb2c7axCp5WHzjnhBrfrU5rvNSdpeaWC+JO6En
	i6u4pkxD
X-Received: by 2002:a05:600c:5492:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-48a7b5124cemr68867815e9.6.1777473114207;
        Wed, 29 Apr 2026 07:31:54 -0700 (PDT)
Received: from [172.17.0.113] (218-211-0-146.static.cpe.unicatlc.net. [146.0.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c57333fsm51551715e9.2.2026.04.29.07.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 07:31:53 -0700 (PDT)
Message-ID: <69bd0255-33ef-455f-98a8-db14a4d88708@gmail.com>
Date: Wed, 29 Apr 2026 15:31:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: add net_iov_init() and use it to initialize
 ->page_type
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, axboe@kernel.dk,
 almasrymina@google.com, sdf@fomichev.me, hawk@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vbabka@kernel.org,
 io-uring@vger.kernel.org
References: <20260428025320.853452-1-kuba@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260428025320.853452-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE5C3495E9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282413-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/28/26 03:53, Jakub Kicinski wrote:
> Commit db359fccf212 ("mm: introduce a new page type for page pool in
> page type") added a page_type field to struct net_iov at the same
> offset as struct page::page_type, so that page_pool_set_pp_info() can
> call __SetPageNetpp() uniformly on both pages and net_iovs.
> 
> The page-type API requires the field to hold the UINT_MAX "no type"
> sentinel before a type can be set; for real struct page that invariant
> is established by the page allocator on free. struct net_iov is not
> allocated through the page allocator, so the field is left as zero
> (io_uring zcrx, which uses __GFP_ZERO) or as slab garbage (devmem,
> which uses kvmalloc_objs() without zeroing). When the page pool then
> calls page_pool_set_pp_info() on a freshly-bound niov,
> __SetPageNetpp()'s VM_BUG_ON_PAGE(page->page_type != UINT_MAX) fires
> and the kernel BUGs. Triggered in selftests by io_uring zcrx setup
> through the fbnic queue restart path:

Looks good to me,

Acked-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


