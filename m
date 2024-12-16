Return-Path: <netdev+bounces-152334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3C9F375F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B2C1882DB5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E365204F8B;
	Mon, 16 Dec 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl/E7J5W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC28204C03
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369483; cv=none; b=Vw28eIIL9+/XAwamfI9PCcHMbgn7ad8aZuseU3dzF7KfHudN1htxRrPNDfXeY+4SNsk8Eaqp9rnrr6VK3yVK2uS6C6qWr/EQdXHZx/eZwrOx4pUv30ZSzQ04/oQuq21CdWEV8jUXS+rST50B6A8f35rsHs6RscmOL57hPeZYrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369483; c=relaxed/simple;
	bh=CB0UWCuuolqxNwUndk9Sz/WuskV7824SRH3BDYarDVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpzVVFAsEcjCznrd448XtmZ4GNnash0mX/u5+mBPeFOOnzZyjqczRx2lhNdxj+0szVaUF5AzYOV5ZSQjoI9gto379nFKh9JjshlG0XG30i7x7qXhmSmJ0QBPSG6akf1SzsizAQn9Cg+dracMqO/8rOLTYZqoEZ+7PDVTorP0jvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl/E7J5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2CFC4CED0;
	Mon, 16 Dec 2024 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369483;
	bh=CB0UWCuuolqxNwUndk9Sz/WuskV7824SRH3BDYarDVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nl/E7J5WQ+rKnhRTsDiAIfvkWcivo4gGOhTJTmxj+uJVqPVRaKHh+BGhOhGIkpT4G
	 1ZaeACMhNr+cQ246VwYNKQ6zYz+5FK+7MGW8yf7wSk+SfigE2Vh6ZxqouNl151eqUH
	 ksulULQsOvH+OZFVQbbIdn1/viruPI+Lk7DXe8zoyf/ptHyUpE4FgA8jHmoMHs+jJT
	 wUqeBfargZB6q4g3HoI3azGdTN+VWJNkypWrTDxZ7AS635k+JLuJ0dmORiOStgv/G4
	 TDDJwJwZqUdGZs7pRr1L+xXY/LsEzFma0elOB7A5y9mUD8ZpzsqhNcoJTGUoCHO9Em
	 9ZrgnfQivE9Wg==
Date: Mon, 16 Dec 2024 17:17:59 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net: netdevsim: fix nsim_pp_hold_write()
Message-ID: <20241216171759.GJ780307@kernel.org>
References: <20241216083703.1859921-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216083703.1859921-1-edumazet@google.com>

On Mon, Dec 16, 2024 at 08:37:03AM +0000, Eric Dumazet wrote:
> nsim_pp_hold_write() has two problems:
> 
> 1) It may return with rtnl held, as found by syzbot.
> 
> 2) Its return value does not propagate an error if any.
> 
> Fixes: 1580cbcbfe77 ("net: netdevsim: add some fake page pool use")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


