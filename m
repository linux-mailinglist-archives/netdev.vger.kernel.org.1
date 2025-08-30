Return-Path: <netdev+bounces-218484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A3B3CA22
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 12:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A281B222B3
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494FC274B53;
	Sat, 30 Aug 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOpg/OGb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCE2749E2;
	Sat, 30 Aug 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549579; cv=none; b=WfS93Ucq5Wbwmy5yNDRbQFe08OFZNGRg2wAIIZeJUeftlkynZd/FkrVH8TkQ09Kv/gKlCBHPP8/MsxpARE/kLMjjnGlpljqEE6NwTJnzk6G95wu7MQfCx9oYnVNRhOLyPlEWD2OHI6JfViz2iVZZrBVPuj+i9SB8+0mYuJiACpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549579; c=relaxed/simple;
	bh=jLuGCcE4TiC7yL+c1hFI1DN93NdtSUJpTnLR8tAgg5k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RnHnJMhsS7TQSHUXQq7hcYy/DkbmIqh/5AsvgXrcRhJU+NhgMUuGI/A1gFmweN0FsklgrTOsCdZbLsnKN3RSgcdVb1o/xj0qj15JJObm4f+Y7Fc/ZWN2R+fQMBnZvXuydMDtlvQFQ1W2eQyuJwSi24hf1XQPrzSrv43mBxer3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOpg/OGb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso259045f8f.0;
        Sat, 30 Aug 2025 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756549576; x=1757154376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bEwm3goWEKjvfNy6RAUrtv/iztXuHjnaHOxeoayWGo=;
        b=eOpg/OGb01aT0ga/F0kJ+WTptX2H6fuhxNOFJW36XQYJQi/dDaYEO8HPBfxUnpDiUK
         Ut4cEDQc+rX11300xIEf1vqX5OSHlyMT0hpQ/FjgskCSFfvyy38m2mtxAp19bNhX1Uqp
         rUW2GQxl2co/i/OWpbh6szqMElvyli41/au99iOquOG32+L6pEKwDUC+qbJRbM0Yoo1R
         VNrNGA3UWczHL0SIiB7IlJD7wRFYJhQxTvOlaSGwC2zwgq+X7wGzO/nz5r5zYm1ceXNe
         ZYO2n0m/lYOgrPnM3o5aCPe+ji/8ksXWkCYtXWWZtCp/M8H9mGPG3AXbuTF0Wv00SRns
         XGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549576; x=1757154376;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bEwm3goWEKjvfNy6RAUrtv/iztXuHjnaHOxeoayWGo=;
        b=RdFSGuWBNuyaxXJxpvSkIln5CB0+61YJjCfpfR577Ajepoa9n2gQ0nWe+6Fe5P8Ow4
         rs13meZbBKFdDFHQuei9MpKT6lIbBvXRW+z5ZH0rAbhtzaz0f3RloBwG+wWQ3uXbjLof
         eAs0zQvXfkL0SnLPGOon199j8gk4fkYR72PMIlPXNA26XY6xa1W6L5NIzlgERMnXhVGB
         te2x90yfc0yHQb6Es0ff60wmJP3GoxibLTHVICW7RGBBAtytS+Dd3LvGEKEYCZrmJSQZ
         trPDd+6pX2OsodVtdD3DxTgYY5C52Eh7YkPwW+yZlt199Q6w2ubmKGX1mKfa4CVVnISy
         1yoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8JLkHjOp7QCzDpqCj+CW4z+hFLGMxirklJv0lRvmZp3ArTWMVN4hYDdx6le+dAXtnAN5YNpGl@vger.kernel.org, AJvYcCXVP31RVJ3MuLv6OakccgBmQqiM81h4kYQdnNJXNrvf9DGJijLZ8k7CyAZOx0bCSyjan6z9F/hwTvZm@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/eADDX6Jv+MURd2eBuydBTtUF7O7fWs06HNyXTlkwV09SU6i
	Rf6c/pQo0MuCab7Iw0eGWi/5sU7C4FJ8aG5Vsv3DIrtI6xnnEPL24sRn
X-Gm-Gg: ASbGncs4AT4vc2CKPS288f7+zLZYl1BD8c6HDtJB2tf0GcCjVDXaVaEcmifCuWTxc/f
	0gY9IKVEFaWRYlucQZAKkxbrNAi/uC9eFM4a3CgJ71s3SV4L61uqk/AlxjiPwvWZC675SyB02Qv
	lgYD2SWB/R40OqoCHzFxewparOG4MriSWV71vK1fRJiOgb8Z+wloyMqwU+8JjF/uw5zjiuAA4v9
	sEA2Zz6rPcmsq/TxWcMIEnsAbPm+Aq+y4JRAiKQ0H1w9hAIBBxhbVb/slDYq4GkLhjxatFEIDs8
	JdJvo2MzWV0DAkkRH/zA5p2YY1arriw4aZ40oNoTDWDgH3x1LGPGZMQTI7Old6pfZBc35PF7x9k
	45nJlPsMD2inxU4tn4emwl+n76WFssHVZ2e4vKD4dqR8l2eY2+kMDuPUpVJfkTT66TCv8+fQzQs
	7/P1PtdbcP7sDZXOIDGKVv/fn9jEOlykmRD7X6VC2urAW9wgEuBrJGBWVWJWT4V+FjE+w=
X-Google-Smtp-Source: AGHT+IESiXAPYaondigOOaobHYodOgUU55bDiY3IYU0ShHDYf19GplKbo7wficGsorW+hMbiIFY+kQ==
X-Received: by 2002:a05:6000:4605:b0:3d2:3408:3b70 with SMTP id ffacd0b85a97d-3d234083c72mr932252f8f.13.1756549575580;
        Sat, 30 Aug 2025 03:26:15 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2? (p200300ea8f2f9b00080ca2fc7bcf03a2.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf270fc34esm6767166f8f.10.2025.08.30.03.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 03:26:15 -0700 (PDT)
Message-ID: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Date: Sat, 30 Aug 2025 12:26:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/5] net: phy: remove support for deprecated
 array-style fixed-link binding
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs. See e.g. 91c1d980d601 ("Documentation: devicetree: add old
and deprecated 'fixed-link'") from 2014.

So migrate the remaining few in-kernel users of the old binding,
and remove for it.

Heiner Kallweit (5):
  arm64: dts: ls1043a-qds: switch to new fixed-link binding
  ARM: dts: ls1021a: switch to new fixed-link binding
  ARM: dts: st: switch to new fixed-link binding
  net: mdio: remove support for old fixed-link binding
  net: phy: phylink: remove support for deprecated fixed-link-binding

 arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts      |  5 +++-
 arch/arm/boot/dts/st/stih418-b2199.dts        |  5 +++-
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi       |  5 +++-
 .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  5 +++-
 drivers/net/mdio/of_mdio.c                    | 26 -------------------
 drivers/net/phy/phylink.c                     | 25 +-----------------
 6 files changed, 17 insertions(+), 54 deletions(-)

-- 
2.51.0


