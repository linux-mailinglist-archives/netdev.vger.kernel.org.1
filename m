Return-Path: <netdev+bounces-85680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A01089BD86
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D2B2265D
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A15FDB2;
	Mon,  8 Apr 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="budiKEGI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F25FB95
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573427; cv=none; b=ENBVhXF+nMt5Ll6AUdKk1HeieQ5kESMIiDfUfoqYrSAaW58ie0LKdvf72se/O2fpSKvP8rTwn813LdUf3HczkLTbE4YDiRXe9VGQEvuuR3VQrnsaSBhGbgEpqzKZaPE3oTd/hyIjEpQDpZJCwktw1ibeqCknD0bw1JVnn72/qdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573427; c=relaxed/simple;
	bh=coFhGZOTuVDCB3AO1aXVV2pSlrSNEbaMojvxVj/OAXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DPb4q3Lh93lFRIYS7ThnQFYZSW47GEY3nmaOPG4G7xBwATOWzbJcOcS1HQ709aZrvsGMoJlr7pZuuPTlNLaeljPlu81hpWIYD/uC7KW4MrNeNQWjcuJjvBmmTzp7+lZAZmwXHbML/RGJ9EXd4WU7K1xoNM1BmPMD1sbeMCGo6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=budiKEGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74F62C43394;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712573427;
	bh=coFhGZOTuVDCB3AO1aXVV2pSlrSNEbaMojvxVj/OAXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=budiKEGIipqL0wTpJdbpfCMw2tLwnACQ3uyjRUcNwEtcxJyVS46FTcsopqRrt87Jl
	 9pzoUPcVlg8NPHMW6+eZPrGRhvga5bON8iMetgQ5+ucS0A9R2pKkoW71345YABYUKm
	 ckQyMsrhWbtcWhIFFmaqBXNlhus5ddclYeqnf73uYbNxPoESTyYJMw3Oru7Uwk/GJu
	 U1kuRoqtmdjyTfMBFmWkcqK+6XijdorpM1ReqXwUXp/Em3NLxfWcv60GJoVfQfSSAv
	 sTK0mUvmDPqCiEYMCczsC8lOEI0V4qKGpJDL7cDsKYZhD/JnW94/HZoS0PB5lkBWjb
	 Osc1hDY/Fom4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60481C54BD8;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2] pfcp: avoid copy warning by simplifing code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257342739.21044.6095732571313830982.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:50:27 +0000
References: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, arnd@arndb.de

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 08:36:05 +0200 you wrote:
> From Arnd comments:
> "The memcpy() in the ip_tunnel_info_opts_set() causes
> a string.h fortification warning, with at least gcc-13:
> 
>     In function 'fortify_memcpy_chk',
>         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
>         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
>     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>       553 |                         __write_overflow_field(p_size_field, size);"
> 
> [...]

Here is the summary with links:
  - [net-next,v2] pfcp: avoid copy warning by simplifing code
    https://git.kernel.org/netdev/net-next/c/cd8a34cbc853

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



