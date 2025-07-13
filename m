Return-Path: <netdev+bounces-206397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0387B02E4D
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FA6482F93
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24CE573;
	Sun, 13 Jul 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2Khdi24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAF2594;
	Sun, 13 Jul 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752367187; cv=none; b=SFzIZMzuVw2a4cVc+ZjQteLrOP3UZMuEJW27nXblTwWmY4L4PEqS8ucjWZ0exI757ivM2J39Vv075/yq4frQwdJt7JZ02G9BdqEk5DEtHFVRuyJS5kHC8WSSdh9RoWzU4GSr3b9/Qpo/bTe0tLVgxTcBo3ZmGtu2X2FIlk3gBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752367187; c=relaxed/simple;
	bh=FUALmYwbC2vHNgtMO6s9lDgqYQVe4hgXJClPdvSjrvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utJZ5U89xWfnczoYMAOb3cxwOUh2xvjzNQIWs2YyuAYruahxMqzlEhYMic5RW0PTucTZqtWLG9luhdLOkunYPfdwFfaRPLFmr0PggoMMW3fOpdu83CYle0wuaihxdlC0qHqqZfd/Esp9R4bgynedlGJVRFEPYzkR/UhtmaAJums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2Khdi24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F47C4CEEF;
	Sun, 13 Jul 2025 00:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752367187;
	bh=FUALmYwbC2vHNgtMO6s9lDgqYQVe4hgXJClPdvSjrvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C2Khdi24Os0JJFhIxR+i+oQpS5E7fkIXxWyJFL7crVJ+buM6xtxDu4zh46gC6uQcw
	 0CBViw2g2WdKxwii25yHvtq3w7b79FAjbaTiFoveng7TAQtpg46cn2h4wRaHFanSzt
	 TDKcDbwm7dl4chYexw6lXd9mGZO8OY7xETWL2+b6UOFRrzxqRDr2zNyaY1GCQ48x/f
	 EXIDV/Tg4VY/vfwJup0l0h5dMsywtBNqNN7i+A9/xLDMxATNzSfBOCzWcpmSl6m06p
	 f7OS+U888eORkfFzyn0Ixmo8gfjh4BPz4vire4hExvJ3BvrAFpksHs878x35NIPhCZ
	 RI66CeAzPdx0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCEB383B276;
	Sun, 13 Jul 2025 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] fix two issues and optimize code on tpacket_snd()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175236720841.2674210.17766353481530263722.git-patchwork-notify@kernel.org>
Date: Sun, 13 Jul 2025 00:40:08 +0000
References: <20250711093300.9537-1-luyun_611@163.com>
In-Reply-To: <20250711093300.9537-1-luyun_611@163.com>
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Jul 2025 17:32:58 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> This series fix two issues and optimize the code on tpacket_snd():
> 1, fix the SO_SNDTIMEO constraint not effective due to the changes in
> commit 581073f626e3;
> 2, fix a soft lockup issue on a specific edge case, and also optimize
> the loop logic to be clearer and more obvious;
> 
> [...]

Here is the summary with links:
  - [v5,1/2] af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
    https://git.kernel.org/netdev/net/c/c1ba3c0cbdb5
  - [v5,2/2] af_packet: fix soft lockup issue caused by tpacket_snd()
    https://git.kernel.org/netdev/net/c/55f0bfc03705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



