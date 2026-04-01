Return-Path: <netdev+bounces-273924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEiGDDrHzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7152375B8B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2519302964D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C437BE8C;
	Wed,  1 Apr 2026 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbIkInau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3437AA61
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028023; cv=none; b=SlCuM1ApTAiljt4mU2oOnoj2hJhuiXxm8a75Z8jxebsW2Nt/5Zi6zlhoNbgB50sfYuYHXAMRNizPXZzkENsvYZbJ5II69ns+xDRHB1rCnIqQzydcHfFaksHujFsAlZkJQQc7BflnTf42+8nbT9+Cy34ypcu8l7v1rBhQMMjYej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028023; c=relaxed/simple;
	bh=1C/fHWl+sG3yDAzWQbKnq15d8iX9CJ/Ux/8amMkuuqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP+uo25F7vRduF+Ot4nRvP82XAy7ZsWJQxgLL9QqiZIdfSaz8tH4oGupRPlcLzcbOqGgJlNB6UED81OCYpQ15DZHodvDq03H2QMXy9PylKH+DJHSWel0kCl11koUGwPrtmgRA1hrvWY37RmhL7P87wQzcIK69aHPREW412C88tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbIkInau; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fd27754bso63942605e9.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775028020; x=1775632820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F19Da554mA1vX8XitqGgImCzBrMPiaJr46jzt8QLeDo=;
        b=KbIkInausbNcpCzBmVR3GkFeenkmduukIq3QxITE0zUIH6I3mQx72dig1MS5O0bO6I
         Our6fYJhPiPhUJRG2ar/d14TVoafltHoUxmVIxUAd80OMm9YvdRU8N4ZaBinibedW5CE
         MEAWIkXpEUPig9TuwgPT4+itZMvRFQ3ANoAoFfoeFlvOk732hTn408cU8whgUzRtqmbN
         hY31Phb9BTP+LukFO9UUm8JcG4cZPOAfctsRjngGmEZHx0wC9qfpxxKyh/ym0PKlOfz7
         jpWPu9C0pEYF/QOnBRGAqRsFeMGegn0tMij5GiEUSxA4Citug2+WmYS0YKf4b10IhSSC
         O/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775028020; x=1775632820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F19Da554mA1vX8XitqGgImCzBrMPiaJr46jzt8QLeDo=;
        b=SdE21oEOgw/7zJp5C9nvUPfX41nenVl5KJuyMLccEamKNDNYyA4G3VabiiOYm8bFgN
         S+H5mhUvXfX94aImjoTZy/3Ts8mGIPhriH4YxwEMIjvkjpSGWg5N3wKFBoBFquPVye70
         yBmleHAtjCnrig/jKN1pS0QZ5qihbJ57XiKtTyCmH9YFhkXgSgosG6RR6y0z5FtnyReE
         93UVuSoOKvI0fLwC1uLG05cHPMESysM0gFCcLAdrpXzZJ9aUFKQd2aFTd2884HTM+ixr
         NBC4h9WG2Q0AGOSS0XpSXyUNAfpOCrC76q0bCeNReKuNx4NX4fG/z/1cInCS88vaOyuH
         Tzmw==
X-Gm-Message-State: AOJu0Yxv6P4PhTraXoB3/wexyNFeSrqxgUFJM62rMsWBnFiGuvkbv3Rp
	SqxoBeoX1Z1noiI9KGu9Xg09aPiZnHfIf6vQHDrr2wYM9kstQUG6xs6m
X-Gm-Gg: ATEYQzyiLIJFSACApgfOW+XVl7cTh/tDZl72q6o5OHiRuGaemE7Q6Lhg2CRQsBxHwvL
	G7vPHgzg1xXKGj96cwjhABAH/EuY+oT2lY8EyZMe6PM7+Dp0KyO/1VpV6vhBJmrv6ePDAzDr0ma
	hmIadbw8bBogK2KAtbJ/Pu+KYjYJP5BN5uRyzSMljYMFc672/sMQEVF6BUzDlblRIvVgGIB/urT
	9TF5/rD5EAuSjL/u/Zjt6g4JAeL0ioNFYl2JPMFhg/tmLLIOfNHU61wtSWRF4cqLUrvOcxOhqVX
	IKSjAWafCA3yuszQJ83GE39fNxGgNpqr7wviyOeWSvcF0e2wkUqKpF7QoxMlKLpe/MwazjNTZty
	pk1gvb1OnvqojDqoeL/DpNKw4nYqnUtTrdoZwrnZHWk37zgdIL2uDCt4BkOEyBE2/l/qnMlYeDr
	zQ11jbJzLr5YHZsPMUMSIrZcWxRNuKOyO6V51Zrza+V3rypVTzoNL4VP45QiIU3LRmi3lLvi4rW
	7suVwwqT8HkFSK8/+bPFF68GUln2oyS+MWbSO1k8i97AA5Jagr3Oqt6OTwO7D8=
