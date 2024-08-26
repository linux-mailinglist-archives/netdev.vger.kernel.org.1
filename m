Return-Path: <netdev+bounces-122070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5660695FCCA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063271F24DA2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A9319ADAA;
	Mon, 26 Aug 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T56jXZvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BA199392;
	Mon, 26 Aug 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711427; cv=none; b=JXeSVYLoLJ7iMJmLuzNwEGwTpBGrA7G56Zt/dxV1HXsXv0FuAGBpk0Gd9LuH/GehaUDCO3REzdFninATJ7ZmgEP4Rok7iWBEsb6Xs6uDXqiKXPPQg4r0l4eEvIG4r48fA0v7cDLIMnVCg8LnuYf6pKB6E4OdfEI+Qc222leP/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711427; c=relaxed/simple;
	bh=z+sF/O3in2guc/ktcX3snW4v58k0nbXORFzSl1yZG6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YWWhl/Lp+IvhvhSaTTt/q11iWMZKJI5GQLnnXP801lGi3UBp/URHWOLfjZfq/6MWVBkY55y1FWCC2B+P0W69YIWDyPnYCz6ZOTTVTvLQYmwJnTnWL+zjCws337GUsVBTatmCocLZzM/SXTuYScGu+YRlZYOg2COvoFr5IeibWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T56jXZvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF8BC8B7A7;
	Mon, 26 Aug 2024 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711426;
	bh=z+sF/O3in2guc/ktcX3snW4v58k0nbXORFzSl1yZG6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T56jXZvMH2fZgr8yoR94D4WPAGUlYg4tcMJY9rjWOe2rJ20PShWOX7fEz9nT02mhO
	 MyPUnVmobhG/aYNG6DADC8/NR+firAS3CVCUIBb7qf729Lk+TLxlmVoZKkqrbQ+Kz+
	 jU2vcOceUTVLNdvhzUuA+b5ijTVKZO1eWdKppjbRVnIuiCR9hgLaf3Cx8Hw7Y6hdl3
	 J5D5ny5Jf3kjXgG8zjK1izzA70tJo1/xkX1Rd15XuvnSXLxKoLw5fYp10MXKlo513C
	 FHM0/FQnr00cn0c0SDUMOU627zWeQPvA2OQHZmZxxN++WE6c4mZxbsjH1BbwE6vprQ
	 jlX0Har7PwNdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBD13806651;
	Mon, 26 Aug 2024 22:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ethtool: check device is present when getting link
 settings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172471142650.144512.6072386483155129089.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 22:30:26 +0000
References: <8bae218864beaa44ed01628140475b9bf641c5b0.1724393671.git.jamie.bainbridge@gmail.com>
In-Reply-To: <8bae218864beaa44ed01628140475b9bf641c5b0.1724393671.git.jamie.bainbridge@gmail.com>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, suresh2514@gmail.com, johannes@sipsolutions.net,
 syoshida@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 16:26:58 +1000 you wrote:
> A sysfs reader can race with a device reset or removal, attempting to
> read device state when the device is not actually present. eg:
> 
>      [exception RIP: qed_get_current_link+17]
>   #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
>   #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
>  #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
>  #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
>  #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
>  #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
>  #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
>  #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
>  #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
>  #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb
> 
> [...]

Here is the summary with links:
  - [net,v5] ethtool: check device is present when getting link settings
    https://git.kernel.org/netdev/net/c/a699781c79ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



