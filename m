Return-Path: <netdev+bounces-141148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8639B9C15
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 03:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AD82823E8
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC8D53C;
	Sat,  2 Nov 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epggiZIH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117D33F9;
	Sat,  2 Nov 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730512863; cv=none; b=Xr/IdQS1SD0k5M0+1ha91WKa4LfFdmbeyJ9GS1QgHZ7oNfJIz5F+GeGq2Q/nxC5EgV0PiTUabWu2GA3JKYoexq+VJDecfy9uV0sws3y7JAhFuNFi1MZCYcwuXjN5jlOKoc9EKOriDVwISxKJBW2MoOyd+MJFFbM7z8z4vwv7WUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730512863; c=relaxed/simple;
	bh=vfMmnspn0jW6b2YuG/NWO0vXzBSdbpyucoVUu0lgC2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/9lSI3OMobb+8gkVxDHwIszar0Imau09htfHP3UF3z2UJ/fyIpzTYcWkLORy0IL8KmUcF4g1F/ZgJL80h0Wm4vx9X7Fo23Eb5XP4/uRDxwSDGxITJuseX540hrXTv/hE2zqivhIftzP6ydBkoo+0SxatN7iJ6ziGMNV7b0DoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epggiZIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70C4C4CECD;
	Sat,  2 Nov 2024 02:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730512863;
	bh=vfMmnspn0jW6b2YuG/NWO0vXzBSdbpyucoVUu0lgC2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epggiZIHPB7GUtULmd6R0zoVlVAvKfkeRPIa3h/J7WBHOqg+Hmd8s1G7f5Zuytbco
	 EBriMCvWDH2zO+IbWGSzLP2am2KdTtij2IQTIoenTNcyk+/nXY4IfSYiYGTBcwk/1Y
	 IbyzR3atnv2o1geyuhHFEB64gUY4HefLOQet+3ouIBIPr/XJPxRG4gkD4qiK4jqLIW
	 vXe+XJTEUJq7l6mVu9F5taPLwRuJQElMf6K9DEFVA+fpkfzYrz2MUw20MCb8iTrdE3
	 wz/3WJGEoasEw99QM4UZpGopNgwg9/J7rLHDgj5XYVjFPfA/VeRn3L+Cl72eFYt+lo
	 xHLV3SBMZPkPA==
Date: Fri, 1 Nov 2024 19:01:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com, kernel-team@meta.com, jiri@resnulli.us, jv@jvosburgh.net,
 andy@greyhouse.net, aehkn@xenhub.one, Rik van Riel <riel@surriel.com>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241101190101.4a2b765f@kernel.org>
In-Reply-To: <20241101-prompt-carrot-hare-ff2aaa@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
	<20241025142025.3558051-2-leitao@debian.org>
	<20241031182647.3fbb2ac4@kernel.org>
	<20241101-cheerful-pretty-wapiti-d5f69e@leitao>
	<20241101-prompt-carrot-hare-ff2aaa@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 11:18:29 -0700 Breno Leitao wrote:
> > I think that a best mechanism might be something like:
> > 
> >  * If find_skb() needs to consume from the pool (which is rare, only
> > when alloc_skb() fails), raise workthread that tries to repopulate the
> > pool in the background. 
> > 
> >  * Eventually avoid alloc_skb() first, and getting directly from the
> >    pool first, if the pool is depleted, try to alloc_skb(GPF_ATOMIC).
> >    This might make the code faster, but, I don't have data yet.  
> 
> I've hacked this case (getting the skb from the pool first and refilling
> it on a workqueue) today, and the performance is expressive.
> 
> I've tested sending 2k messages, and meassured the time it takes to
> run `netpoll_send_udp`, which is the critical function in netpoll.

The purpose of the pool is to have a reserve in case of OOM, AFAIU.
We may speed things up by taking the allocations out of line but
we risk the pool being empty when we really need it.

