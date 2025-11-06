Return-Path: <netdev+bounces-236514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA3C3D7E9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 22:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3222C4E0EF9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F43064BD;
	Thu,  6 Nov 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eEnrZTuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE43064A4
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464433; cv=none; b=WaZAhLeD6d0fLmNr4cm9iFBKRRmHtM4zpaw4SV64RmTGMwExizTZoq9+xb8NrwDxyHJJz3nwkbdBmGmO+9ZoRPfo3g7NGwSezoEnr8UyUs9Sy7rxf8NsuhvjO0PkJh8QiCNK9WJ7eqgY3KPVxI4LeXZLV/3R1AXISDqOnARaVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464433; c=relaxed/simple;
	bh=FYSKozxsphHhSnFuMlU6acNkyuBXeYvex6fsRdvNKxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg2s2afPFVCpAnxLIjw2FCuFdPu66Vafw/vKu8Vi6NgS2cDK9Y3Hc9J+u6LHBAGhRYO6bQpFsVBmrj9c5wvw9UX/bTohm8SNPGZMbs3kCSzCUXR84Qa3dgX+l84euYRIq1ELSLFmfslCXmbvLQcqvxunMR3ibU5AphxloRChlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eEnrZTuC; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-4334e884b9dso269975ab.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 13:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464431; x=1763069231;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bq1kDHzzeUC5/5qzBKK+XJi+hezEO+Qt7PAq3T7/Vv8=;
        b=Xp8s2LST6Eo1Od5G8TP7CScwcobDTZ8hGoLzjxwzskxQFAcHnrJec1LcAJQrlQ4TLt
         OhurVXxlWUN4m3QyWvgRczFsUHTvbKlA67jv7m8fAfTgv5LMLYq10Y3czBeV5QQC537a
         DPWi+PQcNuEavpvZ/rHyV0hwKTMa3YaLXfGYlBGVCebMehf7jM/XnO1seSqZaokTIuiI
         vJKSCqNq0iMmxHz4f4/ZyQV/YMRE9c4mXllaOVPCEwbu3nkOGkjR4sVUkqjX1/2NYy9w
         b7jiHDsecgkxAra3yn+qrA2DqTQMYfFqUrZbVXNqQUdIju//ab4AydLFO+k9GhNrIzwx
         vAvA==
X-Gm-Message-State: AOJu0YyQsFOGAMK8lthFueni5YEdflLe8ehpieH4VPC9d6AtaisWLGYO
	FB4nE8zMAwkCnUwOjHJ5++Tx5xywFo+BJVE6yUlZAPE3cb7t1bPOqS5phWkMFQYGuXcyh2t7cCm
	Ggpugu19/ZQzWiNrh5k+6lJHWZex2hE5vY59swRt8aZ21W4jrS4xNwWNutIMg3lN/DSMl84Lzdi
	ixQ3+WwCxvKI9Ff3YajkFNx2tJSAmsZogQA5tvGl3gED47rEtaRPhizEHllKlbyNEa9U2IYoNr0
	f/h96mK/rvMXLu0
X-Gm-Gg: ASbGnctfTnQbtQBgWuMWq5YeM07GD4sEidJlmMmgAJ5TEkv0U3/hgjC2BGu/drc7D1J
	rkmhnrWoNtfIP+3idH2Vl4NR3yzbRnCwfyqGll01HA1NRnHKCEk/Zji9BuBmW67YHqs7Xu1X0sI
	lywmjSlTqSUbJdOJYOkWKT8+Bx4bx2nqqKDzl+i8//k6sEKTAOzXuU9j4S9shxlSkx6MHReENYY
	EciiRsqo1KN3SgD+Cm5rxmzqKF5yHfG7+56X0NG3Dp/FUwXYb39YXxvbOPwMrOoxzJY1tIAz2Gi
	nERt8h4EwbehzMaK/c2bCvCMxp2RUWoN3eQQKnQLmxj0almr1AmLnqWZ2FP47WrjpZx7cDYLjcv
	9Z1JZnE5HhYx0bPymv+C54Z7iP9I6JQfZBCfCjtCcNFq35q2mYk1Rgx9sh/WWEFZ/wCh/ZPlBTN
	O5Lzq+UBJuEqnmmy+RlqFAyCVJHM4iOMfSWTxDTBs=
