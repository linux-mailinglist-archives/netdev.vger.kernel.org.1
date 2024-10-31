Return-Path: <netdev+bounces-140594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0CC9B71F8
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6BD1C24006
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3812D20D;
	Thu, 31 Oct 2024 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0GqxaZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A612CD89;
	Thu, 31 Oct 2024 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338246; cv=none; b=pzZqT0MipW+yhOlMicvnA4oBtPitRvqvkpEx1oUtbNZXdpnKVWbjVHHOD4caZc8UBvoZ/S3QOd8W6h/de+X+Ol+43ECSE1h7c42H1QY2cmEo8QFPgas01Bhc36DEpiKuWDWjolgZlQ8CT9Ew4odfIm+su6TM8Om3MoAi7Mi8Xwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338246; c=relaxed/simple;
	bh=Y+lcThPBWVjCPTYYlmOezurYzskGCGSZ+hugRIeTewQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SiMTimILUyzsJ1Lq/Y9D156htofoTa+dJHsUHs/IH6xfk9nDe/bP7n1sFFNtMwO5BDCIAiLci8gpe14887gfWhWOFml1qCOm/Dfo58VUqJqt8zTfwslfIEUm8zPszZL/nt7jecB19QjpMQf18LqTkRa4gwNlU+Gq3gWP248k5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0GqxaZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D64DC4CED6;
	Thu, 31 Oct 2024 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730338245;
	bh=Y+lcThPBWVjCPTYYlmOezurYzskGCGSZ+hugRIeTewQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h0GqxaZK43sLetCv71O6lVTichkGB1j8LDoJZ9TbktWv6y0nNnK67JAjX0eklCMqj
	 w00onVQVif/dpI60833yHnfTwXLGe7cphEkPbCdjDixXToYoCz9ZQJ9yP1T5GLqGcG
	 uM5gMUZo5bjYGRgwNlx0RfVgK1HaKzan69W5kfIslsmP50jyZG4XX3vsW7W2X0eV6z
	 i/lnPzK3sBKEkUc9FFyDizdXG+9t12RDFQTfK1bffGe8CLPm16N4ssziI/ovIv5u+9
	 iiotBJZlrBBXqMEqeFQvppZar6xNpJ+GmU636BO6QEacl5Id8qojbmmWT0fbLsgFkS
	 Uom+VR/eD0FYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB0380AC22;
	Thu, 31 Oct 2024 01:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rtnetlink: Fix an error handling path in rtnl_newlink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033825326.1516656.63148059324643801.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 01:30:53 +0000
References: <eca90eeb4d9e9a0545772b68aeaab883d9fe2279.1729952228.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <eca90eeb4d9e9a0545772b68aeaab883d9fe2279.1729952228.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Oct 2024 16:17:44 +0200 you wrote:
> When some code has been moved in the commit in Fixes, some "return err;"
> have correctly been changed in goto <some_where_in_the_error_handling_path>
> but this one was missed.
> 
> Should "ops->maxtype > RTNL_MAX_TYPE" happen, then some resources would
> leak.
> 
> [...]

Here is the summary with links:
  - rtnetlink: Fix an error handling path in rtnl_newlink()
    https://git.kernel.org/netdev/net-next/c/bd03e7627c37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



