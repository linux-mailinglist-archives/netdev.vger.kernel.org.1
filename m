Return-Path: <netdev+bounces-119395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7559556C9
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC25D1C20F8C
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ECD145344;
	Sat, 17 Aug 2024 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="akEjxC1v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3743881E;
	Sat, 17 Aug 2024 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887333; cv=none; b=MIV82o2AQrtVUxSXFcFDUaGE9GqvayjKgolvf6M9UVMuxuciVevnCkN4WaLolY3eAnNBGhCmaHev/kDh8RpLjleb4ciqtvsf0VBObxS7rAa1SoGSP3ycVZURTuUdALb4DPIKCPk9ocB+H3w03eRDEEgujeMSIbNzmkaPQN6tM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887333; c=relaxed/simple;
	bh=Sw1HIvz572t59kMetUvCyMhXO9ZkRGeCQrNyyiWLYtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAFyWZk0pCgAPcNW5Y1q2mCOZ3j4OR1RUkFjnaOT7ndyR1y92kKvBctDUB6IBwBjExB8Lg2wiAPjEBjeiAhQ/dygYeUYkWbAePJ4I9LHE77qRBx6OAuajY4OnsbdK4OgU4WYnY+EeOtm8B2WDDEnlxdPeit+CBaJrkByXg7zGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=akEjxC1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDEEC116B1;
	Sat, 17 Aug 2024 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723887333;
	bh=Sw1HIvz572t59kMetUvCyMhXO9ZkRGeCQrNyyiWLYtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akEjxC1vFTIUq8RvgEODnkyu4+wgCYGN1jKpTV5gGuIogxCfOl1VW65LHrZDhOW3H
	 2qTh7gpTPsOs+GxWciwCFMCBg11eayMHbMhd2W7rHygmEZCj3/yxPf+JcQKqXs4f8A
	 qud6CHl/eMhy1wqlzRnAQ5SwBfMj+fv+F+gDLSLk=
Date: Sat, 17 Aug 2024 11:35:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Young <alex000young@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, security@kernel.org,
	xkaneiki@gmail.com, hackerzheng666@gmail.com
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
Message-ID: <2024081722-reflex-reverend-4916@gregkh>
References: <20240816015355.688153-1-alex000young@gmail.com>
 <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
 <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
 <CAFC++j15p9Ey3qc4ZsY4CXBsL3LHn7TsFTi6=N9=H+_Yx_k=+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFC++j15p9Ey3qc4ZsY4CXBsL3LHn7TsFTi6=N9=H+_Yx_k=+Q@mail.gmail.com>

On Sat, Aug 17, 2024 at 05:27:17PM +0800, Alex Young wrote:
> Hi Jamal,
> 
> Thanks your mention. I have reviewed the latest kernel code.
> I understand why these two tc function threads can enter the kernel at the same
> time. It's because the request_module[2] function in tcf_action_init_1. When the
> tc_action_init_1 function to add a new action, it will load the action
> module. It will
> call rtnl_unlock to let the Thread2 into the kernel space.
> 
> Thread1                                                 Thread2
> rtnetlink_rcv_msg                                   rtnetlink_rcv_msg
>  rtnl_lock();
>  tcf_action_init
>   for(i;i<TCA_ACT_MAX_PRIO;i++)
>    act=tcf_action_init_1 //[1]
>         if (rtnl_held)
>            rtnl_unlock(); //[2]
>         request_module("act_%s", act_name);
> 
>                                                                 tcf_del_walker
> 
> idr_for_each_entry_ul(idr,p,id)
> 
> __tcf_idr_release(p,false,true)
> 
>  free_tcf(p) //[3]
> if (rtnl_held)
> rtnl_lock();
> 
>    if(IS_ERR(act))
>     goto err
>    actions[i] = act
> 
>   err:
>    tcf_action_destroy
>     a=actions[i]
>     ops = a->ops //[4]
> I know this time window is small, but it can indeed cause the bug. And
> in the latest
> kernel, it have fixed the bug. But version 4.19.x is still a
> maintenance version.

4.19.y is only going to be alive for 4 more months, and anyone still
using it now really should have their plans to move off of it finished
already (or almost finished.)

If this is a request_module issue, and you care about 4.19.y kernels,
just add that module to the modprobe exclude list in userspace which
will prevent it from being loaded automatically.  Or load it at boot
time.

And what specific commit resolved this issue in the older kernels?  Have
you attempted to just backport that change to 4.19.y?

thanks,

greg k-h

