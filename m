Return-Path: <netdev+bounces-239369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5601C673CA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 366E04EDC64
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8722DFA5;
	Tue, 18 Nov 2025 04:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E36Wz/qn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50A35972
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439641; cv=none; b=KkD82VbcpIDIKchtS2G0En6r1IwBO68fso+igRoT++Jp80NdWTn2F1dBnNAg0TheaXG23S8OOG8eRk9vigrC+d3nDFZpq9qV4dznl0TD6XFeX8cX7PoSMzh3sm4yX4B6FeBEtrwr4U+XIkbgb8h/zwjj8OPcdFHykTTp1vlAk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439641; c=relaxed/simple;
	bh=ESYCJhFz6qvRXOfOOiFBo9T3qoVii5Lf9a/4mxUB+n0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h2p+gqeSj3p5NV1nGPbAcHh4jgESBQ6NscEk2te7v07INjXYoXpuBylOo25jKRMiLo3zt5/hsYZtqeWnRu503PMfIOvt/SDdEiIKrzfsTIPP7g9BMshYNgeSAGA4QgR3VhRtBNQMnzjz4TqwTQA6/ZNZCRVzw2urscyKbOvM978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E36Wz/qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5A9C19423;
	Tue, 18 Nov 2025 04:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763439640;
	bh=ESYCJhFz6qvRXOfOOiFBo9T3qoVii5Lf9a/4mxUB+n0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E36Wz/qnraHqzKHy5Ady5z9Nirm3xJKWR/ATFTzgAHLdwQ9FKcGxIWGOSXiNvSaaT
	 NljXVLBpLDcBThuq9ZAIB8bZ2eVtHMiT4QNyVlXBBlLn2B1QZuWL8Avu+LDrI3t3/e
	 DttRUTUCq8dp/zktvRCAHqTSH5wAqCNsQgRi5jSFrU3vMMFXyvGb/O1QgyJQRE8ny4
	 hLXYnc/k3QgdPWFf32OWflWHLAyge/GoRCR0ziH6uQqb9s1lcSgGEwiKFjyX/gELI+
	 taMU+y88P2n1NXz41iR/UuIH9b+MgzfRBk67F95j/vdIPL0XA0IPlxj8I4xJnGR0yi
	 QLySqpUg8mD8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE43809A1D;
	Tue, 18 Nov 2025 04:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Do not loopback traffic to GDM2 if it is
 available on the device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176343960603.3966336.2301891207348602792.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 04:20:06 +0000
References: <20251113-airoha-hw-offload-gdm2-fix-v1-1-7e4ca300872f@kernel.org>
In-Reply-To: 
 <20251113-airoha-hw-offload-gdm2-fix-v1-1-7e4ca300872f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 18:19:38 +0100 you wrote:
> Airoha_eth driver forwards offloaded uplink traffic (packets received on
> GDM1 and forwarded to GDM{3,4}) to GDM2 in order to apply hw QoS.
> This is correct if the device does not support a dedicated GDM2 port. In
> this case, in order to enable hw offloading for uplink traffic, the
> packets should be sent to GDM{3,4} directly.
> 
> Fixes: 9cd451d414f6 ("net: airoha: Add loopback support for GDM2")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Do not loopback traffic to GDM2 if it is available on the device
    https://git.kernel.org/netdev/net/c/8e0a754b0836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



