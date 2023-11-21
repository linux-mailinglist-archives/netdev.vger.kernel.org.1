Return-Path: <netdev+bounces-49649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB777F2D77
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F0F1F23E65
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75E1C69D;
	Tue, 21 Nov 2023 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="CgdKZaxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6169DA2
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 04:44:23 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso66686291fa.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 04:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700570661; x=1701175461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rMw5n9cmVUZi1UTcla4CtRS6x8Yg6FXUn9xygIUWkmw=;
        b=CgdKZaxnV/QkgHsDlP2LNfI5xFouZftrhvu2iWre+eIGKuoJ7ujAGI01eyK8AykT1C
         xL7qeOUV3/w4EvVtw8yFuvD9GqeZAD8+XRSxYWmHWgUPjHO81f/FpO/uLrvkwZxxJweG
         Cc0Jnejg5s6LKdTGHNyaUzv0GncQ4lbpkjjD+NM00TDGY0lDlpa08Lu+hyeqSaamDZZA
         ejNhhwfsv292G+Gp2qF26sJQvaZwPwSrgk34k0Bo2H6DADc2FaIP96/NavAAU8arAiUt
         +OXgopzE6DX1PXECAKHmF6J2FFEI14+1y95BTqZu+XG0gJ3ZksQRx1ncEdZfROJwP6pd
         eLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700570661; x=1701175461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMw5n9cmVUZi1UTcla4CtRS6x8Yg6FXUn9xygIUWkmw=;
        b=Lz83MS6WDT6K71RlWTIvp40xX2Zww2lMkpzUZTRaqO4Pgf4jpQYAEG3YJ7jqc8ht0z
         jP+Ab2SRII7zKmA5avQmFDQHnvm74L7nOgVjRMOLHA7TQOcLjKgsdFOj1AyLBLLq6RcZ
         8B6hWK3/zAax6LwTNLA7mtM/gTbH/JssndjYLuFp0fWwO+YuwlagJfwwp1JeDJ9tA5cK
         rE4636vM0Ghgu9fNpzhMQbSnRGVstTKm6gWKrsGUEwykmfMlwquuDtTeSA8lZC8IaGQo
         zmDGiYZHUBFLwtFRlrXXlbaYeQa2+KwbR3RfTHrjIH1ydAL4iUpvqz6Qjf8KP3HQqwB5
         z5zw==
X-Gm-Message-State: AOJu0YwIwtAkn78Ess9DYvhDitXLvm500tmgwfBF7nJDiNEhQSIomtD3
	fXtuFBIYH/SviSTAvoACqmZXMXEv/o7cOxxM7VdVrA==
X-Google-Smtp-Source: AGHT+IHGjvxg/Ua+h6ZcN6vDaA37sk4GAxUmdgFKQhNiBrZbkxbfYx+zoHyFIuzk4CYV9a8UGcZR2Q==
X-Received: by 2002:a2e:2243:0:b0:2c8:35a2:ab4c with SMTP id i64-20020a2e2243000000b002c835a2ab4cmr7082140lji.24.1700570661672;
        Tue, 21 Nov 2023 04:44:21 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id a7-20020a2e8607000000b002bfddd7f0b8sm1210238lji.101.2023.11.21.04.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:44:21 -0800 (PST)
Date: Tue, 21 Nov 2023 13:44:20 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: renesas,ethertsn: Add bindings for
 Ethernet TSN
Message-ID: <ZVymJF2dd7XssGaQ@oden.dyn.berto.se>
References: <20231120160740.3532848-1-niklas.soderlund+renesas@ragnatech.se>
 <2ab74479-f1fb-4faf-b223-ae750b4c08ce@linaro.org>
 <ZVyeMKjVhjW2F2e0@oden.dyn.berto.se>
 <2ffb39c3-7939-46f2-8ca9-2b2cb44caaff@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ffb39c3-7939-46f2-8ca9-2b2cb44caaff@linaro.org>

Hello Krzysztof,

On 2023-11-21 13:20:54 +0100, Krzysztof Kozlowski wrote:
> On 21/11/2023 13:10, Niklas Söderlund wrote:
> >>> +
> >>> +  renesas,rx-internal-delay:
> >>> +    type: boolean
> >>> +    description:
> >>> +      Enable internal Rx clock delay, typically 1.8ns.
> >>
> >> Why this is bool, not delay in ns?
> > 
> > The TSN is only capable of enabling or disable internal delays, not set 
> > how long the delay is. The documentation states that the delay depends 
> > on the electronic characteristics of the particular board, but states 
> > that they typically are 1.8ns for Rx and 2.0ns for Tx.
> 
> I don't understand that part. If you cannot configure the internal
> delay, how could it depend on the board characteristics?

Each of these two properties reflect a single bit in the device 
configuration space. If the bit is set the {Rx,Tx} delay mode is active 
or disabled. The documentation for the bit simply states,

    Tx clock internal Delay Mode

    This bit can add internal Tx clock delay typ 2.0ns*.

    *Refer to Electrical Characteristics for details.

Same paragraph for Rx but a typical 1.8ns delay.

> 
> > 
> > I looked at the generic properties {rx,tx}-internal-delay-ps but they 
> > are of int type. So I opted for a vendor specific bool property. Do you 
> > think a better route is to use the generic property and force the value 
> > to be either 0 or the typical delay?
> > 
> >> Why this is property of a board (not SoC)?
> > 
> > I'm sorry I don't understand this question.
> 
> Why setting internal delay is specific to a board, not to a SoC? Why
> each board would need to configure it? On which parts of hardware on the
> board does this depend?

Ahh, I think I understand. It is per board as I understand the 
documentation. It depends on the electrical characteristics of the 
board.

Maybe updating the description would help, how about?

    Enable internal Rx clock delay. Typically 1.8ns but depends on 
    electrical characteristics of the board.

-- 
Kind Regards,
Niklas Söderlund

