Return-Path: <netdev+bounces-212109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33ECB1DFD3
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 01:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB20189F75D
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 23:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D420126A;
	Thu,  7 Aug 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMh74DDK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049EB2EAE5
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754610529; cv=none; b=K0i2RltSNreTBK4ST9N8o41U4hiAfVa5qETraHwfUx81Kk28eyyfLnl0BTE4UpxeQSZNCQS7qmEDQJOgB1FxP3/gPeBuRWYT5GhXD3L8EdxiW7jtxHNNAQL5+sdkJGkfkkeGkwdt99ffsUwcWd96ID0W+ZQw9BcCFVb9pBR2L/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754610529; c=relaxed/simple;
	bh=UbdMlawSEb+QASl+7DHdn06GeX2jC9mNnnhWX5ZzAtQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=duxyAfdO6uvVAYfkqQtltVRRPJL3e02t35BnI/A2IEN9u41b45wgQgtfKAdj3rndgMykaKVWoHS1JpZN1oDSsy/325BwdvwvXNAAOaT7UxaBMXM0WU5BJ7tmu7QMyYpWYdmyybYmMH+7KetbcrRh7fmV/uuG3b37E1ICT/uyREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMh74DDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838CBC4CEEB;
	Thu,  7 Aug 2025 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754610528;
	bh=UbdMlawSEb+QASl+7DHdn06GeX2jC9mNnnhWX5ZzAtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EMh74DDK5JOVM2FY/4NM54Tv8cRJRnyVsou+i0nibrf+HiGjTLRx/jWsAXOPAXPpJ
	 n0iXy0xlwyobF2h5goziIqFeNM0o88vb61MKtd7ZTbjXbTtLlCWYe5YhxtZbyXvE/W
	 1SBauBi1RHjuZdfMSueD5clTus18l8decuKHAP0SVeMHE7BXQPMaOBGOOEeaObosRF
	 93gzdEZs+nPMJKSuF3yukW1+AD9qkMTt0vgkHMRGxLDDMXMrIhAlabdxf39Sib3zMP
	 JpPJU4R695H+bOsPTRam8S/PN5JuGLIz2J2OYR7TrHSV/XfsGh69fpK8nEfXkm6W0T
	 N0k3BZYWqlp5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B00383BF4E;
	Thu,  7 Aug 2025 23:49:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] netlink: fix print_string when the value is NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175461054201.3719041.4355345326392065104.git-patchwork-notify@kernel.org>
Date: Thu, 07 Aug 2025 23:49:02 +0000
References: <aILUS-BlVm5tubAF@maurice.local>
In-Reply-To: <aILUS-BlVm5tubAF@maurice.local>
To: Michel Lind <michel@michel-slm.name>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Thu, 24 Jul 2025 19:48:11 -0500 you wrote:
> The previous fix in commit b70c92866102 ("netlink: fix missing headers
> in text output") handles the case when value is NULL by still using
> `fprintf` but passing no value.
> 
> This fails if `-Werror=format-security` is passed to gcc, as is the
> default in distros like Fedora.
> 
> [...]

Here is the summary with links:
  - [ethtool] netlink: fix print_string when the value is NULL
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=41d6105250c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



