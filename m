Return-Path: <netdev+bounces-24685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C148D771126
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F731C20A95
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD4C2F3;
	Sat,  5 Aug 2023 17:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE5C2C8
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 17:50:14 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B835AA;
	Sat,  5 Aug 2023 10:49:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcd6c0282so450153666b.1;
        Sat, 05 Aug 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691257793; x=1691862593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYJH/1P//NwsKipiDkgfl/z4aZz2q+xkqCsqTOu5Bf0=;
        b=j/mPVWvYXvbo/U83l1AGEhWBbnbL5ajrpLlTTSCXbdaJLSvpWA8XqfqCvpKRezoFL4
         GDCsmSuw4dObYIn1NQHIrtO7ZljDdV247wdhWW9+Cpfz688iwYU7cQKJu8T7/HeszQsu
         +gOMBaXAsF7foZDrq8HVld7TYkXDQW+G3tzwyD91WjNo33t6Kge2uh7vGnl85cJX+P2T
         V62JC9p/sXMehHtY70AFIe2oLRP5xx/e6aaK28Uh53j+ytu8bBbd8/iOo+q7pwuDOAcS
         7egsQyG0sDLHfjw1HKaoZ1wV0CIE8QTdpfWHlZNK7w4Krg8Mxi8EMbY2Url/mmGqVuOu
         4Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691257793; x=1691862593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYJH/1P//NwsKipiDkgfl/z4aZz2q+xkqCsqTOu5Bf0=;
        b=ihBy1agR/z4cQ81YN6x9YESZwq8IgeMBQXPs1DJD5yyojORrNcj7AaVsukaP5rQXBC
         qnwIG7fWHJF2coGSVZN4a6w9LDvGgdfliDXccCGUsx79SJD8JbiXHf9fMSOP2DzQsqDy
         H/i1++ZjRTajfGLRqNrwuft4IROruWPnr5gvB2lk8vjKsScTKsk+Bsm3poEFBX6jyNcF
         HgLooSauRfNK92t5ivxEAsoLF1CgPxx7kbvK53a1SJiahdkkEEI1Q5lp650KrU1/Bs3K
         G2kPmGQsO8THH3Lu5KnqTaG/h9kPovZCcDGSb3Mmhqbt8v+3yQ7QfwqkjQVhrVW3C7OH
         o62g==
X-Gm-Message-State: AOJu0Ywn3B6SMCrmLxbnQaOl2H1ApNF224cCVwz3PDZdfqzbdsN69lsc
	FiuSVPuhIJK4Kq8JtYuPKtc=
X-Google-Smtp-Source: AGHT+IEj+JsLAYsRvKq5tljy3+gyroq6CmwWB5RDT+QP3IP4h/PpnBkxNteaPS5GTU473Jm9OxjtOg==
X-Received: by 2002:a17:906:14:b0:98e:1156:1a35 with SMTP id 20-20020a170906001400b0098e11561a35mr3934964eja.74.1691257793309;
        Sat, 05 Aug 2023 10:49:53 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906138800b00992ae4cf3c1sm2938044ejc.186.2023.08.05.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 10:49:52 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maksim Kiselev <bigunclemax@gmail.com>, John Watts <contact@jookia.org>
Cc: aou@eecs.berkeley.edu, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com,
 krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, mkl@pengutronix.de, netdev@vger.kernel.org,
 pabeni@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh+dt@kernel.org, samuel@sholland.org, wens@csie.org, wg@grandegger.com
Subject:
 Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Date: Sat, 05 Aug 2023 19:49:51 +0200
Message-ID: <2690764.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <ZM5-Ke-59o0R5AtY@titan>
References:
 <20230721221552.1973203-4-contact@jookia.org>
 <20230805164052.669184-1-bigunclemax@gmail.com> <ZM5-Ke-59o0R5AtY@titan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dne sobota, 05. avgust 2023 ob 18:51:53 CEST je John Watts napisal(a):
> On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> > Hi John, Jernej
> > Should we also keep a pinctrl nodes itself in alphabetical order?
> > I mean placing a CAN nodes before `clk_pg11_pin` node?
> > Looks like the other nodes sorted in this way...
> 
> Good catch. Now that you mention it, the device tree nodes are sorted
> by memory order too! These should be after i2c3.
> 
> It looks like I might need to do a patch to re-order those too.

It would be better if DT patches are dropped from netdev tree and then post 
new versions.

Best regards,
Jernej

> 
> > Cheers,
> > Maksim
> 
> John.





