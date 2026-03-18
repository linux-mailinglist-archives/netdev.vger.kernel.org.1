Return-Path: <netdev+bounces-268929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHxkHgxpumnnWAIAu9opvQ
	(envelope-from <netdev+bounces-268929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:57:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2668B2B8931
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83CB43009B0D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61873988EE;
	Wed, 18 Mar 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfoQfUed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423238550C
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824250; cv=none; b=eqkY7moKeYbtYCu6YZhYYgpReoWetCdqizBdBX6qt4m1LJ1zgIssXEWHJ6pZ8gAM5YsnzEn+5oN+AY5qi8tVdYGzHqZyDYDgYNNTASRftk8KVqDZHmzQcd3E0eFIdB+U8jUMv2eSjnJJ+tKUHKQjgEqkJ6VuiqQtX1vviQyCraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824250; c=relaxed/simple;
	bh=NUWaA211MVtgOyFvRrtpZ0xN6iYxcwddItz9sEVKQiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0sigzQxSLtdeH8ebM0ZF2Q8ps4N2j+igjyOBZbIQbwPh3FniFz8FXlxSBCQ4p4WMocmhmBLOexa8+FnsoiUJR/KEGMxzW213emD1VK5leRS9oMHiA5/c0pMGJwJ4W7MB/r+d9HWTUWidcnpHM5Q8Nlb+feBvH0WZlKQ76tIVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfoQfUed; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so22243435e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773824247; x=1774429047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OudNO2OnvwTpIE96QJS7IaE3Xw3RCtNFDCoe4J2lk3A=;
        b=dfoQfUedNNvnmlDimCSR7G1+W7Rus9ksSpMCSVrMamWPCWFYIT7R58P2hoEBa2XyIf
         EoW3p54zCFkPH07K0Gca5PfiNWfhhf8slp3Q6IOMCsGYmwkT8yebOFK2uB8ei06lulfN
         hfSeiuW00qU4bBXQTLBa29v3W3eDRGDTygrJ3Vm+esjPxxwbg9wVAt7JXiS5b99BtHEC
         nnrgdhWBTQMIj2SgGq7l0YBxwTzbu8s/66Sx+OzzgVokVSCv3PLGEImxiRQYv4fojWhd
         CIbd+TpqV4LPGrFz6F4aoRpSveJm+dXbPT/COLpwSGqp3I7btL7swU8fxdfmO0H7VAWG
         /AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773824247; x=1774429047;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OudNO2OnvwTpIE96QJS7IaE3Xw3RCtNFDCoe4J2lk3A=;
        b=BT3tFE2Px90yiX+yT6rnU3F0aWl9ybX+LGahEJbiCLUhpu16rBRTGGFYk/WzvArk2S
         VubixdVPqplmZWhR93JAJ0iZm1XR/v4OOBqLLvwOPm+QHqCGx8BS12G+BzVrEGbQ5mC+
         ViCmRXeVnlOexD+0ev1jkG1INJ73KkA+8NZPWsX1d9yK8I7JGRug2OroIFlmmcMAYc8R
         Bl+VgKUAHRGI8FiZzCI84EzV1Tm2EyH58Fikz+HmVd1FG2ojIqRZ4lrtc775oKx8ay/R
         AMPSO/RZMk3tb8JqbbdRHpEXrgJSJ5NnAfda0voWq+3kvlHuCWxPTRtBqX2uThIc6s2Z
         T56w==
X-Forwarded-Encrypted: i=1; AJvYcCUPhwJrFo+mwJpRcKbVykpMugR+MrLmIfRSESIFhmZrydtcPpgB2gV3GXTmWr/+9tgN9WTxZw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXR6T6CWNPSpbC5NzPOwZ3eB94wV4lP47xg2uUuauIdepjJEo
	9mymjYRKbHNALzHifgLKu7IZhrLZjhA5c90JMg2YmDX9edcb95aHe2Wl5PW9GrpLXDw=
X-Gm-Gg: ATEYQzyiVN4ZymkyTN12C3ckh4eiWecWAaxZUWn3COcKdzYirjIjkXzPWfOBoGnio0G
	7fjYGqMnsQWLyBo4bTPBnQBxAs5HbEbat2bO12zNyka57TL2TFC6LcuaY6HC0RopXu91mriUxPN
	GvaxJgwPUlpap1rBTucli3hjO1nMGJACqA6Xcr1qvsgSjiciCvrMip12UWAGpSnIdlau3hUaBZC
	CH8xfZY9usVQHjhSpv3G0+hmPxNxrxOVMPvT9AHz6xeCId5qoleuRj+S1gZuvQ52LnS4j8uj3Dk
	QvObMXtQY95XelajcGxKYHA7koeiVcn1X13ZrnCQRhsgOFWEgXtkcw9JwTs+5qPmZzsWqW7e8xf
	slPdeiKyl1yPogl5+CWKhMgC/n09TrcQvoV6jUXFtfIkQNeRFLzuWfRKVzHu0zuGsboBET6F1WR
	0OyroHBaetwitvpDdGvCWkhq0KDshwrUFJYSIBoWh+S6Lq0lsRKjM87C0sUfIlb1+ff3H9mbSn6
	PpS07s=
X-Received: by 2002:a05:600c:4fc4:b0:485:3423:727d with SMTP id 5b1f17b1804b1-486f4476ce8mr38072065e9.26.1773824246935;
        Wed, 18 Mar 2026 01:57:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ac75:790f:ef3c:2eb0? ([2a01:e0a:106d:1080:ac75:790f:ef3c:2eb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaffbbdsm124891015e9.15.2026.03.18.01.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:57:26 -0700 (PDT)
Message-ID: <b48e092a-fcee-4065-a8ef-862245b9e2eb@linaro.org>
Date: Wed, 18 Mar 2026 09:57:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add qcs9075-radxa-airbox-q900
To: Mecid Urganci <mecid@mecomediagroup.de>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260318083621.470826-1-mecid@mecomediagroup.de>
 <20260318083621.470826-3-mecid@mecomediagroup.de>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260318083621.470826-3-mecid@mecomediagroup.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268929-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 2668B2B8931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 3/18/26 09:36, Mecid Urganci wrote:
> Add device tree support for the Radxa AirBox Q900 board based on the
> Qualcomm QCS9075 SoC (Lemans Family).
> 
> This board features HDMI 2.0 via dp0, 2x USB 3.1 Gen 2 ports,
> 2x 2.5GbE Ethernet ports and onboard UFS storage.
> 
> Further information: https://radxa.com/products/fogwise/airbox-q900/
> 
> Functionality has been tested and confirmed working via an Armbian
> Debian Trixie build.
> 
> Signed-off-by: Mecid Urganci <mecid@mecomediagroup.de>
> Made-with: Cursor
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |    1 +
>   .../dts/qcom/qcs9075-radxa-airbox-q900.dts    | 1012 +++++++++++++++++
>   2 files changed, 1013 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/qcs9075-radxa-airbox-q900.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index a4dc9e8b2d25..c8b7dd67806d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -180,6 +180,7 @@ qcs8300-ride-el2-dtbs := qcs8300-ride.dtb monaco-el2.dtbo
>   
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride-el2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9075-radxa-airbox-q900.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
>   
> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-radxa-airbox-q900.dts b/arch/arm64/boot/dts/qcom/qcs9075-radxa-airbox-q900.dts
> new file mode 100644
> index 000000000000..8b5202b527cb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs9075-radxa-airbox-q900.dts
> @@ -0,0 +1,1012 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026 Mecid Urganci
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "lemans.dtsi"
> +#include "lemans-pmics.dtsi"
> +
> +/ {
> +	model = "Radxa AIRbox Q900";

The radxa pages shows "Radxa Fogwise® AIRbox Q900", why did you drop Fogwise ?

> +	compatible = "radxa,airbox-q900", "qcom,qcs9075", "qcom,sa8775p";
> +

<snip>

> +
> +	dp0-connector {
> +		compatible = "dp-connector";
> +		label = "eDP0";
> +		type = "full-size";
> +
> +		port {
> +			dp0_connector_in: endpoint {
> +				remote-endpoint = <&mdss0_dp0_out>;
> +			};
> +		};

The device has an HDMI output, and this is probably provided by a DP to HDMI IC,
please represent it here.

> +	};
> +};
> +

<snip>

> +};
> +
> +/ {
> +	thermal-zones {
> +		cpu-0-0-0-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +
> +			trips {
> +				fan_on: fan-on {
> +					temperature = <40000>;
> +					hysteresis = <5000>;
> +					type = "active";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map-fan {
> +					trip = <&fan_on>;
> +					cooling-device = <&fan0 1 1>;
> +				};
> +			};
> +		};
> +	};

So the fan only cools the cpu0 ?? not the gpu ?

Neil

> +};


