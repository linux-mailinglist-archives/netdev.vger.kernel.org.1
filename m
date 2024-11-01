Return-Path: <netdev+bounces-140872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159169B887A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB15B21C28
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BD941C94;
	Fri,  1 Nov 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcXoHLfr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358522097;
	Fri,  1 Nov 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424539; cv=none; b=HEOHOj9ggjS8RPRPew6D/FFxip+MpRJc5ozgRrqi9bxw1EYVVTfqo91g+TPMjCHmWfmUt3cQYNMd7V3XBnUuWvfFsYcLm3bKxfvyX8GtTrMvbBWF6pJ5LUcAWh7lThzwgAibpTFRgHqoWdyqfWDG1wuRBQb21SKJK6P7DrQW+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424539; c=relaxed/simple;
	bh=Ro2wOnPsRBt1diTGU2M/zs+SVAUDM/F0zIV7WcyhoOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pf4PZ5NIdx5aOM9ssc3xox7a5H38uYBh6bG5XNWOm+Wf76HWYKssVv1/mlDGOozl79UHCntPUZxs7dkQY0vU3DAIQsimn/9EnOv2Uit77MUy2WKSLcoaKGlXtBl4FGTbp/uC5keiH5mH+CqcLnzQ2mk5xvUdp/SVt0oAvpacTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcXoHLfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5884FC4CEC3;
	Fri,  1 Nov 2024 01:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424539;
	bh=Ro2wOnPsRBt1diTGU2M/zs+SVAUDM/F0zIV7WcyhoOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RcXoHLfrE4SHFihNod53epyWLW6w0+i/KjDQeTCK6ybU5wXh40KCO6DTH15306zza
	 LDuTQ8a+w280Q6vfB+lJVnbnwm3pfDqWQwteSgEfyDf5WpFcQgC6dqTALen/MqPZ7j
	 5BOmLI09f1+knZEyZweyOQIP4FUEc29qGKfJeRKJj9lug7Syax1zixlO87daGq6OYu
	 qmbWCr2R3JWdM1gqFGPMKcGZSxilJYjm+wIQVle4uIwKtxoif0RwmfsDKmHM3U7AJ9
	 5GWKKFcv5Dzjb7qTjjXAcy5KsIUPg0zd5mts4bnWOi/Nmrm8v0ne4zqtCcdUPKxMAS
	 sj5oPd56PAp2w==
Date: Thu, 31 Oct 2024 18:28:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com, kernel-team@meta.com, jiri@resnulli.us, jv@jvosburgh.net,
 andy@greyhouse.net, aehkn@xenhub.one, Rik van Riel <riel@surriel.com>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 2/3] net: netpoll: Individualize the skb pool
Message-ID: <20241031182857.68d41c6f@kernel.org>
In-Reply-To: <20241025142025.3558051-3-leitao@debian.org>
References: <20241025142025.3558051-1-leitao@debian.org>
	<20241025142025.3558051-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 07:20:19 -0700 Breno Leitao wrote:
> The current implementation of the netpoll system uses a global skb pool,
> which can lead to inefficient memory usage and waste when targets are
> disabled or no longer in use.
> 
> This can result in a significant amount of memory being unnecessarily
> allocated and retained, potentially causing performance issues and
> limiting the availability of resources for other system components.
> 
> Modify the netpoll system to assign a skb pool to each target instead of
> using a global one.
> 
> This approach allows for more fine-grained control over memory
> allocation and deallocation, ensuring that resources are only allocated
> and retained as needed.

If memory consumption is a concern then having n pools for n targets
rather than one seems even worse? 

Is it not better to flush the pool when last target gets disabled?

