Return-Path: <netdev+bounces-127293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D58F974E4F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B371C26A4C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9DE18593A;
	Wed, 11 Sep 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f41SzjDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AE183CB8;
	Wed, 11 Sep 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046074; cv=none; b=oX5jP0obtWTZzd4i6QXVohnkfgcA6LM0RcKPHWJeMh/8PlHPPBLF34pLvrW+ZltSA+i5mZb+sjJCSdVtRkiJMi2cCfozb92oX6d82QDpCSPysgWFmaNGWpUB5vfhz2JCcaAMAPh58IGPhoRu7XlLX/N6o9b0BVwllUCBDClnAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046074; c=relaxed/simple;
	bh=k63Xb5JdFWNvwvex9LRCUWIaHk8AWqg543ojPWu+5uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeyqZ9C5RfLaWbyOQQjF1cgPQt2uQC0UgbFeCKwvOUWsXsgURSqKsJOeo6UnsAlhf3eMnyQNeMRaY6rv6CekjDKspOSDATsfCim27ZLRB4n/9LtM5pl/xafvKr89kdMyZpZ7TZzYbPIjlgp4VcxIgtG6vYcRYg/Fux4n0D+XRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f41SzjDf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso2113494a12.1;
        Wed, 11 Sep 2024 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726046069; x=1726650869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J4m6whvAlloaXv0IhhihhHg3Z82jfxR5j2mp47TZX3g=;
        b=f41SzjDftKjVUr8y5T9IJvebKgEXEpYdE1JqSkkeK5ZuWIM/JnGx/3hSAChhtrpypL
         kzDIhYuz8YZmwv80JFYSSU1ZImFF7/Gz9G+Vm0EccqObcJQo9hI3RAyv6aEVNn0GGTmX
         vv9RPvSBrll/V4OPbsItCI/r2/JsSn67EvrmL74/dhB6V9AVgqkohWoDw0LJrLCm9TBK
         APtQwo0cs6L3IIGv9djbxp+W0X2y23svs22ko00ETQeHY+yVlOR414cpttw9IyqWGvX5
         gpYVhLrQdG16ZxYQ026hsxxqnjxhnqs9On+DtxM3q9uYhaMYkoLToKq7iwElSwuRnOnl
         S+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046070; x=1726650870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4m6whvAlloaXv0IhhihhHg3Z82jfxR5j2mp47TZX3g=;
        b=cZid42bmlSUNVfXHrvLi3uJ9vKoShoj396Y16kVGvpOTE4a5eRxJcHvKszlp+iYRLp
         fqdqA7sjGlD8IXlE5uoWJRLz4Es0qWQsjy/GTprtu+0gkjy9XcL2TFRQctpmSciKD3qS
         Z286AiXaGGfBiJKdBGQ59oQ3t085RPhQoV2AMmy5itRcUoQJG1fH4OhuagNM+fwZeAvY
         x346FWlcoUTCR5zroZGxm1UH0aztrPz/rEMlCCp94Ba4/yRRLifwrjGEZ9YsyW59Txw6
         w5wPTWAwmZB+FSoMyudMaIYiq/mujnu/TAVMmBJu7W61ukZuMmW27Sw4OjfpJbkMPoNw
         NEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0VxIDrX1CFn5TagyBQQIqv1nZEcmhQVbahP3GiBHrKjzkiRWUXpcbuyJRIprN+C3Ee5vCVvEB@vger.kernel.org, AJvYcCXXwqEMeY62C8T4c02O3Jv9EDWEoXMFFzgL8bQLEtl+97QBFllsu13FlwV2ycKYvTDaqwFahpCBF3j4iZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yZJAXgdbMqhDLMPALwC/+PEh4yLOl72U4saDGgI1JgnBeme7
	sbOt4ICsgxsg0VwICMom2puoXIIWLbL1l3ipI/Qp22L2clHpC2MO
