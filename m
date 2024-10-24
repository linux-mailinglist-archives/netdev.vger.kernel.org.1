Return-Path: <netdev+bounces-138725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489B9AEA5C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B0C1C22AD2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967A81EC006;
	Thu, 24 Oct 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcHnmH29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703261EABDF
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783628; cv=none; b=dNfqP+iArx1Syvdn1Ucf5sYRd4Fj8248bUgswYOnAlYLIwibeAE0ulYzBuC3C22wUh2lW/eZsatq6sCuJcVygf3aVXSpk3smlvCp5ZTe+Ckp1rSf909Hv9qddrQcAhIDRfmLI1tT2musI/QTSKoEjGbobOPxT+o2GQp1Hqb0USo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783628; c=relaxed/simple;
	bh=104Vhor7ZYpfQ65jwmwwWPHwxqkG4KJ8b/4ibDgqmM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2n74qvARhgzUXJIyqOSlaVnmjMnZh/D4CbL3svvo+1/mOh6FnXfBZxGTQdQAmPMiHr4YN9HCmaTg3o4suybFAeyz0jpGXfGt77K2jvNszZwOrEW+8iO0eL9ycm2HNfyXxBDFHGMDjpTQ7hshUJ2rb/MJC4fl/iv5kmZUCY0bzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcHnmH29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59788C4CEC7;
	Thu, 24 Oct 2024 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783628;
	bh=104Vhor7ZYpfQ65jwmwwWPHwxqkG4KJ8b/4ibDgqmM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcHnmH29ZwqO/tsiWi67RZTNIzk/6UgPnOxILrBDZPSVBXsUeA7SRLKCTjkQ/EgtN
	 2SwQXUpD2Yx/U504tfuKu7weMeGoAHGPY5C+HpugVeAstpwtX2dOZE1P3spRQD3Y6E
	 RLcP2fV5on74oD3xxeQomaW3LFlKHOZOMwREPbRYGTrLHAq6dVtOq/1jk8waouwBbx
	 oJHpJgiCb/PnI3adhng74gzHFu06Bbb1vbSdO/GfydjkSthW+FvcBbhfQ8INuaNbBs
	 zqEumK4N2QY5zeITtuWmLhuaIy0DF0lMvBwAkeNyC7LQxSmP0YjXxubmzxEJme9Bwu
	 d7xPRsFAQ4TzA==
Date: Thu, 24 Oct 2024 16:27:04 +0100
From: Simon Horman <horms@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] bna: Fix return value check for debugfs create APIs
Message-ID: <20241024152704.GZ1202098@kernel.org>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
 <20241023080921.326-2-thunder.leizhen@huawei.com>
 <20241024121325.GJ1202098@kernel.org>
 <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>

On Thu, Oct 24, 2024 at 09:26:30PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/10/24 20:13, Simon Horman wrote:
> > On Wed, Oct 23, 2024 at 04:09:20PM +0800, Zhen Lei wrote:
> >> Fix the incorrect return value check for debugfs_create_dir() and
> >> debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
> >> when it fails.
> >>
> >> Commit 4ad23d2368cc ("bna: Remove error checking for
> >> debugfs_create_dir()") allows the program to continue execution if the
> >> creation of bnad->port_debugfs_root fails, which causes the atomic count
> >> bna_debugfs_port_count to be unbalanced. The corresponding error check
> >> need to be added back.
> > 
> > Hi Zhen Lei,
> > 
> > The documentation for debugfs_create_dir states:
> > 
> >  * NOTE: it's expected that most callers should _ignore_ the errors returned
> >  * by this function. Other debugfs functions handle the fact that the "dentry"
> >  * passed to them could be an error and they don't crash in that case.
> >  * Drivers should generally work fine even if debugfs fails to init anyway.
> > 
> > Which makes me wonder why we are checking the return value of
> > debugfs_create_dir() at all. Can't we just take advantage of
> > it not mattering, to debugfs functions, if the return value
> > is an error or not?
> 
> Do you want to ignore all the return values of debugfs_create_dir() and debugfs_create_file()?
> "bna_debugfs_root = debugfs_create_dir("bna", NULL);" and debugfs_create_file() is OK.
> I've carefully analyzed the current code, and "bnad->port_debugfs_root = debugfs_create_dir(...);"
> is also OK for now.

What I'm saying is that it is unusual to depend on the return value of
debugfs_create_dir() for anything. And it would be best to avoid doing so.

But perhaps that isn't possible for some reason?

> 
> bnad_debugfs_init():
> 	bnad->port_debugfs_root = debugfs_create_dir(name, bna_debugfs_root);	//IS_ERR() if fails
> (1)
> 	atomic_inc(&bna_debugfs_port_count);
> 
> bnad_debugfs_uninit():
> (2)	if (bnad->port_debugfs_root)						//It still works when it's IS_ERR()
> 		atomic_dec(&bna_debugfs_port_count);
> 
> 	if (atomic_read(&bna_debugfs_port_count) == 0)
> 		debugfs_remove(bna_debugfs_root);
> 
> If we want the code to be more robust or easier to understand, it is better
> to modify (1) and (2) above as follows:
> (1) if (IS_ERR(bnad->port_debugfs_root))
> 	return;
> (2) if (!IS_ERR_OR_NULL(bnad->port_debugfs_root))
> 
> > 
> >> Fixes: 4ad23d2368cc ("bna: Remove error checking for debugfs_create_dir()")
> >> Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > ...
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

