Return-Path: <netdev+bounces-190164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9AFAB5657
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757103BB1C2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E78290BCD;
	Tue, 13 May 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA03Tyxp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7428640E;
	Tue, 13 May 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143664; cv=none; b=Y4Tb3Zjzh6BFIaOeQZIHdxo/YAiglx+wbeKhzHnq4lAcQLECgEjRNf1pSaYz9r6BvCTebjyiSJL4aLYHU6yPcTqXRSSoCiFlPqr0UoqCQVUgduXu52Tfw/hYn82B+4QFy3Dkk02h4cFkS99HX0taOCt8JKN9X7xDGWoiFzrFXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143664; c=relaxed/simple;
	bh=S00eQUskUp0D65XsF+o/OCXFi+oPqCIXuzNkGKHgNjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQGAwuuleQ2GzPqkvTISB2eSkiQe5pCQTtCbf2me8ZWqHupFSwnizqKumfs0tzCykxrmaDqa3V81Hsx33tUvuQ5q6TtFB6Yd/ST07sl4VhfcyCh6ESQvgVLQ1EFVX6kidYMsSjfQ6dqP2Ftshc2M8WKbv5M3UU3vFE41HTp29W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA03Tyxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47246C4CEE4;
	Tue, 13 May 2025 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747143664;
	bh=S00eQUskUp0D65XsF+o/OCXFi+oPqCIXuzNkGKHgNjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sA03TyxpdSkLcwUQ6qaOB9Kn1Tplkuq75cj2Zf4bbNLaRdG+LXqWkFjj91hDS4zWs
	 +tlyO0fPEGFlzjTNk01cKiEmKosvj0hwU17+nM7m77dDSIAdp9kpULZenwB21O0vyw
	 wgJYKLIxf4rnLtTZbVXhR3sUmENZWweOs1NdHo+X9hX6KNxC+ulrptUkxmMb7ysg8Y
	 +5ZlsMPZOb6uTT78QuRBIBJFUMP22YkTwXUx1GxB6tn9xF/RibgfQAwXr4dH/ZEW9V
	 AaO93EmzvnPamQ0UydWpVQ74EW/eHcfM7e5yEfRZZDiSgTvo0GIhmzWo5QmsYk5ONl
	 DeMdEv8DRHyrA==
Date: Tue, 13 May 2025 14:40:55 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
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
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: Re: [PATCH iwl-next v3 00/15] Introduce iXD driver
Message-ID: <20250513134055.GB3339421@horms.kernel.org>
References: <20250509134319.66631-1-larysa.zaremba@intel.com>
 <20250512124906.GA1417107@horms.kernel.org>
 <aCH19kCiDI0GUs8s@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCH19kCiDI0GUs8s@soc-5CG4396X81.clients.intel.com>

On Mon, May 12, 2025 at 03:21:58PM +0200, Larysa Zaremba wrote:
> On Mon, May 12, 2025 at 01:49:06PM +0100, Simon Horman wrote:
> > On Fri, May 09, 2025 at 03:42:57PM +0200, Larysa Zaremba wrote:
> > > This patch series adds the iXD driver, which supports the Intel(R)
> > > Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
> > > It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> > > exposed by the same card. The reason for the separation is to be able
> > > to offload the control plane to the host different from where the data
> > > plane is running.
> > > 
> > > This is the first phase in the release of this driver where we implement the
> > > initialization of the core PCI driver. Subsequent phases will implement
> > > advanced features like usage of idpf ethernet aux device, link management,
> > > NVM update via devlink, switchdev port representors, data and exception path,
> > > flow rule programming, etc.
> > 
> > Hi Larysa,
> > 
> > I am having a bit of trouble figuring out where to cleanly apply this
> > series to. Could you help me out?
> 
> Tree did change quite a bit in a short span of time between me fetching and 
> sending, sorry for the trouble.
> 
> The base commit is 10f540c09cf9 "ice: default to TIME_REF instead of TXCO on 
> E825-C". In case you cannot access it, I have pushed the tree to my github.
> 
> https://github.com/walking-machine/linux/commits/ixd_phase1_iwl_v3

Thanks. I did not have that commit present locally, but I was able
to fetch it from the URL above. And the series did indeed apply cleanly
on top of it.

> This version is probably much closer to what would be in dev-queue eventually, 
> compared to a properly rebased one. Some patches were pulled out of dev-queue 
> because of validation problems, but should be back pretty soon, as far as I 
> know. Those patches are the reason why I have an additional fix in the github 
> tree.

Understood.

