Return-Path: <netdev+bounces-42699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68B7CFE10
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601FCB20DCD
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB773159C;
	Thu, 19 Oct 2023 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FpXujF7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67E30F82
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3CEC433C8;
	Thu, 19 Oct 2023 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697729867;
	bh=EXiL4JWpALWGOQ9Ko8C4CeFcWE+AEC82IizKX7PGipc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpXujF7+idedTEKRzu+EfC3ZRPiNwdjelzhR+fJH4Y1HM/ro75HpaSyfxjaYE5KHt
	 zXxa8skp2oV8gSGHmeVu/4DuyXOBSYMB9xfdGPFqzLKtC6YOSA852oD/9xPl/j+Ga8
	 NezINdh5bN26jqyd8kr+tWRU31052Ndc4uWLwQdc=
Date: Thu, 19 Oct 2023 17:37:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org, mhocko@suse.com,
	stephen@networkplumber.org
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <2023101917-till-unshackle-5098@gregkh>
References: <20231018154804.420823-1-atenart@kernel.org>
 <20231018154804.420823-2-atenart@kernel.org>
 <2023101840-scabbed-visitor-3fdd@gregkh>
 <169770320930.433869.5743241833039124669@kwain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169770320930.433869.5743241833039124669@kwain>

On Thu, Oct 19, 2023 at 10:13:29AM +0200, Antoine Tenart wrote:
> Quoting Greg KH (2023-10-18 18:49:18)
> > On Wed, Oct 18, 2023 at 05:47:43PM +0200, Antoine Tenart wrote:
> > > +static inline struct kernfs_node *sysfs_rtnl_lock(struct kobject *kobj,
> > > +                                               struct attribute *attr,
> > > +                                               struct net_device *ndev)
> > > +{
> > > +     struct kernfs_node *kn;
> > > +
> > > +     /* First, we hold a reference to the net device we might use in the
> > > +      * locking section as the unregistration path might run in parallel.
> > > +      * This will ensure the net device won't be freed before we return.
> > > +      */
> > > +     dev_hold(ndev);
> > > +     /* sysfs_break_active_protection was introduced to allow self-removal of
> > > +      * devices and their associated sysfs files by bailing out of the
> > > +      * sysfs/kernfs protection. We do this here to allow the unregistration
> > > +      * path to complete in parallel. The following takes a reference on the
> > > +      * kobject and the kernfs_node being accessed.
> > > +      *
> > > +      * This works because we hold a reference onto the net device and the
> > > +      * unregistration path will wait for us eventually in netdev_run_todo
> > > +      * (outside an rtnl lock section).
> > > +      */
> > > +     kn = sysfs_break_active_protection(kobj, attr);
> > > +     WARN_ON_ONCE(!kn);
> > 
> > If this triggers, you will end up rebooting the machines that set
> > panic-on-warn, do you mean to do that?  And note, the huge majority of
> > Linux systems in the world have that enabled, so be careful.
> 
> Right. My understanding was this can not happen here and I added this
> one as a "that should not happen and something is really wrong", as the
> attribute should be valid until at least the call to
> sysfs_break_active_protection.

If it can not happen, then no need to ever check it.  If it can happen,
then check for it and handle the error.  Don't cheat and try to rely on
WARN_ON() to paper over lazy programming :)

thanks,

greg k-h

