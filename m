Return-Path: <netdev+bounces-281911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ+/N1zF8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:34:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516104870A8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B09312AF38
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F143E9D6;
	Tue, 28 Apr 2026 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itJjBxW+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729A42EEA9;
	Tue, 28 Apr 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385515; cv=none; b=FEuNim7m3LDvGRIpXYU9jQxE6GpffH1+aD4R/EMImG8cwBBE3cq10Qm0ioSsRROZO3myDCjlpzkvW+mAUx7gmw8kBi5D7EbTPYbNZ41/QnwFpr4TXNJczTXs0MgTXlWPiuPsuX6S/3JB00ujcnLHeU9mknOR4En/AY3n1nsS+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385515; c=relaxed/simple;
	bh=iZMPl9A0IRKQYEGLCFSm2JdnyKo75iIwr6JJniSQLGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZykOMip78eYFWqUwsX62ZPSi8LsExeG3TDuVOo2WnuxAMKz1cOWv3qhfFxQCpH7Cub2f4UrCJSZxofyIRQuVwUvHOTdELB4pxyXHNZFwFF9mTj3Z4dvOM8uKuQKeOyDGO8hGJ0ScMQb4BkBa+ylV/6fSoF6e7yb5S/OMPV65AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itJjBxW+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777385514; x=1808921514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZMPl9A0IRKQYEGLCFSm2JdnyKo75iIwr6JJniSQLGw=;
  b=itJjBxW+JILV6dXQJK9oLA4Tmu/wFgXUCLiGlWYVvmVvrcXkx8BXFD18
   BWTyx/Qpk4TDwCwpv7VNYsJn652YHbHp4w23RizRbg4iH5FdFEG+3+ggc
   qqUVuIrKRvBDhuz47jfbFGxufbrhwAR64H2aXqyeJqwK3Vfb6Qw2a+tGn
   1FHhWsCCQE89haQUk4Lbj9jsJ7uvMLcUSh5GtYZ/5aoRlOTIrjeauUh+o
   LHx5Um8uCGFxwq80K0TQR+wlvXY8tkvvbdkHfkI/K0/3VvFsi+LAYyQGn
   b61VYIrKYEAmHLVnim0MRTvASGw2oZZJXsd2EyW3FevFNONJB77I8eYWH
   w==;
X-CSE-ConnectionGUID: nxUvrNupRvWtM+On8YwEaA==
X-CSE-MsgGUID: y5CQhoCxS/Kp7nYPOSiqwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95861085"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="95861085"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:11:53 -0700
X-CSE-ConnectionGUID: KipQ7+abQM2E7BHlDiHV4g==
X-CSE-MsgGUID: kVBKkaD8Q/urxUomJPK13w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233919968"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 28 Apr 2026 07:11:50 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id AD39E95; Tue, 28 Apr 2026 16:11:48 +0200 (CEST)
Date: Tue, 28 Apr 2026 16:11:48 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <20260428141148.GS557136@black.igk.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
 <2026042848-cubical-penalize-807c@gregkh>
 <20260428120314.GR557136@black.igk.intel.com>
 <2026042802-bobsled-envy-8e56@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026042802-bobsled-envy-8e56@gregkh>
X-Rspamd-Queue-Id: 516104870A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-281911-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,black.igk.intel.com:mid]

