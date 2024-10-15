Return-Path: <netdev+bounces-135526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0399E315
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C15B20FF7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E781DF25F;
	Tue, 15 Oct 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thsA3RnP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F118B488;
	Tue, 15 Oct 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985826; cv=none; b=efwOiVQObgTArOfjiNVi3Sg8RIfDkVVT8z9seiecCP75teCLT7xd6VdvZXfWMJRYhIiQzgPGSCRZQG5r1SI75yHkKyAgte54brI9Jmt0pdZHYCs3cwLnsJxzJ0t26PXPcd8p2xh+YJQ3SagKhVaTb5b5h9PhWjhJOkQwG6cOTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985826; c=relaxed/simple;
	bh=IL/aasB5Mbbp0AzbnKR65ranGjZKkWCwdkk+VmxzXGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mdIMLEjAahgYKX7aJkggTF75nwvXwkP7PlZEIYKf24jj4gGWi1SZe/sESmF7WwSGk5+M1Rt4KG9+CIkjJAJGXH+BSQswyN68ZHlYeTT2gM2z0xJvkDVTCVv9tECS0rqA/E36sDg9h6qh2bhzufKHAzYA015gRPb1p7MeTk5FI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thsA3RnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C454BC4CEC6;
	Tue, 15 Oct 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728985825;
	bh=IL/aasB5Mbbp0AzbnKR65ranGjZKkWCwdkk+VmxzXGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=thsA3RnP2sg2pLXaR99tTE91bEEeiri3hlj9Fqh2yuhEInIyKownouGzqa6JmqVLv
	 lSNmtkHzi7n25+yV9e8IEDsZMh3+aG2TItWK0Sa5pAEWbmwyJfJkCcfHF3GbkxbpQd
	 5JSPcIbaT+rmNlrqXm5PfePeqOXwhxNIutmubVhChSzSCBVFQlebB0KWMQs3I+h55U
	 9wvk6QRPIOumBpjZPPwctgHa8i8k7je+hnyAZlgDKROCgH+sZzydEafBp1YoXPF5c7
	 Nslko3wqapLPayoRryIjlpnI1Cj5JBvHoCxzC5aLdmV3Mn54I3IYM4RSCOOYf1fsYA
	 Uoqb7HvZGEoFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9D3809A8A;
	Tue, 15 Oct 2024 09:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: usbnet: fix race in probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172898583101.1097558.13664462177713787665.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 09:50:31 +0000
References: <20241010131934.1499695-1-oneukum@suse.com>
In-Reply-To: <20241010131934.1499695-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Oct 2024 15:19:14 +0200 you wrote:
> The same bug as in the disconnect code path also exists
> in the case of a failure late during the probe process.
> The flag must also be set.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> [...]

Here is the summary with links:
  - [net] net: usb: usbnet: fix race in probe failure
    https://git.kernel.org/netdev/net/c/b62f4c186c70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



