Return-Path: <netdev+bounces-96365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF48C5755
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D19281FD8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5681448D4;
	Tue, 14 May 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+nwBFyI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45C135A40;
	Tue, 14 May 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694389; cv=none; b=kErFygxB9XKPbUC7BLddBRW6EnsgTKfGE0VNYy3bxf9qUrXiYdr79u46ZBo5ScI/lMK076s6262nBXddbfceSd6nkvTkjSCLInXjMWJ8rr2gJqgOCBJS3Lo2sHUF/HtFuQ30C6gENiSUyZUdEOpobCC1OzhVBxNZYsVOwCQ6eQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694389; c=relaxed/simple;
	bh=zBSGEEVkAYXfxfHKmHO3J9UMnIn9Z43RNoE8U8/JUJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXT1sNrOGL/2b7UZwGHW3lbIlnJdMmY4xTjb79DninaNE7IrqD7qZ9mM7MwfT4T7eHo3mOUttWGPK09GJmFfk66Ll8jC9fCWN8f+l0ouB4ExJVN7toodN8CIMh9bhB0EFjFbJ6jo7S7RWdnmg2FtD4B9K1ia8pvXrjBdhaYrKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+nwBFyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49328C2BD10;
	Tue, 14 May 2024 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715694388;
	bh=zBSGEEVkAYXfxfHKmHO3J9UMnIn9Z43RNoE8U8/JUJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+nwBFyIporfF0UR4fTxoN8Lx4/bsH7hRvZEErPJk897JJ3CMiUBYxZKLILVJY5is
	 pTOtImxqbpf50N34AaIr58fAovsJ3UZeVT6U49wtDBhi7qyd4XSQRyEPKjYMwdt9Uz
	 g7RQ+0I7lkvQimxMs9+w3cdebdI0Wbv+SrbxI6S1DBEc+V8Kn/m1y7XoLn+dpRwTm+
	 p/lfrJFNQPkOZm+ZkwmPeYH3kU9o2CzYBj2NLd6XoCY6FRqoera6YlYyvylZN04hiH
	 wzt/rhaBxz1IZuXW6/NsZ5uzEGPq5MF9oVTKVEEpZx0spfVYDpKLMIfzFObhT6k9Lp
	 WT2ozW4nGRFYw==
Date: Tue, 14 May 2024 06:46:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Jason
    Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett    Creeley <bcreeley@amd.com>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan    Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>,
 Paul    Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki
 <ahmed.zaki@intel.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, donald.hunter@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240514064626.44778d98@kernel.org>
In-Reply-To: <1715652495.6335685-4-hengqi@linux.alibaba.com>
References: <20240509044747.101237-1-hengqi@linux.alibaba.com>
	<20240509044747.101237-3-hengqi@linux.alibaba.com>
	<202405100654.5PbLQXnL-lkp@intel.com>
	<1715531818.6973832-3-hengqi@linux.alibaba.com>
	<20240513072249.7b0513b0@kernel.org>
	<1715611933.2264705-1-hengqi@linux.alibaba.com>
	<20240513082412.2a27f965@kernel.org>
	<1715614744.0497134-3-hengqi@linux.alibaba.com>
	<20240513114233.6eb8799e@kernel.org>
	<1715652495.6335685-4-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 10:08:15 +0800 Heng Qi wrote:
> > We can't make lockdep dependent on NET.
> > People working on other subsystems should be able to use LOCKDEP 
> > with minimal builds.  
> 
> Got it. Then I declare "DIMLIB depends on NET" and clean up other places.

I'm not sure if there's any legit DIM (but not net_dim) user, if there
isn't that SGTM. The RDMA is fine to depend on NET.

> One more friendly request, I see net-next is closed today, but our downstream
> kernel release deadline is 5.20, so I want to test and release the new v14 today,
> is it ok?

You'll need to post as RFC since it can't be applied but you can post
to continue review. Please wait a day or two tho, I'm currently swamped
trying to go thru the PR preparations.

