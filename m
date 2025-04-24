Return-Path: <netdev+bounces-185701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAEA9B6AB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8414A3C8A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE05D1E1C1A;
	Thu, 24 Apr 2025 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFkInMrC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633A155342;
	Thu, 24 Apr 2025 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520427; cv=none; b=mVZr7+qiuD2AB++vYb1PIy1WGX6qeZxVv/2SsOV7lqIsQLUZgYAMSHQ4MkP3je6E6ToF+taozaS6VmPb4jiUGFtwE7QD64COh6h5mDqg2WPBHky+1ItpkbC+JgWO/uNCtfA7tEv0nx/0CG1xxJaclCgsp+CcNuqtPhd9ykV2cVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520427; c=relaxed/simple;
	bh=63B8SOezIjHF6IjNgkPDhala00PxbRTVS/sNnyV2qkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD1wvLtMBGRaVDjyGkjrZzI6zGmNBoiKbQ8mXShYL0rdS6PuXcoohW+A4pncvcyp+9Nr+hQP0Ab188XdP+LiFVnK04d5kYl8sJAkvQ2DpInB9xfb/gYEaraEcIGazLDi5grVYxZAcaIqNa2JpayF/OStRdgFHylG8PYLhPQB74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFkInMrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A39C4CEE3;
	Thu, 24 Apr 2025 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745520427;
	bh=63B8SOezIjHF6IjNgkPDhala00PxbRTVS/sNnyV2qkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFkInMrCO5J8iV/bB+T5cQR/lWofnjsGp9pDGEQWS0+81n3snP5Ijg/Jzni5NyqWE
	 bL9nG5a2dQXEVaIviUZd62Clu7xK+rrOC42TCEbHp6KudOiK0vnD6H5Ro6tNa4khia
	 FA0o0nYN53RVzARWd6Vc5Ndiehh4pxY7myVX05xhVEvrY7VwlNOR7NXCdpx1r0Xhty
	 hDsRG70+dZhnKvCQyvhLU4agi4SEjB7dK7r/RfOdRBGh56oV90iNaEfMnBmV8xELA2
	 4Ll1s6QcC295oO/zrY5exdGJW1WvIKXqmCtN7TeVeQKP1B7sHoet+vrBGAVLTg2MyT
	 7LFKLShA+9KLA==
Date: Thu, 24 Apr 2025 08:47:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
	Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <aAqHKWU2xFk2X2ZD@slm.duckdns.org>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>

On Thu, Apr 24, 2025 at 05:07:48PM +0900, Harry Yoo wrote:
...
> Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> constructor/destructor pair to mitigate the global serialization point
> (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> percpu memory during its lifetime.
> 
> Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> so each allocate–free cycle requires two expensive acquire/release on
> that mutex.

When percpu allocator was first introduced, the use cases were a lot more
limited, so the single mutex and expensive alloc/free paths weren't a
problem. We keep using percpu memory for more and more things, and I always
thought we'd eventually need a more sophisticated allocator something with
object caching. I don't exactly know what that should look like but maybe a
simplified version of sl*b serving power of two sizes should do or maybe it
needs to be smaller and more adaptive. We'd need to collect some data to
decide which way to go.

Improving percpu allocator in general is obviously a heavier lift but that
may be a better long-term direction.

Thanks.

-- 
tejun

