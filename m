Return-Path: <netdev+bounces-114281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14029942049
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463D31C234EB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A601898E9;
	Tue, 30 Jul 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOOwPDnG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C031AA3C5;
	Tue, 30 Jul 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366363; cv=none; b=pNq+/jaQY74tA4KL1MCELp6eOjS8GtXpds+FBRTaoSoyDol3Gv7l976zNuTVPYieLNXyBJ1OqDi7zrUeoHG93tAQBrO60Pq76D8A8vjjCr2uKKKFB1JMz83TXmrqEnT7LDa5McaRYSXnqXoVEw9HwApeh2xX7UfKTAql6UnGo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366363; c=relaxed/simple;
	bh=kgqS2ZqR7iWB0gKNoKq2Vmx7MtJRc3IeMqQ4iYYBCO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3EXQDCEvE+rlyhoh1y4OGmTiesFp43Pu4x8+aUF2i8FDGsJPsymclOK+Vtyfmcerna61yGikklnuy5rs9xgztqTS6eQFo3DceSh1cyxRHnTsZI6jF93RdI+Ov6k6NZeQAaaw4Rs4RGyRwyyNFHS0VfH22GIdbTe+moeW9dSNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOOwPDnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFA6C32782;
	Tue, 30 Jul 2024 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722366362;
	bh=kgqS2ZqR7iWB0gKNoKq2Vmx7MtJRc3IeMqQ4iYYBCO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOOwPDnGF7/sKuRqbaqy15zf9ElOWENrqUnQCHvo7ELxOvQ0+0mFRn9FM65+c8WvM
	 W+TAjnDAFvY7NyCDI0z4mAoYX/P5vLQhmwGGTpzC7/62wJr6uXbpQv9Wc2NOr44NHh
	 yfGayq+bW1ze7Cf8rk0kTbeQQFO8UXEia+cn6nSqCKn9zKpzHaeIWOEY26Qkmnicxq
	 zByY7WScQWWT0hQ+Rv7+jXn7vHkMtuggUq4M/EsqJ7vJaUSQwaAyS+Ph9nOGW98Ee8
	 +pJYwr6e1RQM4phKHDnFHMsTWH/+0289HUxyN82vnYWvO1cpDEL3Oh+SVdP0FZhkBo
	 F1NiOF0vKSPuA==
Date: Tue, 30 Jul 2024 20:05:59 +0100
From: Simon Horman <horms@kernel.org>
To: John Wang <wangzq.jn@gmail.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mctp: Consistent peer address handling in ioctl
 tag allocation
Message-ID: <20240730190559.GK1967603@kernel.org>
References: <20240730034031.87151-1-wangzhiqiang02@ieisystem.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730034031.87151-1-wangzhiqiang02@ieisystem.com>

On Tue, Jul 30, 2024 at 11:40:31AM +0800, John Wang wrote:
> When executing ioctl to allocate tags, if the peer address is 0,
> mctp_alloc_local_tag now replaces it with 0xff. However, during tag
> dropping, this replacement is not performed, potentially causing the key
> not to be dropped as expected.
> 
> Signed-off-by: John Wang <wangzhiqiang02@ieisystem.com>
> Change-Id: I9c75aa8aff4bc048dd3be563f7f50a6fb14dc028

Hi John,

This is not a full review, so I would recommend waiting for feedback
from others, but please:

1. Do not include the Change-Id as it is not obvious what public
   resource it references
2. As this is a fix targeted at net, please do include a Fixes tag,
   indicating the commit where this user-visible problem first
   manifested.

Also, as an aside, please wait 24h between posting updated patches.
Link: https://docs.kernel.org/process/maintainer-netdev.html

...

