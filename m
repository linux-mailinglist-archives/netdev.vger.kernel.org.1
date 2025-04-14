Return-Path: <netdev+bounces-182523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F55A88FFF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EDB188EEE5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335F1F3FC0;
	Mon, 14 Apr 2025 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UAHmw+/I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A01C861C;
	Mon, 14 Apr 2025 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672580; cv=none; b=O3X0WERJ62Na4/osS9jm7jOqrohqN0jav2UbQHdVhz2DGH8+frAo00W4UFn7SzpxW0PYdjBMg7X8ZD18ho4rYPrUFNNbnBHFwfDjm9qUt1DcDiwvUWa4pF/iCN4kALXWa0atChxi5B9lV9SoNJsHOx2DdAtgf0p+cBPVMLkvwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672580; c=relaxed/simple;
	bh=0WqDJG69FEs0KkciHDeVevftpF1QWOSoCvGqGBsnecM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkvRvvFnko5G+s8E82KAy+RtpWZN6O0HrmUKj5TkAWLXfDlhs2292zG+TESTiJijgu7Snyq6uIHU9DwtyYIf2eb6bje8rLf/ih3eS5H5+4Fg6Im7yKVbc0ewS+Ly+1F6RN+hSmpTbJyp2IHvQxKBx9EYZf5dF3bAUpYtSbd1JI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UAHmw+/I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k3Dqh+OTN4sR3eT1lMWrg0MEuvqz/VfkV60i8wzfX/A=; b=UAHmw+/I2Jn1sZWh5meC29DmAg
	TQ6CXyLvFuyzSlFLlL5rQ1TA9j3RGyse5map2+ERUcrFBhOlbFCuAhcf/kDfUdkiX7fzi1HLd9FHJ
	4Kj/RWZhmro0zgNckfF2by7mlwJF2kTzJLBEB+Vy112fJpQrDlVJUzfBeu3IvFRU0NoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4T2B-009IXJ-5I; Tue, 15 Apr 2025 01:16:11 +0200
Date: Tue, 15 Apr 2025 01:16:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: jlayton@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, nathan@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, qasdev00@gmail.com
Subject: Re: [PATCH 4/4] net: register debugfs file for net_device refcnt
 tracker
Message-ID: <782ca402-83a0-4a7b-b29b-ac021932d081@lunn.ch>
References: <20250414-reftrack-dbgfs-v1-4-f03585832203@kernel.org>
 <20250414222926.72911-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414222926.72911-1-kuniyu@amazon.com>

On Mon, Apr 14, 2025 at 03:27:36PM -0700, Kuniyuki Iwashima wrote:
> From: Jeff Layton <jlayton@kernel.org>
> Date: Mon, 14 Apr 2025 10:45:49 -0400
> > As a nearly-final step in register_netdevice(), finalize the name in the
> > refcount tracker, and register a debugfs file for it.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  net/core/dev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..db9cac702bb2230ca2bbc2c04ac0a77482c65fc3 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -10994,6 +10994,8 @@ int register_netdevice(struct net_device *dev)
> >  	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
> >  		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
> >  
> > +	/* Register debugfs file for the refcount tracker */
> > +	ref_tracker_dir_debugfs(&dev->refcnt_tracker, dev->name);
> 
> dev->name is not unique across network namespaces, so we should specify
> a netns-specific parent dir here.
> 
> For example, syzkaller creates a bunch of devices with the same name in
> different network namespaces.
> 
> Then, we also need to move the file when dev is moved to another netns
> in __dev_change_net_namespace().

The address of dev should be unique, and does not change as the netdev
moves between network name spaces. So you could postfix it with the
hashed version of an address, as produced by %pK. This is debugfs, it
does not need to be too friendly.

       Andrew

