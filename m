Return-Path: <netdev+bounces-296170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QUsTNHHDJGoM/AEAu9opvQ
	(envelope-from <netdev+bounces-296170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 03:03:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1368564EA25
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 03:03:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pardini.net header.s=google header.b="JfGqC/ws";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296170-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296170-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25E43300BD94
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48A1B4F0A;
	Sun,  7 Jun 2026 01:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9914071CB
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 01:03:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780794205; cv=none; b=LIBTHU2nm0eBiEb8hepRshmH0W6CSsb4FaGxHfGQGaFovNJw/sjGUAJDHpdZmi8UKUCKGUawqekPSBcGsYgzpTW3tFRGzNdTwsCFyYj6bRMg5xzkv+AuJ4qFbUj8zKE0WNXgKS7KMwYjOzgspCBFySyhIJE2JJ9ajVFEg1P3pes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780794205; c=relaxed/simple;
	bh=V7tezCKTEwZpa11y/H0dMbg03qX0QXGP1XKis3C+aNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3fF+xl+3s3Hltcj4yckYxLwI+bxuki8iBhtla+yCZQrugnuQpS2HAufzqAFckiHZ+7CP8D9aeNF3HKUXixt12Pfv38K80h4QkfMxFK1Cko6E+odN0favAwN4ZKZKhjavYPvEGrntgeasKhZS1xswJBkqUXW4uzpdpUzn1G+yFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net; spf=pass smtp.mailfrom=pardini.net; dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b=JfGqC/ws; arc=none smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-becfa735b9aso437661966b.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 18:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pardini.net; s=google; t=1780794202; x=1781399002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqAMDji/Y/ZfDPdozsCR+NdaIZJxhg+V9OuE8Iuwqx0=;
        b=JfGqC/wsx5Hqql7fs+BsCvQYlBZMhQ0dLHiNBps2c+/LrK92g8nsLvEO0IHFPMg3dl
         59rqd5zwKfJynEIOqQFO87Whd81MdW4B1AqcNrw1zTcQxCX0ryjokLydJ2NkQGSN/D9w
         +0bcYW8ZP87M6mwGVPDH33S/MLvXjWIlKDlUVluH00EihswRPr12/X/S2403LNPK8cXl
         F59owFAS38NlUIWp88lfczEned9edLNMan3RYy6IrHWWLiCsN4lE5a9ytuqITbjgxMnE
         6qPM+E9sZbcRJHc2qTFtZxF+LIfQMdGPORmp4lT6Szikhr50To75B56qH/Hsa4YYu7Sh
         81SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780794202; x=1781399002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqAMDji/Y/ZfDPdozsCR+NdaIZJxhg+V9OuE8Iuwqx0=;
        b=XXZIJWJh/FD6h63qezQbuTYmuSuF4QHIQXMc9l6tPpBl0q5UwMGiPRPU1I2ZCDnr2L
         4pcccFR4krKYQa1L8EbcDVt68Jrqhkry2IZnJ1tTbeW4qvkRRP6FfhdG3/mJeu0yedbC
         HEoZ0OByhj5JFtrfeYIqdtEs/+cFmkl/JioEM0VR/FHNmu1bhNwwMRHZKQULza+Ss84w
         +b6UFU3rSg6TP3ML/JIhiEh3zopXM71EO7TfFBxvQW/AKUPNvEWjt85inIZk33GrQJq1
         ghLQ9WQnMSkQ2lUtNp/9k96Iq1IQVLZnlUFwtt8/DLGcP2CElCleUsxtVakyH6qQtVv5
         2c5A==
X-Forwarded-Encrypted: i=1; AFNElJ8KXf0UCjkExv3mroCP2EA5obCCfe4TDGWiJOwtNYgLUjIzHx8y/+ejG2zlAxTa9lg4RzPaGLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2I8Uf0MVxDwSRkRFFtJCUWnSAaYlj2M87fbnx5ssRrMS6edl
	bE+h5fcnZI7vQFhZAa0SM4lBQxqeJuttn1XOpID+gLXfRpYmCsm39snwlpFz84eNlg==
X-Gm-Gg: Acq92OGyUgcILvpi6Wu4k/NCIWhyKMeA8sMsD/fE9GylnHoPvh1ZfozXbjTekBCa8qH
	s1guGKWKA5EN5Uula9HwPjuM/gH4IqhiMXLWSwNwjctRrrVS4liAEG6dUxHI/5avrA7mbbl+Z2j
	XEYAl0IoJitWzyOvJI+B31xJUJ9+e5qgSXMnvuNDZH4kuw8qDFD/Xp3Jv7MNkrk5DRDG0HmR9dA
	fp1zqtQSHMPQp4SJQwxYsvvffQplA81qGR/2NNX3O40vYGVpRlEDlKmkB0Wd/dy1fvrSEnh9d0u
	ZHEZQh7Q5oFDr0Iya5Uf51Jcts1i2heWrhNt62Qx8MeYu3OxtThkuMkdwNi61O6O5OqUar+j9+e
	3ndD2x5MUkB09BCeIKsAKZ3ZhuXsXBpVBUx4hDrxgtMEwezkMWLuUBIeUyuc7eL7SvEk/Ogs8Uk
	/hx1Jb7hKJhwRaoZE4eKC7zoZUPOQH0JZYc4J2ENzI+FUZZwRSWHKCPa/uMTe8Td+RdvceDSL0u
	AayB0jpyxcu96epebgaQ4riGn41Lm6Kly1FCTrMBnrQwK8M3c7qRyGr6WOJKujBCCaQhtoD6a6H
	L7FO
X-Received: by 2002:a17:906:6a01:b0:bed:87c:b24e with SMTP id a640c23a62f3a-bf3721513damr453039466b.29.1780794201771;
        Sat, 06 Jun 2026 18:03:21 -0700 (PDT)
Received: from ?IPV6:2a02:a466:4d7a:0:9569:75b0:b281:a338? (2a02-a466-4d7a-0-9569-75b0-b281-a338.fixed6.kpn.net. [2a02:a466:4d7a:0:9569:75b0:b281:a338])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e0280asm654743666b.33.2026.06.06.18.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 18:03:20 -0700 (PDT)
Message-ID: <04ef65b1-e28f-42fd-b054-d1843205f67d@pardini.net>
Date: Sun, 7 Jun 2026 03:03:19 +0200
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
 <26da1dfa-3408-4654-9046-36ed6d57059c@pardini.net>
 <667f64e0-2b3e-41bf-9c97-3562696d3af7@gmail.com>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <667f64e0-2b3e-41bf-9c97-3562696d3af7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[pardini.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
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
	TAGGED_FROM(0.00)[bounces-296170-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1368564EA25

On 06/06/2026 22:50, Heiner Kallweit wrote:
> On 06.06.2026 07:03, Ricardo Pardini wrote:
>> On 05/06/2026 17:48, Heiner Kallweit wrote:
>>> On 05.06.2026 13:49, Ricardo Pardini via B4 Relay wrote:
>>>> From: Ricardo Pardini <ricardo@pardini.net>
>>>>
>>>> Add a binding for fixed/soldered Realtek PCIe Ethernet controllers
>>>> driven by the r8169 driver (RTL8125/8126/8127/8168 and variants).
>>>>
>>>> The "pciVVVV,DDDD" compatibles are the Open Firmware PCI Bus Binding
>>>> spelling, auto-derived from PCI-SIG vendor/device IDs, but they still
>>>> need a binding when used in a board DT - analogous to "usbVVVV,PPPP"
>>>> compatibles documented in their own bindings (e.g. microchip,lan95xx)
>>>> so board DTs attaching properties (fixed MAC, nvmem cell, ...) to
>>>> these PCI function nodes can be validated.
>>>
>>> The of node seems to be created by of_pci_make_dev_node(). But this
>>> function is called for bridges only in pci_bus_add_device().
>>> So where is the node created in your case? Did you test node creation?
>>
>> Seems to me of_pci_make_dev_node() is not at play here - that's the DT-synthesis path. For nodes already present in DT, the of_node is bound earlier, during pci_setup_device() -> pci_set_of_node() -> of_pci_find_child_device() via the 5-cell reg.
>>
> I see, thanks. If the matching is done based on the reg property, then I just wonder
> if and where the compatible string is used. Or would the logic also work with a
> random compatible string?

Thanks, Heiner. It seems the compatible is not involved in the kernel 
runtime matching at all (and u-boot simply patches DT via the ethernetN 
alias).

I guess DT-wise, specifying compatible (although not strictly required) 
makes sense since DT describes the hardware; "there's an RTL8125 at 
0x410000" sounds better than "there's a PCIe device that needs a MAC 
address at 0x410000", and having the binding opens up usages of 
non-generic properties, although that would be future-looking.

At this stage I've to ask the devicetree folks: should I simply drop the 
compatible from the DT patches (and the whole binding)? dtbs_check 
passes without it, and it also avoids the checkpatch.pl 
vendor-prefix-undocumented warning. There's precedent: at least on some 
Apple Silicon (2022, t600x-j375) and NVIDIA (2019, tegra210-p3450-0000). 
On Rockchip there's quite a few (10?) boards using the same RTL chip we 
might want to describe.

> [...]
>>> This list reflects just some of the PCI id's handled by r8169.
>>> Any specific reason for this exact selection?
>> I went for "chips likely to be soldered down on an SBC", but that was indeed speculative.
>>
>> I guess I should trim to pci10ec,8125, which is all this series describes? (further IDs can be added by the patches that introduce boards using them)
>>
> Yes, I'd prefer this approach. Considering that RTL8168 has been supported for
> about 20yrs now, your use case seems to be exotic. Otherwise I would have
> such a patch much earlier.
The Tegra Jetson Nano has an RTL8111 described in DT for this exact use 
case (without compatible) for about 7 years now -- I just couldn't find 
it until now.

I'll wait for people to chime in, and later send a v4 either dropping 
the binding, or trimming it to only the 8125. Sashiko seems to have nice 
suggestions [1] on the YAML too, in case we decide to keep the binding.

--
Regards,
Ricardo

[1] 
https://sashiko.dev/#/patchset/20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf%40pardini.net


