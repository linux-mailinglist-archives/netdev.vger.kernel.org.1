Return-Path: <netdev+bounces-188486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E366AAD0EC
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0986B7B2820
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78962218EBA;
	Tue,  6 May 2025 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIGJ9WXu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3110217648;
	Tue,  6 May 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570295; cv=none; b=dUqY4/0jXH08Cf1mK6B0WZG3dD2p76mtzHpXhTUGQiUfs921fERj9LnK4RCI41Nhd4iJ9klQFb27+O/cjDVOeSXaRfq05KMX3JojsZeejimOW7lKSsY6FfxovED70Xd6LKs6G/wjB0EsBFrWS5cAtY3u4qoipZa7FAfNMpLg/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570295; c=relaxed/simple;
	bh=pGCW6+4GYSpPWrxlBu87gJhu5P8X0pt7xGbhx4iMxbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIKtHyoWxouaOwMtgqdCd4a2OJ1jRjoGhm6B0CdW+Ku5LdxyDPsgwtBYgN0AkbwJE4y3f4sgcBOSQI25uUhHfJ9jH8W9B7h+w30UpPozjekl3PDVUNFyhyfsnQhtjcdmJl0dAzdRlZhUGpv/gE9z4uC9NtIGv/KUH7Bm2QAp6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIGJ9WXu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so56614096d6.3;
        Tue, 06 May 2025 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746570293; x=1747175093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6PuN11kmLGkE9CdpXY3LsP08NiwndWR9cFcKMuKbeQ=;
        b=fIGJ9WXuBt4dCCptMl/c6244BfnFKMYMn0w8/Cj3sQkbo1RI37YFUq9XZlILkJoIUR
         7DiuFE1qwfE8xJvSHSE3NP0Sjq5J9YXxKyYo4OY39SEKHF3hyL6IbuKnatsnz8TUXiyr
         ivcDp4DSbznp03hfXoDv1JnmyP86sjzfvzm+PfWK9QhLKz8N97IwSiQhnPV3BmD7L0pE
         qd7mq1GLsOk3/v0qI4geXW4I4rMU23i79GmpCgzeCVktwqlcd633teOyFT7IWp5EQ78K
         S0kx0E801R94y7VKILiMkzJqJotg+7dIuU9zxjdej/D3fg6ZABcvqfaXl7keC0soZRCR
         rqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570293; x=1747175093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6PuN11kmLGkE9CdpXY3LsP08NiwndWR9cFcKMuKbeQ=;
        b=shK0HOSJY8597vd26oHl3IGRbE3ZqzVrqWsduSUYjFyy6GaQUSTLljjzLtOzNdOhHw
         RdU/Ek9Vcwn7vLjY6uaph6wUFt+Kzc3fJMcEw9wfHMw+WWIaLJLXFuTU7bap6EWoRTKD
         okeMMjpk1Y3FCueiLhzOUfwDIWbaALIgDKGkl+rRtGBHbUN53xXxj4Uy0kvXGujwDsoO
         QgvqmzeM+zUPsGc2WvJrFLv1zpni7gqvywGprk7mAgCKB9qUnudaT4EJOSFAZQiaRJRY
         EEGLmhS/fA/ZI5KAQWsqBIRJxJGb/Pih+on1vl1gSkovSLyhdFQmPkdM4kIRGbGW9TrD
         Fc0A==
X-Forwarded-Encrypted: i=1; AJvYcCV8t4PlSsthLPOoy1uwR6fVEplHqOV2S4sFqDdTO76C+kbIcVMhRFTydOlbnKpchKgkDLvuk1am9KNw@vger.kernel.org, AJvYcCWqUcXw8JBVEl00SLtxELtplEWPVwKswWh2Rwf+4hPhCbRWbiY28YjbdqV3KMAUt/x82EBDTKCD45axCRJl@vger.kernel.org, AJvYcCWyvK0jvpNEEzWSGYHjf7uTO/QM+OCQlcW2f7ZrZ6CScv3aT3LADjuZkAaYVtJaNmFLPVCI6AuU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FG4t9x2YE05Koh4eqbrOqg/2M355By8NgwTxqL+v2TLkGV90
	9fDBg4dxunLMPs1HXhz0dyOsrENcH0xIEM62D03KI3lb5vNsllTz
X-Gm-Gg: ASbGncuGgWQDHtwD1VkT2FLiSa5pd/iArsGUZCIAEGhb1AvZ3ESmRDPRjCBw1UZWEJA
	V9EVJZTyflKt/u7W8bJtP+KDKrb9aHskQHAzMn15HyqeMkcnRVPTSLD4mLKOi8MYvfXgQ4b/bl8
	Nxsk5nedKi9bxYYB9bH1uEgiV1Of8UHZPMLi7H7uOjCFoyLOR5k0GUuk7V34ILpvNfWbnLRaChx
	LwC6O5op4QlADBLI5amJi9dwoq1vb8nhe74EymLalo4PgL8kQ+/iRC6zUPMAPBuf1ZVkoTYdp8a
	i64QRTYT7prNEUvJ
X-Google-Smtp-Source: AGHT+IE/HcOkUaQ1OjeZ76XLCIoAMcLQ4gb8y3bZBjcdCFJTsGZuHVr3Qr8wRx0H5mUFdFynUfAxQQ==
X-Received: by 2002:ad4:5b87:0:b0:6f5:3e46:63f9 with SMTP id 6a1803df08f44-6f5429afe88mr16025426d6.7.1746570292605;
        Tue, 06 May 2025 15:24:52 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f5427b07e6sm3118126d6.106.2025.05.06.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 15:24:52 -0700 (PDT)
Date: Wed, 7 May 2025 06:24:29 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Romain Gantois <romain.gantois@bootlin.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 0/4] riscv: sophgo: Add ethernet support for
 SG2042
Message-ID: <fgao5qnim6o3gvixzl7lnftgsish6uajlia5okylxskn3nrexe@gyvgrp72jvj6>
References: <20250506093256.1107770-1-inochiama@gmail.com>
 <c7a8185e-07b7-4a62-b39b-7d1e6eec64d6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a8185e-07b7-4a62-b39b-7d1e6eec64d6@lunn.ch>

On Tue, May 06, 2025 at 02:03:18PM +0200, Andrew Lunn wrote:
> On Tue, May 06, 2025 at 05:32:50PM +0800, Inochi Amaoto wrote:
> > The ethernet controller of SG2042 is Synopsys DesignWare IP with
> > tx clock. Add device id for it.
> > 
> > This patch can only be tested on a SG2042 x4 evb board, as pioneer
> > does not expose this device.
> 
> Do you have a patch for this EVB board? Ideally there should be a user
> added at the same time as support for a device.
> 
> 	Andrew

Yes, I have one for this device. And Han Gao told me that he will send
the board patch for the evb board. So I only send the driver.
And the fragment for the evb board is likes below, I think it is kind
of trivial:

&gmac0 {
	phy-handle = <&phy0>;
	phy-mode = "rgmii-txid";
	status = "okay";

	mdio {
		phy0: phy@0 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <0>;
			reset-gpios = <&port0a 27 GPIO_ACTIVE_LOW>;
			reset-assert-us = <100000>;
			reset-deassert-us = <100000>;
		};
	};
};
 
Regards,
Inochi

