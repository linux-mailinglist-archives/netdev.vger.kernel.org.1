Return-Path: <netdev+bounces-54901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF58808E79
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768F91F2101D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09648CDE;
	Thu,  7 Dec 2023 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxr2+Q9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037ABA3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 09:19:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50be3611794so1137123e87.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701969584; x=1702574384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRHoBg+e4lgIgJKzi58vQb3qsKzDJiDasD/dwcxO1Ig=;
        b=Kxr2+Q9T7Nvj8ZCs6xqmi9v3a1ObQ0mYjkIfopyKuF/Zr8VCAU5Uwx/AXYPrtyGs8D
         4k3nvskY6fIziC2QywZkN0zXPpa/Ge3jj+DkEqwqIOCf0CTBt4ErPyTQjPMmMtzFCEzn
         IjWHUWrcDmAqyzD8RzhODSCD29gOntpE8FfX0eBqexWSpK4+IE71nzA7999gzw1e786s
         /zbu87YKBspSTBF0k9W7c7weFSj82ON1Kb1jWCDzt0oxLp9uRHANLyBjNrRNLACl4X85
         y8P8sVZDGIzBb4RkdrR/o6PtjNwlQq7rmycIEwdTsEERQAPkUy5lP39MeEyz1jwFPlbP
         ieJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969584; x=1702574384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRHoBg+e4lgIgJKzi58vQb3qsKzDJiDasD/dwcxO1Ig=;
        b=ESZ3P6TjldcCgRzU4p/5wFQHMhdlInqP7n/VVQHdmqYUEm3LX+Sq2Fj/vdGEYBq56O
         Kx+sKDdUSRw+mFfMM1avnPd14qttLQGyv4vhyk5GdZNe34A4+OLtTSMr7Tu+B5KQwJFU
         IUN7HhZtb1TRrYhjB0iDzesGyIDsndFzJNAeGNM7LO3MddCz9iruqI7x7WS+6jglRRaR
         QKYtzuB3gO/sHpMs/Kmi2/hpAhEK6COUWo5jfEf12wvN5i1XlMJCB4uLriIfAHNQgTSI
         7YqVE/I7V8ZP/pXaNe/53S/ZDrMoNENN4I8kkfrl/5uA7qbiSm6tChRDHj2NN5p5gMEt
         P3xg==
X-Gm-Message-State: AOJu0Ywp8Rwxal90rUQNfYwV2rc3Vx8PiyOoBoOEeac++X9xZkwIBouZ
	2y0IrQuOdhJME6rHyJZikD8=
X-Google-Smtp-Source: AGHT+IEpj6tGSGS158u15FcF7n6tjEx5auUv/OmsZYJgE6zJpi7PcJ3MXF20AGjV+4ghi0wuH0mwcw==
X-Received: by 2002:a05:6512:78e:b0:50b:aa9a:903b with SMTP id x14-20020a056512078e00b0050baa9a903bmr1376304lfr.30.1701969583827;
        Thu, 07 Dec 2023 09:19:43 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id ck9-20020a0564021c0900b0054f4097fea2sm67095edb.0.2023.12.07.09.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:19:43 -0800 (PST)
Date: Thu, 7 Dec 2023 19:19:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Message-ID: <20231207171941.dhgch5fs6mmke7v7@skbuf>
References: <20231117235140.1178-3-luizluca@gmail.com>
 <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org>
 <20231120134818.e2k673xsjec5scy5@skbuf>
 <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
 <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org>
 <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
 <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
 <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>

On Mon, Nov 27, 2023 at 07:24:16PM -0300, Luiz Angelo Daros de Luca wrote:
> The "realtek_smi_setup_mdio()" used in setup_interface isn't really
> necessary (like it happens in realtek-mdio). It could be used (or not)
> by both interfaces. The "realtek,smi-mdio" compatible string is
> misleading, indicating it might be something specific to the SMI
> interface HW while it is just how the driver was implemented. A
> "realtek,slave_mdio" or "realtek,user_mii" would be better.

The compatible string is about picking a driver for a device. It is
supposed to uniquely describe the register layout and functionality of
that IP block, not its functional role in the kernel. "slave_mdio" and
"user_mii" are too ingrained with "this MDIO controller gives access to
internal PHY ports of DSA slave ports".

Even if the MDIO controller doesn't currently have its own struct device
and driver, you'd have to think of the fact that it could, when picking
an appropriate compatible string.

If you have very specific information that the MDIO controller is based on
some reusable/licensable IP block and there were no modifications made
to it, you could use that compatible string.

Otherwise, another sensible choice would be "realtek,<precise-soc-name>-mdio",
because it leaves room for future extensions with other compatible
strings, more generic or just as specific, that all bind to the same
driver.

It's always good to start being too specific rather than too generic,
because a future Realtek switch might have a different IP block for its
MDIO controller. Then a driver for your existing "realtek,smi-mdio" or
"realtek,slave_mdio" or "realtek,user_mii" compatible string sounds like
it could handle it, but it can't.

You can always add secondary compatible strings to a node, but changing
the existing one breaks the ABI between the kernel and the DT.

