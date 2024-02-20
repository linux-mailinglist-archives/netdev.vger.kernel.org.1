Return-Path: <netdev+bounces-73229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC385B7E5
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5952853E1
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5FB60DF7;
	Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBT06w3j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E7679E2
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422028; cv=none; b=XtyJDQUmh9Rjh6KyNuFA+BT9NGCM6fWsLhKcV79CovwRYbCzieBimWzP94KlsGklw/h7J6WndK2Zvnc89G7XTuCH4MxqYwOG0LOGR0rWSLiG9+4cjrd51IHDAi8UzBgaYPmnejKT7w48fPheA4RfRZuzPyfosjirHptN1a+YuHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422028; c=relaxed/simple;
	bh=JJgnMQNO8Yo7ELg8BrmH6bVSIANoIw10j09+rg7j/5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQ1N6SsD6TJQF6M146bfSsvr4Xohv9Z+ay+2sXGueThfN0k7BoroP/BqIac9/QK9YGr0u0DDfU4ANANV+L07b0ttUTjqN7IpZ+RjLzKhr4Et9NQHXD5UTKzC4DZVgxcCzGpoW5e98aq5bMCQthEU37fxF4WEL4Rq3Lj8ysmPb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBT06w3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BCFBC43399;
	Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422028;
	bh=JJgnMQNO8Yo7ELg8BrmH6bVSIANoIw10j09+rg7j/5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pBT06w3jM8KfwswMKEKicUCCg4YJxq4/2rVcBwzbEH2LkLICmMeYODpnUdVXoTtSw
	 Bcb3zUMYcoL1NaV8/4Bb8VBLzQo04iFhxFak+r+Rbk5maMt3sJyO9DeakFyabhsWLf
	 AXKiufZeU3tx8i4E7gNVI4y5v2nzt3scjilj1BbBOdeRiZSn++vJQTLVk+YynxB3Li
	 IanttXp/3WpDAMEXqUSmejlLt05scRT7Now++FHZS8YM/utp+yvTIIP+4BUDIi3Z+n
	 +67eu4aioJ217Sj4vl9nsMhu9olIhCDOzB8CpwmCuP0MNHGfyMCOJ6RW69VwpDT7j6
	 7zJwuYUShz3wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C929D990D9;
	Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] devlink: fix possible use-after-free and memory leaks in
 devlink_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170842202804.17965.1863101467473980923.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 09:40:28 +0000
References: <20240215203400.29976-1-kovalev@altlinux.org>
In-Reply-To: <20240215203400.29976-1-kovalev@altlinux.org>
To: None <kovalev@altlinux.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 Feb 2024 23:34:00 +0300 you wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> The pernet operations structure for the subsystem must be registered
> before registering the generic netlink family.
> 
> Make an unregister in case of unsuccessful registration.
> 
> [...]

Here is the summary with links:
  - devlink: fix possible use-after-free and memory leaks in devlink_init()
    https://git.kernel.org/netdev/net/c/def689fc26b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



