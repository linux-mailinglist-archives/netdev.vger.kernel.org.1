Return-Path: <netdev+bounces-133623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC42399687A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A521C21A0D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF7191F6D;
	Wed,  9 Oct 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlFU/+bk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F37191F65;
	Wed,  9 Oct 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472829; cv=none; b=CKs7RpdsGDNIUw7rizbgrzBMvfym5AlibIJLTCyJGGWBKCvochpCwcXGQZWDS6nUVKGmnVSJfXLxEZjqupzugMo2hcJgRwQhMKNmHm4UyjHfbVvVYEmGSp2FEWqJUlDrrlosbrCXLFdviTx8ODSS/0wxbBr4yheXmljMrt7e280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472829; c=relaxed/simple;
	bh=lepe6ODduukxewlVrTOaBuryD6wgIVqOjUmzDxDh/z8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nVT3+4aJHLwl2UwHiFrJxZJSFMOcBweNYbLhIiyOnj1KEsEfGyr3gQjcfZjEIGF1euJLqpZ8UzW3tMTZxMZZwwDecy5SoxizQmFdspAYbcVzBVxaOENccF76wOfHa2Yv/lV6zLRQBnkzpQEEX42kWTAsgRbhN7ZyeXYtArULprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlFU/+bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59B9C4CEC5;
	Wed,  9 Oct 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728472828;
	bh=lepe6ODduukxewlVrTOaBuryD6wgIVqOjUmzDxDh/z8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qlFU/+bkB9I0OcSqk1Xi+HBurMSooYbDCGd8t6R++uew6iIoCP6nOJVdvA2cd708B
	 Vqr9vyWmGdGYQ/oz0xfXQTbZNVJg40xdbrRgjhU3ZhP/f1BzZNUUvCDXgxqAtoUSVS
	 YMfsWt5K8wZHw8y18LQad0u160oDxh+I4uMhKeboNPRY6n9WYJ3dU8ql2B+01rheRi
	 KlPIb59iKPqi1K2WH2dmlv9JlUMH9pgw5Aqa7QofF4h/0IbeSxy14Woq2r2m1zAGB2
	 B3H1CTDVO8EKgAQUw/XjxA0fOHuoujMQJpLwAvco965pQjGkLjG5qa4g82aZ5uYnv8
	 J0aClMZBNwyJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BBF3806644;
	Wed,  9 Oct 2024 11:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix race condition for VLAN
 table access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847283307.1228916.1437413215215722558.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 11:20:33 +0000
References: <20241007054124.832792-1-danishanwar@ti.com>
In-Reply-To: <20241007054124.832792-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: robh@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 7 Oct 2024 11:11:24 +0530 you wrote:
> The VLAN table is a shared memory between the two ports/slices
> in a ICSSG cluster and this may lead to race condition when the
> common code paths for both ports are executed in different CPUs.
> 
> Fix the race condition access by locking the shared memory access
> 
> Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ti: icssg-prueth: Fix race condition for VLAN table access
    https://git.kernel.org/netdev/net/c/ff8ee11e7785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



