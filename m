Return-Path: <netdev+bounces-222040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8DEB52DD8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BB118935A8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC025303A13;
	Thu, 11 Sep 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I59Z5Wei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F2303A07
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584807; cv=none; b=onrqS2ath397J0bHz5KuOKOZ2tHoGeQsHoKCPQFP0MUJOhGpZAwk2qKK7cnApD6MSR/z4Xn3OVxkDAN0dNUXTOrcSZChHamnRqiZoviud+PqzrcGI3ahuQFIk1oPxis81mcClAEy8hZWSRnzMJuXlH28SFK8LnwaOUm7hqKW/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584807; c=relaxed/simple;
	bh=Hg0lptivFc7tv1KMbKKN/souJdrSQrR+jxjMyvPrlCs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=flHRZffXeKSC0rRqgi1B9dVS0nsvDWT+6j3PJ4fio9GdhYiXkvDTTKuNjbMxwUUWec3RnyhzqyO1v6sPUPTTnJqPzUJeooG5f+Qz0kshAjdpxk6SgpOoYwHXF07mWfq1Gd1smPEG0H2ql7eWlrtONMJhMQdzpyWH72HNcWB2mE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I59Z5Wei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44144C4CEF0;
	Thu, 11 Sep 2025 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757584807;
	bh=Hg0lptivFc7tv1KMbKKN/souJdrSQrR+jxjMyvPrlCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I59Z5WeiKwC00crIbbfSh4K03ydJTM5cw0Zgbjr8Ov33cGSUAzcIAcp6tMKpokNIa
	 4M17WKcfgqTJxwMEbfOrWU0WbBTLL7uR7fqSUOgpKKz4GZ5e2oYcSi8XQcUWee2y9J
	 Gg3uhnCQUeaCRCtzcGtUN8PvPLzqJlG/lnhOCYCigwZfYNjccUDRrRzMw+uI/ZDm6g
	 1ydNDQO53UcpXCc7ClYu3IIcN9kMUdaaF34JFk5cV+CZ77AzAgB5cY8q3BgNDcWG3X
	 3HJWAQbbCYm1H812dhPS4ubZMCP2lniucbCQzcZ7unWb6mnu8DwrxZn4W9QCHDQhNE
	 gRk4FXAhIqj+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1F383BF69;
	Thu, 11 Sep 2025 10:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net 0/3] hsr: fix lock warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175758481000.2111220.9133355374443467875.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 10:00:10 +0000
References: <20250905091533.377443-1-liuhangbin@gmail.com>
In-Reply-To: <20250905091533.377443-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, danishanwar@ti.com,
 aleksander.lobakin@intel.com, jkarrenpalo@gmail.com, ffmancera@riseup.net,
 m-karicheri2@ti.com, w-kwok2@ti.com, sdf@fomichev.me, shaw.leon@gmail.com,
 kuniyu@google.com, johannes.berg@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  5 Sep 2025 09:15:30 +0000 you wrote:
> hsr_for_each_port is called in many places without holding the RCU read
> lock, this may trigger warnings on debug kernels like:
> 
>   [   40.457015] [  T201] WARNING: suspicious RCU usage
>   [   40.457020] [  T201] 6.17.0-rc2-virtme #1 Not tainted
>   [   40.457025] [  T201] -----------------------------
>   [   40.457029] [  T201] net/hsr/hsr_main.c:137 RCU-list traversed in non-reader section!!
>   [   40.457036] [  T201]
>                           other info that might help us debug this:
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net,1/3] hsr: use rtnl lock when iterating over ports
    https://git.kernel.org/netdev/net/c/8884c6939913
  - [PATCHv3,net,2/3] hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr
    https://git.kernel.org/netdev/net/c/393c841fe433
  - [PATCHv3,net,3/3] hsr: hold rcu and dev lock for hsr_get_port_ndev
    https://git.kernel.org/netdev/net/c/847748fc66d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



