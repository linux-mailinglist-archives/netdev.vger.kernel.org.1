Return-Path: <netdev+bounces-215824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FBB3084A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFE33ACC49
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956912C026B;
	Thu, 21 Aug 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="E7Ze60CN"
X-Original-To: netdev@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE52BD001;
	Thu, 21 Aug 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811316; cv=pass; b=aaORIOpLJVEA+8B8f+l1Eguax2mXDzlPiHWtbIqIX7uUr8BD0wIaolgJPN3EhfigLKe2vQU5NIBVaRzSHzXITieA1NG6a8y2A41NlBTn/tqo2tD54EW4KsErJLhxdMIauW85TWKf1GVfdohWw8W1YKONeLihrfgcynLQp8aIH0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811316; c=relaxed/simple;
	bh=gHc9N+sPNmbFdoVvlcXaXBnEUwSsL2C2pPfbjITtm2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T24ZERiKtkukb2gip27u04p3LUQ2LzdbRX0C7Q7gHbl6my40KWs8SMPfIl1Qe3ffqIclOMSQzuc2POlhxgQ5Zybfc171Mpr/qb0aUFeRICrvAFE5BlSU/y+k/ewng1EPNnhJXrQ48gD2LoLe0isoUAuS8XhPYYpoiFODy4IS5BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=E7Ze60CN; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 67DB02C60D5;
	Thu, 21 Aug 2025 21:02:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (trex-blue-3.trex.outbound.svc.cluster.local [100.96.37.67])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BB8372C6073;
	Thu, 21 Aug 2025 21:02:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755810165; a=rsa-sha256;
	cv=none;
	b=VA395R/iBN/iOB+2AT3Sx/h1V57sN4gvPNEF/dlZq+Ge5opPfCJ/TpPnVatyDp0CHNJxEv
	tfDOgcPj/9I3SSVqRyD5TEldt/tqv/xweW+60BgBStohBbFv8e2ynhrglN2nyyxh25jZQA
	YORnb92Kh16oV1zpUf9tESKgdmeBarvhIeE7vF0+64eZYgtrrOlVucRk0kDNPxv7OQ5qY/
	E2N1+scnJbeXWvTnXGmf8uS0oFkgbmIM+zJq5T0ul1As2+W1OWWVvNCUD+YIrVnck8t/2A
	ji//1hdJ9dZfNDYeeIgIAVsb/CjjUaJAfb6JHpd7XAcTnKIglfss8ZWkvQuNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755810165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PiRdnVkb3Mdck8rf90p7+DnOfB9A+JduUXfai72Z7+4=;
	b=fvPcQG0GmaTFX0s1SvnPmsgzy7jrpdnnof5z+FJUBRcZNz6Yrb7EjpplCBztg5XKo8l85X
	vHXX5ehr9qCvBYjGuVtmUvNX7211fZM0R9Xql2poMvPoFXHnoBmEFYsyNj4CC5rM9SmwHO
	EAPh/w93JrVjFX3ybeA5SbFS+CvE6mYStAXAMcPUXA2p3YmsqIRTR+lWEtDtz6xxqipg7a
	wI/lpLAQAIurkhZwCy7PSEzAmul2gk48lwVbObDJY/IKmMwgd9RSptaiYI45tUTfv3K7ml
	HcRlx8kRl3opZw0WLx0xmQEJVlTb7vOavtegGw4yurw/8Zt+PJG4G0s6aM2eNg==
ARC-Authentication-Results: i=1;
	rspamd-b597879cf-ngsbq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Bubble: 2f8dd21033f8e097_1755810167283_2720825162
X-MC-Loop-Signature: 1755810167283:381200934
X-MC-Ingress-Time: 1755810167283
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.37.67 (trex/7.1.3);
	Thu, 21 Aug 2025 21:02:47 +0000
