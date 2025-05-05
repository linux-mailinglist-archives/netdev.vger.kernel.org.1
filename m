Return-Path: <netdev+bounces-187822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FAAAA9C2D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8267A2F56
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7615E5C2;
	Mon,  5 May 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLBrRcci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA64A1D
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471802; cv=none; b=ZrMQLEdk4Zq/YItwP6zGGlgjWe5cN6LrLJrtA/nHtLutGPiEODDALjUBs4ddXIeXy4ShA9PLoNe4tCXYCqrFxANhFvJkvY7FrXd2s3KRWFl0yKwcnLT9eVbi0wpz+KRWKv+dWo5QFgZ/R9IZx/ZUoeR2Wlfs0t4/WdNU8NoxkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471802; c=relaxed/simple;
	bh=YDMFTODhyZBtTiUWWNtb+7SIVIpwQIRxJ4UVPm4nv7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1DBqkJZubXcmjPBNrtJ6G4t+RbQyUVGyDKs0h9pFIy5jORRiyibeHu7qG0PbLxS3JI5eriouliJXn/HFtYOjt8nsQ6wxh8rcFhU1wawv3fPiet/7wcfqkj8uS7Kety/lDzOEMcmgQ6q47K+BXdaGJRV17NyZTHsFZDavz9wOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLBrRcci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B436C4CEE4;
	Mon,  5 May 2025 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471801;
	bh=YDMFTODhyZBtTiUWWNtb+7SIVIpwQIRxJ4UVPm4nv7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RLBrRcciagXiKOD1UgAqTYgchiGkCVd/heYU7WBrfJvaraIQekQwh+98D1xEsvv6O
	 v6Rn2HD5KV83zSybuO8SHI4lEQsGLmpuTx2TjvKC4u3ueOkozsOW/xfp02P8RMPRNy
	 B8ruIbEWcmWsVnF3a+mWsSxshlX71G944CpuGJYXCDvxq5R/JoNVZJOIcl6hllNOFC
	 BMrwdrkU1DpCavGGwDtB9h0TRDkDoARX1E0bdtRAJ9L0yKKYBEm6FZWpA1q14X5TY2
	 ZhcZ+JhhvlvS815HAuAHEBzXVzPrz7iMpkrAi3lLTT0/mksLNHmRQGAUH0B4tBoBYY
	 1scpr8F5FtG5Q==
Date: Mon, 5 May 2025 12:03:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "saeed@kernel.org"
 <saeed@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock
 during qdisc ndo_setup_tc
Message-ID: <20250505120320.68db7b42@kernel.org>
In-Reply-To: <aBkJg0W-QhIJiMfp@mini-arch>
References: <20250305163732.2766420-1-sdf@fomichev.me>
	<20250305163732.2766420-5-sdf@fomichev.me>
	<eba9def750047f1789b708b97e376f453f09bfa4.camel@nvidia.com>
	<aBjUFyaiZ9UHpvze@mini-arch>
	<a834c663507a78acaf1f0b3145cf38c74fe3de09.camel@nvidia.com>
	<20250505113514.6f369217@kernel.org>
	<aBkJg0W-QhIJiMfp@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 11:54:59 -0700 Stanislav Fomichev wrote:
> > BTW isn't the naming scheme now that dev_* takes the lock? So we should
> > probably add netif_ versions or rename these existing calls?  
> 
> Can I follow up on these separately? I was thinking about sending
> a bulk rename once we are closer to shipping 6.15. We have a lot of
> cases where dev_ is inconsistent.

Ah, SG! There shouldn't be any driver callers of dev_shutdown
so no risk of confusion.

