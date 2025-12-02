Return-Path: <netdev+bounces-243257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D6CC9C4FA
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE3349F4D
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181232BE05A;
	Tue,  2 Dec 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcytxSNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695252BDC29
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694650; cv=none; b=XMnuPCiaAEbKBVyc05iYzXnQeWsZFWhl7AhpJzdZ8KSkj5PeKuFszP+54VBqCMfzZ5HfN2WyGopDVq81mq7xSEk3jGfReqT/SsaN9KOTDCpfCgD5ZGoOTGeJGqge7s7FJf23c3yWbtVDkVHvRS226PqTyAveZd15pIwD+3CJUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694650; c=relaxed/simple;
	bh=8GZa5BFOz4bmTox4bCUeDCaAhMJqWewg2lBzE3JNKXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G70BaymFUnaJUYFLUkLpj0IZ3Ge6uRvSksoLB1yvR4gzLv2Mg8L1JHeYlVxnewsjOave7CjeiBNAN3XCIyH55spJI8Wzl6p/xDKVT08Q3zbyXP6UOPidOul9QJqc9jTWVrwkpqgKchS3SSC3JoGxxemv11ThnQXp+HMnqYa7xA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcytxSNf; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78bdc9c9594so2016377b3.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764694647; x=1765299447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLtIXwRxRTClH4u3K+K/BoWr2xFp78REuPVNjVJNxSM=;
        b=ZcytxSNftDGyrys74tVCWVZilwNM9ndSTEllhyk81UtZ8BC4igQPaa9dkFQ8UO/BSy
         n1qKIY1pwhWM1kuZBKrL5zPBGYGa2VYCu09hYMMdkElLuCmXQB5HFpuVN5V/8QNiTqMA
         /g1UV4tFN0m/GAZmPcSFPS4lQIaDztv4r/O+5gP9itWoFN2bdk+H8JWOZ/I9W/nSIS0X
         bh4wWrUM5plc8oe+pnAs005gFjX5X8UGxPEPs51+E7bJylJPa4n6AsHw0xsUlY3ikKPT
         q/7zTHz8hdtejF2e0zgu1OXF+LDGPFcl6gssftnxhrTKYBOk+fveOy/RM3fRMUWkXI40
         IMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694647; x=1765299447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLtIXwRxRTClH4u3K+K/BoWr2xFp78REuPVNjVJNxSM=;
        b=W7rx5yfCh/78s3IpYveNYMB816x5JOwY5pyUK12HNcIXvgZedHp1WPrBjMZOYfjXAA
         bSB/xyoaAskhnLIRUYy2hp6/y/VKIokcB6o/QtFbKKU5DLaYL1KzE2uBbocnluuE+a38
         2IHmLVkexDf3VIfSIBuomgwS9bVcaivtJrrLs7Xw5Qh+obb93D/ZbmexF3MDBSjQH4PB
         DJrDAkxo+hyEYKMbdUUDhsLNDCFDBglk/BCCLI7iLH4JuSqPjAU5ifDLtdKWZ04JGTDf
         P6OtNISnSrQK7nWQpT88Xfz/Qj9PPBFAWpKfxVqOFuL4NHOQe/T9sejlFLUVkAOjXzBP
         pdTw==
X-Forwarded-Encrypted: i=1; AJvYcCUSX7/R61ta1wcuAeI0+uUcMEqgQt9QAn+hGSEzAoBrI7P20UAOmA/VbzH4FW/+EFo4X2+edfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/BQd0j3I0jrXjr55fyXM7vtdXWJLIoFZIXRfy89vWR5lMhdf
	b/U7W6cy7H9pYTfszt6HN3daIUEzjzPN09o7IRks0cOUurSTI0giGjskbaSDwFgP
X-Gm-Gg: ASbGnctM1tGPzEX9he219nZiUpI2SqjvaBxc5N7p7uk8XmDHtQQcL1+jj22iah71Kmk
	q+ODqsDwgWURbHEwdmi51B9eRJmmp9sLuGYaUhlB/tEAgGLWX/VTZKSzufS8azpuU0lRKvyEfX5
	o+VB+Mexj9HqB+lSB/Wmb3iZKhU5eelqoTbEVYMa/BjUrlgQJruNcExANhP82HduUXyHg4UwyRS
	GZnPscVEEF0Vi1MmiUHt5unXxPGWnfLtvnO2gZ7D9LWzSjK29E5detkFUTjmVbW3vDXeGOSmpoQ
	0AAE2Wx3wk5QMj2hUJmcD2olJhaUmPrNDMyNQvJ4e2ZU2V58YHRLBISo7qtTysFS1Kuh2y52qVv
	63/PpIhRVhlqDN5/c2nas9QsPJjkSf2vMUctA5ZdXUymqm2o2SaSh3cdqLNVa/FmXJtUJg1ZWYq
	F0STl/XqkIrGTJn3KklkM=
X-Google-Smtp-Source: AGHT+IHc/xNgAAFtyzW0w5Ee4IqlqQ6ITw/LHV6ICZneq+HjCdkM72XVhtKGPyzuJb/23onkFLvbIg==
X-Received: by 2002:a05:690c:f91:b0:786:896d:884a with SMTP id 00721157ae682-78a8b587725mr286126347b3.9.1764694647326;
        Tue, 02 Dec 2025 08:57:27 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d603f5sm64522557b3.19.2025.12.02.08.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 08:57:26 -0800 (PST)
Message-ID: <ef8ed31a-7b3b-439a-a3e1-8de298827bbd@gmail.com>
Date: Tue, 2 Dec 2025 17:55:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-2-maklimek97@gmail.com>
 <a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com>
 <3728e02b-02d9-4dad-b5da-47e64e91f406@redhat.com>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <3728e02b-02d9-4dad-b5da-47e64e91f406@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 13:06, Paolo Abeni wrote:
> On 12/2/25 12:36 PM, Paolo Abeni wrote:
>> On 11/27/25 10:13 AM, Mariusz Klimek wrote:
>>> This patch fixes an issue in skb_gso_network_seglen where the calculated
>>> segment length includes the HBH headers of BIG TCP jumbograms despite these
>>> headers being removed before segmentation. These headers are added by GRO
>>> or by ip6_xmit for BIG TCP packets and are later removed by GSO. This bug
>>> causes MTU validation of BIG TCP jumbograms to fail.
>>>
>>> Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
>>> ---
>>>  net/core/gso.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/core/gso.c b/net/core/gso.c
>>> index bcd156372f4d..251a49181031 100644
>>> --- a/net/core/gso.c
>>> +++ b/net/core/gso.c
>>> @@ -180,6 +180,10 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>>>  	unsigned int hdr_len = skb_transport_header(skb) -
>>>  			       skb_network_header(skb);
>>>  
>>> +	/* Jumbogram HBH header is removed upon segmentation. */
>>> +	if (skb->protocol == htons(ETH_P_IPV6) && skb->len > IPV6_MAXPLEN)
>>> +		hdr_len -= sizeof(struct hop_jumbo_hdr);
>>
>> Isn't the above condition a bit too course-grain? Specifically, can
>> UDP-encapsulated GSO packets wrongly hit it?
> 
> I forgot to mention that AI review noted the above check should be
> placed in skb_gso_mac_seglen(), too:
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=bed04a62-0239-4392-a9a3-2399fee27630
> 
> AFAICS, it the OVS forwarding path should be impacted.
> 
> /P
> 

Right. I'll add a helper function.

-- 
Mariusz K.

