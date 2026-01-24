Return-Path: <netdev+bounces-253110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IKNLpY4dWloCQEAu9opvQ
	(envelope-from <netdev+bounces-253110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:24:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CF7F0BC
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CD35300B103
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBAC217722;
	Sat, 24 Jan 2026 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIEm3dlR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D092737E3
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769289873; cv=none; b=Z1VbVHoDmdAN54zxNnialpfXDk73E8QTW73gEufH5zhcPyvZhIwkZgnnzO94o4Cyz6wHbDV57XHmKgDRyq3UOOJW9kuiRgss9mP1pRLOxvqaUMPN9CTaWuRhaJSBkVMATamB8A6MgyJ2lNSM6R6ZB1dCO/+iDAJRxPXCf7kGJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769289873; c=relaxed/simple;
	bh=A84JJ0XpgcLGOiITPiKFdUjMa7lfdTLwyHkwgIuR3FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbJkyuGtAhCl88jUVRQ+UEF4jO84DS1Wf3fbfsVw5l7jbPuw7RWJYhe1hlMMlfL2XXJE0bBU0WMEVV2Z80WH/N5jK66eibepN3rJpCoM0YAVQFoH3KgkUYzjzIs79e5/me3OIot4z2CVRmfN9lDqAYVXTLbbmAyYVGkXfc3aITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIEm3dlR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so36761025e9.2
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769289871; x=1769894671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XULfkdAlET0A699pHhCQs9Fxp1jyicZoNolAS38Xy80=;
        b=XIEm3dlRKrEMQcYa7EGcxMg+6UT1D86JVAaFb/tH0ojtMlQ/FHAqYgAr8Va6rzqSwY
         vbTE+9MJ5UPKUiunpUHD1qqKSidLXQGgrYMPNrZHxy+vrIiJmHiWNoKUzQJoYi0c0tTN
         HCs3Yo9rUaHzmUdZ8KVMNcopN8221M19DFiv9uadLTaYgRD2/a6EbtL43/jr5q4/Hw3w
         XXRttHKFxMyVQyhcp7Ryo15mPXEM9eaq57ZcEcgZkrlpLRMcfGB/JB9mZ+2uFga+UK2e
         d9ISc95ilbXMacGnfJi8CaL0Bd8IXdZacknIO2xTpVoH0VFeoyzbwl1rXHZNdzFzMp9U
         gRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769289871; x=1769894671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XULfkdAlET0A699pHhCQs9Fxp1jyicZoNolAS38Xy80=;
        b=Gx6ikiUQ4nDmvSiu+3MeIZxQYtyqDlka1ZrdWIyaw71fXgVeOEqVlcMCUlkdq9cFEw
         UpUiYTaurchUzPN4jQtu2At1SxpNWWQvvM0i6Vude37nRhuhby8qyUXbQKlr/FWzrRKj
         +fx13b/sHclXPCspr/K0d3ERsa5J096UYb+fyXYFRuEH5FeoCyRpdmOWl4+QdIuEDuyd
         5Q9Ib86uXuhYRa+kXITksScLQIbSUiDnc5dQVq/vHTG3oj9bYhlIYOe6d6SQt41GsjT4
         k701GFC8gYGb7P4ZqRO5oTNU3mkBvEA+JtrebZsDBRVVOcMGK0mus+pDiGQxK9cPqw+t
         j4Pg==
X-Gm-Message-State: AOJu0YypkbHulkIJLIckRDI9HAL0/e4+bWo3COuvR+74/o4ZIL6o5WwR
	MPPp1iEcq4P/T5/EIrr76keL3QvqwXO3gQNiUVpr2To94aLFodd1ldWW
X-Gm-Gg: AZuq6aJCvMUsAhPC96k7zmSruEFWHSMcjC+fwLcWpkbBQ+JKDeSngqW/eK3DJj8Uxfb
	CfqnuW+5m9Qk1vnXYoDfZzlrtJU6sK3PvUX9yBE0kwY3hlck0tuLmL20P0M+WrJYfbx5uQk9fdV
	G2NjTCajKq2MxjWDt8jujqWAsy16r1Yr5F7gjKi3cjVCnJHccZaU42uQ5n3t7nKMzKMehJ3vfkf
	SbOoBSZv+X8UxvulS7dAYQ/S6hqngdEi/suflfbhxal0OuFo40qQBsRFr3w5qwFvwU5udFa9Vkx
	JmflTo3VvNYPBWb0X6ADmvoNoYmmODGxF7cVM17XgXZD0TRrDtsZVrUN9uT4NyUj34Wi+/zHpw7
	jCFsPWyoD3HHgexduMBm8VxWnAdXa+SVvBefVtKonDbN8l+069nzrgsCX7Ee9vXO8f4zZ+GEF1z
	TiEr7rGoJfKb3fyNfeEJ5DfnDwFumG50zpcj+eJbtXh891DRGRR/xUoFBy0kW0WrpZY6TO01ok/
	gNFLgtvvHmXhj1f5t8ArAYi1RsuhKqwksTArXnl4JVpREJHy9JLg9LUwuoZiHm1
X-Received: by 2002:a05:600c:34d3:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-48051905a38mr88022735e9.10.1769289870402;
        Sat, 24 Jan 2026 13:24:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2c:b000:9cd8:dac0:8b53:119f? (p200300ea8f2cb0009cd8dac08b53119f.dip0.t-ipconnect.de. [2003:ea:8f2c:b000:9cd8:dac0:8b53:119f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804702876asm258671545e9.1.2026.01.24.13.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 13:24:29 -0800 (PST)
Message-ID: <1029930d-39d9-4003-a0ee-026b687af27d@gmail.com>
Date: Sat, 24 Jan 2026 22:24:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
To: =?UTF-8?B?6K645L+K5Lyf?= <javen_xu@realsil.com.cn>,
 Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
 <20260112024541.1847-4-javen_xu@realsil.com.cn>
 <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
 <a244b2c5-b3d6-4150-b9ab-8be20d72bf23@redhat.com>
 <bffa03f0eb9f405388b5436882776111@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <bffa03f0eb9f405388b5436882776111@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253110-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 052CF7F0BC
X-Rspamd-Action: no action

On 1/22/2026 2:42 AM, 许俊伟 wrote:
>> On 1/12/26 11:20 PM, Heiner Kallweit wrote:
>>> On 1/12/2026 3:45 AM, javen wrote:
>>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>>
>>>> This patch adds support for chip RTL9151AS. Since lacking of Hardware
>>>> version IDs, we use TX_CONFIG_V2 to recognize RTL9151AS and coming
>> chips.
>>>> rtl_chip_infos_extend is used to store IC information for RTL9151AS
>>>> and coming chips. The TxConfig value between RTL9151AS and RTL9151A
>>>> is
>>>>
>>>> different.
>>>>
>>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>>> ---
>>>>  drivers/net/ethernet/realtek/r8169.h      |  3 ++-
>>>>  drivers/net/ethernet/realtek/r8169_main.c | 28
>>>> +++++++++++++++++++++--
>>>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/realtek/r8169.h
>>>> b/drivers/net/ethernet/realtek/r8169.h
>>>> index 2c1a0c21af8d..f66c279cbee6 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169.h
>>>> +++ b/drivers/net/ethernet/realtek/r8169.h
>>>> @@ -72,7 +72,8 @@ enum mac_version {
>>>>      RTL_GIGA_MAC_VER_70,
>>>>      RTL_GIGA_MAC_VER_80,
>>>>      RTL_GIGA_MAC_NONE,
>>>> -    RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
>>>> +    RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1,
>>>> +    RTL_GIGA_MAC_VER_CHECK_EXTEND
>>>>  };
>>>>
>>>>  struct rtl8169_private;
>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>>>> b/drivers/net/ethernet/realtek/r8169_main.c
>>>> index 9b89bbf67198..164ad6570059 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>> @@ -95,8 +95,8 @@
>>>>  #define JUMBO_16K   (SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
>>>>
>>>>  static const struct rtl_chip_info {
>>>> -    u16 mask;
>>>> -    u16 val;
>>>> +    u32 mask;
>>>> +    u32 val;
>>>>      enum mac_version mac_version;
>>>>      const char *name;
>>>>      const char *fw_name;
>>>> @@ -205,10 +205,20 @@ static const struct rtl_chip_info {
>>>>      { 0xfc8, 0x040, RTL_GIGA_MAC_VER_03, "RTL8110s" },
>>>>      { 0xfc8, 0x008, RTL_GIGA_MAC_VER_02, "RTL8169s" },
>>>>
>>>> +    /* extend chip version*/
>>>> +    { 0x7cf, 0x7c8, RTL_GIGA_MAC_VER_CHECK_EXTEND },
>>>> +
>>>>      /* Catch-all */
>>>>      { 0x000, 0x000, RTL_GIGA_MAC_NONE }  };
>>>>
>>>> +static const struct rtl_chip_info rtl_chip_infos_extend[] = {
>>>> +    { 0x7fffffff, 0x00000000, RTL_GIGA_MAC_VER_64, "RTL9151AS",
>>>> +FIRMWARE_9151A_1},
>>>> +
>>>
>>> Seems all bits except bit 31 are used for chip detection. However
>>> register is named TX_CONFIG_V2, even though only bit 31 is left for actual tx
>> configuration.
>>> Is the register name misleading, or is the mask incorrect?
>>
>> @Heiner (double checking to avoid more confusion on my side): are you fine
>> with the register name? It's unclear to me if you are fine with just the 2
>> merged patches or even with this one.
>>
>> Thanks,
>>
>> Paolo
> 
> Hi, Paolo & Heiner
> 
> It appears that this patch has not been accepted yet. Should I resubmit it as a 
> separate  patch?
> 
I will slightly extend your patch to display the new extended XID properly
in places where the XID is printed, and submit it on your behalf.

> Thank,
> Javen Xu

Heiner

