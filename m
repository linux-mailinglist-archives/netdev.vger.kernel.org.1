Return-Path: <netdev+bounces-181303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CDDA8458E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2006E3B69D3
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00712857E0;
	Thu, 10 Apr 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKApxj71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECE26ACB;
	Thu, 10 Apr 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293528; cv=none; b=c9iLW9+ZZe3gFcYyz4iXeuTFFSYkXPdsZBUzPc+dt4bVvHbOrcCnWmGZnKv2MRqHd46kpcqfMsAKVWD2+OLgItflVfMXJxY3SH/9bBdLwoGOAODNOYN7pjbS8GYPxpZsO0IyPuIjZBjYJQ4xCgukpUpbTMLiCO+2SZjGSuXwhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293528; c=relaxed/simple;
	bh=tc3sjsEyh+ECbexe09u7lpewpQnE1mf7v/fkj4+zOy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJyHdYHyWdIL0RMzm/2m/yY+6z5bQOV5+TeVB8pg7Wg69LWpr2Bk/d+FlbR3CEBK/wXbUaQjdn84Xh3fMuY8ESyTOdnnXg+zxIPg/7IHVu9MlxiKDddj7VOizUjZYSCYnc0tCdf84p8Dccw1N7XALiv0hk9vQHaP0S5DHVMxitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKApxj71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061C7C4CEDD;
	Thu, 10 Apr 2025 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744293528;
	bh=tc3sjsEyh+ECbexe09u7lpewpQnE1mf7v/fkj4+zOy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKApxj71kO7MtG3mvtlzsnBLPdsk6DOvpqsDJLj5Zp2cK0YLoAFOsmy157pN4IXf2
	 BZ428qjsIMaN2cDly63aH7BoR4eqDIQA/J10/KETejdkzXCHVDNaTx5Gtb7YfYUCz5
	 OMyBZ7xyBzph+iaBZXlVpXZHQkGJDDf71Ct49kMF8E6u4HXJxxIV9ZuICkRQFon32x
	 AkUQWwvQB9uosvTnIs+rOib20WBt2FSJZe3ilEJpwdMpBF0llh0wCrxoUpS8LACVfM
	 xFp2XDBhNNWjN+DF5IkSDGRNewTMEgcItf9JkODT7Js4xgeHryVP9R20ppzOgkJ2C6
	 nw1+mRfubH16g==
Date: Thu, 10 Apr 2025 16:58:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Phani R Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH iwl-next 05/14] libeth: add control queue support
Message-ID: <20250410135843.GV199604@unreal>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
 <20250410082137.GO199604@unreal>
 <Z_ehEXmlEBREQWQM@soc-5CG4396X81.clients.intel.com>
 <20250410112349.GP199604@unreal>
 <Z_fAdLJ4quuP2lip@soc-5CG4396X81.clients.intel.com>
 <20250410132706.GR199604@unreal>
 <7e3f2eb8-b668-4ac5-8b49-43eebff2b3e0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3f2eb8-b668-4ac5-8b49-43eebff2b3e0@intel.com>

On Thu, Apr 10, 2025 at 03:33:40PM +0200, Alexander Lobakin wrote:
> From: Leon Romanovsky <leon@kernel.org>
> Date: Thu, 10 Apr 2025 16:27:06 +0300
> 
> > On Thu, Apr 10, 2025 at 02:58:28PM +0200, Larysa Zaremba wrote:
> >> On Thu, Apr 10, 2025 at 02:23:49PM +0300, Leon Romanovsky wrote:
> >>> On Thu, Apr 10, 2025 at 12:44:33PM +0200, Larysa Zaremba wrote:
> >>>> On Thu, Apr 10, 2025 at 11:21:37AM +0300, Leon Romanovsky wrote:
> >>>>> On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
> >>>>>> From: Phani R Burra <phani.r.burra@intel.com>
> >>>>>>
> >>>>>> Libeth will now support control queue setup and configuration APIs.
> >>>>>> These are mainly used for mailbox communication between drivers and
> >>>>>> control plane.
> >>>>>>
> >>>>>> Make use of the page pool support for managing controlq buffers.
> >>>>>
> >>>>> <...>
> >>>>>
> >>>>>>  libeth-y			:= rx.o
> >>>>>>  
> >>>>>> +obj-$(CONFIG_LIBETH_CP)		+= libeth_cp.o
> >>>>>> +
> >>>>>> +libeth_cp-y			:= controlq.o
> >>>>>
> >>>>> So why did you create separate module for it?
> >>>>> Now you have pci -> libeth -> libeth_cp -> ixd, with the potential races between ixd and libeth, am I right?
> >>>>>
> >>>>
> >>>> I am not sure what kind of races do you mean, all libeth modules themselves are 
> >>>> stateless and will stay this way [0], all used data is owned by drivers.
> >>>
> >>> Somehow such separation doesn't truly work. There are multiple syzkaller
> >>> reports per-cycle where module A tries to access module C, which already
> >>> doesn't exist because it was proxied through module B.
> >>
> >> Are there similar reports for libeth and libie modules when iavf is enabled?
> > 
> > To get such report, syzkaller should run on physical iavf, it looks like it doesn't.
> > Did I miss it here?
> > https://syzkaller.appspot.com/upstream/s/net
> > 
> >> It is basically the same hierarchy. (iavf uses both libeth and libie, libie 
> >> depends on libeth).
> >>
> >> I am just trying to understand, is this a regular situation or did I just mess 
> >> smth up?
> > 
> > My review comment was general one. It is almost impossible to review
> > this newly proposed architecture split for correctness.
> > 
> >>
> >>>
> >>>>
> >>>> As for the module separation, I think there is no harm in keeping it modular. 
> >>>
> >>> Syzkaller reports disagree with you. 
> >>>
> >>
> >> Could you please share them?
> > 
> > It is not an easy question to answer, because all these reports are complaining
> > about some wrong locking order or NULL-pointer access. You will never know if
> > it is because of programming or design error.
> > 
> > As an approximate example, see commits a27c6f46dcec ("RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier")
> > and f0df225d12fc ("RDMA/bnxt_re: Add sanity checks on rdev validity").
> > At the first glance, they look unrelated to our discussion, however
> > they can serve as an example or races between deinit/disable paths in
> > parent module vs. child.
> 
> Unrelated. At first, you were talking about module dependencies, now
> you're talking about struct device etc dependencies, which is a
> completely different thing.
> 
> As already said, libeth is stateless, so the latter one can't happen.
> The former one is impossible at all. As long as at least 1 child module
> is loaded, you can't unload the parent. And load/unload is serialized,
> see module core code.

It is not only module load/unload. It is bind/unbind, devlink operations
e.t.c, everything that can cause to reload driver in module C.

Thanks

