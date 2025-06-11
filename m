Return-Path: <netdev+bounces-196401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7213AD4797
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 03:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA277177A93
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8213AA53;
	Wed, 11 Jun 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmTQOxRu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E6137C37
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603604; cv=none; b=uOB1oTKoNjqGT5UlgwnxTgc0S3DRIFbjtuSbhpdisy0qi1vgYjzpvRByHZ0fVXB/7Opc8o/PHJ1trsEOr72cM6fw7OqTT7Klo6HkD0Yjb863vUt+rMmJ7bmwTg8pSHdkfduMoivamwr+v+pXfNfy1UTh149fHB3VMWAPBGL2I4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603604; c=relaxed/simple;
	bh=uLAgrIpub9AmdKhq0yWw8R1yF3sALoGs/7Utz2MGozo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hKVRDeuB8H3CciCFxwBg5tVtBcFXXWdb384csl1MdHIzu0Evpy6vig2JJAcyeLUo6tr6UtYRn1Ms7d56UJ0cv+bEKIIw1tHMYUVwjvbPQrGkQ0tK9/3+REujfoKVUBdh5YjPqCuTZWW3KhnunJJNoPs+wM2wHn8X20jCJZRzTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmTQOxRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4E8C4CEED;
	Wed, 11 Jun 2025 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749603604;
	bh=uLAgrIpub9AmdKhq0yWw8R1yF3sALoGs/7Utz2MGozo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DmTQOxRutTzmusdY0gnxVJBahDD9ClF1UxQ5XhuKNmGR3oLmcLX7QIAjBxjMzfDAM
	 K/LpzZfGB1WkDdTkQo8wqzKfooPWv16Tuo2He8fGcPrcqwbyENncV6ZjMP96Vh6FhM
	 eBbSb9KQUhb2+mTndKs+lIAG/sLKekBpOQaweYuthgAXPz5LiWHTqIGo4OUrGc4h7C
	 pCQdY/KVocvQWCnPxz9yBJ3wj4ze7tUVkbPYkf/h0vQSqFJZSA5E+fM+tv4kzEQBFJ
	 OU/78Q8GpXcrQyfz2tTBXNXmPMVoFq3ZEHLNbkC974JGUMIFfeJd5dZ/jxMuCi1htb
	 GPGeZMTqsP+wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD0E38111E3;
	Wed, 11 Jun 2025 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: stop napi kthreads when THREADED napi is
 disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174960363449.2754897.11583309016240150698.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 01:00:34 +0000
References: <20250609173015.3851695-1-skhawaja@google.com>
In-Reply-To: <20250609173015.3851695-1-skhawaja@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, willemb@google.com,
 jdamato@fastly.com, mkarsten@uwaterloo.ca, weiwan@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Jun 2025 17:30:15 +0000 you wrote:
> Once the THREADED napi is disabled, the napi kthread should also be
> stopped. Keeping the kthread intact after disabling THREADED napi makes
> the PID of this kthread show up in the output of netlink 'napi-get' and
> ps -ef output.
> 
> The is discussed in the patch below:
> https://lore.kernel.org/all/20250502191548.559cc416@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: stop napi kthreads when THREADED napi is disabled
    https://git.kernel.org/netdev/net-next/c/689883de94dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



