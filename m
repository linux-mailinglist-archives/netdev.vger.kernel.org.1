Return-Path: <netdev+bounces-50081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D67F48C5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12C91C203DA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9658114;
	Wed, 22 Nov 2023 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a94F66wI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7455773
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEE5C433CD;
	Wed, 22 Nov 2023 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700662827;
	bh=ZYYZgyI2DXGvKGtY07DZARJ5jAFyBs+v1IdUtbspW28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a94F66wIqBLkbnRkxlrm/ntluay213U+DwwFOB6aH6PxK5CmNsTDL1KH9yMfuLI1v
	 Wtv168XQCgTqH3NknA1AeUskNUa+w81NYsJanAYCORGbNDVU7FQVntWXQaaAjnW4Ri
	 A4lAJ31BJWVO0TYEZE3eOYqa9tLffWTuCU+04guLPq3pLoN1h0YTE98BieEVqAzp17
	 PGpfDFZwR2HazygxWV+My/ZVDVxZyRcJDHapyW1cLlgWuBs2fm3b7HpgRPQZ51wDct
	 GxBKfYHLGJTbGJxVg1wvZyJzVg1prDRAag6EwKA/ncO0LR6NpxaONqitrvcH2+r95g
	 LNPlgUS0HQKYA==
Message-ID: <40025e46-c631-40e7-a3e4-49c77bdb141f@kernel.org>
Date: Wed, 22 Nov 2023 15:20:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/13] net: page_pool: record pools per netdev
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-4-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Link the page pools with netdevs. This needs to be netns compatible
> so we have two options. Either we record the pools per netns and
> have to worry about moving them as the netdev gets moved.
> Or we record them directly on the netdev so they move with the netdev
> without any extra work.
> 
> Implement the latter option. Since pools may outlast netdev we need
> a place to store orphans. In time honored tradition use loopback
> for this purpose.
> 
> Reviewed-by: Mina Almasry<almasrymina@google.com>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
> v1: fix race between page pool and netdev disappearing (Simon)
> ---
>   include/linux/list.h          | 20 ++++++++
>   include/linux/netdevice.h     |  4 ++
>   include/linux/poison.h        |  2 +
>   include/net/page_pool/types.h |  4 ++
>   net/core/page_pool_user.c     | 90 +++++++++++++++++++++++++++++++++++
>   5 files changed, 120 insertions(+)

I like it :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

