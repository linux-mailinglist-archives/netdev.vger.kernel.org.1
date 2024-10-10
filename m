Return-Path: <netdev+bounces-134344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDF998DEB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91117282B4E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EEA194082;
	Thu, 10 Oct 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTLfwWq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A338F9C
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579628; cv=none; b=tonytg/e4wpKnaVN+OGrNQPXMwiJI9krgey34z83Y5uzy2fkmko8iKpvCaEq55tMIvb05C/WYUmfkD+txfBW+2DAOP1Cs+me7//8YvW5PX99CYkQAST5zfjEDROi98Ekr5mMbVPRCEMlmMHBk0s2BK83lFDc2ezT67vGREuWnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579628; c=relaxed/simple;
	bh=ooPHrBjcM8dXcybHVr/49cW3P33nFi1bG3RYIMaWJI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LEN8RjyJ4wlkzFvZXmAcpdBlRu7f4K82MbxvOEHW+2hCYDdG5Hq8qEibsmCOqo+a6hXgeRCoYHuk6dFQrwaH20oDlzrbLCPG05yTHpbEn5TkdBI0YeF7naAPDUEJ3jtw477HLDOq6024i48kk7Eo8FdydlrESq2Sya4idEs0Oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTLfwWq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C48CC4CEC5;
	Thu, 10 Oct 2024 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728579626;
	bh=ooPHrBjcM8dXcybHVr/49cW3P33nFi1bG3RYIMaWJI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iTLfwWq1G0mivEadbuXdA4bvUdDNJZck70MpgZD0HCa3k9a8+uLRm7zLTBF8kOMoV
	 8U0BKL81+GYhILndNAyma2jgvtEXgZ/mA0bhH+XizSWrcUakGdA71nxMi5yj3bnMvd
	 mQ03FxKYltDbC195dzyr6MnUNVcck/jRq+Oc9/jLEEXvirFx/fEfDqMtZsEMuqNl0b
	 MI7T+jgZnc843JQe7iPpUuwwLU1FJVF0ndbLUpMeGGjgOrzf2Y4TzboEnezs0IKJkU
	 HKzLeEmsIuCrkEBcdEvqV1GHDWfcteQD/wJuuZJaR5SwTLbJ2tOQT8s9i8mjienyQR
	 L9HzxGIdai9Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD73803263;
	Thu, 10 Oct 2024 17:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ip/ipmroute: use preferred_family to get prefix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857963050.2096226.739914601076298955.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 17:00:30 +0000
References: <20241009095309.17167-1-liuhangbin@gmail.com>
In-Reply-To: <20241009095309.17167-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org,
 jishi@redhat.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  9 Oct 2024 09:53:09 +0000 you wrote:
> The mroute family is reset to RTNL_FAMILY_IPMR or RTNL_FAMILY_IP6MR when
> retrieving the multicast routing cache. However, the get_prefix() and
> subsequently __get_addr_1() cannot identify these families. Using
> preferred_family to obtain the prefix can resolve this issue.
> 
> Fixes: 98ce99273f24 ("mroute: fix up family handling")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [iproute2] ip/ipmroute: use preferred_family to get prefix
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f305296e40c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



