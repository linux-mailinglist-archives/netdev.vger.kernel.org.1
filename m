Return-Path: <netdev+bounces-46038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE2D7E0FEF
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6BB28145F
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99618C13C;
	Sat,  4 Nov 2023 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wPc6SAdO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6ABE6C
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 14:37:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D441194;
	Sat,  4 Nov 2023 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l8mmV4gmP9xOvUkDg9Vq1tdSD8CwyMqEbz/ZFux3m5o=; b=wPc6SAdOG5dS9SxpEOMlfCr/N5
	Np/SfR6Fboau0RZv1mp9ROt1iM5GVkMARST2VMySjGDCzbREbbUsm/WGu1amA7b8DjJ27k+wjq5ZS
	bhy96f5f72WlSDAgAfos33UPd2aSZ5SDUF8zW+ay7D8BYBS8aQ4ku9Yx58yhXoScCCqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzHli-000sL5-1L; Sat, 04 Nov 2023 15:36:58 +0100
Date: Sat, 4 Nov 2023 15:36:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] net: ethernet: cortina: Fix MTU max setting
Message-ID: <11cf3d6f-91fc-41bb-b780-1d967f388981@lunn.ch>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-1-9c5513f22f33@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-gemini-largeframe-fix-v1-1-9c5513f22f33@linaro.org>

> +	if (mtu > MTU_SIZE_BIT_MASK) {
> +		netdev_err(netdev, "%s: MTU too big, max size 2047 bytes, capped\n", __func__);
> +		mtu = MTU_SIZE_BIT_MASK;
> +	}

So this should not actually happen. If it does, some protocol above is
ignoring the MTU. And if that happens, you are going to spam the log
at line rate.

Packets which are truncated are also pretty useless. They are likely
to be dropped by the receiver when the CRC fails. So i would suggest
drop them here, and increment a counter.

>  #define SOF_EOF_BIT_MASK	0x3fffffff
> -#define SOF_BIT			0x80000000
> -#define EOF_BIT			0x40000000
> -#define EOFIE_BIT		BIT(29)
> -#define MTU_SIZE_BIT_MASK	0x1fff
> +#define SOF_BIT			BIT(31) /* Start of Frame */
> +#define EOF_BIT			BIT(30) /* End of Frame */
> +#define EOFIE_BIT		BIT(29) /* End of Frame Interrupt Enable */
> +#define MTU_SIZE_BIT_MASK	0x7ff /* Max MTU 2047 bytes */

Apart from the MTU_SIZE_BIT_MASK, this looks mostly unrelated.


    Andrew

---
pw-bot: cr

