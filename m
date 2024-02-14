Return-Path: <netdev+bounces-71600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49AF8541B5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 04:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6D728D824
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8088BFA;
	Wed, 14 Feb 2024 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osrzGrBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980F2F2E
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707880423; cv=none; b=Kjy929qo5DjVYH3HTPH7xvTXwJmM1+PAchiLn5KCNoxPcvYzIORzxWeVNaZ4ge71zJUF1FvkLYWUisr7aAOidVJr3s0ffsQqEAYLDQAzQbO0A4kWtrbFHXhK6YDb2eX+mz6Bo6xztuRZ8dnbt9nA18A1Ki3aPFmopstY9VTkdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707880423; c=relaxed/simple;
	bh=wOvkf1Aw0FRr7YTzhLHcxFZEAcOE1Yw4LLnTnEQXT/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKrtXYNre9dFD0Ko0BKmEVPnhgRkJvbxeSzrEuljWDCIcLvGAGXsm8RELm/UXJY5CEWrXfZuuP8kImNdPQF3gdyo4q48LWO6OoqXEXmWtFpjcM4R/1rsQI6J54wHY213DCRRVU/yhdtja7e+o4cAp2vREgm8cjIWRlWTQ1DfRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osrzGrBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE1BC433F1;
	Wed, 14 Feb 2024 03:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707880422;
	bh=wOvkf1Aw0FRr7YTzhLHcxFZEAcOE1Yw4LLnTnEQXT/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=osrzGrBAYU9tMlIefVDEDHuSmT+Rw9UQxdOFsvtb0TQmYj20Zc0WDt1pQL03V8yeR
	 sq/3nOZDz060l7Gn1UwxYXvOW11OvzK2dcuRC1ZW6I05VxAMMgNTZV0lRBn1TJmODT
	 KptoZgSTeDD/7xS0rJgbQzqB5af95O+TnxKadBftFdWK3mYttYwbT73/tYmf4mTcQI
	 P80ZFMxTjMPjVDl+kvN0uZPgq1PvBmhnZ9KlZVqaYK6X5XarbGclh2HpCRdM6e4Rl1
	 7rv8iv6U0Y2eHj8t5JGZ1LEHleLXpgZ7xXrEqsjZ9Ug2Q9ksdStSjJKC8WCRMKc0nd
	 ojLS8e2RMOPVA==
Date: Tue, 13 Feb 2024 19:13:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: cache for same cpu skb_attempt_defer_free
Message-ID: <20240213191341.3370a443@kernel.org>
In-Reply-To: <457b4869-8f35-4619-8807-f79fc0122313@gmail.com>
References: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
	<CANn89iJBQLv7JKq5OUYu7gv2y9nh4HOFmG_N7g1S1fVfbn=-uA@mail.gmail.com>
	<457b4869-8f35-4619-8807-f79fc0122313@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 14:07:24 +0000 Pavel Begunkov wrote:
> >> +       local_bh_disable();
> >> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);  
> > 
> > I am trying to understand why we use false instead of true here ?
> > Or if you prefer:
> > local_bh_disable();
> > __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> > local_bh_enable();  

FWIW I had the same reaction. napi_safe = false followed by
napi_skb_cache_put() looks sus. No argument that naming is bad,
not the first time it comes up :(

> Maybe it's my misunderstanding but disabled bh != "napi safe",
> e.g. the napi_struct we're interested in might be scheduled for
> another CPU. Which is also why "napi" prefix in percpu
> napi_alloc_cache sounds a bit misleading to me.

FWIW the skb recycling is called napi_* to hint to driver authors that
if they are in NAPI context this is a better function to call.

The connection to a particular NAPI instance matters only for the page
pool recycling, but that's handled. The conditions you actually
need to look out for are hardware IRQs and whatever async paths which
can trigger trigger while NAPI is half way thru touching the cache of
the local CPU.

> The second reason is that it shouldn't change anything
> performance wise
> 
> napi_pp_put_page(napi_safe) {
>      ...
>      if (napi_safe || in_softirq()) { ... }
> }

