Return-Path: <netdev+bounces-153319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66DD9F79C1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA2516DD59
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C3222D45;
	Thu, 19 Dec 2024 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqRel8W3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4522256E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734604994; cv=none; b=N4X37Ysrr4LTHzPg4TJCZtS8ueBazWn1jWOoBt5gfz7Br+wLPJSHG5GmGcdiTgkziJm6mL9u+8i5qSpelZ6W2eovtpjw59jwcHyGZLbUFbabSsCR9WKjC6np/fvo57OZqEc9MBQh1i523M2nzIl9Rq+sAcYcHpxQEq1oNOtK6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734604994; c=relaxed/simple;
	bh=xctGrKNjyEqrQNBes8QDh00bSqkeoLPqCWNniZ+3mDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTuzJcjd0BgGxZ/hVs/rTzhwqQQYOVGd4GOJ8ZccJzwuO4ypBGveGTzmZYcpQ55BJk1h+nq+ujqv8H7N2f+lTd+f1SJGTSF4lTXaFhrEbwVNBR5Q8Y/B9v7C+Tzsko2pdmem7u0Wfgtbg7PGcfkYXrCYIeMWnhX5+fVfreSDuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqRel8W3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734604992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpPwc0bxzpk/ODMpU/DpXxSrREQ7QEq1IBIxImcqo4g=;
	b=WqRel8W3eD3hHwIai1bjsBU9HBCGbTZgmGV2e86gfgEyl1j3tIkWf/oRnbzhAuukG2TlLq
	636wX5FVbm45tKSysL40D1SEEjZgSL0giBKuD7JU6MIkMUMCrDxP9pMtJn1D/YuuE9I4ag
	9EcVesQMSJPokBz/kzqaSA3sxDuVF0Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-yOZg-4BNM3uLOT7xlZN-5Q-1; Thu, 19 Dec 2024 05:43:10 -0500
X-MC-Unique: yOZg-4BNM3uLOT7xlZN-5Q-1
X-Mimecast-MFC-AGG-ID: yOZg-4BNM3uLOT7xlZN-5Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385df115288so320333f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 02:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734604989; x=1735209789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpPwc0bxzpk/ODMpU/DpXxSrREQ7QEq1IBIxImcqo4g=;
        b=rOvskYNzIpXYtBTX3chsUvUsyFHYKlWBanCytfNC7RZNr1Q3Qhb/EilYXBuJ8mSJxV
         W3H0WaVtlVvEjBhAF3TF/RBuP+jn8RpY81xHP23BzDDaKnSnWmMrIPiyfnnuZvlo/1a7
         YKYb35mYz1wqU2z0E5qBCZAzHirBtzSMXL3ed9mamYaYxqGldn5d6qjgXsivLqT30UjI
         wLuQ9LghucsMhclDB58I2JvUWlNFMT+/yrlToohWGBUMk5qq6KrnnrfASg2sBGtZ6PIZ
         I+Z5wkrrtV3Hwkf19IHdcmCHh4bLTfwnKfAqDSE48nWJq/N70MiltdbbE3ENQ3+bAP9K
         ed7w==
X-Forwarded-Encrypted: i=1; AJvYcCXSg2JnfFSuvL6EqkMNeRkm1UNTG1Vfl+XE3AWofBwWk4A4MFmG4K1MAEOX+ojRrWg0Hg8iyfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWvQYvQjjV+IYvm8uAi7YZZMcoLagltrnOp3ips6278Rjz5vc
	WytHgsUA5pYg9ksd+pFsPsIqBcIOxjrSfi8drAqWRPlB386d+LB/J9YL7vN7GsFLqJHVM0va+qA
	omxk0xpXwS5VjdD3o9J0XuO8vjBM9jPP1miqDBjdOR/wb9b1kai4Peg==
X-Gm-Gg: ASbGncsymBWSLQzSONZ8cIFkP4svx2loKJOj3RyrssWgu7+GWLB/S6tchA+OIN6gbUP
	WNGE3nJzwSrkdwq1bKpLQBRJxR8Wap8NnVIMaYVpLfH5s3zDbBkyorHUcgX600ZLRFjNrjm5k2w
	uNAk9f78OQiPLghlP/JcXuf9gglsz3EAsh/c72KyxXGpnrlPaIuaLT8Ej6gLC4uCeNC9q+pp+0S
	o0hibexjMG2/9CRVvV1WMeljh7EFNljwKoVI+wMFUaaXKIIB+a1I/NebwmWaFpIcxJjSRKFlphL
	eHD/4ArtQQ==
X-Received: by 2002:a05:6000:1fa2:b0:386:3357:b4ac with SMTP id ffacd0b85a97d-38a19b1e727mr2518818f8f.42.1734604989567;
        Thu, 19 Dec 2024 02:43:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJSKr2/YYlBAUa3pwKhmIgjUJgPNJ1Yka1xNUjygqzb6ORUFcMicfDNAljlC4zVw6nGPGEeQ==
