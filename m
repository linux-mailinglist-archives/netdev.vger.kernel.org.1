Return-Path: <netdev+bounces-87321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F348A29BE
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8261F223B0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4C6F534;
	Fri, 12 Apr 2024 08:43:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F863CAC
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911422; cv=none; b=iTBIyVsNIwIG1nIdyI/u7ZqCxlXDLV4wwcv1fm9ZpSX5p57m9U0ffo6aa8RsZwHzZFwWu9B9eUX1ReZ6mfuZYcAseHuPZ/M15s00NxFTtaDW3w9Axgjz0/+wvO/BFkY7IJEfdjr9gcp6xk4mdGnL29dvhQieWxGh1Mj0tN1FuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911422; c=relaxed/simple;
	bh=5vKVdwapLg+EI9SOK3D+29zLm5XE+AsTn5abEJgy2vM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LbLfE56UsvoNHUO+M70l0VLktbAm8h/PBPhwxXfmk/Sse2/ekx0EUxA5Ny81Y9ly7Y6LUcF8WfymxwjkT0HizOUumcEq3rdqVQqjnV8mi+W2Mb6mRNet4fuUDQVlRpxe9Z82HHRE1u3lS877aZjIgCp7veQkv2PwtVd5wGSMsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VG9731wDBz1wrPG;
	Fri, 12 Apr 2024 16:42:39 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A1651403D5;
	Fri, 12 Apr 2024 16:43:35 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 16:43:35 +0800
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
 <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
Date: Fri, 12 Apr 2024 16:43:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/10 23:03, Alexander Duyck wrote:
> On Wed, Apr 10, 2024 at 4:54 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/4/9 23:08, Alexander Duyck wrote:
>>> On Tue, Apr 9, 2024 at 4:47 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> On 2024/4/4 4:09, Alexander Duyck wrote:
>>>>> From: Alexander Duyck <alexanderduyck@fb.com>
>>>
>>> [...]
>>>
>>>>> +     /* Unmap and free processed buffers */
>>>>> +     if (head0 >= 0)
>>>>> +             fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
>>>>> +     fbnic_fill_bdq(nv, &qt->sub0);
>>>>> +
>>>>> +     if (head1 >= 0)
>>>>> +             fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
>>>>> +     fbnic_fill_bdq(nv, &qt->sub1);
>>>>
>>>> I am not sure how complicated the rx handling will be for the advanced
>>>> feature. For the current code, for each entry/desc in both qt->sub0 and
>>>> qt->sub1 at least need one page, and the page seems to be only used once
>>>> no matter however small the page is used?
>>>>
>>>> I am assuming you want to do 'tightly optimized' operation for this by
>>>> calling page_pool_fragment_page(), but manipulating page->pp_ref_count
>>>> directly does not seems to add any value for the current code, but seem
>>>> to waste a lot of memory by not using the frag API, especially PAGE_SIZE
>>>>> 4K?
>>>
>>> On this hardware both the header and payload buffers are fragmentable.
>>> The hardware decides the partitioning and we just follow it. So for
>>> example it wouldn't be uncommon to have a jumbo frame split up such
>>> that the header is less than 128B plus SKB overhead while the actual
>>> data in the payload is just over 1400. So for us fragmenting the pages
>>> is a very likely case especially with smaller packets.
>>
>> I understand that is what you are trying to do, but the code above does
>> not seems to match the description, as the fbnic_clean_bdq() and
>> fbnic_fill_bdq() are called for qt->sub0 and qt->sub1, so the old pages
>> of qt->sub0 and qt->sub1 just cleaned are drained and refill each sub
>> with new pages, which does not seems to have any fragmenting?
> 
> That is because it is all taken care of by the completion queue. Take
> a look in fbnic_pkt_prepare. We are taking the buffer from the header
> descriptor and taking a slice out of it there via fbnic_page_pool_get.
> Basically we store the fragment count locally in the rx_buf and then
> subtract what is leftover when the device is done with it.

The above seems look a lot like the prepare/commit API in [1], the prepare
is done in fbnic_fill_bdq() and commit is done by fbnic_page_pool_get() in
fbnic_pkt_prepare() and fbnic_add_rx_frag().

