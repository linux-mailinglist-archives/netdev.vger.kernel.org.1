Return-Path: <netdev+bounces-137297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F59A54F5
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AED1C20CEB
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E8194A43;
	Sun, 20 Oct 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKLvP8wB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4981946CD
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440627; cv=none; b=N+GSreEFrbeGIzSQHsGfsOxtkbL/4SAmsUci9DTgOeD7Lbwc6jP+DxfBRi0jiIOBDkp9O1w8dBA/uC18pEGJdp1DyPTEKIkvDUljCGJ9Up7MfpnQYG1SgsnQJ4oXblCKPWZ/YUL7kMjOFjZk31NoJuTlas7YhgLG4bMGeY/j2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440627; c=relaxed/simple;
	bh=iwP7B1w8vFCRWkj66o3NuqPwTrEisI4WyZDzIadgTjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mmMxdz36xVTkVAwQ1xC8X9alPUFKb8owjgqOYcHcOYG3gR+qZNltkNEKZN89GEMmWgSTrc2JWSuNjn4Ruz52sEnBBWf830Cwn+FwpN/Jth7TpZLnIjieqqOx0S7lCRUsXfhXUlA+kvHO1QsSOQ9jXWl+HzJc/SN732luNTb8zZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKLvP8wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9340DC4CEEA;
	Sun, 20 Oct 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440626;
	bh=iwP7B1w8vFCRWkj66o3NuqPwTrEisI4WyZDzIadgTjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RKLvP8wBXj6twlo79wTdSmVm0oDo4a9OZvLE1wR1Uhhnwqg++lp3KKLm7JVY9sSoH
	 G6xiAmogafpnhRoPw/QpRhJ77Y7J08ie5aZ1PagJnqtKUUPoTYNQ6+UGYdP1K6tItn
	 2OR6JmuKO+rE+A3spIarkgKiufAggJbF/DNU3mE1/ht9mOU6Mtqp0qnvB+yv1dYNZF
	 yiPJZ5Ly4J840S7Q8fW4ZD0NhOeLBKfN3twHgSdhsY1VTu7X169eBioEiAUHZ++iqN
	 AeJFC0HcxB4Q7B399WLWN3YXN+gXkO0p6/g1myujMZnzmni4DblQYXn9gPNjySA535
	 AsuJBcva6Bk5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB813805CC0;
	Sun, 20 Oct 2024 16:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: avoid duplicated messages if loading firmware
 fails and switch to warn level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944063225.3604255.10612506735627250284.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:32 +0000
References: <d9c5094c-89a6-40e2-b5fe-8df7df4624ef@gmail.com>
In-Reply-To: <d9c5094c-89a6-40e2-b5fe-8df7df4624ef@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 22:29:39 +0200 you wrote:
> In case of a problem with firmware loading we inform at the driver level,
> in addition the firmware load code itself issues warnings. Therefore
> switch to firmware_request_nowarn() to avoid duplicated error messages.
> In addition switch to warn level because the firmware is optional and
> typically just fixes compatibility issues.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: avoid duplicated messages if loading firmware fails and switch to warn level
    https://git.kernel.org/netdev/net-next/c/1c105bacb160

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



