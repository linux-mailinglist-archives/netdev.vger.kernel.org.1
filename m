Return-Path: <netdev+bounces-66060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AF83D1F7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57521C251D8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8764C;
	Fri, 26 Jan 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPATBBkS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F710F5
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232026; cv=none; b=NNb/Mg3fXTFW5kUvFAaOxXV+0qYscJ8GdLJSH3YOqnLEa/0X9dtp+MC2vWbuLF4BiTEHHiKnhGJjRiGam5WQFIyJEXulLQS4lI+49XcFu6lwo+OvNPAIdm7O1yUUd0qS6odBdBKHhwQfXKJSgo2LZt1n5NGlrM+YN0ZfHKyzMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232026; c=relaxed/simple;
	bh=K1lY695uWMSCMxLHAkn3oN5FtzMm0sI0cNGmOrwxBhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=urR229mNwQWvSMBxD0lZW1I1Yzn4x8JKXI0d7wbowgOLmsswfkODNhqkyMWrc9Ar/7B85OVRYpCMIGT9Pcyoq3aPGIl7iSFwWXI53H9GEXCrgP1TlaCsNFaUmvLnTxsOpFfebypYrZvBkxuw/Zg9q7YID0RNoGoevjfU4+9RltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPATBBkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F66FC433F1;
	Fri, 26 Jan 2024 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232026;
	bh=K1lY695uWMSCMxLHAkn3oN5FtzMm0sI0cNGmOrwxBhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KPATBBkSJtJ7H7lC1e+zxtVNarrC8uqEopl2TqKd60eCmX/uK1fJuJMTt/CurxIwr
	 IIsBjoqGJ/X91NDhcdwWdAKBpc9yyqICvFThWH/ESuKYB34no96jmDOfcg1k38uOdH
	 gQmWSke8Vrls/qSi/i5eUu0gmhT2TcM6ufrtbeke+iSeJQwxjphdJ4103d2K6hyXCi
	 phGeWi3qExDf0bZ83aOX1DxQVttjqpiK4zFAprRdHd5IaJgb+ZuZB8eJLvi4w9IUOq
	 XNRqb+S70hexG4/2jfyVVj+FO2+FW5jLXk1hoFhTqORzuxgq6/XzorChjaUSJ+j3Rh
	 y4OMH95a4qU4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E89B6DFF765;
	Fri, 26 Jan 2024 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: Fix skb truesize underestimation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623202594.2360.13636003325159269773.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 01:20:25 +0000
References: <20240124161025.1819836-1-pkaligineedi@google.com>
In-Reply-To: <20240124161025.1819836-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com, shailend@google.com,
 jfraker@google.com, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 08:10:25 -0800 you wrote:
> For a skb frag with a newly allocated copy page, the true size is
> incorrectly set to packet buffer size. It should be set to PAGE_SIZE
> instead.
> 
> Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> 
> [...]

Here is the summary with links:
  - [net] gve: Fix skb truesize underestimation
    https://git.kernel.org/netdev/net/c/534326711000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



