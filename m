Return-Path: <netdev+bounces-127058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A992973E1C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE91C24B90
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5106A1A4AAB;
	Tue, 10 Sep 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egq4yuIo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF001A38FD;
	Tue, 10 Sep 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987986; cv=none; b=JMTQAZcaqwxtvQHgyyXNtKjeHRupY+TdA/v/8dzGXxoyHTFeryp7mOLoy47NtQU56y42nL7ThOoG16iGO5OtL4z2oh7JzoajV6zXheYD1x0bN+iic0BNmxHuQcKQ3JRiuCh+sgMLR3ou+8YiO/uURjfBK+3A52WwIQ/6gmM6P4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987986; c=relaxed/simple;
	bh=X6GxUXgIpthZ4hkYtW1OBXJavA9LWUA1gRiTxvcauQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqgaTmJ0YEWyTblT4B+J6XdUEZrErT3uBGZ1yLf8ehPJDiJrT0vIUkWesV6zrsvxqDnL+rlfMQNNUS78+mom6YGF1q7VjjTV+rqxvaaV/pSHnTkkuB7OW/+HmnFeVas38CFhEOG6KmzFrBk/yIVT4JrFeByU1IMgr+ib6PqtuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egq4yuIo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c84dcc64so4495478f8f.1;
        Tue, 10 Sep 2024 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725987983; x=1726592783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QXwEs9Y9JVv7cES2jlT6BP+QZdA8iaeYLh1s141Dr0E=;
        b=egq4yuIoEUNbPQoUg1bGlOwH0LHzO12+s2ekXh3Slj4+P2R4RR3ihxtsO1MyPYHnk7
         /S1H6DNLGTAb6xS/WZNuqrNtI1P17cQ6phLlqUQpNONQYo4S123GHCvsEL903HkUkWvZ
         OjUpwXeHh1B14zlLGHWpcKdy+iQ8C6pP3C97P0nWpmPPoD+qkMeWfaDOujosg3V3uhgB
         ZCi34uspIB12cAnCDD6y+2XpMxtEYLvzGiF1PG+GyaK6GsjjUpShVX3P2WKzSpVRTYyA
         UMcFvKVdU8BE1x7jKAYpAxhXTqf1Qa18tl84brJ37AluTK+JOhAPPQf5+P5HvQ8Mubju
         JZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987983; x=1726592783;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXwEs9Y9JVv7cES2jlT6BP+QZdA8iaeYLh1s141Dr0E=;
        b=WCQielCFI2PRG6QRyl3SQSi6d87T97ikIs4H+v/2AxD8BnLpC1fTCr7WLSliX/aWO6
         fdOT1WfLfL7KJnLn2jhDwK/5UO5MLcZYIfSXe3mbOKKEJPTZB0SlglU8T1/AJiAV95Pt
         16HEQxmoXA6VHC3ZNDokAI7TnvDDU814/Vws7cc69qZDtQK97ljpqxk5yhcN4HHwG8iN
         zzuKCSQAeN2SOhZxg5JqWvonsVMiTf89JH/w1yoIlYB+G0np5hQVu38b16pJzxMwv63W
         aiaDOwNnE5cx3g669oIsxSQDok0+AhwwxfETEMPTVGOZwzRj/ycbAqb1zZ2Ebfzrmf+D
         We6A==
X-Forwarded-Encrypted: i=1; AJvYcCVw9THSO6RYvUKP8z7j84xXtbqQsVpZ543nkrqH+z/jeP+YZ0NNbpiUeFNvrgXZaenBKgnIYzE5BDpnDUQ=@vger.kernel.org, AJvYcCW/pOya5Z+cR8MqaYeR4c1E7gwRwyD6G67tXiwkYi0Fh1M4ofK062v+lVRX+sIJbRROsTh+gOlq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0Hg6OuKeEQx+UjaLy4Px2t6KdErwhjn/wFNgm+RS/v4dolOt
	yKuaH2PLs/AXSXjN/+yP3xUqI4SOd4+Fa/XD7iqGdUYxyrWihh6C
X-Google-Smtp-Source: AGHT+IEHJFQxDeA1DhumdJmAXc+zefco2qlhdZRV8v+Jig+0woeksn7yRxxgCVacEU3SHcFKS9PyVg==
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id ffacd0b85a97d-3789243fa0bmr9923077f8f.45.1725987982222;
        Tue, 10 Sep 2024 10:06:22 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a1e4:b900:551f:92c7:e4c2:de47? (dynamic-2a02-3100-a1e4-b900-551f-92c7-e4c2-de47.310.pool.telefonica.de. [2a02:3100:a1e4:b900:551f:92c7:e4c2:de47])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8d25ce9277sm513817666b.149.2024.09.10.10.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:06:21 -0700 (PDT)
