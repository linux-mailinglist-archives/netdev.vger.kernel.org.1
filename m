Return-Path: <netdev+bounces-224029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4B0B7F29B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AA64A8336
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C497302CDC;
	Wed, 17 Sep 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpDI0AcA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F552FBDF8
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114054; cv=none; b=rtZ7yBA6aY1OzOAWTDfdSYd+HpBEdzzHSXjLUJS8FDtIrxw0jTartxltZ3JLxC709PUcDW+KCQFXdOeO91P25/9kOpS5Lf8XuipMaPMyw3eqkPWVfn2Ubkz8/KveoZSaRhxpjXrARxoad952qUeVOYJx7eDWQOkRXVTiHghfjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114054; c=relaxed/simple;
	bh=wk9RXuVqpXxxFDzmO7M+cLF30Msy65hjjIojj2YuEdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQ3GR/OQOGBKc2viXpPIz2k/tIJhi78gM6zAOa7chQDnfuYXd31i1Yr0YT6cDFSYP1Rce2aGmnIVugEQZG7RVidJG5wOPysKyVIcagRmz9L0GY6ORgA/vf3lvPYNPa0lUg44pKrNUbBlzu+5Hqcsuc4EHeqkp1aUn8KFnFd4zSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpDI0AcA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8287fa098e8so368879785a.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114051; x=1758718851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X00c/S8lQpFd+72iK9PH+Axt2hlWX60fuXCEoXNETw8=;
        b=ZpDI0AcATciuya53zosHs+bmnW3OTx8VoXWz6sTxo/0uJTbjLtVFUPdnuwYLprGuRy
         bQcJ+kcAJPpDmClQUDIW2adQfTWzvVywMsZtJQgdc6Sv5DSS3SneCPP7ATe4Kt0l9/wd
         uids1L5u3xNU2mPVpMNrLw8YuarAyK5e9L36hcmUR7wSv65wP7MaSf5/ntQmXR5Dfmy3
         +mHR8f4ptCv2QXkdkwqrrQQbupELYcOCFhE2pc0uTB80ERRb6rUJIQWU6RCMDCFz7/0c
         pfb1fb7OSQAFFrpBdeavuT6IKg/opxA6wE7qUkwhulaZ5UMuiC4/WwLrme0FyONloy7N
         zxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114051; x=1758718851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X00c/S8lQpFd+72iK9PH+Axt2hlWX60fuXCEoXNETw8=;
        b=lbxKe05l08bigJVBAFeDb3QowgLXxChcfkxep7MqqLtPb8rvjoLwTdgz0cfFvLX332
         J8qEzn9lH2nhdZ+VoDNBi0FHDaK+jmPpFzzib/eZ5Aw18topniIL2FXWwts6WpQkJDdl
         EhvmhSEZT0/7tMlVHpRGjGs5uDQoqQyQ40v2QjGTCuPfnfbr2woK/JAhY6RMSuiUZYOF
         uhUsvNkGYNeeNfTbit2PRSn8emyHRNuO+Hqb5AH07iXbLkSxfkEGZSqujeIBIevkWXg7
         8u0F6r6ThTZ1LVWQsV8f8HTE8/qpFPnWvpCq1eLztZyIq2sPNW/sm/5YqCP68B8/Hp1i
         IOdg==
X-Forwarded-Encrypted: i=1; AJvYcCWmWywxVQgG5597qha38OlVxCxxt7TM2GrvJCfER98jYfKCqUA0EYaybIKkiQvj6qbZWNOvH28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzw18Vw4h5LJbvWjbbGxpP7aq4kbw04GWBhwYnmkkvlbFU0q18
	8HHXyNutFcnfEDsGQVhAaIqLKORiX+qmItMeOgDOGVig6wXDbmZKYA/n
