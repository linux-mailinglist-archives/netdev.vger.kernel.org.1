Return-Path: <netdev+bounces-152823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2979F5D9A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B761693C6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D13149C7A;
	Wed, 18 Dec 2024 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4xTiyDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4561494B3
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493815; cv=none; b=DYgHOjGd7Q9B5YZUrlMgqpNpuA6dC9wgAZe9kjkMEMwuUGNSsDFRW76As8xntYRS6dEIy6kdaP9ip7LIN1mnISPuk9wCvgvPvvYkNIWyyp2thVyLThrEF1jCh2N1zU/iKiA7MgE9g0pENe8E6omYIRyX9z7bv3S2VN9vu+HeRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493815; c=relaxed/simple;
	bh=84RHA2n6MkLeCxxH5rqwDN10VKWOgUWENWVULRZHO4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WdL7zKcHTDXzU/ve8bkKwWEmaZVvhP1d2w2NmSwoX+9Oo4mBlH/74N48pahhxg/VnJyKkuCoQjuXUtcCPBztoi67O/ewZwPV8JNCVylfrBtKopcHHZWVvOWPjMsULq5L/JdBMkMtn7HrFv7t/V+guTTNTJznBYChUB/R9knsl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4xTiyDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E15AC4CEDD;
	Wed, 18 Dec 2024 03:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734493815;
	bh=84RHA2n6MkLeCxxH5rqwDN10VKWOgUWENWVULRZHO4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G4xTiyDLtoSPCIy15R/H2kaOhanf+Ue0Cuk8DW7Z8KTDZuFovd251xj8KKE8gyH6N
	 2dLl77+3hwcNh+zBC4mIid7eV3T9VuH2oCFZXznPEBSGLoA+Dl4L2rDviWv0Z3xkH2
	 h/t+5ITvZYVN8DUhPl2qwLFKB7aHZCgF2cW/cKL7Iv7Eu/HMWm/YyHdveCp+Q0A3ee
	 WpkbA9L05Tyk3uny4nddYJZyQ/wqlM7Zr+m7h2vMUmlYsBYFUbHEvGBH6HaCaSBbaB
	 jCOEdRnM7TTn9BnooLsOwKG0zq0jlBTErTk9sooK4nyivjSMaVcg7W2T8N5vq/zEBe
	 tm+O8fXb1WzPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E7BE13806657;
	Wed, 18 Dec 2024 03:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] niu: Use page->private instead of page->index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173449383274.1170405.13729545074307749615.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 03:50:32 +0000
References: <20241216155124.3114-1-willy@infradead.org>
In-Reply-To: <20241216155124.3114-1-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-mm@kvack.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 15:51:22 +0000 you wrote:
> We are close to removing page->index.  Use page->private instead, which
> is least likely to be removed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  drivers/net/ethernet/sun/niu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Here is the summary with links:
  - niu: Use page->private instead of page->index
    https://git.kernel.org/netdev/net-next/c/33d06d1d2812

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



