Return-Path: <netdev+bounces-139845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C219B4718
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880562836A2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A560204F71;
	Tue, 29 Oct 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVYVQ2L/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63D1DF985;
	Tue, 29 Oct 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198424; cv=none; b=LBAn8gUxLyx6HHcl81RxzQbESAwlyfbUkrGvSXhWfz2s9R18H92le/ryYKXUW1pIU33b7AjFnq1UKRA7a+V91Qw/T9C0Mza5nJ68OHQCDME8J2icDt2K6OpSTa1V4v8MzgN/NSYr0GtzVasP4FKniA8JBH0r4ydyBFtyf69oatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198424; c=relaxed/simple;
	bh=GKQOic+Iow43xdBlnF2TJONS4WKrXxqdtwInlxWhQUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JK/EfIWNbMJJ3FyZzvQnktIkwZo4C38eAQNc0UxIjQe8nCij2wQhHKKAMvHJin94FP8ET6Ow+cPGd4E3IabWz7uNHJ9znKqQ80Ix64YheW7Bf5Q7RHwN68rCnuACW9+IX84Uo+Ugk+csbgo8cy+JF5PcTIy/tE6z8TJDzlwLcI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVYVQ2L/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3A9C4CEE3;
	Tue, 29 Oct 2024 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730198424;
	bh=GKQOic+Iow43xdBlnF2TJONS4WKrXxqdtwInlxWhQUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JVYVQ2L//XHfQqT9rYVWZdJK4YWnkUdMRkHJP+H1nd01+Yilf8tQmUeI8ZV92SoXD
	 NUjCpC2yxYENqspHMXVneu2J6vqfjChP1Kw7jB1P6tE5ZVgpp9qzH2u07cOKFt00ds
	 nWOSkidF4goOnTMDiubY+NZr9FvONLa6fSapF4mE7kMzrOONK7FUX1lIddZVIi7h1m
	 dIHvGXFP/aYGs3RCg5oGHbKcH20zu9aYhmVSns5Uf4z1/IriYHSno/NpRfN1JKjS9j
	 dYupPKoPkjukp5C71nNmkf1hCFCvHJSrUaXkuVGiIY7cW2DSowwN6JYIFBZRRAZnmI
	 hWiVhsIeTW//w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1D380AC00;
	Tue, 29 Oct 2024 10:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for
 non-paged SKB data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173019843151.651132.13756275797117288059.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 10:40:31 +0000
References: <20241021061023.2162701-1-0x1207@gmail.com>
In-Reply-To: <20241021061023.2162701-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com, quic_jsuraj@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Oct 2024 14:10:23 +0800 you wrote:
> In case the non-paged data of a SKB carries protocol header and protocol
> payload to be transmitted on a certain platform that the DMA AXI address
> width is configured to 40-bit/48-bit, or the size of the non-paged data
> is bigger than TSO_MAX_BUFF_SIZE on a certain platform that the DMA AXI
> address width is configured to 32-bit, then this SKB requires at least
> two DMA transmit descriptors to serve it.
> 
> [...]

Here is the summary with links:
  - [net,v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data
    https://git.kernel.org/netdev/net/c/66600fac7a98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



