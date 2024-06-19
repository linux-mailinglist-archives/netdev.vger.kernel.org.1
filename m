Return-Path: <netdev+bounces-104840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873890EA40
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E1282BAA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401A13DDC9;
	Wed, 19 Jun 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIov5lXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02ED13212E
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798385; cv=none; b=UAV9SF0vr/q4kRZqVjQzP37p56ul7cZOPcDWnpN+w4qRGdZmxtHxx1ltq9BmJnID5zlf6A6X5G2PDDX02bkcZGDtaj7HA3CCMHYbqq5/OGFn+A3UVQEQfXHs8q4cB+H1fV2Ovcwfgv/N3u67Otx3VmqjRX+0p3tkwrrcWsn+E9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798385; c=relaxed/simple;
	bh=5i/ufGEXGZM+asXvViRV7VJUiWQz5Z4h2JWJfaYbOs0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eN/JYgN1+3on25rpDsxu1z+bI6DcgteHgREepj7vpWko0C1im6ecZe90IAlPhWGnLce6hF+lttye6+RNSc6n6hTYMT+CxmM6VG5c813qnGgmkhKqApwM1L05XyAlMnaGnlKYlP0XoGB5U2c5/W08iHf7m6spa8pLS767qqlHmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIov5lXw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4217990f997so46904885e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718798382; x=1719403182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvg4vGG0NNCH7mnLi58lkwASaYMo6neAVgHZyfchLqY=;
        b=hIov5lXwwled0piFG1TMGPxZ2A0Py0fb1ucOGBgz0QOvW3IfFm1GhLAzSWrjmxf4ZS
         bwqTrs8e2tomIVe4R3ghPvpT1s8P/K1ou08cX6nsNzYG0cHs5+ZkDEzYR6KZWQ4f5wqr
         4vyq1TKbCKPhjxNBnCj2xkgC6FrGIhQJt07wfBR6vR1ocTVt7I1Phek0PDHpm2nsspUt
         124RTQgMropI2xY6Q2LvOjw/MRhdegA7z8UPg7G1rv/BlpQkkPLGHH7TnMW1ISyB+Ezr
         jWzBwtou38AGyAyMyMegLCkOzB920KJ04iNR/ynGjlwKhCAGXSFGqrgd4zaCbj5Hk5wj
         uxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798382; x=1719403182;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvg4vGG0NNCH7mnLi58lkwASaYMo6neAVgHZyfchLqY=;
        b=Wv1mdlQQxVAKkC0/RlSchk1XwkkvN6wx9WgHV7bcI5OKc6wZDpELXHowbbUi5Ds82L
         XPcAsMvK66rebFl2oVhAJ/EeHuFhSYx6UPiEiPbKc7jmWUCys2BGRiQQpxhH3dvxzc5b
         856DgfrzJTo5ZcxckI0/syEn1ItXF0HrgFIQTqKuf+0sbQfLkKcCv7BKyibV5eu4YBVO
         RQ6szrPXIWNAeaaypKaP6Xpaqvci+ZyaUrANZz4xlbA+jfsZw8UK+wRuu5fX9cHsZ+C8
         KZ82ZwxxEewQYEoKOgtbWH4FuJgZVP2ceWwsrMFcAcKhwRhc0kt43mH0B8FmdpbTvJAI
         TsZw==
X-Gm-Message-State: AOJu0YzGExAo/HXbthyAp6Xi1pBPjKGWO/nequ5FA5+MZUqH/RVYagfw
	2yP3bkO85hDrS1ZXufT/G9ZTtXe81OBWrsKuD9ulz8qjMsccgnBr
X-Google-Smtp-Source: AGHT+IGFYKB0stBBhearch7GBt2XkbprkLsDvGhS0htFufQYuPX/v8MMmmoBuSjtCmymCbGJteE8eQ==
X-Received: by 2002:a05:600c:49a3:b0:421:2202:1cd1 with SMTP id 5b1f17b1804b1-42475296c55mr14584245e9.25.1718798381957;
        Wed, 19 Jun 2024 04:59:41 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f2f30925sm229384975e9.0.2024.06.19.04.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 04:59:41 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 3/7] net: ethtool: record custom RSS contexts
 in the XArray
To: David Wei <dw@davidwei.uk>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, mw@semihalf.com,
 linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
 <889f665fc8a0943de4aeaaa4278298a9eba8df84.1718750587.git.ecree.xilinx@gmail.com>
 <6d697584-d860-4ee2-a2de-cbfca81600b2@davidwei.uk>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f14b14e1-1dfb-1769-88c9-856dc3c96c37@gmail.com>
Date: Wed, 19 Jun 2024 12:59:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6d697584-d860-4ee2-a2de-cbfca81600b2@davidwei.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 19/06/2024 01:46, David Wei wrote:
> On 2024-06-18 15:44, edward.cree@amd.com wrote:
>> From: Edward Cree <ecree.xilinx@gmail.com>
>>
>> Since drivers are still choosing the context IDs, we have to force the
>>  XArray to use the ID they've chosen rather than picking one ourselves,
>>  and handle the case where they give us an ID that's already in use.
>>
>> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>  include/linux/ethtool.h | 14 ++++++++
>>  net/ethtool/ioctl.c     | 74 ++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index a68b83a6d61f..5bef46fdcb94 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -199,6 +199,17 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
>>  	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
>>  }
>>  
>> +static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
>> +					       u16 priv_size)
>> +{
>> +	size_t indir_bytes = array_size(indir_size, sizeof(u32));
>> +	size_t flex_len;
>> +
>> +	flex_len = size_add(size_add(indir_bytes, key_size),
>> +			    ALIGN(priv_size, sizeof(u32)));
>> +	return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);
> 
> ctx->data is [ priv | indir_tbl | key ] but only priv and indir_tbl are
> aligned to sizeof(u32). Why does key not need to be aligned?

Because it's a u8[], whereas indir_tbl is a u32[].
(And priv is aligned to sizeof(void *), so that drivers can put
 whatever struct they like there and have proper alignment.)

> Is it guaranteed to be 40 bytes?

Not AFAIK, though that certainly is a popular size.

-ed

