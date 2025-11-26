Return-Path: <netdev+bounces-241762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F7C88014
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08BE4E13A0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FCB30E852;
	Wed, 26 Nov 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUG9U4a9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E920CCDC;
	Wed, 26 Nov 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129663; cv=none; b=BBzwjuCiEF6HkY4vjU/qVrNBt5wVNyFq5+b+ul8blY8mhNmPyyVmXhyeiVMj9MYKFs/KwyouSyPDYQQ8BLXyyUn7oGHe7CQb/CCsn3+jo6ZgjscuwwgOpDp1zKIxlfw14BWP/jWGvM9niHajooeA1IXMw/6k9gEplYs6Lt7Q2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129663; c=relaxed/simple;
	bh=yxPxRhrTDbY+y54DKOOAKlTteq8knZ5DChr7Be+981M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kJ+64Y28q55gLTTxE6wc4PCK51e7DcmvRmaLl1XUJ7aOOlF2ML9egyTneWyiptXTAPO+ARZ8+KKQ0uLIeZV9i6xy/hcP5hUaM8uVIxqhs9xdvqS/tCcGsE/1nYqNt8E055p/6G64axejYRWO7gD8nbBDBHkvgz/33RCYyz2u7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUG9U4a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446AAC16AAE;
	Wed, 26 Nov 2025 04:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129663;
	bh=yxPxRhrTDbY+y54DKOOAKlTteq8knZ5DChr7Be+981M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CUG9U4a9kvpGlvTygI5Td+Jc70c40ltdc2hOcpGLK6h6Z8aNDG95qOhs47ZLeaSm2
	 9ipbzWwzXLRVZycFH/3iM3JoKm732N9D2k5GHIUgM5RNa3xkuhUOwCOfN+QewpyJMw
	 fUlds41s+m2cRevA9o2Q2gRi+uxWOa0TQgBO+irZqiTdbHPrTA/zkZvX+RUMGFmREb
	 HxFz5s055n4IJU4Cv1QDthNMZMvtvy8ti3lWloGioGTha/NZPcKvq3a9U0lC4fD2Et
	 Y2mXZo+sthySxpaVftvQPVccNeHcIs+X4ptmrUNy87tVSryyVUXXfz34oOG+52YQ+I
	 tBNX49Gsq0xUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1FE380AA73;
	Wed, 26 Nov 2025 04:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ice: fix broken Rx on VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412962530.1513924.5156245445511033054.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:00:25 +0000
References: <20251124170735.3077425-1-aleksander.lobakin@intel.com>
In-Reply-To: <20251124170735.3077425-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com, jakub.slepecki@intel.com,
 nxne.cnse.osdt.itp.upstreaming@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 18:07:35 +0100 you wrote:
> Since the tagged commit, ice stopped respecting Rx buffer length
> passed from VFs.
> At that point, the buffer length was hardcoded in ice, so VFs still
> worked up to some point (until, for example, a VF wanted an MTU
> larger than its PF).
> The next commit 93f53db9f9dc ("ice: switch to Page Pool"), broke
> Rx on VFs completely since ice started accounting per-queue buffer
> lengths again, but now VF queues always had their length zeroed, as
> ice was already ignoring what iavf was passing to it.
> 
> [...]

Here is the summary with links:
  - [net-next] ice: fix broken Rx on VFs
    https://git.kernel.org/netdev/net-next/c/436fa8e7d1a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



