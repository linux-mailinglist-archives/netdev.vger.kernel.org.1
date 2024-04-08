Return-Path: <netdev+bounces-85677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E0689BD77
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6CB9B21FDA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E685F87B;
	Mon,  8 Apr 2024 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yb3CGR6A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865085EE8D
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573230; cv=none; b=siX12w/JTFtSWMIhp2cqwlQSSbCvGSrtOwjodYHojKCvyIKozJ5JXAFrEjoSFWN8CFh7pzz6AZbHCRPXvNeJ+onq10k4+9+Tm0yytq6sdZV+MaGEG2OAiZLIU/A+V+RQNdb7COJLGHNR+dmaHnxw12lg4deJa+miQCV3Cph58L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573230; c=relaxed/simple;
	bh=ObdaVqWgs3SFyts3ryQluWw9JpSdn/slwfXRdChB01c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtMTGG6Hyv9kAO3XIrf5RgZWKKc7/dXABXQaHwWld7+Y135pyYbKZxmRge0oWv7DNtUJguQm5UbHdgFvbH5UJklxEMVB4Je9wbD0KaE8Rw1Q3ISVk3GbvP+kC2OZbhh49L2o57s2doeL/KrPz5hQsodVJU2tcZkKFRTGLDl/g4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yb3CGR6A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712573226; x=1744109226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObdaVqWgs3SFyts3ryQluWw9JpSdn/slwfXRdChB01c=;
  b=Yb3CGR6ArvcfjK4RLZwfRm/FOpLC46VQ5qySWNHz1+bRxUghP/Zuas75
   6vd2OuT5viEM0xFBWxiuSs5ngHjXx5mOhcu2k4ObmvjIEqyCybwmWblR9
   gKZL9wBiFOwcQ30oDdMExJEu2vwRuLWDde07hVmlv1yzsDc3b5MhvYo19
   sHlM3Mv0S1kA2JMn7XUyqtkr9POK80oJgPFwE9TbtyjKYf0grhp06f6BC
   Fm/plKkbQjliLgVrIck22iolO+Z15U4BjKIV+nX+a71HgtT7a/t6wzqWT
   qaWil7gTfMeJGHyVYzUGmxZ2E0JZ8qvfNJLgvE8+qdFjgzh6Odc+kjAbI
   A==;
X-CSE-ConnectionGUID: P/pGYJzWRDGCOOSAO2RIxQ==
X-CSE-MsgGUID: 1p5ElsS7TT6NdFSrIj6hTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11617704"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="11617704"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:47:03 -0700
X-CSE-ConnectionGUID: sEidQA7XQmawayL06aZHqQ==
X-CSE-MsgGUID: csSWIVYjQc+V4OfcxJAKhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="51029981"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:47:01 -0700
Date: Mon, 8 Apr 2024 12:46:42 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [net-next v2] pfcp: avoid copy warning by simplifing code
Message-ID: <ZhPLEuZQ0T7mQHHT@mev-dev>
References: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>
 <20240408081829.GC26556@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408081829.GC26556@kernel.org>

On Mon, Apr 08, 2024 at 09:18:29AM +0100, Simon Horman wrote:
> On Fri, Apr 05, 2024 at 08:36:05AM +0200, Michal Swiatkowski wrote:
> > >From Arnd comments:
> > "The memcpy() in the ip_tunnel_info_opts_set() causes
> > a string.h fortification warning, with at least gcc-13:
> > 
> >     In function 'fortify_memcpy_chk',
> >         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
> >         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
> >     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >       553 |                         __write_overflow_field(p_size_field, size);"
> > 
> > It is a false-positivie caused by ambiguity of the union.
> > 
> > However, as Arnd noticed, copying here is unescessary. The code can be
> > simplified to avoid calling ip_tunnel_info_opts_set(), which is doing
> > copying, setting flags and options_len.
> > 
> > Set correct flags and options_len directly on tun_info.
> > 
> > Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Closes: https://lore.kernel.org/netdev/701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com/
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> I agree that it's nice to avoid a copy.
> But I do wonder where else this pattern may exist.
> And if it might be worth introducing a helper for it.

Right, the same is done in vxlan, ip_gre and ip6_gre at least. I will
send v3 with helper.

Thanks,
Michal

> 
> Regardless, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

