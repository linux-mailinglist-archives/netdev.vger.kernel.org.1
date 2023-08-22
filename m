Return-Path: <netdev+bounces-29757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA478494A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E4C1C20BA5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B601DDCD;
	Tue, 22 Aug 2023 18:13:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FA2B576
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A35DC433C8;
	Tue, 22 Aug 2023 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692728003;
	bh=UmC1QpitqolkunPU1SZPBD8bKD7x9tTaWCdhyLoNaDQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MtSDULi27Gzzy+DVMfL5Ay0E9qZKeg05nL3+SkIdV/vlbBfrjdm75KCpbkHrACbFG
	 zQI3xcJG2qrDHE8QSuDmWlNT6RRSt8eUFxwKUqGk370nDpexni5enK7bn9katmAVmN
	 CPQZVw574Fez1oKrHWwx6TIa/x5KXNt+w9Mt6XP823cFNf49S1orAcb67GH5Wejvda
	 JJWebEZvzv1yDK/J5Y2sopsK1pM/yj2A8bAhhEC84jtpORznjnqmN2Ta3QslPcDkMF
	 OdANUU9RqgwLvO4gD2/qMQeHUjsCx2A6jUzgztCgOIiKvWo0xFDwY215pJw2UM3ZiY
	 FT48/6aRsDj5w==
Message-ID: <21cc97c9-1778-1b73-a05e-4ebbca39c861@kernel.org>
Date: Tue, 22 Aug 2023 20:13:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: ilias.apalodimas@linaro.org, daniel@iogearbox.net, ast@kernel.org,
 netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Stanislav Fomichev <sdf@google.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [RFC PATCH net-next v3 0/2] net: veth: Optimizing page pool usage
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Liang Chen <liangchen.linux@gmail.com>, hawk@kernel.org, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20230816123029.20339-1-liangchen.linux@gmail.com>
 <05eec0a4-f8f8-ef68-3cf2-66b9109843b9@redhat.com>
 <a7e72202-0fa1-633e-1564-132a1984aba1@redhat.com>
 <a4e49ab5-fdc5-971a-47e6-30c002ad513f@huawei.com>
 <ef4ca8d3-3127-f6dd-032a-e04d367fd49c@redhat.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ef4ca8d3-3127-f6dd-032a-e04d367fd49c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/08/2023 15.05, Jesper Dangaard Brouer wrote:
> 
> On 22/08/2023 14.24, Yunsheng Lin wrote:
>> On 2023/8/22 5:54, Jesper Dangaard Brouer wrote:
>>> On 21/08/2023 16.21, Jesper Dangaard Brouer wrote:
>>>>
>>>> On 16/08/2023 14.30, Liang Chen wrote:
>>>>> Page pool is supported for veth, but at the moment pages are not properly
>>>>> recyled for XDP_TX and XDP_REDIRECT. That prevents veth xdp from fully
>>>>> leveraging the advantages of the page pool. So this RFC patchset is mainly
>>>>> to make recycling work for those cases. With that in place, it can be
>>>>> further optimized by utilizing the napi skb cache. Detailed figures are
>>>>> presented in each commit message, and together they demonstrate a quite
>>>>> noticeable improvement.
>>>>>
>>>>
>>>> I'm digging into this code path today.
>>>>
>>>> I'm trying to extend this and find a way to support SKBs that used
>>>> kmalloc (skb->head_frag=0), such that we can remove the
>>>> skb_head_is_locked() check in veth_convert_skb_to_xdp_buff(), which will
>>>> allow more SKBs to avoid realloc.  As long as they have enough headroom,
>>>> which we can dynamically control for netdev TX-packets by adjusting
>>>> netdev->needed_headroom, e.g. when loading an XDP prog.
>>>>
>>>> I noticed netif_receive_generic_xdp() and bpf_prog_run_generic_xdp() can
>>>> handle SKB kmalloc (skb->head_frag=0).  Going though the code, I don't
>>>> think it is a bug that generic-XDP allows this.
>>
>> Is it possible to relaxe other checking too, and implement something like
>> pskb_expand_head() in xdp core if xdp core need to modify the data?
>>
> 
> Yes, I definitely hope (and plan) to relax other checks.
> 
> The XDP_PACKET_HEADROOM (256 bytes) check have IMHO become obsolete and
> wrong, as many drivers today use headroom 192 bytes for XDP (which we
> allowed).  Thus, there is not reason for veth to insist on this
> XDP_PACKET_HEADROOM limit.  Today XDP can handle variable headroom (due
> to these drivers).
> 
> 
>>
>>>>
>>>> Deep into this rabbit hole, I start to question our approach.
>>>>    - Perhaps the veth XDP approach for SKBs is wrong?
>>>>
>>>> The root-cause of this issue is that veth_xdp_rcv_skb() code path (that
>>>> handle SKBs) is calling XDP-native function "xdp_do_redirect()". I
>>>> question, why isn't it using "xdp_do_generic_redirect()"?
>>>> (I will jump into this rabbit hole now...)
>>
>> Is there any reason why xdp_do_redirect() can not handle the 
>> slab-allocated
>> data? Can we change the xdp_do_redirect() to handle slab-allocated
>> data, so that it can benefit other case beside veth too?
>>
> 
> I started coding up this, but realized that it was a wrong approach.
> 
> The xdp_do_redirect() call is for native-XDP with a proper xdp_buff.
> When dealing with SKBs we pretend is a xdp_buff, we have the API
> xdp_do_generic_redirect().  IMHO it is wrong to "steal" the packet-data
> from an SKB and in-order to use the native-XDP API xdp_do_redirect().
> In the use-cases I see, often the next layer will allocate a new SKB and
> attach the stolen packet-data , which is pure-waste as
> xdp_do_generic_redirect() keeps the SKB intact, so no new SKB allocs.
> 

Please see my RFC-v1 patchset[1] for a different approach, which avoids 
the realloc and page_pool usage all together (but also results in 
correct recycling for PP when realloc cannot be avoided).

[1] 
https://lore.kernel.org/all/169272709850.1975370.16698220879817216294.stgit@firesoul/

--Jesper



