Return-Path: <netdev+bounces-229770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F89BE0A2C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DB919A3506
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23B25333F;
	Wed, 15 Oct 2025 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcwq5vvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44924BD04
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560282; cv=none; b=edyXxA/tGNjEVwm9aV8F8tn6o/AeQIaNNM+C/Upys0rjYhwjwp1lq9pgIz3qugiyRwfvRFnnxWSrAMt8KKZpvYUAFeTBdfxzLQtslZ0CE58DneA4bRRAmE+w/H8fs0KlVPqmX3MlcWqVleb6kf86WWSpFuk2S5NzxFIWvmAeQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560282; c=relaxed/simple;
	bh=pivJSrMweKTt0+Bq5YHN9/KyBe29/QBMUSs/Cd5ZYiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCiclExIF18RvsUXsGUlXpjtYFVuumxE7YLxoHorT8eyEhurqybpheI2q5QFrwZf1Bd4LkiTKiFwqoPFvKBIq439MMli3Yphy9W+PFY8GlSflVlivExwyQ1f1QZVn4chyz++c66JKRmtpkosbxmXVoc7As4Lqm9fVwUhNlzs5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcwq5vvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36157C4CEF8;
	Wed, 15 Oct 2025 20:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760560281;
	bh=pivJSrMweKTt0+Bq5YHN9/KyBe29/QBMUSs/Cd5ZYiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gcwq5vvmrJ6RdRh1hTdx5U1YcQblD+/6hWzWYTSue+LpOR7A9DaG9vlhmgi+3V1ac
	 YHZvLBuwPcEFOgOnrADiyfSGFh8XAnc77LHwtMxqkf0Wz4Lxsdx9nzW+QIEjExCTxA
	 kwYD9WpWMZhZarmuxOwRD/6w4GMNmldam4ccUWSNwUldcqSb+qx2rx93J53mEbjAsx
	 6ZsZMiJ1CS8ZSL+IiBtG+AH0gASOkj1QD/UCS5x48XHOBibewa+6LEfOQ3N0uWEloA
	 Qtz2f/REM3XodoNxj2QwQLAOCyFgB2n62Ch7ebGmn3xFZa6d1SsTsqiCh9hvTs1dVf
	 krzjoXsJaxo6Q==
Date: Wed, 15 Oct 2025 13:31:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cynthia <cynthia@kosmx.dev>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [REGRESSION] in 6.17, failing
 __dev_change_net_namespace+0xb89/0xc30
Message-ID: <20251015133120.7ef53b20@kernel.org>
In-Reply-To: <01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com>
References: <01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 10:04:43 +0000 Cynthia wrote:
> When I updated my machine to the newest kernel, a bug started to appear. 
> The system does not panic, but an error kept happening in dmesg.
> 
> The bug happens with LXC/Incus when it tries to start a new container. 
> (but probably other things are affected too)
> 
> 
> Steps to Reproduce: the bug can be reproduced in a libvirt VM, no need 
> for a specific system. Also I suspect the bug is also 
> architecture-independent, but I cannot verify that.
> 1) Install ArchLinux (all dependencies are available). I was testing 
> with vanilla kernel, so any linux distro should be affected.
> https://aur.archlinux.org/packages/linux-mainline can be installed, this 
> is the vanilla kernel with a generally good kernel config for most PCs.
> 2) Install LXC/Incus (pacman -S incus)
> 3) configure incus and start a container:
> usermod -v 1000000-1000999999 -w 1000000-1000999999 root &&
> incus admin init &&
> incus launch images:debian/12 first # start a container
> 4) Previous step should trigger incus to do namespaces. I'm not sure 
> what syscall is causing the bug, I do not have a mini C program. These 
> steps should be enough to see the log in the dmesg.
> 
> I also did a git bisect, the first commit to have this bug is this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c17270f9b920e4e1777488f1911bbfdaf2af3be
> 
> I initially reported this bug on Bugzilla, but after seeing 6 year old 
> bugs there, I'm not sure if that platform is still in use.
> https://bugzilla.kernel.org/show_bug.cgi?id=220649
> 
> Since my initial report, 6.17.2 was released, the bug is still happening.
> 
> I'm attaching 2 files:
> dmesg_slice: the slice of dmesg containing the problematic frame (on a 
> bare-metal linux with AMD srso mitigation disabled)
> bisect_log: a log of the git bisect process

Thanks a lot for bisecting! Looking at the code my guess is that sysfs
gives us ENOENT when we try to change owner of a file that isn't
visible. Adding sysfs maintainers - should sysfs_group_attrs_change_owner() 
call is_visible before trying to touch the attr?

