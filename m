Return-Path: <netdev+bounces-27385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D713877BC23
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CB428102D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A12C150;
	Mon, 14 Aug 2023 14:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEEA923
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:54:59 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A400FE65;
	Mon, 14 Aug 2023 07:54:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1c66876aso587432166b.2;
        Mon, 14 Aug 2023 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692024896; x=1692629696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SdQr3rrizrMRhKoEmZUiV2af/wkAGf076hXpLFsw31g=;
        b=cJpN17+XMgDreKMySImUvNHZksbt4rB280CaUXDOttaJA280+H7xGnogrnAC3wkGYO
         Wx8q5yJltHuAYXHIq12XESM+AWMq2o+xK/N3+WFGjy1q5hj+V86Ag0wXspihkYcHdULk
         XNCiba2p7GCrfK2/a7khsCdUAQxFHo6qbWjcaJQ4oiBHSr+G4oHperJs0875V/l5wEIZ
         WX5/ZTizYDiFpmFlOkN+ov+k5ET0n1Z6xqYhntGuW8jYREQ7C0lUcrYM80fZD/0npfR+
         oCbDAq6RXYskXP0SEocdIWIaqrejtXpTwLhKFLmFpnr5fsbbip5DtlEQxli6PQ/gIUDp
         eE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024896; x=1692629696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdQr3rrizrMRhKoEmZUiV2af/wkAGf076hXpLFsw31g=;
        b=ap9lwajLz3WmhwUNa0e7llnYj8E3OIB7FW9bnPr21tgtTH2BtfWSCo67Y7XQOEsWTD
         LgQytGQ8QM9/lTvzwxyd4j36tlrSLMWjFrTVX/9JkVjBzlU9kP3yc1PV6T9Tf/f3iYCQ
         k5tL1lre8crVPEsGPnd1zRna8c/UdYX9XdInaKte+sJKjuJhbZnLgGcXwJzbRA+U5g/O
         FXNTKvapcBAYknX6F6KznpQz2vn2TqolIx6MCTxG/lwz+awiD7l7ZaKhbYxqFOSVuFwA
         aKNjAR1TU2BDGgjwrsDAhlieIslA+6tl/zjaIMkjogAZnuzWVCN8CSIgSyblO8SZ16/i
         PFHA==
X-Gm-Message-State: AOJu0Yx6yVnqlfiJ/B5YEMvlp04AZVc6VoyX9vwXeEPQs/yvmn6JWtvM
	TzPe4L2owZAvUVDDIK5M8RI=
X-Google-Smtp-Source: AGHT+IGD+bEMcb3aN2r3jf0W/51DuXGWSsBb0MvHmMbqHAkymleRZPycJXHf7avCMC7iSeqawJ64/A==
X-Received: by 2002:a17:907:1de9:b0:99b:55e3:bbd with SMTP id og41-20020a1709071de900b0099b55e30bbdmr8394422ejc.34.1692024895791;
        Mon, 14 Aug 2023 07:54:55 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b0099d0a8ccb5fsm5767726ejb.152.2023.08.14.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:54:55 -0700 (PDT)
Date: Mon, 14 Aug 2023 17:54:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: microchip,lan937x: add
 missing ethernet on example
Message-ID: <20230814145452.i73g7bfb6wkoqp5w@skbuf>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-2-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230812091708.34665-2-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 12:17:05PM +0300, Arınç ÜNAL wrote:
> The port@5 node on the example is missing the ethernet property. Add it.
> Remove the MAC bindings on the example as they cannot be validated.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  .../bindings/net/dsa/microchip,lan937x.yaml           | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> index 8d7e878b84dc..49af4b0d5916 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> @@ -68,16 +68,6 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>  
> -    macb0 {
> -            #address-cells = <1>;
> -            #size-cells = <0>;
> -
> -            fixed-link {
> -                    speed = <1000>;
> -                    full-duplex;
> -            };
> -    };
> -
>      spi {
>              #address-cells = <1>;
>              #size-cells = <0>;
> @@ -138,6 +128,7 @@ examples:
>                                      phy-mode = "rgmii";
>                                      tx-internal-delay-ps = <2000>;
>                                      rx-internal-delay-ps = <2000>;
> +                                    ethernet = <&macb1>;
>  
>                                      fixed-link {
>                                              speed = <1000>;
> -- 
> 2.39.2
> 