Message-ID: <038166f4-9c47-4017-9543-4b4a5ca503f5@gmail.com>
Date: Tue, 10 Sep 2024 19:06:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuan-ying.lee@canonical.com,
 kai.heng.feng@canonical.com, me@lagy.org
References: <20240906083539.154019-1-en-wei.wu@canonical.com>
 <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com>
 <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09.09.2024 07:25, En-Wei WU wrote:
> Hi Heiner,
> 
> Thank you for the quick response.
> 
> On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 06.09.2024 10:35, En-Wei Wu wrote:
>>> The commit 621735f59064 ("r8169: fix rare issue with broken rx after
>>> link-down on RTL8125") set a reset work for RTL8125 in
>>> r8169_phylink_handler() to avoid the MAC from locking up, this
>>> makes the connection broken after unplugging then re-plugging the
>>> Ethernet cable.
>>>
>>> This is because the commit mistakenly put the reset work in the
>>> link-down path rather than the link-up path (The commit message says
>>> it should be put in the link-up path).
>>>
>> That's not what the commit message is saying. It says vendor driver
>> r8125 does it in the link-up path.
>> I moved it intentionally to the link-down path, because traffic may
>> be flowing already after link-up.
>>
>>> Moving the reset work from the link-down path to the link-up path fixes
>>> the issue. Also, remove the unnecessary enum member.
>>>
>> The user who reported the issue at that time confirmed that the original
>> change fixed the issue for him.
>> Can you explain, from the NICs perspective, what exactly the difference
>> is when doing the reset after link-up?
>> Including an explanation how the original change suppresses the link-up
>> interrupt. And why that's not the case when doing the reset after link-up.
> 
> The host-plug test under original change does have the link-up
> interrupt and r8169_phylink_handler() called. There is not much clue
> why calling reset in link-down path doesn't work but in link-up does.
> 
> After several new tests, I found that with the original change, the
> link won't break if I unplug and then plug the cable within about 3
> seconds. On the other hand, the connections always break if I re-plug
> the cable after a few seconds.
> 
Interesting finding. 3 seconds sounds like it's unrelated to runtime pm,
because this has a 10s delay before the chip is transitioned to D3hot.
It makes more the impression that after 3s of link-down the chip (PHY?)
transitions to a mode where it doesn't wake up after re-plugging the cable.

Just a wild guess: It may be some feature like ALDPS (advanced link-down
power saving). Depending on the link partner this may result in not waking
up again, namely if the link partner uses ALDPS too.
What is the link partner in your case? If you put a simple switch in between,
does this help?

In the RTL8211F datasheet I found the following:

Link Down Power Saving Mode.
1: Reflects local device entered Link Down Power Saving Mode,
i.e., cable not plugged in (reflected after 3 sec)
0: With cable plugged in

This is a 1Gbps PHY, but Realtek may use the same ALDPS mechanism with the
integrated PHY of RTL8125. The 3s delay described there perfectly matches
your finding.

> With this new patch (reset in link-up path), both of the tests work
> without any error.
> 
>>
>> I simply want to be convinced enough that your change doesn't break
>> behavior for other users.
>>
>>> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
>>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 3507c2e28110..632e661fc74b 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
>>>  enum rtl_flag {
>>>       RTL_FLAG_TASK_ENABLED = 0,
>>>       RTL_FLAG_TASK_RESET_PENDING,
>>> -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>>>       RTL_FLAG_TASK_TX_TIMEOUT,
>>>       RTL_FLAG_MAX
>>>  };
>>> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
>>>  reset:
>>>               rtl_reset_work(tp);
>>>               netif_wake_queue(tp->dev);
>>> -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
>>> -             rtl_reset_work(tp);
>>>       }
>>>  out_unlock:
>>>       rtnl_unlock();
>>> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_device *ndev)
>>>       if (netif_carrier_ok(ndev)) {
>>>               rtl_link_chg_patch(tp);
>>>               pm_request_resume(d);
>>> -             netif_wake_queue(tp->dev);
>>> -     } else {
>>> +
>>>               /* In few cases rx is broken after link-down otherwise */
>>>               if (rtl_is_8125(tp))
>>> -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
>>> +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>> +             else
>>> +                     netif_wake_queue(tp->dev);
>>
>> This call to netif_wake_queue() isn't needed any longer, it was introduced with
>> the original change only.
>>
>>> +     } else {
>>>               pm_runtime_idle(d);
>>>       }
>>>
>>
> 
> CC. Martin Kjær Jørgensen  <me@lagy.org>, could you kindly test if
> this new patch works on your environment? Thanks!
> 
> En-Wei,
> Best regards.


