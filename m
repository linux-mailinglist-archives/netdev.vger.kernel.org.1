Return-Path: <netdev+bounces-228474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE7BCBE48
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18BC14EADA5
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949051E0E14;
	Fri, 10 Oct 2025 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upx2IcbI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09D1A267;
	Fri, 10 Oct 2025 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080719; cv=none; b=GwcF/1jWl0AFeWxvjUfeWFHrTe3xCiKAHdk/yU45jteZ4i1gSumErrg2QmU4cbqJ3mZ4YTZy0YGLkDtg1zdCXuwtSsNdleajmZ2Pw8+sKbTvjxvVHIiryrETBehuwtcwcD6MZSAvCuzb9paiSQIekdvACrQaYglz8twGoQl1DwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080719; c=relaxed/simple;
	bh=0L2Qi+NGJJTq2+7NzVpgzCxVh7Djj6DY8ORJwVShcws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1OzKqGtUXonD7lOlwPt11yc/2bVLFMcdASW0x7ult4o0s7eVXfpd09OUVx0BSf07qhM2B1+9ZzE3pPzjVJJYAKFnm2zCJMiAmFszZh4rCeLnKEmj4Llf6ddgsi6m8dzhNbvOONHLfOPm/6eiM6bHwcNeJPbOqL5aTyTbTBjZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upx2IcbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDBCC4CEF1;
	Fri, 10 Oct 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760080718;
	bh=0L2Qi+NGJJTq2+7NzVpgzCxVh7Djj6DY8ORJwVShcws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upx2IcbILcqGDdpncJur8gjpsPOgzpjJ4fMR8DxXT+i9zNAqr7bgS9TOmdulEvS5D
	 743devjPJB4TEDFIzcuB1F8uCwyuG3XK0bhgEBkL1FrXzdxI+dpmsNcqrfiRrOxT9i
	 ukRgLMgbCUYlnfBN+Ht8CJHfmcSgA5DMJa4ZGpabPAx6fpQqx2L9d2MDLgYf67a3WO
	 t8Le/xz8UVCVINAa9m+SK1igdzCl89/fpix3RHuOU16njswwEy5LuVh/54eOm1xgoo
	 r12T6MULrRNF0Qvuxhm12M3b1B23oYNmLrd9+mEbXuDwQ4tzFLBSfQMMvukzBjFJtL
	 2gC2GQzHqmjWQ==
Date: Fri, 10 Oct 2025 08:18:35 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: fix null dereference in receive_packet()
Message-ID: <20251010071835.GB3115768@horms.kernel.org>
References: <20251009190222.4777-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009190222.4777-1-yyyynoom@gmail.com>

On Fri, Oct 10, 2025 at 04:02:22AM +0900, Yeounsu Moon wrote:
> If `np->rx_skbuff[entry]` was not allocated before
> reuse, `receive_packet()` will cause null dereference.
> 
> This patch fixes the issue by breaking out of the loop when
> `np->rx_skbuff[entry]` is `NULL`.

I see that if np->rx_skbuff[entry] there will be a dereference.
But I'm less clear on how this situation can occur.
So I think it would be worth adding some explanation of that
to the commit message.

Also, I do see that break will result in np->rx_skbuff[entry],
and other empty entries in that array, being refilled.
This is due to the refill loop that towards the end of receive_packet().
But perhaps it is worth mentioning that in the commit message too?

> 
> Found by inspection.

Thanks, that is clear.

> 
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Tested-on: D-Link DGE-550T Rev-A3

...