X-Received: by 2002:a05:600c:310d:b0:487:18c:7acf with SMTP id 5b1f17b1804b1-48883599311mr37370055e9.25.1775028019966;
        Wed, 01 Apr 2026 00:20:19 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f29:9c00:8c4f:53a3:ddd3:1e0? (p200300ea8f299c008c4f53a3ddd301e0.dip0.t-ipconnect.de. [2003:ea:8f29:9c00:8c4f:53a3:ddd3:1e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm157689315e9.2.2026.04.01.00.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:20:19 -0700 (PDT)
Message-ID: <ded0854f-c318-42ed-82ec-655f47ea5d12@gmail.com>
Date: Wed, 1 Apr 2026 09:20:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
To: Javen <javen_xu@realsil.com.cn>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-3-javen_xu@realsil.com.cn>
 <d2b97f5b-6032-49fd-b80a-6fb47f3fad4c@gmail.com>
 <98d632aecbbb4dd8ad79c24e672765b1@realsil.com.cn>
 <fcb72518-24f7-4e16-8208-fb38441408d2@gmail.com>
 <761cc11222bc4f4cb206629a76292c97@realsil.com.cn>
 <cd96bc5c-1087-4d13-b556-e1fd94e6322e@gmail.com>
 <d4357d7d824f4558842fb1997dff7867@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <d4357d7d824f4558842fb1997dff7867@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273924-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7152375B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01.04.2026 03:43, Javen wrote:
>> On 17.03.2026 04:14, Javen wrote:
>>>> On 13.03.2026 08:25, Javen wrote:
>>>>>> On 02.03.2026 07:32, javen wrote:
>>>>>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>>>>>
>>>>>>> RTL8116af is a variation of RTL8168fp. It uses SerDes instead of PHY.
>>>>>>> But SerDes status will not relect to PHY. So it needs to add sfp
>>>>>>> mode for quirk to help reflect SerDes status during PHY read.
>>>>>>>
>>>>>>
>>>>>> Is there any mass market device using this chip version? As far as
>>>>>> possible I'd like to avoid adding support for chip versions that
>>>>>> never make it to the mass market. This just makes driver
>>>>>> maintenance
>>>> harder.
>>>>>>
>>>>>> The patch includes support for 100Mbps fiber mode. Is there any use
>>>>>> case for such legacy modes?
>>>>>>
>>>>>>
>>>>>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>>>>>> ---
>>>>>>>  drivers/net/ethernet/realtek/r8169_main.c | 71
>>>>>>> ++++++++++++++++++++---
>>>>>>>  1 file changed, 62 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> b/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> index fb2247a20c36..a5c0d3995328 100644
>>>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> @@ -726,6 +726,12 @@ enum rtl_dash_type {
>>>>>>>       RTL_DASH_25_BP,
>>>>>>>  };
>>>>>>>
>>>>>>> +enum rtl_sfp_mode {
>>>>>>> +     RTL_SFP_NONE,
>>>>>>> +     RTL_SFP_8168_AF,
>>>>>>> +     RTL_SFP_8127_ATF,
>>>>>>> +};
>>>>>>> +
>>>>>>>  struct rtl8169_private {
>>>>>>>       void __iomem *mmio_addr;        /* memory map physical address
>> */
>>>>>>>       struct pci_dev *pci_dev;
>>>>>>> @@ -734,6 +740,7 @@ struct rtl8169_private {
>>>>>>>       struct napi_struct napi;
>>>>>>>       enum mac_version mac_version;
>>>>>>>       enum rtl_dash_type dash_type;
>>>>>>> +     enum rtl_sfp_mode sfp_mode;
>>>>>>>       u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
>>>>>>>       u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
>>>>>>>       u32 dirty_tx;
>>>>>>> @@ -760,7 +767,6 @@ struct rtl8169_private {
>>>>>>>       unsigned supports_gmii:1;
>>>>>>>       unsigned aspm_manageable:1;
>>>>>>>       unsigned dash_enabled:1;
>>>>>>> -     bool sfp_mode:1;
>>>>>>>       dma_addr_t counters_phys_addr;
>>>>>>>       struct rtl8169_counters *counters;
>>>>>>>       struct rtl8169_tc_offsets tc_offset; @@ -1126,7 +1132,7 @@
>>>>>>> static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
>>>>>>>               return 0;
>>>>>>>
>>>>>>>       /* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY
>>>>>>> driver
>>>> */
>>>>>>> -     if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 *
>> MII_PHYSID2))
>>>>>>> +     if (tp->sfp_mode == RTL_SFP_8127_ATF && reg ==
>>>>>> (OCP_STD_PHY_BASE
>>>>>>> + + 2 * MII_PHYSID2))
>>>>>>>               return PHY_ID_RTL_DUMMY_SFP & 0xffff;
>>>>>>>
>>>>>>>       RTL_W32(tp, GPHY_OCP, reg << 15); @@ -1270,6 +1276,34 @@
>>>>>>> static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
>>>>>>>       return r8168_phy_ocp_read(tp, tp->ocp_base + reg * 2);  }
>>>>>>>
>>>>>>> +/* The quirk reflects RTL8116af SerDes status. */ static int
>>>>>>> +r8116af_mdio_read_quirk(struct rtl8169_private *tp, int reg) {
>>>>>>> +     u8 phyStatus = RTL_R8(tp, PHYstatus);
>>>>>>> +
>>>>>>> +     if (!(phyStatus & LinkStatus))
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     /* BMSR */
>>>>>>> +     if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMSR)
>>>>>>> +             return BMSR_ANEGCOMPLETE | BMSR_LSTATUS;
>>>>>>> +
>>>>>>> +     /* PHYSR */
>>>>>>> +     if (tp->ocp_base == 0xa430 && reg == 0x12) {
>>>>>>> +             if (phyStatus & _1000bpsF)
>>>>>>> +                     return 0x0028;
>>>>>>> +             else if (phyStatus & _100bps)
>>>>>>> +                     return 0x0018;
>>>>>>
>>>>>> This is a complete hack. Any means to access the SerDes directly?
>>>>>
>>>>> Hi, Heiner
>>>>> Now we find a indirect access to serdes reg. The serdes reg is
>>>>> designed
>>>> according to IEEE 802.3.
>>>>> BIT 2 means Link Status and BIT 5 means ANEGCOMPLETE. We can access
>>>>> it through read mac ocp 0xeb14, I wonder whether this indirect
>>>>> access can be
>>>> accepted?
>>>>>
>>>> Based on the bit numbers this seems to be the BMSR register. Can all
>>>> clause
>>>> 22 registers be accessed in a similar way so that a MII bus can be
>>>> implemented for accessing the SerDes?
>>>
>>> We checked our chip documentation and confirmed that the SerDes
>>> register file maps all clause 22 registers(e.g. WR 0xeb10<reg_addr>,
>>> RD 0xeb14. reg_addr 0x40 is for BMCR,
>>> 0x41 for BMSR, 0x42 for PHYSID1, 0x43 for PHYSID2, etc.) As you
>>> suggested, I wonder whether the proper approach is to implement a
>>> virtual mii_bus and map the standard serdes reg in the new map.
>>>
>> We'd need to know how the internal PHY and the SerDes play together.
>> Whether the usual internal PHY plays any role in communication between
>> MAC and SerDes.
>> How interface modes are controlled on MAC and SerDes side, etc.
>> If Realtek doesn't implement proper layering in hw, and doesn't have enough
>> knowledge about mainline network driver structures, and on the other hand
>> doesn't want to provide chip documentation, then the situation somewhat
>> deadlocks.
>>
> 
> Hi, Heiner
> For RTL8116af, the datapath is structured as MAC->PCS->SerDes.
> However, PCS block does not have a standard MDIO interface. Instead, we have to 
> access the standard reg via MAC OCP.These standard registers are exactly the standard 
> IEEE 802.3 Clause 22 PHY registers.
> Given hardware information above, I would like to ask for your advice on the recommended 
> approach to support RTL8116af. Or any other information do I need to provide?
> 

The described scenario MAC->PCS->SerDes is a standard scenario supported
by phylink, see e.g. phylink_pcs_ops and the drivers under drivers/net/pcs.
So you best get familiar with phylink, and start thinking about what it
would take to drive your IP blocks using phylink.

And still: Proper advice needs documentation as input. So if Realtek asks
for advice, they should also be willing to share datasheets etc.

> Thanks,
> Javen Xu
> 
>>>> In general it's hard to provide a statement w/o knowing the internal
>>>> layout of the IP blocks.
>>>> Can you provide any chip documentation / datasheet?
>>>> For proper support of such a component chain between MAC and SFP port
>>>> the driver would have to be converted to use phylink, what requires
>>>> access to the involved components, incl. the SFP I2C bus.
>>>>
>>>>
>>>>> Thanks,
>>>>> Javen Xu
>>>>>
>>>>>>
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int r8116af_mdio_read(struct rtl8169_private *tp, int reg) {
>>>>>>> +     return r8168g_mdio_read(tp, reg) |
>>>>>>> +r8116af_mdio_read_quirk(tp, reg); }
>>>>>>> +
>>>>>>>  static void mac_mcu_write(struct rtl8169_private *tp, int reg,
>>>>>>> int
>>>>>>> value)  {
>>>>>>>       if (reg == 0x1f) {
>>>>>>> @@ -1280,6 +1314,13 @@ static void mac_mcu_write(struct
>>>>>>> rtl8169_private
>>>>>> *tp, int reg, int value)
>>>>>>>       r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);  }
>>>>>>>
>>>>>>> +static bool rtl_is_8116af(struct rtl8169_private *tp) {
>>>>>>> +     return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
>>>>>>> +             (r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
>>>>>>> +             (r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;
>>>>>>> +}
>>>>>>> +
>>>>>>>  static int mac_mcu_read(struct rtl8169_private *tp, int reg)  {
>>>>>>>       return r8168_mac_ocp_read(tp, tp->ocp_base + reg); @@
>>>>>>> -1386,7
>>>>>>> +1427,10 @@ static int rtl_readphy(struct rtl8169_private *tp, int
>>>>>>> +location)
>>>>>>>       case RTL_GIGA_MAC_VER_31:
>>>>>>>               return r8168dp_2_mdio_read(tp, location);
>>>>>>>       case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
>>>>>>> -             return r8168g_mdio_read(tp, location);
>>>>>>> +             if (tp->sfp_mode == RTL_SFP_8168_AF)
>>>>>>> +                     return r8116af_mdio_read(tp, location);
>>>>>>> +             else
>>>>>>> +                     return r8168g_mdio_read(tp, location);
>>>>>>>       default:
>>>>>>>               return r8169_mdio_read(tp, location);
>>>>>>>       }
>>>>>>> @@ -1575,6 +1619,20 @@ static bool rtl_dash_is_enabled(struct
>>>>>> rtl8169_private *tp)
>>>>>>>       }
>>>>>>>  }
>>>>>>>
>>>>>>> +static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private
>>>>>>> +*tp) {
>>>>>>> +     if (rtl_is_8125(tp)) {
>>>>>>> +             u16 data = r8168_mac_ocp_read(tp, 0xd006);
>>>>>>> +
>>>>>>> +             if ((data & 0xff) == 0x07)
>>>>>>> +                     return RTL_SFP_8127_ATF;
>>>>>>> +     } else if (rtl_is_8116af(tp)) {
>>>>>>> +             return RTL_SFP_8168_AF;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return RTL_SFP_NONE;
>>>>>>> +}
>>>>>>> +
>>>>>>>  static enum rtl_dash_type rtl_get_dash_type(struct
>>>>>>> rtl8169_private
>>>>>>> *tp)  {
>>>>>>>       switch (tp->mac_version) {
>>>>>>> @@ -5693,12 +5751,7 @@ static int rtl_init_one(struct pci_dev
>>>>>>> *pdev, const
>>>>>> struct pci_device_id *ent)
>>>>>>>       }
>>>>>>>       tp->aspm_manageable = !rc;
>>>>>>>
>>>>>>> -     if (rtl_is_8125(tp)) {
>>>>>>> -             u16 data = r8168_mac_ocp_read(tp, 0xd006);
>>>>>>> -
>>>>>>> -             if ((data & 0xff) == 0x07)
>>>>>>> -                     tp->sfp_mode = true;
>>>>>>> -     }
>>>>>>> +     tp->sfp_mode = rtl_get_sfp_mode(tp);
>>>>>>>
>>>>>>>       tp->dash_type = rtl_get_dash_type(tp);
>>>>>>>       tp->dash_enabled = rtl_dash_is_enabled(tp);
>>>>>
>>>
> 


