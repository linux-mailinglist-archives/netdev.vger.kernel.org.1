Return-Path: <netdev+bounces-78958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C08771AB
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 15:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5642BB20E9C
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93F3FBB0;
	Sat,  9 Mar 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="UU8jaHjA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EC1BDF4
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709995274; cv=none; b=TPFEID8daJTS4bQe6GP3AaedHww8SOnUOxxrQvsTZ9W9QwT51inSmha2QVTM6jAd+LOJ8sgflz8CT/h19yw9jYaBa0xntXKRrqRjIN9Q8HrjAPJP2SONDpDEPx408B3lvkTXL1QysRFVLbsS7AjaLqbRfv9kqylCo3BLRcF89ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709995274; c=relaxed/simple;
	bh=IzBLFbK9oOlEHEb0H1yGUQxZ9MKYj/qNuBe2AGswBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5jymXJtaEwQi+0TuLuc5Bf6CwVgozoAcO7pTrvG15E3Nl0OZqYcNdXS/DY+criY62qtQ+NgMq8b4FhIYd0aCiNCL13FCFj1mzWxJtEuglQXqCGLlPc7PS4g5xxprjS0xcqJbKeUaD1OVyIugz2qREJhoQIxx0ypgK0+2c2W25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=UU8jaHjA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51336ab1fb7so2324414e87.1
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709995270; x=1710600070; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xwESe4a6WCPaLW5Z6luTRR81H770hCLDzcMHfprpWI=;
        b=UU8jaHjAEUO7AUVaQUNF4ObKonT3gQsSMZW1o84b+fg7E+AmpDQ1d8+lF3ArC9HDlB
         wyCzWHLp5EcStEGVRqZsqkzKTyPLCs5Y7wCXmYRZ9jJQmiVQBz6XKrNxC0Tu914yJKKK
         kJjIM1cSBHQD1Wm7HetooJNZ5h4tImTXGp4t4/BsPZTHSbI9kOIDKNLgo6c00gXOQ7qJ
         vS/1twOiaPf3eHE7zl8NbKaDRo8GaTKglgp70yHnfKfai9svSRvcE6YMR3naql2f/366
         yhSp579XvcSjMhCW6ak+LJk9GOXKAT9pOHgq+FvyCpcLiQ73mboUiKHaDmBjn6lYkryu
         9RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709995270; x=1710600070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xwESe4a6WCPaLW5Z6luTRR81H770hCLDzcMHfprpWI=;
        b=pK7swbAyscsgoEYIxsOC3x2Lzoeg/XLSbYw5PvIHEY4a9IBGpZMB2izjmqLnMgUJQv
         bCLNCjKSib0ZVgBhO9qGJ8d9+qoj49ldu1pxzWlMyjz1BK3J3m/UaWIRjAZ6ej4OrdcG
         WMbrtBOq0YVFgBNnbZ+Im92flRHiMO88F+gEfssWo6avQ0voUwWlQ7cnzNJnupyqtJut
         jVlCP7PeAAZfmuJ2fsl0hrHcJBHeofEf1OmOo8cTCpI/D6LdKDE9wGH6r2SQ08VSPa+0
         XWVz9FJw2TddMg71j/44rSf76DPGKo4EuGMImm21Hw4GGPGCsKJQrvxbwA9VQq6ZCVlE
         J9ag==
X-Forwarded-Encrypted: i=1; AJvYcCXK7YW8zqNgVQfs22HW0jd5Nsa+CxfwlP91h+xCtkXEgJaYINISGqzBBv5EA2vHg4TTOEt6K1OpUPPdkgis2PJUt2rgw3Fu
X-Gm-Message-State: AOJu0YyfvIKKwtL/nNnakrCHgZhlssqOG/TwjFOZdh4Z+Uonr5eQINy5
	yhn8axxo4RY8I9ACagzjWuq6YmGkg6lrrRH8zNBG6P3uw/ub3PibXlJoT469kh4=
