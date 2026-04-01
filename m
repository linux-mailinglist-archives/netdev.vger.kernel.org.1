Return-Path: <netdev+bounces-274264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CW6DCGPzWn2ewYAu9opvQ
	(envelope-from <netdev+bounces-274264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:33:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA13809FA
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 553FB301C167
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B32673B0;
	Wed,  1 Apr 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sTU4sW97"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1A19AD5C;
	Wed,  1 Apr 2026 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079195; cv=none; b=pMxeA0w5nEVH5xV1VBbTcAgitjCn7PplN9pMOhM06tpZXoEDmenkUy1DmcsJBSxSU2o9v/WKDe1tTfxCiZ23vH+vVwZCBALpuLnfTjcnmQufAzJL5v5XC1BeIPAxvCnkqmO7g4Ko4ny4UO1K5F6dARWjTnD9ZvechZbwpDFsl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079195; c=relaxed/simple;
	bh=XqMVTfjNXrtOXlK4bfBqiQ8Zh6vhcMehBXHfkdwuCvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaEHdtvVds7nipbXKavFEGgEtD2LYgTmk4B/QqaXftXS0CR8uOsxHfmbPH0sUUOcUl1doJkDk1wWdS32GHfErN+WyRRvenE82kW42E/hsfRXVaBsbJNnNZaO+d97FePVg14P6BxkQOm5vEoy31HBDR5M0rwb4BloR+DZsG2kgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sTU4sW97; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/H8Le/lSCc+EAdY9MpvFA1yefQ1AJiCeDzALO0unz3g=; b=sTU4sW97F09jY/E5mzq6mswEYa
	R2PheddoUldiP4cY3HvX3ODBHQa/cLIOVO8Sl74FtyNl0DwA46RLDW34iGGoCEKmZOerVrWRtdWTN
	S1F1ZUOcuGNoX7itsb/81qKt7lOrzxF/adEqwqNtKdpUSmeNbdZeFro0eyVuHDdfIFa47UX3Lmujq
	dv6x1PreS0oImZcmyQyYtPCc5nvfa7gS4I5FLEGcnCwwfBuOFiHwHWGm1RtsCvVVj0x7B8duVzH5m
	XbRt73kaFg/OlMxxGDhJzJYm0mv2hLRSZveyG5Yl5uxhgmsakgzUrcuoCEkH3YYDSa5m7Vniyftjd
	k5HU5zdA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w83B9-0000000B3i8-2xWX;
	Wed, 01 Apr 2026 21:32:47 +0000
Date: Wed, 1 Apr 2026 22:32:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, hannes@cmpxchg.org, riel@surriel.com,
	kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/vmpressure: skip socket pressure for costly order
 reclaim
Message-ID: <ac2O_3R--3W7cgCx@casper.infradead.org>
References: <20260401203752.643259-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401203752.643259-1-jp.kobryn@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 33EA13809FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 01:37:52PM -0700, JP Kobryn (Meta) wrote:
>  #ifdef CONFIG_MEMCG
> -extern void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
> -		       unsigned long scanned, unsigned long reclaimed);
> +extern void vmpressure(gfp_t gfp, int order, struct mem_cgroup *memcg,
> +		       bool tree, unsigned long scanned, unsigned long reclaimed);

You can drop the 'extern' while you're changing this line.

