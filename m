Return-Path: <netdev+bounces-129502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885D984296
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63481F21944
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D814BF9B;
	Tue, 24 Sep 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckcSzzab"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8F335A5;
	Tue, 24 Sep 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171426; cv=none; b=lVj8UrMlR/HUtuZzaNj++xSHd01UMGa9AuYoZs49cdHxVU/4TakbqOwM4LeCXDtWbAE2MS+iMSk/B7pFXBDSxA46p+31i0UK384enpwB5vf7iRhMTxETwdemMItJcgZZrURuF4CGNOHZEVVV/CeMd+stibG0WxRSKGBs7GqA9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171426; c=relaxed/simple;
	bh=BurBzI8ngKah39LvdFErebusrYUIIpd4vTRNgU0ne18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UiQhgNOSeu/3bSIM5X/ynmm4oN1b/p+KVYecdJHZtLUw6nF815msw/Nm1oPG+E/y/n2bcxtVLzPJSZuhmqaJ7boyVvExEboEzPH9oidTRaiT2qyiGAoyDF2lEyY0Xvv4J0aBcD3gAhW/fMt8Igcm845RPvE/zgtJfMLCmS45haE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckcSzzab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E62CC4CEC4;
	Tue, 24 Sep 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727171425;
	bh=BurBzI8ngKah39LvdFErebusrYUIIpd4vTRNgU0ne18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ckcSzzabzQRvieGmBOhpLCQHIKlOLNnNCe/Wv/ASZKQ43J9WkjJM1qe55/8img+Kz
	 xHg/VsXpn+QkGkHTeN/9qUFrA+p54ADKDutClX5MWiR36zVNrlCP7hwHkVpZtosRbx
	 cfCjymuiHTfIdaBMewt1uYyfnFObls5HqB2qUR3kzf7nBfPqI2hicNXSlZ3tpaGH3h
	 r4Y/M9yBTSjCv2vpC6/OpgA9hcJ1VRdovnPBxoA/BwP/uTrzbacl0ziar3k/Apb1HS
	 Fzspy0pZDgCrmRkqeAZKv+NXDAd9uFsSkFaqnTtjRC+TIYykVdLRD2fY6/nApOpjtl
	 24s0Z83qSprWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAB3806655;
	Tue, 24 Sep 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: stmmac: Fix zero-division error when
 disabling tc cbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172717142776.3968801.9111597655574522093.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 09:50:27 +0000
References: <20240918061422.1589662-1-khai.wen.tan@linux.intel.com>
In-Reply-To: <20240918061422.1589662-1-khai.wen.tan@linux.intel.com>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xiaolei.wang@windriver.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yong.liang.choong@linux.intel.com, khai.wen.tan@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Sep 2024 14:14:22 +0800 you wrote:
> The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
> when offload is disabled") allows the "port_transmit_rate_kbps" to be
> set to a value of 0, which is then passed to the "div_s64" function when
> tc-cbs is disabled. This leads to a zero-division error.
> 
> When tc-cbs is disabled, the idleslope, sendslope, and credit values the
> credit values are not required to be configured. Therefore, adding a return
> statement after setting the txQ mode to DCB when tc-cbs is disabled would
> prevent a zero-division error.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: stmmac: Fix zero-division error when disabling tc cbs
    https://git.kernel.org/netdev/net/c/675faf5a14c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



