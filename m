Return-Path: <netdev+bounces-39984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A37C54E6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA03281FA0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539DC1F19E;
	Wed, 11 Oct 2023 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6481F196;
	Wed, 11 Oct 2023 13:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B1CC433C8;
	Wed, 11 Oct 2023 13:09:09 +0000 (UTC)
Message-ID: <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org>
Date: Wed, 11 Oct 2023 23:09:07 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
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
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20231011055213.GA1131@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/10/23 15:52, Christoph Hellwig wrote:
> On Wed, Oct 11, 2023 at 12:20:57AM +1000, Greg Ungerer wrote:
>> That should be M532x.
>>
>> I am pretty sure the code as-is today is broken for the case of using
>> the split cache arrangement (so both instruction and data cache) for any
>> of the version 2 cores too (denoted by the HAVE_CACHE_SPLIT option).
>> But that has probably not been picked up because the default on those
>> has always been instruction cache only.
>>
>> The reason for the special case for the M532x series is that it is a version 3
>> core and they have a unified instruction and data cache. The 523x series is the
>> only version 3 core that Linux supports that has the FEC hardware module.
> 
> So what config option should we check for supporting coherent allocations
> and which not having the hack in fec?
> 
> Here is my guesses based on the above:
> 
> in m68k support coherent allocations with no work if
> 
> CONFIG_COLDIFRE is set and neither CONFIG_CACHE_D or CONFIG_CACHE_BOTH
> is set.

I think this needs to be CONFIG_COLDFIRE is set and none of CONFIG_HAVE_CACHE_CB or
CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set.



> in the fec driver do the alloc_noncoherent and global cache flush
> hack if:
> 
> COMFIG_COLDFIRE && (CONFIG_CACHE_D || CONFIG_CACHE_BOTH)

And then this becomes:

CONFIG_COLDFIRE && (CONFIG_HAVE_CACHE_CB || CONFIG_CACHE_D || CONFIG_CACHE_BOTH)

