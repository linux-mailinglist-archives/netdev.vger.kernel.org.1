Return-Path: <netdev+bounces-40970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1BD7C9398
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29926B20AFF
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1C6AB0;
	Sat, 14 Oct 2023 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwquyA1G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6316127
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 08:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D654C433C8;
	Sat, 14 Oct 2023 08:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697273903;
	bh=g/tuy6CHeROVx+Ezgeb3eHQEHb6fFY68DT6V7ojM0Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwquyA1GiswEfR3mJ75HDYOMl4O4xzBiPxlayEz1TDRnMW3pm4VhfFT+cJqlEo/TP
	 3nZRN0t3E+3TsOMBti2KhMFgR5qiNr1cPNFhTgRC5LFyjIIGXQDPfZTytTcZpHydoi
	 d+5FLTZsn0vv01iN3kY4GlkViePUav/vaFNHP7bo=
Date: Sat, 14 Oct 2023 10:58:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Serge Hallyn <serge.hallyn@canonical.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <2023101408-matador-stagnant-7cab@gregkh>
References: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
 <20231013153605.487f5a74@kernel.org>
 <20231013154302.44cc197d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013154302.44cc197d@kernel.org>

On Fri, Oct 13, 2023 at 03:43:02PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Oct 2023 15:36:05 -0700 Jakub Kicinski wrote:
> >    kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
> >    dev_net_set(dev, net);
> >    kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> 
> Greg, we seem to have a problem in networking with combined
> netns move and name change.
> 
> We have this code in __dev_change_net_namespace():
> 
> 	kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
> 	dev_net_set(dev, net);
> 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> 
> 	err = device_rename(&dev->dev, dev->name);
> 
> Is there any way we can only get the REMOVE (old name) and ADD
> (new name) events, without the move? I.e. silence the rename? 
> 
> Daniel is reporting that with current code target netns sees an 
> add of an interface with the old (duplicated) name. And then a rename.

But that's how this has always been, right?  What problems is this
causing?

> Without a silent move best we can do is probably:
> 
> 	kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
> 	dev_net_set(dev, net);
> 	err = device_rename(&dev->dev, dev->name);
> 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> 
> which will give us:
> 
> 	MOVE new-name
> 	ADD new-name
> 
> in target netns, which, hm.

That wouldn't make much sense.

What is the real problem here?  What changed to cause a problem?

thanks,

greg k-h