Received: from [IPV6:2607:fb90:faae:51e1:d9d4:2e42:ae75:9827] (unknown [172.58.14.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4c7G431Sm7zDF;
	Thu, 21 Aug 2025 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1755810164;
	bh=PiRdnVkb3Mdck8rf90p7+DnOfB9A+JduUXfai72Z7+4=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=E7Ze60CNKAiVA+WD8T4gncR5kdArdw1idFuny3yPyKtIHpxERaG5Sb3tizBAEbBL/
	 1rZpQo1GhUTePym7uXRlMqKbqQScRPDFlva0DiRf+aR0LSjS/M+i/0OSjzvlYfTtCd
	 IgsnjyNyyunyCtWVkBI/altwWbggCNtHJGZ7XJ3zZhXH203GZsTE7otLwmIRNL/uUV
	 Fjdx1AxvsaHevwhNKe1sIfhj+tUt6JSudtond1NWpomo1JJ7C5lGodn70E5f4LSu22
	 96C1BYubVxQ4CfoUOIKdH3ZsHxphuqfLytr7+LmMt956XvMF7DNvFXe8gaUzBPpzRP
	 pM+ZgqBhRFNkw==
Message-ID: <4df745a6-2997-4eee-87b1-0c77ff46cfdd@landley.net>
Date: Thu, 21 Aug 2025 16:02:41 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
To: Rob Herring <robh@kernel.org>, "D. Jeff Dionne" <jeff@coresemi.io>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Artur Rojek <contact@artur-rojek.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815194806.1202589-3-contact@artur-rojek.eu>
 <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
 <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
 <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
 <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org>
 <295AB115-C189-430E-B361-4A892D7528C9@coresemi.io>
 <bc96aab8-fbb4-4869-a40a-d655e01bb5c7@kernel.org>
 <CAMuHMdW0NZHCX1V01N4oay-yKuOf+RR5YV3kjNFiM6X6aVAvdw@mail.gmail.com>
 <0784109c-bb3e-4c4e-a516-d9e11685f9fb@kernel.org>
 <CB2BF943-8629-4D01-8E52-EEC578A371B5@coresemi.io>
 <20250820213959.GA1242641-robh@kernel.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250820213959.GA1242641-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/25 16:39, Rob Herring wrote:
> On Mon, Aug 18, 2025 at 10:55:51PM +0900, D. Jeff Dionne wrote:
>> J-Core SoCs are assembled with an SoC generator tool from standard
>> components.  An SoC has a ROM from soc_gen with a Device Tree binary
>> included.  Therefore, J-Core SoC devices are designed to ‘just work’
>> with linux, but this means the DT entires are generic, slightly
>> different than standard device tree practice.
> 
> Yes. Though doesn't the SoC generator evolve/change? New features in the
> IP blocks, bug fixes, etc. Soft IP for FPGAs is similar I think.

The j-core guys almost never change the hardware interface on a deployed 
I/O device: when the existing interface is too limiting they do a new 
design with a different interface. (You'll notice in the github soc_top, 
components/ has ddr and ddr2, and components/misc has aic and aic2 from 
when the interrupt controller changed, for example. Those aren't version 
numbers, those are rewrites.)

Outputting a different constellation of devices/busses from the SOC 
generator is more akin to running "make menuconfig". There isn't an 
ancestor/descendant relationship there, it's a generator working from a 
configuration to instantiate and connect existing components.

> There
> we typically just require the versioning schema be documented and
> correlate to the IP versions (vs. made up v1, v2, v3).

There hasn't been a new version of the 100baseT specification recently.

The same chunk of bitstream is still driving the same PHY chips on the 
boards (or compatible, long out of patent) via the same small parallel 
bus at 50mhz. The engineers are no more interested in changing the 
kernel side interface than they are in changing the PHY side interface.

> This is all pretty niche I think, so I'm not too concerned about what 
> you do here.

Eh, not that niche. Just hardware development culture rather than 
software development culture. What's the model number on your microwave? 
If you need to replace it, how many versions will you advance?

Chip model numbers tend to be assigned by marketing well after the fact, 
and don't necessarily have a linear relationship even for the big boys 
making central components other people build entire systems around:

https://en.wikipedia.org/wiki/List_of_Qualcomm_Snapdragon_systems_on_chips

The Pentium II's development name was Kalmath, Pentium III was Katmai, 
then Pentium 4 was a space heater and everybody backed up and switched 
to "Pentium M" (which was MEANT to be a mobile chip but was instead a 
"not stupid" chip) and then they did "Core"... And then "Core 2" and 
"Core Duo" were different things and "Core 2 Duo" was both of those 
things, and then they had i3 and i5 and i7 but they all came out at the 
same time...

Jeep produced a "Cherokee" for 50 years and expected the user to step 
from a 1973 model to a 2023 model and be able to drive it the same 
(modulo major flag day changes like stick shift or leaded gasoline) with 
zero learning curve. Hardware developers of today go "here's an sd card, 
it goes click-click into your device and it just works, the only numbers 
you really need to know are price and capacity" (modulo microsd, but 
they still provide adapter sleds).

Software developers think that "DOS 2.0" and "DOS 3.0" or "Windows 3.0" 
and "Windows 3.1" being profoundly different and largely incompatible is 
just normal, and track that stuff minutely.

Different culture.

Rob

