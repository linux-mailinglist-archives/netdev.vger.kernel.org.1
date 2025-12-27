Return-Path: <netdev+bounces-246143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F50CDFF1E
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 010CD3004BB5
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD031A57B;
	Sat, 27 Dec 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWhrEfGd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D80BnxxX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0843314B66
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766852680; cv=none; b=FFqepyHr/hYiwxcGm6dCSmgoMIJq/+Y/Xkq/faFs3xsaUSYBOtN+cUHnumuqgoIVigtNq7GqbdVO1NRbrQShKLHSFwz4I7Uo4AnoX+oboGSoutF9jM7qYMC8XSai+rKuYjhr6MY0jq02CouMOVAVMEjP+hUdbay0xxL246zzI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766852680; c=relaxed/simple;
	bh=8YNXVPWR0u96ITfCMf9F3KyEcp7wyChe154P/vlG+F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjEZv8fxAbykWg3M2xKW7QZMLYn4CBASveZFT5sxvepPz1OcyFpUC8KC66SAn9awWqxY+nkqYQ43gDvNkGoeO4gv9AK0XQXi7IPm6S9UvhmSjpT2R3eh8J4Vk1ZbLa/jpA8xWvrV6ZPvKjSZlHJj1S3jiSU9VzHezYQE5bJ1J1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWhrEfGd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D80BnxxX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766852677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0pFoW0fxxbGtsoDZJaaxbA0XpDtBn2L+88OYPdKiVs=;
	b=OWhrEfGd1H9CdTW393YEzrPv3A+1KJPwFonNCTiHCd6cdBl+PU5WFybhreN4YuItUhxZB6
	xONU1XcX6pPj8VjngPByp5MZgwcf2TfJ2NgJYpi/bQTcN8xei2sUgmMppiletA6Qo/wj0G
	maX0U9ZOVK7Wdib8VMWAQot7G2ai3eU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ci30bnvUP1eQWk5eO2hlpg-1; Sat, 27 Dec 2025 11:24:36 -0500
X-MC-Unique: ci30bnvUP1eQWk5eO2hlpg-1
X-Mimecast-MFC-AGG-ID: ci30bnvUP1eQWk5eO2hlpg_1766852675
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477964c22e0so54897415e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766852675; x=1767457475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0pFoW0fxxbGtsoDZJaaxbA0XpDtBn2L+88OYPdKiVs=;
        b=D80BnxxXldZctW7uC96JpOjh/xRkxAeLTfUEvP+h6EtvmzokmhQGvRmt9D00JzVEzr
         hXHixkUAmhS6jubU0aj6D+478cDgK1FHq4oVMXu6znffdCVekwpQvXsyqQ+7fP0Au7mU
         HtLEUr3463N4hc6nGG5GlG+Qz/miskNhRdgUHuzX+q2A3a81dlPje4Lh7D+ksZvsVNFi
         u+gqTtSGT9TGioYqHTj0I8K3hBJgvB+EVnTj3kjvFJMcw4sqvQ3ZuDZy1bS2DlKA17/H
         QDLRw6HiKdc9eSBuKLaO8QDpuONXCImnx30EdReIBbdrD26wmKwT7h6ruqfFxkKa3tDR
         Yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766852675; x=1767457475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0pFoW0fxxbGtsoDZJaaxbA0XpDtBn2L+88OYPdKiVs=;
        b=hcdXDk0HRx8pz80U1x0/xzFdXPQS+ntHENqOqLDmVipvUICT3ImvWXbCFzDB/oBu/8
         dEsOhhvW/pS8sX8MIi0hUFbp4q28J0kKjL4zJ5wxr07/KMpK9GO3nu2pGJS9m4lBE4Vn
         X6PFSEKkymd32ooszEYLrtxe78vKkq94QpcD81DELuX55D8Wx0lsM41kkaT5PHkZWF0/
         ZhGQDwnVzZcteg5tuJiLe5J9y/AGB3yIBe2JFn7GQ9jg76Gyb3JYbA9xY4SuWAebwbsR
         3fw1zt3N1CoY1z1s8Y3XjraISndTJW/xeVaFkMxKOKCGI13P180YsW7XdXnaT5/xEZo3
         kVhQ==
X-Gm-Message-State: AOJu0YyFf27jVjUhWGIrEWqKzl627bzH2QW8HbKQXUL/ZHC7/FsZLMT0
	hE3dq1+hHvdnb40yIVtsdkUmRLZCUFrT69NAzJsMo1J2ODuflKPamrPn6PakHJzYXf5agxXblaD
	VBrT3K3UMPV+p656I3O9bWaf+1jFaGaCZL24kgRrRJn+Sg9Itu/rYGeSuEA==
X-Gm-Gg: AY/fxX6JyBXKnJJCZsQfC4glhGT+WaKrJ4SS4iTKrFwoaFBOy/ZRey+e0JASAqZpVk8
	gYpbpfFulHqIUJ7dvzUKI+itoHY0iEJc3BHFOxhlcjgGeW53xHxNSr5l72hgqbM7RxcsZxF1n0K
	hb7X000DolqijzEOguTFB8OnilQaG+pvPZ0v+AN08L1u+Xz9jitO5Xbse7kt8JWwz48N2rQX3m7
	5QEC8KkY98Aej+Kksi4yXNuMHvkvljJzrWfzVlgb+3K72tmoEfAfYMrMaoav65Z0msyWm8mXDzP
	WC84eUFm46uhKVO2fkUv6FMZOQYCpMEbOWYj+3gFOlt5AtSnlKG1qlWT5mhKLwz+ktQF6aXq0sd
	32BdnbLJq9QZSTw==
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d18be144fmr257527045e9.14.1766852675252;
        Sat, 27 Dec 2025 08:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+n6rR4mCRXdumkBNyVc/341HA3AYN1kUq6F6siD1Lcd+ziTKXrb+aL7jp1MXCilbI6b58Tg==
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d18be144fmr257526865e9.14.1766852674879;
        Sat, 27 Dec 2025 08:24:34 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be396c909sm194725735e9.0.2025.12.27.08.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 08:24:34 -0800 (PST)
Message-ID: <80be718c-3592-43bf-b3ab-8e1b9d3cf41a@redhat.com>
Date: Sat, 27 Dec 2025 17:24:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac: Add a fixup for the
 Micrel KSZ9131 PHY
To: Stefan Eichenberger <eichest@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-stm32@st-md-mailman.stormreply.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, robh@kernel.org,
 francesco.dolcini@toradex.com,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20251223101240.10634-1-eichest@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251223101240.10634-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 11:10 AM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add a fixup to the stmmac driver to keep the preamble before the SFD
> (Start Frame Delimiter) on the Micrel KSZ9131 PHY when the driver is
> used on an NXP i.MX8MP SoC.
> 
> This allows to workaround errata ERR050694 of the NXP i.MX8MP that
> states:
> ENET_QOS: MAC incorrectly discards the received packets when Preamble
> Byte does not precede SFD or SMD.
> 
> The bit which disables this feature is not documented in the datasheet
> from Micrel, but has been found by NXP and Micrel following this
> discussion:
> https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032
> 
> It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
> 10MBit. Without bit 2 being set in the remote loopback register, no
> packets are received. With the bit set, reception works fine.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


