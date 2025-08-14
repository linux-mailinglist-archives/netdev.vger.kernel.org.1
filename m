Return-Path: <netdev+bounces-213522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E76B2580C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08E32A6FF0
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FF10FD;
	Thu, 14 Aug 2025 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF/lcqMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7151EEE6;
	Thu, 14 Aug 2025 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130195; cv=none; b=qU+w+t3BVFDRkXqOkGke0mzIzVph0ltF5yfHiRYCvTvD255HxHqXQw6GUUvtbCANo1iRzwkAum4qQXGydyvVVeRmWbeWxyJVcob5ZvkEqUVN/uusDME3JNG3BfSITAnW3DtKIFTrB7v3r/twDms6FqmmWnm2HY8eEatW/KWrbZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130195; c=relaxed/simple;
	bh=DW4CsdevOiR6rhiPYnrtcOlpAXU4lp/cbwii1TzRmtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ejjp759lp2eznrnKXfdmVHfQZL05/CQZbS6blDMCYxxc/5mvKN/vZ/jjUlyQoBnoD8arkcRYA9iu3xP2jMfBgSymOE01jsybsD9wa581MOKcY3xHLCuaWKCQBuvVGxlZt4agaRYvgY5667vJO5rU2pGA3uAP1fc3RmiFxye1/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF/lcqMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F538C4CEEB;
	Thu, 14 Aug 2025 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755130194;
	bh=DW4CsdevOiR6rhiPYnrtcOlpAXU4lp/cbwii1TzRmtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pF/lcqMwRx8Fx96VnYxhhb0k/vgUHgCSqSvx+qQYfwexKjx/rMy2GrSEJQCxnOmdV
	 rfLL3+TYyY/R3Q2iSaRfq8MQK6W5zHONWAlia1p63CuTFKFqoZdkG3IkYbUNfT2wxU
	 yh9hfpD+UGxTFlaZBRW0EF7sQX/TnJKRYebGsU7vKgRMAyhPMtNnQpELF3UI2bHxdT
	 1E85Buk6djb3a6qya2er3oeceAqfth7pv5S6MCaiDpAsGWkUosNsoVJYc/gSX1IsCV
	 qNZaPA95wCpIg2m1TNuuE/spxoELWvu0NTzktRzOBhD0rROb9/aagehN4L2aXpF2gS
	 9EO2A6V0u54rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F4C39D0C37;
	Thu, 14 Aug 2025 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock: use sizeof(struct sockaddr_storage)
 instead
 of magic value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513020601.3825277.1947080522866981155.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:10:06 +0000
References: <20250812015929.1419896-1-wangliang74@huawei.com>
In-Reply-To: <20250812015929.1419896-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 09:59:29 +0800 you wrote:
> Previous commit 230b183921ec ("net: Use standard structures for generic
> socket address structures.") use 'struct sockaddr_storage address;'
> to replace 'char address[MAX_SOCK_ADDR];'.
> 
> The macro MAX_SOCK_ADDR is removed by commit 01893c82b4e6 ("net: Remove
> MAX_SOCK_ADDR constant").
> 
> [...]

Here is the summary with links:
  - [net-next] vsock: use sizeof(struct sockaddr_storage) instead of magic value
    https://git.kernel.org/netdev/net-next/c/4d18083d6b2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



