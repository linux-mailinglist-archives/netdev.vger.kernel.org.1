Return-Path: <netdev+bounces-40391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2A7C71CE
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8402826AF
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D2728DD4;
	Thu, 12 Oct 2023 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UHTSpsQT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2D273D7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:47:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F02F5;
	Thu, 12 Oct 2023 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=EBnjnVg+y4DDG6Px7ecx0HYcMluDmx+CBNhjuKFvPy8=; b=UHTSpsQThE+kLNmBQwnVqk6KF4
	vini3NlLRTqt4OJRF5XxyKB8QRqaIwSIKCmiHk08DPnsezLgWQVoSP9LqGKjrwV3h7WdxEyyM+tsS
	oY8NW3v4FiQLZhWwIhKpyi66jtls7EWuL3xxyBH0VJCMfH5I0k3Zsmk9PX4tkdNKG4333elt79LKq
	oGazMbDNJEvP8f8r0O8ODfuqveoTHM7YfUuAigBCZ9ElafvTBjZb6OUW5uzMyNGBXrD/Y77YY+l3r
	IYKNJiKoEmI5Y5BA7YjPvh7i90orNNWKXynfzxAUjt7+HvzxnRpV0+YtiwyN1r84iu1g49huHfTwI
	GV3MJa/w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxuA-001KXV-0w;
	Thu, 12 Oct 2023 15:47:18 +0000
Message-ID: <b5c1030a-9831-4580-8684-7c68f5888131@infradead.org>
Date: Thu, 12 Oct 2023 08:47:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: Jacob Keller <jacob.e.keller@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michal Michalik <michal.michalik@intel.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Milena Olech <milena.olech@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-4-aleksander.lobakin@intel.com>
 <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
 <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
 <8eaece43-a30d-45e8-9610-28ed2af842fc@infradead.org>
In-Reply-To: <8eaece43-a30d-45e8-9610-28ed2af842fc@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/20/23 18:30, Randy Dunlap wrote:
> 
> 
> On 9/20/23 17:04, Jacob Keller wrote:
>>
>>
>> On 9/20/2023 2:30 PM, Randy Dunlap wrote:
>>>
>>>
>>> On 9/20/23 11:07, Alexander Lobakin wrote:
>>>> When CONFIG_INET is not set, tcp_gro_complete is not compiled, although
>>>> the drivers using it may still be compiled (spotted by Randy):
>>>>
>>>> aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o:
>>>> in function `idpf_rx_rsc.isra.0':
>>>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc):
>>>> undefined reference to `tcp_gro_complete'
>>>>
>>>> The drivers need to guard the calls to it manually.
>>>> Return early from the RSC completion function if !CONFIG_INET, it won't
>>>> work properly either way. This effectively makes it be compiled-out
>>>> almost entirely on such builds.
>>>>
>>>> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Closes: https://lore.kernel.org/linux-next/4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>
>>> That builds for me.  Thanks.
>>>
>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> I hope that these patches can be merged into the v6.6 instead of
>>> v6.7 kernel at some point (i.e., [PATCH net] instead of net-next).
>>>
>>
>> Did any of the offending code make it into 6.6? I thought all of this
>> was from recent merges after 6.6 closed.
>>
>> Thanks,
>> Jake
> 
> Oh, I think that you are correct. Sorry about my comment.
> Thanks.
> 

Even if this is just > v6.6 kernels (i.e., linux-next),
it would be very good to get a fix merged for these build errors.
I keep getting build errors in linux-next....

>>
>>>
>>>> ---
>>>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>>> index 6fa79898c42c..aa45afeb6496 100644
>>>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>>> @@ -2876,6 +2876,9 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
>>>>  	if (unlikely(!(ipv4 ^ ipv6)))
>>>>  		return -EINVAL;
>>>>  
>>>> +	if (!IS_ENABLED(CONFIG_INET))
>>>> +		return 0;
>>>> +
>>>>  	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
>>>>  	if (unlikely(rsc_segments == 1))
>>>>  		return 0;
>>>
> 

Thanks.
-- 
~Randy

