Return-Path: <netdev+bounces-142710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024279C0102
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCCC283943
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FBB1DFE37;
	Thu,  7 Nov 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzZ/lzqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5B1DFE09;
	Thu,  7 Nov 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971220; cv=none; b=b6FfTka3JgXzi+A7uMw3yGqRHj0U+1cmvm/S61gIvOjrK7+W8x+WXsPgXAhHOn9NCs/aeunay7xmslk3xImeE+c3aTwxOLMhdl7SP6VP1sXaIrWmSI1PYqzX9LUCEdH6aOhqohEDCNcMRLLdjgG8fQsXsR+2HfGWm2Rnqjvcdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971220; c=relaxed/simple;
	bh=MzAtMnBa36cvwhj9J6ISxKGN8qWAOmIs4UqZoAWc1x8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CSRJuRVCjpQzH871umPrvvntX7rF0gwpKdMyUP2Wnwhj92Q8S0sk2ybioN4WiF+0CAczYUwZzWim2srLNKplSbITXgakEtC3POmh+QVcE7HF2NY2s3sZNFuV5Kc4o3tEvHsDpiw6qBng2aEf4rOQGmXSBmUKhH1p+8aBLwnXd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzZ/lzqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A5EC4CECC;
	Thu,  7 Nov 2024 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730971219;
	bh=MzAtMnBa36cvwhj9J6ISxKGN8qWAOmIs4UqZoAWc1x8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzZ/lzqqzJaLDXBN1l74ys9/c85Yaqeq3wvmQOwXthEaMxW+9whlB0DxNEKfhS2fx
	 Vq5nIVqJvNG7wFBdfgljy4080TwcTq9XYX64WLEjrTDhB8vLb81A05E/KD/KyKjYA9
	 Gox8Ev5qFK10ejsUSEHp3Wh7yQ8pKaCDzCIP+vC+wU2yI94zyDnkOzf7JWV9utuV8a
	 XxtMQgat1ye6FLYP15oXodBdo8X4OoSx3bBHxXTTkUVgDxkuY5A5i/7BcScgSjfoiI
	 kdVCjfqM/Y305cuisfX0+snkjIdg0VqzT7nKpwBLJcbsZBwDpKFsOtYMG4AjJaE69o
	 rK41u5M2ZWQfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34EE13809A80;
	Thu,  7 Nov 2024 09:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: Fix unbalanced IRQ wake disable warning on
 single irq case
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173097122904.1579640.5010342385326557978.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 09:20:29 +0000
References: <20241101-stmmac-unbalanced-wake-single-fix-v1-1-5952524c97f0@collabora.com>
In-Reply-To: <20241101-stmmac-unbalanced-wake-single-fix-v1-1-5952524c97f0@collabora.com>
To: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_=3Cnfraprado=40collabora=2Ecom?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, horms@kernel.org, maqianga@uniontech.com,
 kernel@collabora.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 angelogioacchino.delregno@collabora.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 01 Nov 2024 17:17:29 -0400 you wrote:
> Commit a23aa0404218 ("net: stmmac: ethtool: Fixed calltrace caused by
> unbalanced disable_irq_wake calls") introduced checks to prevent
> unbalanced enable and disable IRQ wake calls. However it only
> initialized the auxiliary variable on one of the paths,
> stmmac_request_irq_multi_msi(), missing the other,
> stmmac_request_irq_single().
> 
> [...]

Here is the summary with links:
  - net: stmmac: Fix unbalanced IRQ wake disable warning on single irq case
    https://git.kernel.org/netdev/net/c/25d70702142a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



