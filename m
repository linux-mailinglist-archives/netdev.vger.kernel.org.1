Return-Path: <netdev+bounces-53904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA9F8052C8
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E7D1C20748
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CFA69798;
	Tue,  5 Dec 2023 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBLZAOhr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEE230C2;
	Tue,  5 Dec 2023 03:25:02 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9fc0b84d0so30993871fa.0;
        Tue, 05 Dec 2023 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701775472; x=1702380272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQQyxGUKk4pbCHDpcs6JlELv+pOGJjJC9lYpip2lfKM=;
        b=PBLZAOhrWtiXt3vkeGSG4M8uPM09Xxf2V+qgz2CdCpLOoFOHYtj8IcB24uEQEj6sVl
         fTImgtnmvAz+vfe7d1X0w7LloS0fKtLzU047CFrmK5Gm++qRMprK34nosmxM30aoUC+G
         KbeM5+BGvn8OTYOlU8weVjakCWenzUHanZRtNlsfPEgfq7dsDjPiMJiTwO6mRlMmsb28
         w3H9aXsRamph5Z16gZ0jutNGcsbi1hmFPX0r2g63rM5vMN8e4OuS8+D00AevHSRKIXmh
         WHlqNaYl34Ijb7Ko+SeuJ0rBy2QqwKFxFNgCjUXZATDPd+2qVwpfY3+vloAzePpOIyh1
         Cgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775472; x=1702380272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQQyxGUKk4pbCHDpcs6JlELv+pOGJjJC9lYpip2lfKM=;
        b=CHWo1PTqtQh9vIgfWvtOWjLB1+Rc6h48SqUrAi6UpRJb4CJ2KMVdrvMuYH+9Jj8J6d
         pHMt8A24JrRoVfPjqiFOK79yARD5CrYbc1hmwsBTx3JXwYe1Dg3PFl2WCgZ+k8xC8qjG
         iPtVlw3FZEB2KwIIQHhni6TLNTwsZMww3YT67EfKrWWej7e9icRIwYJOrLz/k5KoOkac
         1SJBolQ2LE7XeNeqmtS8/qjxI2QiH2vpXTMOS2jQ3PIzgzoXxh1ntIAzIjr4Rkb7Q/Bk
         3L0T3ptveQ6C3h2PoHhMKMiFC/W6pfnpoYF854GpsHuvwwSUNIYuDq4HIGjPoKkJoT3+
         3f4Q==
X-Gm-Message-State: AOJu0YyoWXV+Y9sBDmGbDf73vewcQdIkQQsDz6gD75zFdhofEayqmrRy
	60NmWVg8Y2SUgE5zj+9fytE=
X-Google-Smtp-Source: AGHT+IEMbJi9JfgwJmbW7rz+XhmNZMSh11Xumx4Y4u6mllkJx9Vg0PTHAe8th3MAn+PEuygze2apvA==
X-Received: by 2002:a2e:9284:0:b0:2c9:cf94:94bc with SMTP id d4-20020a2e9284000000b002c9cf9494bcmr3021288ljh.33.1701775471899;
        Tue, 05 Dec 2023 03:24:31 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id x12-20020a170906298c00b00a1cbb055575sm412662eje.180.2023.12.05.03.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:24:31 -0800 (PST)
Date: Tue, 5 Dec 2023 13:24:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/16] net: pcs: xpcs: Drop sentinel entry from
 2500basex ifaces list
Message-ID: <20231205112429.bp6lpvj4klrfrrim@skbuf>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-2-fancer.lancer@gmail.com>

On Tue, Dec 05, 2023 at 01:35:22PM +0300, Serge Semin wrote:
> There are currently two methods (xpcs_find_compat() and
> xpcs_get_interfaces()) defined in the driver which loop over the available
> interfaces. All of them rely on the xpcs_compat.num_interfaces field value
> to get the number of interfaces. That field is initialized with the
> ARRAY_SIZE(xpcs_*_interfaces) macro function call. Thus the interface
> arrays are supposed to be filled with actual interface IDs and there is no
> need in the dummy terminating ID placed at the end of the arrays. Let's
> drop the redundant PHY_INTERFACE_MODE_MAX entry from the
> xpcs_2500basex_interfaces list and the redundant
> PHY_INTERFACE_MODE_MAX-based conditional statement from the
> xpcs_get_interfaces() method then.

It would help the readability of the commit message if you would split
it into multiple paragraphs.

> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

