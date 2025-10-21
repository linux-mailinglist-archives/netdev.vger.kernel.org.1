Return-Path: <netdev+bounces-231115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1107BF55BF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 902874F27BF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BF2777FC;
	Tue, 21 Oct 2025 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="a8lHBt0/"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B1252906
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036617; cv=none; b=qY5Oli8EOHE9MRc5qURX83Y4BXeh1dcW4rBrpaxmBJsGkuasT48s+xmzsbnuFSVM6n5iouAyAQ504JLDG4jtKW+w1f1VReWYTvKpI6+MjeUGvpWwMu04oPq1Lq/Qrodu/y+/+wxMIIooLsw5c9EX+mokAu4wt9M55eJOXPPaPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036617; c=relaxed/simple;
	bh=wndupjH5Sua+28vDjCRLmOOCVxHW++gOVaUH97vw8/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdPyh/kM1vVgmHa2kSSzpaD6FuovaZlZ0i/vviB3IcwwWxHJG3RersNi0PjQCFffnuabOxnTTPDZfmQJBzhQ8xqtjv/6LDPks79SwFt9f/WTvhZHS1RYtnRkI47jjhZV8SSsm0vXyWKZIpThG0naBF1sL4JGkMtuVUB2ioSdrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=a8lHBt0/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0A43620839;
	Tue, 21 Oct 2025 10:50:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0wuVR7HoUC-t; Tue, 21 Oct 2025 10:50:04 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0410A206BC;
	Tue, 21 Oct 2025 10:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0410A206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1761036604;
	bh=RUBh9UYVKUuQsKDTiQthbtQrX8SdUP8OP+RYt7Uq1fI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=a8lHBt0/Swo3Jo5Eqqw2OLd7C8EroKgncC7mCh+NhNY0tFXgVspUmj9gAtRNPqasj
	 ZOPXl5RInLfqPZ07iJAHdG4lam80d33iMpmPZQb3x68SBPBIZdHkNHrTzu7elvD7qM
	 sY51iV3NQMXhe+b65QZFWkhj+UWOuyq8kHGYrUDsj5quTvmoXGoDbPejq7R6pDXco5
	 pNW+N5Ju/3BWgFG8X1Gg7+BurUTA3qDnIUxeoehQ2sgETBSrgcoBXdNnZhfOg7WkCA
	 aCmXkv2y5lXNnfc5vBp1M4Upi36lyxUc4O/aJlN5i9A1do0lpBfx2jJgy6fUpg8pZy
	 QpKzIZmJYtJhg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 21 Oct
 2025 10:50:03 +0200
Received: (nullmailer pid 2817729 invoked by uid 1000);
	Tue, 21 Oct 2025 08:50:03 -0000
Date: Tue, 21 Oct 2025 10:50:03 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>, kernel test
 robot <lkp@intel.com>, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH ipsec 6/6] xfrm: check all hash buckets for leftover
 states during netns deletion
Message-ID: <aPdJO3k9C-bhqHSQ@secunet.com>
References: <2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd@queasysnail.net>
 <202510172159.iLR9bfcc-lkp@intel.com>
 <aPVtmloGOCQi_7ue@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPVtmloGOCQi_7ue@krikkit>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

Hi Sabrina,

On Mon, Oct 20, 2025 at 01:00:42AM +0200, Sabrina Dubroca wrote:
> Hi Steffen,
> 
> 2025-10-17, 23:10:36 +0800, kernel test robot wrote:
> > Hi Sabrina,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on klassert-ipsec-next/master]
> > [also build test WARNING on klassert-ipsec/master net/main net-next/main linus/master v6.18-rc1 next-20251016]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sabrina-Dubroca/xfrm-drop-SA-reference-in-xfrm_state_update-if-dir-doesn-t-match/20251016-184507
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
> > patch link:    https://lore.kernel.org/r/2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd%40queasysnail.net
> > patch subject: [PATCH ipsec 6/6] xfrm: check all hash buckets for leftover states during netns deletion
> > config: x86_64-randconfig-r123-20251017 (https://download.01.org/0day-ci/archive/20251017/202510172159.iLR9bfcc-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172159.iLR9bfcc-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202510172159.iLR9bfcc-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> [...]
> >   3308	void xfrm_state_fini(struct net *net)
> >   3309	{
> >   3310		unsigned int sz;
> >   3311		int i;
> >   3312	
> >   3313		flush_work(&net->xfrm.state_hash_work);
> >   3314		xfrm_state_flush(net, 0, false);
> >   3315		flush_work(&xfrm_state_gc_work);
> >   3316	
> >   3317		WARN_ON(!list_empty(&net->xfrm.state_all));
> >   3318	
> >   3319		for (i = 0; i <= net->xfrm.state_hmask; i++) {
> > > 3320			WARN_ON(!hlist_empty(net->xfrm.state_byseq + i));
> 
> So, before my patch there was a sparse waraning on the
> 
> 	WARN_ON(!hlist_empty(net->xfrm.state_by*));
> 
> lines, and now there's a sparse warning on the loop.
> (and plenty on other lines in net/xfrm/xfrm_state.c)
> 
> This bot message gave me the push to finally take a look at all the
> sparse warnings in net/xfrm/xfrm_state.c, I have solutions for a big
> chunk of them (and a few in other files).
> 
> If you want to drop this patch from the set, I'll re-send it later, on
> top of the sparse stuff. The rest of the series works without it. If
> you want to take it as is, it doesn't change the sparse situation in
> this file (a few warnings moved around) and I'll do the sparse
> cleanups on top of it.

I'll take the patchset as is and wait for your sparse fixes on top.

Thanks!

