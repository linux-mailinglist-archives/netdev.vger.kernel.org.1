Return-Path: <netdev+bounces-197021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C1AD763C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A487AFFDD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061C2DECA5;
	Thu, 12 Jun 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjqPN+kn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9D29B8EA
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741621; cv=none; b=LqYpBwWOcOnyhR1mCU+U+ZvCm+jzaRqWWNUnEaOVMiqgtGKXqcoCaWpzXNOvi7cfTa7aDF0d6d6cwA6gisENMBBE91PI+j72MY+o8oNaK2DNWLpQOOvDhj5MXTpsB45FOsJAxaBkGfNxWzgd1Cvut7nFkzt3wQKpbEEllSrg+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741621; c=relaxed/simple;
	bh=vn3lQBxpov3jjjOtqnE5Bqxi2sq3/h8ksyKc7go9wiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLbk2zniMtNot0hmW371ZnH0oJdsfdZbk/1PaKHh328tB1DF1wEi2xizyhH6fpNTmg0+HT5mFObG6JmZpcnYeWiQP34gcjvKv2vI/rzJwQN5bgCULHmSPuwxAgT/w/DF2QoTkJgCizv0OrcTp0FIrz2/DA+5rHQ+uRQG+6E/Eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjqPN+kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D06BC4CEEB;
	Thu, 12 Jun 2025 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741621;
	bh=vn3lQBxpov3jjjOtqnE5Bqxi2sq3/h8ksyKc7go9wiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CjqPN+kni2Qaps7WYeaVI5YUhh3Db575D6RswvsINvO+vpNVezSPtrN53FGZpSAAF
	 rF/dTuzWehrU6HklwzSUBlZIEcEpkMn4sV5qaFxnlYfrmzso1YSfFriMlacKXe3hmS
	 IHGWNu2p3xAD20qDgOcwLC5jZM4HuinlyYff35E5iVhpAos+RhCbeTCn4cVFi53MEY
	 eoh6PlfRX5jKQsY7hn4q+lueYMiBRN5kPKevtuac1iZbJlzv2/3Mf+tnFdB8UO+eJL
	 /jSqjouyCpikbD5gQpOO/3jYIvdMklcFoIkDtSTF9MQp2na4+LVWGbhM5z2PnYaTZP
	 8DER70qyp2SOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3839EFFCF;
	Thu, 12 Jun 2025 15:20:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: drv: netdevsim: don't napi_complete() from
 netpoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974165099.4177214.7214118561387768587.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:20:50 +0000
References: <20250611174643.2769263-1-kuba@kernel.org>
In-Reply-To: <20250611174643.2769263-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 leitao@debian.org, dw@davidwei.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 10:46:43 -0700 you wrote:
> netdevsim supports netpoll. Make sure we don't call napi_complete()
> from it, since it may not be scheduled. Breno reports hitting a
> warning in napi_complete_done():
> 
> WARNING: CPU: 14 PID: 104 at net/core/dev.c:6592 napi_complete_done+0x2cc/0x560
>   __napi_poll+0x2d8/0x3a0
>   handle_softirqs+0x1fe/0x710
> 
> [...]

Here is the summary with links:
  - [net] net: drv: netdevsim: don't napi_complete() from netpoll
    https://git.kernel.org/netdev/net/c/1264971017b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



