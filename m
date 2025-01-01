Return-Path: <netdev+bounces-154643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D89FF2AA
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 01:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDD93A2E36
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21371FA4;
	Wed,  1 Jan 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVvQSp0W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD2366
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735692122; cv=none; b=NG/qQfaIFGZDEN0w/Lq182rA1iAlut/WF2iW0N+lvDuUdbzycdiKevpg3YOTkUMSc4F4pZ+E2rJ1WDT/q3CDsnh2cqnu4heUEnJ/08cccgW3VVWGiAkYsQbYybHeYhB1J0Jn2LKSq2gu9NwWcQN9Y2p6mvTbG6BkpwrmaiwTgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735692122; c=relaxed/simple;
	bh=Rxzn41NWH+o9X/E5aYIW+SRs3jvyU7BqhmOy8qIcoMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKbBIaahU/HYIhAKCd7Jg2BgNh0EjPnZIc9Jwj2bEayUQue3cpT4VjbGbCLH0DsOxIJW3yb653o6BhyWnqH1gwH9+sIYbx/ddqASu5gdSFPZKUb39C4AEKK0KmbujQmVMvdUhY4Tg/NandcyjBQMeuaPoaXKo3hM9ibEJlCrVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVvQSp0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A50C4CED2;
	Wed,  1 Jan 2025 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735692122;
	bh=Rxzn41NWH+o9X/E5aYIW+SRs3jvyU7BqhmOy8qIcoMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVvQSp0WOSzypqUJdCHbT9n+ohZfeVZQqA7pYh05xyYWPXzbszAxshYLcCNKXTvRs
	 tRYZM7iSNIp8s8kuxOZ+CxvHkhl8v2IjocuB7LMXv0TAWzyNqMmnHUYCmuY6p9/dyR
	 T01vXYnN7HIlOvUk2ClZPfYF0y9FJTD8JxATTPw1j4TQaOwucqIaX+uw+L2Plo8ros
	 WKavjj8Lyw0io+hhF3eXWWBKeFzURI9ecdppyfpy6tK256//gZBea80ruIRYBG+AwF
	 vsoAecyDx5NVO1YU1j1Nq4b+snserg4b0W4nYca9CqRwOvbfmS6cdmvlEvx7/cvU5b
	 NgMkwQ8lv8DTg==
Date: Tue, 31 Dec 2024 16:42:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: John Daley <johndale@cisco.com>, <benve@cisco.com>,
 <satishkh@cisco.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next v3 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
Message-ID: <20241231164200.3364e18b@kernel.org>
In-Reply-To: <731d74c2-7cc6-4d60-a2a4-c451d399e442@huawei.com>
References: <20241228001055.12707-1-johndale@cisco.com>
	<20241228001055.12707-5-johndale@cisco.com>
	<ef5266a0-6d7a-4327-be7c-11f46f8d1074@huawei.com>
	<20241230084449.545b746f@kernel.org>
	<731d74c2-7cc6-4d60-a2a4-c451d399e442@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Dec 2024 19:37:12 +0800 Yunsheng Lin wrote:
> >> It seems the above has a similar problem of not using
> >> page_pool_put_full_page() when page_pool_dev_alloc() API is used and
> >> page_pool is created with PP_FLAG_DMA_SYNC_DEV flags.
> >>
> >> It seems like a common mistake that a WARN_ON might be needed to catch
> >> this kind of problem.  
> > 
> > Agreed. Maybe also add an alias to page_pool_put_full_page() called
> > something like page_pool_dev_put_page() to correspond to the alloc
> > call? I suspect people don't understand the internals and "releasing
> > full page" feels wrong when they only allocated a portion..  
> 
> Yes, I guess so too.
> But as all the alloc APIs have the 'dev' version of API:
> page_pool_dev_alloc
> page_pool_dev_alloc_frag
> page_pool_dev_alloc_pages
> page_pool_dev_alloc_va
> 
> Only adding 'dev' does not seem to clear the confusion from API naming
> perspective.

page_pool_free_page()? We already have page_pool_free_va()

