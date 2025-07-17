Return-Path: <netdev+bounces-207910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D497EB08FDF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87FD5845E2
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F22F8C54;
	Thu, 17 Jul 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9DcgwW8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75522F7D0B;
	Thu, 17 Jul 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763808; cv=none; b=ll/yYY58bgWuvFLCqgVJjbu2uYoT2yxS/afPsX1ju0S2vRGjDNG+mfQtzh44LYye9+9yL537LOJGIPtIcjQQJmam7ZfCz7NVnmIuaBabqXXwM5v39V9rQM6c2Fo4B25B3XAFMo6GtDe1Bzq49KSlHdhWMwuTubnTER4bvEg4EYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763808; c=relaxed/simple;
	bh=MDGtG4FAEKfAVwiC3Uj6THK55CuV7YxbZHvMpXBsGT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aBG1faT3CR89Jm0UYw86zuGBWJMeH8PkdbgnBLfqs+yHq4vHD6vgT2JiGqk5MipojcYsAO6LKhSmTNzIQyaKVi/fu4GuDpDbHKnlT0LZJ9qzSuKBfHtd83tRNhN+h6EzWqEBELxlnYpvaiBBtISu2AM3y70rlWyaY5L55yjmkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9DcgwW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403FFC4CEF4;
	Thu, 17 Jul 2025 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763808;
	bh=MDGtG4FAEKfAVwiC3Uj6THK55CuV7YxbZHvMpXBsGT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C9DcgwW8axEht5ojl9r4YknZdnxdq1se6gkXAIqgFZzcEppIVrtapgWK2pMRTtMkm
	 KgQxDdI/Qkb9DuggbE2tCSAlvUimwAMOf2jnAcfoeM00H9Zbnax/4GtjdGqwwJVZe7
	 /tc9rB+3qLcWb544lEfjg3EE+oZ8218S9dh+4weK8O/JtY8lzrulRwWRIIXGYIaalM
	 2ArNNUfTXpt/ADntbULXXNbV/rYq+RQpkTa80NcwrDvL9PZgyPpJXIjr1wE1w84K78
	 PJBFX7YEK6CQSSw+5oPZnP+S5Lu4EoAJKEsxjZu/GUiNlde3uv2/A2TY0yh8acWLoA
	 ofSxz2d6nOa4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F0C383BF47;
	Thu, 17 Jul 2025 14:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: vlan: fix VLAN 0 refcount imbalance of
 toggling filtering during runtime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276382799.1959085.5617599868762941082.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:50:27 +0000
References: <20250716034504.2285203-1-dongchenchen2@huawei.com>
In-Reply-To: <20250716034504.2285203-1-dongchenchen2@huawei.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: idosch@idosch.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 oscmaes92@gmail.com, linux@treblig.org, pedro.netdev@dondevamos.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangchangzhong@huawei.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 11:45:02 +0800 you wrote:
> Fix VLAN 0 refcount imbalance of toggling filtering during runtime.
> 
> v2:
> 	Add auto_vid0 flag to track the refcount of vlan0
> 	Add selftest case for vlan_filter
> 
> v3:
> 	Add Suggested-by signature
> 	Modify commit message description
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime
    https://git.kernel.org/netdev/net/c/579d4f9ca9a9
  - [net,v3,2/2] selftests: Add test cases for vlan_filter modification during runtime
    https://git.kernel.org/netdev/net/c/e0f3b3e5c77a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



