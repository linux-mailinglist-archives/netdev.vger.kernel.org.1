Return-Path: <netdev+bounces-205520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98DAFF0D4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E44587E20
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B3237708;
	Wed,  9 Jul 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9N52cnF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8A22338
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085423; cv=none; b=WxJZhfhvgDpxyoOOAHbr/jjkajkznjkAbs6qZKk8zI1pyF0lg9HA2ulf3AEDZ+3a/wLFTmb//QcL2kg2R2I322T4pnizu89dzlx95Tzzx4WNskEVO4zzr+yZg3aUQJsH3dEYNBkxQmmj8WBrgPKrS3hu3pr8rqfJih2ZW6/Wfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085423; c=relaxed/simple;
	bh=UIan3usiEzoHCTMzjeSVnKgxD5Lc4tX0YC6rCOvJA88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsJtmTak4x9F/UYt/+veiy6GYwwR3OPEu+olYJyLDtmOYS7ywdXeKD96S5ogacxN79azRTiflR4EMfhjqT4YZG0kasf1aUzk5TAWL+YvnoE+Zai/1fhN7ukK6Zy89kOi5TAyhciYur+eB0gCmpWdKNnneGE7FhufIXrEmS7tGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9N52cnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092D8C4CEEF;
	Wed,  9 Jul 2025 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752085422;
	bh=UIan3usiEzoHCTMzjeSVnKgxD5Lc4tX0YC6rCOvJA88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9N52cnFKK/h5zzXLAb+CJjwdZRrrPmV18PHjiuIe6ivzLNCkQdXg5RCs9iAy+kAF
	 +nws69g0JwUwtR3tNYVXxwFVJjGCYXFyFWqZ+dHvYo/Xmv/388coAV3J6Vd5gvSDkm
	 ZxWCL0/ujA/7pyLgYKXVDdLawM9bz1CRViOE5at/2RxDnSCs2Epe1SLv3u5S+tFiM3
	 OlNgU/ZarW1dweKEFkI0u2wfr6tuDGZhEgBIunjxFKl/WIQFGhyRquJqHo9/tJI7+y
	 r25xdOX/OBY/08ux7/9181w+rOJGuOqsCRT7wZEpdBIgYfCGM1iEWyJZ+pM/AIRdvb
	 t+4IJEcSfkiqw==
Date: Wed, 9 Jul 2025 19:23:39 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, nnac123@linux.ibm.com,
	bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net] ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS
 with dynamic sizeof
Message-ID: <20250709182339.GJ721198@horms.kernel.org>
References: <20250709153332.73892-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709153332.73892-1-mmc@linux.ibm.com>

On Wed, Jul 09, 2025 at 08:33:32AM -0700, Mingming Cao wrote:
> The previous hardcoded definitions of NUM_RX_STATS and
> NUM_TX_STATS were not updated when new fields were added
> to the ibmvnic_{rx,tx}_queue_stats structures. Specifically,
> commit 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx
> batched") added a fourth TX stat, but NUM_TX_STATS remained 3,
> leading to a mismatch.
> 
> This patch replaces the static defines with dynamic sizeof-based
> calculations to ensure the stat arrays are correctly sized.
> This fixes incorrect indexing and prevents incomplete stat
> reporting in tools like ethtool.
> 
> Fixes: 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx batched")
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
> Reviewed-by: Haren Myneni <haren@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

