Return-Path: <netdev+bounces-145128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B2A9CD537
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF7B22532
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039E58222;
	Fri, 15 Nov 2024 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/E1KjKA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BF3307B
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635833; cv=none; b=mCWIImJpRc7pr59SyRtM5ACyeUbhnxIcLwCiaX9TLz31SanbFYyRT36AQs30JgnEqB05cEAFXm2QNwecUkbYqYgkYW6xu37D/7yTtKtjdmAwN2YUzX8LPYTvyTpocZ1LZhZQjllxiS7lNLfHRFDQLin8gFUKrXIn10qMDs5ZhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635833; c=relaxed/simple;
	bh=tcOuP5p62jl5BLLfSzICiOVoitRJ77m8em2pnmBMEyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+EdGt5ad5ihAxHoi1GkmGWGLWshuWdfinhfdQLTPBKx/Xjem8ka3qI7Kpj9Lx8CMGoJhe/qU7OjylMxOuEUidAR63xeiGRi8VJoox03TD4o+beMGWstQRV63FI0tLT0Bp2lfbmZT69J0M1R9/UwFYdF1xMqePljcspSfAfVhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/E1KjKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9557C4CECD;
	Fri, 15 Nov 2024 01:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635832;
	bh=tcOuP5p62jl5BLLfSzICiOVoitRJ77m8em2pnmBMEyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z/E1KjKA+8aXfz987yfQSI8TJJ2gM4EdRTxzIpvwppvacNvQGowNepVsCjctfzjXa
	 VZcDr8ugbCznSfGpCb5SDr6gOEmAxWl074urADRhWXCoIRXu4SsI8krs8zkZeqK/en
	 RZ0I5VxEwwLVJT0QHV6afoCiQp1yVDZF07lyGVYBrKVewqaCpaOczLJYAYJU7x7UJp
	 uhCQ+2D4G2vXUXhHLAUu6sshwwt43p7tkzr5KSy6+BFuZivXG6YMOPW4Ch9IJugx8b
	 taRLHsFVstBs+qMr8Bq3zG6FYAqGPgvQud4RnpCd126uOa9dMAkmzp1bIaHRD8UJ3M
	 iywIc6VxYaOOQ==
Date: Thu, 14 Nov 2024 17:57:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: Make copy_safe_from_sockptr() match
 documentation
Message-ID: <20241114175711.1a51c414@kernel.org>
In-Reply-To: <535b4ef7-3cfb-4816-bd7e-c0fa8725c7f8@rbox.co>
References: <20241111-sockptr-copy-ret-fix-v1-1-a520083a93fb@rbox.co>
	<20241113192924.4f931147@kernel.org>
	<535b4ef7-3cfb-4816-bd7e-c0fa8725c7f8@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 00:36:35 +0100 Michal Luczaj wrote:
> > I'll move this to the commit message, it's important.
> > 
> > Are you planning to scan callers of copy_from_sockptr() ?
> > I looked at 3 callers who save the return value, 2 of them are buggy :S  
> 
> Sure, I took a look:
> https://lore.kernel.org/netdev/20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co/
> Have I missed anything?

Looks like you covered the two I spotted - rxrpc and llc, thanks!

