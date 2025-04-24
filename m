Return-Path: <netdev+bounces-185336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D686A99C96
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF284613C9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A86E545;
	Thu, 24 Apr 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQZ5tVxm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7446B8
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453409; cv=none; b=czGr2/09u8T60M5FJrfP5Gx1Ai5BDyn6rm7glNy5aClJDZrGrkGmzQlfDqaGB4lb0phxqqf0w8ttnsHt6acv43sf/sq+PQSLZxrtiaDmkv9dJ2+xYHLa4pOuIkZOzREZVaatasr1lGeCaW79sXg14JA58RgvJ0NZZiidydT42CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453409; c=relaxed/simple;
	bh=kutzUqqAA5NrWKcLMwRLKAOTWgV4eKf0VodnQx/O4lI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sTlLYe37Ek+paouk0AFlBRFTnv+7eAjJCEk+jXz46UMpEh2ARQ8FoOPt6RW/nrjHrQAgnmwnQLhOjSfW30ZkInM5YLZx22+24/YOMwzXH+ejJQIrYLApmieurTbOTwCyZmxrv80npRDEyLMsdRqgYESxpeIlXx3kHNja1RZlUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQZ5tVxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE583C4CEE2;
	Thu, 24 Apr 2025 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745453408;
	bh=kutzUqqAA5NrWKcLMwRLKAOTWgV4eKf0VodnQx/O4lI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQZ5tVxmqJF/jnQCS0kn5tnNttAuQlfoh7Rm35ZEs0oFpxid1Pdazg07hjCCLV0P6
	 itVca3K0zlKsE0OGxv/9KLj122Bt/W2d2VmX9H0wwilUO7dmVivOVvB+FUZFtznNzy
	 KVgoqakCzyZKLC15UA2VQwzv8I7njc8v3ioSmaSGL4A35ES/9XOppSsTGn9DktBmAb
	 oA3at13dpcR+4OL6cyvMinX+xCLce19aIld4a4oOU6jQsRVM9Do+CCXJhy3X467BZK
	 oJhxM0evZMs7Rz6DcvVmJrGoIZ078isfPDFge9Qh3+RBhduHRjwc44NjMhqkcZILR+
	 Tn4B3Hh5uZ6jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F9380CED9;
	Thu, 24 Apr 2025 00:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: Fix wild-memory-access in
 __register_pernet_operations() when CONFIG_NET_NS=n.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545344723.2807189.4095571131831487304.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 00:10:47 +0000
References: <20250418215025.87871-1-kuniyu@amazon.com>
In-Reply-To: <20250418215025.87871-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, oliver.sang@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 14:50:20 -0700 you wrote:
> kernel test robot reported the splat below. [0]
> 
> Before commit fed176bf3143 ("net: Add ops_undo_single for module
> load/unload."), if CONFIG_NET_NS=n, ops was linked to pernet_list
> only when init_net had not been initialised, and ops was unlinked
> from pernet_list only under the same condition.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: Fix wild-memory-access in __register_pernet_operations() when CONFIG_NET_NS=n.
    https://git.kernel.org/netdev/net-next/c/f0cc3777b2db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



