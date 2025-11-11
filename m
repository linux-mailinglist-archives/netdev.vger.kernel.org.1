Return-Path: <netdev+bounces-237422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040FC4B36C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A1F534C598
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CEF3054CE;
	Tue, 11 Nov 2025 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA7dzTdE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1C7082A;
	Tue, 11 Nov 2025 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828237; cv=none; b=UeNXS75rz6FYI+xLLTjlqWW6uXhCoN0Cuf30j6sMn6P9WCq+WCWnkl7nxNtpsjPrrKIbSYj3vQBYW+YKPysXpjsgHnNVW52rPmOlX7XIQRY8jEgffr145J6+lTaa2CQkeAPEzF8Osf6Xj9HWg6dKX58eGcnxvqdF5QwPRIdqY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828237; c=relaxed/simple;
	bh=GgV9Iv0esINc2xmUnKv9b395UQpf4cgOVLAgAe8BYeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jp4ZPi9r0LbEKF/7FmnlmsAsVArzCSQYyEus4mVMZZO3/i0ECeUFFw4vZsqabC0o5EkHSqcyt4/vYSnPVbj0zZbPKtja4v1NVb7+gK15hXXG1OQJFcINMpCrI6M9zMr0rMMI76qiHFqUApOOHfKhcDcxOeGEWoUQxpzKX+FPZXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA7dzTdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA668C113D0;
	Tue, 11 Nov 2025 02:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762828236;
	bh=GgV9Iv0esINc2xmUnKv9b395UQpf4cgOVLAgAe8BYeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rA7dzTdEnsMtlUI/BO6+bJRyZQkbU01fQaFDAxTZ9MGaXz/OxgFFRRYB87O5pFUaA
	 ZYZYjC9Xin0Sq1fzVTH40owmL03Lsxwsc6zx5q7ET4CQS4P6ofdDpG7ZZm2svNxjkg
	 afSbOpno0TdBclf7KlBUPcFCZhXAYyQZ8cJJlqBKXnWRvWakHjGQ2dWWAUTGahmaoU
	 0JE8+ys1cPZQakoxIifP3biAKkxN/lbYgE6XlIjT6H8WfKGSePI1nkgsYWtiRUSrlm
	 eFoS+a6s/hvii7RIH4wVT6L4XuRkzkhS9K5o+C/Hz/B/TZSC7LUp2hXM/VR/HaEh25
	 UYd4R1tsY7Yow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F1A380CFD7;
	Tue, 11 Nov 2025 02:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: fix resource leak in
 mdiobus_register_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282820725.2856551.7984445263108394336.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:30:07 +0000
References: 
 <4b419377f8dd7d2f63f919d0f74a336c734f8fff.1762584481.git.buday.csaba@prolan.hu>
In-Reply-To: 
 <4b419377f8dd7d2f63f919d0f74a336c734f8fff.1762584481.git.buday.csaba@prolan.hu>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mail@david-bauer.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 8 Nov 2025 07:49:22 +0100 you wrote:
> Fix a possible leak in mdiobus_register_device() when both a
> reset-gpio and a reset-controller are present.
> Clean up the already claimed reset-gpio, when the registration of
> the reset-controller fails, so when an error code is returned, the
> device retains its state before the registration attempt.
> 
> Link: https://lore.kernel.org/all/20251106144603.39053c81@kernel.org/
> Fixes: 71dd6c0dff51 ("net: phy: add support for reset-controller")
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: fix resource leak in mdiobus_register_device()
    https://git.kernel.org/netdev/net/c/e6ca8f533ed4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



