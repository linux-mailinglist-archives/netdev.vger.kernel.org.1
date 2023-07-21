Return-Path: <netdev+bounces-19915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8C75CCFA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2954728233D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D621ED49;
	Fri, 21 Jul 2023 16:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF81ED47
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDA6C433C7;
	Fri, 21 Jul 2023 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689955290;
	bh=PA8mIgj50fgfgrMmzr5lfjZFBWvQfHEld71JX4l0vVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApAy324Isd9NkMwHiREvXxaFH9gl3vLG53CvMG2D5xH2Qp1tl7DI+Vsm77Y077GXX
	 9o4KMZKE5dVK3YEWO0FxBiI971ZmKeEAGuzLxLrbitRq5DjKpfoVQ1p0tfitMnwU3g
	 M3kjLl9nwy0tPuDc8NJdUgmdJHBPyi79psylyw+gEvznThbSsxSGD+Ay6nh5ZzGHg+
	 pZ9tsTBH7mI8RDI+dTVM9ctjiXsVpdJR26EVxahTnhQcxtpxQe0jt9msdvMUBXnqJZ
	 lFLbtOd3ekcSfi4h8NS/Q7VpmnjhDii+aBVkaahbn9jKDIozAa2WfXR1wwbwC5e5a0
	 6dYEzHJBaUvrg==
Date: Fri, 21 Jul 2023 09:01:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Yunsheng Lin
 <linyunsheng@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle
 PP pages directly when in softirq
Message-ID: <20230721090129.4a61033b@kernel.org>
In-Reply-To: <ebd284ad-5fa9-2269-c40e-f385420b27c3@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
	<20230714170853.866018-10-aleksander.lobakin@intel.com>
	<20230718174042.67c02449@kernel.org>
	<d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
	<20230719135150.4da2f0ff@kernel.org>
	<48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
	<20230720101231.7a5ff6cd@kernel.org>
	<8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
	<20230720110027.4bd43ee7@kernel.org>
	<988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
	<b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
	<20230720122015.1e7efc21@kernel.org>
	<e542f6b5-4eea-5ac6-a034-47e9f92dbf7e@intel.com>
	<20230720124647.413363d5@kernel.org>
	<406885ee-8dd0-1654-ec13-914ed8986c24@huawei.com>
	<ebd284ad-5fa9-2269-c40e-f385420b27c3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 17:37:57 +0200 Alexander Lobakin wrote:
> > Does it mean ptr_ring_produce_any() is needed in
> > page_pool_recycle_in_ring() too?
> > 
> > As it is assumed that page pool API can be called in the context with
> > irqs_disabled() || in_hardirq(), and force recylcling happens in the
> > prt_ring.
> > 
> > Isn't it conflit with the below patch? as the below patch assume page
> > pool API can not be called in the context with irqs_disabled() || in_hardirq():
> > [PATCH net-next] page_pool: add a lockdep check for recycling in hardirq
> > 
> > Or am I missing something obvious here?  
> 
> No, Page Pool is *not* intended to be called when IRQs are disabled,
> hence the fix Jakub's posted in the separate thread.

Yeah, it's just a bandaid / compromise, since Olek really wants his
optimization and I really don't want to spend a month debugging
potential production crashes :)

On the ptr ring the use may still be incorrect but there is a spin lock
so things will explode in much more obvious way, if they do.

