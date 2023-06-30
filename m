Return-Path: <netdev+bounces-14885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F14DB744502
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 01:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279351C20C50
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 23:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C178AD21;
	Fri, 30 Jun 2023 23:07:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D58820
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 23:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1C9C433C7;
	Fri, 30 Jun 2023 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688166431;
	bh=o6g1YaJ7IlyesmEPVEtYQGumrFRi+iUxjc0/yz70OEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c5uPkr2FbfSUpE3irdBJm005zptRRLLlQQ03fhh6tyu1yZwId6K/VgXNdsJFLXkE0
	 J1sqn7tDXJ4LNg+qkflfApuB3ryaWxDpcfaUIbx8m3wTMOR8LYEvHMlfQ6ZA5944Rf
	 kn44eqGIYKp6WtSPAL1JcIuB5UXoXS0qZefbiaAlX8PD50lcqg/YMiXEnCQimj0zIB
	 wETTV1LIVIfB1asDWS/8cKXgkEkcr51Vmd1n4JQd/EbaDQhblD5tzabbNsXPf3kGK3
	 WP4dnvaN1dKKAd2HM782jGyjxu3CYcFO/xiLZHp9p9Ev7OCfyw/HyqQvAG4R6FBTUx
	 kRu/+vsizVdEA==
Date: Fri, 30 Jun 2023 16:07:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: ilias.apalodimas@linaro.org, hawk@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linyunsheng@huawei.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool
 case
Message-ID: <20230630160709.45ea4faa@kernel.org>
In-Reply-To: <20230628121150.47778-1-liangchen.linux@gmail.com>
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 20:11:50 +0800 Liang Chen wrote:
> +static inline void page_pool_page_ref(struct page *page)
> +{
> +	struct page *head_page = compound_head(page);
> +
> +	if (page_pool_is_pp_page(head_page) &&
> +			page_pool_is_pp_page_frag(head_page))
> +		atomic_long_inc(&head_page->pp_frag_count);
> +	else
> +		get_page(head_page);

AFAICT this is not correct, you cannot take an extra *pp* reference 
on a pp page, unless it is a frag. If the @to skb is a pp skb (and it
must be, if we get here) we will have two skbs with pp_recycle = 1.
Which means if they both get freed at the same time they will both
try to return / release the page.

I haven't looked at Yunsheng's v5 yet, but that's why I was asking 
to rename the pp_frag_count to pp_ref_count. pp_frag_count is a true
refcount (rather than skb->pp_recycle acting as a poor man's single
shot refcount), so in case of frag'd pages / after Yunsheng's work
we will be able to take new refs.

Long story short please wait until Yunsheng's changes are finalized.

