Return-Path: <netdev+bounces-13677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17873C832
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 10:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AF4281FEE
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2B1371;
	Sat, 24 Jun 2023 08:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAB1C08
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 08:02:14 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542EB295A
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 01:02:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98bcc5338d8so158461666b.1
        for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593720; x=1690185720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evwXLshiChnPPoFaOHbuHqZ762vCCjuGEyQDNCOD67s=;
        b=D9tJ/SfpPzuEgx6VkFAna6q37GPvy140Mp1+3AL4FalYGKRecNq4J5+7jqN3/okS8O
         6VCYYFjRmknfk1Pc6cmV5km+eu6S8+dNsd/6ZxlJHnuwXBsHrGYlDYPQc+5f6+k6+IuB
         GQ2i6ZzaDPj3eVQfF+ha5N+EegiRLR6qQUSP7YQmJByxynUIP9FFNPV1KvaIldisXyYf
         CEC0Kmvo9lFLJYFbPpu7qy9Q8Xiyb4NJqbwsjDnHHtgoqGqOd9Th0k19ifx675SrSoj/
         Q0oNeP6rMCMHk685HjSqRhDPeDMfnhCGrCr0QzKvt4/28ajDuSinwy8LILhi/tqkhGoC
         s1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593720; x=1690185720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evwXLshiChnPPoFaOHbuHqZ762vCCjuGEyQDNCOD67s=;
        b=gKWGgiDkooyF921AjOAyRkzmq0ojGSWhUsTSavAx8eDdTeomhjJYGNIfnUySAecYUE
         5qJCTzWpM04ucbZWe8q9jXNUm0feODeSEgfrQs/Nsk0q+H3huW4ixRief7syxCQAuN3t
         yCPMvwr4aTHE+ZAZmsPlZavlSSlwubJeam9Z+9aFCi3Gk96PTUSBgIDVsALDqL4BrGK/
         mDT1K7zOH3QrfY5QJRA+JGs4iB0XMJ4Dm7lYLb8jVHLE9kx3G875lDGG1d0G8W7oUfy6
         KTG7zmRFVgspBsiayDkGFDYt8W+sQ54V9O0s9pxBnYChrue/28ChHGTxd2x+E20TGeOv
         1UwQ==
X-Gm-Message-State: AC+VfDxkxTbK6TpB/8yKegVwjMZN12VYZ33GvV+Y1BwmXeQXxmJ5qy2z
	6uIJge9mD+Kwr20Gazzz/pqJ3A==
X-Google-Smtp-Source: ACHHUZ6WVqK97+L/rLsxsj0TIcEtyCmujOvKdKn3w1rntsMk+nGINy7dJc6MjB9ynUGuEpDSVTkQsA==
X-Received: by 2002:a17:907:3da6:b0:98c:b942:dc7d with SMTP id he38-20020a1709073da600b0098cb942dc7dmr8195232ejc.64.1687593719652;
        Sat, 24 Jun 2023 01:01:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lo6-20020a170906fa0600b00982bf866f9esm607015ejb.66.2023.06.24.01.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:01:58 -0700 (PDT)
Message-ID: <fb91791c-760f-45f5-12db-04f2ff1be8c1@linaro.org>
Date: Sat, 24 Jun 2023 10:01:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 28/45] dt-bindings: rtc: at91rm9200: add sam9x7
 compatible
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
 tglx@linutronix.de, maz@kernel.org, lee@kernel.org, ulf.hansson@linaro.org,
 tudor.ambarus@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, p.zabel@pengutronix.de, olivia@selenic.com,
 a.zummo@towertech.it, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
 gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
 wim@linux-watchdog.org, linux@roeck-us.net, arnd@arndb.de, olof@lixom.net,
 soc@kernel.org, linux@armlinux.org.uk, sre@kernel.org,
 jerry.ray@microchip.com, horatiu.vultur@microchip.com,
 durai.manickamkr@microchip.com, andrew@lunn.ch, alain.volmat@foss.st.com,
 neil.armstrong@linaro.org, mihai.sain@microchip.com,
 eugen.hristev@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
 balamanikandan.gunasundar@microchip.com, manikandan.m@microchip.com,
 dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
 balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-29-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-29-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add compatible for SAM9X7 RTC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> index 4d2bef15fb7a..e15872bbdd7e 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> @@ -20,6 +20,7 @@ properties:
>        - atmel,sama5d4-rtc
>        - atmel,sama5d2-rtc
>        - microchip,sam9x60-rtc
> +      - microchip,sam9x7-rtc
>        - microchip,sama7g5-rtc

Same as in other cases, so just to avoid applying by submaintainer:
looks not tested and not working.

Best regards,
Krzysztof


