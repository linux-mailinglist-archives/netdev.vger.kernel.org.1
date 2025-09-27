Return-Path: <netdev+bounces-226822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F4BA56A4
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 02:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4983A1C067DA
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72F1C3314;
	Sat, 27 Sep 2025 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJmDaiJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1817E4;
	Sat, 27 Sep 2025 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932773; cv=none; b=hs1RCMVUJMAQKjxl+ZJ1B/v4t6l7++tPkxx5neu9nHCs/xneuxS9yAnTWOMq3eNWG1hyCylrwdNPVvACCNXED29EOPemuaimcAO63K2v0mNLFaZLGHCdHNq1MtMwsAHjhr1d3GUGueLpkwJFjjnMK8iCm98DZHED8NUHBTlan+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932773; c=relaxed/simple;
	bh=ldQkQDaE7kzwJlWbrIdbMhU3peP+xUqWXqOsC0kAejY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4kSJ3qqZJBBsEwHMIZMiP+BEQyCy4l7ol3nnCdbSYCp1Yn/ykdMlanZ5www03d1JGYz74tu7n4XFoDe/dgHj3DDCLN+ooZmaAkRh1rHYr6uTw8DG6K7u2lLC7gMvtSgVKaTr7yles/aLaKykPsWEr8dPYaWyuoNRiXX/VXvT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJmDaiJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A27C4CEF4;
	Sat, 27 Sep 2025 00:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758932773;
	bh=ldQkQDaE7kzwJlWbrIdbMhU3peP+xUqWXqOsC0kAejY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bJmDaiJA3Sy8PeR9f0QUdQK3FN51BDqZafta3nVKF/8ArMCpUJyzulo+fcR6GHF1X
	 D2dFWz9JPOHN2yUo7K1owfpk4OOiVicLQ1AI6T7vC5lakv6jYXe8hDY7FVcdGxqRk1
	 rI/WWrwib7y1xCQTcHiBh24N9OzKd0Vi1JpOIG+GSIA6B1JMQn7TytisiJdZbmJK5y
	 +0M8K9eSkfj5bxCR7RBrnFbgzPQBXMreZN8ywTTYUGpM7Pm5WPnFZv3KTkv90b0Kvc
	 mTXgvW/6DgXEuambGU9TFbYw0xy1ZZgmm95nP5+0i8/roPnOMp7BiQ1+wD8DD5V+rB
	 5JNNKW+YlNSyg==
Date: Fri, 26 Sep 2025 17:26:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, xfr@outlook.com
Subject: Re: [PATCH net-next] net: stmmac: Convert open-coded register
 polling to helper macro
Message-ID: <20250926172611.32d60205@kernel.org>
In-Reply-To: <20250924152217.10749-1-0x1207@gmail.com>
References: <20250924152217.10749-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 23:22:17 +0800 Furong Xu wrote:
>  	writel(addend, ioaddr + PTP_TAR);
>  	/* issue command to update the addend value */
> @@ -144,23 +143,15 @@ static int config_addend(void __iomem *ioaddr, u32 addend)
>  	writel(value, ioaddr + PTP_TCR);
>  
>  	/* wait for present addend update to complete */
> -	limit = 10;
> -	while (limit--) {
> -		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSADDREG))
> -			break;
> -		mdelay(10);
> -	}
> -	if (limit < 0)
> -		return -EBUSY;
> -
> -	return 0;
> +	return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
> +				!(value & PTP_TCR_TSADDREG),

Why the strange alignment ? I think you can start the continuation line
under the opening bracket and still easily fit in 80 chars?

> +				10, 100000);

You say in the commit message "no functional changes intended"
but you changed the frequency of polling from 10msec to 10usec.
Seems like a reasonable change, but the commit message is lying.
-- 
pw-bot: cr

