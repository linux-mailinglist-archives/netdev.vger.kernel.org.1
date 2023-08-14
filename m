Return-Path: <netdev+bounces-27447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B6277C055
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A09281213
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4ECA65;
	Mon, 14 Aug 2023 19:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86664CA49
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:06:30 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35C510F7
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:06:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6185196a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692039987; x=1692644787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5HtRk7v9N5XEliCZizIOYoda+POCp5Lvz3Wvapa2NQ=;
        b=rDeKbTEZJKLZ9FP1roXmnxVr4jyE26Xz426JSxZdrzFWLD5ynNP3xL8sNjLcZU/yaL
         56uzL+AXlE3EnhrMYYJZN356xVRsL+DBftaWVa5MdwnNPtTB/06e8PaKrxHHpwMVfRfM
         Dsp69t/qPIE2on4qrEYQZfSRtWSPiRVAM5a887sF+w+hBCVqnycbtdnYngB+lHxLLy46
         QaSiAGaZeqwj0iZ2S/TTfBYlt+kgL/KVZOr09/XGuys4tU09IOhFHylGoMYHVXxrB+IS
         6IUxT0Z2anepZ/wN3DbVMWHvkX/h95uHAqig2E2Nmj97puU6DWSdv2Q7TercqwaTXKrk
         e26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039987; x=1692644787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5HtRk7v9N5XEliCZizIOYoda+POCp5Lvz3Wvapa2NQ=;
        b=bRTXPO/lSOvp3ZEUZvOy9X4wHnJ9m/uMqI+PEUtPlM6OIeNUR7TpmQV0PlAtT9SLli
         nMyH2GAttj3VtPjMA3uxvsgF0cs4i4Som8L55G/8DbTGgm+HBkeWsO9AigeU4D1R/ups
         f1P8MXFDXdH6496wO41KNUO4gNqurxh8Mo2zJotN3eusu+3/s2UW0z47NZn1awsOLSfZ
         Y8fakT59IY3Z1nyBEhrv9yuSaccncZW/v/b8pMchWBlEC5dcRkrIeiOZG1aU6E/VpbWh
         nTQyYZ6G1QipJ0bwdjMlPt4rpB9dHNQuG117xkjOlM4ZWhsrWvCWb7W3lfmJftE6Wp/6
         UNGw==
X-Gm-Message-State: AOJu0YwarUbLev8g+oKvpr3tcuDLXdBldkQqq20EdFQ+6OGIqlObHVMp
	TxS+wkWqkR7SnUs98QI7l2tcGQ==
X-Google-Smtp-Source: AGHT+IFHiepWq3vTDb+HRBkxRdAsLmYtndO/QQpUJgvVSY+3A1b+srlVoCwN0ixgeEioddUXasf1pA==
X-Received: by 2002:a05:6402:792:b0:51d:fa7c:c330 with SMTP id d18-20020a056402079200b0051dfa7cc330mr8460833edy.26.1692039987311;
        Mon, 14 Aug 2023 12:06:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id t8-20020a056402020800b005236b47116asm5862939edv.70.2023.08.14.12.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:06:26 -0700 (PDT)
Message-ID: <fae2d136-28e3-d3a1-c789-8552e8f59a15@linaro.org>
Date: Mon, 14 Aug 2023 21:06:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
To: Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-3-keguang.zhang@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230812151135.1028780-3-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/08/2023 17:11, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 8103154bbb52..c77d7b155a4c 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -49,6 +49,8 @@ properties:
>                - hisilicon,peri-subctrl
>                - hpe,gxp-sysreg
>                - intel,lgm-syscon
> +              - loongson,ls1b-syscon
> +              - loongson,ls1c-syscon

It seems each SoC has multiple syscons so using the same compatible is
wrong. Different devices should have different compatibles.

Best regards,
Krzysztof


