Return-Path: <netdev+bounces-24151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F476EFC9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E505D2822AA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B624195;
	Thu,  3 Aug 2023 16:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18818B0D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D4AC433C9;
	Thu,  3 Aug 2023 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691080845;
	bh=NI7M5nVqns/TurmJFFwI2aLoffncxbg++s5EmED6FKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n950stocTOkG/lu8Iqr01otzxmPUTEOAgv64Sn+oeSUMtsX3XOdIEa6AyHwLjj+jT
	 az3VJpROPtBv+8OfVefo6HqNM+rr0276yPcLuCx5TWrha6G83e0lvrhR9yq452qQzC
	 jtXOPYugCqLwEvYnJFAEqkoF1io04AQFTRrGv67vJCXHWZh9eOrDQ8hql5b7oMZ+pK
	 JWjTWxgl9GycYlB9TVcFC2hcS5snq2HtPUPeXYkSygC6Bh7QF0S+x4JrF+Td0zyjQf
	 wJDV2bRnXKB5u7kDfLEKlBopJvvyQm2ffCjGto30uFlGxwFLhB/jKsM4nKHNCgQMZi
	 9eBzDYfaUUkZQ==
Date: Thu, 3 Aug 2023 09:40:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Simon Horman
 <simon.horman@corigine.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags
 field directly
Message-ID: <20230803094043.31d27cb5@kernel.org>
In-Reply-To: <7c1c6ec2-90cb-84e0-1bc3-cf758f15e384@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
	<20230727144336.1646454-6-aleksander.lobakin@intel.com>
	<a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
	<6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
	<a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
	<0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
	<20230802142920.4a777079@kernel.org>
	<7b77dd3a-fd03-884a-8b8a-f76ab6de5691@intel.com>
	<20230803090029.16a6798d@kernel.org>
	<7c1c6ec2-90cb-84e0-1bc3-cf758f15e384@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 18:07:23 +0200 Alexander Lobakin wrote:
> >> I would propose to include it in the series, but it has grown a bunch
> >> already and it's better to do that later separately :s  
> > 
> > Yeah.. I'd be trying to split your series up a little to make progress
> > rather than add more things :( I was going to suggest that you post
> > just the first 3 patches for instance. Should be an easy merge.  
> 
> One minute before I was going to post v2 :>
> Sounds good. AFACS only #4-6 are still under question (not for me tho
> :D), let me move that piece out.

FWIW I'll apply my doc changes in the next 5min if nobody objects.
Can you rebase on top of that?

