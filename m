Return-Path: <netdev+bounces-110264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3D92BAF6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC301C21DFE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684D15F314;
	Tue,  9 Jul 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQLI7saQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B20158D8C
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531495; cv=none; b=eGIWENYNCNLz3DnefpC7MNVpnuoF10z4WIIKzns3f+TVcctU0B8qqy1zSRtQFmrhNTwM/wtAwVLmwF4gAP6s+OfLXHP9SMoma915fGMeLhavSq7tRc/5wKTuH9sxwZiyEcSb4Zw0UV/qnPU10WQTCr22cckReGGJmYMe61OdE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531495; c=relaxed/simple;
	bh=l1YhVUnA2g8U2yZ3cKW4A0UuZXyhzOiz4ezIV37dn9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XL5vVadm1ie9eqHG12DMn1nZFe6ro0hVidPe8HdNnFRx4XH2HWccPfuiNRTuQQFC0LrX+ivky79r6P57h01h07FJ4f0Vga1gy4dgINJ8Uzf4O71qB9gW234zfzmlfzZwyuybEiIP09sToTAbL1ia6adM8ilk8LE6LUDKe6ZIrj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQLI7saQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso23663065e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720531492; x=1721136292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9DV3ap4mOBjZrqFkxUZqvRj1Amf1Vr1xrGFCMN1gAU=;
        b=FQLI7saQSS8Y612ME6dr9/SI388XjDMhNCHBuR6euBLv5tkzBcbMnc8N09UnVaNkHB
         ooRYkK4I6es7OR7VYU5qeHwtYre3aP4qv0tHwenntPnLUMjBn0h0B+cpMIGxXW804wFO
         7ihRMRuMwJbektsaXwAo81QkXp2S8SpnmjS9S5+0FsXPEUm3MEEIPVLnNC8LQjz2SaTr
         3lBw0XfLSQc4Y+37yCIx57n9tPQfJW2af8O4Qh/99S9kdWnA/Hp8uAIIP1qAYZE967mm
         gm0MqErCBAdyOavJRe1StuQ54ojamxNzk23yjrZUZ8vS7bbuvA75U44aBaqwbYw+1DUS
         P/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720531492; x=1721136292;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a9DV3ap4mOBjZrqFkxUZqvRj1Amf1Vr1xrGFCMN1gAU=;
        b=aIogtU+JfV5nB0tax1NecpacKM1/hQXLQvDm+Me0rmlc1McixTvhtyv04bh0M6+gCj
         Wo467MPq4Km9GnivgjjgB7IhoFc/D2wGK834WYwLsQNn40/216QOWMvq1MLdZXzPtrk9
         CJrGG1JSSxfrmJ9IfADrYb0XmGOfh2wAUoqVJ7YwQBCh+Oc0DxcUQtYUv7ZmlA9Gigva
         HNZMBT8Eh/ISr7RYqC4QVus9PwM+yggnFqSYy60Um+9+sI9dMxlK2PHFLA2uKw4jFhTV
         gG8kBDHp+Ntz27Cxq66NlMa1ICtUA6TpaxE6daHJddQxera90ruAac1DmSdAG+bBn6fB
         kFeg==
X-Forwarded-Encrypted: i=1; AJvYcCWWP1n6G1G8XiFKkK02lMjzsZmloQuoqPVAjrme27EbWFufU9ZU0ZpEv4rkthb6qyETLU/WZZC2KQzNhCNdvRzGYSUQUBqM
X-Gm-Message-State: AOJu0YzRBD/VCikTplnseNTqyllPLD7fjiCUduRbIxBAdi4kj/jeDMdu
	ouQJyGr1CproWN5SZ8qK99iuCYbmkpvjmWu/04M/b2M5CndU1KaDjLMx1HwPXFs=
X-Google-Smtp-Source: AGHT+IHZZYmLZWy+LpSljew8ozWWmPOpw/Lkp/TKeE18DSer88Pw1iWgQ2+5bRFhAbdnfp2SrvIBCQ==
X-Received: by 2002:a7b:cc97:0:b0:426:5d63:24c4 with SMTP id 5b1f17b1804b1-426708f1dcamr17063055e9.27.1720531491679;
        Tue, 09 Jul 2024 06:24:51 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:133f:fb1b:7fc5:f63a:ac6f:62c6? ([2a0d:e487:133f:fb1b:7fc5:f63a:ac6f:62c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426740d9a75sm13478995e9.1.2024.07.09.06.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 06:24:51 -0700 (PDT)
Message-ID: <96a79d97-532f-4467-a564-c7aebd5a2ca3@linaro.org>
Date: Tue, 9 Jul 2024 15:24:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/6] Bluetooth: hci_qca: use the power sequencer for
 wcn7850
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org>
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
In-Reply-To: <20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 14:18, Bartosz Golaszewski wrote:
> The following series extend the usage of the power sequencing subsystem
> in the hci_qca driver.
> 
> The end goal is to convert the entire driver to be exclusively pwrseq-based
> and simplify it in the process. However due to a large number of users we
> need to be careful and consider every case separately.
> 
> Right now the only model that fully uses the power sequencer is QCA6390 on
> the RB5 board. The next steps are enabling pwrseq for Bluetooth on sm8650
> and the X13s laptop. To that end we need to make wcn7850 and wcn6855 aware
> of the power sequencing but also keep backward compatibility with older
> device trees.
> 
> This series contains changes to mainline DT bindings for wcn7850, some
> refactoring of the hci_qca driver, making pwrseq the default for the two
> models mentioned above and finally modifies the device-tree for sm8650-qrd
> to correctly represent the way the Bluetooth module is powered.
> 
> I made the last patch part of this series as it has a run-time dependency
> on previous changes in it and bluetooth support on the board will break
> without them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes in v3:
> - Add a missing break in a switch case
> - Link to v2: https://lore.kernel.org/r/20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org
> 
> Changes in v2:
> - Fix a switch issue reported by the test bot
> - Link to v1: https://lore.kernel.org/r/20240705-hci_qca_refactor-v1-0-e2442121c13e@linaro.org
> 
> ---
> Bartosz Golaszewski (6):
>        dt-bindings: bluetooth: qualcomm: describe the inputs from PMU for wcn7850
>        Bluetooth: hci_qca: schedule a devm action for disabling the clock
>        Bluetooth: hci_qca: unduplicate calls to hci_uart_register_device()
>        Bluetooth: hci_qca: make pwrseq calls the default if available
>        Bluetooth: hci_qca: use the power sequencer for wcn7850 and wcn6855
>        arm64: dts: qcom: sm8650-qrd: use the PMU to power up bluetooth
> 
>   .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 18 +++--
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts            | 28 +++----
>   drivers/bluetooth/hci_qca.c                        | 87 +++++++++++++---------
>   3 files changed, 72 insertions(+), 61 deletions(-)
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240704-hci_qca_refactor-0770e9931fb4
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Still works on SM8550-QRD, and properly works with power sequencer on SM8650-QRD

Thanks,
Neil


