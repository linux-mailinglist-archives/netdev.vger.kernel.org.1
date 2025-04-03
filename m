Return-Path: <netdev+bounces-179192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83106A7B1A1
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5B188377C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6119258E;
	Thu,  3 Apr 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUrRfy1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E981494CC;
	Thu,  3 Apr 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716799; cv=none; b=Mfjt215B38x7/1y7p9VUzY5Px8ySdtMys29lq23ojM1NbYNP6K1zY7zW2mtwiy7Jl9HDK2f4HPUs6RQthlReyVwOi0aBAxcglKTm47Ilb3StPQaYGwChHZmxrsLHXJ6WeUCwhZZpNwGvOd9QwjJVbJ9tnl8W4ucMjykfKIYNmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716799; c=relaxed/simple;
	bh=UoHi17w8zgHvpFGQto+G13hZRwmTH8OcIzC9cvweJ94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/yE0ExhFegSk2qAYx5hpcGsSnUc/F4roKdH21S8jzxWUppk186ROrLzGcrn8Z74PjZ5/m3a22qgUnY3ehpCIN4Z3Zh27u+RIS77O3yfMR11GlCVgHywrX48mypur6kvqvQVRNU88KryWrMy0ZJSnJnOHzfBADXeaSmXg90pqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUrRfy1W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so9529495e9.1;
        Thu, 03 Apr 2025 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743716796; x=1744321596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDLT5jaOfTvnXrHcbjmxYiedZsavDNsVTNdUJK4Wfl8=;
        b=iUrRfy1Wmpgodg/UJzrDsD4g5H6fiotEQ5YmUlhWVGHsJQNgXES/1uqHdL6Slkpbcz
         WdBnxnsle+MaVPMvc+z/hqQ0cU6FeMtvor0scjWivwcrukxwF5RTk+nlwbGfjVG+mj48
         UzLRe9Y/IDsuXoSTQJhAAWAUkr7zXWiekoMYR6EXfmrL+JjFPQSVxTPucxMDIqsf4MyH
         xldk+/mkxoH4wSpgvS9qkaKVfOi8RC7Pd/JggUzqq5lyHmpcEifobiCj8y2CLqH252Il
         saGmsrT/SpNQPrm/fIqRnt1QUM3VPsp8BFnMGO7euGEM9kajDalsEBLzdu7xdkntjMLR
         ZH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716796; x=1744321596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDLT5jaOfTvnXrHcbjmxYiedZsavDNsVTNdUJK4Wfl8=;
        b=vbJBKtg45OtZErigGqTCKC8zrolj6u57pDauhgKGy02jV1g9K0lDFspF/A2QMfFweM
         Eiwk3riSjPo6G2N+1kdj0WmG69572dW2I1SuGoZiLNRfeRi2r5LgkLi4D31fnJlXH9tC
         j2qFHvvTvxgVAILRkHaxL6Hhn0WgTHZgHdwv/OtJk6r7wPolcBwb3ke3iHlxNC0Pg9Rn
         xBi4Qx0jxKcKcoQL/DrNxUPz5HYGyaEasCgeVOLzU/ctv/4/Y7pV4oyOcgQNnGf1mt4J
         eqHhuLgdh+eGmpDvO4S5VMvQOtwxMoNZBpCpo7aBISjjNUWuIcnDh2cDFl8W8mAl9ltT
         XdPA==
X-Forwarded-Encrypted: i=1; AJvYcCULI1tVethUEb+iCThqXaZ/hFQD+fx0xkCTducu6N19rieQaCzsw5afP7Oh+YbGZW/3eEsxAvQj@vger.kernel.org, AJvYcCXMmQzXsW9N4dSXmFqD18K6RBneP5vPInrrnMY9UwJ4CqKzjKeNwrJWfsc9FmGdHdEvH5DM+fYjqtnLc9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdeGgFiAdpiPh7UalCEIje46PEX38Z98t0DyqYGJZDUBvkfmM
	AXVbYJdpZ4pIDZLVFK4GMWyA3VEhiv4CUttqIpeZCf8RTKAAh0tv
