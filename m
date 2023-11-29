Return-Path: <netdev+bounces-52231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF297FDF12
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D08B211B7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B225C3C0;
	Wed, 29 Nov 2023 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Viv2jJJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C34AA8;
	Wed, 29 Nov 2023 10:06:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-409299277bbso135015e9.2;
        Wed, 29 Nov 2023 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701281210; x=1701886010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WP/VskNJd0LA4E1Mk07bsXVasJaRqm4qXuSnlHideFE=;
        b=Viv2jJJ14cnHsSiQMdm1UCPNoju6w1pIshvNP6BEWSaN3RSOoa9mQyjakwA4bgBSyg
         6Mg4K1CS6Y/D/g3yaNS4mm+yFkCzz79WdiFAex+Dl8mgLPL5voskWEbOlQTDfkld2+oe
         0Edxx+M/3b9f1twkAJCtMcNfiavOOI1y+sl0cGTY8hHeoNT405g8Z2xBPGIucs6nPgsK
         9Y0IRnKlFVatmU3WncOStZK7KonitVI6hdDKL0X+F80yxO1Fv2s77Efk7a95/c1PM5vq
         uVx7EtYL5QIcx4TkqlZXodnp5DlXsJKSTqKqzVIXDL9vrDzpKfoHYy5HILkF0WDNY4if
         TybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281210; x=1701886010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP/VskNJd0LA4E1Mk07bsXVasJaRqm4qXuSnlHideFE=;
        b=sA04V7+YxfPptJlgNhhAxtcjMv/7Ylz3v7WfPsUhb4zyfHuLttBfPt5NjkBf+Qkdng
         UYKmr8LDC1O+Q4MP2RtG2xwHSzo8aJMfbDaFj6oG/JEERK+F/bLMuUoXl0T8RpZJIqZ+
         6eSEV0KV9Apyrh7kIYdxXMtwfdroJzHrDVMozyaCkkCe08a0PQPnBN+L87DjSuxeWRd9
         Epa9nd03t5f19RE6vgUIU9sfDnCcl/988fZkVoZMCIiYfr7kVNE7+MWKkn9tnBZjQJm5
         Co7B0E7erGJ/LnDG0VM1mWiIn3O+bajIPUhtNk6X9Q9GLHxI8KnNBaIWo2sN0IN0KoX/
         tXcA==
X-Gm-Message-State: AOJu0YyDfuMMclNTgB1tcUsE6MoPlk1kmEDHEyAEmLPD+buJFEY6w6AY
	ztj+gh0UYTXm1iggP8JMpLI=
X-Google-Smtp-Source: AGHT+IGCqKmEQmXCHAhNv3R9Y7f8whXFQ6c5b+m19lU3XNKj7aXxtJJZw2vSzghtWrgTqB2kFIERSg==
X-Received: by 2002:a05:600c:188a:b0:40b:5021:f057 with SMTP id x10-20020a05600c188a00b0040b5021f057mr3307729wmp.11.1701281209422;
        Wed, 29 Nov 2023 10:06:49 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0040b2b38a1fasm3101035wmq.4.2023.11.29.10.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:06:45 -0800 (PST)
Date: Wed, 29 Nov 2023 20:06:42 +0200
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
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH net-next v9 3/5] dt-bindings: net: ethernet-switch:
 Accept special variants
Message-ID: <20231129180642.q5ybndg5fp5c4udg@skbuf>
References: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>

On Mon, Nov 27, 2023 at 04:43:06PM +0100, Linus Walleij wrote:
> Accept special node naming variants for Marvell switches with
> special node names as ABI.
> 
> This is maybe not the prettiest but it avoids special-casing
> the Marvell MV88E6xxx bindings by copying a lot of generic
> binding code down into that one binding just to special-case
> these unfixable nodes.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Not great, not terrible.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

