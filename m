Return-Path: <netdev+bounces-227443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F1BAF849
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 09:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B87A3E73
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A3279351;
	Wed,  1 Oct 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9IbUTfL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E2277C9F
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305548; cv=none; b=FDj6NF3W3X0uxVLexLQH0ZEBRf9+dkxnFLgdpmP7xecE7gOgIENf5zM7X2+wASiGAJCgLLgIVzmNUsh3rdJjb0Au583GP2BSbQvDsNW1UJSP+7a+QGAz10UustqvTxY/3Gstlx8+94yRAonLwsw53iABqylTd+yCHKyh2UMGyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305548; c=relaxed/simple;
	bh=32+dcV5KCnlxSs5GB9v7s7dAz1V61Qe0s4V0xusvslI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxQ/3RKBjeqc+3ERN3ia5CJYnwtDg+iWAaqWy6QsXHfbNPN91HOVCV7v4nqm0t/qx85sgNjDFy4+qWElWXefQI3LTEWXPFGY4TOOtU5oaLjJ7EZQf+TKiPt+7ZieOymfbaVcj+tubLUvLfnsrWWazTGgirphXxkns7zBshEJAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9IbUTfL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759305545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JRYgwl0T5IpgOuDkp0yF08iEAoUfTslJUqiB0DRs8I=;
	b=R9IbUTfL4xB9I5KgqSokOYTFzqZkaN5sYyaMftBvHjTnU96zRg6u4IPMTBnoTY5v2fvMEd
	sLM1V5w/nne1MfqdhX9mpvJL8yAq+FsygD2kK5QmAq9T8ffG91pu3VNX9Fg70CiHGCTcXJ
	FUU50YJ/feDoA+ttAoAFmfo/nnCwMUE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-3yRv19ANPSm3jO_Sc7i_iQ-1; Wed, 01 Oct 2025 03:59:04 -0400
X-MC-Unique: 3yRv19ANPSm3jO_Sc7i_iQ-1
X-Mimecast-MFC-AGG-ID: 3yRv19ANPSm3jO_Sc7i_iQ_1759305543
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42558f501adso145701f8f.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 00:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759305543; x=1759910343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JRYgwl0T5IpgOuDkp0yF08iEAoUfTslJUqiB0DRs8I=;
        b=IXFS14t69g2zNtXF/qc5xKdbNWowcLmXix/X1YlReAIenv08LyNMO+/kuGgz1YTnb9
         bt1AjILxUC+8J4+ANgi6mKaT/PkPH4CEpB6S3/93xkwqJRaoCXhsz2oeQ9lAniB1V3/h
         JLQwVoCRszraxenohkCI5HoMDxBBhR1qq6mFDWovpacaXqv8FsIrrqH4DaXNrmOPSFFQ
         fqHsIrLP/07MmZBHzdwDuQqItvP0Fy4ie/IgruKoC1qOPordbN9JzZH81tq6xscQH/87
         LJ5KAFCdLW3Pwpk6KX9bEIguniP/HgADba/l9fZ49TkDOhT/L/LNg44eRE6C6sbb9BOc
         p9nA==
X-Forwarded-Encrypted: i=1; AJvYcCUtt9RZDjwRAiPKE2wnbglMpwtBMI0qRRz7AUmpeTu2+QgRYXr8s3SZfHJYXDSKOi2ztYkil0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmqNZc7JdiLg1GtB5M7d5ZbMK/6IP/PEl6KnTIJSrJkqGW8L3
	fv0YFynW7xE7m+/xgoTwL5wCoSHr4iyrszqmMX3peKwIlq3M/NEl0mojRtVpaUZMK8TaZJS5h9G
	Z9R5e9fyiOmg4ZzrgjcKCRqR5iwwv4yY0TQyqa630Xd3fj4ySsbJqM5mk0A==
