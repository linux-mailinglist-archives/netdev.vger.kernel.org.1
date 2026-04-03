Return-Path: <netdev+bounces-274971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJr6NSKLz2mmxAYAu9opvQ
	(envelope-from <netdev+bounces-274971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:40:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C72392E62
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3B063053658
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34469377559;
	Fri,  3 Apr 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW3JFyGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7024312807
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208936; cv=none; b=MYBVeHIpTuC+mj6rnSQv5c3+Zs6dvt1sW7zDD6VOj5nJaAhHiNAHJkVyQGJ0qmg/DWW4QC1tLP9xZuTIVqqa9EKweZPyQ8XBCQ9zxDNKvLEW95yuDaA7bRS+XPJjF2CF5DF6KL4e6qWiPr3ihusmujhT1A7A+CInmQ3ZXhY1r6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208936; c=relaxed/simple;
	bh=CGaTbTzIdYwuRlEh+YKKBHzWhKzKyqy2VXhXB7t6eBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIVeTmW6CLsFwPwvyLUg1/hXvvKwHEvu7n4YoGVJhhio+12ATPrZ0jsqDLO7RKtnZrSaeTJbcu9ncBd5a+wxzgacBA8mGpOGe9lxN0EmRF3lN3eHJ4UrRnccAHJ2On+cjqodWeE/HFxwsGWgRhe7II386+GnIzVxuLN/Lc0PrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW3JFyGr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so13794875e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775208932; x=1775813732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+7bh6JYJimFo01dLJuKHAMSI9ybhWnOBWq0Gz5gOhs=;
        b=nW3JFyGrzFRpkm/gQghHrjA282BtnDL2ZSyehbBk1sVw1nNcrIoey0HbrEuxFSgSMB
         9BcFnOLeUUtDFJCdsat99H3hBRwd2EZp35YdP1ubIh2SNNt8I1x0ue8V7hf0Lmh/YLQT
         aGZjVsCRczSS3HRBsFHdgdC8NcUgjuEanlpzQy3EyapX1iUFBIJLAuAMOXuzZXEIjWZ6
         HcHn/XlTu+vSkQxpoqg5HlIzKWCZ+tmI4uhWcwHRPER/knm7ym1v328r3aKTVAE5CfhH
         yz+odeWl2caLXz19LIiJ41l0UxKzLd37e5RRnHgMocLpYEVrTIX6R+npJ347Kz4jBVlI
         VjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775208932; x=1775813732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+7bh6JYJimFo01dLJuKHAMSI9ybhWnOBWq0Gz5gOhs=;
        b=plPQx8zbYp8kuDAgWC9ed5RcJijSeirAxj4EXLbF8JAHP45KFaSww9MNTuaK9w+LMf
         s9zp+i7B6BS7iYUK8aJJS2epw/sJsU1OrXxupJleFsvkb3OJ1QoSxw9Qd1jB/E43x/Y/
         Vb5FFjQIXICrDhCPQLFCr9EGL38Lne9Li6AhFRJ8n58vOK1LLMDoGF3CkbZ9YvZUV1c0
         LlcgGZcANi55teCqxMeb/MS+T233/z9pQMkpgicYl3/UGW5yXb8c397lknp90bvaqtVh
         QJLPfq0mtgCXp8QOKa0spi+OlK7AGXlZnmWmmfydUpT0+Wc4payQ+HTuML9F4uYRm9kz
         uxTw==
X-Forwarded-Encrypted: i=1; AJvYcCXCWoijv2fzJOWcBUnUkNf/E/KiSSvqamL+3qMeJrcT9eQzBecmGRhgXGz9XGrGMrE6InyFeA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMt+MZJ+OUBZuldFSC01zwYjalvN6QdhLTnxwS3ToK8Xfh3BxQ
	JU678k6ZYDVWuyOU+OPMWM6UbkDnLv5TaAJpB3IS4iwLzxQ3DN6P1fT7
X-Gm-Gg: ATEYQzyV3ug75JCsCUsf36TquIlc2jUuepJ5bf43LVtZkv+E6LDlJ7OoWBQO1TyDnfg
	mSvbcZFSJLiiRki9NFCL1dCHJeh5KjvB5qwWOeDR1M3nHDPlrwKAY6eSm+IZEcuPTFd6pG0BwbJ
	Gld5k8bGzsut0DMu85P+Rlp/Je9AQF7URBxSyyTpBdoItubO84RAMo0Zo9WNA93QTUXQIkga6kU
	2Dqcjk/EpK10rRuT8CZqeYTHoc+KeO/6LoOTRE95YtQHlBPLnZXyXdAIxTOgyEqKJ6FaO/c1L39
	fTqwtoE7qAR5CbyIRO8IY4dsNJN1LhDeeUmZ9dLoWAXGEvaybEfWgCxInBAPQlINaiPq6SzROZD
	t6M6aQxQc/xpcuqOQkGRg78gaZhsjWEHy64OMCH5lj4iq1nTARehJMQ5zVRpIlf8sVioM9+svh7
	kcbLVP1+W4fP2C+wne3H8UNI4oJO2p+K700m9FfUpnrfXxg/vgZ/B5CAlRQDa/MLbGebmavbqMG
	Otm4iS7NU6CUWtejaJI
X-Received: by 2002:a05:600c:698d:b0:488:7f49:eae5 with SMTP id 5b1f17b1804b1-48899780926mr36577785e9.16.1775208931761;
        Fri, 03 Apr 2026 02:35:31 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488981e8e66sm16662805e9.10.2026.04.03.02.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 02:35:31 -0700 (PDT)
Message-ID: <c09c1b4e-e557-494a-a261-ed146d3a6dea@gmail.com>
Date: Fri, 3 Apr 2026 11:35:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Vladimir Oltean <olteanv@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326094211.hdaf4tz7lbjyjznn@skbuf>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <20260326094211.hdaf4tz7lbjyjznn@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274971-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exotec.com:email]
X-Rspamd-Queue-Id: 36C72392E62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 10:42, Vladimir Oltean wrote:
> On Thu, Mar 26, 2026 at 10:10:23AM +0100, Fidelio Lawson wrote:
>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>> Microchip document DS80000687C for KSZ87xx switches.
>>
>> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
>> where the PHY receiver equalizer may amplify high-amplitude signals
>> excessively, resulting in internal distortion and link establishment
>> failures.
>>
>> Depending on the selected workaround (1 or 2), the driver writes a
>> specific value to the indirect PHY register
>> using the 6E/6F/A0 indirect access mechanism.
>>
>> The errata fix is applied during global switch initialization when
>> enabled via device tree.
>>
>> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
>> ---
>>   drivers/net/dsa/microchip/ksz8.c | 46 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
>> index 78b42cf50ce2..b6f3a1ce85fc 100644
>> --- a/drivers/net/dsa/microchip/ksz8.c
>> +++ b/drivers/net/dsa/microchip/ksz8.c
>> @@ -1901,6 +1901,41 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
>>   		ksz8_phy_port_link_up(dev, port, duplex, tx_pause, rx_pause);
>>   }
>>   
>> +static int ksz8_handle_module3_errata(struct ksz_device *dev)
>> +{
>> +	int ret = 0;
> 
> "ret" does not need to be zero-initialized. It is unconditionally
> overwritten by ksz_write8().
> 
> And please sort lines with variable declarations in decreasing line
> length order. Netdev calls this "reverse Christmas tree" ordering and is
> the preferred coding style.
> 
>> +	const u16 *regs = dev->info->regs;
>> +	u16 indir_reg = 0x0000;
>> +	u8 indir_val = 0x00;
>> +
>> +	switch (dev->low_loss_wa_mode) {
>> +	case KSZ_LOW_LOSS_WA_1:
>> +		indir_reg = 0x3C;
>> +		indir_val = 0x15;
>> +		break;
>> +	case KSZ_LOW_LOSS_WA_2:
>> +		indir_reg = 0x4C;
>> +		indir_val = 0x40;
> 
> Do the 3c and 4c registers have any associated documentation? Do we know
> what they are or what they do? We should have some macros for them,
> instead of magic numbers.
> 
>> +		break;
>> +	default:
>> +		break;
> 
> Is it expected that in the default case (no workaround), the code flow
> writes indir_val = 0x00 to indir_reg = 0x0000? Or would it be better to
> just exit early without making any change?
> 
>> +	}
>> +
>> +	mutex_lock(&dev->alu_mutex);
>> +
>> +	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
>> +
>> +	if (!ret)
>> +		ret = ksz_write8(dev, 0x6F, indir_reg);
>> +
>> +	if (!ret)
>> +		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
> 
> Is this sequence better suited for ksz8_ind_write8()? Perhaps wrapped in
> another layer similar to ksz8_pme_write8(), once we know what the magic
> numbers represent in terms of indirect table?
> 
>> +
>> +	mutex_unlock(&dev->alu_mutex);
>> +
>> +	return ret;
>> +}
>> +
>>   static int ksz8_handle_global_errata(struct dsa_switch *ds)
>>   {
>>   	struct ksz_device *dev = ds->priv;
>> @@ -1915,6 +1950,17 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
>>   	if (dev->info->ksz87xx_eee_link_erratum)
>>   		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
>>   
>> +	/* KSZ87xx Errata DS80000687C.
>> +	 * Module 3: Equalizer fix for short cables
>> +	 * The receiver of the embedded PHYs is tuned by default
>> +	 * to support long cable length applications.
>> +	 * Because of this, the equalizer in the PHY may amplify
>> +	 * high amplitude receiver signals to the point that
>> +	 * the signal is distorted internally
>> +	 */
>> +	if (!ret && dev->low_loss_wa_enable && ksz_is_ksz87xx(dev))
>> +		ret = ksz8_handle_module3_errata(dev);
>> +
>>   	return ret;
>>   }
>>   
>>
>> -- 
>> 2.53.0
>>
> 
> FYI, the driver is in a restructuring process. The ksz88xx_switch_ops
> will be split out of the common ksz_switch_ops. This will conflict with
> your series, so you should rebase on top of that much larger set.
> You can coordinate with Bastien Curutchet to see what is the status:
> https://lore.kernel.org/netdev/20260313153849.qkfzv5c2u6fepjku@skbuf

Hi Vladimir,
Thanks for the review and for the detailed feedback!
I’ll apply your suggestions in the next version of the patch.
Thanks again for the guidance.

Best regards,
Fidelio


