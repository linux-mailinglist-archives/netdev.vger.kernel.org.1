Return-Path: <netdev+bounces-212586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39811B214F7
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A75B1A23428
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276612E2DED;
	Mon, 11 Aug 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u136D40H"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE62E2DD2
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938420; cv=none; b=tHctJMfRxJxJkIf4H+BegJSrhkWSxOByJ/nrF7A8+GxibIzbk/h904ZwPdK2FqW0g3ebXbhhTuIUjaH6WPkpq2BoG+eluh5cKFYzksqoUJ0LmAcKVuvDAZ8gWdpQjd7WRrzB+3B6RfHnGQHa3GPIsfCft34XZ1y+iFYngp7akWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938420; c=relaxed/simple;
	bh=ACaCCx/zYEw6greU3vAV3sCC6jE2zat1KZSmI+K260U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gD0RhdUa37Uhi/Xjp75pw4vkPJNJK4ZBPiJEKvqD3k925ftUpmf1OB/2uNIQ1H1QS03VPLW/6s0NsvuMOsL0K0TIAjUvlVXzhJ1Lc6jLPp9+VsshBVSz7qZMe2+Xgfy/cDuTAXxbd6I3dhIi53rnJfxFwfHyq12LhSSpAcP2U+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u136D40H; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d4bead1c-697a-46d8-ba9c-64292fccb19f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754938405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0R2bnIhPyR3QQbpGsQ2ZiExRLQ4FHglk5+SDpIvYRfw=;
	b=u136D40HAZRm2Ns4PIkj7lNjk9GpEzIDA0c6PL4vfZunBpXOL+T8bK9eSHezE+/ErbtzoA
	LFQBQRUjQbRcJ1FXpHpS4eMH3GHZTlm1PKk0cvRkbUEl1ubAtZ3EEn0ylwCcFNanSmEGhi
	3Gh+X8fqy4yk5tSREu0rhyEpC/kmjMI=
Date: Mon, 11 Aug 2025 14:53:19 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 12/18] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Harini Katakam <harini.katakam@xilinx.com>,
 Rafal Ozieblo <rafalo@cadence.com>,
 Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mips@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20250627-macb-v2-0-ff8207d0bb77@bootlin.com>
 <20250627-macb-v2-12-ff8207d0bb77@bootlin.com>
 <1a4fe95a-f029-43b2-aed1-594365254b6a@linux.dev>
 <DBWASGS8U4LN.1GMHL8A61VWU8@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <DBWASGS8U4LN.1GMHL8A61VWU8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/7/25 11:24, Théo Lebrun wrote:
> On Tue Jul 1, 2025 at 6:40 PM CEST, Sean Anderson wrote:
>> On 6/27/25 05:08, Théo Lebrun wrote:
>>> If HW is RSC capable, it cannot add dummy bytes at the start of IP
>>
>> Receive-side coalescing? Can you add a brief description of this
>> feature to your commit message?
> 
> Yes that is Receive Side Coalescing. Clearly it needs to be mentioned
> out loud, and briefly described.
> 
>>> packets. Alignment (ie number of dummy bytes) is configured using the
>>> RBOF field inside the NCFGR register.
>>> 
>>> On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
>>> be done if those dummy bytes are added by the hardware; notice the
>>> skb_reserve() is done AFTER writing the address to the device.
>>> 
>>> We cannot do the skb_reserve() call BEFORE writing the address because
>>> the address field ignores the low 2/3 bits. Conclusion: in some cases,
>>> we risk not being able to respect the NET_IP_ALIGN value (which is
>>> picked based on unaligned CPU access performance).
>>> 
>>> Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
>>
>> Do any existing MACBs support RSC? Is this a fix? 
> 
> I have no idea. If any MACB supports RSC, it must be those running with
> NET_IP_ALIGN=0, so arm64/powerpc/x86.
> 
> Is it a fix? We can guess that all boards fall in either category:
>  - Don't support RSC (=> RBOF works fine).
>  - Support RSC (=> RBOF not working) AND NET_IP_ALIGN=0.
> 
> Both of those are not impacted, so we technically don't fix anything for
> current users.

OK, then please drop the fixes tag then.

--Sean


