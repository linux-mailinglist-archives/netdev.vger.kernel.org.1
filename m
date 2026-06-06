Return-Path: <netdev+bounces-296039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TsUFH0eqI2qowgEAu9opvQ
	(envelope-from <netdev+bounces-296039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E6664C79B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:04:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pardini.net header.s=google header.b=GZrsoX1z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296039-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296039-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B4CD301C3F0
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 05:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8E2F8E8E;
	Sat,  6 Jun 2026 05:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DB524F
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 05:04:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780722244; cv=none; b=cF2YRKM2jt46B2oi9piMmOQunTDbf9z+wPDphFIFGOPop5j2jaCZwoalR8JoA4jPg5UDFqUXKoUvRwdcWWV2KHkgF+BxvRCXlrPIXK3DhGQQ48OcIttslalYAZNwWmlPdw9O5RICi0US15ATFv0ZvK8iYDJYp6yAyNSprgSUCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780722244; c=relaxed/simple;
	bh=263QfBY5Zp+gfX2SSDrodQXz/EAIY/aQ/Pr5s0xl9+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIAZV9Bs9FtHzHDhRQHrqT8CgkURyHl4kBLEDZ6keV5ciqdRMbMai5DFTknUQKLaAIfvrEVnA378Jncuo9NyysU1eMFzyqBZ8TIpACTz3r3ncrbUlz3zbY+5YzDGUpiXrN3cl8bjM/XIfm7M9BiLdvBDWsXinTK0CjM50Rg4Q1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net; spf=pass smtp.mailfrom=pardini.net; dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b=GZrsoX1z; arc=none smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so3778435a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pardini.net; s=google; t=1780722242; x=1781327042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ad3Risuri9Oy23ttuXXObF+tJAD6dYgEl+kDhesPP88=;
        b=GZrsoX1ziTdDLcdmOAsCHNY+OeE3e5tdgZDTirvyA8VQdLnrB0uiVrpcwwBCPpiH8E
         56TTq067Mz7cq3cPfUcoDPjmyBuTkVKUvdjb4cFjhwjC3TblyCh0ymondJHKqduCiCCT
         YjAdydm+f96c14j8w1y3vGy6sh6tcr/EEZFdfmFqZwWHTG08z5kdLubGIHS1PDl89oEC
         GbWxqWWc6JxOcLtA7R4rBvZneI1qRMLBKqITxDluKzE17ugE0txz1Cf1j5Nocdm1/EN2
         7L0hVwxnfJOIquakxQ5Tyn0x+84uMVWVt641klWNDZKC58IJMzOxDPn6rE+Wvl9R+sc9
         BIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780722242; x=1781327042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad3Risuri9Oy23ttuXXObF+tJAD6dYgEl+kDhesPP88=;
        b=dEYyD+QnSvtrILA1kv8VrA/jWzJULTKToCm0BnjHQIzzkdTVBVGNezG916GiQbIN9H
         L474qj3zskpmRYD+QMo3TB9EOacCM12pldmDICOw1iIptIHFcbBzc6yImqqKggXEhPdK
         U9IxEu7Yzy+LOPveLrQelQgg+pqOikwsfdj10qFUns/KWxht/sCB8+Bil8wleoIwff5c
         +n44RHrN8h1EKeIPiP1bDWD8BIFc0e+a5znQJC+WU2wX1b2Cemdyopm/3Ba2zwaMAVN7
         EAVkAdcj965bqh4/U8K3Ijuli3MrB1qQkN7A9TG4T2iENb6rYOlePPDZkuu2kdcfreTm
         9BZg==
X-Forwarded-Encrypted: i=1; AFNElJ/a45ANrcg2+YW6lCaAD5dKLKl6tpNkbXZ4AzVXjKrqiPR3xSi9yuDb8ubBwJsz+YCb4DY5LDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dZRR0VGGEEFZ+tkySOaKDGUey7ofDYkI268FIZtxFVTIw7sx
	rOHEgC/xTbm3A59NjNOBTn/4YN31tedE2ne+DSLSQhAeAag+mT0IzYE53LMu7yGymQ==
X-Gm-Gg: Acq92OHXm59VgUNvyU8fjTCqi451eHCd2FZwWy4HGemCWjjGTfaBwzisMO5eSOyVJjA
	W62A0GfUB5Ci5KVgNm7HaDsmlX4MWSKnCUz6UYLkMmqEYH29UrmE+uOgNWaO1O6NRfkmHTZoc0v
	xIJTI8SFVdtC/NItBFONsp6grJVWTvn7geHSTBcFgRzPDvi/sE1QXrZWwxU2SYIi44YK6ke5ksa
	+38IYQbYGhIpU3mLKbMKW/GYur3uv7zjAKlcnD9Brq1UERs0YBQPJCLQWJf94cEfKcDSSA4cu7d
	max+jpOk4bVTO6u3JLLT1K3cqp18mz1pr8gu7YvhO63tl00RznPthrM5hSSySbP+4j7v/Owo4mI
	zcKXwnqkhn0z+aVwkfMTnk050CcAh/8JP7H2A0qXfYDSZJFAsoXXXiMkTPbQ7wzRkS/0cPVdHOr
	Qm3OxQ3H8KBEUKeIATCDshoclKv218eKYmYErqjt3ijy6uYoEyRrxJUrD3s5LlO73+dYhr8VYxX
	y2o6SwXYXdPVam/svFtix+lv6iLiKTP7QLmxrJyNEh6g0mt6TMSrvrUEjr3jHoOtDRcj5kxxNlk
X-Received: by 2002:a05:6402:268f:b0:68e:4c0:f599 with SMTP id 4fb4d7f45d1cf-68fa4c16b80mr3088882a12.5.1780722241268;
        Fri, 05 Jun 2026 22:04:01 -0700 (PDT)
Received: from ?IPV6:2a02:a466:4d7a:0:c439:8cdb:ad2:c0fb? (2a02-a466-4d7a-0-c439-8cdb-ad2-c0fb.fixed6.kpn.net. [2a02:a466:4d7a:0:c439:8cdb:ad2:c0fb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6915a637180sm421874a12.26.2026.06.05.22.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 22:04:00 -0700 (PDT)
Message-ID: <26da1dfa-3408-4654-9046-36ed6d57059c@pardini.net>
Date: Sat, 6 Jun 2026 07:03:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: net: add Realtek r8169 family PCIe
 Ethernet
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net>
 <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-1-8a8857b39daf@pardini.net>
 <b7cc8eba-ff6e-417d-8e74-b3bb24e08a26@gmail.com>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <b7cc8eba-ff6e-417d-8e74-b3bb24e08a26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[pardini.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,sntech.de];
	DMARC_NA(0.00)[pardini.net];
	FORGED_SENDER(0.00)[ricardo@pardini.net,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296039-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo@pardini.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[pardini.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pardini.net:mid,pardini.net:dkim,pardini.net:from_mime,pardini.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70E6664C79B

On 05/06/2026 17:48, Heiner Kallweit wrote:
> On 05.06.2026 13:49, Ricardo Pardini via B4 Relay wrote:
>> From: Ricardo Pardini <ricardo@pardini.net>
>>
>> Add a binding for fixed/soldered Realtek PCIe Ethernet controllers
>> driven by the r8169 driver (RTL8125/8126/8127/8168 and variants).
>>
>> The "pciVVVV,DDDD" compatibles are the Open Firmware PCI Bus Binding
>> spelling, auto-derived from PCI-SIG vendor/device IDs, but they still
>> need a binding when used in a board DT - analogous to "usbVVVV,PPPP"
>> compatibles documented in their own bindings (e.g. microchip,lan95xx)
>> so board DTs attaching properties (fixed MAC, nvmem cell, ...) to
>> these PCI function nodes can be validated.
>>
> 
> The of node seems to be created by of_pci_make_dev_node(). But this
> function is called for bridges only in pci_bus_add_device().
> So where is the node created in your case? Did you test node creation?
> 

Hi Heiner,

Seems to me of_pci_make_dev_node() is not at play here - that's the 
DT-synthesis path. For nodes already present in DT, the of_node is bound 
earlier, during pci_setup_device() -> pci_set_of_node() -> 
of_pci_find_child_device() via the 5-cell reg.

Ref testing: yes; with this series on a NanoPC-T6 I get, for example:
/sys/bus/pci/devices/0004:41:00.0/of_node -> 
/sys/firmware/devicetree/base/pcie@fe190000/pcie@0,0/ethernet@0,0 and 
u-boot correctly adds local-mac-address property there which is 
correctly picked up kernel-side:

=> setenv eth1addr 8e:b4:90:66:66:66
=> boot

...

# readlink -f /sys/bus/pci/devices/0004:41:00.0/of_node
/sys/firmware/devicetree/base/pcie@fe190000/pcie@0,0/ethernet@0,0

# xxd /sys/bus/pci/devices/0004:41:00.0/of_node/local-mac-address
00000000: 8eb4 9066 6666                           ...fff

# ip link show dev end1 | grep ether
     link/ether 8e:b4:90:66:66:66 brd ff:ff:ff:ff:ff:ff


>> +properties:
>> +  compatible:
>> +    enum:
>> +      - pci10ec,8125  # RTL8125 2.5GbE
>> +      - pci10ec,8126  # RTL8126 5GbE
>> +      - pci10ec,8127  # RTL8127
>> +      - pci10ec,8161  # RTL8168 variant
>> +      - pci10ec,8162  # RTL8168 variant
>> +      - pci10ec,8168  # RTL8168/8111 GbE
> 
> This list reflects just some of the PCI id's handled by r8169.
> Any specific reason for this exact selection?
I went for "chips likely to be soldered down on an SBC", but that was 
indeed speculative.

I guess I should trim to pci10ec,8125, which is all this series 
describes? (further IDs can be added by the patches that introduce 
boards using them)

--
Regards,
Ricardo