If page_pool is able to provide a central place for pagecnt_bias of all the
fragmemts of the same page, we may provide a similar prepare/commit API for
frag API, I am not sure how to handle it for now.

From the below macro, this hw seems to be only able to handle 4K memory for
each entry/desc in qt->sub0 and qt->sub1, so there seems to be a lot of memory
that is unused for PAGE_SIZE > 4K as it is allocating memory based on page
granularity for each rx_buf in qt->sub0 and qt->sub1.

+#define FBNIC_RCD_AL_BUFF_OFF_MASK		DESC_GENMASK(43, 32)

It is still possible to reserve enough pagecnt_bias for each fragment, so that
the caller can still do its own fragmenting on fragment granularity as we
seems to have enough pagecnt_bias for each page.

If we provide a proper frag API to reserve enough pagecnt_bias for caller to
do its own fragmenting, then the memory waste may be avoided for this hw in
system with PAGE_SIZE > 4K.

1. https://lore.kernel.org/lkml/20240407130850.19625-10-linyunsheng@huawei.com/

> 
>> The fragmenting can only happen when there is continuous small packet
>> coming from wire so that hw can report the same pg_id for different
>> packet with pg_offset before fbnic_clean_bdq() and fbnic_fill_bdq()
>> is called? I am not sure how to ensure that considering that we might
>> break out of while loop in fbnic_clean_rcq() because of 'packets < budget'
>> checking.
> 
> We don't free the page until we have moved one past it, or the
> hardware has indicated it will take no more slices via a PAGE_FIN bit
> in the descriptor.


I look more closely at it, I am not able to figure it out how it is done
yet, as the PAGE_FIN bit mentioned above seems to be only used to calculate
the hdr_pg_end and truesize in fbnic_pkt_prepare() and fbnic_add_rx_frag().

For the below flow in fbnic_clean_rcq(), fbnic_clean_bdq() will be called
to drain the page in rx_buf just cleaned when head0/head1 >= 0, so I am not
sure how it do the fragmenting yet, am I missing something obvious here?

	while (likely(packets < budget)) {
		switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
		case FBNIC_RCD_TYPE_HDR_AL:
			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rcd);
			fbnic_pkt_prepare(nv, rcd, pkt, qt);

			break;
		case FBNIC_RCD_TYPE_PAY_AL:
			head1 = FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rcd);
			fbnic_add_rx_frag(nv, rcd, pkt, qt);

			break;

		case FBNIC_RCD_TYPE_META:
			if (likely(!fbnic_rcd_metadata_err(rcd)))
				skb = fbnic_build_skb(nv, pkt);

			/* populate skb and invalidate XDP */
			if (!IS_ERR_OR_NULL(skb)) {
				fbnic_populate_skb_fields(nv, rcd, skb, qt);

				packets++;

				napi_gro_receive(&nv->napi, skb);
			}

			pkt->buff.data_hard_start = NULL;

			break;
		}

	/* Unmap and free processed buffers */
	if (head0 >= 0)
		fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
	fbnic_fill_bdq(nv, &qt->sub0);

	if (head1 >= 0)
		fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
	fbnic_fill_bdq(nv, &qt->sub1);
	
	}

> 
>>> It is better for us to optimize for the small packet scenario than
>>> optimize for the case where 4K slices are getting taken. That way when
>>> we are CPU constrained handling small packets we are the most
>>> optimized whereas for the larger frames we can spare a few cycles to
>>> account for the extra overhead. The result should be a higher overall
>>> packets per second.
>>
>> The problem is that small packet means low utilization of the bandwidth
>> as more bandwidth is used to send header instead of payload that is useful
>> for the user, so the question seems to be how often the small packet is
>> seen in the wire?
> 
> Very often. Especially when you are running something like servers
> where the flow usually consists of an incoming request which is often
> only a few hundred bytes, followed by us sending a response which then
> leads to a flow of control frames for it.

I think this is depending on the use case, if it is video streaming server,
I guess most of the packet is mtu-sized?

> .
> 

