Return-Path: <netdev+bounces-210998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B9B161B4
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEA8564BFA
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491312D640E;
	Wed, 30 Jul 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTf3PAVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E28F66
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883061; cv=none; b=g/8YHosjpxJM5rNcpLxx6QCcs33YrcVsK9OKrjsw0MgRveUte3rxqcOYVOXOBAOZVMats51OYxOxzcxiq8iZq5k+bMwBrgIl0CoZXJDWIIDMY8/MY/52Vg52xd1K5zsHHR82SgqA/VpXy6lfhQtB6VKCu9Asax05GgxDwTLDCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883061; c=relaxed/simple;
	bh=cgP7ufEbc1fp1+482maor3B6Hqo7lhcA8bqWL0MDuCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0IgE8nHYwRbnvMv7l3M7qQTCbv9HaRXS/46IgqYAAtx9DDgZKN5LPWSRw02CSWNb0d93lsQOLft8BIvOpDvVSinNAqNV98HhUJ6SJgQTXkhE1DyuHtSEjmnGu1no4I0bGV5zM+et/cXhzsYKa2VCZOBSBo8OqFQwuLNWdGLzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTf3PAVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4746EC4CEE7;
	Wed, 30 Jul 2025 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883060;
	bh=cgP7ufEbc1fp1+482maor3B6Hqo7lhcA8bqWL0MDuCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mTf3PAVgkEAh6b8AMNui+UNmqLyAXKG9tkrXugLGu25sGFNv4xZLxdFpg58hd6eOf
	 KcmsurfVVJTJ5B3cSXGI1A1S8warGgiHekZOmKPd51G65bdk9LlQg65QpbF0cr1ViU
	 WdPfCNw1GfGYZzvzXcoSdmLwQ0foi4xBfJ7XND23ys59XRHRt0PYsKSHO9M0ewp+g9
	 8SNVe3CULazbokXl2GACVm4FoWFL/oXKwz3ZcJ8fV8+VxpvxEvaVkDv4dHm99dfe9E
	 DV0P9qYD+5713vJ0iJoS0ITSqHgjHpmc1tFOFNOFmXb9vByiVP9JrWI5Y5ggpFde0Y
	 +2yuhdP6x7FLg==
Date: Wed, 30 Jul 2025 06:44:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <20250730064419.2588a5e3@kernel.org>
In-Reply-To: <bb66c931-ac17-4a70-ba11-2a109794b9e2@linux.dev>
References: <20250729102354.771859-1-vadfed@meta.com>
	<982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
	<1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
	<9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
	<4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>
	<c52af63b-1350-4574-874e-7d6c41bc615d@lunn.ch>
	<424e38be-127d-49d8-98bf-1b4a2075d710@linux.dev>
	<20250729185146.513504e0@kernel.org>
	<bb66c931-ac17-4a70-ba11-2a109794b9e2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 10:18:46 +0100 Vadim Fedorenko wrote:
> > IDK, 0,0 means all symbols were completely correct.
> > It may be useful for calculating bit error rate?  
> 
> The standard doesn't have this bin, its value can be potentially
> deducted from all packets counter.

We have a number of counters outside of the standard. Here the
extension is pretty trivial, so I don't see why we'd deprive
the user of the information HW collects. The translation between
bytes and symbols is not exact. Not sure we care about exactness
but, again, trivial to keep the 0,0 bin.

> > A workaround for having the {-1, -1} sentinel could also be to skip
> > the first entry:
> > 
> > 	if (i && !ranges[i].low && !ranges[i].high)
> > 		break;  
> 
> I was thinking of this way, the problem is that in the core we rely on
> the driver to provide at least 2 bins and we cannot add any compile-time
> checks because it's all dynamic.

1 bin is no binning, its not a legit use of the histogram API. 
We have a counter for corrected symbols already, that's the "1 bin".

