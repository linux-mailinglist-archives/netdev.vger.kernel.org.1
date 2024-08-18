Return-Path: <netdev+bounces-119462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D455955C1E
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 12:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3832A281DF3
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84517C96;
	Sun, 18 Aug 2024 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PD14DlQV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D917BCE;
	Sun, 18 Aug 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977610; cv=none; b=G8fgPK/hpfCByJi9TYv61wV1sxzRixZqBVFv2FGS4DZx5wuKdgolQfon7S5iySJ7IyQv0OrHMktGUIhJGXb0avbzEziUOay+p689e8L7QX5loMFLZJOAEjCLymez7ZUUZF8o4hB2IQdjBU3NePsV4d/Qn4KquYzWr+IijbO2p1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977610; c=relaxed/simple;
	bh=SYntiWmpvu31I1wmYEvwL8oR4HWpxZe+YWYjmNxhB3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE6xR0QVqmmIFjYk0WwpxqumM/h1DC6OnUvae6uIq9mqxfh7LD8QPy3xPMkw9Wos2A9D23vmoKUr+FWAzKqxms6HIJruNntPM+DcpqoPRcq0MaLa+R66HJcItwWrfDD1icfxvEyZZMtrefLvWjnoego9WFVfzYvnVPBkugnv9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PD14DlQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C11C32786;
	Sun, 18 Aug 2024 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723977609;
	bh=SYntiWmpvu31I1wmYEvwL8oR4HWpxZe+YWYjmNxhB3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PD14DlQVhHANvL3LYcj3RT0N0z5E0AilKb/3FPrPp8ahQT3RSvPKLBM+yh0sFqij6
	 S5p1frNLzOAEc94IdR8S6mDQCjvXxwDu8kS8UJHCc3Hbp433RPc3ZRMvi7kdUhSRAL
	 TUG2muYmAMgqkeaqOhG+qCxYo8LQv4pEtSlZWR3k=
Date: Sun, 18 Aug 2024 12:40:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Alex Young <alex000young@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, security@kernel.org,
	xkaneiki@gmail.com, hackerzheng666@gmail.com
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
Message-ID: <2024081839-fool-accuracy-b841@gregkh>
References: <20240816015355.688153-1-alex000young@gmail.com>
 <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
 <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
 <CAFC++j15p9Ey3qc4ZsY4CXBsL3LHn7TsFTi6=N9=H+_Yx_k=+Q@mail.gmail.com>
 <2024081722-reflex-reverend-4916@gregkh>
 <CAM0EoMmUSGEY_wGHmZJkP5s=sr0zPJ2sOyTf3Uy6P3pN8XmvhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmUSGEY_wGHmZJkP5s=sr0zPJ2sOyTf3Uy6P3pN8XmvhA@mail.gmail.com>

On Sat, Aug 17, 2024 at 08:11:50AM -0400, Jamal Hadi Salim wrote:
> On Sat, Aug 17, 2024 at 5:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Aug 17, 2024 at 05:27:17PM +0800, Alex Young wrote:
> > > Hi Jamal,
> > >
> > > Thanks your mention. I have reviewed the latest kernel code.
> > > I understand why these two tc function threads can enter the kernel at the same
> > > time. It's because the request_module[2] function in tcf_action_init_1. When the
> > > tc_action_init_1 function to add a new action, it will load the action
> > > module. It will
> > > call rtnl_unlock to let the Thread2 into the kernel space.
> > >
> > > Thread1                                                 Thread2
> > > rtnetlink_rcv_msg                                   rtnetlink_rcv_msg
> > >  rtnl_lock();
> > >  tcf_action_init
> > >   for(i;i<TCA_ACT_MAX_PRIO;i++)
> > >    act=tcf_action_init_1 //[1]
> > >         if (rtnl_held)
> > >            rtnl_unlock(); //[2]
> > >         request_module("act_%s", act_name);
> > >
> > >                                                                 tcf_del_walker
> > >
> > > idr_for_each_entry_ul(idr,p,id)
> > >
> > > __tcf_idr_release(p,false,true)
> > >
> > >  free_tcf(p) //[3]
> > > if (rtnl_held)
> > > rtnl_lock();
> > >
> > >    if(IS_ERR(act))
> > >     goto err
> > >    actions[i] = act
> > >
> > >   err:
> > >    tcf_action_destroy
> > >     a=actions[i]
> > >     ops = a->ops //[4]
> > > I know this time window is small, but it can indeed cause the bug. And
> > > in the latest
> > > kernel, it have fixed the bug. But version 4.19.x is still a
> > > maintenance version.
> >
> > 4.19.y is only going to be alive for 4 more months, and anyone still
> > using it now really should have their plans to move off of it finished
> > already (or almost finished.)
> >
> > If this is a request_module issue, and you care about 4.19.y kernels,
> > just add that module to the modprobe exclude list in userspace which
> > will prevent it from being loaded automatically.  Or load it at boot
> > time.
> >
> > And what specific commit resolved this issue in the older kernels?  Have
> > you attempted to just backport that change to 4.19.y?
> >
> 
> And if you or anyone cares, here it is:
> d349f997686887906b1183b5be96933c5452362a

Thanks for that.  Looks like it might be good to backport that to 5.4.y
if someone cares about this issue there as well.

thanks,

greg k-h

