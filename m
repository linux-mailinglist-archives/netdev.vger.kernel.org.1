Return-Path: <netdev+bounces-170312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF97A481B1
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD68F3AEB18
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95109235BF8;
	Thu, 27 Feb 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tso3/GXM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848932376E4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667138; cv=none; b=q1EgUIyUA37kP3o0BB0cG5WYQ3sqIq4aAaZSarJPDw184ZJWmXbT6Q1Po/VeuLpF1IDbVqsCUNlDNtzzGdb7M/F1G1CLZJ2hff0dM2TuwsmLaDzB/pF1RLlJnO/8q6afEdIdIKUzod6ezGpSsYXjfRNxQ0/2MGyuLeC12grED/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667138; c=relaxed/simple;
	bh=MVhhK9ChVthnbijgWf1bB4x4JswF9Qgxd89oKFnXags=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DxyB7BFVSKdrgsXtN/BRy5SmcqGkyH7AIlQ31FWFSMqcs/KTJX4pEqffjT7C3sZ6Iw/CaTNvzJb07BYU35JDsE3syWtbQOxfzFD8V43o09JvPOT4AAveCTArj2VZ2lQhkFTJ+PCRGWaZrjh1PRTNvtM0eBUEh3LuB1QLW9VIhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tso3/GXM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so10452005e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740667135; x=1741271935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDcODo9ERLNHFPyFhG+ldH6uGhEwuHVDSakPGts/Q/0=;
        b=Tso3/GXM57QDLZW/9AQOKWL8oGkGVAOfmK21prpCN/4QQwvQFPYeA6qjN/DczVE55+
         9wFsn3MOPl5dGsUadc5+eBGq/dOLJ8gsVUgHcoc01r+KmOTqhkV7CfO+np0PHaegElAw
         +2qkO650z9djk01MPk5RIwMmCCcwb6XxU+B0VT/jdpRXTLDHN3xeYBBhCzGC9pA3xOLu
         D7wrprp6erb9phopPWu9KuTqQhPpw4cH4zhCgdX01s9XximhbE2nOrT6X+pWa4tPwbtT
         d2+d8rrFv6zbKfwJXhb5VC7aA4sO4c1LBZlxglxLv+aPOavuUb5GpAMNmB0ESWvCq/PP
         DB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667135; x=1741271935;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gDcODo9ERLNHFPyFhG+ldH6uGhEwuHVDSakPGts/Q/0=;
        b=IU2zThvDN5m5gMiFgl6nqKnHlluE+v4a0xu7WqnI1Va85OFQBlgr/RwZoeQusDiNcu
         QvHWN1wKkmLmt5zhaNDdtVkmcbUhDunTNEnpS1YYHMqiJ1C3515BdtluubsgYQTRaB3q
         q5MXC4C8eijbMYOCEwhoEkPa2TAGASBZnipSZzS4RN88qLk4SQJLPPtZZQqDpW399Tnd
         fBbkaJUrP0CG2lA+VHiqoser/NiEo6hHTTNZSiHhOeT0cJ8k2jBolw5NdDzgIINlKJBY
         OcKs7EG7VQCjbjm9CM2NyCw7Vq31ptoDkEtm56QV/wUXQjxj9WsRr6Pg1utIIll2B4Ow
         aung==
X-Forwarded-Encrypted: i=1; AJvYcCV5Dx1AkhHWFQQ1k0T744PFs3+j6voPhanHzo99SyhMGE25pXGcNEBSgqgGFA49FOBVPPuecH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXmQN7Nm5bPIWHS28i8Vh/HcH8c9wo14uQ9On5ULsEdicsIgE
	ezIfAowwMhP6FwbJCaomxX3rbqgSID0XVqNjrwkmNLKmer6QV8rh8fDXn8DojsA=
X-Gm-Gg: ASbGncv8b2mjPHMN//uy1GzFM7AJ8WoWt6gl4OLg5lgQcVIo68eMLeCy9EeDy4Qq9Wa
	xzN/3ECV8yU01Yl2Ri0+no9O9XAqZu67HW4wF1l9nRiLNPan7qhoYIpKWWlETeAba+pTrl7RoS9
	wIUtlrUSUmQiQKqWGFHlQ/avMGwmw65BkjdDaTNA3cqfEGGzIsH3PW6busZ7hsFvuetWFRAnm+k
	GoLqB/0+XxtjhMv+jFCZIz6ZNjPk3oOvC2HZarDFqhpK0/5yOZZ6TvHD4IyC7f10AxoOwoS52mX
	JGOh3fzJ8rqSXfwpfc3+TJKJrIrCYnbeaEnrEdD4btUH6zQu/4AJ2wK+rTsh2xYv+tVZP0VOQ4C
	BRpA=
X-Google-Smtp-Source: AGHT+IGglvD0BjLjUSReKQ3M4zIhgXtSEWvSxDygsXG0F96YWhydQ0BMAYxWezFgG1DgXlMFXIW6VA==
X-Received: by 2002:a05:6000:1541:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-38f70825febmr20148963f8f.42.1740667134786;
        Thu, 27 Feb 2025 06:38:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958? ([2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58713bsm59521635e9.34.2025.02.27.06.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 06:38:54 -0800 (PST)
Message-ID: <f21edb2c-e49d-4448-a25d-fb75f44c902a@linaro.org>
Date: Thu, 27 Feb 2025 15:38:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH net-next 10/11] net: stmmac: meson: switch to use
 set_clk_tx_rate() hook
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0z-0052tN-O1@rmk-PC.armlinux.org.uk>
 <2198e689-ed38-4842-9964-dca42468088a@linaro.org>
 <Z8B4OSbY954Zy37S@shell.armlinux.org.uk>
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
In-Reply-To: <Z8B4OSbY954Zy37S@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2025 15:35, Russell King (Oracle) wrote:
> On Thu, Feb 27, 2025 at 03:18:22PM +0100, Neil Armstrong wrote:
>> Hi,
>>
>> On 27/02/2025 10:17, Russell King (Oracle) wrote:
>>> Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
>>> manage the transmit clock.
>>>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>> ---
>>>    drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 9 ++++++---
>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
>>> index b115b7873cef..07c504d07604 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
>>> @@ -22,9 +22,10 @@ struct meson_dwmac {
>>>    	void __iomem	*reg;
>>>    };
>>> -static void meson6_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
>>> +static int meson6_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
>>> +					phy_interface_t interface, int speed)
>>
>> You can keep priv as first argument name and remove the next changes
> 
> I *can* but I don't want to. Inside the bulk of the stmmac driver,
> "priv" is used with struct stmmac_priv. "plat_dat" is used with
> struct plat_stmmacenet_data.

Right, it's still an unrelated change in this case.

> 
> Having different parts of the driver use the same local variable
> name for different structures is confusing, and has already lead to
> errors. Consistency is key. This is called "bsp_priv" in
> struct plat_stmmacenet_data, and therefore it should be referred to
> as "bsp_priv".
> 
> I am not yet going to be doing a big rename, but it *will* come in
> time.
> 

Doing it in a big rename patch would be much better indeed.

Neil