X-Gm-Gg: ASbGnctqZ8deCIXD42sLPa2fIwYNVXpnq3CefehSnD6Ixx1oSFxC6vXMITSzZcrhL5y
	HFn6Hvk6hEzDHb3+O37nseuYkHdrFIRXCIahZYRhh6adheeu85ZwbrTS/JGFughPNygDr9N4u7y
	5/ItaZzBZl3cbXU94Fzoy4+BU3tAjufw9rN4Sn9SW8W936ET7U5Yc152hNmbnwC0cwvT50JUrmi
	3YOFMoDPGHdYFuJs3+WsWk7Zfrmga6UHfIuaQFR5Ke+YVh18XkuEAwZNGdJIyuiXaFW0K+T7jNn
	L5omx6o6M5SE+jF02bCwPqXHHWeRMNbq921NYGpmj2GEyt6tmiVGGVGuOln1qc3x5lBgFw9LGqS
	f8104nA5GVh8XXiPFZw==
X-Received: by 2002:a5d:5f55:0:b0:424:2275:63c2 with SMTP id ffacd0b85a97d-42557816e2fmr1739104f8f.33.1759305542734;
        Wed, 01 Oct 2025 00:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmThKjj9QWZgUZye0EGBRbRcpzbrXizq8/t5RuSNwiL8WkyRG5/i9RJlh4f2Y+zEs9wXkX5Q==
X-Received: by 2002:a5d:5f55:0:b0:424:2275:63c2 with SMTP id ffacd0b85a97d-42557816e2fmr1739074f8f.33.1759305542103;
        Wed, 01 Oct 2025 00:59:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619a6fc8sm26932675e9.13.2025.10.01.00.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:59:01 -0700 (PDT)
Message-ID: <a1f2c541-01c3-4c02-9caa-d061b1ec81f3@redhat.com>
Date: Wed, 1 Oct 2025 09:58:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20250925191600.3306595-1-wens@kernel.org>
 <20250925191600.3306595-3-wens@kernel.org>
 <20250929180804.3bd18dd9@kernel.org> <20250930172022.3a6dd03e@kernel.org>
 <d5aaff54-04dd-4631-847c-a2e9bd5ad038@redhat.com>
 <aNzc17ZW56gLX87v@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aNzc17ZW56gLX87v@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 9:48 AM, Russell King (Oracle) wrote:
> On Wed, Oct 01, 2025 at 09:25:07AM +0200, Paolo Abeni wrote:
>> On 10/1/25 2:20 AM, Jakub Kicinski wrote:
>>> On Mon, 29 Sep 2025 18:08:04 -0700 Jakub Kicinski wrote:
>>>> On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
>>>>> The Allwinner A523 SoC family has a second Ethernet controller, called
>>>>> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
>>>>> numbering. This controller, according to BSP sources, is fully
>>>>> compatible with a slightly newer version of the Synopsys DWMAC core.
>>>>> The glue layer around the controller is the same as found around older
>>>>> DWMAC cores on Allwinner SoCs. The only slight difference is that since
>>>>> this is the second controller on the SoC, the register for the clock
>>>>> delay controls is at a different offset. Last, the integration includes
>>>>> a dedicated clock gate for the memory bus and the whole thing is put in
>>>>> a separately controllable power domain.  
>>>>
>>>> Hi Andrew, does this look good ?
>>>>
>>>> thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.org
>>>
>>> Adding Heiner and Russell, in case Andrew is AFK.
>>>
>>> We need an ack from PHY maintainers, the patch seems to be setting
>>> delays regardless of the exact RMII mode. I don't know these things..
>>
>> The net-next PR is upon us, let's defer even this series to the next cycle.
> 
> Would've been nice to have been given the opportunity to respond to
> Jakub's email before that decision was made. Not all of us are in
> the US timezone. (Jakub's email came in gone 1am my time.)

I'm sorry, the time constraint is very strict. The PR is already in
late. My message's goal was to give you the needed and deserve time for
reviewing the series, not to pressure you.

Note that to merge the series at this point I need to undo some of the
work already done.

Cheers,

Paolo



