Return-Path: <netdev+bounces-214402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2096BB29405
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A93C2A4D13
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13F2E371F;
	Sun, 17 Aug 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="XCpqFCqx"
X-Original-To: netdev@vger.kernel.org
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8314B086;
	Sun, 17 Aug 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446997; cv=pass; b=ZeG1nUDVRu5CS/x+EI9DnPmVi8qwjSmkBhd7iPJEak8H++eaMnbxUz0Uk+5zgCyDegtGhp8m+uVSQNXOtYv2FlP2hYa8LtU+xaM1TsuRp2THvZTMecppEh5/NsngrHJbvTyBqPaVzTbueBaCMUTKAfdW1heV4PCHHEV5IG6D3c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446997; c=relaxed/simple;
	bh=fjqdlchKoZQp8z6BOQfPzPE/Kn3at+oXweNS0d0qYd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDaBMVWBRLIXSPvD3z+1gXExD3HjLmMK3kvlZ3Hfhuuk285s7otviymqWRe1Ojkd9+4blQuJFeBLI3gPbzXeANwDIKnM6h3fo2hBp1lFgRS7NVuweeKCYmqFLKah1ZsFhUlmX6LrGX+TAV3t4BjIsWAEHVd5YkGhWjDmycKVLZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=XCpqFCqx; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3AA5D2C5FF4;
	Sun, 17 Aug 2025 16:04:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a266.dreamhost.com (trex-blue-2.trex.outbound.svc.cluster.local [100.96.24.204])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A9D5C2C5BC0;
	Sun, 17 Aug 2025 16:04:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755446678; a=rsa-sha256;
	cv=none;
	b=79eaCdimCdxb/iC5hvvHQ0HNM1n+D3OOB0TRZHB7IooDoHyGsXYPyHmQgzKJ92/kSbWxoF
	ZDD4pdXgyLyx/0J1zojJgIiP2Xhi0TJnpZYh12QO68Df5EbVMp3rvxKGA1gdi+V8zc2iHC
	0KUJfztwk0KiGkbDl5DnbMyb9mdnncU2HD5cMu2fQVHk5p03MtyIWM4vkdlpgcBu0YnC0d
	FNZ5S5cyuFvhHZy99dPLCpP8eJZNU6A2gqAimu45PsRit+cJsEdsPmI+1Nl55/M7mpmKN4
	l0UHKiM6jAG+KWhePC6KnK9VGWAr3GxHE+HEu2tIjK9cshMaHlJxmKQazWZ9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755446678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1UyeYL1cdUfgr+ZEGrn8RJmbevR9bD7UF50xpYXVxks=;
	b=j9uqFpwWW/V8LMvtx445Rjvn3UEe/k3YyuJm8IJeS4RfFPG7ydSgVr3qTMLzQLGiLpUg8R
	wLYdC3ckaH3bDP2SkyWoq9y26eRo80cPxkxGWGu+PigkBFcagNWD+gzuM5KDp4cAcJsdcw
	2Lx4ugPCjC2/Gg5oM+cdQkqwceh0CvYxFb3Nm5cRf0S1SmxD492H2gvG7wGFxPSvr2Z+D5
	5ZDFu1b2alrxc5TmHHq/yvyCuVPbDED8lXPa4INYBnSbFzTr/xWHkExYXidiV77RkmIOSa
	vkodUcMM5U2crkPBYfVrtda8N9Fc/JkG1+MtJgNdV9mfkTRZxz2SWj7P5IsgLQ==
ARC-Authentication-Results: i=1;
	rspamd-697fb8bd44-8sr7s;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Cooing: 5f6ae9f50f5cf92c_1755446679101_4172374461
X-MC-Loop-Signature: 1755446679101:843244194
X-MC-Ingress-Time: 1755446679101
Received: from pdx1-sub0-mail-a266.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.24.204 (trex/7.1.3);
	Sun, 17 Aug 2025 16:04:39 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a266.dreamhost.com (Postfix) with ESMTPSA id 4c4gdx2LB3zPS;
	Sun, 17 Aug 2025 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1755446678;
	bh=1UyeYL1cdUfgr+ZEGrn8RJmbevR9bD7UF50xpYXVxks=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=XCpqFCqxcvJJTfy4OTrCUM2Htgr/7IGFok1cVjmYKXOMi1wiqwODNwADQ13rSCESQ
	 KvqhFDCGeL+c039xlvVPaEcg6pRW0U4Y5wlSwIGq+6ZZO9FnVlwH4jmDkE+GvxBd+Q
	 cmCzGOP+NY0jTdG7uM10/iobTMZaE3C1OY2yWhYP1aWuhpU2Hy+j2RUgOqiXWsc+cK
	 uGFI1ZxQM6lqbyvm4sEEgMtR2pU2EJGCiDKn3fbeBQ9UhLeImL9yWGx4t/j5xeMDxM
	 2v3xSGhAaOC8JJefzQUEaQbjpMiNxrJLR4clZ+cKLRIReShruLL1R8oarPXUKd/vNA
	 SBmtoP9N2gv8A==
Message-ID: <dd48568e-90db-430a-b910-623c7aaf566e@landley.net>
Date: Sun, 17 Aug 2025 11:04:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
To: Andrew Lunn <andrew@lunn.ch>, Artur Rojek <contact@artur-rojek.eu>
Cc: Jeff Dionne <jeff@coresemi.io>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 17:38, Andrew Lunn wrote:
>>>> What support is there for MDIO? Normally the MAC driver would not be
>>>> setting the carrier status, phylink or phylib would do that.
>>>
>>>  From what I can tell, none. This is a very simple FPGA RTL
>>> implementation of a MAC, and looking at the VHDL, I don't see any MDIO
>>> registers.
>>
>>> Moreover, the MDIO pin on the PHY IC on my dev board also
>>> appears unconnected.
>>
>> I spoke too soon on that one. It appears to be connected through a trace
>> that goes under the IC. Nevertheless, I don't think MDIO support is in
>> the IP core design.
> 
> MDIO is actually two pins. MDC and MDIO.

I asked Jeff and he pointed me at 
https://github.com/j-core/jcore-soc/blob/master/targets/boards/turtle_1v1/pad_ring.vhd#L732 
and 
https://github.com/j-core/jcore-soc/blob/master/targets/pins/turtle_1v0.pins 
and said those two pins are "wired to zero".

He also said: "It would only take a few hrs to add MDIO." but there 
basically hasn't been a use case yet.

> It might be there is a second IP core which implements MDIO. There is
> no reason it needs to be tightly integrated into the MAC. But it does
> make the MAC driver slightly more complex. You then need a Linux MDIO
> bus driver for it, and the DT for the MAC would include a phy-handle
> property pointing to the PHY on the MDIO bus.
> 
> Is there an Ethernet PHY on your board?

According to 
https://github.com/j-core/jcore-jx/blob/master/schematic.pdf it's a 
https://www.micros.com.pl/mediaserver/info-uiip101a.pdf

> 	Andrew

Rob

