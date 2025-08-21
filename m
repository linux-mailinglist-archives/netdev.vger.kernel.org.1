Return-Path: <netdev+bounces-215470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B0B2EB68
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA6B7BA362
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38844258EE6;
	Thu, 21 Aug 2025 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8H/dF+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84F248F73;
	Thu, 21 Aug 2025 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744600; cv=none; b=GCmL8XeDcDOd/mRGRitq14jG1SL8mTjZpgaSeWt04f4Fn0YlgLg5JE4TlZQolBdG4XwiK2y8/csHlrEB6uA8Fy2rYKApdqK+Oz7bPTJ7FE+oP/vyHprmafCuj9SRNEMZcG6D53D92Xcrcs+P++e6PfzC7TG6OO/8v3bgae5kjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744600; c=relaxed/simple;
	bh=DiGbolHgCORTjbvJecb4FDqCcbukebLRSFuh9c89bMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOK8rnJf/Mo5a7UAJgFaJ6zqp2aDyec1/vHIM4Z8GlVoWtNhpiv2djwBsoBW4yGyPWFfMZ23r+mVjAVYl+i1vq62NdXqDQXutkxDyVLRSTAaBOIASOqXaGX2TubxL0OhnkuFkfEJFPhygnvMiI/pyjwonzdziJ36B18/IvanjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8H/dF+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B42C113CF;
	Thu, 21 Aug 2025 02:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744599;
	bh=DiGbolHgCORTjbvJecb4FDqCcbukebLRSFuh9c89bMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N8H/dF+MtB/RR8Lc1YWzerZZJPYlROGbe/UH9klPU3D1swkpI8MCRIfFbjkeXNd7j
	 pb16DJYhPSrNNoluCeUiKax8Iepw5BgpxVtS9MCLsHl38a1p0vTiCKzyWvWMOk8j15
	 oOvjWVsd6gTDi5GjGygv/yYmIQ63O33fZybydOq1yHPfXyuFcVVtUcf1k+xQHfeA6a
	 XsusFrySKYnDKfE0TzJp5dRDyvyB1yxeA/CbvaLLwT6O6SQuo1LFe2xYqwIHemUDy/
	 v46Fx8idTyt1z6D1zuCo9U/+Z/vRzIkrI9+QvPecST1Y4sdGT15P+eyb6Gl230meJU
	 FJbV9tM41IFbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1C383BF4E;
	Thu, 21 Aug 2025 02:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: openvswitch: Use for_each_cpu() where appropriate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574460849.485172.11397210689768201683.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:50:08 +0000
References: <20250818172806.189325-1-yury.norov@gmail.com>
In-Reply-To: <20250818172806.189325-1-yury.norov@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 13:28:05 -0400 you wrote:
> From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
> 
> Due to legacy reasons, openswitch code opencodes for_each_cpu() to make
> sure that CPU0 is always considered.
> 
> Since commit c4b2bf6b4a35 ("openvswitch: Optimize operations for OvS
> flow_stats."), the corresponding  flow->cpu_used_mask is initialized
> such that CPU0 is explicitly set.
> 
> [...]

Here is the summary with links:
  - net: openvswitch: Use for_each_cpu() where appropriate
    https://git.kernel.org/netdev/net-next/c/62a2b3502573

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



