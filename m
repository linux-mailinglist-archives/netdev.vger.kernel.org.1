Return-Path: <netdev+bounces-268522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB0dCYojuWkrrwEAu9opvQ
	(envelope-from <netdev+bounces-268522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:48:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B90ED2A733D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3444C303D10A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F136EA8B;
	Tue, 17 Mar 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuCIg2BO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454839E17B
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740675; cv=none; b=NhuQHtImY40fMJdrYt22EhC3Jarmg7w0xozeh74TkF/ETFZCKBVzMbtLhvk7IWXQc8P9FmyN012Fcj/JSBg6n/J6x0UkLMVrTbfAgGmEnrpUkcXVeHMQkW5xHJgeAe8maLOVzzC1vNWNVCDeO/DqJQ0/eNj6tIM/6VgimjvKZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740675; c=relaxed/simple;
	bh=PAMdidfnOf121kydypX0jEaZ+fkCpwsL2XJsRhSLSMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1oEegP2MTb07WXdyNnIz8cMLn7Tgc6HRd6C7t9K8LRQC4kgzhtAbyEfAqmpXG8j4AYCQ98zS/tMWArUnC2z+XGSELrl8r5orSbEzmTSOU9uyFIrk6toVHW5Z7X09r0zVOvaEVYiC0nZ5BMP9mwAi69FfQc+WvjAEBV5f1WTmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuCIg2BO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b9b190easo3943005f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 02:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740672; x=1774345472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+hEcaRdAr7anEus8IqUd1vdhfhd9o9G8hlpvoLUy98=;
        b=YuCIg2BOpKbQ0yy8+A7+O7cZjImzgD8ksYuTTXaFv6NAm3Qz/lgBdrm4ru3sj6f2eu
         xWZk2dVgF2qGJsW2wBBmCrDTTMQUiUsJLIQiALWmgBwWWjk3fT+leAQUQ3Ns9qzxJb9H
         6zklVu9noGCUwedPo/wn+26drmdaBu4T1AzWmaEYGC7dbpOhVlLQwuplmziMlKpu0Brn
         dBLPRiBnxPWYNZcJoaFexr374syBOxMEs3GRL4bGdWDH4IGXEG3pLaKHlm/LfMbag0wt
         7hHlbQN6GqR0zvxhPc2WRBkulCPrSIpmDGpC8NPkHPgjkxlmhYE8+QPuqb2iClSN+b81
         S0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740672; x=1774345472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+hEcaRdAr7anEus8IqUd1vdhfhd9o9G8hlpvoLUy98=;
        b=qgs0i36xwFHOQrymx+ffZJSCjOFc59wjpgaiwq+fNIeCREpm5DppBf3C3WFg8+CFPK
         E82vAehpaHsKxWUo1V2MiGtS30axZX0YXpuC2UFIKUsUNovgQnntxBx4PdMw+iKAYvSl
         Vx6kRS8R7iDPUUfR/Xy7dPPIlVFj/TSCWNy8TqZhKB3kK++5b8gZYlFMRnz9zMsKASWC
         4zhz9a5+J94Ee84Q4IytBbV9jIYo2swyHfNOe59vHPyAnO7MbMFtMlwRCxXAwYVVKEVA
         z1VzLiDrEckOdaoW5x+c2Q9jkF0KTpo7IdOTKYoMabJcQ9s4wzgFpZqBlLEcDC+M/45e
         Wfmw==
X-Forwarded-Encrypted: i=1; AJvYcCVGdj0vlSq2X5HXQBzXfSCK+QkEkuGtUBCpRXwN9Tb43zcIAtPoLsXfyOivz5P1Fve4jydiZCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUg3kf3L79zIfNZt/LURqJIcdmt68Q6SQBe3+RaJWJMkXAyyj
	t5vfKKbLui5qZWMNzSWTloAt789b3MCUn8XsYweiC5jjlJejgltRckt2
X-Gm-Gg: ATEYQzwuA/hypJs411OqoYx7/ZIfxOT97T7tDRTshwHgW3Xdu5lG1Y3Ml5n/2KIdrJS
	DqzkBlZ4qegfwoFU8+hhVSM3EnIf+HxkvxXbbTHUzKj5BydQltjOjqcB8e1ZkfbQ1P/hvkQ9PeQ
	XL4Nhpkw1aa59Njv5vT0oklYKcq3Ctg68wrMpi0Hm2ImqCpeVI2Lcmwp6qJO62C+VsczHP5ZHOA
	VaAPE2+9Eii+D+037iLBa2QaTA3f2S1MUEyNEdAA8Isvlcm6kJW9PnW2uzU10gtXKgQIN2hSi+Y
	AemxVSbPXGjZCAQmRQUeoVJt1zPX0LQmFZcAzQy1grjlvsnTFhV3fGvgThDm+Rms+ASUnENaPbo
	X9iV0klUNopxWk7ULuvt7WEX9D2DZrCgXU1Ccn2J+Yw973IHo/Ad99RpHh084NVR0QvNhw6oljJ
	bZWbnec1zgiXqbbQt6zFTFVG32A5mlXHNz8iJko8r1BJVCvy2YKXYIL39csLqkD6pNsTjR/pdz1
	6lIkAmDTMNQ1U/rA+XGi4JJPOVcGkT41+bSUfT0OtucAUAqa/1gBiQKh9uMqEhDCw==
X-Received: by 2002:a5d:638b:0:b0:43b:3be3:9a16 with SMTP id ffacd0b85a97d-43b3be39f78mr12948717f8f.38.1773740671845;
        Tue, 17 Mar 2026 02:44:31 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f31:8700:e117:6b03:72ec:d890? (p200300ea8f318700e1176b0372ecd890.dip0.t-ipconnect.de. [2003:ea:8f31:8700:e117:6b03:72ec:d890])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3e9a4fcdsm21982305f8f.8.2026.03.17.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 02:44:31 -0700 (PDT)
Message-ID: <7e39eb0e-d4eb-451f-bdb2-206ddd0a0b35@gmail.com>
Date: Tue, 17 Mar 2026 10:44:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and
 improve error reporting during probe
To: Anand Moon <linux.amoon@gmail.com>
Cc: "maintainer:8169 10/100/1000 GIGABIT ETHERNET DRIVER"
 <nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin
 <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>,
 Niklas Cassel <cassel@kernel.org>,
 "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>
References: <20260317061700.7734-1-linux.amoon@gmail.com>
 <c630aa45-0904-4b3c-a1f6-90b167741d27@gmail.com>
 <CANAwSgTG53wD+z8KBVs4e-n4za-f3xXZELRu6c61SV2Z+4dwMA@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CANAwSgTG53wD+z8KBVs4e-n4za-f3xXZELRu6c61SV2Z+4dwMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268522-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rock-chips.com,163.com,vger.kernel.org,arm.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B90ED2A733D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.03.2026 08:59, Anand Moon wrote:
> Hi Heiner,
> 
> Thanks for your review comments.
> 
> On Tue, 17 Mar 2026 at 12:21, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 17.03.2026 07:16, Anand Moon wrote:
>>> The driver currently assumes the PHY is always at address 0. On some
>>> hardware or buggy BIOS implementations, the PHY may reside at a
>>> different address on the MDIO bus. Update r8169_mdio_register()
>>> to scan the bus for the first available PHY instead of hardcoding
>>> address 0.
>>
>> No. The PHY always shows up at (virtual) address 0, due to the
>> MAC register based way of accessing the internal PHY.
>> Do you have any concrete example of such a "hardware or buggy bios"?
>>
> Sorry about that, I didn't realize. Unfortunately, my testing shows
> this still doesn't
> fix the problem, but I still perceive. I modeled the change after some
> other drivers,
> but clearly, that approach isn't working in this case.
>>>
>>> Additionally, switch to dev_err_probe() in the main probe path to
>>> provide standardized error handling and cleaner log output for
>>> registration failures.
>>>
>>> Link: https://lore.kernel.org/all/87bc37ee-234c-4568-b72e-955c130a6838@arm.com/
>>> Fixes: ec392abc9593 ("PCI: dw-rockchip: Enable async probe by default")
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Cc: Niklas Cassel <cassel@kernel.org>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 34 ++++++++++++++++-------
>>>  1 file changed, 24 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 791277e750ba..0fd735beff92 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -5427,7 +5427,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>>>  {
>>>       struct pci_dev *pdev = tp->pci_dev;
>>>       struct mii_bus *new_bus;
>>> -     int ret;
>>> +     struct phy_device *phydev;
>>> +     int ret, addr;
>>>
>>>       /* On some boards with this chip version the BIOS is buggy and misses
>>>        * to reset the PHY page selector. This results in the PHY ID read
>>> @@ -5462,18 +5463,31 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>>>       if (ret)
>>>               return ret;
>>>
>>> -     tp->phydev = mdiobus_get_phy(new_bus, 0);
>>> -     if (!tp->phydev) {
>>> +     /* find the first (lowest address) PHY on the current MAC's MII bus */
>>> +     for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
>>> +             struct phy_device *tmp = mdiobus_get_phy(new_bus, addr);
>>> +
>>> +             if (tmp) {
>>> +                     phydev = tmp;
>>> +                     break;
>>> +             }
>>> +     }
>>> +
>>> +     if (!phydev) {
>>> +             dev_err(&pdev->dev, "no PHY found on bus\n");
>>>               return -ENODEV;
>>> -     } else if (!tp->phydev->drv) {
>>> -             /* Most chip versions fail with the genphy driver.
>>> -              * Therefore ensure that the dedicated PHY driver is loaded.
>>> -              */
>>
>> This check is needed. It's seems your actual intention is something completely
>> different from what you state in the commit message. You try to find a workaround
>> for the issues with request_module() from async contect, caused by the referenced
>> change to Rockchip PCI.
> That makes sense, sorry for the noise.
> 
> What are your thoughts on using dev_err_probe() for these registration failures?
> I thought it might clean up the error path.
> 
I'm not aware of any realistic scenario where these calls would fail (w/o printing
an error message before). So adding an error message wouldn't hurt, but it also
wouldn't be beneficial enough to justify a patch.

> Thanks
> -Anand
>>
>>> +     }
>>> +
>>> +     /* Most chip versions fail with the genphy driver.
>>> +      * Therefore ensure that the dedicated PHY driver is loaded.
>>> +      */
>>> +     if (!phydev->drv) {
>>>               dev_err(&pdev->dev, "no dedicated PHY driver found for PHY ID 0x%08x, maybe realtek.ko needs to be added to initramfs?\n",
>>> -                     tp->phydev->phy_id);
>>> +                     phydev->phy_id);
>>>               return -EUNATCH;
>>>       }
>>>
>>> +     tp->phydev = phydev;
>>>       tp->phydev->mac_managed_pm = true;
>>>       if (rtl_supports_eee(tp))
>>>               phy_support_eee(tp->phydev);
>>> @@ -5790,11 +5804,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>
>>>       rc = r8169_mdio_register(tp);
>>>       if (rc)
>>> -             return rc;
>>> +             return dev_err_probe(&pdev->dev, rc, "mdio register failure\n");
>>>
>>>       rc = register_netdev(dev);
>>>       if (rc)
>>> -             return rc;
>>> +             return dev_err_probe(&pdev->dev, rc, "register newdev failure\n");
>>>
>>>       if (IS_ENABLED(CONFIG_R8169_LEDS)) {
>>>               if (rtl_is_8125(tp))
>>>
>>> base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
>>


