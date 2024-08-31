Return-Path: <netdev+bounces-123966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C0967056
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 10:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46821C2185D
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27435320F;
	Sat, 31 Aug 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSMWDXu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C214D28F
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725092754; cv=none; b=ZhKM8s86eLNAYhe3BDFJdi6Fg5k0JAqcMS0fzQPTcG9o/v0PBeh4zI0aRQc6AJTra/wTNa8WM8QC2YQdg8B9z3qtwqvY/6p93DjyF4Fxz/LfIt7uP4V6VHiKTUVhP1+twc7hMOxoAgUh/s1atHKKTujwF3Ptlpo6tJ7PCUzoEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725092754; c=relaxed/simple;
	bh=h1lmuIAN58zJlFcdfujfHAd0+78s9nF3cx7f99mwL6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtbbJy2naV7VGsp5xTfKUzgsBJLxjf3DLyOjVWHy9u1pL+7dkrV0uUZD7VwvsNzu8D3XJD4XqNPM7aACouJcK7gSD5fB61MFdIpcCDwCPnXTxPp9fN/KoZD7BR+cUYTNepq48CvucXU28lB8fShnR29eiYC8x4Tn8OE5FuIyPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSMWDXu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E98C4CEC5;
	Sat, 31 Aug 2024 08:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725092753;
	bh=h1lmuIAN58zJlFcdfujfHAd0+78s9nF3cx7f99mwL6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSMWDXu+3Y8And4PyxWSIG0I42iMewtnTKN00AAlvYqezE8EnJvoOdi9Ozm1KbJ1p
	 JmRJaIbeRykAe0NDU2fs3jMKRY1CqSKHMA9fxZ7TcUgv1ArooGGfVG1JFdzG6HXJju
	 y+9MBUttmh1uXoV91BIpgU0u3hRy+5m0kSen0iMHymMk4Aq+dDhSRZGFAD2I16j2z1
	 sbJghDDA6msk3r9l76Ooes/qB8RKZ64MKR3EX8DdNQQpp1d/dtrtV0KsQZ8e6aSEyG
	 os5n1uzBkI2J9p6tt/cQomTDuD8SypWAmPidj6206YGVOoTMtQ39vcrG6TlFl8WdOo
	 AbOwbqoVyaA0A==
Date: Sat, 31 Aug 2024 09:25:49 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH ipsec-next] xfrm: Initialise dir in xfrm_hash_rebuild()
Message-ID: <20240831082549.GD4063074@kernel.org>
References: <20240830-xfrm_hash_rebuild-dir-v1-1-f75092d07e1b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-xfrm_hash_rebuild-dir-v1-1-f75092d07e1b@kernel.org>

+ Nathan

On Fri, Aug 30, 2024 at 06:01:50PM +0100, Simon Horman wrote:
> The cited commit removed the initialisation of dir in one place too
> many: it is still used within the loop this patch updates.
> 
> Compile tested only.
> 
> Fixes: 08c2182cf0b4 ("xfrm: policy: use recently added helper in more places")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/netdev/CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com/
> Signed-off-by: Simon Horman <horms@kernel.org>

Nathan advises me that this fix is incomplete and
that he has sent a complete fix here:

https://lore.kernel.org/all/20240829-xfrm-restore-dir-assign-xfrm_hash_rebuild-v2-1-1cf8958f6e8e@kernel.org/

-- 
pw-bot: rejected