On Tue, Apr 28, 2026 at 07:54:51AM -0600, Greg KH wrote:
> On Tue, Apr 28, 2026 at 02:03:14PM +0200, Mika Westerberg wrote:
> > On Tue, Apr 28, 2026 at 05:57:37AM -0600, Greg KH wrote:
> > > On Tue, Apr 28, 2026 at 09:22:09AM +0200, Mika Westerberg wrote:
> > > > Introduce USB4STREAM protocol and Linux implementation. This allows two
> > > > (or more) hosts to transfer data directly over Thunderbolt/USB4 cable
> > > > through a character device without need to go through the network stack.
> > > > 
> > > > Any application that supports read(2) and write(2) in some form should
> > > > be able to use the device without changes. The data is sent out to the
> > > > other side over a tunnel inside Thunderbolt/USB4 fabric. The character
> > > > device is called /dev/tbstreamX where X is the minor number starting
> > > > from 0.
> > > > 
> > > > All stream devices need to be configured first. This is done through
> > > > ConfigFS interface. There can be multiple streams at the same time (this
> > > > depends on number of DMA rings and available HopIDs) and a single stream
> > > > supports traffic in both directions. For example there could be an
> > > > application that uses one stream as control channel and another one as
> > > > bi-directional data channel.
> > > > 
> > > > A real use-case for this is to take a backup as a part of recovery
> > > > initramfs tooling (no need to setup networking or have ssh or similar
> > > > tooling as part of the initramfs). Say we want to backup the disk of
> > > > host1 to host2. First Thunderbolt/USB4 cable is connected between the
> > > > hosts (there can be devices in the middle too) then the receiving side
> > > > configures the stream:
> > > > 
> > > >   host2 # mkdir /sys/kernel/config/thunderbolt/stream/0-1.0
> > > >   host2 # mkdir /sys/kernel/config/thunderbolt/stream/0-1.0/backup
> > > >   host2 # echo -1 > /sys/kernel/config/thunderbolt/stream/0-1.0/backup/in_hopid
> > > >   host2 # echo -1 > /sys/kernel/config/thunderbolt/stream/0-1.0/backup/out_hopid
> > > > 
> > > > We use automatic HopID allocation (writing -1 to HopIDs) for simplicity.
> > > > >From this point forward the /dev/tbstream0 can be used pretty much as
> > > > regular file:
> > > > 
> > > >   host2 # dd if=/dev/tbstream0 of=/tmp/host1.nvme0n1.backup-$(date +%F) bs=256k
> > > > 
> > > > The host that is being backed up then configures the stream accordingly:
> > > > 
> > > >   host1 # mkdir /sys/kernel/config/thunderbolt/stream/0-503.0
> > > >   host1 # mkdir /sys/kernel/config/thunderbolt/stream/0-503.0/backup
> > > > 
> > > > Here we take advantage of the fact that host2 also announces the active
> > > > streams through XDomain properties so the name "backup" gives us the
> > > > HopIDs. It is also possible to configure them manually in the same way
> > > > we did for host2.
> > > > 
> > > > Then it is just a matter of copying the data over:
> > > > 
> > > >   host1 # dd if=/dev/nvme0n1 of=/dev/tbstream0 bs=256k
> > > > 
> > > > Similarly it is possible to transfer parts of the filesystem. For
> > > > example copy contents of mydir over to the host2:
> > > > 
> > > >   host2 # gunzip < /dev/tbstream0 | tar xf -
> > > >   host1 # tar cf - mydir | gzip > /dev/tbstream0
> > > > 
> > > > Other end of the spectrum use-case is "borrowing" laptop (host1) camera
> > > > to desktop (host2):
> > > > 
> > > >   host2 # gst-launch-1.0 filesrc location=/dev/tbstream0 ! jpegdec ! videoconvert ! \
> > > >                          autovideosink
> > > > 
> > > >   host1 # gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw,width=1920,height=1080 ! \
> > > >                          jpegenc quality=90 ! filesink location=/dev/tbstream0
> > > > 
> > > > Once the streams are no longer needed they can be removed:
> > > > 
> > > >   host1 # cd /sys/kernel/config/thunderbolt/stream/
> > > >   host1 # rmdir -p 0-503.0/backup
> > > > 
> > > >   host2 # cd /sys/kernel/config/thunderbolt/stream
> > > >   host2 # rmdir -p 0-1.0/backup
> > > 
> > > Very cool, but shouldn't the above be in some documentation somewhere so
> > > that people know how to use it?
> > 
> > Sure, I can add it part of the Documentation/admin-guide/thunderbolt.rs for
> > example.
> > 
> > > And why do you need a whole major for this, why not just use a misc
> > > device that it dynamically created for every new dev?
> > 
> > We do use this:
> > 
> >        ret = alloc_chrdev_region(&tbstream_devt, 0, TBSTREAM_DEV_MINORS,
> >                                   "tbstream");
> > 
> > that should be dynamically allocated, no?
> 
> Yes, but you are using up a whole major number for this, and in reality
> there's only going to be 1-2, maybe 4, different devices needed at once,
> right?  So just use the miscdev interface instead?

There could be 11 per host controller in Intel hardware (we have 12 DMA
rings, one of which is reserved for control traffic), and we have 2 host
conrollers in recent systems. Due to the dedicated flow control we use now
that's not possible but we are planning to make it to use shared flow
control instead which allows more.

Not sure if anybody ever will create that many, though.

Second thing is that we use cdev_device_add() to manage the char device and
the stream device as they are part of the same structure. I don't think
that can be done with miscdevice.

