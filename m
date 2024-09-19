Return-Path: <netdev+bounces-128963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4AE97CA17
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EC41C21E04
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9019519DF69;
	Thu, 19 Sep 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWEoJ4nY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E519D09A;
	Thu, 19 Sep 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752032; cv=none; b=QA6F7Lu8BL39D5R58AXy/cZVB58Gn1L+vcPtNPkCPfaE0b68FWTt98MWtIeRvGvuGg2WFhZXd5HcMyPmJgnmWLzQ8kYqkG4qt6YlSqxB4Z+nnfVc6YJaXEzE5UMsl/gIAAbziQWOzBlZsfX9JccHzho/Oyeol5R5+PNDeJyw+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752032; c=relaxed/simple;
	bh=Vtkkwu/6xApSWPYaXd+PwSNb2uRW3tETscvtIXQ7+TM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UFmlAhS+sxC7qcsBjb46eFw7DNm1s24t83lERJKojg9Pjo5cUdWOvtxjeycqAJWQQz4xqvYMTfNPB6AuP8fMtGt3AZ57fFPMOcz+jYFM/j71WMMJFqXXxcqk79SgfrXcsQUWe9HoMyVxpvn+ytqKqb85NI2dCFzwJsv6uVmAuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWEoJ4nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBB4C4CED4;
	Thu, 19 Sep 2024 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726752031;
	bh=Vtkkwu/6xApSWPYaXd+PwSNb2uRW3tETscvtIXQ7+TM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IWEoJ4nYK7ulCROShROgrcMBIEPv60XPvjCel9sa/O2VuUfFNoU6AKhmZVrGqeaFe
	 lVGPs7eBa7Efvn/naJJzfXhC4ZWFBB5ty2tFDsmIOI5VIprarY+Ro4pImRSQ+i09Zl
	 G3JNvNo7tDpjqG3RrsKN7R6KIFL/xrMRyWYGT1kMYv1ykMjSx09zCuMjzoJsKCe47t
	 1dngR9sGrY2Lp+MfW6qv6MUVF1cn8nN7hGRt/z4iCo3F4nSsq+XaqqAmzllSw7zSas
	 5gAQFA8Noy/D3MkrU3zWNbAfZh9qfMXzcFqfefGfKMoJBkxofNwemK9q5sHbseXzjD
	 NcfjAlAf6gKBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9173809A80;
	Thu, 19 Sep 2024 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: seeq: Fix use after free vulnerability in ether3
 Driver Due to Race Condition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172675203357.1546508.17110855118202359127.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 13:20:33 +0000
References: <20240915144045.451-1-kxwang23@m.fudan.edu.cn>
In-Reply-To: <20240915144045.451-1-kxwang23@m.fudan.edu.cn>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: davem@davemloft.net, wtdeng24@m.fudan.edu.cn, 21210240012@m.fudan.edu.cn,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, przemyslaw.kitszel@intel.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 15 Sep 2024 22:40:46 +0800 you wrote:
> In the ether3_probe function, a timer is initialized with a callback
> function ether3_ledoff, bound to &prev(dev)->timer. Once the timer is
> started, there is a risk of a race condition if the module or device
> is removed, triggering the ether3_remove function to perform cleanup.
> The sequence of operations that may lead to a UAF bug is as follows:
> 
> CPU0                                    CPU1
> 
> [...]

Here is the summary with links:
  - [net,v2] net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
    https://git.kernel.org/netdev/net/c/b5109b60ee4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



