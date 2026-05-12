Return-Path: <netdev+bounces-287292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHrjM6GPA2rI7QEAu9opvQ
	(envelope-from <netdev+bounces-287292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:37:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270B529617
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4378231448B2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D23CAA48;
	Tue, 12 May 2026 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVluOorI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2843CAA25
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617844; cv=none; b=n9e3KqL8u9tNGGGgpKvyIm12enAJKTu0Hm7Cvdw0gl1JG0Wp16ZJb7VH7/cvo3SroNlaw0BGBwb+YAEoZd/LWvYk7mXN8KS9nqDoevhVWI1yhr2Kn75TiC16i0L61REXXxzblhuEMRYFF8R+M9LAczlo5lz7F2zrmCGwir778Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617844; c=relaxed/simple;
	bh=VaFRdFo9VibEiQ3eBuEP9D4AW5KzamADAu0IY56lq0w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ahDv19UlvTWHQspDcK6ibZ2TSmkqJcS2UHIIBeF7+8MxsAddG5ryyilscX5F9SjPo7rpBW2LilW1gzE/V5XC5nHOn0sGcT/mcyfVCQQJijFqfItN60mng5c6MaxMgHRB05dbw/jWxkOMi1ctze+AxpIFKwgmRuLtMrI1G+L41Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVluOorI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f6092eso3703220f8f.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617841; x=1779222641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IOyXPZFidKiz6EcOZ9YcQmiYuPdH1hxNMH2N2Yn0x/o=;
        b=cVluOorIFZSBUc3J60XHG+/ps/1/aWORVKIHm12hY7I45eiF/raPXKQyFdknrlZDrz
         2GDqBcSB2SI4a9KLyDpcq01cPNf045dGMDTPBcRDhQ58ZFFtPGM9+4sjS39opKJJ8jTY
         HK8HgNzPbn01zGw4xwNIb3mfBKPuRENJNA+lNxadiEKXOC0peSc0pdRl6LfKMVc27G74
         45Twg9oAwuwO2PNEPzW+ZYjTnSYFBS+9dkeFdYER7lZeuvNFkoGfHJ4HyXpy1hRfkPB6
         TBc9YcTWn2NKWw2cC8ySS+BIIwg7c7/sJJYi0wBp9b+vexXZ7upzqw5hlDCtkY8ZWGcQ
         m+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617841; x=1779222641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOyXPZFidKiz6EcOZ9YcQmiYuPdH1hxNMH2N2Yn0x/o=;
        b=USDQeXBmiEhw5pIj/5k2XGQr+DIwLifOMcLYqURE/oezqzLN9HwS6g5F4lHqr5o+up
         qpTQUlbS009MoLIZeQJanNX9c/GNOAGHh0o3Nrm/y4FaFBYZhlY7sna71jRxsBJLED4P
         gYsMCqi09JJGLNRkAiNcfhx3di9zTzP1yLYUfaTHO9Co3eiZ1KNm7EewXG9EYVygxGHd
         LSSSBHb2FM1ge4ldk5mcumUhEva86prwZDdBvHs78iBtx6TEnIXBECMypoBc9B5aYeAN
         t2UzFRgNTiKD2DhiHTjzbMc66yzcjQX06+zRHqBv/VprDwVXB5vSbNjwNDHfxxrXZHv3
         DFdg==
X-Gm-Message-State: AOJu0YzdqFaR0Llly5UICyxb35m/CP1ahziL+kW54BAiHQRvYBCJd2UX
	yt5egYRgUDqYCVnmtKDZ1B/gXBvQWy8VpsLAKhR28UPX/JVjzCchY0dQ
X-Gm-Gg: Acq92OGnPBCpZJH9HyEmvxSmQb10KUi4RGLVTyPw2OakVWp65WhVXK/iVRikA1MUp/N
	cCq/BGk5n398AhuePk26R831kCedpj1h7/EUm9DQpaReCRYy8KWICgiRtIagg0nXk7M7U7lBDwe
	cN0lJ/uH6H8Oc+TvJyF0IgcrXtJ0CQuhq80t3bmWtlpTczkbvkEx5nRDJ3gzpAeBsydzL0ig6VM
	SmsRgnMBQu8n0pXNE7pNOPlVb+mfAuSzq+s0IiOZ3wDaD7jYSzCfwPWWXDZ2j/gXjJXXS5Rabz+
	Vb2/r03DqxSGEOU2ffq1VsrttV4gmJ2enaVehBqVicnn9Wdep6CHVGaMCUDAoJhR6p96sNvwUHI
	+ErmKegBNng4BkKmxeOZmCXmY9rk0dmeF8pZhjErPrLUiENPs/MtgJ7LQYkSBdq3eQhqbDnpHpD
	xl69l+L+ciRSNAq153YZaUFQgtj0mZouvsHh4K4HSywaxV4eMy0cgw8Fai0roILhyjOa3jyowb3
	R/HlYPIL2yMDhG5JMqqs361pkjHyrcMPTQo55NSgwlwvqJSvaz3YkGO7QnTCTtkQQ==
X-Received: by 2002:a05:6000:288c:b0:43c:fe66:43ec with SMTP id ffacd0b85a97d-45c584a793bmr419324f8f.14.1778617840988;
        Tue, 12 May 2026 13:30:40 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3200:655a:16b8:d272:9436? (p200300ea8f473200655a16b8d2729436.dip0.t-ipconnect.de. [2003:ea:8f47:3200:655a:16b8:d272:9436])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm30698945f8f.4.2026.05.12.13.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:30:40 -0700 (PDT)
Message-ID: <f97ae96b-74ab-4e0f-aa8d-c3a3306a7c47@gmail.com>
Date: Tue, 12 May 2026 22:30:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v2 4/7] r8169: enable new interrupt mapping
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
 <20260508121802.2010-5-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260508121802.2010-5-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3270B529617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287292-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email]
X-Rspamd-Action: no action

On 08.05.2026 14:17, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch enables new interrupt mapping for RTL8127.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index bb72a2030f44..0ff0671fc2ac 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3965,6 +3965,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>  	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>  }
>  
> +static void rtl8125_hw_set_interrupt_type(struct rtl8169_private *tp)
> +{
> +	u8 tmp;
> +
> +	tmp = RTL_R8(tp, INT_CFG0_8125);
> +	tmp |= INT_CFG0_ENABLE_8125;

What is meant with interrupt type here, and what does this bit set?
A self-explanatory function name would be preferred.

> +	RTL_W8(tp, INT_CFG0_8125, tmp);
> +}
> +
>  static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  {
>  	rtl_pcie_state_l2l3_disable(tp);
> @@ -3973,6 +3982,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	RTL_W32(tp, RSS_CTRL_8125, 0);
>  	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
>  
> +	if (tp->features & RTL_VEC_MAP_ENABLE)
> +		rtl8125_hw_set_interrupt_type(tp);
> +
>  	/* disable UPS */
>  	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>  


