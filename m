Return-Path: <netdev+bounces-94188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1EE8BE93E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D351C23C53
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528CA16F8F1;
	Tue,  7 May 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7hEx/ha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3FE16C842
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099568; cv=none; b=g/STdaEzZGkwl1zJpy9o3c2AbVWzINW+MdcgK+wjthBYLMR4y9K5i9JgsipV1hiY971jC/rEE7Q4pyy3sc/efwaqs1G0NH2rmldMczQBcOWWk1FFO542cbJP/szcZEuUmCS2jf9F4QL9Hz3dZqjuVYFJnp9dDu0SlixR6FJSOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099568; c=relaxed/simple;
	bh=qdUjpn8g1ZYCkPGqSK8F32oMmlGRWe9a08FJ3eVmSCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZxqdHeDvMExbBEJmabqhrkVUI/kwX4IbKrMoG3MOTMBRAJOBDkcajEPP6AbRPV9jmuzgeuH9oo+V8rBG7ub1ZH1W6SLbYTObAPCzyoVa8yWXdVXqGxFNGoqfzfgaeiXXDf8FP2RLYjsRf3WoXdvUIXHKCtJmCpY6DR9odr0Bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7hEx/ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A10DC2BBFC;
	Tue,  7 May 2024 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715099567;
	bh=qdUjpn8g1ZYCkPGqSK8F32oMmlGRWe9a08FJ3eVmSCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7hEx/ha+CHt0ySwxNis3rmILvgTVkKE+gCYa1/nzwRp6itG0+MhC62m2GewE9TFP
	 T2c3TdNb5ezO4aSCNIq70yILLfIxOeN3oVMw5m+R8sL2XgnoLRVlQUZlllvEyGvwPq
	 54FNbSdH2RV7JKTYuSXAmvMy1vgDv7rm4ugqOAdqJqDY+TSsOPz5kYs04+zTfLvx02
	 6m52zlw1QzLHpzBfZW3Yy2vzO4BN03TvsycFJvSn6gjR58YSbZHnMA9EIblHKH6zlX
	 cnFJwCwYM0Ala/MuFhXjl7y9xPRl5XMveNlpGa5aOzs9xMmX4E8DiFFlgD42HQbW4/
	 FiLUw+hQuJynA==
Date: Tue, 7 May 2024 17:32:43 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/8] rtnetlink: do not depend on RTNL for
 IFLA_TXQLEN output
Message-ID: <20240507163243.GD15955@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-4-edumazet@google.com>
 <20240505144334.GA67882@kernel.org>
 <89e0117a970a56bc2de521bbc6f13dfe03b33373.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89e0117a970a56bc2de521bbc6f13dfe03b33373.camel@redhat.com>

On Tue, May 07, 2024 at 11:26:10AM +0200, Paolo Abeni wrote:
> On Sun, 2024-05-05 at 15:43 +0100, Simon Horman wrote:
> > On Fri, May 03, 2024 at 07:20:54PM +0000, Eric Dumazet wrote:
> > > rtnl_fill_ifinfo() can read dev->tx_queue_len locklessly,
> > > granted we add corresponding READ_ONCE()/WRITE_ONCE() annotations.
> > > 
> > > Add missing READ_ONCE(dev->tx_queue_len) in teql_enqueue()
> > 
> > Hi Eric,
> > 
> > I am wondering if READ_ONCE(caifd->netdev->tx_queue_len)
> > is also missing from net/caif/caif_dev.c:transmit().
> 
> I agree such read is outside the rtnl lock and could use a READ_ONCE
> annotation. I think it's better to handle that as an eventual follow-up
> instead of blocking this series.

Yes, that is fine by me too.
And I am happy to add it to my TODO list if no one else wants to take it.

Reviewed-by: Simon Horman <horms@kernel.org>


