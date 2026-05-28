Return-Path: <netdev+bounces-292611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBZlKkgIGGoaawgAu9opvQ
	(envelope-from <netdev+bounces-292611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFE05EF6BD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A9D43009824
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ABA39F19C;
	Thu, 28 May 2026 09:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2E39E16B;
	Thu, 28 May 2026 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959116; cv=none; b=p6K/Ibp4txRoAeITXZQoOMr1YN7AeCzBdfAINFTJ8nkWFRz0Z8zjlxm6/m/YHIJnoXPtbVW84GvlzGVwlrtG34PIbn4YD8GUym3tk2b9RmBUxqR2E4yQ5OLySwRiLdu4Bj+omrhcXHrWkEahm0oAehAfugQHwpNW7y+rw8y+CiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959116; c=relaxed/simple;
	bh=Wgj1AFhm7MQ7HhTqX39oI5eoayqlItDzxkQczK2qw/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvgCSXLYDkJIWT0PhBMlaVltF09MWbrosStrVdAHNer8D914QZNTv21t6Ax1v0OjQxtdGnrXmrcqcktziYdXcgkp5l3DcH3p7MKDCMAphYba5f9QaEOzY3o1srus3PHI/ec5RtLMuJCXiJz/RygInKm+OGB4DbbL7IgakapxafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 454E468B05; Thu, 28 May 2026 11:05:09 +0200 (CEST)
Date: Thu, 28 May 2026 11:05:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, io-uring@vger.kernel.org,
	kasan-dev@googlegroups.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: improve the kmem_cache_alloc_bulk API
Message-ID: <20260528090508.GB8376@lst.de>
References: <20260527070239.2252948-1-hch@lst.de> <ee817070-cc7a-40d5-92a4-2bd8e9e65fbe@kernel.org> <20260527122148.GA6838@lst.de> <482ee03a-c5b3-4873-a550-cc5743068616@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482ee03a-c5b3-4873-a550-cc5743068616@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292611-lists,netdev=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 0CFE05EF6BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:07:12PM +0200, Vlastimil Babka (SUSE) wrote:
> commit 46dea1744498 ("slab: refill sheaves from all nodes") from this January.
> Previously it was just interrupts enabled.
> 
> > but by requiring separate functions so I somehow doubt that was meant.
> 
> Yeah, it's expressed by the _nolock variants. But slab propagates it internally
> by the gfp flags, and since 46dea1744498 it affects kmem_cache_alloc_bulk().

So what are the GFP flags that affect spinning?  I can't find anything
related to that in either Documentation/core-api/memory-allocation.rst or
include/linux/gfp_types.h.


