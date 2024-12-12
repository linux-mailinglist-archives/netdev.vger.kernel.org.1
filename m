Return-Path: <netdev+bounces-151262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA759EDCD3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 01:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6021889096
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177C15E8B;
	Thu, 12 Dec 2024 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZpoze4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9A3BB24
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964523; cv=none; b=Up7mNhZZ418g2Si/kArzasMAicpED28yH1OPhyy5Zllct/7cIJdCtgKiaYIP3W+k8c3pCOA8+UxORPGUSvpbam6DlOjR1uF8vR66lp3OoejJ74PirM/hl34sSpZj6YQ4SDDhNk/DFdTOqA/8VJFMChuHSSINvdpdDiV+Z54Yi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964523; c=relaxed/simple;
	bh=Op/xrUFMq7xJCV6WqNKzSaIcz+vzYF0vnclFUAlvzJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cl9DTVYs/Cdj3nLaaRcR2OT5udkjpU7r5Y7yrjNGWOnh4FSSRVXDJfEF9P4HW/GXM3I72ytZ8N+Pk4/IoH7sSdj45EbgppPukgAUUiAQjT/Y4k96TXwixQwHytXGvq34EsFNrNF3dikuCjVfrBCB0VNAb6tmYh850uxpygHJBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZpoze4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9C6C4CED2;
	Thu, 12 Dec 2024 00:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733964523;
	bh=Op/xrUFMq7xJCV6WqNKzSaIcz+vzYF0vnclFUAlvzJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aZpoze4iStlTwICIMGG4OWzMi0UQG9QdgYNx3As2raDfTJZVDvVAhYSEMdb0f7jDo
	 Kj0YWuMil2Sg4xT0ZK0RNa/ne2flzLh7ROyMG87xctu5kq7y2WrcWtltZvwarMlzeb
	 xymRTk6HMZaSHSUmIzPO2+LJ2p1EPeQgJuWoTMnNXTA17yVoiplrOdri8kOXKfKeqM
	 tEwUa8RpgrFlTV9ClCm00pyKFRkFC05+CoVn0s6Oy3R5XZ0WLsovSBIf6zQwcc2Kcs
	 DdjqekfUHpb0C3NV0rVOkHHXF0UYUr8SM54fBVmdSs6RSgnS9qczlXCn0dk6vwTVVk
	 tI4fssATCn06Q==
Date: Wed, 11 Dec 2024 16:48:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: David Wei <dw@davidwei.uk>, Yunsheng Lin <linyunsheng@huawei.com>,
 netdev@vger.kernel.org, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Message-ID: <20241211164841.44cba0ad@kernel.org>
In-Reply-To: <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
	<20241204041022.56512-4-dw@davidwei.uk>
	<9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
	<0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
	<a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
	<fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
	<CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 09:11:55 -0800 Michael Chan wrote:
> > At the time I just wanted something to work, and not having
> > napi_enable/disable() made it work. :) Looking back though it does seem
> > odd, so I'll try putting it back.  
> 
> Yeah, I think it makes sense to add napi_disable().

+1, TBH I'm not sure how we avoid hitting the warning which checks
if NAPI is "scheduled" in page_pool_disable_direct_recycling().

But, Yunsheng, I hope it is clear that the sync RCU is needed even 
if driver disables NAPI for the reconfiguration. Unless you see a
RCU sync in napi_disable() / napi_enable()..

