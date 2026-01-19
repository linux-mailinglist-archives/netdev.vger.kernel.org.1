Return-Path: <netdev+bounces-251320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958DD3BA4C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE2D3046396
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB52DB78A;
	Mon, 19 Jan 2026 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC52HIsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D2265CA6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768859904; cv=none; b=PWRYAKq1UaCsy+eRUic+fwyYd+RqHYfrT9/V9zAJiQz8o3yLCgz5WpnI8VkNh5be6E2u7X9Xq2o1D90jEI/wqxURo2Bsk7uc5ebq7Sr9z9wMEhOIZiet9uYL8S7acFNb2QW/MS/qov1BiCJN9i9zlhIxOVPrJPP9496GwLa6JTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768859904; c=relaxed/simple;
	bh=kqcllbyonJLK3WbgixPxCzp5vjouwvuQy44HXKV/Ga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmg1lQ9xDZIsPkwZEV1bHnXO/UBSYQ3KLF2H20kR9kbvkyFeAnNWWR07Aqolfdf0uk4CjjWPvf6f5JEvb5qB7HoS+ES8Z+U7FBvnYC5/kF3RWOOxfw8/IRQJyw2aXNfJ05lNaDvJGpZ9CDy0UvhihNhKlufHChh57RSA5Jv4R5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC52HIsu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c632109so2080145e9.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768859901; x=1769464701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILOg9KzJhrQcKcjPs7nzqFFzLsLXRafQWNo9YSO0V+4=;
        b=lC52HIsu0ZkWDkfvR5xQ+TYLpY0THs3jYWogmb5VesWBQTDWHTCT0OoJpYNJkc3r/x
         yEUl1Cema2kFEaq1g34ZWcGBflZJ6YkqLyE6ro74JpgERiygoekiuIe5OeJbc3bXmXGZ
         cZ28iIUtYIVNQqCVgZ1TXYpu+FBKEzc+aG0bPMeuC6eaBraMYWlczsVAncn/W36O9KMQ
         cbZYavCSjXO8iQKkdxemJFDWmcEMDghg2u3elu+IWN/zT6XLPpJVz2IFpKhJblB4x9Ts
         b1b5k1W3nMhVElmtCuQSCTsKSlqNZWfEiGT4yV5oygkqVrdZicBWIapw4QFXEAfwXPIr
         1s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768859901; x=1769464701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILOg9KzJhrQcKcjPs7nzqFFzLsLXRafQWNo9YSO0V+4=;
        b=loMg+0Ij3xDVN75ArY9CZWcBP74YdpniicR4orL1l5NDP9JGXw3RphmXw600zK09VK
         oUMGHGXZHgFg0XdS69iAclAX+JtZcTyIs0IXg9hcdDAjDr0TEYYu0Jp/5xuIhk8sOENE
         wTCSarn2Vbe3l1yKPtLmS5y07+qDiks7BjKIpizpiwSq0Y2MOXnzpf969jBtUtNx/IQK
         umgFC823gimBHFu1gIT9NNZx2gs8BdqRrpdpM1liFzzigFpnUReLkUfMj1+rC/xvEEDt
         zTvmfS4efdHbpjYuIcD85kIbSwOt7ldUaDAVmkmBq53BU/LjKaA76BZ4P+ZJlswMGVdp
         p7dw==
X-Forwarded-Encrypted: i=1; AJvYcCW4bapkEngG5tEs7XB9c0J6l6cvNZXHwSzYV/hdeNcsYyTNo8QorZgMa6ORcAmSYrOk00zbZfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsiEYBYRqKodx5y876ddNfimM3Z8LJZ/koa1pcma89gaVxcC8
	WnDdlIsmuHwwoFnHsy8z6Hjjx0VaMvnk1UAIFUAI5ngXNCHrLZDJH+3IXoekIw==
X-Gm-Gg: AY/fxX7EjPndeA/c34a/XXsEBDVqnVo+PAHhn+LEfZgRPOj812BqIDMKymUInNw4RkO
	ac6zbuz9q4L9323vGpgmbZo16vytL0RVCXFJD2OmGx+PJKD1aH8xrQHWeWc3T49eMUlhSt9S63e
	4pFl3fskteCk997DBk0ErKB28x050hngd0P5txVWQ+MAVpMomHHU4LhoEeSH4sEXlpVOFM+TxjZ
	iBpWqBrurBFQDeLpMfFJzfj/beCYMDhTU8waKYa5ZrkwGuyVQK3siEr7Pz0897n3cLfHac446rd
	BeT83Fp76kQ3XWr4ytjgopuDQhi6rieINbUNd+NBNvcIqP7xj28H3TP5ubhirBLLz1lxYEB6xsb
	E4mKt6p+42Xe4eMA1H2UPQSbFSuG2cUiVqPDnYb+R5XRudRDPExzOBGh7pD05xFHqi3PYBzr3Kc
	Era1k=
X-Received: by 2002:a05:600c:4e0f:b0:477:a16e:fec5 with SMTP id 5b1f17b1804b1-4801e2a50f1mr90625065e9.0.1768859901248;
        Mon, 19 Jan 2026 13:58:21 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:619a:24df:1726:f869])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm267568255e9.11.2026.01.19.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:58:20 -0800 (PST)
Date: Mon, 19 Jan 2026 23:58:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: dsa: ks8955: Delete KSZ8864 and
 KSZ8795 support
Message-ID: <20260119215818.qiaqdudcz32nk7f2@skbuf>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-2-98bd034a0d12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-ks8995-fixups-v2-2-98bd034a0d12@kernel.org>

On Mon, Jan 19, 2026 at 03:30:06PM +0100, Linus Walleij wrote:
> After studying the datasheets for a bit, I can conclude that
> the register maps for the two KSZ variants explicitly said to
> be supported by this driver are fully supported by the newer
> Micrel KSZ driver, including full VLAN support and a different
> custom tag than what the KS8995 is using.
> 
> Delete this support, users should be using the KSZ driver
> CONFIG_NET_DSA_MICROCHIP_KSZ_SPI and any new device trees should
> use:
> micrel,ksz8864 -> microchip,ksz8864
> micrel,ksz8795 -> microchip,ksz8795

So the binding changes you've done to Documentation/devicetree/bindings/net/micrel-ks8995.txt
in commit a0f29a07b654 ("dt-bindings: dsa: Rewrite Micrel KS8995 in schema")
were apparently backwards-compatible. But this isn't - you're offering
no forward path for existing device trees.

IMO, even if nobody cares about these compatible strings (given that the
"PHY" driver dates from 2016 and the KSZ DSA driver has supported these
chips since 2019), IMO it's pretty hard to sell a loss of hardware support
in a patch set targeted to 'net'.

Does it make more sense to retarget the patches to 'net-next', drop
the Fixes: tags and to somehow mark the driver as "experimental", to set
the expectations about the fact that it's still under development and
many things aren't how they should be?

> 
> Apparently Microchip acquired Micrel at some point and this
> created the confusion.
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/ks8995.c | 160 +++++++++--------------------------------------
>  1 file changed, 28 insertions(+), 132 deletions(-)

