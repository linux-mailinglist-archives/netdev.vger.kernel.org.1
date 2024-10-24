Return-Path: <netdev+bounces-138533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA409AE068
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95DD1F223C8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676BA1AC8B9;
	Thu, 24 Oct 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/6GIEAu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436045258
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761630; cv=none; b=j4qXB/Fa1TAdfFjAfK5sHE5Y0gEVabmTi901xyBrxCXnEj8rMLXiPuaVCeuHOnHbY2Hib0CoWdICuY67DW6TU5S7gib4nfWZGsad1VuksVN4kgTKaAwvdcecpivL5gKsWkKdssn2A8lXnCvwTc+d7OQIUYYwhTjNS4ujhGPHjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761630; c=relaxed/simple;
	bh=Fz8MhRAv84psw3Bx5LLORTTu9KqBElHdD2w0j+wd0bc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIE7gx/kjZXG7cseW2K+d//HKtOPJAzA1HIj2A6Dp1k9PHGtFRxVnT/8NFF9P1/f5rhFMRqij28vtmErglLc/uU/fIcR+/miBN3FOZmPTS9svutkSDshWp7XMKFunp9jxXghKZxLQ0w1+oESJ6KqIezRwvIpxnpEAx0/3xSO6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/6GIEAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA61CC4CEC7;
	Thu, 24 Oct 2024 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729761629;
	bh=Fz8MhRAv84psw3Bx5LLORTTu9KqBElHdD2w0j+wd0bc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f/6GIEAuxisVKug77FUoqoQIpQ/a+JF0SFvdlvewjKMDct+amDzQdPqaAfJ6vHdUk
	 mL8KR8Hc/qr4YZ9W4Llw0pldOo9Ch+XswFyS1lO4hfPF7qzVZTwpV6FGkn6d9ZGS8A
	 QHsg7tEc3miGKzlAEnX7uWKXI90c95Ov34upFYP4R+JFW2g5VaVNv22ucQSQBjB1x/
	 oS/wE5njYQNOMNN7OMB0CyA0xfCqrCXNWepewnBxTZUyfIpM7TLEatXkft0V+NR3MS
	 sCRG4ge532CZSTcCUmGnpu3wPt8w0BvbdubQomqh7NRYVjGuCn35mr2HJcqChipx9c
	 ib0CvtMuCYyEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717E4380DBDC;
	Thu, 24 Oct 2024 09:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] xfrm: extract dst lookup parameters into a struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172976163606.2169378.7808893214162654338.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 09:20:36 +0000
References: <20241022092226.654370-2-steffen.klassert@secunet.com>
In-Reply-To: <20241022092226.654370-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 22 Oct 2024 11:22:22 +0200 you wrote:
> From: Eyal Birger <eyal.birger@gmail.com>
> 
> Preparation for adding more fields to dst lookup functions without
> changing their signatures.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [1/5] xfrm: extract dst lookup parameters into a struct
    https://git.kernel.org/netdev/net/c/e509996b1672
  - [2/5] xfrm: respect ip protocols rules criteria when performing dst lookups
    https://git.kernel.org/netdev/net/c/b84697210343
  - [3/5] xfrm: policy: remove last remnants of pernet inexact list
    https://git.kernel.org/netdev/net/c/645546a05b03
  - [4/5] xfrm: validate new SA's prefixlen using SA family when sel.family is unset
    https://git.kernel.org/netdev/net/c/3f0ab59e6537
  - [5/5] xfrm: fix one more kernel-infoleak in algo dumping
    https://git.kernel.org/netdev/net/c/6889cd2a93e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



