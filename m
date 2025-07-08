Return-Path: <netdev+bounces-205030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7676AAFCE97
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D465421C6C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB52DEA78;
	Tue,  8 Jul 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9CBw1Ey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876114883F;
	Tue,  8 Jul 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987387; cv=none; b=I7tW8Z7iHbYrnRnfl/uwvegGe5xN/CPvpMB7Mv7sgC+zWQ3O7XmN7YUQW2RBg1oZK7YhIWBWIG7W3l8YgWzBVZkNQQWQWK0ck1MbdpJvgbfrrLI5FytQ+lUnhnaSHTJJb/NSipqRcqueUiD4jHsO+bE0jY1i6Tfea7TJ1nN6k6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987387; c=relaxed/simple;
	bh=7iAG9b47HjAbUmZonxDUG+A93PzhEo22h9CDJpaBB2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DBh7nLLSePh1JuDpgR6w6QOI68VDkqPlXd3ptJCCG1jRrgsB6ZXXSbq/Vwu8UuC0Ge55AV8HX0wiik5NfqCCtQdfZRj8rWhnORII5bb/9e8YutBoqviraxB359czwxesSE+FqYn2xKTwN9qCnJ6Ny61ZrCKSg1QjvIfQSSKmu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9CBw1Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315D2C4CEF7;
	Tue,  8 Jul 2025 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751987387;
	bh=7iAG9b47HjAbUmZonxDUG+A93PzhEo22h9CDJpaBB2I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k9CBw1EyWaTg85sJLPrOrDHGorYV9ojGW2JQDAEDJ10Qgu+A0oLXx23JPnXUjEh+Z
	 6sO5frPjkFU94J+dW7l/a8JswaCpH09P4DsvfSkPP1oyldKhXN8x7Vu5zD2p860Fov
	 6VNtlOUwrRPFphKBbXnrjO3YBUrTEzPcLnlkeniRmAGj/I0cwfjZfiAtzmrU/5MN7d
	 zH8tEoFbd+/+eqr8YHxqzURNUjSwssczmatPwaPaGcHYxwDN2mrhZMI2SlsPlchHqv
	 68v2oc4xmWAtSRj8uHxrcb7APk78Q2iAyq2Hj4mHzAYxmG0BvFHBFMUXa1etksBGOu
	 1FpClfb/26yug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340D838111DD;
	Tue,  8 Jul 2025 15:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tcp: Correct signedness in skb remaining spac
 calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198741001.4099273.99951051587276414.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:10:10 +0000
References: <20250704005252.21744-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250704005252.21744-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com,
 syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com, edumazet@google.com,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dhowells@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Jul 2025 08:52:52 +0800 you wrote:
> Syzkaller reported a bug [1] where sk->sk_forward_alloc can overflow.
> 
> When we send data, if an skb exists at the tail of the write queue, the
> kernel will attempt to append the new data to that skb. However, the code
> that checks for available space in the skb is flawed:
> '''
> copy = size_goal - skb->len
> '''
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tcp: Correct signedness in skb remaining spac calculation
    https://git.kernel.org/netdev/net/c/d3a5f2871adc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



