Return-Path: <netdev+bounces-250070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55FD23A93
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D695B3193698
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C535CBDD;
	Thu, 15 Jan 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnO268iR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEEGN+sZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DFA35EDA2
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469864; cv=none; b=IfyW2ukq1ePvmB+84cupU6b960HBI8t+XCB2zqsF/JZXhTWLRpyUFcp3hxvhA1GwsBZjgz3D+2G9lZPboRk4e4Xgr5i/JthNcLqw718dXOKCGpGEGMDizJ0/DpEVK2hkoWQDb1yjFX0lag5Qx+ssXubjwbOs2lC3xbd1aHqVpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469864; c=relaxed/simple;
	bh=OvixmhxKp77Kx6QGMyWPAcEWNA77oY+wK7kwCqKoO1A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DzGufkHRYlCh9VZHGRpYUAJGMXMdoR1pg0svNAi9CFTRu0TBmUn//9CABzRBuE3E5nHEjcTdiwAUbxKZnqe/AuwHSO6KfPyLP9te4a177k3vMe0qAieWBX1/xgrPiDLBuYgOkeKsLBRgEskjZVhOHkHF6p1N6rhYsdIpChSYsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnO268iR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEEGN+sZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768469862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbyX5I3XmcBb65h/6RUQRH0oiD3GDHhpS2uLRUVlL/Y=;
	b=fnO268iR/azZJBVNEmhaUawQeJBs1pjQ2MRfJA4M+FqaZ71f42i7I6DDKaAU74HtE0HBBB
	79b9RwAgsR59Oef6GaFQpgepommym1kIcw3rXH3Nq560U4I9xxgJOLp0eO8vcgJw+4SK8l
	FmXIKJABlWX2CrQwMZp7ST09rS9N1wU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-GorUeStFNTCtsiyxcB8rrg-1; Thu, 15 Jan 2026 04:37:38 -0500
X-MC-Unique: GorUeStFNTCtsiyxcB8rrg-1
X-Mimecast-MFC-AGG-ID: GorUeStFNTCtsiyxcB8rrg_1768469856
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edfdc6c1aso5207975e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768469856; x=1769074656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HbyX5I3XmcBb65h/6RUQRH0oiD3GDHhpS2uLRUVlL/Y=;
        b=OEEGN+sZdwY8G1bMuu+HHHQiqGb6QakLkJd4IGFmS0QZl2JmkCNY908XJ37anf0jan
         oGSzsSb4AbfRDi3T8/NspnCOLuIE0aGOh/gOEqOcSgsbZzNt5aOGw7zHHMN5amh1ywL2
         AEjiHWq40hRe9mjbOMqzRZ4yw6jk3Ma2x2YkZ5TPyoH1HSGZ8PMRaO1dHHGynqDILJsM
         eFUGlKwUK+179rDHEQGifOij1F6Eb/BVRBS5sYAMPlAhkX0kQkUotsaOZ6SwCY2XeWPm
         qVAAcveyEPUshcdHLxEmP/2lsHv8YsA4fPds9IF3OGUYn2nuXR2axukfGRnXpOQHAkOh
         V52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469856; x=1769074656;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbyX5I3XmcBb65h/6RUQRH0oiD3GDHhpS2uLRUVlL/Y=;
        b=URX9+mgeQfSk1aVzgSNgNkjWYgVwbqyYoWU25ehX+4IX9e49mDNGOS+Z+0sM83Usfi
         CVyGv8YTWEHG1MCO8Rlxu7JWhrRcvAUzFSmeZJlH6AVhIiAXlEhGnYzsnfOK3Y0lgRIe
         gNc2fmeTboPHXPsJqTkMCByfxVqPJroC+pFSGZ3t4hPa/bIItLzQ0XR2F+jE+TgRNnOI
         WMmZAkGvhHlK6UBP9dzFWAgn6S592urr6h/JCq59CJgKhKMS98QuziqKExF2M2mVlz19
         UMVPWx/7Xf03ZInlO30F7BWBPVrTZvtK0ajV8hc7u2v0gEOvi0n4GBEqsd4Los0Cbigw
         JGIw==
