Return-Path: <netdev+bounces-262921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBYJLCIUpmnlJgAAu9opvQ
	(envelope-from <netdev+bounces-262921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:50:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B69191E5EEC
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AA51304A057
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE543909A6;
	Mon,  2 Mar 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5KpUz7J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A0A1AF0BB
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489248; cv=none; b=A+7drLNDXo/SLQorvlwT5dglSEEDpEeh2S80ozRh0MLOGYaA0iIW25f7dRtI5vtj4WeFzm0bVbm3UmDwkARu1eXCUYawKCGhpy4BQBrK16mL3LD7dN071fiBKNXyjF/4ShwGztZujCES444gsvd0rGTi7bftJH+WiHPgh7S0osA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489248; c=relaxed/simple;
	bh=d0ZZI0cx+iOSwwZnVAt0GjPNuMqSXf6U58PzAda0ew8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BglRZvEQE8Fa5QMv3roryBbNKg8SWa6ZmPwFI1KgBvgeyp3TizXl3XvmMknQImhtVeOI8i0v2Aaw28pTfXmirLDjCV9LgdsTM6O9cn44wouar91XTHbeJQelfzKZAGp4pSBoMkrCDOqkPCw8/qZnxJcgPwOvn2zqh4z+kP3qMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5KpUz7J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4837634de51so20820215e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 14:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772489245; x=1773094045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7H/1BDKSXZaBOMmIE8H6F18jbcqQoi44dLneKh6xhwk=;
        b=V5KpUz7JqWwmNSh+KLCXlkNdeEBuzFQTJPkEx1lu5OSJ/RkjJSF4SBFzCAkAklbAtg
         MAgTY8nHraFi8AhDrZJ9s+wzqqhQNPsVe19UpcHNcP/YFu8v9MFo+INqY3nE3I8/bRD2
         tmtElVM2M8+KnduiEAsEtOE6jSBV+GqfrOXMzNu44zNwksu8hvBQ3KFiCUAPRweYHQhQ
         g/oxmeUwDUmocWdkAR5GhJc789AVEiXDApT/7bAqnDgq3RfMV5baKuEGsthclMiGnWne
         cvUVK5ABH6s1OHJFOAgKLfUaR3Vp/DvoP6GJxgJcwjNn6JiB7db52eHKEWFMSYV3LUN6
         WCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489245; x=1773094045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7H/1BDKSXZaBOMmIE8H6F18jbcqQoi44dLneKh6xhwk=;
        b=OwMwG/Ubj3QLPquZXWESz43gkGhGd62N0IOHGwQLOFxPlMj4u0V/oVR+f5Eoo7gZ6p
         3cO8BC3NYV1okn82nxUoc7cp4+UBRguwCZd7K9OvMl399OnTyIouYnhKyFO/5dPFQcQQ
         nrh2wJmUpsbr9EzbBzzGCM+PMDB/YUXtpAB4vNjjxNsJc7xWkH6fJHrYEgh5HQWgnqQT
         fVKqvLyP3LNSu3CFHpFDUjZmES3omwxk4ZzEM9R0pck2rijpgW1mU0srSwyh5uLyKNNN
         jrDi+Pex+LAQX3Kita9WION3tGeO1CpWTnxaSbTAVtxCIk+JNsa+KYSp0gBxnNkRbjxv
         djzQ==
X-Gm-Message-State: AOJu0YzBX40FpJwsHVJz1JSyEXBgCi41KDqvJ/joMouDiTsjmOgc53i5
	UQWEDsPyK6zWq0WRrtx5mLgqmh/MTzXzetKkYzyFwsWwRJpJyi8HQoQh
X-Gm-Gg: ATEYQzycdMVgnZUrwpNQ55l80/kKK8/fZNSR20CESjS69dbWCvaxoRpgdqkB6HriZoP
	uuSOY3CpwJPgEydQ4gNiLJdy6KemqQn8B8fuNbn/gRoMD0pQLi0UjjS/QJWXrfrdsgO2fnWsxio
	PI9+ydaPUthPEAma3I5t0ST/CyaP6k/Axx7roWCaAJ34Z+ZgyJgin9rYqtSX5gbtUxKrVkrQYsh
	xnShLQ36tIZTT7S8SDzp8J+K5n4hNuzBFy07bqa5T93IHXMWIfN4pBcOhn0hjwOy7P84FkPhMi+
	lcW8xX1qXHCoZ5XwiF5tKg+iZrOhnaYv032AIrO6utPpqgS3is9ETt1H91Gd/EJKTNOAIC61x05
	jXX4oic73pVOlWuowJ/viwwIRiPEjlpuxnpXBHz6f7Ptvp8By8aKXtCgzMh19SLLtQF88D1JskX
	FPxI6n4trod/G4Rcbg7DDmXtp3hgEe0M4K49V4LxAjMABaGIAx592iwiqXAgz/V09KCszCpszaO
	a955YCckg52GW3Y8XbbksKjznqTeVRsqBeuvlCpOL9yK5bHFI6ddzyfo1ixbpelEg==
X-Received: by 2002:a05:600c:548a:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-483c9bdb16emr220529315e9.8.1772489245425;
        Mon, 02 Mar 2026 14:07:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f29:3b00:7d0b:dcf1:6608:9853? (p200300ea8f293b007d0bdcf166089853.dip0.t-ipconnect.de. [2003:ea:8f29:3b00:7d0b:dcf1:6608:9853])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3addb3asm384603245e9.0.2026.03.02.14.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 14:07:25 -0800 (PST)
Message-ID: <d2b97f5b-6032-49fd-b80a-6fb47f3fad4c@gmail.com>
Date: Mon, 2 Mar 2026 23:07:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-3-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260302063215.1790-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B69191E5EEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262921-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 02.03.2026 07:32, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8116af is a variation of RTL8168fp. It uses SerDes instead of PHY.
> But SerDes status will not relect to PHY. So it needs to add sfp mode
> for quirk to help reflect SerDes status during PHY read.
> 

Is there any mass market device using this chip version? As far as possible
I'd like to avoid adding support for chip versions that never make it
to the mass market. This just makes driver maintenance harder.

The patch includes support for 100Mbps fiber mode. Is there any use case
for such legacy modes?


> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 71 ++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index fb2247a20c36..a5c0d3995328 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -726,6 +726,12 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +enum rtl_sfp_mode {
> +	RTL_SFP_NONE,
> +	RTL_SFP_8168_AF,
> +	RTL_SFP_8127_ATF,
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -734,6 +740,7 @@ struct rtl8169_private {
>  	struct napi_struct napi;
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
> +	enum rtl_sfp_mode sfp_mode;
>  	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
>  	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
>  	u32 dirty_tx;
> @@ -760,7 +767,6 @@ struct rtl8169_private {
>  	unsigned supports_gmii:1;
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
> -	bool sfp_mode:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> @@ -1126,7 +1132,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
>  		return 0;
>  
>  	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
> -	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
> +	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
>  		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
>  
>  	RTL_W32(tp, GPHY_OCP, reg << 15);
> @@ -1270,6 +1276,34 @@ static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
>  	return r8168_phy_ocp_read(tp, tp->ocp_base + reg * 2);
>  }
>  
> +/* The quirk reflects RTL8116af SerDes status. */
> +static int r8116af_mdio_read_quirk(struct rtl8169_private *tp, int reg)
> +{
> +	u8 phyStatus = RTL_R8(tp, PHYstatus);
> +
> +	if (!(phyStatus & LinkStatus))
> +		return 0;
> +
> +	/* BMSR */
> +	if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMSR)
> +		return BMSR_ANEGCOMPLETE | BMSR_LSTATUS;
> +
> +	/* PHYSR */
> +	if (tp->ocp_base == 0xa430 && reg == 0x12) {
> +		if (phyStatus & _1000bpsF)
> +			return 0x0028;
> +		else if (phyStatus & _100bps)
> +			return 0x0018;

This is a complete hack. Any means to access the SerDes directly?

> +	}
> +
> +	return 0;
> +}
> +
> +static int r8116af_mdio_read(struct rtl8169_private *tp, int reg)
> +{
> +	return r8168g_mdio_read(tp, reg) | r8116af_mdio_read_quirk(tp, reg);
> +}
> +
>  static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
>  {
>  	if (reg == 0x1f) {
> @@ -1280,6 +1314,13 @@ static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
>  	r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);
>  }
>  
> +static bool rtl_is_8116af(struct rtl8169_private *tp)
> +{
> +	return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
> +		(r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
> +		(r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;
> +}
> +
>  static int mac_mcu_read(struct rtl8169_private *tp, int reg)
>  {
>  	return r8168_mac_ocp_read(tp, tp->ocp_base + reg);
> @@ -1386,7 +1427,10 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
>  	case RTL_GIGA_MAC_VER_31:
>  		return r8168dp_2_mdio_read(tp, location);
>  	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
> -		return r8168g_mdio_read(tp, location);
> +		if (tp->sfp_mode == RTL_SFP_8168_AF)
> +			return r8116af_mdio_read(tp, location);
> +		else
> +			return r8168g_mdio_read(tp, location);
>  	default:
>  		return r8169_mdio_read(tp, location);
>  	}
> @@ -1575,6 +1619,20 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private *tp)
> +{
> +	if (rtl_is_8125(tp)) {
> +		u16 data = r8168_mac_ocp_read(tp, 0xd006);
> +
> +		if ((data & 0xff) == 0x07)
> +			return RTL_SFP_8127_ATF;
> +	} else if (rtl_is_8116af(tp)) {
> +		return RTL_SFP_8168_AF;
> +	}
> +
> +	return RTL_SFP_NONE;
> +}
> +
>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
> @@ -5693,12 +5751,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  	tp->aspm_manageable = !rc;
>  
> -	if (rtl_is_8125(tp)) {
> -		u16 data = r8168_mac_ocp_read(tp, 0xd006);
> -
> -		if ((data & 0xff) == 0x07)
> -			tp->sfp_mode = true;
> -	}
> +	tp->sfp_mode = rtl_get_sfp_mode(tp);
>  
>  	tp->dash_type = rtl_get_dash_type(tp);
>  	tp->dash_enabled = rtl_dash_is_enabled(tp);


