Return-Path: <netdev+bounces-109583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D857A928FBB
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F193284123
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFE4C66;
	Sat,  6 Jul 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqKaYNWQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96762629;
	Sat,  6 Jul 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720225232; cv=none; b=bFtP6n7Enm6UQ0H9sexPGuE6CSkfjNgw+WhgwykTAfND4MiUroUrRh/BMcjpL20Paq4H2QQDAsiDQSeH2Ls4bXyXTeEU96E4zTBvqrs3jA53ytEJs3T5eaVxqvEIcuwpKYOAW5w3QDUbngIeqWn7ZHZ5gw3SCng4FAwHKXk7lgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720225232; c=relaxed/simple;
	bh=mTFJwvimHXfAAulibMAiNcci7VWAw1aUgc5lWwsGlzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dbm6rEkMa/XwSIGMt8eJpoc1wJNLRYAJrJsl+E9DXkdAYv/N0pPIIOdNNl09M0RChoNOC9en3NV1hW/nOFAgyo6pz6y5zvNAW9brnqOOH4x+MqwRc2RztNHSaip+n2qKClAf6JzFYnO4Yk3wANNzX2uNn3zOuQNsJp6tGEnndbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqKaYNWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E7BCC4AF0A;
	Sat,  6 Jul 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720225231;
	bh=mTFJwvimHXfAAulibMAiNcci7VWAw1aUgc5lWwsGlzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hqKaYNWQHVzxtLXwo8RWSYlirR2212yBeF5EACILm6jM7uwkl1Mbqzxkny6Yudi0P
	 HZOC68T4P1kCUzR6tlkia4jqctQS7GHsgDt4tSpyQ21t8DmuvbQv6MVgcrFtVq4FZ8
	 ZcWxRQKIGZwepY3euo2QfAJIMd4q3nCjcdlCH+2hOT/rwyqhMhhGZpvSC67EHxXleg
	 rdUpitmHnKPG6DWEXrQTFArhXRK9DSDR8Ut0buq4pr6mHf3ZmdtZPK0snhlqth1hIG
	 oVmgkIiNazL/tGvEUhjctZzaagbbaxmm6so4f3EcBr68lGP2I7a6EGy4p/BkqPp6RL
	 IgD3efAfD30FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BF31C43332;
	Sat,  6 Jul 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmasp: Fix error code in probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022523104.18034.11968225683723635232.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 00:20:31 +0000
References: <ZoWKBkHH9D1fqV4r@stanley.mountain>
In-Reply-To: <ZoWKBkHH9D1fqV4r@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jul 2024 10:19:44 -0500 you wrote:
> Return an error code if bcmasp_interface_create() fails.  Don't return
> success.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] net: bcmasp: Fix error code in probe()
    https://git.kernel.org/netdev/net/c/0c754d9d86ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



