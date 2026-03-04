Return-Path: <netdev+bounces-264052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJNqEDuoqGlOwQAAu9opvQ
	(envelope-from <netdev+bounces-264052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:46:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0A2082E1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA4C0312F30D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3293396564;
	Wed,  4 Mar 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RreMhnjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9527C162
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660554; cv=none; b=CLOnbAPJl5PtyI96rtOj59sUjT9Sc8Wfhoffx6eBJGdiIU4W9fbXNvFO8vOZOCv+7FHm2yINjpXUtrmcs2WbfxhunfGf3vo3cIRZFBALEEn4TRaXb7eUVh9eAiV9VefjB/GoYqzMv+vNPnpZdns/knRoolt0kHN/WbbatJgUTM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660554; c=relaxed/simple;
	bh=GpJFrPbnjPXIGZGaGcssigr03iXNraZOIkx6gx95kFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvtK1LH/WJJyINeWzoV8kJw9TC0DETASK2OOWMH/ZT5E1wICrsNDYbBMwp3a/QtOLdhddxdDMZttoPlh/HjR1xFHgY0V2QSzB8O5BdR9DOUirkR6s9DNxehE1IHJPkChwWKLfh4W7vIPdENmVtVHmDaL0q0gmJHjoRbNIGkEFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RreMhnjb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4807068eacbso61263515e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660551; x=1773265351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kctZy9mhqulMkjljiHxEssCE12q1K8nYfu/U/QolPN0=;
        b=RreMhnjbkERaxm/bnepZlFSNlFlogyhzbdQl5cdIw4iL7hdoj8xe4K9xYGigBQNuHl
         yxW4uXXNnJuA4PXf2a3SHgqqXVxTRD0IBcqd+WFE/oGK9TybpE9rvI/+2aHZHDEhgJSV
         o56Lo7kS2QFY7pm5e2LTECRFHvca0mF5VqQp+Wcf4ZeVephgfb6jtGS3E3s67NMBvfEi
         ziJfH+EAlS8SzwmfQwNw/doUt8j+XTK+eiIavrrNOVh9NuAkHoyPPEacZNwKy4m6zaGn
         1GeS81vyIgQeD14m/LQE+9+28s1GX9/4nu6zgb5KFLtaAM2TeO2wg+JHQJjB6aGCkAPU
         WK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660551; x=1773265351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kctZy9mhqulMkjljiHxEssCE12q1K8nYfu/U/QolPN0=;
        b=U/Dmw0kvnytwKSqnQwFd6GdfuhrVA8tWw00571SjjxxElWonvHDr4sTWsw8MHe8NTC
         heBCvfFuoLUI7XDoNfLw8Fbv9reMVdzHMnTokgOp+sU9oU7O37mqpS80CMEFPMdT7wTu
         LD0HySsqu1/2JbL2y6xmiXR/w9jPSNUhKO/RUhFB/XfoM+Uv2Vl+46nGSp2ftjYDRo/i
         VQTvYTPxOK6fCDNlLbR6PZyHeOQXw64G+c2pOa7HTUYg3bOoQeFxs6sfr43/0M5Cf3qK
         JryK/h7+I7eynXhDzziV1hmpymkI1v+bJ8G9yTxfK7jGS+Gm3OvPusHC8GVSgDyuh3up
         ID4Q==
X-Gm-Message-State: AOJu0Yzizz0IFkupWcH+NABOlyE2cwqxbOFGDkzFwBpc7AbCt6mQ6r5e
	+piT2bU4H8a44DvfHv/QhDhLbVm4m3fWTzZeuIY6HUVX+ZpzJlFX57XM
X-Gm-Gg: ATEYQzwyweVoiNo230EhT1EiK8sNAtcAOWCkf3faFMTiLaBwHvb4l81/zrJ4KX4gBEO
	VGApgnfSDJoA6gaUOdXN9hgETYTRXUKpaeRi6G9CYX1LPAQh99ou68CF/sGXfcKc0mYuTVDDEZt
	HGcDo7J2krgJQGVTn2rw1womBC3JVEBDCnSeEisgV7UrvY0MzA3djxrj9PeSp/MQGgj5rfBSYLn
	PnkYdX7oWUF3qFc8WP/Gu1vLLnyBwdvdfGQ7CCM8c/I+Sv+DbevUspraS141f4DJku3fwOMaOs0
	UkyCOWBIiccFzeRxYP36Tq2sOY1V+Q7pnh86Nh/L4+d9C64w2psdXhB/HjqF9pKsWc98MKTxMcC
	HJTVg5s1VaCfKMcdNsVylXiwqZmK2+Vf84ya75C60oii4OszGMIZjSi2iU5FOliX6n/FFK1RZdE
	ak0HGNjoAnMYyOfzkNm6HnwEy/bstzqpW1wJma5VkS3gF2jE+gBv0x/BPdKgJIsEGrmz/F6b9+Y
	EHfkRJgEd0hL6acjGrLY0KWHJfZ9JvRIyy7NfxuCxDxdcMu82lIjGvCXMW+QKR2hw==
X-Received: by 2002:a05:600c:64ce:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-485198608e9mr62217165e9.10.1772660550561;
        Wed, 04 Mar 2026 13:42:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:5c00:3037:1150:282e:5094? (p200300ea8f245c0030371150282e5094.dip0.t-ipconnect.de. [2003:ea:8f24:5c00:3037:1150:282e:5094])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188422dbsm78908095e9.5.2026.03.04.13.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 13:42:30 -0800 (PST)
Message-ID: <5c341bec-4d9c-4435-b997-9b005b4e4f30@gmail.com>
Date: Wed, 4 Mar 2026 22:42:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
To: =?UTF-8?B?6K645L+K5Lyf?= <javen_xu@realsil.com.cn>,
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
 <d00155fb7b2549eaafbeeeffe2b2d56d@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <d00155fb7b2549eaafbeeeffe2b2d56d@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BFD0A2082E1
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
	TAGGED_FROM(0.00)[bounces-264052-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 04.03.2026 09:16, 许俊伟 wrote:
>> On 02.03.2026 07:32, javen wrote:
>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>
>>> RTL8116af is a variation of RTL8168fp. It uses SerDes instead of PHY.
>>> But SerDes status will not relect to PHY. So it needs to add sfp mode
>>> for quirk to help reflect SerDes status during PHY read.
>>>
>>
>> Is there any mass market device using this chip version? As far as possible I'd
>> like to avoid adding support for chip versions that never make it to the mass
>> market. This just makes driver maintenance harder.
>>
>> The patch includes support for 100Mbps fiber mode. Is there any use case for
>> such legacy modes?
>>
> 
> Our customer platform (using RTL8116af) requires support for entering c10
> power-saving state, so we need to add support for this chip.
> 
What do you mean with "customer platform"? That what other manufacturers
would call a board support package (BSP)?

>>
>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 71
>>> ++++++++++++++++++++---
>>>  1 file changed, 62 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>>> b/drivers/net/ethernet/realtek/r8169_main.c
>>> index fb2247a20c36..a5c0d3995328 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -726,6 +726,12 @@ enum rtl_dash_type {
>>>       RTL_DASH_25_BP,
>>>  };
>>>
>>> +enum rtl_sfp_mode {
>>> +     RTL_SFP_NONE,
>>> +     RTL_SFP_8168_AF,
>>> +     RTL_SFP_8127_ATF,
>>> +};
>>> +
>>>  struct rtl8169_private {
>>>       void __iomem *mmio_addr;        /* memory map physical address */
>>>       struct pci_dev *pci_dev;
>>> @@ -734,6 +740,7 @@ struct rtl8169_private {
>>>       struct napi_struct napi;
>>>       enum mac_version mac_version;
>>>       enum rtl_dash_type dash_type;
>>> +     enum rtl_sfp_mode sfp_mode;
>>>       u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
>>>       u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
>>>       u32 dirty_tx;
>>> @@ -760,7 +767,6 @@ struct rtl8169_private {
>>>       unsigned supports_gmii:1;
>>>       unsigned aspm_manageable:1;
>>>       unsigned dash_enabled:1;
>>> -     bool sfp_mode:1;
>>>       dma_addr_t counters_phys_addr;
>>>       struct rtl8169_counters *counters;
>>>       struct rtl8169_tc_offsets tc_offset; @@ -1126,7 +1132,7 @@
>>> static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
>>>               return 0;
>>>
>>>       /* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
>>> -     if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
>>> +     if (tp->sfp_mode == RTL_SFP_8127_ATF && reg ==
>> (OCP_STD_PHY_BASE
>>> + + 2 * MII_PHYSID2))
>>>               return PHY_ID_RTL_DUMMY_SFP & 0xffff;
>>>
>>>       RTL_W32(tp, GPHY_OCP, reg << 15); @@ -1270,6 +1276,34 @@ static
>>> int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
>>>       return r8168_phy_ocp_read(tp, tp->ocp_base + reg * 2);  }
>>>
>>> +/* The quirk reflects RTL8116af SerDes status. */ static int
>>> +r8116af_mdio_read_quirk(struct rtl8169_private *tp, int reg) {
>>> +     u8 phyStatus = RTL_R8(tp, PHYstatus);
>>> +
>>> +     if (!(phyStatus & LinkStatus))
>>> +             return 0;
>>> +
>>> +     /* BMSR */
>>> +     if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMSR)
>>> +             return BMSR_ANEGCOMPLETE | BMSR_LSTATUS;
>>> +
>>> +     /* PHYSR */
>>> +     if (tp->ocp_base == 0xa430 && reg == 0x12) {
>>> +             if (phyStatus & _1000bpsF)
>>> +                     return 0x0028;
>>> +             else if (phyStatus & _100bps)
>>> +                     return 0x0018;
>>
>> This is a complete hack. Any means to access the SerDes directly?
> 
> Unlike RTL8127atf where the SerDes status is automatically reflected in the
> Standard PHY register, RTL8116af does not sync this status to the PHY register.
> Maybe this hardware design is to save power. So we have no choice but to
> upstream such hack code to get link status and speed. 
> Given this hardware behavior, do you have any suggestions for a cleaner approach,
> or would this workaround be acceptable with some explaining comments?
> 
Even RTL8127atf requires ugly workarounds because there's no direct access to
the SerDes and the SFP I2C bus.
Realtek's wish to upstream support for their chips collides with their decision
to hide several essential components behind firmware. For proper mainline support
Realtek should expose components like SerDes and SFP I2C, so that the kernel
can access them, and phylink, sfp, and friends can do their job.

If use case is just Realtek's customer platform, then RTL8116af support could
be implemented downstream, avoiding hacks in mainline.


> Thanks,
> Javen Xu
> 
>>
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int r8116af_mdio_read(struct rtl8169_private *tp, int reg) {
>>> +     return r8168g_mdio_read(tp, reg) | r8116af_mdio_read_quirk(tp,
>>> +reg); }
>>> +
>>>  static void mac_mcu_write(struct rtl8169_private *tp, int reg, int
>>> value)  {
>>>       if (reg == 0x1f) {
>>> @@ -1280,6 +1314,13 @@ static void mac_mcu_write(struct rtl8169_private
>> *tp, int reg, int value)
>>>       r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);  }
>>>
>>> +static bool rtl_is_8116af(struct rtl8169_private *tp) {
>>> +     return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
>>> +             (r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
>>> +             (r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000; }
>>> +
>>>  static int mac_mcu_read(struct rtl8169_private *tp, int reg)  {
>>>       return r8168_mac_ocp_read(tp, tp->ocp_base + reg); @@ -1386,7
>>> +1427,10 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
>>>       case RTL_GIGA_MAC_VER_31:
>>>               return r8168dp_2_mdio_read(tp, location);
>>>       case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
>>> -             return r8168g_mdio_read(tp, location);
>>> +             if (tp->sfp_mode == RTL_SFP_8168_AF)
>>> +                     return r8116af_mdio_read(tp, location);
>>> +             else
>>> +                     return r8168g_mdio_read(tp, location);
>>>       default:
>>>               return r8169_mdio_read(tp, location);
>>>       }
>>> @@ -1575,6 +1619,20 @@ static bool rtl_dash_is_enabled(struct
>> rtl8169_private *tp)
>>>       }
>>>  }
>>>
>>> +static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private *tp)
>>> +{
>>> +     if (rtl_is_8125(tp)) {
>>> +             u16 data = r8168_mac_ocp_read(tp, 0xd006);
>>> +
>>> +             if ((data & 0xff) == 0x07)
>>> +                     return RTL_SFP_8127_ATF;
>>> +     } else if (rtl_is_8116af(tp)) {
>>> +             return RTL_SFP_8168_AF;
>>> +     }
>>> +
>>> +     return RTL_SFP_NONE;
>>> +}
>>> +
>>>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private
>>> *tp)  {
>>>       switch (tp->mac_version) {
>>> @@ -5693,12 +5751,7 @@ static int rtl_init_one(struct pci_dev *pdev, const
>> struct pci_device_id *ent)
>>>       }
>>>       tp->aspm_manageable = !rc;
>>>
>>> -     if (rtl_is_8125(tp)) {
>>> -             u16 data = r8168_mac_ocp_read(tp, 0xd006);
>>> -
>>> -             if ((data & 0xff) == 0x07)
>>> -                     tp->sfp_mode = true;
>>> -     }
>>> +     tp->sfp_mode = rtl_get_sfp_mode(tp);
>>>
>>>       tp->dash_type = rtl_get_dash_type(tp);
>>>       tp->dash_enabled = rtl_dash_is_enabled(tp);
> 


