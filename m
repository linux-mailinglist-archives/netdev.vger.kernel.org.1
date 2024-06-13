Return-Path: <netdev+bounces-103213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179289070F3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB91C22937
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB9B1EB26;
	Thu, 13 Jun 2024 12:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C538389;
	Thu, 13 Jun 2024 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281938; cv=none; b=kbjXuar2DZlIKnPteLS4J9tm9VBe4YZ8K9sHFi/O+chjMgE9xxwhkJ0Dv85qTT/sKd4Y84M7moYnUwHwlelRI8iulJImC2kgaatQReOEvMh/MS9yw7GxuurzUVsU7uzwari2JEivu4uuvZZiqlKAzWD8jR/YRLpuZ7ZRmdZnLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281938; c=relaxed/simple;
	bh=av2MyV6dZ4ftkxMdjqTuLR0VQcHiGEhTe8qOtSbJrZw=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=nkcYKH2RUNGgjLl3E6BIW8TA9fxP1Oo/keU1i5kpo4zEr+KGNE0PCj6OM6VcpBVo5MAHT9LZDEIDJiUB1QQ/h2Xri3PjsNJr0sgiIL/NXKjT9KyV/4dfJUKRQT1/rq1sc5T2INqDZCRxHGuZuyOI88c5mD57iSSlw6dSaXytm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=99085fba10=ms@dev.tdt.de>)
	id 1sHjcj-000Vdz-AG; Thu, 13 Jun 2024 14:32:13 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHjci-0021Od-Nq; Thu, 13 Jun 2024 14:32:12 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 707FE240053;
	Thu, 13 Jun 2024 14:32:12 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 05615240050;
	Thu, 13 Jun 2024 14:32:12 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 7D7A13852A;
	Thu, 13 Jun 2024 14:32:11 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jun 2024 14:32:11 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/12] net: dsa: lantiq_gswip: Only allow
 phy-mode = "internal" on the CPU port
Organization: TDT AG
In-Reply-To: <20240613115025.2ogzag4p3gp7xf6n@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-3-ms@dev.tdt.de>
 <20240613115025.2ogzag4p3gp7xf6n@skbuf>
Message-ID: <8ba7dfe8f64c060c4a980261064794da@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718281933-1FCDB522-43926268/0/0

On 2024-06-13 13:50, Vladimir Oltean wrote:
> On Tue, Jun 11, 2024 at 03:54:24PM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Add the CPU port to gswip_xrx200_phylink_get_caps() and
>> gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal 
>> bus,
>> so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
> 
> Similar thing with the sign off here, and there are a few other patches
> on which I'm not going to comment on individually.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>

