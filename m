Return-Path: <netdev+bounces-47227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9517E8F73
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 11:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591381C20361
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC38B53A1;
	Sun, 12 Nov 2023 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiN7kx+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD37468
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 10:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16090C433C7;
	Sun, 12 Nov 2023 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699784061;
	bh=XppWsVok4VbmgTSQclZ+NH9ECPSAE17ODB2eGqs9ZOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiN7kx+He2HcdPB27YNq9N3K7JXJu8KvTwkQ2G/DRnbemV8nYNQuuO72PghM+rn/T
	 pP6N9//XOywhtTfms1Lc0QxnPXOR4jemgyl10RFEDlDHzPvu5CECZsH9d+Paw2ET6S
	 uHKZC8JJyC0wv9j/Yi6vgtGgazMw4CzOL4pU1YofZyr3XRqKsFmzc4kySyM17VO6JT
	 sDS63MvtleG+Wl8/xWYyoRM+r3xoaykwdGxeXqkDkVez9S1B9UOesHytgWM6N0tl0I
	 lVih6B6vXc1+fehjkxRjxC9Plo1i0MmLkIhrdI3pt5/EYn4Q8JKBPAdrVdoPhH+4zu
	 RpH6MX3m21fiQ==
Date: Sun, 12 Nov 2023 10:14:11 +0000
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: gso_test: support CONFIG_MAX_SKB_FRAGS up to 45
Message-ID: <20231112101411.GI705326@kernel.org>
References: <20231110153630.161171-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110153630.161171-1-willemdebruijn.kernel@gmail.com>

On Fri, Nov 10, 2023 at 10:36:00AM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The test allocs a single page to hold all the frag_list skbs. This
> is insufficient on kernels with CONFIG_MAX_SKB_FRAGS=45, due to the
> increased skb_shared_info frags[] array length.
> 
>         gso_test_func: ASSERTION FAILED at net/core/gso_test.c:210
>         Expected alloc_size <= ((1UL) << 12), but
>             alloc_size == 5075 (0x13d3)
>             ((1UL) << 12) == 4096 (0x1000)
> 
> Simplify the logic. Just allocate a page for each frag_list skb.
> 
> Fixes: 4688ecb1385f ("net: expand skb_segment unit test with frag_list coverage")
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Thanks Willem,

I agree that the logic does as described,
that it should resolve the flagged problem,
and that as a bonus it is a nice simplification.

Reviewed-by: Simon Horman <horms@kernel.org>

