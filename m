Return-Path: <netdev+bounces-31035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C748678B008
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A20280DB0
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817311CB0;
	Mon, 28 Aug 2023 12:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62511C9F
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 12:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A74C433C8;
	Mon, 28 Aug 2023 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693225549;
	bh=1jc7+zlzQOne7RnC8B6F4JM0ri3eqrDyd9zLA8CrD8Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JsUydquVOR7ca9/xs7YifFQBBFStyboihWcpOVd7/RpRKepfzaoX9R8m0afrYV4nM
	 vbDpobCmRJ/Yri9GImCo62qsc+JcuEbubnLdkpvvik00z6iu9LU/2bXL2YPqOhdfPW
	 tTL+Mc+tz7guQzwg5/HvABIQCmkrcBLDlCsE6dxsvjBq6Tma+1FPORxUUDDChk4OH/
	 XLOV1hbEIZXfMTyxU2PGtpkeKDNP12s4jJqF1LBUrHDmG0vUH/h6t0/K1PBkC4ZERB
	 ZIajzpZ7KquqglrchRC7MwCg87ZOV20ziiJvUdV3iwFU/oluRrjJhEZjiF5FkZ/bJY
	 /2GpA7XVRHVhA==
Message-ID: <ec6f9b3a-39ec-404c-7876-4c581aa8ced2@kernel.org>
Date: Mon, 28 Aug 2023 14:25:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Paolo Abeni <pabeni@redhat.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 hariprasad <hkelam@marvell.com>,
 Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
 <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
 <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
 <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
 <20230825174258.3db24492@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230825174258.3db24492@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/08/2023 02.42, Jakub Kicinski wrote:
> On Fri, 25 Aug 2023 19:25:42 +0200 Jesper Dangaard Brouer wrote:
>>>> This WQ process is not allowed to use the page_pool_alloc() API this
>>>> way (from a work-queue).  The PP alloc-side API must only be used
>>>> under NAPI protection.
>>>
>>> Who did say that? If I don't set p.napi, how is Page Pool then tied to NAPI?
>>
>> *I* say that (as the PP inventor) as that was the design and intent,
>> that this is tied to a NAPI instance and rely on the NAPI protection to
>> make it safe to do lockless access to this cache array.
> 
> Absolutely no objection to us making the NAPI / bh context a requirement
> past the startup stage, but just to be sure I understand the code -
> technically if the driver never recycles direct, does not set the NAPI,
> does not use xdp_return_frame_rx_napi etc. - the cache is always empty
> so we good?
> 

Nope cache is NOT always empty, the PP cache will be refilled if empty.
Thus, PP alloc side code will touch/use pool->alloc.cache[].  See two
places in code with comment: /* Return last page */.

The PP cache is always refilled; Either from ptr_ring or via
page-allocators bulking APIs.

> I wonder if we can add a check like "mark the pool as BH-only on first
> BH use, and WARN() on process use afterwards". But I'm not sure what
> CONFIG you'd accept that being under ;)
> 

The PP alloc side is designed as a Single Consumer data-structure/model
on alloc side, (via a lockless cache/array).  That on empty cache
fallback to bulk from a Multi Consumer data-structure/model to amortize
that cost.  This is where the PP speedup comes from.

--Jesper

