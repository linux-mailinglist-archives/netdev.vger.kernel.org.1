Return-Path: <netdev+bounces-70581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937684FA38
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D5B23C44
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423F823B4;
	Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1FRB6q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4E81AD4
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497430; cv=none; b=g2vElO8GT+qpqSn9WK/5G0d/8b78PcxAZbkdoa5QPXpateFjj3IU1LznIMecatO3gM0JayVbl4T7ZLZk6cEaNMUHhwyg45mut0/Fsg7bTBOUqQvXguYMAF+iuTcJUXE5z7eYSb+IpARFvZE/ZYrgNodZ0F9pjUGM1jD1SCuG010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497430; c=relaxed/simple;
	bh=eQcd4DW4LQiVRlyQ7jth4nU9sqQRE5Hw0qJ2KYeHBHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S3XVtcLNhppteHmb0oDwlh8vfWbvRYyq+zPBF+KkcQZpHYUEWClwxzxvjmB280l4qhRHSVXXwR87lBZkclxz+2Mp+uESkvxj1ZP1iRHKXvYiw/efU7xtP6q0EjnCXSNTR26CIJ96kwU0xPWQSxiQGwyHKKrsth5zhNA6XJ5+jhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1FRB6q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3076BC433F1;
	Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707497430;
	bh=eQcd4DW4LQiVRlyQ7jth4nU9sqQRE5Hw0qJ2KYeHBHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L1FRB6q8R8j3jC2k3B+yCxghLppjUTJGOhF59SKO+NPKIem9d6XPPVDdkUAYP8fXq
	 pKneVEdxr0URUCz0V3SnCXy7SgtTFTx2bFgFUdDPOh6i5s827O9uni0ZAzHYSgvNae
	 GvKwAA2lOFaR05rKisjl+zomtYKMBO1TBH6wl8E8ylx/fE74heMTqpmq/QQmfxd8ns
	 zm2iinh1nuynY1RH6BRMXC+bOzguKdAyecFvExCyn8f1CBs43hAADMDxgyIVsq5UZY
	 wQqkkyDuLkKAAvVmEtinKHXE9WX9vmzE4li4abL3PJwo1XznQiUM682l06jY/iACPr
	 mDOul3jNCrw0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15F32D8C970;
	Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 1/3] ctrl: Fix fd leak in ctrl_listen()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170749743008.28784.542691478266400859.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 16:50:30 +0000
References: <20240208172647.324168-1-stephen@networkplumber.org>
In-Reply-To: <20240208172647.324168-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, maks.mishinfz@gmail.com, maks.mishinFZ@gmail.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu,  8 Feb 2024 09:26:27 -0800 you wrote:
> From: Maks Mishin <maks.mishinfz@gmail.com>
> 
> Use the same pattern for handling rtnl_listen() errors that
> is used across other iproute2 commands. All other commands
> exit with status of 2 if rtnl_listen fails.
> 
> Reported-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2,1/3] ctrl: Fix fd leak in ctrl_listen()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f4dc6a784f6e
  - [iproute2,2/3] ip: detect errors in netconf monitor mode
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=00e8a64dac3b
  - [iproute2,3/3] ip: detect rtnl_listen errors while monitoring netns
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=8f340a075138

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



