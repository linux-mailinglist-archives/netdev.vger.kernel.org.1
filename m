Return-Path: <netdev+bounces-189416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDEBAB207B
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748271BC29B7
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB744C94;
	Sat, 10 May 2025 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXrtRgB8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36422594
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746836990; cv=none; b=Ok2cxzoNi3+XhIa13lX4JKRvo8AHczkcIewLmKppi5DAeKf8iOEoJ5tarxU7zAzkwMNcbw7y2hLGkrEE+KoGxkimdNLPomVDYY79zGZidKtu26w9qsEMeujtUN2h/jO5ghdsO/zTGt91x+Qr6CckZgOwVDPVWH6SlPIGomEqAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746836990; c=relaxed/simple;
	bh=5flC4LkV9wCWcziU/SIzwtlZU/HyoHncGFHjDuXVcK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qxEvB0PNAa52fG2/eRQsFZZ26zGEyldbxai/Gd2g7LUKxO7sQSAjrYIjcByL/u7MwdQcSYQXrphEZ0zBqilvT5t6c0eJGW5YTsX8tsrLcO9CRIWhOsa6HErLuSbOl+Lh86QAdes00jgV5OAa9TQ+5StJDAL/QkMAAs3zDlFNroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXrtRgB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C507C4CEE4;
	Sat, 10 May 2025 00:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746836990;
	bh=5flC4LkV9wCWcziU/SIzwtlZU/HyoHncGFHjDuXVcK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JXrtRgB8zfKe6iFLpm5gVd0HBGdFl+W83iP8aki9M+6nWeGXbvk1DUivPDhkznEqC
	 WvrgASH3E6MuYE1FSFCoQ4BCZwKLvh8e5ycPDCbo0Sm+4TX0VUo9cNiqP/cuwmYape
	 qheFUeAAS9DXCAL0i2zyrbacW3fGnoSuoDQvVjxe6ZB7qtlUScl3eccNIRe/AJQ0Yt
	 fWtFlsy7ZvORs45uM8ueynpzzOuRHNxr5Z5xlwezccB5OZTEiKViOLVzmemLKlIBkr
	 ned9a5qQrGrN/fRNZ9c87/9zTziAp4w84zXd/SihHupe2avnip+0OYBiOfzB51KbZm
	 PzfSBS/Va/6SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF4381091A;
	Sat, 10 May 2025 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: fix duplicate MAC address check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683702875.3851370.14678019061074033156.git-patchwork-notify@kernel.org>
Date: Sat, 10 May 2025 00:30:28 +0000
References: <20250509090240.107796-2-sw@simonwunderlich.de>
In-Reply-To: <20250509090240.107796-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, mschiffer@universe-factory.net

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri,  9 May 2025 11:02:40 +0200 you wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> batadv_check_known_mac_addr() is both too lenient and too strict:
> 
> - It is called from batadv_hardif_add_interface(), which means that it
>   checked interfaces that are not used for batman-adv at all. Move it
>   to batadv_hardif_enable_interface(). Also, restrict it to hardifs of
>   the same mesh interface; different mesh interfaces should not interact
>   at all. The batadv_check_known_mac_addr() argument is changed from
>   `struct net_device` to `struct batadv_hard_iface` to achieve this.
> - The check only cares about hardifs in BATADV_IF_ACTIVE and
>   BATADV_IF_TO_BE_ACTIVATED states, but interfaces in BATADV_IF_INACTIVE
>   state should be checked as well, or the following steps will not
>   result in a warning then they should:
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: fix duplicate MAC address check
    https://git.kernel.org/netdev/net/c/8772cc49e0b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



