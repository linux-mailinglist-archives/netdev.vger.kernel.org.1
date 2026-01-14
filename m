Return-Path: <netdev+bounces-249795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32AD1E2AD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDD173095AA1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5B38FF09;
	Wed, 14 Jan 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffPbo/CT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA838A2BA
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387162; cv=none; b=VeRY333CAfjNrrxnF5Nyaw5prs7xeTaIOhXl/nohF4EbblN9tDvmKFcBeDHvSjSVGe6zsKBKsTPWairm0AfrNRaoYJxsxv02z3hD2Zl0qFzuKAzXDOFJFBu5RxmA3QzT7b93UkvSKq2CyDH3cYNRqtUTZGKlzZXsz+EIjFOOrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387162; c=relaxed/simple;
	bh=NeZGER3lKepKkGnq50QW7TBSgU+zWJs6ARL5d7H5b24=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR9kuj/CIzUq8K/u5JyjC278DepjRHGAWCMl5mu1SY5BLCwMZHNydvb2EwXyZ8u6dzo5g8JspbBsx9wMqK3+npKNUnln8KsBZsPjwoymcycqdVi4zml6AUbS7mzYYFWZbWkMmH7iq9uV9Wa80CahLA0F0v0NKRqsOWx3/Vgh33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffPbo/CT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4597061f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768387159; x=1768991959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cVbatpxpKElt1sAAsNQJxq68ajK6K9op7sSsIg3JJAA=;
        b=ffPbo/CT89uspMudxd1ltajyIUncsP3uszbSqL/fopNVdwppHdY0WazXN+bu3fimM0
         +ums/CHItdYy/UPClMHotLh/uKuuQDwH9HJ9aDljY6ooQpLxXY3ueuLEgCNGzafUYztR
         yTK1QLfI1zJWFdM1ApRB/UO8cQklyN7JRPlNYBXJipF3SpQvt4D1C0eM9Pqa9hcmW5p+
         0K/jiz6Vxp/NfgH13rKRUHBZ/itajkbXRvVAofsSfZau/JsrE71HFCdCP2Ytj5UEZgwp
         OzIHLvNigCNw9ojOT9Ock1YxORV6Q8lIqhtuC/3ynFvje9PCLaAAhPW4brp1lsrKlhHK
         5K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768387159; x=1768991959;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVbatpxpKElt1sAAsNQJxq68ajK6K9op7sSsIg3JJAA=;
        b=cM7fFUEXqfqQTJ/3s94M0nrQbD4YXI5yYoZUQU7bijRW7AQRhkf5CmCsO1Q1GLsrey
         YYHT49BiT7/Rn+XqSkjoZwk2VjPtl1NsDTkNCU0asYX3hBKBEH0cjMoWdh9B380RuT09
         IIVt0ezPvHSukMI8oDUCYdwySzMwdKOFujYPsDJLgAGXZPz4skNgQzTS9m3dJCpf+/qx
         uRcu+As22B4vR9vyiWVXCWyaurnOlgjPowt+2PLJ/RAHnt9qn4tXj43lFh8Au6IvhE6F
         dJQw34Z3PRaF/oUnEJhVx2T6RyyQVH8LrL4b5FnBV9DkB51PIke8FhNDGzSkL0b/gEa7
         RJmA==
X-Forwarded-Encrypted: i=1; AJvYcCXSFgfZqhB/eJrcIYvL/VSA4rbMoqEEmxgWgqc7Lq6B5wRC0eRnSjwagYndG9+XkaL7dRxPs6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJbzUseVWRsDUonqzHrYcHbTXQPtNMpWtY4tMyIjR4lmkODWB
	ZZNtdzGFShQG/dQ6heWg4bCS5Ja6KyPqQGGVhHgoCeIF6Lb16eaNcUJl
X-Gm-Gg: AY/fxX4C3RNMlDrsIh7iLsdBADd1ELITGQrbwozU2UZdzF4AUvkxdU6S//dLc8bGaE/
	yvHBq/BOJ45uU5I//ttaKm/WZNzwkMZYqs3FvlVANBApaqfi1+HVrHFC5b0bju8ADnxxKN/q9Px
	ptJJPv9Rw7E8F2E3v+oJ4m7lzefj3531gBWhsLpm3+sm/kxgzgg4qLeTZaT+i1uFUxF4kL31qhS
	xxigTdkHENvX6GZNPO70bOuXhAlAv2+CE2xZnhHYSn9OlGN3lOfn7QQeAS2TXFxRNJYBdTDJDV6
	Y4/uLCcn4bnp8PZvyfiSx2QtJOckfNynzyieGcrk5I2s4NrGMQsR7exfEs2h9GAquWsgQGRSA2K
	E88+WArQ8/EerECis4tniylcwVbMxFsgfzlCJ8pv+qERjRmrYidHGl/l4ZiXaecXLqKwxYzTBdj
	UZuA0rs13WXEFf2wyzbWMkEYamo2RcLVk4QtZJjazicQtMRkCCqw==
