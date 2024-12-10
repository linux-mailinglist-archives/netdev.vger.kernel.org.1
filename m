Return-Path: <netdev+bounces-150836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7101B9EBB3E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74977166D00
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8E22B5A2;
	Tue, 10 Dec 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Z5meC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166022B584;
	Tue, 10 Dec 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864151; cv=none; b=Etu/mh8l/esLBzB2PJ2ZM0BNrptjbqPrne5X9WLHk4m+uT/x5jYFcpMeaCDJ3r1i60Mtj7weIrNib6AXEYM+mynaNtthPpko6rF0okobRo+NAR/Tq8BHDTz+JERoE4iPwS7v20yvNdJYatoNKkSdC7vzg8ih3bWb/RNnIWdevUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864151; c=relaxed/simple;
	bh=Mukv+uRVidCOZjnT7rieh/XLXa2zNO6xq7n5KzR14Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meNCtLiPMP4aTwJeQAewhI8wW3b2gI1aKXziCJQFzAj0bnwfniyDjuLUWOHyf9bG4p08iHyFCyAQx0z8KTSW5wHJUgosoyWohm4TfmnaPb1SChfrBK/QSmmgu9VYwSakceZeTXeNOdMSpyRDvpeHcPUuFADTAWDQPJkBLgotBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5Z5meC0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434f398a171so2714975e9.2;
        Tue, 10 Dec 2024 12:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864148; x=1734468948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03lzIWbBgrYztWCtWT8WxjDnlzcQKSOSZ3z9Gh8bKUs=;
        b=I5Z5meC0+VnX19uNIqumZfKH5dbcFz3V8ZByVtDX2yEO2kdsIxR62txAlf70EVytJW
         As6XoVXhxxuw9sqPK/8DzK1HQZ142KSjrBD7HMvCjAJunuQfzktD/kjKSaiVl18MBCku
         jKv432syzgNtBEjXrZlGW0Hkbh4eouod/zSxWBDiI76wwh/BkG5mw37irl6jjt9bEUUD
         HCb/X92KyFUmxTLg/RofTDJh5Rzp+hgR7b6JD+2uzBf++2+0/Vmc1vJvyqj73gHwE80b
         t34iyBdn3RFR0xWL7hiGrvXAbxRn0O81DsdU8QZIPK78hXEtrq876NzSxg4ZuTFgdAwZ
         xDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864148; x=1734468948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03lzIWbBgrYztWCtWT8WxjDnlzcQKSOSZ3z9Gh8bKUs=;
        b=MmjIxSMvY2U1C9iov43jAiKi6xIBn/SQ0zx0lsGGkn8oKhlmMYz+o8h414yfyOxiEN
         v4Gc6ZLtGwn2uFgVpfrxHB8PV1EgT27LtesW8DNU6QrE0lscLi5j6l5pl6zNzJFBW6Tm
         /f6k2SlhcGW/nEK/nyxVHigmoAebKJKTxHTUTWj7gQjl3qANNHhdOOTLR4dfMqgI9Uzx
         n0U1mRBB4LI8O73bUQns3GU5WjnyXC4m9dFteacsNCDzYQ6Wi901uL51Yv/5JDEaV9vY
         DJdgXxYyrasTO7ll+qogabr6tKUhR9E3OlP5vhOUXOFx9cHaprusZYLrgbXQP9cjBc47
         v+jA==
X-Forwarded-Encrypted: i=1; AJvYcCUCj1fc6v+P6aUiY8q3ZxC/HLfac197n0RhAoPbWLIOuHqVz0qbJn7mNjoOOpCpysSND4gs2zdlkBXfcZIj@vger.kernel.org, AJvYcCV8KB26lyQxlf0MPPdJqpXgVfndircFcqvZ+9uh2/5OowOzGcPLAT5FIQv9y8xs8BpOcvYgM+fA@vger.kernel.org, AJvYcCWXJ5FlNBMCDzcC0oiRY4VRxxoOXnLe6werFMf6pq8HANG6+48jDeayiymbbMfr6AoEne5TURQIwQsE@vger.kernel.org
X-Gm-Message-State: AOJu0YxvK5OZf/5Waiz9iEWFd70jL9r5onTdHdPH7o3+cH+jhMKlSuBM
	RuFpMR7M9lJE4aQMnOMmgKnkMBtnHUEHSiZDkbyxm2Ldb/RhfHvU
X-Gm-Gg: ASbGncuHm22zn+VVvL2uITk+dqgbupEfOMQ2zujM6AmhE/JRxwD73WNI/J1XHNqG5fx
	WpUIj0G+inH8wou51vLz/f42DTpIaU/ElXjxtvjj1UIFGWulkqL3/mJZUTddoPG/PMUzJOo6kYv
	EJgVrhGMTqIGlcMwcwJIbCnhRN5TP47Z/NOUxhRf7i8B7ExXwimAX48kgA7TwoUPuhY1wBIHUec
	wOI0eT8SFffxkKKy+jWTfwZTcYLNnIOzEToOJeXAQ==
X-Google-Smtp-Source: AGHT+IEiD+5cl0JJRHM/3eDcF6jZsi6IQoeOt4l+BoieBmFnyEFAFnP/YYrof8zR3fpaQjM0J7r5Gg==
X-Received: by 2002:a05:600c:3541:b0:434:f30e:fd7c with SMTP id 5b1f17b1804b1-4361c4238e9mr616715e9.9.1733864147857;
        Tue, 10 Dec 2024 12:55:47 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526ac03sm245511785e9.4.2024.12.10.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:55:47 -0800 (PST)
Date: Tue, 10 Dec 2024 22:55:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 4/9] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
Message-ID: <20241210205544.g6y7vcyekyfebkoo@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-5-ansuelsmth@gmail.com>
 <20241209134459.27110-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-5-ansuelsmth@gmail.com>
 <20241209134459.27110-5-ansuelsmth@gmail.com>

On Mon, Dec 09, 2024 at 02:44:21PM +0100, Christian Marangi wrote:
> +properties:
> +  compatible:
> +    const: airoha,an8855-mfd

After assisting dt-binding reviews in the past, I get the impression
that "mfd" in a compatible string name is not going to be accepted.
The bindings should be OS-independent, MFD is a Linux implementation.
In principle this could be just "airoha,an8855" for the entire SoC.

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mfd@1 {

And the node name could be just "soc@1".

> +            compatible = "airoha,an8855-mfd";
> +            reg = <1>;
> +
> +            efuse {
...
> +            };
> +
> +            ethernet-switch {
...
> +            };
> +
> +            mdio {
...
> +            };
> +        };
> +    };

I hope it's not mandatory to duplicate in the example also the bindings
of the children, especially since you link to their own schemas.

