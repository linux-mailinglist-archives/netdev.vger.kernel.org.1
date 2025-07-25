Return-Path: <netdev+bounces-209989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA752B11B28
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 11:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872D23A676F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B22D3734;
	Fri, 25 Jul 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF3xZeA3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9D2D1920;
	Fri, 25 Jul 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437106; cv=none; b=ETmIRQyWA/8etJL3d3f0zeq2N07/oNFpfl/wF4UL0EBNcQx/FDCHiqaKKmFoiAmhZEtf5cIaxmZHovgtYq/yF5vJ94COy8PU+1xRvF2fvgobpfkbakLftd8ga8yUwxrxa9IHH9sCBQvr+LXuaoNgAITtIjxIA84e6pEWDA85cXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437106; c=relaxed/simple;
	bh=CslKMzEgNIx06AGoQ7+B9pcd0N2hOUm31pNgdyNe0xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMBBfcUJDl/TwLn5RuQcDep1QZkN7J8rxSJA0UH8yR8si4mD0f0Im1C/96S27+IZuJXtl/gfHtHazkJl6N8lTmTio6GyVIHjqeMSyEYxm88g4lGsBGC3VdlMZ5MByaoMGwWcqBkBJJ60no5vYBDbSMkSTixdnKqNX8KCvR/EmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF3xZeA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94577C4CEE7;
	Fri, 25 Jul 2025 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753437106;
	bh=CslKMzEgNIx06AGoQ7+B9pcd0N2hOUm31pNgdyNe0xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hF3xZeA3oED1lWe1F0MTD4LkfodA1ZbLBbrtSCZ7ofmL9oFhNjwArAmHpXkizj3Jw
	 zm5Ld8Cm52fbNhRnCOtjQZ9DV4eQ0rVshGpxJRgogB4iJpk6xJVno9z2WBGov4ZZXz
	 bhGUD7BKYw7Ba+atf5GSeZ4BdrSnIjM+JTgGzXe+qoz/L8EQixJZbemqmt2MrnWbSp
	 fzDacgCX3ppehjEoDQiNO/TzOnUrcjwtVTo9ioRlvOS8r0X6SjaNIf/2WUUTsSOXXc
	 IeozNVGS7LOxpkdLxUt0Wjv99cH0nmde8wgYj+cmbjXYeYvrpNJsAMY1MWGgl2sqMO
	 HfnQsXQYPpfKQ==
Date: Fri, 25 Jul 2025 10:51:40 +0100
From: Simon Horman <horms@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <20250725095140.GC1367887@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <20250722112909.GF2459@horms.kernel.org>
 <0E9C9DD4FB65EC52+20250723030111.GA169181@nic-Precision-5820-Tower>
 <20250723200934.GO1036606@horms.kernel.org>
 <173AE84ACE4EE2AE+20250724061047.GA153004@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173AE84ACE4EE2AE+20250724061047.GA153004@nic-Precision-5820-Tower>

On Thu, Jul 24, 2025 at 02:10:47PM +0800, Yibo Dong wrote:
> On Wed, Jul 23, 2025 at 09:09:34PM +0100, Simon Horman wrote:
> > On Wed, Jul 23, 2025 at 11:01:11AM +0800, Yibo Dong wrote:
> > > On Tue, Jul 22, 2025 at 12:29:09PM +0100, Simon Horman wrote:
> > > > On Mon, Jul 21, 2025 at 07:32:24PM +0800, Dong Yibo wrote:
> > 
> > ...
> > 
> > > But I can't get this warning follow steps in my local:
> > > ---
> > > - make x86_64_defconfig
> > > - make menuconfig  (select my driver rnpgbe to *)
> > > - make W=1 -j 20
> > > ---
> > > if I compile it with 'make W=1 C=1 -j 20', some errors like this:
> > > ---
> > > ./include/linux/skbuff.h:978:1: error: directive in macro's argument list
> > > ./include/linux/skbuff.h:981:1: error: directive in macro's argument list
> > > ........
> > > Segmentation fault
> > > ---
> > > I also tried to use nipa/tests/patch/build_allmodconfig_warn
> > > /build_allmodconfig.sh (not run the bot, just copy this sh to source
> > > code). It seems the same with 'make W=1 C=1 -j 20'.
> > > Is there something wrong for me? I want to get the warnings locally,
> > > then I can check it before sending patches. Any suggestions to me, please?
> > > Thanks for your feedback.
> > 
> > I would expect what you are trying to work.
> 
> I want to reproduce the warning locally, like this: 
> 'warning: symbol 'rnpgbe_driver_name' was not declared. Should it be static'
> Then, I can check codes before sending patches.

Yes, I think that is a very good plan.

> > And I certainly would not expect a segmentation fault.
> > 
> > I suspect that the version of Sparse you have is causing this problem
> > (although it is just a wild guess). I would suggest installing
> > from git. http://git.kernel.org/pub/scm/devel/sparse/sparse.git
> > 
> > The current HEAD is commit 0196afe16a50 ("Merge branch 'riscv'").
> > I have exercised it quite a lot.
> > 
> 
> nice, after installation, it works. I reproduced the warning, thanks.

Excellent.

> 
> > For reference, I also use:
> > GCC 15.1.0 from here: https://mirrors.edge.kernel.org/pub/tools/crosstool/
> > Clang 20.1.8 from here: https://mirrors.edge.kernel.org/pub/tools/llvm/
> > (Because they are the latest non -rc compilers available there)
> > 
> > 
> 