X-Gm-Gg: ASbGncuL0Lvkc2ycuWM0bwn/4wMDElnl37z8SOXWaYeShCWKntZHKFjrv2i7uMZtLAm
	c7K1vygoLA+GG22xXSqvv1OlX5oHVnLKyAWjtH5jrYW33LLUyWkrzILqRGJdmP7dciF0XDbeNzm
	IPPITfwHU/OGXIEtMaI6yJWzPGeCfEhpw/Aogu1TUK+zlznHbGaCC0JLqKWeFLfS4ixuYByHbcJ
	QlLv3RBoLPyGRkoCTbitdvS7aOQ5WBfo7GlMLD0zbv1tf1Bol288BVOIgsWJg+46empwEkvql3g
	VfxtiY06lqF6cQTWWfjk2dULkW5Efe/W+Wfw2x1ccWm1WbsYnJPvUYs8y1ISr+eD9fTIGslmNTj
	CoK/aL6uXsHwbBsh0aLjUFDblUdxxgZ4y3MJd3TJPKJ1ugMBSibp6JA4g
X-Google-Smtp-Source: AGHT+IGo7e3giCzoRWJPH5fuNrErSKA+sW5Jg+vdwA1lvHisc0+bw0iNJTwvMQIo5DNK9p/Hsz6KRg==
X-Received: by 2002:a05:622a:59ca:b0:4b3:50b0:d7f with SMTP id d75a77b69052e-4ba6b089cdemr27166391cf.61.1758114050366;
        Wed, 17 Sep 2025 06:00:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:d14c:9eca:ff3a:fa00? ([2620:10d:c091:500::5:59da])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce19df73sm1094771885a.51.2025.09.17.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:00:48 -0700 (PDT)
Message-ID: <71ce45fc-5214-4d40-b8c4-abab1d44314a@gmail.com>
Date: Wed, 17 Sep 2025 09:00:46 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
To: Tariq Toukan <ttoukan.linux@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 Alexei Lazar <alazar@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
 <20250825143435.598584-11-mbloch@nvidia.com>
 <20250910170011.70528106@kernel.org> <20250911064732.2234b9fb@kernel.org>
 <fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
 <20250911073630.14cd6764@kernel.org>
 <af70c86b-2345-4403-9078-be5c8ef0886f@gmail.com>
 <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/25 6:39 AM, Tariq Toukan wrote:
>
>
> On 15/09/2025 10:38, Tariq Toukan wrote:
>>
>>
>> On 11/09/2025 17:36, Jakub Kicinski wrote:
>>> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>>>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>>>> older FW versions, too). Looks like the host is not receiving any
>>>>>> mcast (ping within a subnet doesn't work because the host receives
>>>>>> no ndisc), and most traffic slows down to a trickle.
>>>>>> Lost of rx_prio0_buf_discard increments.
>>>>>>
>>>>>> Please TAL ASAP, this change went to LTS last week.
>>>>>
>>>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>>>> on 6.12.45 LTS.
>>>>
>>>> We are looking into this, once we have anything I'll update.
>>>> Just to make sure, reverting this is one commit solves the
>>>> issue you are seeing?
>>>
>>> It did for me, but Daniel (who is working on the PSP series)
>>> mentioned that he had reverted all three to get net-next working:
>>>
>>>    net/mlx5e: Set local Xoff after FW update
>>>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>>>    net/mlx5e: Update and set Xon/Xoff upon MTU set
>>>
>>
>> Hi Jakub,
>>
>> Thanks for reporting.
>> We're investigating and will update soon.
>>
>> Regards,
>> Tariq
>>
>
> Hi,
>
> We prefer reverting the single patch [1] for now. We'll submit a fixed 
> version later.
>
> Regarding the other two patches [2], initial testing showed no issues.
> Can you/Daniel share more info? What issues you see, and the repro steps.
>
> Thanks,
> Tariq
>
> [1]
> net/mlx5e: Update and set Xon/Xoff upon port speed set
>
> [2]
> net/mlx5e: Set local Xoff after FW update
> net/mlx5e: Update and set Xon/Xoff upon MTU set
>

Hello Tariq,

My notes for the situation were that I was running a vanilla net-next 
kernel on a dual host, CX7 system, with the 28.45.1300 FW at commit:

deb105f49879 net: phy: marvell: Fix 88e1510 downshift counter errata

and I was having the issues that Jakub described. No ping working in a 
subnet. Extremely slow bandwidth on a large transfer. My notes say that 
reverting just [1] (from your message) did not fix the problem, but then 
reverting [2] and [3] restored normal behavior.

However, I did attempt to reproduce again on the same system this 
morning, and now I'm seeing that reverting just [1] is sufficient to fix 
the issues.

