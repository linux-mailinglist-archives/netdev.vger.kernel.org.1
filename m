Return-Path: <netdev+bounces-181033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7861BA83682
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2F2443B70
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD301D63F8;
	Thu, 10 Apr 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPHZp7UL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA781D5CFD
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252197; cv=none; b=EgC8XnclhByrah4WY7o/RO4qieZTbpqaAClYYUUCksLM/xHr7xJpL2uwAxetWvVst5b1Tgc2GiyijKjL7w0N53+vfjQH6wJFsh/ertLr9PDNl4YJkCcp32NLferTJVLY3KsPOwf/Vvkn2/VvhNYRIiNFfkZvOHbN4jDfb1PSmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252197; c=relaxed/simple;
	bh=c1LDfpNmdBmGmyn01jK35vvnGQrJB5pX5fwgBVkfZeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dug5vbPoo4A7CBKNWH37zFhregbAmmBnxkWb/WJjaVreR5HGSDsYeLi61o/3kmoh90mqHUnN+i8yfX8ZISwiIaVTAMHYHx6jewoU56SDSN4R8S6jqd3g8bx22SfEK7Y+vYWuOCaaMGPiyPEfyy+7NJLC+MmjH/BoL9WekapCKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPHZp7UL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75479C4CEE2;
	Thu, 10 Apr 2025 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744252197;
	bh=c1LDfpNmdBmGmyn01jK35vvnGQrJB5pX5fwgBVkfZeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PPHZp7ULR5Aw5xrqdbchkS+Vuq69hVS45Btk84XQenK1FJ6fMT4vPZqNdwm0WtSPb
	 2Y/t4qK+c2ZFrJU4whSyZ0QwNStQAzkMFAWbT548OBmp/AwEL358iGYI0CYrxLt2tH
	 HrStnqzbY9m0Xsg6WYyVqEfdY3hrSUONLQjIMmXgrVfLQs9FRfTdJG5IG5nucQVr4h
	 cK2Y9Hv0lH04s9/NekAGFDHiJTD8JLR67INycXWsZVVX8CLlS7CbPYd3zyuyjaVv1g
	 BZDO1ZV9taOZ9Qf+FzSvScHUPalN/QCcJBaskth2nYXoed4eV+8EtP332/+YCJUv+y
	 htS7w+xCMj2rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3577638111DC;
	Thu, 10 Apr 2025 02:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: cortina: Use TOE/TSO on all TCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425223499.3120264.4252756991309364861.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 02:30:34 +0000
References: <20250408-gemini-ethernet-tso-always-v1-1-e669f932359c@linaro.org>
In-Reply-To: <20250408-gemini-ethernet-tso-always-v1-1-e669f932359c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Apr 2025 11:26:58 +0200 you wrote:
> It is desireable to push the hardware accelerator to also
> process non-segmented TCP frames: we pass the skb->len
> to the "TOE/TSO" offloader and it will handle them.
> 
> Without this quirk the driver becomes unstable and lock
> up and and crash.
> 
> [...]

Here is the summary with links:
  - net: ethernet: cortina: Use TOE/TSO on all TCP
    https://git.kernel.org/netdev/net-next/c/6a07e3af4973

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



