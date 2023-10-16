Return-Path: <netdev+bounces-41378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AEE7CAB86
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D6DB20D87
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464626E08;
	Mon, 16 Oct 2023 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxnpPReU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649228E10
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD92C433C7;
	Mon, 16 Oct 2023 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697466773;
	bh=ybykDt/NemfhXcLcv/MMn4Or6vPKfoGmKXm/cawvROk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RxnpPReU50Q65aqZpye9yk/Oa22ZG5ThNcXFNEu3Z9EblYzeweMjtn6COdTNavktv
	 SpzSF25gcjjUAJFjeK26+b1e94PqwLysnsY+iHum7vHO32KgOV3+jpop1iUYZrFCwh
	 w1m0xnd+e9YernryljBbFeoCwAmkkIyn0nzUotEK4/qPzviCzUERUu7Dc8GiQiT+3H
	 sxsW7lRu1KB9gwcL6xPTLupx740MmUrgWrkJ5p0oMVQeaJFfhNCJkZKjFp2nd3Hpne
	 yEZUnhdEBgJuRFz3BhP45YekJeOGwOowuOYLL4i0Nvc/XgNPVOyTRptXXyQil4mhCX
	 pmQzSXzrLqbHw==
Date: Mon, 16 Oct 2023 07:32:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel =?UTF-8?B?R3LDtmJlcg==?= <dxld@darkboxed.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Richard Weinberger
 <richard@nod.at>, Serge Hallyn <serge.hallyn@canonical.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>
Subject: Re: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <20231016073251.0f47d42b@kernel.org>
In-Reply-To: <2023101408-matador-stagnant-7cab@gregkh>
References: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
	<20231013153605.487f5a74@kernel.org>
	<20231013154302.44cc197d@kernel.org>
	<2023101408-matador-stagnant-7cab@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Oct 2023 10:58:20 +0200 Greg Kroah-Hartman wrote:
> On Fri, Oct 13, 2023 at 03:43:02PM -0700, Jakub Kicinski wrote:
> > On Fri, 13 Oct 2023 15:36:05 -0700 Jakub Kicinski wrote:  
> > >    kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
> > >    dev_net_set(dev, net);
> > >    kobject_uevent(&dev->dev.kobj, KOBJ_ADD);  
> > 
> > Greg, we seem to have a problem in networking with combined
> > netns move and name change.
> > 
> > We have this code in __dev_change_net_namespace():
> > 
> > 	kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
> > 	dev_net_set(dev, net);
> > 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> > 
> > 	err = device_rename(&dev->dev, dev->name);
> > 
> > Is there any way we can only get the REMOVE (old name) and ADD
> > (new name) events, without the move? I.e. silence the rename? 
> > 
> > Daniel is reporting that with current code target netns sees an 
> > add of an interface with the old (duplicated) name. And then a rename.  
> 
> But that's how this has always been, right?  What problems is this
> causing?

Original report is up-thread:
https://lore.kernel.org/all/20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at/
With a link to a GH issue for lxc:
https://github.com/lxc/incus/issues/146

> > Without a silent move best we can do is probably:
> > 
> > 	kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
> > 	dev_net_set(dev, net);
> > 	err = device_rename(&dev->dev, dev->name);
> > 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> > 
> > which will give us:
> > 
> > 	MOVE new-name
> > 	ADD new-name
> > 
> > in target netns, which, hm.  
> 
> That wouldn't make much sense.
> 
> What is the real problem here?  What changed to cause a problem?

IIUC what happens is:

 - systemd controls "real" eth0
 - we move a "to be renamed" eth0 from a container into main ns
 - we rename "to be renamed" eth0 to something else
 - seeing the rename of eth0 system thinks it's the "real" one
   that is being renamed, ergo there's no eth0 any more,
   so it shuts down its "unit" for eth0

I don't think anything changed. Sounds more like someone finally tried
to use this in anger.

