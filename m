Return-Path: <netdev+bounces-229882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DCBE1B6B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620E519C7B5D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59A2D2491;
	Thu, 16 Oct 2025 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DlyR1g5J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DE21CC44
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595945; cv=none; b=QFH4HPiCd8hOSgV+qko3haevmcoifP0vCzFMLaIygWOO5Jyo6Evda0669z7AVG/ic2KUnD0M4sNmxjwkODS63xoMe18VN7fV3rDo4KJRm3OnTCC2DwmGCegYkC9d0chYCVp62PHJLv4mBqDg8mhAZukqGucjJZcNoM72zNkQemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595945; c=relaxed/simple;
	bh=1m4Hk7EVBiUQT3fUtyJl5ICcWL7F5BpX7wQLf6O0c1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG786nQA9VO+TA5tczBuxlnWox+sv80bRzUGpE13EPd3VdH72duG1HUzR1FvzfiY0HpPiJ30za/dGVLZumYq7EINNHt0RgP32YcVTYKL0Zz1GYJ/lModQKRDOnac3xzppPmbmNZHzpwQAG8ellh6ziaJ/Dt2k63oujvhMvX6Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DlyR1g5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB926C4CEF1;
	Thu, 16 Oct 2025 06:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760595945;
	bh=1m4Hk7EVBiUQT3fUtyJl5ICcWL7F5BpX7wQLf6O0c1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlyR1g5JOem+OB3HHV2dIHVpxfapSN3mz5BsdAj0k6H32Xn+4fgiYwZSF6z8MXYjx
	 KD7Z6Y/E5bpvE6ftdw804nUxlQsyfDqxlmyreVhWyChQjZVFxXqMbHEMaJGN7nUGnG
	 3dkXCnMdAdptBnvL27tcQMz6/RSBC/GsBC61+LsU=
Date: Thu, 16 Oct 2025 08:25:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cynthia <cynthia@kosmx.dev>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org
Subject: Re: [REGRESSION] in 6.17, failing
 __dev_change_net_namespace+0xb89/0xc30
Message-ID: <2025101649-lid-cancel-4a69@gregkh>
References: <01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com>
 <20251015133120.7ef53b20@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015133120.7ef53b20@kernel.org>

On Wed, Oct 15, 2025 at 01:31:20PM -0700, Jakub Kicinski wrote:
> On Tue, 14 Oct 2025 10:04:43 +0000 Cynthia wrote:
> > When I updated my machine to the newest kernel, a bug started to appear. 
> > The system does not panic, but an error kept happening in dmesg.
> > 
> > The bug happens with LXC/Incus when it tries to start a new container. 
> > (but probably other things are affected too)
> > 
> > 
> > Steps to Reproduce: the bug can be reproduced in a libvirt VM, no need 
> > for a specific system. Also I suspect the bug is also 
> > architecture-independent, but I cannot verify that.
> > 1) Install ArchLinux (all dependencies are available). I was testing 
> > with vanilla kernel, so any linux distro should be affected.
> > https://aur.archlinux.org/packages/linux-mainline can be installed, this 
> > is the vanilla kernel with a generally good kernel config for most PCs.
> > 2) Install LXC/Incus (pacman -S incus)
> > 3) configure incus and start a container:
> > usermod -v 1000000-1000999999 -w 1000000-1000999999 root &&
> > incus admin init &&
> > incus launch images:debian/12 first # start a container
> > 4) Previous step should trigger incus to do namespaces. I'm not sure 
> > what syscall is causing the bug, I do not have a mini C program. These 
> > steps should be enough to see the log in the dmesg.
> > 
> > I also did a git bisect, the first commit to have this bug is this:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c17270f9b920e4e1777488f1911bbfdaf2af3be
> > 
> > I initially reported this bug on Bugzilla, but after seeing 6 year old 
> > bugs there, I'm not sure if that platform is still in use.
> > https://bugzilla.kernel.org/show_bug.cgi?id=220649
> > 
> > Since my initial report, 6.17.2 was released, the bug is still happening.
> > 
> > I'm attaching 2 files:
> > dmesg_slice: the slice of dmesg containing the problematic frame (on a 
> > bare-metal linux with AMD srso mitigation disabled)
> > bisect_log: a log of the git bisect process
> 
> Thanks a lot for bisecting! Looking at the code my guess is that sysfs
> gives us ENOENT when we try to change owner of a file that isn't
> visible. Adding sysfs maintainers - should sysfs_group_attrs_change_owner() 
> call is_visible before trying to touch the attr?

Oh, I never considered that call-path, and given that I haven't seen a
bug report about this yet, it's pretty rare :)

So yes, that should be checked.  Can anyone knock up a patch for this?
I'm busy all today with other stuff, sorry.

greg k-h

