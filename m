Return-Path: <netdev+bounces-180183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B261A80029
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C38317330A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E92267F65;
	Tue,  8 Apr 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYXGqoDw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF126738B;
	Tue,  8 Apr 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111195; cv=none; b=C1w4YfDW6CVdIiJElbsyKJK+FZyI/dYpbXLAdWnH9rzBqs15R859XDIhWAJaJ18TzCdg6cYVWXfzL9FHBjdmu32O+c8TF02bpRB/zR5WynD0LSzr4GCPowDRaThgjgtq592HiTOu4XBRc3ZJCxPMIL6//cJWnomXBhYatg5Ick8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111195; c=relaxed/simple;
	bh=YIYWQIhz48YbSQFZb89VL/7r46qg0r/A90qlSIfSg20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ic2heAvqW1EvtPbVC+KM+tuT3dETpRyK8F8LYeiHt/hSRWvtIKjGBVBC6uADWbXx9DHFbiEmytNMq8YRV/dThlom2cl0GJTwQanxyKnlnB5+KbwKGXw1HaMYZj3uzyVVYSTRzIZQlHSfe7ycA8/NoPnWyB/aFvQKvjd1zgwi8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYXGqoDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E41C4CEE5;
	Tue,  8 Apr 2025 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744111194;
	bh=YIYWQIhz48YbSQFZb89VL/7r46qg0r/A90qlSIfSg20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LYXGqoDwq15gOXcrI/rcYT6+0inOmXP2je0Zu2OZG6mUGSC48nVLtI1JPPbvl2s0O
	 AO4mgfcSQ+9hBNlCZLNgMsEg5fT43tZxMA2i0ud0tMJxANKzXl8gWPvCSfPkYpRrpa
	 HgvcNbpAWnW0eki06ch8uX5ZTOxVXJIceLUM0Omu1aNlWM21lac72MZGVHWnZ6ewfW
	 2y35KqrJPn9zIOkBdmYhEn6iGV6mScRGogYk3yjMz0FeyDvtJmFTtxZ+mhc6xT4SSh
	 6mQKbuvl9wZyAIFgDrD5SDurdVeV2vyn8if1llKHsJPDBX1W54aybSDcoq9QsvIoJw
	 gu2cTbpcOYEhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7197038111D4;
	Tue,  8 Apr 2025 11:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rocker: Simplify if condition in ofdpa_port_fdb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174411123226.1881371.3532819555367926213.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 11:20:32 +0000
References: <20250407091442.743478-1-thorsten.blum@linux.dev>
In-Reply-To: <20250407091442.743478-1-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Apr 2025 11:14:42 +0200 you wrote:
> Remove the double negation and simplify the if condition.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/net/ethernet/rocker/rocker_ofdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] rocker: Simplify if condition in ofdpa_port_fdb()
    https://git.kernel.org/netdev/net-next/c/4acdd3de31c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



