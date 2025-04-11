Return-Path: <netdev+bounces-181688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB9A86254
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121501BA114E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DA20F063;
	Fri, 11 Apr 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJV8RtgE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8035961
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386708; cv=none; b=AKed3dsIUq7QwGhRM3AuZLVXG8X6bQx9VhhNSqrdXBvrZCxJHE6mNAWsUF697WQbje7Fy5ZZNNkq2YTRSv42q/45bbvHa9NHLpyk3E652Lw7T66xQyrdZhnO+F4E1tsscdWhd/927a2pAnbGKqIpcagGiEIa+6QMCUZke+mhAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386708; c=relaxed/simple;
	bh=WUlpEvUyYqtQN+coMNo0xuXkthk/nI+QBNZ5QVY2IEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsRBIthb09pBkNJTvVIHKsE0eMA44yVvoWbJyP9ghcFqTHCkJT7r/L3bVPKDfpc4y7In+viQUMWbI4N3M8F9yUaEpQfrT8OBx3ng2TofZbWrNnNZx9FQ10zhdikcTIYsa0YkTgrQ4WtPkAvFspF9QM7F4neI97tqvYuXJLCH6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJV8RtgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8737AC4CEE2;
	Fri, 11 Apr 2025 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744386707;
	bh=WUlpEvUyYqtQN+coMNo0xuXkthk/nI+QBNZ5QVY2IEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJV8RtgEypwQNef0ye9KfcaXQa74Cyotrouoa9xRTpGTPIktpvkSgg/SvTfwtLUxL
	 OvN/DGKSindUTGn6KcSxn4KEugaGYVF/ZzV4wK/aLvKDOAEMdjut80+Qqzq18pPg9F
	 AF5bm28C1IQ238e7uudusF32MBNI7+1pZ2RrPTWm4JxJQ37IZyJ9PTmaZ6qZlDGme/
	 F7Lp+DIvvALwhv6yG6yD8Q+SOHD4yNFQ+EGDxRhhYQeRF4wFrL8Ue5ZXqfEN00VNno
	 yRkvfwMwpp+JD2N/nvtP9seuU1wY852N0rN5YMMUIUwVherOjE9WXQb2C5TZWIJL9H
	 kKiSpzbR+uyyg==
Date: Fri, 11 Apr 2025 16:51:44 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] idpf: fix potential memory leak on kcalloc()
 failure
Message-ID: <20250411155144.GJ395307@horms.kernel.org>
References: <20250404105421.1257835-1-michal.swiatkowski@linux.intel.com>
 <20250407104350.GA395307@horms.kernel.org>
 <Z/ij+J8kGYM5ezC/@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/ij+J8kGYM5ezC/@mev-dev.igk.intel.com>

On Fri, Apr 11, 2025 at 07:09:12AM +0200, Michal Swiatkowski wrote:
> On Mon, Apr 07, 2025 at 11:43:50AM +0100, Simon Horman wrote:
> > On Fri, Apr 04, 2025 at 12:54:21PM +0200, Michal Swiatkowski wrote:
> > > In case of failing on rss_data->rss_key allocation the function is
> > > freeing vport without freeing earlier allocated q_vector_idxs. Fix it.
> > > 
> > > Move from freeing in error branch to goto scheme.
> > > 
> > > Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> > 
> > Hi Michal,
> > 
> > WRT leaking q_vector_indxs, that allocation is not present at
> > the commit cited above, so I think the correct Fixes tag for
> > that problem is the following, where that allocation was added:
> > 
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> 
> Thanks for checking that. I agree, my fixes is wrong.
> 
> > 
> > I do note that adapter->vport_config[idx] may be allocated but
> > not freed on error in idpf_vport_alloc(). But I assume that this
> > is not a leak as it will eventually be cleaned up by idpf_remove().
> 
> Right, it will be better to free it directly for better readable.
> Probably candidate for net-next changes.

Thanks, that does sound like a nice idea.

...

