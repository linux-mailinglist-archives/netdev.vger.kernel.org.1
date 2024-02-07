Return-Path: <netdev+bounces-69727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B88884C5D5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 08:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E669D28981D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D21F955;
	Wed,  7 Feb 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0qxNt6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D1200B8
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292377; cv=none; b=Lf7e2vyb3ybvCAFs/W7tDB4E+WIQAhxMzygr9N2R1lrIXtHtdN5d3x01Jmf6L0IAEy0f49L7PdO0hE546srn3/KQh6NIUo9PPOwM4q5ccWjCeYSWriKVjLDo0UjopjAX7UTTzHJS7bp4xwTyOk8YEjYtjSiajJR7g+9Xg6MhEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292377; c=relaxed/simple;
	bh=KPfQuWi/PXVkKmq8lELu0pIH64nc2bAJSKfva0E2W9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxkxWe29+AmLLIvFnv9E+OC1csz+4rHzW8jQslirBuMnSNQQrFAyfpRuwidges11EaYKw4NUEBmsKDJKM10ALIcQ+88yjZt7YKkPrtS03ILxAr1XCI3poYwyifRMycWvY+q/B9O7l0W4azqu2RIiHXZQ4AVCgPia2zN8lrxje2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0qxNt6g; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337d05b8942so317383f8f.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 23:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707292374; x=1707897174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4m7Si2JFAYJeO9yLW8w4qmaSrLD1aYrFf/y2zpA4ILM=;
        b=q0qxNt6gv+E/hGFNAq+dK9U6faq5MSy0rs1ix5y83IJp9416UdBAC+/FOPIyyFG7w1
         1ykDQzjMWtjbH3SRVstL6Z8oiK2AQdbpWHNhzo9XSqR0zPOkWjYPwOtDWG2EMLfa2F72
         dXL3Le2E9TEA8cFHHvxKalkZYStptHaRkyRkERK58JE8CVjwTkg8E9Q6VNca1N2eI3bt
         tlC2dbaTbrYtDKk9FuJTWmXKnn5g/Xa9Ti08+U8MSCdV7tk1+JYiBSiPkXbU09IVFRYE
         yn6ApAN7tM8KXINra6p8uDKZbR+WB0XrpdFhzvX9dFr+osI71Mb/5z+Q8mEiY4A36hDg
         fWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292374; x=1707897174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m7Si2JFAYJeO9yLW8w4qmaSrLD1aYrFf/y2zpA4ILM=;
        b=RN03iysLyEb4S1dV0hLLEKIw8MZ9jv0fqWPNDb7M0OuHzBCxsy7j7pBybsgM3m1Xut
         +540rUzCPi92HFxnxR2ZgO7jdm/LptePKPMc/sj0cWEBUXbDL4kzCmvEkMVJoJVEtNzE
         JXEptK9Ticr+CzYeLTwuPCR6y6o8zMWU/AJL44pqI5mLuTNGCj/XqBtPOvvJVL0EMC9m
         5olOmw0mOoZV+p3Cdp3vUQSRNcD3+7gpN182S0wAwikYQpTcYnhwzq+RDyrj1HR1U+iP
         oNaY8kq6w+ngPY/OIx92C03vKpbelrkZ3CXIGDXBxaecyXXgSn95cMwyf06Eq+TT34Y+
         7L2Q==
X-Gm-Message-State: AOJu0Yx6e6RpevMF/LZD4jSOGgs4aKk247kye069Z55r58z3geQxT9j8
	OIDnyeVlPiscX+hNHjhtlBLl2Qc5EJhuFBdtCK+wuaBovJq1IU1BPDgI6GqmHG0=
X-Google-Smtp-Source: AGHT+IH/aKBWw+eJLUYv8QGZd4sXrwuaM+XNWQReNDxtgKZa2iR4o45DsEoZsG80TSSFCTqcpInx/g==
X-Received: by 2002:adf:e50b:0:b0:33b:4b01:cc94 with SMTP id j11-20020adfe50b000000b0033b4b01cc94mr1866833wrm.63.1707292373570;
        Tue, 06 Feb 2024 23:52:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsFMp0lx84Jc2lvposEF66wvq1wewxRpxX3R80XKreT90wcFbPNlQ5oeJ35WcI+vCO7nNGO49KLQtPVAPGimHJB45pR17NRhFxm80WRhXFPeaMNdqMy7HXFJn9LueYfgDRYOFBK5quYUPIMEBg4Uf05jPudnwIqeMyM2rNjkYiiclDXirjviJu8B2IcPpuBiPHtuZdz/eMkIUnkHPmPKbaTHMIm0Y/HqmF8TSiIHd2T98eyIb4FfRlI+AS0Vbbusg1BBy/VsFhx7rqS6D883FqY/tu+3RLXomNY2/Soi9AP1q9cwc/6ImQnkLlDB+v6S2G/OaAKsWVgpV0hkmjmzuv41SNKcTwg6jEokw8ntxcOKKpOJrX3R/LmYSGuxTCYOYaDKd2k5hj6hsCVYKG5HNIC9gbegp5h8sHCZWma9BhlDsYovSmgncBYWvlDNmU0Dbilqv52C9wjwUdKAXb3OJexxRja5XkS1U7UXawP1yG3ppJTzOV9eU4zf2tm3ABJmTMLav8iXyy1Vjw8Z7LPKmDOLLZqph5riwKMTDMDgekdLLKq1GUMXwZmmVK7HD7nABYzM6DP1GE6fI6L02lu21ztK/A
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id d11-20020adff2cb000000b0033b278cf5fesm806286wrp.102.2024.02.06.23.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:52:53 -0800 (PST)
Message-ID: <76f9aeed-9c8c-4bbf-98b5-98e9ee7dfff8@linaro.org>
Date: Wed, 7 Feb 2024 08:52:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h serdes polarity
Content-Language: en-US
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240206194751.1901802-1-ericwouds@gmail.com>
 <20240206194751.1901802-2-ericwouds@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206194751.1901802-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 20:47, Eric Woudstra wrote:
> The en8811h phy can be set with serdes polarity reversed on rx and/or tx.
> 
> Changed from rfc patch:
> 
> Explicitly say what -rx and -tx means.

I don't know what does it mean. This is v1, so we don't expect
changelog. If this is v2 (because there was RFC/RFT/RFkisses/RFhugs
which are states of patchsets, not versions), then please mark it as v2
and put changelog under ---.

> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  .../bindings/net/airoha,en8811h.yaml          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
> new file mode 100644
> index 000000000000..99898e2bed64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,en8811h.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN8811H PHY
> +
> +maintainers:
> +  - Eric Woudstra <ericwouds@gmail.com>
> +
> +description:
> +  Bindings for Airoha EN8811H PHY

Drop "Bindings for" and instead describe the hardware. You are
duplicating now title.


> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:

This won't match to anything... missing compatible. You probably want to
align with ongoing work on the lists.


> +  airoha,pnswap-rx:
> +    type: boolean
> +    description:
> +      Reverse rx polarity of the SERDES. This is the receiving
> +      side of the lines from the MAC towards the EN881H.
> +
> +

Only one blank line.

> +  airoha,pnswap-tx:
> +    type: boolean
> +    description:
> +      Reverse tx polarity of SERDES. This is the transmitting
> +      side of the lines from EN8811H towards the MAC.
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethphy1: ethernet-phy@1 {
> +                reg = <1>;
> +                airoha,pnswap-rx;

You have broken indentation.

Use 4 spaces for example indentation.

> +        };
> +    };

Best regards,
Krzysztof


