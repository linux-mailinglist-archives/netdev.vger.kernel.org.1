Return-Path: <netdev+bounces-223962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE5B7F9C4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DBC1BC0BAD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388142EB853;
	Wed, 17 Sep 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp2CBoTN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E86278150
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105586; cv=none; b=Qzu3aJz78y289CV9usiQ5ZcHwPDFSnuKXTCsimhKGxV5c2JIYtSJ7zN8fVY5FgacTEqB41eShvyeRHlfU4Os5MLz0tbqv1oXvNka0jv81tifZbS+5cgWBtA3eMWgQ5V9ia+0WM3GS6M9qRaz+Dj75Wti8/pu8SIhASzSkjPvuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105586; c=relaxed/simple;
	bh=R4CWvOUtCvrgdNMym402PYTJjWgUILHeZKrnJPMuhgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1d6bt9gyLd2kO3uhwcO86yPpyMX1mTtSwz4oZMz6uDZiiqwFZa1MYbakNaOwhsFIZD65H1xb3m7PXnkZTd5Aytz1L/TTXjN5NC99rfqqDbeua/fGKDgA0Lw26Ug8hDLIku5NHEJqiAtCK3yLKBJxzsdI+/ESlYj7va9KPG6D+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp2CBoTN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so7096355e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758105583; x=1758710383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+sQHbuAnUVLK2DcccTjeny/VsR+2o6xAMfUxaFboC4=;
        b=Cp2CBoTNalC9pWPf5OZPZP1oscN+RkKFGAyyVs7kQcsgII9WtM0putFb1oyuIlXPE4
         BfjcAQCWf1ML6yJsT8l9C+dtkQLCeSrAsNKSI2fqVAWZl85J70p9bYxHc7S/zBPC8Wpc
         nqfd+dqpEwbzM7S456aUjosi9hnwumnUl4i4W3Nk5fnvOUS46VdaTNZXpUbZHPoW7AwI
         uBS7UXlt8Esd1t6SmJvDRNBrNnXQ3zKad9pgzOMk4SmC694YNgaaGoZjPDpm1P7L8YC3
         o6XvUa7Job/nOGboGpq0FArTqFGJ1bh1KicVinPuKYMOEEhYgwPdx41Qhag+XMSUNmUn
         N+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105583; x=1758710383;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+sQHbuAnUVLK2DcccTjeny/VsR+2o6xAMfUxaFboC4=;
        b=XEqGDymDJQAIOi25DZ+G3T69U9Y8g9xRNqEkRuj9i8mRBklDzfCONw3s9BRFewwXiE
         d0dq5n4/XG5B04y0EVa9PZTvVCQpxHiCho/OhZ2h1xP0fGd8vmhG5Gjhp1H7CM1ZsjMC
         BoOLbpfs2JMADmFEj9Pwy/aHxrl8N5JlIFXL8rb0lh1hyZUstPgBhik8THnbOS2sb2F3
         KS7UCH3y4j1ongO4Cmn/o5+A44wleqHsscbnsdVEHeZhk0yRcFVIBSEj8/VzMyYkDfdl
         QI3WzPjJ1hyY+I5MM+36Jlzqvg4qALYXbTF3mm25bbawHzkbtCgkqiOKkM8QtKdhywc3
         DqlA==
X-Forwarded-Encrypted: i=1; AJvYcCX4QlR9FHx6cjJJV815+RsUx5Wc0WBw877uvHmgyMuPVurekvL0yN0z0ACSdhYd416mM9lOOMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLB30DUAJ7gXoX6BQ7fBzOfzQM8IkcsFqd4zgMhVE8iP5aVJwB
	mcSdqZMgF1PW5iitOxylk4k+It6sX3Kj4kC6QcId5XOiFTOyjWHmWD2u
X-Gm-Gg: ASbGncsKIo89jwqDYzeRxRzDyyGSoGmUv9K1mx3cQNOvA780D4odShKDxmTQ9MEnfuk
	UFSI8pgU5jgMVHwqOe7snoQQHG19ob76HuAY5mm9heCS8SFcpn/5kiaM9v14ybKOplcoPvdo77z
	TiFHdU4BMHYGW+wlNHF1OJBbGboPgttxrWIXyAHYgocmNUTDpYpmd16gVoyg3Dv9MZuHdK+CHJm
	/ikjq817xjpF/7qkr0sXR0R2yA8WG3kKClXK3l0eH3+e3KfRaJ5BqaEJOcEiTpWjWzNp/jM0oMh
	m2To8bfbZXdUbscCT+gmgSqJ1hULv3zsSoS79EV/X21P8iP4GMTrkbRQTux9M5yI5muQCZw2Jad
	L+CXC5ubaXEwxIahsNYWuSFOsvYSnlclTyyzap73e6qf3JK/qADKmEA==
X-Google-Smtp-Source: AGHT+IGusD+yhysHUCpNgRezV67Os0zRE0BcwTnTYY3tkSiddnSyzrDXOcH3hNEFYbbdLLij2+d3RA==
X-Received: by 2002:a05:600c:6d2:b0:45d:d295:fddc with SMTP id 5b1f17b1804b1-45f32d002aemr36748375e9.4.1758105582776;
        Wed, 17 Sep 2025 03:39:42 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775b13sm26083726f8f.10.2025.09.17.03.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:39:42 -0700 (PDT)
Message-ID: <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
Date: Wed, 17 Sep 2025 13:39:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
From: Tariq Toukan <ttoukan.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>
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
Content-Language: en-US
In-Reply-To: <af70c86b-2345-4403-9078-be5c8ef0886f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/09/2025 10:38, Tariq Toukan wrote:
> 
> 
> On 11/09/2025 17:36, Jakub Kicinski wrote:
>> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>>> older FW versions, too). Looks like the host is not receiving any
>>>>> mcast (ping within a subnet doesn't work because the host receives
>>>>> no ndisc), and most traffic slows down to a trickle.
>>>>> Lost of rx_prio0_buf_discard increments.
>>>>>
>>>>> Please TAL ASAP, this change went to LTS last week.
>>>>
>>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>>> on 6.12.45 LTS.
>>>
>>> We are looking into this, once we have anything I'll update.
>>> Just to make sure, reverting this is one commit solves the
>>> issue you are seeing?
>>
>> It did for me, but Daniel (who is working on the PSP series)
>> mentioned that he had reverted all three to get net-next working:
>>
>>    net/mlx5e: Set local Xoff after FW update
>>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>>    net/mlx5e: Update and set Xon/Xoff upon MTU set
>>
> 
> Hi Jakub,
> 
> Thanks for reporting.
> We're investigating and will update soon.
> 
> Regards,
> Tariq
> 

Hi,

We prefer reverting the single patch [1] for now. We'll submit a fixed 
version later.

Regarding the other two patches [2], initial testing showed no issues.
Can you/Daniel share more info? What issues you see, and the repro steps.

Thanks,
Tariq

[1]
net/mlx5e: Update and set Xon/Xoff upon port speed set

[2]
net/mlx5e: Set local Xoff after FW update
net/mlx5e: Update and set Xon/Xoff upon MTU set


