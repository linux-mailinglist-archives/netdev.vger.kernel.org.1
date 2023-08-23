Return-Path: <netdev+bounces-29892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB16785140
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A652811DE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9C58820;
	Wed, 23 Aug 2023 07:14:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FB20EE3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79648C433C7;
	Wed, 23 Aug 2023 07:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692774861;
	bh=O0CSLKPWiPjT6f8HB7qUcvjKEmbNq0QtPMkBdTDoUak=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=m7PY2gVi/oTNTQkiuFRqfZst5KkS6WVEftyJXiqfBonMyxTg+r77Rp5qqljP5q/x1
	 issCCRPaoqzRL+NniYqSr0oZRXJGm4pWxB6VQxVjaC/C2Ae1GOLkoHRhnm6tms2XoK
	 bvQ+/dPj/aCfbMMkkppVQXpzXvPzZxZftW61ZvvQbnbnf6on5AiGhTFzqjx6g8Nukn
	 PFCUaTQynSGm8sH2i1EjJA9DUkx4gn0fydn8IoFKpoSzTYdbAS7zGdiLoB5ZWIQpAo
	 hyDjXufaX1bpPEeop5MivvKYFOUBv3iZKz9gw3riIKdea0m0SMZ6jgJh19rceLu/dS
	 vhseGGdzpgfgQ==
Message-ID: <24f2dd3e-fb00-894b-0cdc-4ad1e4345a06@kernel.org>
Date: Wed, 23 Aug 2023 09:14:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
 linyunsheng@huawei.com, Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2 net] octeontx2-pf: fix page_pool creation fail for
 rings > 32k
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230823025325.2499289-1-rkannoth@marvell.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230823025325.2499289-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/08/2023 04.53, Ratheesh Kannoth wrote:
> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned down
> over time as working sets varies, due to the recycling nature
> of page pool, given page pool (currently) don't have a shrinker
> mechanism, the pages remain pinned down in ptr_ring.
> Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory.
> 
> This have been tested on octeontx2 CN10KA hardware.
> TCP and UDP tests using iperf shows no performance regressions.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Suggested-by: Alexander Lobakin<aleksander.lobakin@intel.com>
> Reviewed-by: Sunil Goutham<sgoutham@marvell.com>
> Signed-off-by: Ratheesh Kannoth<rkannoth@marvell.com>

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

