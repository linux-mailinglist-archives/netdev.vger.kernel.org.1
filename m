Return-Path: <netdev+bounces-110978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2292F307
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7C81C21AF4
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF239B;
	Fri, 12 Jul 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WInaZxY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C54376
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744279; cv=none; b=p3YLVnVUbhxnllizIAWNZ3AIzkTMJ6uRvf3xjgWb/Vf9EYi/wph0014Bw7K0+CvrN/WmpvDkApsc5HOT/xBl0iiwxa/KCwb26spzAidWUHtC7ZdzMvLSOualIi8lh9oUlmKDuH4AdcUT+v5pKHh1It1r3ZXQwcJ0TxaefKzziMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744279; c=relaxed/simple;
	bh=/1VFLMdGeuioSPUcmNwsCoRTwA1pu7cpJ9LhGQcEfVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=adkzi7CTp8ee6y0Vi6D2FUiY8lBoONnW1Gr6XqCpSE8NCWSMOLrWAwcwf8h58dnsHEh/sHXVj63gAQ3Vk+j1zGFuBYkEv3R9DBr14PtMcmHYO7/qLSv9eWqYM/Rc9Snqea26oMbfzZQQPzsBMyskl5g13oae+QBa87BH7zyOqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WInaZxY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FEBFC116B1;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744278;
	bh=/1VFLMdGeuioSPUcmNwsCoRTwA1pu7cpJ9LhGQcEfVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WInaZxY82MpAg2C3c+EBmwPegVIg+FxBcIiSbPohoqO4pc++SMJfWvchCcuyuWgwK
	 u9Flsfcxg30+benz1HbhZcWpQVUSEbBnVMKMqHh9Hl4JYpnQtRRS9Z6lxwxhNdTuzy
	 8D/yvnRq20J1uEtA2FuXP6gg3ChwYUmv8qNt3LeGmAitfInZ2ZS45Q440yYs3hwd12
	 0Lf9rYRincwxzXhB7Mv0YnF9uEGEeS4uk9Mp+HWW5qqUjmCSlxuapxW5Dba8c3thrY
	 anBSE1EunvElkW3Zk16eexkN7ykqGvGw0w+MRksHPhADQpmMfisyKK1tsGoQYBk+OC
	 eIa1zIJz9rWPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C122C4332C;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: reduce rtnetlink_rcv_msg() stack usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074427850.19437.2338434288469713752.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 00:31:18 +0000
References: <20240710151653.3786604-1-edumazet@google.com>
In-Reply-To: <20240710151653.3786604-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 15:16:53 +0000 you wrote:
> IFLA_MAX is increasing slowly but surely.
> 
> Some compilers use more than 512 bytes of stack in rtnetlink_rcv_msg()
> because it calls rtnl_calcit() for RTM_GETLINK message.
> 
> Use noinline_for_stack attribute to not inline rtnl_calcit(),
> and directly use nla_for_each_attr_type() (Jakub suggestion)
> because we only care about IFLA_EXT_MASK at this stage.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: reduce rtnetlink_rcv_msg() stack usage
    https://git.kernel.org/netdev/net-next/c/cef4902b0fad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