X-Google-Smtp-Source: AGHT+IGLso4CDdytxsKCOsVdY2doq/i6PZ+8fpyqNyawtoyXgd+r0IxTmH5OALSWPHhZqCYKmtDDqw==
X-Received: by 2002:a17:907:25c6:b0:a8d:3b04:29db with SMTP id a640c23a62f3a-a90048c7949mr266336466b.39.1726046068889;
        Wed, 11 Sep 2024 02:14:28 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c1da:1f00:388c:fb65:b9fd:94c3? (dynamic-2a01-0c23-c1da-1f00-388c-fb65-b9fd-94c3.c23.pool.telefonica.de. [2a01:c23:c1da:1f00:388c:fb65:b9fd:94c3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8d25d63bebsm589190066b.207.2024.09.11.02.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:14:28 -0700 (PDT)
Message-ID: <1f8c55ea-4995-4879-9505-8f80fcf67e67@gmail.com>
Date: Wed, 11 Sep 2024 11:14:29 +0200
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
 <038166f4-9c47-4017-9543-4b4a5ca503f5@gmail.com>
 <CAMqyJG0-35Phq1i3XkTyJfjzk07BNuOvPyDpdbFECzbEPHp_ig@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAMqyJG0-35Phq1i3XkTyJfjzk07BNuOvPyDpdbFECzbEPHp_ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.09.2024 09:01, En-Wei WU wrote:
>> What is the link partner in your case?
> My link partner is FS S3900-48T4S switch.
> 
>>  If you put a simple switch in between, does this help?
> I just put a simple D-link switch in between with the original kernel,
> the issue remains (re-plugging it after 3 seconds).
> 
>> It makes more the impression that after 3s of link-down the chip (PHY?)
>> transitions to a mode where it doesn't wake up after re-plugging the cable.
> I've done a ftrace on the r8169.ko and the phy driver (realtek.ko),
> and I found that the phy did wake up:
> 
>    kworker/u40:4-267   [003]   297.026314: funcgraph_entry:
>        |      phy_link_change() {
> 3533    kworker/u40:4-267   [003]   297.026315: funcgraph_entry:
>  6.704 us   |        netif_carrier_on();
> 3534    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
>             |        r8169_phylink_handler() {
> 3535    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
>  0.257 us   |          rtl_link_chg_patch();
> 3536    kworker/u40:4-267   [003]   297.026324: funcgraph_entry:
>  4.026 us   |          netif_tx_wake_queue();
> 3537    kworker/u40:4-267   [003]   297.026328: funcgraph_entry:
>             |          phy_print_status() {
> 3538    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
>  0.245 us   |            phy_duplex_to_str();
> 3539    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
>  0.240 us   |            phy_speed_to_str();
> 3540    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> + 12.798 us  |            netdev_info();
> 3541    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> + 14.385 us  |          }
> 3542    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> + 21.217 us  |        }
> 3543    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> + 28.785 us  |      }
> 
> So I doubt that the issue isn't necessarily related to the ALDPS,
> because the PHY seems to have woken up.
> 
> After looking at the reset function (plus the TX queue issue
> previously reported by the user) , I'm wondering if the problem is
> related to DMA:
> static void rtl_reset_work(struct rtl8169_private *tp) {
>     ....
>     for (i = 0; i < NUM_RX_DESC; i++)
>          rtl8169_mark_to_asic(tp->RxDescArray + i);
>     ....
> }
> 
Thanks for re-testing. I don't think it's something on the MAC side.
For the MAC it should make no difference whether the reset is done
during link-down or after link-up. Therefore I believe it's something
on the PHY side.
Also wrt ALDPS: Do you have the firmware for the NIC loaded?

> On Wed, 11 Sept 2024 at 01:06, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 09.09.2024 07:25, En-Wei WU wrote:
>>> Hi Heiner,
>>>
>>> Thank you for the quick response.
>>>
>>> On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 06.09.2024 10:35, En-Wei Wu wrote:
>>>>> The commit 621735f59064 ("r8169: fix rare issue with broken rx after
>>>>> link-down on RTL8125") set a reset work for RTL8125 in
>>>>> r8169_phylink_handler() to avoid the MAC from locking up, this
>>>>> makes the connection broken after unplugging then re-plugging the
>>>>> Ethernet cable.
>>>>>
>>>>> This is because the commit mistakenly put the reset work in the
>>>>> link-down path rather than the link-up path (The commit message says
>>>>> it should be put in the link-up path).
>>>>>
>>>> That's not what the commit message is saying. It says vendor driver
>>>> r8125 does it in the link-up path.
>>>> I moved it intentionally to the link-down path, because traffic may
>>>> be flowing already after link-up.
>>>>
>>>>> Moving the reset work from the link-down path to the link-up path fixes
>>>>> the issue. Also, remove the unnecessary enum member.
>>>>>
>>>> The user who reported the issue at that time confirmed that the original
>>>> change fixed the issue for him.
>>>> Can you explain, from the NICs perspective, what exactly the difference
>>>> is when doing the reset after link-up?
>>>> Including an explanation how the original change suppresses the link-up
>>>> interrupt. And why that's not the case when doing the reset after link-up.
>>>
>>> The host-plug test under original change does have the link-up
>>> interrupt and r8169_phylink_handler() called. There is not much clue
>>> why calling reset in link-down path doesn't work but in link-up does.
>>>
>>> After several new tests, I found that with the original change, the
>>> link won't break if I unplug and then plug the cable within about 3
>>> seconds. On the other hand, the connections always break if I re-plug
>>> the cable after a few seconds.
>>>
>> Interesting finding. 3 seconds sounds like it's unrelated to runtime pm,
>> because this has a 10s delay before the chip is transitioned to D3hot.
>> It makes more the impression that after 3s of link-down the chip (PHY?)
>> transitions to a mode where it doesn't wake up after re-plugging the cable.
>>
>> Just a wild guess: It may be some feature like ALDPS (advanced link-down
>> power saving). Depending on the link partner this may result in not waking
>> up again, namely if the link partner uses ALDPS too.
>> What is the link partner in your case? If you put a simple switch in between,
>> does this help?
>>
>> In the RTL8211F datasheet I found the following:
>>
>> Link Down Power Saving Mode.
>> 1: Reflects local device entered Link Down Power Saving Mode,
>> i.e., cable not plugged in (reflected after 3 sec)
>> 0: With cable plugged in
>>
>> This is a 1Gbps PHY, but Realtek may use the same ALDPS mechanism with the
>> integrated PHY of RTL8125. The 3s delay described there perfectly matches
>> your finding.
>>
>>> With this new patch (reset in link-up path), both of the tests work
>>> without any error.
>>>
>>>>
>>>> I simply want to be convinced enough that your change doesn't break
>>>> behavior for other users.
>>>>
>>>>> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
>>>>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
>>>>> ---
>>>>>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
>>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> index 3507c2e28110..632e661fc74b 100644
>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
>>>>>  enum rtl_flag {
>>>>>       RTL_FLAG_TASK_ENABLED = 0,
>>>>>       RTL_FLAG_TASK_RESET_PENDING,
>>>>> -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>>>>>       RTL_FLAG_TASK_TX_TIMEOUT,
>>>>>       RTL_FLAG_MAX
>>>>>  };
>>>>> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
>>>>>  reset:
>>>>>               rtl_reset_work(tp);
>>>>>               netif_wake_queue(tp->dev);
>>>>> -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
>>>>> -             rtl_reset_work(tp);
>>>>>       }
>>>>>  out_unlock:
>>>>>       rtnl_unlock();
>>>>> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_device *ndev)
>>>>>       if (netif_carrier_ok(ndev)) {
>>>>>               rtl_link_chg_patch(tp);
>>>>>               pm_request_resume(d);
>>>>> -             netif_wake_queue(tp->dev);
>>>>> -     } else {
>>>>> +
>>>>>               /* In few cases rx is broken after link-down otherwise */
>>>>>               if (rtl_is_8125(tp))
>>>>> -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
>>>>> +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>>>> +             else
>>>>> +                     netif_wake_queue(tp->dev);
>>>>
>>>> This call to netif_wake_queue() isn't needed any longer, it was introduced with
>>>> the original change only.
>>>>
>>>>> +     } else {
>>>>>               pm_runtime_idle(d);
>>>>>       }
>>>>>
>>>>
>>>
>>> CC. Martin Kjær Jørgensen  <me@lagy.org>, could you kindly test if
>>> this new patch works on your environment? Thanks!
>>>
>>> En-Wei,
>>> Best regards.
>>


