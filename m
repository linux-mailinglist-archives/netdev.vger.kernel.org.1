Return-Path: <netdev+bounces-166579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4726A367CA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2950E3B2090
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C491DC9AA;
	Fri, 14 Feb 2025 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdOhJbgS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00261DB92A;
	Fri, 14 Feb 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569817; cv=none; b=ZWRWQT7UPH56AIc6JkSjFHmvo/7w+J2QrdQErk4ybculYjjQOedlyo8/iKFTSSb2qxprdKO4w12/yibbgU0h7eMbHvaBscTVXMHjuautfUDZG+psUykKKVs0I0YoiMD/P45Va/xwjrOmHtYpdgFrOjy3OniRkkmPAlr71bWZQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569817; c=relaxed/simple;
	bh=Kckz2TLbEWVxhN4tyZx07MCeYrJg4RMfeph7RfTIB/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c7saKthS47CyjT2HnKtnuqhsL0JFutyOGvaCFIST8EhpcMITl4gjXDe1JxEV2UjNb+FlLCmIKR68Lb8dGwEoj/VI1CXNWK9CC/WKzWWpIv+ZWfSJHfLp6LNT9W6CE0+sap+pbXlScStPap5b1DWzRf9nts9h3Hc/F7AotC2DPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdOhJbgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408DCC4CED1;
	Fri, 14 Feb 2025 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739569816;
	bh=Kckz2TLbEWVxhN4tyZx07MCeYrJg4RMfeph7RfTIB/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cdOhJbgSdmNsof0RZWm2bNMcOgyMnbZt+W0tplE2Z42FRnhYN2MMjC/HZid4gAJnv
	 cXzgJPNOG1t4PpQILLyjXxjR2iCMHRuT8dtOszNUaK1l7M+y1R5CXFcEWykXJVOqoq
	 0oEZho2DelTmmNg7d7bolAS6148mq2/iyWr1V/ZAMtTvRYwBTFjA5j7AtiohUvk9SB
	 JZhIv/eEYDTmSx7F9ZN8t38fGLyp2TjWZH+9fUVfjtyhwhBd9NrePCBudywVlg3KIy
	 AWtEGEuJ2oo5x6guLSRmHSYSf331YWc5PdMca/CEcK/KScLXsHz1uuOA/biVVuPInb
	 DirROEdI0JIfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB383380CEE8;
	Fri, 14 Feb 2025 21:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: refactor clock management in EQoS
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173956984555.2115208.11664802737268824641.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 21:50:45 +0000
References: <20250213041559.106111-1-swathi.ks@samsung.com>
In-Reply-To: <20250213041559.106111-1-swathi.ks@samsung.com>
To: Swathi K S <swathi.ks@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 fancer.lancer@gmail.com, krzk@kernel.org, Joao.Pinto@synopsys.com,
 treding@nvidia.com, ajayg@nvidia.com, Jisheng.Zhang@synaptics.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 09:45:59 +0530 you wrote:
> Refactor clock management in EQoS driver for code reuse and to avoid
> redundancy. This way, only minimal changes are required when a new platform
> is added.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: refactor clock management in EQoS driver
    https://git.kernel.org/netdev/net-next/c/a045e40645df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