X-Google-Smtp-Source: AGHT+IGDfCuMjtQZXmTDoPWUblF3RycxYefwCd1bQyZeNrXplXhmeNdOBWfgHKFan5q7mWtja2s3KpYPZ8q0
X-Received: by 2002:a05:6e02:194c:b0:433:2dd5:f573 with SMTP id e9e14a558f8ab-4335efc1fb8mr18257485ab.3.1762464431211;
        Thu, 06 Nov 2025 13:27:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f4cd466sm2785875ab.33.2025.11.06.13.27.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:27:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2359efeb3so20645785a.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762464430; x=1763069230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq1kDHzzeUC5/5qzBKK+XJi+hezEO+Qt7PAq3T7/Vv8=;
        b=eEnrZTuChap+j/p/IiY3zpxskuA7ZkTkWyKIAjedHww7AFNCUxQoav35JEziWm7MEo
         3307a3/nQLoZE7pedUXpRKPQlZzmqzMl0drRdloiXTUNaU45mTcI0rrJcPxHAeyby4E1
         leFdFrRu0D/YRMSrGMFujWpbwjyV37ugxEvA0=
X-Received: by 2002:a05:620a:2905:b0:7fe:e18:d4b7 with SMTP id af79cd13be357-8b235122dbamr574932285a.13.1762464429740;
        Thu, 06 Nov 2025 13:27:09 -0800 (PST)
X-Received: by 2002:a05:620a:2905:b0:7fe:e18:d4b7 with SMTP id af79cd13be357-8b235122dbamr574928785a.13.1762464429253;
        Thu, 06 Nov 2025 13:27:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e615bsm271777385a.19.2025.11.06.13.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:27:06 -0800 (PST)
Message-ID: <f5c2f410-36da-41a0-8d61-ffdd88096513@broadcom.com>
Date: Thu, 6 Nov 2025 13:27:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: Allow disabling pause on
 panic
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Antoine Tenart <atenart@kernel.org>, Yajun Deng <yajun.deng@linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
 <20251104221348.4163417-2-florian.fainelli@broadcom.com>
 <CAAVpQUAXPadkvRa7Rdo-_bQOpH5XRr+GST4cdv6G-be=SQ5sAQ@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CAAVpQUAXPadkvRa7Rdo-_bQOpH5XRr+GST4cdv6G-be=SQ5sAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/4/25 14:44, Kuniyuki Iwashima wrote:
