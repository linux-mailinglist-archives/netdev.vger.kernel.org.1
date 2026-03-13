Return-Path: <netdev+bounces-267616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL/xDQyAtGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:22:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9109828A1D9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6968C301918C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981F3806CF;
	Fri, 13 Mar 2026 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esncXmy1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3209314B96
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436872; cv=none; b=MG+h84ADb1qkU6DV5Eakap334CJSSKLce8jiDwc8/YHAbFrSYFj6rv1ewivQLwnBdEqldyLbSlWFkUKnE+dycRXxoKBHZlHeShdX8N5WI5PuQ9W3OUKrfl0HfhxwEilRFiE9MjaBxLoWoH1vw3UvopJ/K+8Wpf0oaVhCSCjXHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436872; c=relaxed/simple;
	bh=BkV51abWtE8tA+fCayL/tFr/rG5v/NaR5ko1OJ8dNYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvoNFRxrILqlv0PT8wFbd6g4j5TWypgau4GT0R107BkmGx0sgf0bTIiPIKLEFEPF03UzQMdpPL21pqmHq6s3QEGMhCUpfwAoTodWGPK7b9n1DO0nbbTt124OTrnOHJQHw4MdaHrb2CBhuQzhYfLGjNfgjiMPmm3SYZCReM8W0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esncXmy1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-485445e80bdso23240555e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773436869; x=1774041669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05bFysLTe4GC8bUvSRtB9JtDqXl3vfMJpM057TSQP9Q=;
        b=esncXmy1wB961znhmwEjA696Z7yKlxTYHi4Ds/XFt6Ngn4ys3/t9DqPAqeJeRJQ4vQ
         uabYvNZjW5DE8x8MOHUOUfmNMdyyHYGFQjxYeCUdxNIkr6ln9qcrRpKq9QFdZbS+Xxcc
         u26tJzeoBXVHbiU7duVdXWhBT1me2VPHUu1FxZ+Y+ej1fQd/XAPbgXT7MATvH9Ef7ICa
         d3yyTc+j+MiV6P7u2rN0NsxqR85cYR23cqQ4mggyuHQFCzMEEAFKrSKJPdXJyyXDliF2
         bWoWXXQjiaOduupPyEOH+v+vqdyLXWIIBrZIbhUyoxnqMoGCK1NkBfYpbJhCFapVoxws
         xNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436869; x=1774041669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05bFysLTe4GC8bUvSRtB9JtDqXl3vfMJpM057TSQP9Q=;
        b=fZ75f9CzSPtR7rtJRzRyJkVEYnvDtb6qsqP1tpD1+2tzYXlxWR4iqHIRRTxHVBkixT
         aNEKIy7xj82HrwUi2PDd/aI1krViOhOQL3+4tqMT5WZp0iR1WG8JIYMEyhXJawG9Q0Gl
         WKLSrJcDVj+9eSktlAu0QCiNngtG6aPvB9UWnbNMfTx2seuDzZSkY9gLNFjEm25Q9uB9
         uhtdS/KMy/s3evlIseo/f0ffa6Apz3HXa+XnV9YWrgeVISov10YczhIHmWJLtW3JKT2J
         vzST0TjtZOHQ5vQQnwAgb2M+pUjXY5XN74s5imEPCoDMKVbpW47/1N+B6mVJ3RdvKqjM
         cJRw==
X-Gm-Message-State: AOJu0YzHzojTGHyTtym6GlgxUS2s6nRt0BWfXVe3zdqzXhHEwI4b1Lok
	Jusssu+JtBx+AaZ/mIhb2ZHz3AOBLqLhwNknwbJjHHKRQuAd8NEGJAC5
X-Gm-Gg: ATEYQzxWYGnOXDw/8GEuQAtq1pLpAm5J4GAVIsM4AFmsRjeMDTj4lB5bnwNq/t+NXpd
	VFMKrdXzIU5OSd7Bq9ffBBFTiQv5hYEmdPQ0RMi613b+DHtxI3cLNkVdFWQGK8P/Ko1Nq43Brin
	6qdwyiMaPlHkmUuoAJlPdNMb4CRKCyXNmhYxEXb17vKyBZlMHpkv7VVjUEFibPegSPEzlYtx/g4
	QDBJ9TzFLozv/eBV1yRn5Qcua7AVqhJcWQehaoddFHB6E16PH8zr4d6qNyVs+L3h7Jth65GOXt8
	iAC1Anhi6SPadkpwBZyEkuPij0xFReK1x4rAbGeeq+6g2j7LIWnE5G6L24nhG9OphkU0Yd6YkCG
	KURdVTu8pM0fs366645/X+phFRJNy+TI3FsScLJEsPlsZftSjJLlDVtLlXLXXgx1jNW1ylKVaj7
	ec+FjXkJXWXuE0RK8c3z3uRjTUQVhzXpXDMdbIHyVYYR1Wi0yJAGFwSdXvQ4N4pWWYEMZw8lISR
	R18od3dEOJXjSm4xK7cOc8K3fBTO/m9rdfBh5GndpQn7GtOrtxXijpwoOviRfk3eg==
X-Received: by 2002:a05:600c:3553:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-4855649fdafmr86335615e9.0.1773436868587;
        Fri, 13 Mar 2026 14:21:08 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f3e:d400:10f8:6692:7044:8f59? (p200300ea8f3ed40010f8669270448f59.dip0.t-ipconnect.de. [2003:ea:8f3e:d400:10f8:6692:7044:8f59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6070acsm197989535e9.8.2026.03.13.14.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 14:21:08 -0700 (PDT)
Message-ID: <fcb72518-24f7-4e16-8208-fb38441408d2@gmail.com>
Date: Fri, 13 Mar 2026 22:21:07 +0100
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <98d632aecbbb4dd8ad79c24e672765b1@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267616-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9109828A1D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13.03.2026 08:25, Javen wrote:
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
> Hi, Heiner
> Now we find a indirect access to serdes reg. The serdes reg is designed according to IEEE 802.3.
> BIT 2 means Link Status and BIT 5 means ANEGCOMPLETE. We can access it through read mac ocp
> 0xeb14, I wonder whether this indirect access can be accepted?
> 
Based on the bit numbers this seems to be the BMSR register. Can all clause 22 registers be
accessed in a similar way so that a MII bus can be implemented for accessing the SerDes?
In general it's hard to provide a statement w/o knowing the internal layout of the IP blocks.
Can you provide any chip documentation / datasheet?
For proper support of such a component chain between MAC and SFP port the driver would have
to be converted to use phylink, what requires access to the involved components, incl. the
SFP I2C bus.


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


