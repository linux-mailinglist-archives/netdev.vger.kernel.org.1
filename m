Return-Path: <netdev+bounces-65965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432D83CAB4
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33BFB25978
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA5133983;
	Thu, 25 Jan 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjzcikZc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0210A12
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206862; cv=none; b=JpJyysZwLjyrYtbNkmrzchDslihSMQlvVRMaFPxHPm7kM6dCDzc493pM0b3gSokJFRaKtRYH0ibjlXGXyfLXzxEmm0tbt+J/5wEwX1irdFhj5eIxVWCpQVhn8Il+lA1J72CRfAB3j4CiR3eZy0gl/6fZw6aHBoAzIncY7b8oBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206862; c=relaxed/simple;
	bh=Dgjspa0IUCw/GjUtRtv6shH9ECPHfZwj0AvOxZTYjgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MD3bkmgwX7tpIBOVaJIvrGAe1o2Ve75bkxfwmDDSeaZ1dwHPUNq5audoazJGQGm18lEPfOsQhAYBT/8E/W7dmsztrl4yrsENIEelvsR24gzAXNh/ZKZZt9NO0hFZo5vONkchAvLrRrHtvRL69ePFhVtNgDfIxyTM+ON+7udCJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjzcikZc; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bfbe61859dso39185539f.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706206859; x=1706811659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcM5CjcQVWweq2asWoGSAcigp43UdnJ0Pqz7x32rGgY=;
        b=mjzcikZcc0wEYPqM4rPYq+T0Tw8gZTPdsvTrfVPDb4aei+o2X6Y7XdD5aGfT/mS2wR
         EIzmbMcsTwgarJsZ2keIVeTERk9qMABWV5e67xs1hz6i8lRQbzfgQNXYUiDY5sOBlv+5
         xG3JiUthEw01qZ3gWfEsQGFpUrowm8+/hBFq/4hFOkmKcFroLTWQ8it/RYOc6qdc3kUN
         WJ1v1ph4Tiu5FmXF63yZNlRQWW5JoG5T+BNcpurSAiUhEZ1X9D8Pl+cQNyBQPUCG3iaz
         J0B0azsBCcD5prFVVdWrBXerT6bQ2VW1j3oSCzlS84CogQzXuBky/ayZd3J3DW2h6GG4
         7xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706206859; x=1706811659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcM5CjcQVWweq2asWoGSAcigp43UdnJ0Pqz7x32rGgY=;
        b=iRfMYbBqmcFZo2M2NHOOm6fNhSMzoafQj0UNkaHJVYPRK0/OvSKkMVjt8Aoc6Sr4FT
         g0md5H+xBMA6aHDojVx5oRMG5ujvsbaaZXpWA749+hVh30fTcB9Nx9GhKwtWIDNmZmWv
         6X1iCfBrrvpmugHdi6XNut58Fn42OiVNlD9Umxh7OmJ97o+3+kdh/WyXneFs2iGAP6/9
         Dg2tOV+xGFEyKHI0Ctk4AXYDTBTz12fyfZ941mKZMV1udTbrUQJd5PenFjDaTh5uKe3S
         aMy9UwP2rfftTrThK8096E8hRXd30D5OXHLn8Tfdb9xz6lKK7gbK/4jRxrMmmrDAfV7x
         1dMg==
X-Gm-Message-State: AOJu0YyXI9TNIdFApsr5k9VGOYlZAFgVDdBlPdn8BJl69TAiOx18EwnK
	cjKfCqsDO1x1xRib8AxrWBFZPF5WRhsbErH25vAdzZ2kVBD503/X0p3S5EbY
X-Google-Smtp-Source: AGHT+IFpTBzkJghJ4yKTARmhe55qQLmzo+BCDBCyI7/CMZqcQB49yTOvFgwlNzP+8fgGhY3Y3UkpyA==
X-Received: by 2002:a05:6602:21da:b0:7bf:9ab4:5978 with SMTP id c26-20020a05660221da00b007bf9ab45978mr158542ioc.25.1706206859570;
        Thu, 25 Jan 2024 10:20:59 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:ddd8:edb3:1925:c8bf? ([2601:282:1e82:2350:ddd8:edb3:1925:c8bf])
        by smtp.googlemail.com with ESMTPSA id r12-20020a02c84c000000b0046eda09d55esm2749151jao.179.2024.01.25.10.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 10:20:59 -0800 (PST)
Message-ID: <08d60060-ee2b-436f-9dcc-8aad1c8c35a1@gmail.com>
Date: Thu, 25 Jan 2024 11:20:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.6.x REGRESSION][BISECTED] dev_snmp6: broken Ip6OutOctets
 accounting for forwarded IPv6 packets
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, heng guo <heng.guo@windriver.com>,
 netdev@vger.kernel.org
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
 <20240124123006.26bad16c@kernel.org>
 <61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
 <493d90b0-53f8-487e-8e0f-49f1dce65d58@windriver.com>
 <20240124174652.670af8d9@kernel.org> <ZbIEDFETblTqqCWm@pc11.op.pod.cz>
 <ZbJ5Wfx7jNfXBpAP@pc11.op.pod.cz>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZbJ5Wfx7jNfXBpAP@pc11.op.pod.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 8:08 AM, Vitezslav Samel wrote:
> On Thu, Jan 25, 2024 at 07:47:40 +0100, Vitezslav Samel wrote:
>> On Wed, Jan 24, 2024 at 17:46:52 -0800, Jakub Kicinski wrote:
>>> On Thu, 25 Jan 2024 08:37:11 +0800 heng guo wrote:
>>>>>> Heng Guo, David, any thoughts on this? Revert?  
>>>>> Revert is best; Heng Guo can revisit the math and try again.
>>>>>
>>>>> The patch in question basically negated IPSTATS_MIB_OUTOCTETS; I see it
>>>>> shown in proc but never bumped in the datapath.  
>>>> [HG]: Yes please revert it. I verified the patch on ipv4, seems I should 
>>>> not touch the codes to ipv6. Sorry for it.
>>>
>>> Would you mind sending a patch with a revert, explaining the situation,
>>> the right Fixes tag and a link to Vitezslav's report?
>>
>>   I took a look at current master and found that there is yet another
>> commit since 6.6.x which touches this area: commit b4a11b2033b7 by Heng Guo
>> ("net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams"). It went
>> in v6.7-rc1.
>>
>>   I will test current master this afternoon and report back.
> 
>   Test 1: Linus' current master: IPv6 octets accounting is OK
>   Test 2: 6.6.13 with b4a11b2033b7 ("net: fix IPSTATS_MIB_OUTPKGS
>           increment in OutForwDatagrams") on top is also OK.
> 
>   Seems like my problem was solved in master already, but
> it still exists in 6.6.y. IMHO commit b4a11b2033b7 should be
> marked as for-stable-6.6.y and forwarded to GregKH. AFAIK only 6.6.y
> stable tree is affected.
> 
>   But beware: I only tested my specific problem and I don't know if the
> commit with fix doesn't break anything else.

Only reported problem, so with b4a11b2033b7 backported to stable we
should be good. Thanks for the testing of various releases to isolate
the problem.