> On Tue, Nov 4, 2025 at 2:13 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> Development devices on a lab network might be subject to kernel panics
>> and if they have pause frame generation enabled, once the kernel panics,
>> the Ethernet controller stops being serviced. This can create a flood of
>> pause frames that certain switches are unable to handle resulting a
>> completle paralysis of the network because they broadcast to other
>> stations on that same network segment.
>>
>> To accomodate for such situation introduce a
>> /sys/class/net/<device>/disable_pause_on_panic knob which will disable
>> Ethernet pause frame generation upon kernel panic.
>>
>> Note that device driver wishing to make use of that feature need to
>> implement ethtool_ops::set_pauseparam_panic to specifically deal with
>> that atomic context.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   Documentation/ABI/testing/sysfs-class-net | 16 +++++
>>   include/linux/ethtool.h                   |  3 +
>>   include/linux/netdevice.h                 |  1 +
>>   net/core/net-sysfs.c                      | 34 ++++++++++
>>   net/ethernet/Makefile                     |  3 +-
>>   net/ethernet/pause_panic.c                | 81 +++++++++++++++++++++++
>>   6 files changed, 137 insertions(+), 1 deletion(-)
>>   create mode 100644 net/ethernet/pause_panic.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
>> index ebf21beba846..f762ce439203 100644
>> --- a/Documentation/ABI/testing/sysfs-class-net
>> +++ b/Documentation/ABI/testing/sysfs-class-net
>> @@ -352,3 +352,19 @@ Description:
>>                  0  threaded mode disabled for this dev
>>                  1  threaded mode enabled for this dev
>>                  == ==================================
>> +
>> +What:          /sys/class/net/<iface>/disable_pause_on_panic
>> +Date:          Nov 2025
>> +KernelVersion: 6.20
>> +Contact:       netdev@vger.kernel.org
>> +Description:
>> +               Boolean value to control whether to disable pause frame
>> +               generation on panic. This is helpful in environments where
>> +               the link partner may incorrect respond to pause frames (e.g.:
>> +               improperly configured Ethernet switches)
>> +
>> +               Possible values:
>> +               == ==================================
>> +               0  threaded mode disabled for this dev
>> +               1  threaded mode enabled for this dev
> 
> nit: These lines need to be updated.
> 
> 
>> +               == ==================================
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index c2d8b4ec62eb..e014d0f2a5ac 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -956,6 +956,8 @@ struct kernel_ethtool_ts_info {
>>    * @get_pauseparam: Report pause parameters
>>    * @set_pauseparam: Set pause parameters.  Returns a negative error code
>>    *     or zero.
>> + * @set_pauseparam_panic: Set pause parameters while in a panic context. This
>> + *     call is not allowed to sleep. Returns a negative error code or zero.
>>    * @self_test: Run specified self-tests
>>    * @get_strings: Return a set of strings that describe the requested objects
>>    * @set_phys_id: Identify the physical devices, e.g. by flashing an LED
>> @@ -1170,6 +1172,7 @@ struct ethtool_ops {
>>                                    struct ethtool_pauseparam*);
>>          int     (*set_pauseparam)(struct net_device *,
>>                                    struct ethtool_pauseparam*);
>> +       void    (*set_pauseparam_panic)(struct net_device *);
>>          void    (*self_test)(struct net_device *, struct ethtool_test *, u64 *);
>>          void    (*get_strings)(struct net_device *, u32 stringset, u8 *);
>>          int     (*set_phys_id)(struct net_device *, enum ethtool_phys_id_state);
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index e808071dbb7d..2d4b07693745 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -2441,6 +2441,7 @@ struct net_device {
>>          bool                    proto_down;
>>          bool                    irq_affinity_auto;
>>          bool                    rx_cpu_rmap_auto;
>> +       bool                    disable_pause_on_panic;
>>
>>          /* priv_flags_slow, ungrouped to save space */
>>          unsigned long           see_all_hwtstamp_requests:1;
>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>> index ca878525ad7c..c01dc3e200d8 100644
>> --- a/net/core/net-sysfs.c
>> +++ b/net/core/net-sysfs.c
>> @@ -770,6 +770,39 @@ static ssize_t threaded_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RW(threaded);
>>
>> +static ssize_t disable_pause_on_panic_show(struct device *dev,
>> +                                           struct device_attribute *attr,
>> +                                           char *buf)
>> +{
>> +       struct net_device *ndev = to_net_dev(dev);
>> +       ssize_t ret = -EINVAL;
>> +
>> +       rcu_read_lock();
>> +       if (dev_isalive(ndev))
>> +               ret = sysfs_emit(buf, fmt_dec, READ_ONCE(ndev->disable_pause_on_panic));
>> +       rcu_read_unlock();
>> +
>> +       return ret;
>> +}
>> +
>> +static int modify_disable_pause_on_panic(struct net_device *dev, unsigned long val)
>> +{
>> +       if (val != 0 && val != 1)
>> +               return -EINVAL;
> 
> Should we validate !ops->set_pauseparam_panic here
> rather than disable_pause_on_device() ?

Yes we should certainly do it here to give an early warning to users 
whether this will work or not. To keep things simple however, we would 
still need to check set_pauseparam_panic in the panic handler, otherwise 
we would have to construct a list of network devices that do support the 
operation and use that.

> 
> ops = dev->ethtool_ops;
> if (!ops || !ops->set_pauseparam_panic)
>      return -EOPNOTSUPP;
> 
> 
>> +
>> +       WRITE_ONCE(dev->disable_pause_on_panic, val);
>> +
>> +       return 0;
>> +}
>> +
>> +static ssize_t disable_pause_on_panic_store(struct device *dev,
>> +                                            struct device_attribute *attr,
>> +                                            const char *buf, size_t len)
>> +{
>> +       return netdev_store(dev, attr, buf, len, modify_disable_pause_on_panic);
>> +}
>> +static DEVICE_ATTR_RW(disable_pause_on_panic);
>> +
>>   static struct attribute *net_class_attrs[] __ro_after_init = {
>>          &dev_attr_netdev_group.attr,
>>          &dev_attr_type.attr,
>> @@ -800,6 +833,7 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
>>          &dev_attr_carrier_up_count.attr,
>>          &dev_attr_carrier_down_count.attr,
>>          &dev_attr_threaded.attr,
>> +       &dev_attr_disable_pause_on_panic.attr,
>>          NULL,
>>   };
>>   ATTRIBUTE_GROUPS(net_class);
>> diff --git a/net/ethernet/Makefile b/net/ethernet/Makefile
>> index e03eff94e0db..9b1f3ff8695a 100644
>> --- a/net/ethernet/Makefile
>> +++ b/net/ethernet/Makefile
>> @@ -3,4 +3,5 @@
>>   # Makefile for the Linux Ethernet layer.
>>   #
>>
>> -obj-y                                  += eth.o
>> +obj-y                                  += eth.o \
>> +                                          pause_panic.o
>> diff --git a/net/ethernet/pause_panic.c b/net/ethernet/pause_panic.c
>> new file mode 100644
>> index 000000000000..8ef61eb768a0
>> --- /dev/null
>> +++ b/net/ethernet/pause_panic.c
>> @@ -0,0 +1,81 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Ethernet pause disable on panic handler
>> + *
>> + * This module provides per-device control via sysfs to disable Ethernet flow
>> + * control (pause frames) on individual Ethernet devices when the kernel panics.
>> + * Each device can be configured via /sys/class/net/<device>/disable_pause_on_panic.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/panic_notifier.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/ethtool.h>
>> +#include <linux/notifier.h>
>> +#include <linux/if_ether.h>
>> +#include <net/net_namespace.h>
>> +
>> +/*
>> + * Disable pause/flow control on a single Ethernet device.
>> + */
>> +static void disable_pause_on_device(struct net_device *dev)
>> +{
>> +       const struct ethtool_ops *ops;
>> +
>> +       /* Only proceed if this device has the flag enabled */
>> +       if (!READ_ONCE(dev->disable_pause_on_panic))
>> +               return;
>> +
>> +       ops = dev->ethtool_ops;
>> +       if (!ops || !ops->set_pauseparam_panic)
>> +               return;
>> +
>> +       /*
>> +        * In panic context, we're in atomic context and cannot sleep.
>> +        */
>> +       ops->set_pauseparam_panic(dev);
>> +}
>> +
>> +/*
>> + * Panic notifier to disable pause frames on all Ethernet devices.
>> + * Called in atomic context during kernel panic.
>> + */
>> +static int eth_pause_panic_handler(struct notifier_block *this,
>> +                                       unsigned long event, void *ptr)
>> +{
>> +       struct net_device *dev;
>> +
>> +       /*
>> +        * Iterate over all network devices in the init namespace.
>> +        * In panic context, we cannot acquire locks that might sleep,
>> +        * so we use RCU iteration.
>> +        * Each device will check its own disable_pause_on_panic flag.
>> +        */
>> +       rcu_read_lock();
>> +       for_each_netdev_rcu(&init_net, dev) {
>> +               /* Reference count might not be available in panic */
>> +               if (!dev)
>> +                       continue;
> 
> This seems unnecessary unless while() + next_net_device_rcu()
> is used instead of for_each_netdev_rcu().
> 
> Or are we assuming that something could overwrite NULL to
> dev->dev_list.next and panic ?

In panic context not much can happen by this point, so I presume we can 
just walk the list of network devices in the init space with no specific 
locking or protection of any sort.

Thanks for your review!
-- 
Florian

