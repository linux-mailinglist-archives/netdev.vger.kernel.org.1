Return-Path: <netdev+bounces-210906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4EB155FE
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6B65A046E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7D287519;
	Tue, 29 Jul 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e271msj7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593D2874EA
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831794; cv=none; b=QZkIG+dpcWZXGuJ6NA6XYmVQ4p48xoC8x4ajqtfmPAsnfE9UWIPp3TAC2Q5JI/PcdGF0qiDBhMA/Cc0Xd4RBC9BUxU18TMZTioxkA705wz/AhQnKwVpNxEr6cT7Atr7GB1SaQZV49MygirFosFj/KAfS13/Q/EZ3pQ2NOmGmkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831794; c=relaxed/simple;
	bh=MQthS9001OBWnzC/PZatA3F+SaO/cpH+8NagnTiuOXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=exFfyFiWq2631UsO4lWjSZSWjkwt8gq98mnYGQBvgLqqahGahjQDbQhKAirRIDOECS1KC6xenxxn+4yPRgEY3O9nOnWmOlnlm7DoZ32azi/xxS0R3C8kZNSfpFSmNXQ41ucKeCH+O33/BxBfacsyNxTeImrUH2G4XMJ6VMquYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e271msj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B411C4CEEF;
	Tue, 29 Jul 2025 23:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831794;
	bh=MQthS9001OBWnzC/PZatA3F+SaO/cpH+8NagnTiuOXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e271msj7dkCO/WCMfGWCCKauCkc5+PJxrLdkJhqui8fsxHLl+dLjkicvMpsLKrGdC
	 6JRQTCCHd0fraXBgmmEodoBEtSR5QrmCKcM1rwEIW7f3vQr7/Uqq33LKKkQWWfPYx0
	 ilvH5JUlvEG9SU1uODzuSTIAMBmpAWe/ms6qooMWTYo1CmYEALGD7H0qksVg1bUi/F
	 niaDwk0/tSjOwvTzDfZ3zVKNbLYsBgQshcAb9dhutptRIghJeQy4AgPheC/ifjvvyq
	 zJT1oNgvWl1x9ghtu3DSj03ohcIjaiI1BPePVE5FInQ/+kRb2BT7C0S+uY/xkFUIdT
	 pXID44+2kfqaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3C9383BF5F;
	Tue, 29 Jul 2025 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 iproute2-next] ip: ipmaddr.c: Fix possible integer
 underflow in read_igmp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175383181025.1684209.1251405483737540810.git-patchwork-notify@kernel.org>
Date: Tue, 29 Jul 2025 23:30:10 +0000
References: <20250720153843.62145-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250720153843.62145-1-ant.v.moryakov@gmail.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 20 Jul 2025 18:38:43 +0300 you wrote:
> Static analyzer pointed out a potential error:
> 
> 	Possible integer underflow: left operand is tainted. An integer underflow
> 	may occur due to arithmetic operation (unsigned subtraction) between variable
> 	'len' and value '1', when 'len' is tainted { [0, 18446744073709551615] }
> 
> The fix adds a check for 'len == 0' before accessing the last character of
> the name, and skips the current line in such cases to avoid the underflow.
> 
> [...]

Here is the summary with links:
  - [V2,iproute2-next] ip: ipmaddr.c: Fix possible integer underflow in read_igmp()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=5734dc8aa703

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



