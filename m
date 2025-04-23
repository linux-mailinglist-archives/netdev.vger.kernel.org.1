Return-Path: <netdev+bounces-185181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B160A98D65
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338B33B67D1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98C27EC6C;
	Wed, 23 Apr 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0IyUc88j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64876481CD
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419277; cv=none; b=d6ypTKgfY1It7cPOpGPWSgjYb2zrfuhAIdczMZWaHSdvOZsooD5Bg4QMCC8Xk140KILfmwTV6bQ9U8mLiLAzEr+X9WCjhO1O78fpGK+4xb8UK+SXfZhUEBH9bHVoEjPanxlUDrIhuOcSvLl4EIB8vJ5MRiwGB+3K0VBqKhLmYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419277; c=relaxed/simple;
	bh=jYTlrDsHzO9OEikxM7Gr+ZwLK8oHhFWsMwfZyoLfQ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRtRbwA1Hx+u13X3Jh4ZdQLQyxtkSBn9HyuTy5MnhJ2NGPvrUKQQH2XNNVYdK1hjXiXu8dvpR8rFDZblzXpG75yoH94jeWQJdFIV3Hw89Wecf/7Hm6+TmnaOUSpdm+99Jkrq0KXAsTUxmDGhEmFNdeQPy1l9NTuHk+4GkuLjVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0IyUc88j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22928d629faso62436905ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745419273; x=1746024073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfH82R14xJ+9dQqDHetknS/UsEjphIlXgwWxKJXhO18=;
        b=0IyUc88jBVkD5kpMlUfIsizhHRErnMD6GRko7MgZmRDdxjEUi72gJZJwndz+X5tEqS
         Wa7RAuMkzIfxOly35JNiQ5GGhLlWbC+IiLFStjvPolEIX+z2v0KvE91JVLWKxk2Hz058
         p0sJ01jsoqIF1bnkIHsCKKYBx7AWO8d3advrxxCsz3Vm9yJo4BWg15ewlM4YL6GgnbI6
         wSeifl2xriOVM7qjbMB4V+7Gjf/jeSyoFD9PWwPxVnUnsMB1Z3GoxQ23kq2hJpBMuPnU
         FVJz1klzqPGoJ4HKHUzglistiE/0CUBv6ucukFOwubgGP6He6ZVkrFtt7V7o+ubki+9D
         W6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419273; x=1746024073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfH82R14xJ+9dQqDHetknS/UsEjphIlXgwWxKJXhO18=;
        b=YC79ZG2Sit8fARbPRfqBKXAH1paDT9DEk8hAzJCVa4732VzTUCJ1/yBUESbvhXnYTM
         CZopkP3JB5TdUHoQxDiu+VJ99mNXbybO5qeNf8prg5mHFfWLyTcj0zLytp+P63lDJrsS
         Bx0OYY9TbxYsS+4qSZPqOgd1IulxlfV8t+CmOoSP8JRgEsJUuaPZ20ZOhfFX6+oyGNZX
         1IoHWXflDzKuOczSE2K/4bNuByUHXcEdBviGzQS14Q/689ZtIq2lO4ff740X5Y0qw/F9
         lokYUydcfMCnqMk5/SYc7pg9ryNihY9TH78aFH8tLr8LvhcrQEQdWxcTdb6iqXPcqS95
         j9hg==
X-Gm-Message-State: AOJu0Yxcfn96Us8tpE3ikPrZDwOE72/UlD5o0E46C+TPiQGD85QFLnsO
	iSofHIVKxWjsur8DdmLPCdlnyJqS0T0TTACc7i8kRNzIhy1IVn4jQpD9q0OoTA==
X-Gm-Gg: ASbGncuzzKBrYdwsH/YvU0E10avoeGQxYzI/fa9iBjS42hb4EI2CH9q2iAuxYJQhwO/
	UMvnkJXCN2Q2suLWi5udJ4H4uq6PWmFTEOXmKjdmomCkS89DCIF6GgR7k4xZ+Y+Wc+QHRZCLfsm
	TkkZfpIUCf7D6jF8/5KNK+G2fMOcZF0dW270FimnyYqJZF97IeNzZHVbRfJlqyO4/NrXM7dgJLa
	bQWXCbbdjlafGhSjDjadAZF1QY2C0mayrEbJdCWOAEZqTNggiTyXovvA3ERXgy7zPEr/9HHavla
	8X2qh2AZxQuytf+Rsc/kfvPTyDhf7Nb/eHmQC2pXUlsDTHCBoWVCpCXQS2MWxMs7XNXS27hbiN2
	6f1SjBe2o
X-Google-Smtp-Source: AGHT+IFa06Q6KaXmNp9bA2mo0NYLrxO+yE9INIq/A1BDYA7AAP7oWHE2Xt8R7xWkvo3vOJ3fwjysOA==
X-Received: by 2002:a17:903:2285:b0:220:c4e8:3b9d with SMTP id d9443c01a7336-22c536014d1mr257744415ad.37.1745419273445;
        Wed, 23 Apr 2025 07:41:13 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba? ([2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed1dc3sm105364805ad.205.2025.04.23.07.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:41:12 -0700 (PDT)
Message-ID: <25909f3c-a263-4532-8d61-2bad391a1d79@mojatatu.com>
Date: Wed, 23 Apr 2025 11:41:08 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/5] net_sched: drr: Fix double list add in class
 with netem as child qdisc
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, toke@redhat.com, gerrard.tai@starlabs.sg,
 pctammela@mojatatu.com
References: <20250416102427.3219655-1-victor@mojatatu.com>
 <20250416102427.3219655-2-victor@mojatatu.com>
 <20250422174406.38cc5155@kernel.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250422174406.38cc5155@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 21:44, Jakub Kicinski wrote:
> On Wed, 16 Apr 2025 07:24:23 -0300 Victor Nogueira wrote:
>> +static bool cl_is_initialised(struct drr_class *cl)
> cl_is_active() ?
> Had to look at the code to figure out what it does, but doesn't seem to
> have much to do with being "initialised". The point is that the list
> node of this class is not on the list of active classes.

Ok, I believe cl_is_active describes it better. I'll make that change.

>>   static struct drr_class *drr_find_class(struct Qdisc *sch, u32 classid)
>>   {
>>   	struct drr_sched *q = qdisc_priv(sch);
>> @@ -357,7 +362,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>>   		return err;
>>   	}
>>   
>> -	if (first) {
>> +	if (first && !cl_is_initialised(cl)) {
> I think we can delete the "first" check and temp variable.
> The code under the if() does not touch the packet so it doesn't matter
> whether we execute it for the initial or the nested call, right?

I was being more conservative, but your suggestion is a good optimisation.

cheers,
Victor

