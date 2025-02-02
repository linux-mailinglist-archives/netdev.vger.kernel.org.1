Return-Path: <netdev+bounces-161951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1CAA24C5E
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE8A7A287F
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 00:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426CBE6C;
	Sun,  2 Feb 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFikwgdg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E8B665
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738458008; cv=none; b=NclpC2vA+BzQ1gzp2tz+AbXqpoSeHvTtdUxdoedNBQevd3YggmBe9ukOV2KAijy2Fr1B4yk0FSmyOF04AeU1d/s0V+6mAzHJLrF8nzcPdhD83wgSRckCt2nuyPfH0WTNIn+SbZ/iD3n2HuyD8Of/5wroIyt96GA5bpvpbhVxbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738458008; c=relaxed/simple;
	bh=9tXjQwQY6NWy/WXsAVVe6XYSe/GURHg8b/PVOtzup28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cg5xrs+jm/m9AvyRTJAeEakXfZmJ3i7TrNTOrBPln3i8/Rsi612lusqhuMPzpzO48hH84fGhq0wqs4Qgu5WiHrsQ1hBiQ399WuEGryln1tZnx2kodryOpA2FpBw1HQcQtNF7wR34MHOF2ahjhhC56SGqpIHog7sdbD1t5VZ2YHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFikwgdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3FBC4CED3;
	Sun,  2 Feb 2025 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738458007;
	bh=9tXjQwQY6NWy/WXsAVVe6XYSe/GURHg8b/PVOtzup28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aFikwgdgAOKRpJnkbtQv9/Akyk6Pjcfjffz9ao9jpfUxbCAtfW/KK95/G1FrSGoDP
	 wD8gCSI9j4NghMg8daZPIaHdUl+24gbJYviQtmGR6z2fdjCHatshb4hEcMCzSGhHIE
	 eGUpDGPWI2yOABxrRd8+hwX1SM141c531NKzoZKtwWF94FhME5w8BZ1GMGyXL2A4lL
	 Qzc6XtJoCcWQhQ1ZBUvy+Jg/M2C1r1AwD3EcCC/EL91ndwuhxEuMGsPo+oASq0YxwL
	 FXrQ/cu2vHSJwlchuLiIM9N8DUwmarqI9T4W87fDsWWnjHpNvkIvFDYis7J335zMOg
	 n53HtAh8vGitw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE29C380AA68;
	Sun,  2 Feb 2025 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net: ipv6: fix dst refleaks in rpl,
 seg6 and ioam6 lwtunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173845803452.2027595.4967838744169965425.git-patchwork-notify@kernel.org>
Date: Sun, 02 Feb 2025 01:00:34 +0000
References: <20250130031519.2716843-1-kuba@kernel.org>
In-Reply-To: <20250130031519.2716843-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 justin.iurman@uliege.be, dsahern@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jan 2025 19:15:18 -0800 you wrote:
> dst_cache_get() gives us a reference, we need to release it.
> 
> Discovered by the ioam6.sh test, kmemleak was recently fixed
> to catch per-cpu memory leaks.
> 
> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
> Reviewed-by: Justin Iurman <justin.iurman@uliege.be>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels
    https://git.kernel.org/netdev/net/c/c71a192976de
  - [net,v2,2/2] net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels
    https://git.kernel.org/netdev/net/c/92191dd10730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