X-Google-Smtp-Source: AGHT+IGa/mHD/4/rYMYZsUWADhXsvXO34E4+/aL+FDP5pnnIOG7h6xAxsrkAvY+Zi2tiz6Z6BFLVtQ==
X-Received: by 2002:ac2:5a09:0:b0:513:45b7:91c2 with SMTP id q9-20020ac25a09000000b0051345b791c2mr1097054lfn.36.1709995269834;
        Sat, 09 Mar 2024 06:41:09 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id fb6-20020a056512124600b005139cbb1695sm271562lfb.264.2024.03.09.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 06:41:09 -0800 (PST)
Date: Sat, 9 Mar 2024 15:41:08 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: renesas,etheravb: Add MDIO bus reset
 properties
Message-ID: <20240309144108.GF3735877@ragnatech.se>
References: <20240309012538.719518-1-niklas.soderlund+renesas@ragnatech.se>
 <1375d840-6e42-4e60-896c-265fe6a21705@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1375d840-6e42-4e60-896c-265fe6a21705@linaro.org>

Hi Krzysztof,

Thanks for your reply.

On 2024-03-09 12:45:06 +0100, Krzysztof Kozlowski wrote:
> On 09/03/2024 02:25, Niklas Söderlund wrote:
> > The bindings for Renesas Ethernet AVB are from 2015 and contain some
> > oddities that are impossible to get right without breaking existing
> > bindings. One such thing is that the MDIO bus properties that should be
> > its own node are mixed with the node for the IP for Ethernet AVB.
> > 
> > Instead of a separate node for the MDIO bus,
> > 
> >     avb: ethernet@e6800000 {
> >             compatible = "renesas,etheravb-r8a7795",
> >                          "renesas,etheravb-rcar-gen3";
> >             reg = <0xe6800000 0x800>, <0xe6a00000 0x10000>;
> > 
> >             ...
> > 
> >             phy-handle = <&phy0>;
> > 
> >             mdio {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > 
> >                 phy0: ethernet-phy@0 {
> >                     ...
> >                 };
> >             };
> >     };
> > 
> > The Ethernet AVB mix it in one,
> > 
> >     avb: ethernet@e6800000 {
> >             compatible = "renesas,etheravb-r8a7795",
> >                          "renesas,etheravb-rcar-gen3";
> >             reg = <0xe6800000 0x800>, <0xe6a00000 0x10000>;
> > 
> >             ...
> > 
> >             phy-handle = <&phy0>;
> > 
> >             #address-cells = <1>;
> >             #size-cells = <0>;
> > 
> >             phy0: ethernet-phy@0 {
> >                 ...
> >             };
> >     };
> > 
> > This forces to all MDIO bus properties needed to be described in the
> > Ethernet AVB bindings directly. However not all MDIO bus properties are
> > described as they were not needed. This change adds the MDIO bus
> > properties to reset the MDIO bus in preparation for them being used.
> 
> That is not exactly what you wrote in the binding. Binding suggests you
> have per device GPIO, which in your design is shared but the commit msg
> says it is some sort of bus reset.
> 
> These are two different things, because in first case you could have a
> design using two GPIOs, not one. Then your binding is completely wrong.

I copied the description from mdio.yaml as the intention is the two are 
the same. But on a second read I agree it's confusing.

> 
> Plus, where is the user of all this?

I think you found it in, for posterity it's in '[PATCH] arm64: dts: 
renesas: white-hawk: ethernet: Describe adv1 and avb2'.

> 
> I think you should rather correct the binding to use mdio node and add
> appropriate handling in the driver, keeping backward compatibility.

I had not consider that, the driver can indeed support both modes and 
only allow MDIO bus properties if the mdio sub-node is present. I will 
do so, thanks for the suggestion.

-- 
Kind Regards,
Niklas Söderlund

