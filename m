Return-Path: <netdev+bounces-300051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dm8JFv9DMmq0xgUAu9opvQ
	(envelope-from <netdev+bounces-300051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:51:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7794696F43
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:51:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WCqJCXi9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300051-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300051-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D03D3051176
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA33B6BF1;
	Wed, 17 Jun 2026 06:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342E381AFC
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:50:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679049; cv=none; b=ZbUL6B2oGRZmH0fF8T74jB3C6cLNk6Sv4Z6mtANTL94z7xN24HsZcRiAU58kfjwPglgfbVuLdiiGQAsBZcaykdr7rOl6S8udm6rxSdJeYpmdz1M+rwVMDCT25sJff57it9LTBpS+KZ3h0ca04yfdZRxAJxxnckiaufgIiauqNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679049; c=relaxed/simple;
	bh=C7YFZCCu1dOeCsLg6DoF+9ZVtNHvPRq+h+Zo6dLBmB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuNjliq3HxMeytqYFNSxprO49CLFXscHSgPwTSFG1OC9WbXuTKQUFJGbYbuzMqxgtKPf+e29kVkyh/Qizq7bE7NwS4tjvn0Y9J60iyj7yUJ5jdEsFRbZ1cgOSFiNjSkH1Awl3AMqWDzarJKb/8SRDRGgchkM/9qL8AaLrSjWTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCqJCXi9; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46066e640easo3288185f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679047; x=1782283847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Trq1GUdrJefwFDKO73LEpHAox6MBJ2GUwy+Cih5DopY=;
        b=WCqJCXi9yibRSJ5D2QIBg96wVMVBsltG7hqEhWSiMMjpnepNe7JZcNqou8TvpStsC5
         0O2VRVRDsZr8u6wYnVE9CMPpGHdot2XRhpzV5dySGs2ikkqUNBVPnz3FHJ7bZ1+V+TEP
         aihcJCNbrHAZozcBZVodaoqGw+qhMxEUK8KO5H5WWYnmMpFxSCOLQKtK/fGUyB/z8sxB
         ijoPo6PGn3OTd36WIVXzLOKNiutmb6rQoKwKI6s7cRcJ/20qJnOCoCpTeuT7D0VkSDkp
         2SON5gb7viS29bcJumAjOzlr6/idKj4TDUPRF4JNb8d4dR/xoIkC+K73wDSZqiZ4ZhXu
         aoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679047; x=1782283847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Trq1GUdrJefwFDKO73LEpHAox6MBJ2GUwy+Cih5DopY=;
        b=Y4krXeAh4vce4z1EoSTncxr9WxhW53wSClrwNJ4Jyrbq2A50AbtFNWVOMdDluuhf+y
         1pW78N6ac3z1oy4HwgcRmU1kQ1vd7Vrpx3m0WuypJV3LKLkFYWg0NF2Jd5bxHu9JncoY
         bOAfPlisgJLrbHdenMlBncvFrZh+GYhyUQRD1NrH4YjkiJUNTjbirpTyr0QZf0xPQPuR
         To2ZkF9LSpswTwLkV3+pzv4nZJ2XsBNOZEYiOuYs4shqD76Bgyu1fhoKBHwSNluOTQNP
         vKB3pCcJ/7vpDGKJ7rj37aDC9lC0Mt3F2y6nDRdsbzx4VhBtJB2sonOU+3v1x/tf7gQH
         R8VQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mnKFxu6nFAPPAUZF7lLJ6ohtITkpuIJy/IfwQ5NI7gV9PGBlHHREpzaI0jcGWCSyTpp7fXXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyaNcF68cCnXFLurYOyz9+4t7tSj/ejI8jQKppQPPd08d9hmR
	CV8sMzBZXU/YNlyM6h0N9LBpJkAwbLjgmAYTZvJNWW5aoE50C1zDuZmV
X-Gm-Gg: Acq92OEtg/SKsgUxVFZ9Ck9ecH4URgeCcLSY1fsCkorPLVYOcMqrHquoqDvYlFSyZxX
	heJxJpngLPGJD0pvxf7wARQlby1PF++qobHwSvRTAGqLA60Q1OYQQYipW3z5ZYmr6MGxDHZCArX
	MXW/SNTPuyZgPbAjs1m29UYSBjsboaae4OjpBpEptCYC2UIyfOwNAnoNQOR0rssD72/oFMjFNkB
	1217kior55GicQqjuHyLosBzVcW3+uVmgtEHlwA8/0txCvpJmEBOlgnzo2n5ENk+my7jynTDN5v
	KdvRetO7Vzc1k8RvQwov5Hqgf8TFZVrWKnFWBsLrKJHuPOh7Uf6QLSuq6n+MCr0TgeJdKKsjsh3
	dUBxc4LNRCdEhZS7UcaWQ7di2iTxkpe2QgUTd8wG+KRJi3v9TZTX7lel/cAins/7rKP/FPDgTIq
	AZTJndi8+WSbE0GDSQ8Q9Q1vvP2cGWdQJpZy/Hd98q6ilbrBniWxztm0EprcDng2mBYBmTd/HV3
	hXtCeOXNwL8oLc=
X-Received: by 2002:a05:600c:a111:b0:490:e5c1:b89d with SMTP id 5b1f17b1804b1-492333ffd28mr36380385e9.0.1781679046294;
        Tue, 16 Jun 2026 23:50:46 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f13a:1701:b918:4041:7c7d:eb1d? ([2001:9e8:f13a:1701:b918:4041:7c7d:eb1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49233bf0881sm41430175e9.2.2026.06.16.23.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 23:50:45 -0700 (PDT)
Message-ID: <36668b89-77ef-406f-9edc-ed57a025754b@gmail.com>
Date: Wed, 17 Jun 2026 08:50:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260612132944.460646-1-jelonek.jonas@gmail.com>
 <20260612132944.460646-2-jelonek.jonas@gmail.com>
 <20260615212959.GA1679454-robh@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260615212959.GA1679454-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-300051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7794696F43

Hi Rob,

On 15.06.26 23:29, Rob Herring wrote:
> On Fri, Jun 12, 2026 at 01:29:41PM +0000, Jonas Jelonek wrote:
>> [...]
>>
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - realtek,pse-mcu-rtk
> The "rtk" feels redundant.

In the full Realtek case yes. Do you have a suggestion to improve
that?

>> +      - realtek,pse-mcu-bcm
> "brcm" is the standard vendor prefix, so use that instead of "bcm". 
> Though who defined the protocol in this case? Realtek or Broadcom? In 
> the latter case, I'd argue that "brcm" should be the vendor prefix.

I'll switch to brcm.
As Daniel already mentioned, Realtek defines the firmware and thus
the protocol, in both cases.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  power-supply:
>> +    description: Regulator supplying the PoE power rail.
>> +
>> +  enable-gpios:
>> +    maxItems: 1
>> +
>> +  realtek,i2c-protocol:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum: [ i2c, smbus ]
>> +    description: |
>> +      Wire framing the MCU firmware expects on the I2C bus. "smbus" means
>> +      reads carry a leading command byte (0x00) and a repeated start; "i2c"
>> +      means bare 12-byte writes and reads with no command prefix. Only
>> +      applies to the Realtek I2C attachment.
> I tend to think this should be distinguished by the compatible string. 
> That would simplify the schema given it only applies to one of the 
> compatible strings.

In theory this could also apply to the Broadcom dialect, however I didn't
have a device with that variant on my desk.

If you would go with separate compatibles, do you thought about
something like "realtek,pse-mcu-rtk-i2c" and
"realtek,pse-mcu-rtk-smbus" (given we stick with rtk) ?

> Rob

Best regards,
Jonas

