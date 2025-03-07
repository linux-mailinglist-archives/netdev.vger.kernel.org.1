Return-Path: <netdev+bounces-173108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB830A57621
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4F3189B4CA
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00551DC99A;
	Fri,  7 Mar 2025 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq14szCk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86501A8F97;
	Fri,  7 Mar 2025 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390406; cv=none; b=FL/BM4gV3Pq3d9IlU83yY3RRjLAHAf3q3Tndp9zMyGu8Zf+z4/r0TT027R936tCbRkQbbmMM1T3jWde7Pd/YbuAJdyZrhgwZVEK+DSgHC0Z9OdJ+icxKSAd3RpI9zmN6PKeqIGFymBrmH0WGku6X42RACElUmfh753RP0YyZTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390406; c=relaxed/simple;
	bh=7+Ff22c+DevX/gLTdP8NXs3wDoyTUVuK/5dB170e1Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G70uTexszkrwdclLwnN3xT6Jc/dVcwIaAW76TkPRjP0KM0GW6axUCqrUeAkoI07ju2vZT5ecYv3irv/B6M6v1wckGhv3AhxSHc6+j19LzC0WjFLn1GClMLXYPOlob0tiTuiF22BGH+eRUPu8xS1Vi74eVth7odrxJ1RzIyTySZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq14szCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA89C4CED1;
	Fri,  7 Mar 2025 23:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390406;
	bh=7+Ff22c+DevX/gLTdP8NXs3wDoyTUVuK/5dB170e1Ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fq14szCk6x6wZonGyAuNnX7pde1D8Qh8UzhlHstBVqi7tlhiBsYUoBY4JBwdciRYp
	 Ifk/CQBxMWsQUtvYwYOt/cBSAkT78PDEsvvpY984pjuu2oQYGEx5B6lTYXUEB/Q7pI
	 599nul+OpzL3sXeqU8OSXhrBEEDxp7Y6hJBhvJx3E/LD/H+Iluex/z4t+p346iEddh
	 /pmK9UeEJhhbMmbF4H+hadtUQyhg5FSKgg4FURsX6lL81os/+8T+Q5/ghADnheCnHl
	 yelxFLXfZxOSMeNherLcwByrik54nGNeID+2gJOB5ptmnBzwK48X8LF6GGPgOjGj7e
	 8EJcTAj+PZ3rg==
Date: Fri, 7 Mar 2025 15:33:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, horms@kernel.org, donald.hunter@gmail.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, jdamato@fastly.com, xuanzhuo@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
Message-ID: <20250307153324.6274d305@kernel.org>
In-Reply-To: <Z8tKe5O7ICE3xK80@mini-arch>
References: <20250307155725.219009-1-sdf@fomichev.me>
	<20250307155725.219009-4-sdf@fomichev.me>
	<20250307095049.39cba053@kernel.org>
	<Z8tKe5O7ICE3xK80@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 11:35:23 -0800 Stanislav Fomichev wrote:
> On 03/07, Jakub Kicinski wrote:
> > On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:  
> > > As we move away from rtnl_lock for queue ops, introduce
> > > per-netdev_nl_sock lock.  
> > 
> > What is it protecting?  
> 
> The 'bindings' field of the netlink socket:
> 
> struct netdev_nl_sock {
>        struct mutex lock;
>        struct list_head bindings; <<<
> };
> 
> I'm assuming it's totally valid to have several bindings per socket?

Totally, sorry, I got confused by there being two xarrays.
Lock on the socket state makes sense.

