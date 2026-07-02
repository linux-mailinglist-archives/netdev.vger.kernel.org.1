Return-Path: <netdev+bounces-304133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IdaZGO5ORmrPQQsAu9opvQ
	(envelope-from <netdev+bounces-304133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:43:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1D66F6E4B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:43:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JWKLBOQv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304133-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304133-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AF7D315C136
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A83EDE6E;
	Thu,  2 Jul 2026 11:22:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC433ED11D
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 11:22:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991377; cv=none; b=IuKZVn/LxmMO1YY+WENVwZpPB4NhRO+VXCVwtaqa3AhnuXZaDkXJ52UY+NTFIGpPhjOL0C/t4C228r27SAHOXBVVA3uE5nlFgMRRBWR9nm1iHFaoRD/WfKjqSjge2vqfnIfSSXIPnJSqLcvPJlMOoX+QX822KKlpbvi0OTmNlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991377; c=relaxed/simple;
	bh=BjCZldRmVu7iIL1qiFQiiS2rf7b4kgTkGMTTxWONjr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuB6L8usuqTXIS0vB9pTY4Qk6aOrgw8xN+BGf9UkYn0VnKZoLyC07++26Uvx7I7/ITWQ9NmXql8894HGbchz+PHbrVV+lw82wS0NAa+KA0CNlioWarm3OFKvrbxGDNac6mfDrCGHvXTPQj8/zn3riz/oXfJkifHchtEat0JJKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWKLBOQv; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so8726165e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782991374; x=1783596174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhhtWV7Ryh6pz9r0SAzNB6C4UPIw4trYcrpHGw3+K5E=;
        b=JWKLBOQv5td84hv0LK8aQzdZA2lyEh7d9gRVfDeBB8SdxKlt0gnfGWOikEZPu5cY3y
         EItywlxa6yN8bfbDDYTD5KW7b7IFEU/Im8Ub/ObaE37pM9a3UqgxsFhlNd3CUk0wJQHv
         XlxxIRe3pjBZP0fWL8KydwRmfzBkRVI8hWJMDKVhONFgrXvnzvGkLhlHMljngpERSCj6
         1h/0aG9ybpn+3ReLLDjgqUu3XiHd9lQEx/zHQMkjDwlON+F8geXVo9cFaVpm5wPIzQal
         ik9n8ZbJSBWaQzWvat9vZIImq5Zxf8+0dOAE6FhJkmvghyxSvoVqkGUMonKqmT5ERqGl
         LG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782991374; x=1783596174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhhtWV7Ryh6pz9r0SAzNB6C4UPIw4trYcrpHGw3+K5E=;
        b=e93EifimqvZapySk5jOB4tPbjyJFlGYDPBHG770buwG8sUie28oYjccu7G7mSgFXXI
         8PQ1XHoC36JnX4oI0VtZPvRK79hOFeT1/ErN2Mg7Ivm2s8h2KKXqdvHsSCzuayNXFyyZ
         HQ78OgRvVfxE0mQxLMLCZ9KLUgXqbMYk3xB+kH/RnVuas5sb5b4qL+qDedzFHkQ2CvOW
         PPGEELPfWvv0bdww+wY2Psl4cg8X9ravgLOU6Gsr9RgAaZvw1ac4S954AVUUXw9KjR9K
         OI0UOfQ/yOBGN7bDhBWUA9inS/kyDSHqqLcNRqzxCzSIjcI9elc3/MpEAUW5GrRffgMB
         7b2w==
X-Forwarded-Encrypted: i=1; AFNElJ9RAXlW8Do+jmXjdSrMGZqyTUDRWZ4TalcYntGAuj00zdfyDsRTpCdIM3nsBsBA3cs4/QAe8q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJ/WpBxMIp/N5t9uubbkLtdI6stTTqyE1XSxUjILE1VvzyDHP
	a2l/iFLmQAGqGEY5Qk+NdDS0ahlFrjnEWeS0/1hb0FO7WZ0NalrqP8nO
X-Gm-Gg: AfdE7cmkFKayFy5oMrkRYOtHYR9zJQpW83vXT8XXvMcgw+0nd9c18KffHg6opL9wpOv
	z+FDKC3Tv6o6GpN7y8ZwpbQiTGOoEtV4mO/AwhXvBrBnXZfWI13NoeraQPT9JgjOXBTDcrpvvvg
	lYCyVDIRPJ8B6cq/dgplmAAYCN0BFGA3T70S3GjcaBEwYeA1ATE8KowzVI2Mpuoh3dSqfqywteh
	DSueU9tIqyGRteThSK3np/LaDcCn4UquTgBVoezgcE+HnqnRxfQ8aLKhVY73ASXHHEBQBfkVDnV
	aiV4niyKaj+eMxpAwmEXza/pBuzwiaJd9h7QbLKWAetg+LfoK/POsJjeI79MIb9zVSNQfDJkgwW
	oKODyMPEwbutpioT8vHCjK1zQGC9gTeYl4o/CiQTONzIXwRyiGt2WNOf177YhjbZsyzjfNK8uLp
	UwjsusTjbKMU+2XiCozISFoBugjTnT2BvDtTE570nKSroJkvlxKO7lgH0xcbBp9cNZ81z0Aea4j
	rxyvZCo8Dl7AMs=
X-Received: by 2002:a05:600c:6986:b0:493:bb23:152a with SMTP id 5b1f17b1804b1-493c2baca0cmr76877265e9.34.1782991374089;
        Thu, 02 Jul 2026 04:22:54 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f125:6a01:ed38:5886:81fd:d626? ([2001:9e8:f125:6a01:ed38:5886:81fd:d626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bfe7427dsm76413895e9.2.2026.07.02.04.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 04:22:53 -0700 (PDT)
Message-ID: <5177c53c-3885-410e-8f6c-e40e38677b32@gmail.com>
Date: Thu, 2 Jul 2026 13:22:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: pse-pd: add Realtek/Broadcom PSE MCU
 driver
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20260630105651.756058-1-jelonek.jonas@gmail.com>
 <20260630105651.756058-3-jelonek.jonas@gmail.com>
 <akYPfkRbEzWFuC6j@pengutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <akYPfkRbEzWFuC6j@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-304133-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA1D66F6E4B

Hi Oleksij,

thanks for your review.

On 02.07.26 09:13, Oleksij Rempel wrote:
> Hi Jonas,
>
> On Tue, Jun 30, 2026 at 10:56:50AM +0000, Jonas Jelonek wrote:
>> [...]
>>
>> +struct rtpse_mcu_port_config {
>> +	bool enable;
> in this struct we use only enable, do you plan to wire it somewhere
> later? I assume you wont to keep it as documentation. May be add some
> debug traces? And add some comments what do you already know about this
> fields.
>
>> +	u8 function_mode;
>> +	u8 detection_type;
>> +	u8 cls_type;
>> +	u8 disconnect_type;
>> +	u8 pair_type;
>> +};
>> +
>> +struct rtpse_mcu_port_ext_config {
> Same here.
>
>> +	u8 inrush_mode;
>> +	u8 limit_type;
>> +	u8 max_power;
>> +	u8 priority;
>> +	u8 chip_addr;
>> +	u8 channel;
>> +};

This might be good for follow-up patches. Right now, I don't get
the full complexity of the pse-pd framework so I'll rather keep it
simple. I see that at least some of this information is reportable,
though not configurable (yet).

I suppose it's preferred to not add unused stuff so I should just
drop the unused fields and add them later as needed. There isn't
an urgent need to document it here either, the guide I based my
driver on is quite available here and there in the web. I haven't
actually dealt with all those fields close enough, so adding
half-baked comments about them isn't good either.

>> +			break;
>> +		msleep(RTPSE_MCU_BOOT_RETRY_MS);
>> +	} while (time_before(jiffies, deadline));
>> +	if (ret)
>> +		return dev_err_probe(pse->dev, ret, "failed to read MCU info\n");
>> +
>> +	switch (info->device_id) {
>> +	case RTPSE_MCU_DEVICE_ID_RTL8238B:
>> +		pse->chip = &rtl8238b_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_RTL8239:
>> +		pse->chip = &rtl8239_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_RTL8239C:
>> +		pse->chip = &rtl8239c_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_BCM59111:
>> +		pse->chip = &bcm59111_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_BCM59121:
>> +		pse->chip = &bcm59121_info;
>> +		break;
>> +	default:
>> +		return dev_err_probe(pse->dev, -EINVAL, "unknown PSE id 0x%x\n",
>> +				     info->device_id);
>> +	}
>> +
>> +	if (!info->max_ports || info->max_ports > RTPSE_MCU_MAX_PORTS)
>> +		return dev_err_probe(pse->dev, -EINVAL,
>> +				     "MCU reports invalid port count %u\n", info->max_ports);
>> +
>> +	ret = rtpse_mcu_get_ext_config(pse, &ext_config);
>> +	if (ret)
>> +		return dev_err_probe(pse->dev, ret, "failed to read MCU ext config\n");
>> +
>> +	dev_info(pse->dev, "%s MCU, %s (id 0x%04x), %u ports across %u PSE chip(s)\n",
>> +		 pse->dialect->mcu_type_str(info->mcu_type), pse->chip->name,
>> +		 info->device_id, info->max_ports, ext_config.num_of_pses);
> Reduce it to debug level print.

Is there any guideline about what drivers are allowed to print during
probe? Usually, I'm a fan of at least seeing an immediate sign of life
from a driver, even in success case. And I also see that from drivers in
other subsystems, e.g. fan controllers or GPIO expanders.

>> +	return 0;
>> +}
>> +
> Best Regards,
> Oleksij

I'll address the other points I've not reacted to explicitly in the next
version then. Same for the low-severity sashiko-nipa issues.

Best regards,
Jonas

