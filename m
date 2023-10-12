Return-Path: <netdev+bounces-40368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D97C6F1B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C7D282A8C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC82940F;
	Thu, 12 Oct 2023 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7128DC1;
	Thu, 12 Oct 2023 13:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39833C433C8;
	Thu, 12 Oct 2023 13:25:03 +0000 (UTC)
Message-ID: <e16ac0a4-3e4a-4e8c-98ba-7b600a8c6768@linux-m68k.org>
Date: Thu, 12 Oct 2023 23:25:00 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Content-Language: en-US
To: Michael Schmitz <schmitzmic@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
 netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
References: <20231009074121.219686-1-hch@lst.de>
 <20231009074121.219686-6-hch@lst.de>
 <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com>
 <0299895c-24a5-4bd4-b7a4-dc50cc21e3d8@linux-m68k.org>
 <20231011055213.GA1131@lst.de>
 <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org>
 <12c7b0db-938c-9ca4-7861-dd703a83389a@gmail.com>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <12c7b0db-938c-9ca4-7861-dd703a83389a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 12/10/23 04:21, Michael Schmitz wrote:
> Hi Greg,
> 
> On 12/10/23 02:09, Greg Ungerer wrote:
>>
>> I think this needs to be CONFIG_COLDFIRE is set and none of CONFIG_HAVE_CACHE_CB or
>> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set.
>>
>>
>>
>>> in the fec driver do the alloc_noncoherent and global cache flush
>>> hack if:
>>>
>>> COMFIG_COLDFIRE && (CONFIG_CACHE_D || CONFIG_CACHE_BOTH)
>>
>> And then this becomes:
>>
>> CONFIG_COLDFIRE && (CONFIG_HAVE_CACHE_CB || CONFIG_CACHE_D || CONFIG_CACHE_BOTH)
> 
> You appear to have dropped a '!' there ...

Not sure I follow. This is the opposite of the case above. The noncoherent alloc
and cache flush should be performed if ColdFire and any of CONFIG_HAVE_CACHE_CB,
CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set - since that means there is data
caching involved.

Regards
Greg


