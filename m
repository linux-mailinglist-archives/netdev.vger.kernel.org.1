Return-Path: <netdev+bounces-227246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE492BAADD3
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B817A5DBE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211D1F4C8E;
	Tue, 30 Sep 2025 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW2BbTzZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A11F4180;
	Tue, 30 Sep 2025 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195259; cv=none; b=BqaZO8FlID4WpS9dl+EkNRTto52bPh1apuheMxr2tNYUjUy/zACZm4iJMcxTz2I1s0HwKu5mxlD/TrWM/l+M3zIehZC4yXvLPgt82LG6xUaSJ+4Lc0aYFWNKsCdKsH/V1Ug9XlTZGQlTM+5WgYE5O0WJNMx5HVnd38N5LwWPRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195259; c=relaxed/simple;
	bh=UI9+barV9dJbApEDL0dK6wx3v43T2HrBpod0wuZbNHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6FMxOBNk+38gVkXZBLmiJT3b9gp92/blywOJxUfG7sqlsHMpQs6SB+fB1QW8cdxPb0t9NOyESssjxEy0VoLdE2WqvXKHAyt6LyZX7Ug7F85PMRBOguPdjmapUrX52ooUa+FguE0tXd/SbnEgE+8eFD+163WS4YzQUebsif+lTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW2BbTzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1398BC4CEF4;
	Tue, 30 Sep 2025 01:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195259;
	bh=UI9+barV9dJbApEDL0dK6wx3v43T2HrBpod0wuZbNHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BW2BbTzZcrph+B0Kcx6Kyu27mGLDzwiCRk1z8MfHUpRknO0yya8HrvTP+sIT+Ht9/
	 28RsNiCax4bF9X2SD4zagEFp58sllZ0joIybsNZW0JfZNM4CxYA1OPc/OL3WJBDl7L
	 kcWZFUZUgmulCs+VbZebIfI+A3eIiIMs6lnVKA11Dy6ABssrd4lOIgx/HRlNrcC1UM
	 zGmQQ75v7QC4bh7P6AaKdwIU0uNlTy2S05RiBP2xUo/YlQAEwcp63XFrEJqlJknvEP
	 T8K9NpimvAW8Yp3ImD2CWuuBIIdek1wpvWJsgazAxDmv1PUccfPrpf/ZO5flYpzBS8
	 kmLLHI+2tdBqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0439D0C1A;
	Tue, 30 Sep 2025 01:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptr_ring: __ptr_ring_zero_tail micro
 optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919525224.1775912.18026544343281265585.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:52 +0000
References: 
 <bcd630c7edc628e20d4f8e037341f26c90ab4365.1758976026.git.mst@redhat.com>
In-Reply-To: 
 <bcd630c7edc628e20d4f8e037341f26c90ab4365.1758976026.git.mst@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 08:29:35 -0400 you wrote:
> __ptr_ring_zero_tail currently does the - 1 operation twice:
> - during initialization of head
> - at each loop iteration
> 
> Let's just do it in one place, all we need to do
> is adjust the loop condition. this is better:
> - a slightly clearer logic with less duplication
> - uses prefix -- we don't need to save the old value
> - one less - 1 operation - for example, when ring is empty
>   we now don't do - 1 at all, existing code does it once
> 
> [...]

Here is the summary with links:
  - [net-next] ptr_ring: __ptr_ring_zero_tail micro optimization
    https://git.kernel.org/netdev/net-next/c/c39d6d4d9333

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