X-Forwarded-Encrypted: i=1; AJvYcCXlE1adCerVP5KyIT2Dn6cNnYyjDyWdkerOhO06R315tU+0HNzAiZYPG82mDtZkMoRtDRRVNP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5W0nmO68VZi9EunSo/4nQMGxpLtzvFINSKqsDXeL/rm4IjJC
	f20xDBnfnblsKjo6qUXS46h/jfSMDiIRfKiAnpoTqSIZHYYqtGKVHPU8WJWDSf3JJAL7vmsGjLC
	1WqNp64rgVon1D74a9V9zooVKY5+geY/jdJmOa8rq6vGpn3CLSpE/yhgIsg==
X-Gm-Gg: AY/fxX4o3svPPsrhXtM5kFIzYbZjtmp7u1fct3eJ8MQ1JqsfX4DRi+OsZKjrnh7qfHv
	pD8rTMvNcYItFwCbUzrd3TF9sEKike+4jQDDxav8Z+J3yRoD2SymLTEtvqYO/QNuPAPt5NdxTWt
	7us/idbVYnxqEkCOwOg2M7B45p0hjiP6VFG6x3YuuBRBJHkcx43aePOuVmmPFAKuoME3oEvQD0/
	H1jA81Vnq6Ix/eIgqRCkTht6ToA+J/YaKtPpBaoiuasVHfRN6cOnKHbZ5OZQJpS1/evZUg5gsCR
	58NVqWBDLVzb8050NLMOvg6cBs5KxuOHocVdPODNkflSy8iCG5dFHgO4YzEogP+Eu2S/2l4dapF
	mvnMEcVkvG7tdZA==
X-Received: by 2002:a05:600c:34c3:b0:480:1a3a:5ce6 with SMTP id 5b1f17b1804b1-4801a3a5f92mr13914295e9.14.1768469855747;
        Thu, 15 Jan 2026 01:37:35 -0800 (PST)
X-Received: by 2002:a05:600c:34c3:b0:480:1a3a:5ce6 with SMTP id 5b1f17b1804b1-4801a3a5f92mr13913865e9.14.1768469855311;
        Thu, 15 Jan 2026 01:37:35 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428af0c7sm37233455e9.4.2026.01.15.01.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 01:37:34 -0800 (PST)
Message-ID: <173d1032-386c-4188-933c-ca91ce36468f@redhat.com>
Date: Thu, 15 Jan 2026 10:37:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eric Woudstra <ericwouds@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Lee Jones <lee@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Vinod Koul <vkoul@kernel.org>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com>
 <87o6n04b84.fsf@miraculix.mork.no> <20260111141549.xtl5bpjtru6rv6ys@skbuf>
 <aWeV1CEaEMvImS-9@vaman> <33ff22b4-ead6-4703-8ded-1be5b5d0ead0@redhat.com>
Content-Language: en-US
In-Reply-To: <33ff22b4-ead6-4703-8ded-1be5b5d0ead0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/15/26 10:34 AM, Paolo Abeni wrote:
> On 1/14/26 2:10 PM, Vinod Koul wrote:
>> On 11-01-26, 16:15, Vladimir Oltean wrote:
>>> On Sun, Jan 11, 2026 at 12:53:15PM +0100, Bjørn Mork wrote:
>>>> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
>>>>
>>>>> Add helpers in the generic PHY folder which can be used using 'select
>>>>> GENERIC_PHY_COMMON_PROPS' from Kconfig
>>>>
>>>> The code looks good to me now.
>>>>
>>>> But renaming stuff is hard. Leftover old config symbol in the commit
>>>> description here. Could be fixed up on merge, maybe?
>>>>
>>>>
>>>> Bjørn
>>>
>>> This is unfortunate. I'll let Vinot comment on the preferred approach,
>>> although I also wouldn't prefer resending to fix a minor commit message
>>> mistake. Thanks for spotting and for the review in general.
>>
>> Yes fixed that while applying
> 
> Could you please share a stable branch/tag, so that we can pull patches
> 1-5 into the net-next tree from there?

Vladimir, could you please re-post patches 1-5 after that Vinod shares
the above? So that we don't keep in PW the dangling (current) series.

Thanks,

Paolo