X-Received: by 2002:a5d:5d89:0:b0:42b:4267:83e9 with SMTP id ffacd0b85a97d-4342c4f4cdemr1980366f8f.2.1768387159401;
        Wed, 14 Jan 2026 02:39:19 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm49038091f8f.21.2026.01.14.02.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:39:18 -0800 (PST)
Message-ID: <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
X-Google-Original-Message-ID: <aWdyUuN3TnelxAh9@Ansuel-XPS.>
Date: Wed, 14 Jan 2026 11:39:14 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
 <20260114-heretic-optimal-seahorse-bb094d@quoll>
 <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>

On Wed, Jan 14, 2026 at 11:34:55AM +0100, Krzysztof Kozlowski wrote:
> On 14/01/2026 11:09, Christian Marangi wrote:
> > On Wed, Jan 14, 2026 at 10:26:33AM +0100, Krzysztof Kozlowski wrote:
> >> On 14/01/2026 10:01, Lorenzo Bianconi wrote:
> >>>> On Tue, Jan 13, 2026 at 09:20:27AM +0100, Lorenzo Bianconi wrote:
> >>>>> Introduce en7581-npu-7996 compatible string in order to enable MT76 NPU
> >>>>> offloading for MT7996 (Eagle) chipset since it requires different
> >>>>> binaries with respect to the ones used for MT7992 on the EN7581 SoC.
> >>>>>
> >>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> >>>>> index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..96b2525527c14f60754885c1362b9603349a6353 100644
> >>>>> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> >>>>> @@ -18,6 +18,7 @@ properties:
> >>>>>    compatible:
> >>>>>      enum:
> >>>>>        - airoha,en7581-npu
> >>>>> +      - airoha,en7581-npu-7996
> >>>>
> >>>> This does not warrant new compatible. There is some misunderstanding and
> >>>> previous discussion asked you to use proper compatible, not invent fake
> >>>> one for non-existing hardware.  Either you have en7996-npu or
> >>>> en7581-npu. Not some mixture.
> >>>
> >>> Hi Krzysztof,
> >>>
> >>> We need to specify which fw binaries the airoha NPU module should load
> >>> according to the MT76 WiFi chipset is running on the board (since the NPU
> >>> firmware images are not the same for all the different WiFi chipsets).
> >>> We have two possible combinations:
> >>> - EN7581 NPU + MT7996 (Eagle)
> >>> - EN7581 NPU + MT7992 (Kite)
> >>>
> >>> Please note the airoha NPU module is always the same (this is why is just
> >>> added the -7996 suffix in the compatible string). IIUC you are suggesting
> >>> to use the 'airoha,en7996-npu' compatible string, right?
> >>
> >> No. I am suggesting you need to describe here the hardware. You said
> >> this EN7581 NPU, so this is the only compatible you get, unless (which
> >> is not explained anywhere here) that's part of MT799x soc, but then you
> >> miss that compatible. Really, standard compatible rules apply - so
> >> either this is SoC element/component or dedicated chip.
> >>
> >>
> > 
> > Hi Krzysztof,
> > 
> > just noticing this conversation and I think there is some confusion
> > here.
> > 
> > The HW is the following:
> > 
> > AN/EN7581 SoC that have embedded this NPU (a network coprocessor) that
> > require a dedicated firmware blob to be loaded to work.
> > 
> > Then the SoC can have various WiFi card connected to the PCIe slot.
> > 
> > For the WiFi card MT7996 (Eagle) and the WiFi card MT7992 (Kite) the NPU
> > can also offload the WiFi traffic.
> > 
> > A dedicated firmware blob for the NPU is needed to support the specific
> > WiFi card.
> > 
> > This is why v1 proposed the implementation with the firmware-names
> > property.
> > 
> > v2 introduce the compatible but I feel that doesn't strictly describe
> > the hardware as the NPU isn't specific to the WiFi card but just the
> > firmware blob.
> > 
> > 
> > I still feel v1 with firmware-names should be the correct candidate to
> > handle this.
> 
> Yes. What you plug into PCI is not a part of this hardware, so cannot be
> part of the compatible.
> 

Thanks for the quick response. Just to make sure Lorenzo doesn't get
confused, I guess a v3 would be sending v1 again (firmware-names
implementation series) with the review tag and we should be done with
this.

> > 
> > Hope now the HW setup is more clear.
> > 
> 
> 
> Best regards,
> Krzysztof

-- 
	Ansuel

