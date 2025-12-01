Return-Path: <netdev+bounces-242966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F0C9788E
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84C63A84AE
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450BA311961;
	Mon,  1 Dec 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lO+COmcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A33115BD
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594502; cv=none; b=gTrE7RIlzVI6WBkFVGNA9EB10nsVOQA6IPUXASDP72gg7/SGpF2qhNkWWDPXKmWH+kfrshm26kZtgL1WxcuTI0pdvCO3raQHB0Rv0aSRJIvQicIQUeTzWEJWbTpHUz0/50gnXPwS19yqCg8K2KliO4t88YqjiL0/u86CRt0kyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594502; c=relaxed/simple;
	bh=1jljBYnLYrj5OzlfckI0vPQHKYIf0MNNW7lVPMiJMvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UTeJCTH98jAxc6aYmU5OjijYfWm3iHzI0OktiA11++AanaKfJNVY4E6v4IzgPl0PygY98b0E5gglLacBHK3sBwn6AyPpq/IPRa0ZS2IEaQJXyM9AztHUrN4Q1tKRM8BsO1tc7OC0K5Fw93apUzVPnD5G0x+6VPTlVGkXU91zYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lO+COmcK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73545723ebso822940566b.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 05:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764594499; x=1765199299; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmWOE8tsVdZV+/3MWOEyJyy+ZPffvlIHcvjJiju9iok=;
        b=lO+COmcKvnJhcrxFanTFpDbzru4ALcUnWfCnrg+XyGCRdvOv9jfwwZsQJx7i3CoU7G
         jfoT3GA8lSYP8e7R6+odB1SOzBywspxQDRGiVAErl0h4TMpBt6FH2mmiSndG75dWm+JY
         7N5YSso6MhvnEOVtIx93jnLjsWQ5LRQQ4RrYw+Lin2mWYg3QEp20sjS+/rbUJl7hPihM
         dtDsN2hSFJgE0fh/+umpEdYz3DA/IZyfhP5BWI7INgooht9X9jpAQbiPz2d1VRgaR7xE
         DaFz+29UmRZkznM/QAOwEJW5SMMnBLydRsDt1FrIVuVJrGe+ajbUsoXRjBrU4EwWhyHg
         d0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764594499; x=1765199299;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmWOE8tsVdZV+/3MWOEyJyy+ZPffvlIHcvjJiju9iok=;
        b=H32UoaUDv7Am5K/6yIywdneH9wTmh4bK2q+FyCV3RlVh4KqLUzMBUhpdzgyEhAnxfE
         MEi8gpaw/L4WewODMZFYDzJAhAQSSmfDuyq+UN4qZEZN+EHX0LKWVmZeOtD08eFMajvc
         UnIkZt0dXMMEwVS4+WhxUNczKPHIgXHp/vSHLMy8kLTEHG89BaKbJGmdWzINSysgo7HP
         BQWe8QQ202SLSC38Y0o+Pntkov8Qyrg7yPsQUDHDO3+7TpOqnZ6SFLseXTELtNjf3qN4
         538sX1ooilvnaCCHRFYuG2AA50L5lzPY1VxcUIiKFlwDlo3fZ2V2i2amhrUkuNnl9MYL
         HmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqcrt1LL4Yv2iDjNpvER/61Nh7vfUKwm29LOUq3mC+0ZiwM0iC5mn38Nf/XJRjQHhbwz5i8EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTY2XFe4oWA2W1uq9KiFbWbxz/U/OobdCcL2wwv8EATqitgwf
	TZHdZg+YBsb8CL+KYqSlVJew13TlRzF70lsLDKwQOFdnLR8IwKqmYq9chry4pRIZwp8=
X-Gm-Gg: ASbGnct4zD6VgIriwZ5P6QJzXoUEJKiUS/paB8xhmMke5e61UqlBNSJV2BGjfV8hn9D
	gfvDlRNUSItK6r8IObYxQ4QN55nm9kp6TagB6+5/3KgkMiuXN7LcRcEwj2zHXPV6xh1tbUnZ84f
	ZXI/c/4ouj7haHIXZjXEoybVdb1C/MPUjqa0wolARZwsnLVOcduSYDOuU+IbWwZYI2U+qCle8tw
	WAV3FO1DTu/u4GAFSE0Igmvn3II8YH6J1spPMM3rpQOzY1F5rybuXHKzU8rJBsi8mNZMkcbvErl
	/gAda8pCdhGw+vjcENbXWlYHSG8bFiS+64O2p6AxMS6GBOWx5HqsthbMUJ1E09svpJpz5ZFQ+aR
	WSnavDkojUXcLBh7XNn2TT/PgiE8HiMiJIBL3C2D68w9YpMPJPU6+00afK0ww7cC+9jWDMW4SMA
	8WaQ0g/iYSxKRdo/zj
X-Google-Smtp-Source: AGHT+IG+9MCSjBtPt6W2+zBUhes3WpovLtX4vLeIrokTyK95t4Xc4QrjoCg1IRxwpvpD0DbH6J0bKQ==
X-Received: by 2002:a17:907:e8c:b0:b72:eaba:aac2 with SMTP id a640c23a62f3a-b767173c3f7mr4361122366b.26.1764594498454;
        Mon, 01 Dec 2025 05:08:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76f59aecd4sm1238751566b.44.2025.12.01.05.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 05:08:17 -0800 (PST)
Date: Mon, 1 Dec 2025 16:08:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: [PATCH 0/4] s32g: Use a syscon for GPR
Message-ID: <cover.1764592300.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

*** BLURB HERE ***

Dan Carpenter (4):
  net: stmmac: s32: use the syscon interface PHY_INTF_SEL_RGMII
  dt-bindings: mfd: syscon: Document the GPR syscon for the NXP S32 SoCs
  dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
  dts: s32g: Add GPR syscon region

 .../devicetree/bindings/mfd/syscon.yaml       |  2 ++
 .../bindings/net/nxp,s32-dwmac.yaml           |  6 +++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  8 +++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  8 +++++++
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
 5 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.51.0