X-Received: by 2002:a05:6000:1fa2:b0:386:3357:b4ac with SMTP id ffacd0b85a97d-38a19b1e727mr2518793f8f.42.1734604989184;
        Thu, 19 Dec 2024 02:43:09 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e528sm1261604f8f.83.2024.12.19.02.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:43:08 -0800 (PST)
Message-ID: <85e10807-c2ea-41c8-a5b1-64105f7f30ce@redhat.com>
Date: Thu, 19 Dec 2024 11:43:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND V2 net 1/7] net: hns3: fixed reset failure issues
 caused by the incorrect reset type
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, horms@kernel.org, shenjian15@huawei.com,
 wangpeiyang1@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-2-shaojijie@huawei.com>
 <Z2KPw9WYCI/SZIjg@mev-dev.igk.intel.com>
 <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>
 <Z2PxQ8A5DObivci8@mev-dev.igk.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z2PxQ8A5DObivci8@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 11:11, Michal Swiatkowski wrote:
> On Thu, Dec 19, 2024 at 10:41:53AM +0100, Paolo Abeni wrote:
>> On 12/18/24 10:02, Michal Swiatkowski wrote:
>>> On Tue, Dec 17, 2024 at 09:08:33AM +0800, Jijie Shao wrote:
>>>> From: Hao Lan <lanhao@huawei.com>
>>>>
>>>> When a reset type that is not supported by the driver is input, a reset
>>>> pending flag bit of the HNAE3_NONE_RESET type is generated in
>>>> reset_pending. The driver does not have a mechanism to clear this type
>>>> of error. As a result, the driver considers that the reset is not
>>>> complete. This patch provides a mechanism to clear the
>>>> HNAE3_NONE_RESET flag and the parameter of
>>>> hnae3_ae_ops.set_default_reset_request is verified.
>>>>
>>>> The error message:
>>>> hns3 0000:39:01.0: cmd failed -16
>>>> hns3 0000:39:01.0: hclge device re-init failed, VF is disabled!
>>>> hns3 0000:39:01.0: failed to reset VF stack
>>>> hns3 0000:39:01.0: failed to reset VF(4)
>>>> hns3 0000:39:01.0: prepare reset(2) wait done
>>>> hns3 0000:39:01.0 eth4: already uninitialized
>>>>
>>>> Use the crash tool to view struct hclgevf_dev:
>>>> struct hclgevf_dev {
>>>> ...
>>>> 	default_reset_request = 0x20,
>>>> 	reset_level = HNAE3_NONE_RESET,
>>>> 	reset_pending = 0x100,
>>>> 	reset_type = HNAE3_NONE_RESET,
>>>> ...
>>>> };
>>>>
>>>> Fixes: 720bd5837e37 ("net: hns3: add set_default_reset_request in the hnae3_ae_ops")
>>>> Signed-off-by: Hao Lan <lanhao@huawei.com>
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> I haven't signed-off this patch.
>>
>> Still no need to repost (yet) for this if the following points are
>> solved rapidly (as I may end-up merging the series and really adding my
>> SoB), but please avoid this kind of issue in the future.
>>
>>>> @@ -4227,7 +4240,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
>>>>  		return false;
>>>>  	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
>>>>  		hdev->rst_stats.reset_fail_cnt++;
>>>> -		set_bit(hdev->reset_type, &hdev->reset_pending);
>>>> +		hclge_set_reset_pending(hdev, hdev->reset_type);
>>> Sth is unclear for me here. Doesn't HNAE3_NONE_RESET mean that there is
>>> no reset? If yes, why in this case reset_fail_cnt++ is increasing?
>>>
>>> Maybe the check for NONE_RESET should be done in this else if check to
>>> prevent reset_fail_cnt from increasing (and also solve the problem with
>>> pending bit set)
>>
>> @Michal: I don't understand your comment above. hclge_reset_err_handle()
>> handles attempted reset failures. I don't see it triggered when
>> reset_type == HNAE3_NONE_RESET.
>>
> 
> Maybe I missed sth. The hclge_set_reset_pending() is added to check if
> reset type isn't HNAE3_NONE_RESET. If it is the set_bit isn't called. It
> is the only place where hclge_set_reset_pending() is called with a
> variable, so I assumed the fix is for this place.
> 
> This means that code can be reach here with HNAE3_NONE_RESET which is
> unclear for me why to increment resets if rest_type in NONE. If it is
> true that hclge_reset_err_handle() is never called with reset_type
> HNAE3_NONE_RESET it shouldn't be needed to have the
> hclge_set_reset_pending() function.

You are right, I felt off-track.

@Jijie: how can 'reset_type' be set to an unsupported value?!? I don't
see that in the code, short of a memory corruption on uninit problem.
Are you sure you are not papering over a different issue here? At least
some more info (either in the commit description or in a code comment)
is IMHO needed. Otherwise you should probably catch that before
hclge_reset_err_handle() time.

Thanks!

Paolo


