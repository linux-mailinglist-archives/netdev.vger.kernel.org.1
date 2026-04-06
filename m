Return-Path: <netdev+bounces-275712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLVVM6gG1GnUpwcAu9opvQ
	(envelope-from <netdev+bounces-275712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:16:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA33A691D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E99301BCF9
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51F2C1595;
	Mon,  6 Apr 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i1zGF7/s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53482D7BF;
	Mon,  6 Apr 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502963; cv=none; b=Bx94I13AmfawRjh4VqkpSUcIzhuBqryny7iHFhUflhJcMmcc6IAnJc4ieO8uMMifMwvFKwKHE9MgWvcPrbpxHYP4BqQu78CF09A95iTcXSpNNNc4MCqyTtcYFZJP6LEA46YkxGy7hImf0G+kXUpfNRfmA1wbI8gA4UZ5ecJJecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502963; c=relaxed/simple;
	bh=QFs5zbLdbLvzwCzJF46KTmdJhGKCTNp3PQe/c6FVWuk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YdAoAV69LtnQVP9UQp/FM59wrUUGmN6Yo6Q0T78HX1yBfpRcH1XZLCai2NzSEjlsFLkA9/e9cG84lAzhskULgT3l/T0xpuoNfPXn59/4NoSocd15cGDEXDSxVyRGUSXng3Dvr1sHNCIR7EpMop1ohfDDijTr3uHHNOrb55Okq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i1zGF7/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EC6C4CEF7;
	Mon,  6 Apr 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775502963;
	bh=QFs5zbLdbLvzwCzJF46KTmdJhGKCTNp3PQe/c6FVWuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i1zGF7/sXDGh16efrnNHdWmhZTD0x2pFwIZOavKSuFz2N2xtPiz89vS+Sy1zhba7b
	 FEnT9pU71iW1MyZNNXcGc+cGkz+XnfIw0RzpAiskj7GY1Gg75WAsOQ82daAXmiW+Cc
	 aCbidToP7gn37uvs/LYVIM08JTBfpfHPMoaPEVSs=
Date: Mon, 6 Apr 2026 12:16:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org,
 david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, riel@surriel.com, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] mm/vmpressure: skip socket pressure for costly order
 reclaim
Message-Id: <20260406121601.0f4f3a6886098371e40d6711@linux-foundation.org>
In-Reply-To: <6a41259c-bf69-49d5-9cba-80a5feb8ee8a@linux.dev>
References: <20260406174425.61692-1-jp.kobryn@linux.dev>
	<20260406105417.28fda9587146a011af2fb876@linux-foundation.org>
	<6a41259c-bf69-49d5-9cba-80a5feb8ee8a@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275712-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 30CA33A691D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 12:07:57 -0700 "JP Kobryn (Meta)" <jp.kobryn@linux.dev> wrote:

> Let me know if this data helps, and if you'd like this added to the
> changelog.
> 
> On one affected host with impacted net throughput, the memory state at
> the time showed ~15GB available, zero cgroup pressure, and the following
> buddyinfo state:
> 
> Order FreePages
> 0:    133,970
> 1:    29,230
> 2:    17,351
> 3:    18,984
> 7+:   0
> 
> Using bpf, it was found that 94% of vmpressure calls on this host were
> from order-7 kswapd reclaim.
> 
> TCP minimum recv window is rcv_ssthresh:19712.
> 
> Before patch:
> 723 out of 3,843 (19%) TCP connections stuck at minimum recv window
> 
> After live-patching and ~30min elapsed:
> 0 out of 3,470 TCP connections stuck at minimum recv window

Well I'm impressed ;)

Yes please, it's a useful thing to include.  When people look at a
contribution, question #1 is "why should I spend time on this".  A
clear (and tasty) description of userspace benefit is the ideal way of
answering that.

