Return-Path: <netdev+bounces-86521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AF89F17E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E114B1F21760
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7915B0EA;
	Wed, 10 Apr 2024 11:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2F15ADAA
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750068; cv=none; b=gdlJfEIozk2plzmpUKumq8reRC3U+euYrxTIm4kJRewU1VmMSBKn3E8HZn+uokF8QEatLzYI/siC4kunOAAWlESjEif+SA42o6RVRQJp2vg0SQ4lqjXR2DpLPnWSfDXWwN2Scu3NzQMSKX1Plx9BQsyDcE0hIAlB51Ft/1EHbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750068; c=relaxed/simple;
	bh=tIUOTXXNGYTwEUQu8sM4L6ooQSNgqik+hIqf60Bu5vI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pHGzE6o9clhHyxNhj4Q8JR2dFLyDDxi7+BrFJ32HEnhoK3MLyLijNeGwk9B3FX9ovQeEBH0mpMj5qPJN3jaH+fI9bOyCJdBqnD3gW20OaM2sJQRMSfvQh0sREbKgypTKYwgARya74WYK3UCsowhCDxGw8LwQIwicGFcSP5At7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VF1S73FsPz21kdG;
	Wed, 10 Apr 2024 19:53:27 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id E49D8140155;
	Wed, 10 Apr 2024 19:54:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 19:54:22 +0800
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
 <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
Date: Wed, 10 Apr 2024 19:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/9 23:08, Alexander Duyck wrote:
> On Tue, Apr 9, 2024 at 4:47 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/4/4 4:09, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> [...]
> 
>>> +     /* Unmap and free processed buffers */
>>> +     if (head0 >= 0)
>>> +             fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
>>> +     fbnic_fill_bdq(nv, &qt->sub0);
>>> +
>>> +     if (head1 >= 0)
>>> +             fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
>>> +     fbnic_fill_bdq(nv, &qt->sub1);
>>
>> I am not sure how complicated the rx handling will be for the advanced
>> feature. For the current code, for each entry/desc in both qt->sub0 and
>> qt->sub1 at least need one page, and the page seems to be only used once
>> no matter however small the page is used?
>>
>> I am assuming you want to do 'tightly optimized' operation for this by
>> calling page_pool_fragment_page(), but manipulating page->pp_ref_count
>> directly does not seems to add any value for the current code, but seem
>> to waste a lot of memory by not using the frag API, especially PAGE_SIZE
>>> 4K?
> 
> On this hardware both the header and payload buffers are fragmentable.
> The hardware decides the partitioning and we just follow it. So for
> example it wouldn't be uncommon to have a jumbo frame split up such
> that the header is less than 128B plus SKB overhead while the actual
> data in the payload is just over 1400. So for us fragmenting the pages
> is a very likely case especially with smaller packets.

I understand that is what you are trying to do, but the code above does
not seems to match the description, as the fbnic_clean_bdq() and
fbnic_fill_bdq() are called for qt->sub0 and qt->sub1, so the old pages
of qt->sub0 and qt->sub1 just cleaned are drained and refill each sub
with new pages, which does not seems to have any fragmenting?

The fragmenting can only happen when there is continuous small packet
coming from wire so that hw can report the same pg_id for different
packet with pg_offset before fbnic_clean_bdq() and fbnic_fill_bdq()
is called? I am not sure how to ensure that considering that we might
break out of while loop in fbnic_clean_rcq() because of 'packets < budget'
checking.

> 
> It is better for us to optimize for the small packet scenario than
> optimize for the case where 4K slices are getting taken. That way when
> we are CPU constrained handling small packets we are the most
> optimized whereas for the larger frames we can spare a few cycles to
> account for the extra overhead. The result should be a higher overall
> packets per second.

The problem is that small packet means low utilization of the bandwidth
as more bandwidth is used to send header instead of payload that is useful
for the user, so the question seems to be how often the small packet is
seen in the wire?

> .
> 

