Return-Path: <netdev+bounces-36207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3F7AE4B1
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 06:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6CD4E281C3B
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 04:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445C01104;
	Tue, 26 Sep 2023 04:47:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34621EDB
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2282C433C8;
	Tue, 26 Sep 2023 04:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695703639;
	bh=AMClMXoW/SwY9XBZNSxgkg0YbclLYYx39/FwqmsD/P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkUPrDB0Sc8Aa13mYevbDJwYR3shwPRBPjo91IL8D7otbra6/ar4Agns76mXyoPXl
	 eeLGRc3tuiE7WXxMCDYBWAQpvPaTcUqMM658ZkEJ/Mn3e0EzkKCRsBGeBPc1/c+lE0
	 m3yODV1yBiXYk1aszHeoF3KWwDedd6Iw704oDQ8E=
Date: Tue, 26 Sep 2023 06:47:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, jesse.brandeburg@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i40e: fix the wrong PTP frequency calculation
Message-ID: <2023092641-rind-seventh-c99b@gregkh>
References: <20230627022658.1876747-1-yajun.deng@linux.dev>
 <10269e86-ed8a-0b09-a39a-a5239a1ba744@intel.com>
 <72bfc00f-7c60-f027-61cb-03084021c218@linux.dev>
 <9e1b824f-04d3-4acb-66d3-a5f90afbad0e@intel.com>
 <ef08645e-9891-0d12-2c87-39ce0be52aee@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef08645e-9891-0d12-2c87-39ce0be52aee@linux.dev>

On Tue, Sep 26, 2023 at 09:54:29AM +0800, Yajun Deng wrote:
> 
> On 2023/9/26 07:59, Tony Nguyen wrote:
> > On 9/25/2023 12:55 AM, Yajun Deng wrote:
> > > 
> > > On 2023/6/28 04:20, Jacob Keller wrote:
> > > > 
> > > > On 6/26/2023 7:26 PM, Yajun Deng wrote:
> > > > > The new adjustment should be based on the base frequency, not the
> > > > > I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().
> > > > > 
> > > > > This issue was introduced in commit 3626a690b717 ("i40e: use
> > > > > mul_u64_u64_div_u64 for PTP frequency calculation"), and was fixed in
> > > > > commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
> > > > > parts per million"). However the latter is a new feature and
> > > > > hasn't been
> > > > > backported to the stable releases.
> > > > > 
> > > > > This issue affects both v6.0 and v6.1 versions, and the v6.1
> > > > > version is
> > > > > an LTS version.
> > > > > 
> > 
> > ...
> > 
> > > > 
> > > > Thanks for finding and fixing this mistake. I think its the
> > > > simplest fix
> > > > to get into the stable kernel that are broken, since taking the
> > > > adjust_by_scaled_ppm version would require additional patches.
> > > > 
> > > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > > > 
> > > Kindly ping...
> > 
> > As this patch looks to be for stable, you need to follow the process for
> > that. I believe your situation would fall into option 3:
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
> > 
> > 
> Yes, it needs an upstream commit ID. But this patch didn't need to apply to
> the upstream.
> 
> As the commit of the patch, the issue was fixed in
> commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
> parts per million"). However the commit is a new feature and hasn't been
> backported to the stable releases.
> 
> Therefore, the patch does not have an upstream commit ID, and only needs to
> be applied to stable.

That wasn't very obvious to most of us, perhaps resend it and explicitly
ask for acks/reviews so it can be only applied to the 6.1.y tree?

thanks,

greg k-h

