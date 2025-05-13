Return-Path: <netdev+bounces-190277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2EAB5FA8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005823B6C3D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFD02153D8;
	Tue, 13 May 2025 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJh11/fw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B75215181
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747176618; cv=none; b=SG4UQ52Hw88Jwh/ttwibHyC+1A9pgw16iXUPp13X0IAV+BBGj2KE5NDLeb3DV00/DjKrH/hlOGyXi0bSn5qx+RAooLr+AqkaF4sxD+TmiPtwftZpf74XNqEdP5fuGSlrBQnIqVLf2EEm52CVV8OGP7FeaPy9Xb9YslkrXe3n6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747176618; c=relaxed/simple;
	bh=rhIHqO8VE568SLdFGyEAvdzWO3eLbHn2DCM7VPzCHjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K804R9WG6knFVOiK4W/IxovxtCJHbIMojovBLVRnfW0XUDHZoqBofopi9a/OcWcq6WYbn4HaGkrSkEvsufW4A8jcw0RKX0kHQ/1vTO2gW0EUPADCUoj2xIHnbrLi/LDYvRX6Eew25pZbQPtwpziLKCyLQda/AdqNNoQok2c1DDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJh11/fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C07DC4CEE4;
	Tue, 13 May 2025 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747176617;
	bh=rhIHqO8VE568SLdFGyEAvdzWO3eLbHn2DCM7VPzCHjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NJh11/fwaGboOMbVZ4qzg2YlAGw9jcs/rFWBYjWDmfQubxsCC2ipEUrBYcnM9m5uf
	 TiGmn/ErFtCBXaEg9YAjEglbqUgwZpvIOLYGi5w8xhG0rMhh9+CyUfK1gTkTjM3Sv7
	 yPVLVrdvhI999SXoFu22ul6gV5OH1jQmnETCzB3pRDbBaUFpxXAQ7TJHNECO/lDWsn
	 cRaZzAv0pbQTixGNYEj15FK90Gwv6P+9TjDwQ0aRHE8xLrqCRIE4N5R/T44bZeuzB4
	 rZRSoFhfgPM5x2MA49V4z3yOoZTxCuGNRHZ7Ua+dDZRAPaTQ6UGkfs354JFh9mgkey
	 Zm5zMMly0zWmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4D380DBE8;
	Tue, 13 May 2025 22:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: txgbe: Fix pending interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717665500.1815639.735866145060326141.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 22:50:55 +0000
References: <F4F708403CE7090B+20250512100652.139510-1-jiawenwu@trustnetic.com>
In-Reply-To: <F4F708403CE7090B+20250512100652.139510-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 18:06:52 +0800 you wrote:
> For unknown reasons, sometimes the value of MISC interrupt is 0 in the
> IRQ handle function. In this case, wx_intr_enable() is also should be
> invoked to clear the interrupt. Otherwise, the next interrupt would
> never be reported.
> 
> Fixes: a9843689e2de ("net: txgbe: add sriov function support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: txgbe: Fix pending interrupt
    https://git.kernel.org/netdev/net-next/c/904c6ad822b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



