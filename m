Return-Path: <netdev+bounces-52239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667A7FDF41
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA116282DF8
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812D5CD2C;
	Wed, 29 Nov 2023 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld5mcOvI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B5110F;
	Wed, 29 Nov 2023 10:23:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54a94e68fb1so2366369a12.0;
        Wed, 29 Nov 2023 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701282208; x=1701887008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBk9RWTGtybQBnZdwk7uTpApL8BNGWRqbVDJ7guUN4o=;
        b=ld5mcOvI/V8IlUGsHcRz2BLmLIsLCQNFexQwYpSFle+KKiFZWKjFj/uevMOxKnRnGL
         QCJ7KaxDNkz4KG10WnScBjVKaGYD7zPesIoQ3EvQX+e0EKCCSTzr3id8YPL2EYlLdykJ
         BkFSFGfnNF4SGhHYn0brr4CxdUSv8CiM9h527FRPTLBrzs3fpVyMxzVrorjWal5WqGM9
         KM6rS6DmIYvFeFwSJYyEy5941dMztGOF9SL40R0s5Y2I3jKmt8qQ8DxKT7pJg/FIo05R
         PXQRXjD0jbUTIqHmOKQHmOh5TWs0Wmyou5CyTsyao0sWFYT4iKYFLGbGiTNBxrEQ3l8/
         noQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701282208; x=1701887008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBk9RWTGtybQBnZdwk7uTpApL8BNGWRqbVDJ7guUN4o=;
        b=jCH1BfhvCpaPZSZrKQ09FxPpkC1FZlufO6iPx1xOkkx2z9x1zZ3huota/0OU9+ZyPA
         8fOH3kN1P/ig55qEsaFaIf2znHaPVbrz+gswG0ZAHGMmxZWV6kcPkWfHpfxaxiInF46g
         5T5BwINUvuwgzhGACsZrR1ok8Mynu58FgUGaDRP/mzKgquyzJzXQ9u4V9kW35lA2ICYI
         aVK6tE42KBY+ie0uyQe+pQ8ritEZlFQzvvYdIO/CkaFfMybQ9RLwwejbD013Fq4drqSU
         JLebhwO8ELjzdHP9+bk7H5ZMHYcOM3dylsKD4r6oAzJo9JPvwJw7F3Xovb5kuAIL4xVd
         ybEA==
X-Gm-Message-State: AOJu0YwXfDTwyzj0Qr2DUHrtp3Z7aNX+v1C2n5r/CQgohHAgCbDpwerQ
	ZI3qZTPkKPOUKY1gV5p9zlI=
X-Google-Smtp-Source: AGHT+IGbd5qR+tNHT+aJl0aEmuhst0ERQVGJISYgcTPL1Zmk5O33YLInE2cB/rvSN5HRBtPOgNav6g==
X-Received: by 2002:a17:906:74dc:b0:a17:89f4:72b2 with SMTP id z28-20020a17090674dc00b00a1789f472b2mr2198125ejl.25.1701282208626;
        Wed, 29 Nov 2023 10:23:28 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id my47-20020a1709065a6f00b009920a690cd9sm8217780ejc.59.2023.11.29.10.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:23:27 -0800 (PST)
Date: Wed, 29 Nov 2023 20:23:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next v8 3/9] ARM: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231129182324.jegdmss7qsxt4q3g@skbuf>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-3-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-3-50688741691b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-3-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-3-50688741691b@linaro.org>

On Tue, Nov 14, 2023 at 12:35:58AM +0100, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be ethernet-switch@0.
> - The ports node should be named ethernet-ports
> - The ethernet-ports node should have port@0 etc children, no
>   plural "ports" in the children.
> - Ports should be named ethernet-port@0 etc
> - PHYs should be named ethernet-phy@0 etc
> 
> This serves as an example of fixes needed for introducing a
> schema for the bindings, but the patch can simply be applied.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

