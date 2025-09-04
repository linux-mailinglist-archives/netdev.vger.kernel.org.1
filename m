Return-Path: <netdev+bounces-219832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C1AB4349B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DB23A8822
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C6C29DB9A;
	Thu,  4 Sep 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GbqFS1YM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB522BCF68
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972328; cv=none; b=r+9HB6sbn1xswBPwzh6joyRmPDbUTiquIYcmWMxzeIPs+tkqARCMYY+4gWrTpJeZZXBUnt9+iyVzNUV6LiNQ/eh9LKc2dCESIP1gaJ06hl0g8yQyBffzHspQIAwEbsdjOv3WUJ8mtP63ILx0A/wS8Xg0U2nBF/wFNlYEEMy1G5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972328; c=relaxed/simple;
	bh=QviSrVrxETHht7JJw/IhRoKKYggVSL09AR6USkbnVMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Neflx0H+fW5+tEYrmHyCWhxRuIOx4Tq8Wacjw2MOYxOXCOTtDm7R92bibZwMZ0RxsdVkrIYHnHkSgQdP/Op3lpDvoExMZMQ7cBo+xuXD5lDnwFsfBFCViwmFf/L7Rprb2b7GDOmoobSup+4gVUlGpnmFAa9IIOppKJjLrb8TIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GbqFS1YM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ace3baso135031466b.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756972325; x=1757577125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWRNFXHeRSpnlxKXSwDHA/Hv0MlPLNMzI+84KFHKbrE=;
        b=GbqFS1YM343huFa9FqlFEWnBakdFe3TDD6najYGbrExlu0KM+6UInABZSfqi4mzMN0
         JpI5JqgghicGORHd0/qmsK/sJBRUg+wKBchObQAoBl6khy/TV1N1CpAMjVX9DpOybouA
         UF9oCr8yzclz2iXJdTw1OFI7fKGswUhCw+WgKZTB7r0k75sEihO1kFxfZAG4QfyVKooR
         zIifluzd5L9XD23NWafFCXFt8iiJxs4pTlICjwC45ZfL0/MuifAXruygPFndbLeDku6i
         sNhVzOPwDIWy4ZX9+oEcYMxU22wzGAIetBFzBx0jjUD+6Sc4sRY4rvF95TTjoKo4AMoL
         SUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756972325; x=1757577125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWRNFXHeRSpnlxKXSwDHA/Hv0MlPLNMzI+84KFHKbrE=;
        b=WTnBJFH9nl2axagnuLwzC7h4TQRl3yowrdt/0C95GvG05vJYzsqTreiYt6CiC2JatU
         8GrocNWeFV5Q/jHhKXNK7achiGdMEDLQTtBjm+bRt2tOMy+RznKE47AYZERfpeeREmVl
         ZjckiJ0Hr48qzFmCrGGAEgf3IL3owqzquJNlba7qlyAk1ScZjJ/OuZvXIDCi51YMhP8f
         Ne3rP9Kaog8mqYsjoZNwX9znjyaqKqUsYm3XlOqwMVrnSQMv3J9+Ia2IqEVpFga8HtIa
         TmG0AOMErlQSiW3l6MzkUgcPvjRMt1H7f2Ctv4lxUUH0/s5EZgpLOfoeZFHrMaCcnpSW
         DsOw==
X-Forwarded-Encrypted: i=1; AJvYcCWM3ZeAHr7EwSNeDgAVVLdjmdMqcVjtztBtxqzineJuZ2zZR2y/gBL7IrtOnWY293WxE5hp/eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywus9SLQXx4YktCopei1gzWmFzfv3sqYxHebVVI6+ODUApoLKc2
	4wmUs2KDn4H4EL3KZ+2NSK/iIABR8BfwxG1EnmGhlaVNEJSs5qVoNzFiIqbDPpCRLXs=
X-Gm-Gg: ASbGncsMoDGr4l1ZQ712vlVDoIcU11NIhVsGIobd2+k6fTLaIkHgWzLOVa1AScrLzPJ
	S+oOT4lwzND8S9tr11YieU9+5jYOyO3PyMK48KPTtoMrsavk1UnGSHZSrVPme1S9VUqXkHTSsBG
	lPLBoeszhd6yImuUyZ/d4Xoo8uCQDjV4BnwU0M09zOdLMlzKl1LXnS9tGpjCWl2MSif1yzNmyCr
	LS7lHZO6SZAmDOMSoUTJCqDDGYf1gN4oo5PzbBA3GXCgBR0UXfBblViEVEFlTOVTH7HBBHbHxFY
	a5g74/uUI0QEw64/23nQz58rblLKgR4z2RJBkv8yNN5RWQ3jYaeq/c6nJuQrYbjgA21OMRhJMlx
	BwE0BHBDMPzY21xHUh0O8HyIA4KZbSDUG+TxZQQUBOP4i4gUcJ9Jkp+MeJqJsJypLewYMlunHHk
	P/NQ==
X-Google-Smtp-Source: AGHT+IFz8/s9RU6uLx7pNVkdcxeMAszRCrGtrk5LnHQVCVYMW0GhdVfKmyVuAlC8x0iEfVxQ4lT24Q==
X-Received: by 2002:a17:907:3c8d:b0:b04:6338:c94d with SMTP id a640c23a62f3a-b04633912b1mr602235266b.12.1756972324708;
        Thu, 04 Sep 2025 00:52:04 -0700 (PDT)
Received: from ?IPV6:2001:a61:13cd:9f01:a217:cdfc:46ed:41bc? ([2001:a61:13cd:9f01:a217:cdfc:46ed:41bc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046e6c630fsm292433766b.55.2025.09.04.00.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 00:52:04 -0700 (PDT)
Message-ID: <4bca61b8-71a0-4a8b-b02a-a8e6f5a620de@suse.com>
Date: Thu, 4 Sep 2025 09:52:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usbnet: skip info->stop() callback if suspend_count
 is not 0
To: Xu Yang <xu.yang_2@nxp.com>, Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250818075722.2575543-1-xu.yang_2@nxp.com>
 <663e2978-8e89-4af4-bc1f-ebbcb2c57b1c@suse.com>
 <ajje6wfqyyqocpx2nm6nmw3quubmg5l3zhuxv7ds2444hykgy5@xbi7uttxghv2>
 <ttbjrqjhnwlwlhvsmmwdtzcvpfogxvyih2fovw7nl5bk7hfqkv@4cfkfuuj6vwr>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ttbjrqjhnwlwlhvsmmwdtzcvpfogxvyih2fovw7nl5bk7hfqkv@4cfkfuuj6vwr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/25 09:26, Xu Yang wrote:
>>>    	/* allow minidriver to stop correctly (wireless devices to turn off
>>>    	 * radio etc) */
>>> -	if (info->stop) {
>>> +	if (info->stop && !dev->suspend_count) {
>> ... for !dev->suspend_count to be false
> The suspend_count won't go to 0 because there is no chance to call
> usbnet_resume() if the USB device is physically disconnected from the
> USB port during system suspend.

Sorry for the delay.

While you are correct that a physical disconnect
will make the PM call fail, you cannot assume that
a physical disconnect is the only reason disconnect()
would be called.
It would also be called if

- the module is unloaded
- usbfs is used to disconnect the driver from the device

Hence it seems to me that using suspend_count is false.
You need to use the return of the PM operation.

	Regards
		Oliver



