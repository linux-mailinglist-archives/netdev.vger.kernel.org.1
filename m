Return-Path: <netdev+bounces-227449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173FBAFA4E
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BCF1885643
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BF27EFFE;
	Wed,  1 Oct 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqFrzzrq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEC266B6F
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307502; cv=none; b=cxiKIihZMLn+m6IWzvAckN5MeNOkMyKQDEMkT7Q5P3W/CbWTWom8LzkaMpin/FeaGkq/PleS418mDmdLjjsGVsrtPLiduT5u6lVwBEkLR5a+mX99gNgiOVAHT2uZ22uZchtZqZSnPXSpVUJzQKGuSvw8z6kkcdkCjLSEVabyGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307502; c=relaxed/simple;
	bh=wlepJl/FDglC7Iq5FuOQ6VBskFRpNf8YuU3NftOhPfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTOYTJJ7IptSJM+MJ49iNosXmmcg5Z6vQufKxSuafQzQdnSgVsng/wEibOrD1OnDDW7L8zZ5S5NESsGHJvmDCrVz35okqQqv2YpQe1l2kChOiTGM/jm3DGuJMDi6jyxbMnB4rFcKu5S/0qrmDpgEKaqTuSXDdrqE+CNx2skWq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqFrzzrq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-780fc3b181aso4176334b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759307500; x=1759912300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/BnQS5ICJGbt/butX83RKxPPfruJQzobXgxFKJ0MdI=;
        b=MqFrzzrqmvEAtBO2NWim8lp+Ze+0Ee79O/9eg0AO4pUbTq8PqWgK+ANvRTn4S4uEYj
         JDINeU+D9kJQ4vREinXqSKtO9xj7E18HjNDNU9Wa9mQxTRE0VdTLx8A01Imfpdv4lSrk
         BQlIcuIhUwpyBSpD/bqso0LEqr4DVaLLHKgl/KHbtZkTyHAc6OfAJpCy8FqXaB/dA/Um
         bhwJoUOL2T8+cUpHluIsA6U6n9NzH05hwyJIKujlpWdQ0hGj3c4kdi6mFiftJLY7rR97
         RzI4tbUBuQh+SawbQGvJpXzMWP+MrxVRrtKh2QDGzDOY+0eJ5zUPvPXmG2CmIvdqN2kd
         lp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307500; x=1759912300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/BnQS5ICJGbt/butX83RKxPPfruJQzobXgxFKJ0MdI=;
        b=wHiwlGRAwBoheVTaIwfwlR7M7EV2KAPoxEIQUfTgTfaIaOjZ1SpZt97qlwFwxmJgqi
         B9pLCAa/VA/lPF8w+bX32rubVZU0iBKP/GpEjizKZYrutW26QSG0rhCt7Z0/6uOs1mCk
         JbWdKiApMDbVeAyTrwiO/Udbu9Nmd7Jvs7PifK8DY5iGsXgravqp33FNHpHYsITs9TKh
         NW4Y2vM976wJ2AkASU4//Q4sVhhtmC46z42fZCtqx07j/XKoZ+y0HCMUFPTs6rU4ZG2N
         +84ISzC+aKaG+Gn+01uS1looMSRIW1pmiG04308IhQoHxC5ecamqSV+AS3CrjPdU5PRv
         OM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN1Igdi5mIxLgPk2T9+ZHpE8LaQujcEoV/Qe73PZszgFNwJ8rC4Futb5TJ1CpC9V8s3mNNav0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyONakF93P/X2mqeTLRboKbZzgDLXBueJzt3MMmkTuArow+/Evo
	IQuzUR+3UBxodtGZc1DGYM/9QR2oEAJYPsKZHcbSzWlbH1rYteGg5AOP
X-Gm-Gg: ASbGncu8BK7PSZqzMWDLi65IQYvPh01IHGZOsSF+EfWce3/CqYcmlJnxXSvBC1YG9zQ
	fgWm879vULAkiiiYmqq5Mpf5gL4KJFtbJ2PMTXNYIYsSu/ADujB8oQFGzwdJZJXAJrMPw6eQiEx
	0XHy0I3Y/reIDlbRh8tKZ391J95V9fGKKkr9thZyu4u7mkgz7w8x/yTaet+cRXnQ3OzY8DPKef6
	Ebk8JeAF3sosIDqWpyXKLrJvj2rtGi3thb11mooqWR9xNvHtE71uazQmbRVQAp/MzJCVZa81CUd
	jm0FX+doNZOA2HCl5m7H9u2K+Wo0XOcih9XK89cwQKJcNuIT8G5IP0t+uLLE06U+R+Nfq/272c9
	8Zyin3L0iuRkyhQ9awk540P+vs8jHC46nlvqR5b6OtqsXxGcZR0JOae3/uNjaJpU8MtFDaerkdT
	H/omEu
X-Google-Smtp-Source: AGHT+IGKzyuHahUxvEYMTvpgcvyvBiorHG33cuSCeL+2u5gG6jYyCteWnCT8fMENWTmD8XlLl3NMWw==
X-Received: by 2002:a05:6a20:72a7:b0:30a:267b:b9e8 with SMTP id adf61e73a8af0-321e43a2022mr3642212637.36.1759307500186;
        Wed, 01 Oct 2025 01:31:40 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55bdefesm15501448a12.49.2025.10.01.01.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:31:39 -0700 (PDT)
Message-ID: <7cc900dd-a49a-4f37-88e9-6794e92fc7d4@gmail.com>
Date: Wed, 1 Oct 2025 14:01:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
 <20250930173950.5d7636e2@kernel.org>
 <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
 <aNzbgjlz_J_GwQSt@pengutronix.de>
 <e956c670-a6f5-474c-bed5-2891bb04d7d5@gmail.com>
 <aNzlNkUKEFs0GFdL@pengutronix.de>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <aNzlNkUKEFs0GFdL@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 13:54, Oleksij Rempel wrote:
> On Wed, Oct 01, 2025 at 01:40:56PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> On 01/10/25 13:12, Oleksij Rempel wrote:
>>> Hi,
>>>
>>> On Wed, Oct 01, 2025 at 10:07:21AM +0530, Bhanu Seshu Kumar Valluri wrote:
>>>> On 01/10/25 06:09, Jakub Kicinski wrote:
>>>>> On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
>>>>>> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
>>>>>> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
>>>>>> +		/* If USB fails, there is nothing to do */
>>>>>> +		if (rc < 0)
>>>>>> +			return rc;
>>>>>> +	}
>>>>>> +	return ret;
>>>>>
>>>>> I don't think you need to add and handle rc here separately?
>>>>> rc can only be <= so save the answer to ret and "fall thru"?
>>>>
>>>> The fall thru path might have been reached with ret holding EEPROM read timeout
>>>> error status. So if ret is used instead of rc it might over write the ret with 0 when 
>>>> lan78xx_write_reg returns success and timeout error status would be lost.
>>>
>>> Ack, I see. It may happen if communication with EEPROM will fail. The same
>>> would happen on write path too. Is it happened with real HW or it is
>>> some USB emulation test? For me it is interesting why EEPROM is timed
>>> out.
>>
>> The sysbot's log with message "EEPROM read operation timeout" confirms that EEPROM read
>> timeout occurring. I tested the same condition on EVB-LAN7800LC by simulating 
>> timeout during probe.
> 
> Do you simulating timeout during probe by modifying the code, or it is
> real HW issue?
> 

On my real hardware timeout didn't occur. So I simulated it once by modifying the code
to confirm the BUG. The BUG has occurred confirming syzbot finding.

Thanks. 

