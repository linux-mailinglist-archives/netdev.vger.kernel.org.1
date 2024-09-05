Return-Path: <netdev+bounces-125474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86B96D351
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E42A289368
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ECA198A31;
	Thu,  5 Sep 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtROgWNI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E4198A27;
	Thu,  5 Sep 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528628; cv=none; b=bjU7P0G0whQm0pX8hFYZKYF6qudGEME0FY2hhV9T/TbkOJKTmVB7I+R83xG2k9xb+6iR4OjtGgsFTUI/NdK31ckAzBWoTKWmDDSpmUnqA8iGv38yPib8xMDFlJib0djYiadVv1fYdZ95i7sFsZtYYhbl3kWnvp/lVIViBdFQc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528628; c=relaxed/simple;
	bh=QNKlD7fPFoj/uyo9ThXb2ei2wcNIAH6fD2Z4QRFzEew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KsYXDjfoKeb6IoMKGe4SebUx6g6axxL2N7b5nhdAdtdOJNQxaDlqsxk9MU6Jak5ikm0P/iVSHdte3Ht/idpS1PEOUeEGe910oR/YID1mykcC8aEQ8e3U8apNhmdURbwfnZ+dxNlePu+dZ5bADaWDlY5067R+Fpch+QSERJH5e8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtROgWNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF452C4CEC3;
	Thu,  5 Sep 2024 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725528627;
	bh=QNKlD7fPFoj/uyo9ThXb2ei2wcNIAH6fD2Z4QRFzEew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HtROgWNIG9oUOfBtE/NqJdB8SlN/K4R2xr1M89aig+9OKCIHyPCdZ4QlxIwUtKVxt
	 fioE/d7w0Fw/JOxxK1b2Drw4EC2V+smESGHgxm3Fg1lAYaWG2JDesGWirPn836SCa+
	 eFuwvIz98Lx0oZ8vta95kSo1LyWTUvS6vwzhXvgr7dbNifWImvx2RwIUgi1h/mkdJ2
	 hbBVpY5Rg63H5Xctm/dc5L4suUcOwzCg6lITzKaiYp7FMZK1J+7sXYpCY5f/XT7pfv
	 S+toBV4gRLqqcFqmrA+rysshWV6XDrn51ZKs2D74r7A1oQp4OENr/3DbkdM4aLKdLN
	 +HmAHQa5bnJUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF2D3822D30;
	Thu,  5 Sep 2024 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,v4,1/1] net: stmmac: Batch set RX OWN flag and other flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172552862851.1327461.7737934782782986812.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 09:30:28 +0000
References: <20240831011114.2065912-1-ende.tan@starfivetech.com>
In-Reply-To: <20240831011114.2065912-1-ende.tan@starfivetech.com>
To: EnDe Tan <ende.tan@starfivetech.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, leyfoon.tan@starfivetech.com,
 minda.chen@starfivetech.com, endeneer@gmail.com, f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 31 Aug 2024 09:11:14 +0800 you wrote:
> From: Tan En De <ende.tan@starfivetech.com>
> 
> Minimize access to the RX descriptor by collecting all the flags in a
> local variable and then updating the descriptor at once.
> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/1] net: stmmac: Batch set RX OWN flag and other flags
    https://git.kernel.org/netdev/net-next/c/d2095989943b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



