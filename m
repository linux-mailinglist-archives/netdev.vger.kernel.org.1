Return-Path: <netdev+bounces-194278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6245BAC84FC
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6F04E3F0E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CBE21E094;
	Thu, 29 May 2025 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxkNzBST"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF663B9;
	Thu, 29 May 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748561090; cv=none; b=LB3LCYq087yIaHO/N5GdfLKVPxPWx8Kglmli/ZHueIUzRiFKlOT/nsn1BDMD8wUosHxu9OUwbDrXehkcQZ/mhuPpFjbdNyr22yS/zr+c7zqsNHOz31c0el7r8gQJfXiDYc31PtpZpCrt+XDo8RGiO1ajI8Wa0uRWCH/lLyL34Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748561090; c=relaxed/simple;
	bh=XHek1or6lgqhUolGMvuGeooaTqEUU9Li8TYgY+vSfcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SniTFoUml3S3G6MvfjlxfDw6EeBdTXOfL03e4pYMfVuM0z1etOIWuFhwZdhxshMkfa1+sMP+zQ2hoeOU+NpQ+QPyUQbrmaa95WKsLXcxMSrBB44s326rnnV8Ec/eY5/KyCPUHnhqfg/6ODPI3CpnwsA+PkAUefhqHcOeSQzHokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxkNzBST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9174AC4CEE7;
	Thu, 29 May 2025 23:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748561089;
	bh=XHek1or6lgqhUolGMvuGeooaTqEUU9Li8TYgY+vSfcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxkNzBSTwpjci3VuBTnBCeXjQwbDMmYbh7D5ztdNlSAzhtQM4Kw4VnEEmyPOOJ7dS
	 ml5P97uFliPzrLABarBwXqgRmHigFFTADXFoBhI1l7kml3JmsHM0gGXJ2EdenZyJ6e
	 iUV3fy1cITtu/iVSmXAx6tRmvYLob7yMdCStGtNu/bio1iVq1cJaUGSbJhmQTDLiIr
	 RdLjPH8cyaGS8OWCryRsuVGJAvcUYYw9qtebVaduOyQ1L3bU5uSE2ld37SpcSGizrN
	 dkS27CXxvs24AIkJYhm0KdyQp21oJEaUnhetrjJs2wZT0XtzxQhyi0+tBlTyBmpTSW
	 scCU6sL2oFOPA==
Date: Thu, 29 May 2025 16:24:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v12 00/10] ref_tracker: add ability to register a
 debugfs file for a ref_tracker_dir
Message-ID: <20250529162447.30c4ca85@kernel.org>
In-Reply-To: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
References: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 11:20:36 -0400 Jeff Layton wrote:
> Sorry for the reposting, but this makes things easier with automated CI.
> 
> This posting just drops the pr_warn() calls from the new functions. We
> were still seeing some warnings during (expected) times that debugfs
> file creation would fail. debugfs already throws warnings when these
> things fail unexpectedly, so these warnings are unwanted when dentry
> creation fails before debugfs is up.

Hm, so FWIW we hit a lockdep issue now
raw:
 https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/142540/4-connect-deny-ipv6/stderr
decoded:
https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/142540/vm-crash-thr0-10

I suspect this may just be "merge window fun", since we forwarded our
trees to Linus's since your v11?

[   14.281410][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[   14.281692][    C0] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[   14.281974][    C0] ffffffff9e1c5af8 (pin_fs_lock){+.?.}-{3:3}, at: simple_pin_fs+0x24/0x150
[   14.282373][    C0] {SOFTIRQ-ON-W} state was registered at:
[   14.282614][    C0]   __lock_acquire+0x20b/0x7e0
[   14.282849][    C0]   lock_acquire.part.0+0xb6/0x240
[   14.283072][    C0]   _raw_spin_lock+0x33/0x40
[   14.283298][    C0]   simple_pin_fs+0x24/0x150
[   14.283524][    C0]   start_creating.part.0+0x52/0x310
[   14.283752][    C0]   debugfs_create_dir+0x6a/0x540
[   14.283977][    C0]   component_debug_init+0x17/0x30
[   14.284206][    C0]   do_one_initcall+0x8f/0x1e0
[   14.284451][    C0]   do_initcalls+0x176/0x280
[   14.284679][    C0]   kernel_init_freeable+0x22d/0x300
[   14.284907][    C0]   kernel_init+0x20/0x200
[   14.285131][    C0]   ret_from_fork+0x240/0x320
[   14.285359][    C0]   ret_from_fork_asm+0x1a/0x30
[   14.285580][    C0] irq event stamp: 410868
[   14.285750][    C0] hardirqs last  enabled at (410868): [<ffffffff9cfc332d>] _raw_spin_unlock_irqrestore+0x5d/0x80
[   14.286200][    C0] hardirqs last disabled at (410867): [<ffffffff9cfc300b>] _raw_spin_lock_irqsave+0x5b/0x60
[   14.286653][    C0] softirqs last  enabled at (409604): [<ffffffff9a6877a8>] handle_softirqs+0x358/0x620
[   14.287061][    C0] softirqs last disabled at (409635): [<ffffffff9a687bfa>] __irq_exit_rcu+0xfa/0x160

