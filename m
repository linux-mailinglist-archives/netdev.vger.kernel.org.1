Return-Path: <netdev+bounces-158677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC1A12F08
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 00:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C2E3A26A2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49EB1DCB0E;
	Wed, 15 Jan 2025 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7cSBgwI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA81D89F1
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983206; cv=none; b=lsaEHPpGW2X59macVLDwJLcmyDh2y3BVx+cfUGc49xEuQoKxgKdvxE9OKOGMMPFglwwXFmDweWoFAGaNxVsC2szwv6B8+KdZ/NIIk0lWnmeEbMdC29MHoAe1vLhsP/k0al1//f2aghw/soWPU3PnW+f1F8vZg+OLyd+zaxc7NGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983206; c=relaxed/simple;
	bh=u1iopNtebgkLUj1oT9xplsp1wOKHbzF630GO3GvaUFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TvhYxFY0Owf2rmg+xuMTGq8NvtycS+uIqBXoo3dZJ1WYqRA7AgQ+TY3NT/kkZE/aJDfxBIbOpfSmZTx/nu5d8U5PdTS9N7XOD5bcdoOKnliKCHaGEk7D7VkU4FjkcHfqp5lRNgofFWiMNiY3UgDXiqh8czEvgeqjG5UBBy0zaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7cSBgwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4474AC4CED1;
	Wed, 15 Jan 2025 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736983206;
	bh=u1iopNtebgkLUj1oT9xplsp1wOKHbzF630GO3GvaUFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F7cSBgwIY6UcsdnPm+4vYo4UTknf/AYr82qfCP/hS5diaWok46UoUYoKlGdL8eKlK
	 ttheQHF0iSqUtw4C6E/xrUV6Z+vkysTJQAwaKwe+YqGByr6QYxsbBI37zyYJocYB9f
	 4SNw6hV3f1d0N/Ezlq65x2wgcQb5WccSB1nfrvZmqdsYl4RWNT5Hu5m0QqLpN3e+lK
	 wydYmpqQkoqRIqqWDLj+Sce0ESSJ0Zf/r0PRE2yisP+pxRTemrn8idHT9h4FL7svbS
	 mHswoquqMP99pSUsMIimMl0v8oEOujcf9Cwef41s0jkoQ85OWN8y7rchpehanuvsAD
	 hFKeHzUH2tXzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F06380AA5F;
	Wed, 15 Jan 2025 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] inet: ipmr: fix data-races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173698322926.910486.11639270509692820277.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 23:20:29 +0000
References: <20250114221049.1190631-1-edumazet@google.com>
In-Reply-To: <20250114221049.1190631-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 22:10:49 +0000 you wrote:
> Following fields of 'struct mr_mfc' can be updated
> concurrently (no lock protection) from ip_mr_forward()
> and ip6_mr_forward()
> 
> - bytes
> - pkt
> - wrong_if
> - lastuse
> 
> [...]

Here is the summary with links:
  - [v2,net-next] inet: ipmr: fix data-races
    https://git.kernel.org/netdev/net-next/c/3440fa34ad99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



