Return-Path: <netdev+bounces-84899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2134898964
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4453C283E87
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1E128818;
	Thu,  4 Apr 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYBoZ4Y0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482781272BB
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239176; cv=none; b=KBPPGtfDQl1fjB6KloxoIk0wuBqNxbsaDJrU1Vm0hCYTO89vOeTYsOM5KFCutv16EoVJZbczejYlWkgh1EPLIFwp5FI7wx0xsfbtsAaTQvW/D8imSmzLf7f5TUjbiWAYTZ2NFz6E00hcZKD/kdu7b3c27ROrfpz10YHqumRkzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239176; c=relaxed/simple;
	bh=pmmFduEtsh3CFaCz1t06RpvelcaDlp/p/S4Cuwhdxxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKNHGRiCPM0lFj5tBu3d5sYYuzKgeweLXTKwcwmLLBoWQmd4POcpkEhsNKy2XeTyIwM3Aj96J56PjqIWFbapFwkHsnYEJ6brzdHHjL2FV08AbhSKNZK0HK+W2S1+cnBJH7XCRYzHzs+I/1ahscYYDcvMxSscC+6Ekm7M+cAzdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYBoZ4Y0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239175; x=1743775175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pmmFduEtsh3CFaCz1t06RpvelcaDlp/p/S4Cuwhdxxw=;
  b=GYBoZ4Y0XITe8l+ecnONgRHiVvmxiR4ez1nKtSF3Zdiq5gU90V4xOFDS
   iHcB+cWjW6opNmvvgLNQOhD1MtYjGpZa+F+kAOH9bTm1xohsPqeZPbF5d
   5JfGMYZi4vZlZzZQi4d/zK29N996XJA8lrq7cw9nk2YtORvrLMuR5MKZG
   gvTkoiHmSJIEWIwIoDElnJI1pDfYIXGRQ4Aw12/FztTwEBOeM9VCMLK/c
   uPLVjKGlR9MZOgLOGuKLGm0N3ZUziVM7ieLQ3HWUZQqYDyKEibjQbjIBg
   dhRFk6bOBPH8FCvhVhqor4Ooi2Gv5zvdqrKGk5NMc+s4WrljbGomQxUib
   w==;
X-CSE-ConnectionGUID: BTwnYR01RxSlL79OzYFEMg==
X-CSE-MsgGUID: qU2C8fODRkuW+J2oHkdSNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18088835"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18088835"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:59:30 -0700
X-CSE-ConnectionGUID: Mytx7c3uR6WtmyHlaw0c7A==
X-CSE-MsgGUID: 88pH3e0rR/u8K9LEpA6RsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="41944969"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:59:28 -0700
Date: Thu, 4 Apr 2024 15:59:12 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [net-next v1] pfcp: avoid copy warning by simplifing code
Message-ID: <Zg6yMB/3w4EBQVDm@mev-dev>
References: <20240404135721.647474-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404135721.647474-1-michal.swiatkowski@linux.intel.com>

On Thu, Apr 04, 2024 at 03:57:21PM +0200, Michal Swiatkowski wrote:
> From Arnd comment:
> "The memcpy() in the ip_tunnel_info_opts_set() causes
> a string.h fortification warning, with at least gcc-13:
> 
>     In function 'fortify_memcpy_chk',
>         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
>         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
>     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>       553 |                         __write_overflow_field(p_size_field, size);"
> 
> It is a false-positivie caused by ambiguity of the union.
> 
> However, as Arnd noticed, copying here is unescessary. The code can be
> simplified to avoid calling ip_tunnel_info_opts_set(), which is doing
> copying, setting flags and options_len.
> 
> Set correct flags and options_len directly on tun_info.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/pfcp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
> index cc5b28c5f99f..69434fd13f96 100644
> --- a/drivers/net/pfcp.c
> +++ b/drivers/net/pfcp.c
> @@ -80,9 +80,8 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
>  	else
>  		pfcp_node_recv(pfcp, skb, md);
>  
> -	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, flags);
> -	ip_tunnel_info_opts_set(&tun_dst->u.tun_info, md, sizeof(*md),
> -				flags);
> +	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, tun_dst->u.tun_info.key.tun_flags);
> +	tun_dst->u.tun_info.options_len = sizeof(*md);
>  
>  	if (unlikely(iptunnel_pull_header(skb, PFCP_HLEN, skb->protocol,
>  					  !net_eq(sock_net(sk),
> -- 
> 2.42.0
> 

Ehh, sorry, misstype in netdev ccing
CC: netdev@vger.kernel.org