X-Gm-Gg: ASbGncsDqXkA96baBKRlleHWFttKDmbSZ8EvK9iH7i2UAZAznE5sJaCKq9MOi/YNV/S
	jGhd9FyZ17BDm5pXr037eaEuepGGqB9Lio2TfxPc3ORi/bdVve5Td2ksV1F89FnE2JdpEQjN08D
	RivzUd499bW+SQ7KLswkVUZqLCixYod/Hj1tnfRC6PoQpXzNYy/jQL5LfRe5Z3hz3t+m/z25hVN
	GkmdOAy3FGJRB3agVZB8uNFPBWPHzJ7hOi7JBu8Ix5WJBwPDi1lu+Q018T0+jbzJTQrkeb6zPbx
	vg0U/MEHVob1Gqeyqy6SZljduYYRQhVhIHV0tjfFbluPtn4ep/tDGy2Cej0=
X-Google-Smtp-Source: AGHT+IFtF/KVAoDcggALyJa6yUnhhZ7LhPdgH+LEEouPBpTHX9lLc/XZJT72W1VXptDBNhM5KaENqg==
X-Received: by 2002:a05:600c:1d12:b0:43c:fd72:f028 with SMTP id 5b1f17b1804b1-43ed0db3ba4mr2585675e9.29.1743716796219;
        Thu, 03 Apr 2025 14:46:36 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b76f2sm2788425f8f.53.2025.04.03.14.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 14:46:34 -0700 (PDT)
Message-ID: <f0798724-d5dd-498b-89be-7d7521ac4930@gmail.com>
Date: Fri, 4 Apr 2025 00:47:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GNSS support for Qualcomm PCIe modem device
To: Muhammad Nuzaihan <zaihan@unrealasia.net>, Slark Xiao <slark_xiao@163.com>
Cc: Loic Poulain <loic.poulain@linaro.org>, manivannan.sadhasivam@linaro.org,
 netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
 johan@kernel.org, mhi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <2703842b.58be.195fa426e5e.Coremail.slark_xiao@163.com>
 <DBU4US.LSH9IZJH4Q933@unrealasia.net> <W6W4US.MQDIW3EU4I8R2@unrealasia.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <W6W4US.MQDIW3EU4I8R2@unrealasia.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Slark, Zaihan,

Zaihn, congratulations with the progress, curious to see the result.

Slark, thank you for remind me. It's a good moment. Lets see how we can 
prototype it. Will try to do it this weekend and send some RFC next week.

On 03.04.2025 11:42, Muhammad Nuzaihan wrote:
> Hi Slark,
> 
> I just implemented it in the wwan subsystem since it works for me (even 
> without flow control). I wanted to port it to use GPS subsystem, 
> however, debugging in GPS subsystem is too troublesome, especially when 
> the driver crashes.
> 
> Unless i can have some VM with direct access to the Quectel hardware so 
> i don't need to keep rebooting my machine if it crashes.
> 
> For now, i am getting GNSS/NMEA data from Quectel with MHI wwan 
> modifications.
> 
> Regards,
> Zaihan
> 
> 
> On Thu, Apr 3 2025 at 04:02:01 PM +0800, Muhammad Nuzaihan 
> <zaihan@unrealasia.net> wrote:
>> Hi Slark,
>>
>> I just implemented it in the wwan subsystem since it works for me 
>> (even without flow control). I wanted to port it to use GPS subsystem, 
>> however, debugging in GPS subsystem is too troublesome, especially 
>> when the driver crashes.
>>
>> Unless i can have some VM with direct access to the Quectel hardware 
>> so i don't need to keep rebooting my machine if it crashes.
>>
>> For now, i am getting GNSS/NMEA data from Quectel with MHI wwan 
>> modifications.
>>
>> Regards,
>> Zaihan
>>
>> On Thu, Apr 3 2025 at 02:06:52 PM +0800, Slark Xiao 
>> <slark_xiao@163.com> wrote:
>>>
>>> Hi Sergey, Muhammad,
>>> This is Slark. We have a discussion about the feature of GNSS/NMEA 
>>> over QC PCIe modem
>>> device since 2024/12.May I know if we have any progress on this feature?
>>>
>>> It's really a common requirement for modem device since we have 
>>> received some complaint
>>> from our customer. Please help provide your advice.

--
Sergey

