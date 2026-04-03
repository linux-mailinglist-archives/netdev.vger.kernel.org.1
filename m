Return-Path: <netdev+bounces-274808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMh2HrANz2lysgYAu9opvQ
	(envelope-from <netdev+bounces-274808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E338FA26
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86FD73030B31
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215822F767;
	Fri,  3 Apr 2026 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="pW8IIkcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713523AB87
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177106; cv=none; b=gST/ika9LsT0ikQ7mRFeYKS/Cb4oXU2RHO3xUpy70LlDhanUZiLPAPWkzNBonznm6E1Nj1wWFrV89CbC4nRWTO3GrL8C+mK/ystsd4syZS5NFxdYDgjXTamk9344tY9wrJnQ/Pp+mz14d2EzYajfl3VRX9csEbC5yImeK+AN6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177106; c=relaxed/simple;
	bh=Uo+eFa8ffM82vVc82HmTHe4hQtiePHyyfXhzDgRWbHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcskr/Zx/iWPvKrMEwrbOEeVupGrbnF8K2vvhYX0OYyzxt4al+66nfHN05sEnj8BDPymrK7MNxUwAE9YnK1iD9eg76S/tP35TMPtbXTk2Yts8TZ5DcbBtiwUspAyk85aYl9bHjpEUUsWi3T4JcpGaOW3HAXHRKvlrFWEgJ1g1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=pW8IIkcM; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89f68634786so18437986d6.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1775177103; x=1775781903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nc2bWeNZtLKm/ctbiyRLlxDwOQ1uLVCnFLmdvpOYX6E=;
        b=pW8IIkcMEebrPo4x2FLHdxCjZwPaW8CVQaBwRHSNo87N8QsO3f1eo5LM7d4BTxYDtp
         3Rqf6/tD4MlxNxaFPwn/NCU8tzFnzP4v7MTNmKFjBQnQDU8NtqpoXAtSy8qVhdR2O8HZ
         yyfnbr7ysAwdUEQJ/vQcq1slRwtoqh6PtXCGv25B9HgxE0d2Ap4TL5JmGcHGxO4GgACc
         uWZytgwk3fxejkh+H7lFkynS6nROlXiQr9tO+9/ES52Aa8rpvzyZUK73w8iH8jAQ37NR
         9U2ADHQ0ERuSejjXlffZ+ib8Zw6zHzNC3mNGYhYV+YpuwzUkpzsuXenSWOuKYeYj+zb6
         8/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177103; x=1775781903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc2bWeNZtLKm/ctbiyRLlxDwOQ1uLVCnFLmdvpOYX6E=;
        b=mrY2cuXzj6FaAmPZ9jWZLXoqWifnLoeId6FgzAi+GKKjUkEelveesWrA7lgmPiBcJE
         f+0f71NWaK7jOxG3NM9alBFrBIJxddH26kK6Qr2yekr3vefOvVk3lSCeLel44jedWBIE
         +mCFf5G+mp6JXEZ7R0QSn/ZeZ3PcP4cGQkQKJLhCVlG4JR9qWMcUgTnOcMJ4eScukCWf
         WNybq2/RVtFh2qHj1Qf7ZH5f4fQTeuVn/k1ShGm7nntes8EV4q10lf2IctghOoDm/vwR
         lNjjagQgJz8dNnI3KwPgsuGfoEzA3D/2xYpjQgc0sx4FJHZAUXE0QaTuaOKtZCLWCxKE
         BXrg==
X-Forwarded-Encrypted: i=1; AJvYcCWXXODciyIATM7CcA+V5Et5pfbwqpfabaZv2UF4aQUMrmoil5h/QmwLdotWi0+qUbOTtHAZNxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyikz+KUp85mMFEY3BJLG7wUfm59muLA2j/U8zRrJ7eOlXcRmim
	3wJ1CvelddNsW1edjWnqSwZ4fsFazF7s6hwKRBo56KzIfQKpZA+ZZaGvcvp2dOnm2zU=
X-Gm-Gg: AeBDietxMX7oDS21I2XLXTVcNhscUAiCEXepgXvgE18yj8fhaf+JtSrMsKxqc0noZD4
	YXmK3xsWAwWU3Pw9V9Agu/n6pzRTMibiAckzuj4EOjXXsePYu48JvkKK5BkHg4Sr8DIj8F3LpeM
	eiJJjiQzNiMYCraB8E+3CiI5J9d4QWbDWpBADSUwA/ecDyK8p6rZ0zZRrAfjYzqMuVKQIqCDaxo
	3VBlu/4xnboMLNQPInPe1cEZpbTuuJjwjZRjWbz+q3ysKdQFbeiB/kiYj97oHfWBn1+8JlsdLTL
	XhdS5Mc0JhCBpNSjcR9QFYlCvWHiO1/uAzL1hR26T3twSaDFCGrVAzMXhFkMUeep7uSalJwZOoT
	YOIB/yOTnCnpIa4VGx9zsETBjBql/Fsly5swgl1xWW9BWfP7fe7+q8p1wvk7mBgZq/lJhZbmEI2
	er+a90WXtBrL9SKkQgtiW27Q==
X-Received: by 2002:a05:6214:5f0d:b0:8a4:7977:e5fa with SMTP id 6a1803df08f44-8a702b96165mr25937426d6.25.1775177102854;
        Thu, 02 Apr 2026 17:45:02 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596a0a655sm35304536d6.29.2026.04.02.17.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:45:02 -0700 (PDT)
Date: Thu, 2 Apr 2026 20:45:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, riel@surriel.com,
	kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] mm/vmpressure: skip socket pressure for costly order
 reclaim
Message-ID: <ac8NjV3kmSY95soh@cmpxchg.org>
References: <20260402232511.17246-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402232511.17246-1-jp.kobryn@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274808-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: D33E338FA26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nOn Thu, Apr 02, 2026 at 04:25:11PM -0700, JP Kobryn (Meta) wrote:
> When kswapd reclaims at high order due to fragmentation, vmpressure() can
> report poor reclaim efficiency even though the system has plenty of free
> memory. This is because kswapd scans many pages but finds little to reclaim
> - the pages are actively in use and don't need to be freed. The resulting
> scan:reclaim ratio triggers socket pressure, throttling TCP throughput
> unnecessarily.
> 
> Net allocations do not exceed order 3 (PAGE_ALLOC_COSTLY_ORDER), so high
> order reclaim difficulty should not trigger socket pressure. The kernel
> already treats this order as the boundary where reclaim is no longer
> expected to succeed and compaction may take over.
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
> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

