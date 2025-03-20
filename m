Return-Path: <netdev+bounces-176503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50211A6A904
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106D1882BA2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78101E0E13;
	Thu, 20 Mar 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaBHsUhv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8A1E1022
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482197; cv=none; b=nTxzwZxux2TGB/jZnJdykdKt07yD4ZR2ezydUcX84+QV2l92NED1jLs0Hdkt2Jp/E1CZ63EVkkEA8KtumF/AMaaRSedgM5nSOBsR1jky+B7gVics5ije8k0t50XI9X3iWvEuf8TrPPGneDNkxPaJLE7AhzTRbgph7MlF/BmKBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482197; c=relaxed/simple;
	bh=Y0LxBADVh1kt5S1VOwHmRSScAbXtln83ebdC8HTyHp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sD65tcbKFNbJmS+geK1Iv6UqTiZRSabuXA5gWsfrflqmeY3J07vsWlohqiLixXgbZom8bwFc8KlHIS6azPPaA5rU0EI8mgjRy59z3ndhETsJNg28EmigATEnZvYu5YCt//XN9Za3l43UjEpLy1NGu+TdmUF6PwWf1MgUORk556Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaBHsUhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F948C4CEDD;
	Thu, 20 Mar 2025 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482197;
	bh=Y0LxBADVh1kt5S1VOwHmRSScAbXtln83ebdC8HTyHp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LaBHsUhvk1B8aDoGmOzsgiFSdCRaJzJs106goQu8BnfzWkceFtEs7GBSzKXtJzbTN
	 pXXPCWdy/We3fEHdHxzbDoOhPSrHv/BsHzQK19IgIbVjRlLkFVoqdkWwtRsaYAFYbG
	 ZUcDuPM/8A4BwfURh3n617q9KapTfTM5WoCuNmc+zz5bYLkr2tQ5oubs/OkUOe1knA
	 pEBrGuU67h+7/GPXRrfzpG+Fdhn8cfsKbFzoYemy41RrrU5t6XNejDhB5NoEtXaf8D
	 xP+dap8d9SIkrPv/LupmJek/7qKoDcmtl3gX+zW7keEWlw963559PdweuYScssGP9L
	 CFqg9XHtNYeJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343763806654;
	Thu, 20 Mar 2025 14:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xfrm: Force software GSO only in tunnel mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248223302.1795325.5848574485105137769.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 14:50:33 +0000
References: <20250317103205.573927-1-mbloch@nvidia.com>
In-Reply-To: <20250317103205.573927-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, chopps@labn.net, cratiu@nvidia.com, ychemla@nvidia.com,
 wangfe@google.com, lucien.xin@gmail.com, dtatulea@nvidia.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 17 Mar 2025 12:32:05 +0200 you wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The cited commit fixed a software GSO bug with VXLAN + IPSec in tunnel
> mode. Unfortunately, it is slightly broader than necessary, as it also
> severely affects performance for Geneve + IPSec transport mode over a
> device capable of both HW GSO and IPSec crypto offload. In this case,
> xfrm_output unnecessarily triggers software GSO instead of letting the
> HW do it. In simple iperf3 tests over Geneve + IPSec transport mode over
> a back-2-back pair of NICs with MTU 1500, the performance was observed
> to be up to 6x worse when doing software GSO compared to leaving it to
> the hardware.
> 
> [...]

Here is the summary with links:
  - [net] xfrm: Force software GSO only in tunnel mode
    https://git.kernel.org/netdev/net/c/0aae2867aa60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



