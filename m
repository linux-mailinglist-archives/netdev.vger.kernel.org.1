Return-Path: <netdev+bounces-176410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F6A6A1F3
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1DD7A9792
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8821D5BE;
	Thu, 20 Mar 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARET7j/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E9221DAD
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461098; cv=none; b=k4z+CWTXmDO/CiXzQXfqJkc7xzHQSCaSITc64br/AiHW6xs2itVX83tqSkuyfKHcs2yO004Wc7E0Az7kTjgjEG4866zFk8BOjyX/rIWN1b6wqZoqcHkIdygMg6eQzwVDMaihcYDiMohtskgHM5FrVKuS71IzpI2T+nf7qDBrHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461098; c=relaxed/simple;
	bh=WceSDYxNlU0FESCDHE8rGDqf5WsdoRUSkTN7Y0d2Nd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKF+94AscisolJOqzDat2llxhfftPbXaV6fwoWRte8y/XvcIeWo3mzqqmW0xYtCosdU0KcGetM9P8yhM6CLxNuunlQ+wG3eRMSm/Q71e/D/aGIvF1Y+RpxY+AuTiTzZKt2i/ZCNZtsBzwdOBaAK742Zez7OVS5S4peYn7SCoffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARET7j/C; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso402905f8f.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742461094; x=1743065894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzhZzxRpfuL0NmEgOtiWp7G29TdO9WjRAZeMuHJM+TU=;
        b=ARET7j/C0UClaqONb+euqMHFVfdsnBNXeD/O6p7syIipNOad0/27itKPTU2QSzFsfV
         8Wwv1QQeeTj379Pg7NaibdGFQI76vP+CMktb6cJUfmjG/GAfEyDoe9Wss7MFH+GKBpz8
         tZRx3JQKkvIqQFvwuLc6HcUtJgtYUa/z8uW/57eee8ixqDaH0sjOxeReBqR2GIvsx9st
         1Q4GSrts7R1VNu1+saLYjgj+H6hRgszpC2jW9AjsQcoTp8t+n5lpv2UTPRBQfXxyzQd9
         uiZ+/AwDSdM8uanTyfKhR3P2ktXNvNgDouTLOWsdGrJlnbwKbFmi7EmG2qK1MF3MjFje
         ejMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461094; x=1743065894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzhZzxRpfuL0NmEgOtiWp7G29TdO9WjRAZeMuHJM+TU=;
        b=VZq5yCJpLiCf0bOTu5DIqHeGz0dEPn1sfad4H7BiD1DolPoliDgSRFroWVquxd0jPF
         uCw7GtmOGTPZ+8t0P3gMoNbVR5vW7ieE7VirCrnsqXSjN61ZwVvFd5bsogrrEDjurDPS
         TTmd/0JNfM+fsptnJvIWiNS44b+cjji3EDzUgafNS+3rlrJYZKNUzpe4SIn6EdYFWbIW
         X3AAobYMVnSJU2El5cvOlbgfNrdf5JPgBKEkbTOdbouNgaDNhjLFYSo115WRSYmVcZOx
         aCpC1eSUkMppEItfK7Br8p1vvnm9az1o53vv+dQ4bOwKWKL/Sym9MyxxQOAz6c6x4GsU
         wGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTQaVR78RmLdifPHfaDgl/XeryuYkNb+gLLJwSpqcKMFvNOiS8XBV990XVRmZF0FtKxafPCfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcz/I7d7SpmLXFNdHDnBOrIxBCi48owmnbTs/5W1QmwYTVKnrv
	ozDiYcLvGzKtL5eYP8J9PAurUh5LxVPYIIYPH0iLBgWNv6Yo5gg8
X-Gm-Gg: ASbGncuKgs1ZgXePYSP2CsuUPuhaQBq/0XvXXlKxZ4qQFESxmQke1HS58GtsRGeDdkg
	t9koWQAhvZGLjQqDnt/K3PtLaCXzoCYvGlYyrXLae+zOOh6yn60v23b8JUrDLf1g0r2vdoM8DgH
	lBhYgriSFJnp0hFXAJybxeEqDxZpbCtkfXxG2MvvfU0CJAMvniTbaKRRe0A/BdJoBlmpqcRanOR
	Qkdudnic5ug0jRNt09z/dVZGktJ1fxrzgfb2uU909vybsS6X/p0+TtXhJp+LzMqBYgMYJDxYc5O
	l4pS6D2W9IRTDnWUEVRrIQLDo5th/5/dVvVxo2Mq4XxImFIXnj9Q1uP/1LW5rDvVyljWkCP1K8R
	l
X-Google-Smtp-Source: AGHT+IGrvEDAdD9+Pjrdgu57WFE5aA2NwO6NLoWWRrsMe+ankvXLQ5ZC0/8+6bDJNmAPD1tqGL+EOQ==
X-Received: by 2002:a05:6000:144b:b0:391:1473:336a with SMTP id ffacd0b85a97d-399795df893mr1513720f8f.36.1742461093671;
        Thu, 20 Mar 2025 01:58:13 -0700 (PDT)
Received: from [172.27.33.126] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f589b4sm41904525e9.24.2025.03.20.01.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 01:58:13 -0700 (PDT)
Message-ID: <8a92051f-8169-44a1-a26d-85efa71a5e31@gmail.com>
Date: Thu, 20 Mar 2025 10:58:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS
 context
To: Gal Pressman <gal@nvidia.com>, Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250319124508.3979818-1-maxim@isovalent.com>
 <fadfb5af-afdf-43c3-bc1b-58d5b1eb0d70@nvidia.com>
 <CAKErNvrbdaEom1LQZd6W+4M-Vjfg+YRzgEz3F7YWoCXB_U+dug@mail.gmail.com>
 <fe4b2e7b-1704-426e-99e7-da55375b676d@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <fe4b2e7b-1704-426e-99e7-da55375b676d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/03/2025 10:44, Gal Pressman wrote:
> On 20/03/2025 10:28, Maxim Mikityanskiy wrote:
>> On Thu, 20 Mar 2025 at 10:25, Gal Pressman <gal@nvidia.com> wrote:
>>>
>>> Hey Maxim!
>>>
>>> On 19/03/2025 14:45, Maxim Mikityanskiy wrote:
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
>>>> index 773624bb2c5d..d68230a7b9f4 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
>>>> @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
>>>>        case ESP_V6_FLOW:
>>>>                return MLX5_TT_IPV6_IPSEC_ESP;
>>>>        case IPV4_FLOW:
>>>> +     case IP_USER_FLOW:
>>>
>>> They're the same, but I think IPV4_USER_FLOW is the "modern" define that
>>> should be used.
>>
>> Yeah, I used IP_USER_FLOW for consistency with other places in this
>> file. If you prefer that, I can resubmit with IPV4_USER_FLOW.
> 
> I don't mind, up to Tariq.
> We can followup with a patch that converts all usages.
> 

Please keep using IP_USER_FLOW for consistency with existing code.
We may converts them all together later.

