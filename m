Return-Path: <netdev+bounces-153455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663EF9F80EE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179E6188C412
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF2171E7C;
	Thu, 19 Dec 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DalJcNQe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEF1537C3;
	Thu, 19 Dec 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627758; cv=none; b=r76oirKov8h7LHSc2tpBiUcJV+iaAAObw/8+XkreS5TzCF/HqZe1cQY1CyMaz7j2pVV/H/rPPzyXGwKJV1sUKRm3bIPWDq/3SGEVucjhZ6gXkAFzZ39jm/rHAW72YTSwi8HW6U97I9u7JhIHNLQqP2QQsSxoFURwN1tTiL+hdRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627758; c=relaxed/simple;
	bh=PEFphxGvGg2l4l0PN0KE0EA9RP0MzBCoenGBhETqabw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR0Qodl5hgB65cWGCgweXSYV0LWmFZP8kLCILuMUauU3QbYnn6ZXhpSBw2M0bX69e0WmauahNsTwxQTBIVa2fS64csSw8ozZX0PrNqUaxsjC+m/kQ2Ho/2wJkdIQqBc7gF9+Qciuoaq4HeL0zcSTOhvSF8AXPnOh5IMMswgoBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DalJcNQe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728e78c4d7bso835842b3a.0;
        Thu, 19 Dec 2024 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734627756; x=1735232556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0/L3yqkrFphLSLfi9k6BWAjTwMXwunYK2ocDlQzb2Y8=;
        b=DalJcNQe0rO+Gx8Wuz6GHuhv3IGS4GGdNfFR5WXtBMuH88/Mw8kodrspnIQx41HZWf
         XuHBjH5eGGkfrdV4iCeItwmiDT4Nma3djHez6B4lUpRbCGGTi0YxsBhvG/qLNhMsW5f2
         vebthKKzdlwSD1r8WD9WZ3E2Kbs2T8YYtrZM8XgknSCUzHqpijokByQF8Bl35CjO1cWQ
         h/A9pjSmczlSoAzxp1yi6+6buW7GOrbQhsbSWCGSVq/wBHGyu6mfIhJq2rVHZXlr64mB
         tEcbLS7quhkI/UXYottWq3mIr6PiDVWRdTLrZkxM+tV8O9wZoo3YLtVu+nxP8USLNfAH
         s4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627756; x=1735232556;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/L3yqkrFphLSLfi9k6BWAjTwMXwunYK2ocDlQzb2Y8=;
        b=faJVjEe2znL3TdNoCqmqUh0BisYfeQeEGS+9AbtvjN3Zh0u3HW/BkQu0y0NxIQPeH2
         K9kkmzQ10kFOEOt9X1taHGXFyGvlMqQH9Z9y+WvbFXSrfLqoSbRBlFn/dl3pQVhp2xQN
         +t2fQ5G03FX/5LERScOHGCpaxkhnjDFJTsF3ITVbvVMktG1mZTMjYGXFMnM0a+cjHipm
         a56bbEKADl2HljoDIwfk9n+k9h5E3uj91t//LEbtlDAhHUKPHJrEsF3n6BHGc/97xGP7
         Yih3bDCwyUcXKxy8vLdNoFpQTjONG3KbNm40GwC1QMP5Km/eaXgFmRMXv/tGrqIfpZXT
         ubnw==
X-Forwarded-Encrypted: i=1; AJvYcCXfUXWhyll6S/yTNgn8hRdd5NlvP8/QZGTb7v6hMxh00tekQ6iDSBxdfkia5Npv+fsT5pocbnq/gr+59mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/ucooG28iLR6wdti9T+26DUbSYnCq6CDGIQCMSVG1xhbFrU1
	8wnqjDtkEWjFXdJ/2aWoWohJ74hmuIW5q5TZBt+RTdPems0ef3Kj
X-Gm-Gg: ASbGncsmcXoyNNrlEYQIfASmZlUDaaNpFjenscUqTYr+qug5PEBrLgy8Mxdxe2UAtdT
	9Mf6Ncvd+Of4uo3nq8blXSFZ2V33hqCjvlREvpJItywdrAVfn5ZHWS/3ob6thKlmka+875Ipyju
	GWeH/g3KcMpHgQzF92mesaCeer9fYDYkm4bj+5DOtdoqAKEhBTZ5UJrc9SXxgKQzyh3APYstgvS
	I2q/OtmtokFGbf8wXJTHsiYhnHjFgwHjV30/zCz7upBSb9Thn2/4nQatbMTKwdW3cUyZkLk4mOY
	wNc+PdFh
X-Google-Smtp-Source: AGHT+IFvO/vY33BZqTQhbbTJF5eCLtVfCMylIh1R3YvZnFBh1z0Kxx8OrN4QUhUjizZ7XF0Hpji1eQ==
X-Received: by 2002:aa7:8d15:0:b0:72a:83ec:b1cb with SMTP id d2e1a72fcca58-72aa98f5b53mr5561488b3a.0.1734627755927;
        Thu, 19 Dec 2024 09:02:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd58asm1580581b3a.145.2024.12.19.09.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 09:02:31 -0800 (PST)
Message-ID: <629802cd-ddb1-4e3d-9050-612739d8f3fc@gmail.com>
Date: Thu, 19 Dec 2024 09:02:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
To: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com,
 heiko.stuebner@cherry.de, frank.li@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20241217063500.1424011-1-wei.fang@nxp.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241217063500.1424011-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 22:35, Wei Fang wrote:
> On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
> clock sources for two external KSZ PHYs. However, after closing the two
> FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
> not 0. The root cause is that since the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> external clock of KSZ PHY has been enabled when the PHY driver probes,
> and it can only be disabled when the PHY driver is removed. This causes
> the clock to continue working when the system is suspended or the network
> port is down.
> 
> Although Heiko explained in the commit message that the patch was because
> some clock suppliers need to enable the clock to get the valid clock rate
> , it seems that the simple fix is to disable the clock after getting the
> clock rate to solve the current problem. This is indeed true, but we need
> to admit that Heiko's patch has been applied for more than a year, and we
> cannot guarantee whether there are platforms that only enable rmii-ref in
> the KSZ PHY driver during this period. If this is the case, disabling
> rmii-ref will cause RMII on these platforms to not work.
> 
> Secondly, commit 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic
> ethernet-phy clock") just simply enables the generic clock permanently,
> which seems like the generic clock may only be enabled in the PHY driver.
> If we simply disable the generic clock, RMII may not work. If we keep it
> as it is, the platform using the generic clock will have the same problem
> as the i.MX6ULL platform.
> 
> To solve this problem, the clock is enabled when phy_driver::resume() is
> called, and the clock is disabled when phy_driver::suspend() is called.
> Since phy_driver::resume() and phy_driver::suspend() are not called in
> pairs, an additional clk_enable flag is added. When phy_driver::suspend()
> is called, the clock is disabled only if clk_enable is true. Conversely,
> when phy_driver::resume() is called, the clock is enabled if clk_enable
> is false.
> 
> The changes that introduced the problem were only a few lines, while the
> current fix is about a hundred lines, which seems out of proportion, but
> it is necessary because kszphy_probe() is used by multiple KSZ PHYs and
> we need to fix all of them.
> 
> Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
> Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

