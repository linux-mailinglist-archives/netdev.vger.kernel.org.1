Return-Path: <netdev+bounces-139088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4411A9B01EA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D2A1F2295A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E632022E9;
	Fri, 25 Oct 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECN0Czsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52201D8E1A
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858161; cv=none; b=GA43nQRAGA1ykSeYzEFf+pFOPDWpcqN7cbHTLvkvDzpctQbDUJJDfziaCXNAU76991551AFxh7clqJem5h5yBgj7Hu2PLgVksj4mcvD5y17TxEOQQ0U8LFJh6u7ChA5H64+tIwNoBTFHWgtlH2hsgnTAOqb80Pv24RV3MXONGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858161; c=relaxed/simple;
	bh=JhfMjhFUCVuqaK9d8S9QV++vZsKY6b2ohtnIlsZ7OKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiO0blBsVMcvBGx4ZlyObzZH+dr4thWCB1TGCHrmJ2NK4r8+eyhbr8pEywUOWSbo1WiKdrHLQtHCqJaTEVAHhB1R18PlCCnlnDbdaba+4Xrl3O5nePsxyKuWQlTbglSPjR4HTbSPs6uTgvGkh8m8RDut/6W76dnIfBtplx1hjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECN0Czsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B6EC4CEC3;
	Fri, 25 Oct 2024 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729858161;
	bh=JhfMjhFUCVuqaK9d8S9QV++vZsKY6b2ohtnIlsZ7OKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECN0CzspaWF22OptwNL8NwFnU+xjvMicfl6vuwT5Vym/Cwg+Q9ZQrv8EYHcmDT7SL
	 KJhdx55+AWuV+GVwkuI2vgs+yOxU/6bCtZ3UwbUqjRY02ad501zL25JtsRTNJ5QERP
	 PAbK4UFYKGEe2X+ZFX3iBrMc8yovMjxObLQFWyLEx9xk3/8MNjqCwo5Uv4nMaNF1dd
	 FpOuVnoh8ry/ru96pstwQILnr9REfZsy2Vnib1hH8hhrB7yon8IowtWHb9KN5sj0TP
	 FphYc9Fb+dGd+IKim/bFnWp4bqH4Pu1C+3d+RL/JTffJwaGHPGPkePg0BG7Jz5NLN9
	 CGPCULkfQkwVw==
Date: Fri, 25 Oct 2024 13:09:17 +0100
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
Message-ID: <20241025120917.GQ1202098@kernel.org>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
 <20241023080921.326-2-thunder.leizhen@huawei.com>
 <20241024121325.GJ1202098@kernel.org>
 <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>
 <20241024152704.GZ1202098@kernel.org>
 <c04f1ab2-54de-368c-d80b-f9716a944c30@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04f1ab2-54de-368c-d80b-f9716a944c30@huawei.com>

On Fri, Oct 25, 2024 at 12:17:17PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/10/24 23:27, Simon Horman wrote:
> > On Thu, Oct 24, 2024 at 09:26:30PM +0800, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2024/10/24 20:13, Simon Horman wrote:
> >>> On Wed, Oct 23, 2024 at 04:09:20PM +0800, Zhen Lei wrote:
> >>>> Fix the incorrect return value check for debugfs_create_dir() and
> >>>> debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
> >>>> when it fails.
> >>>>
> >>>> Commit 4ad23d2368cc ("bna: Remove error checking for
> >>>> debugfs_create_dir()") allows the program to continue execution if the
> >>>> creation of bnad->port_debugfs_root fails, which causes the atomic count
> >>>> bna_debugfs_port_count to be unbalanced. The corresponding error check
> >>>> need to be added back.
> >>>
> >>> Hi Zhen Lei,
> >>>
> >>> The documentation for debugfs_create_dir states:
> >>>
> >>>  * NOTE: it's expected that most callers should _ignore_ the errors returned
> >>>  * by this function. Other debugfs functions handle the fact that the "dentry"
> >>>  * passed to them could be an error and they don't crash in that case.
> >>>  * Drivers should generally work fine even if debugfs fails to init anyway.
> >>>
> >>> Which makes me wonder why we are checking the return value of
> >>> debugfs_create_dir() at all. Can't we just take advantage of
> >>> it not mattering, to debugfs functions, if the return value
> >>> is an error or not?
> >>
> >> Do you want to ignore all the return values of debugfs_create_dir() and debugfs_create_file()?
> >> "bna_debugfs_root = debugfs_create_dir("bna", NULL);" and debugfs_create_file() is OK.
> >> I've carefully analyzed the current code, and "bnad->port_debugfs_root = debugfs_create_dir(...);"
> >> is also OK for now.
> > 
> > What I'm saying is that it is unusual to depend on the return value of
> > debugfs_create_dir() for anything. And it would be best to avoid doing so.
> > 
> > But perhaps that isn't possible for some reason?
> 
> OK, I understand now. Please forgive my poor English. Combine Andrew's reply
> and my analysis above. The return value check for the remaining two places
> should now be removed.

Thanks. Sorry that I was not clearer.

...

