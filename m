Return-Path: <netdev+bounces-150841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0639EBB73
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A43228582A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7723024F;
	Tue, 10 Dec 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSSYuLUe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208B22FAF9;
	Tue, 10 Dec 2024 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864596; cv=none; b=EeNFLA29DtpxjHEIUIQD0SFCaJZYKICXUlsffGNZ8ESymghVw5ugJQVAgyafW5tsF747afqLv22S+DU6JalGTnVdgB6JMDltAbFbJB5RKHRysyvgYzUhgARgQ3TMrIR6JgTrMJ/hg1o7qC8bakPUuiXEo5LPY82UKu5aPiM/RZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864596; c=relaxed/simple;
	bh=df4BzORNegqiD0+TekPPqkkG3Yc2iDOz+Iuw4KrksTI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp6gSMYSjmooOfsme6GWifwKHqOJ7d6khNi6ycSFCHMsl+A+pkKVJ/S3HlS1j/NxTAcgKjzlnJc2jPkF6xg7sEqe2niciQSvrCJYvm9LX9IZTR2gGjiwrhimz18LVdPc+ZhiZtm2ftps4zoySm265PtOcf4hWp03R7+yRyjJVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSSYuLUe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434f30ba149so19823595e9.0;
        Tue, 10 Dec 2024 13:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864593; x=1734469393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nm2Mjco+od8VJPNesv7f8taGbBUYsjl37SP0Hd6X4WI=;
        b=NSSYuLUek7Ldyb3gHNIdmhVCpXG4Y8DKKaf+euS1a0qExym3sOXCKcOFIIl7XvZkkL
         3KqlIivqxiLztUB2+8V7NFGoAdDl5m6cJRWdVLhBFJClNIIpmDMpWdwjOjIJaZjBOqCD
         hK4nMq2ZuHKysmiX+FqdvL/6HkPdJdgXHzeJxT8PXAiPBhXdTewgAQK9RAo/+uGii/7j
         k/xnmDxXl/Fj1VDQjSDN3q82QmE+m1QDeP0cw5XRIBTNIvHRNiV8Z+7M9QUeMRQY7V+j
         32NojJMWL8SObAPpz4FUHV5CCPthabKEC67q3cu/4fv9T17zb31rGHdP4Le1jydBnG6R
         w9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864593; x=1734469393;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm2Mjco+od8VJPNesv7f8taGbBUYsjl37SP0Hd6X4WI=;
        b=MJPqu8G//Qos7vDOgtgg0MBexgZN9nBtbe3pahZzK/ruyEo3Ibxj+T+9NxqLqBiMmb
         oKqKQ/F9F+0atSn0i1yQaiLgFJU8oe7GEyvgMqL+ptv2a2+aUae0WKTGFDwBtasipqaO
         /lxLjsps9CzmhxibZSDaXp+EAvl11cFRTLS0ySMFkwkxom2Wlf6d59HZYZh0B/xfWTX/
         yTWIow7RuJSnIPgrmDP5vigbnmQ0vUFmqNq1MpYphCuyYPpMShUm1DGg+TlNO7CPSA9P
         mz4KdehZBi8VTUhEv/58mOM5P1oEWDz9Rs73r/mxs0EByb3dQOixUY96VSnert9VY4nq
         dVGw==
X-Forwarded-Encrypted: i=1; AJvYcCVITBnU0IHjG4kIUX377JoaC883JmikITanyB1Jw1GPa6NgBebHPYz86+HjmFWJEWO4P11Q3Mxo6qLxQvep@vger.kernel.org, AJvYcCWUHKLmc+MkHaZVc6UgMaO9dCL5b0HH/hYYVAcLnd3aufjCadhuyco67kQk1T4ZlENnrtcGEDbaHdTd@vger.kernel.org, AJvYcCXpF3eCToFVk9h5tzmkeCNuD84oMQMOHXP39eluhC9eDXJArxOSXUMf2CnmXoxkBBRA2aiF1vox@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1tJQGgbxx2HAsQmA4iJ11/gJBoWbPej5pTRETHZ+hFEYkD6b
	IuePw8lDUX4UrqMJ/l7lX4ZPGoxeX05pjmnJIgdHDNtBlsCi9p0b
X-Gm-Gg: ASbGnctnC3bGaQAePl784CJ9aLH/9sKylH8hF9dyHEt3hNC6u9GkXfm6haDxtU7TY5S
	QwFeb2+X6ZGtvIYIH/+omyMhshTQNG536owKuy0tq9xfHjFmGSfsoG8vKcbkIa9O8PG+siFc8N3
	bPloX9Ayl5F+UvR1plf/ni2eNueJaJUr8iw1rtLGT1vRJxu0bdR8Fvybtf+59z4K4qecsyX8v0y
	QCzaT7UgCpU/i08hQnkMsXqQ+s+8lzZayRNAl7w+Yp4Fx/uPJAl3w0zmaSM5T57TgwYHA5nqsqQ
	U+pFhiElow==
X-Google-Smtp-Source: AGHT+IEXtT2UlScHLsjoILK+fcmMLa5fdqey9hRCAZXHg3/61m4/0ewYioRKLrqpj0zjb4ItoNJGrg==
X-Received: by 2002:a05:600c:358b:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4361c3efb43mr2036915e9.23.1733864592696;
        Tue, 10 Dec 2024 13:03:12 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbe15sm16620197f8f.92.2024.12.10.13.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:03:12 -0800 (PST)
Message-ID: <6758ac90.df0a0220.20ca7f.df40@mx.google.com>
X-Google-Original-Message-ID: <Z1isjbV2ypR2T2Bh@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 22:03:09 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-5-ansuelsmth@gmail.com>
 <20241209134459.27110-5-ansuelsmth@gmail.com>
 <20241210205544.g6y7vcyekyfebkoo@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210205544.g6y7vcyekyfebkoo@skbuf>

On Tue, Dec 10, 2024 at 10:55:44PM +0200, Vladimir Oltean wrote:
> On Mon, Dec 09, 2024 at 02:44:21PM +0100, Christian Marangi wrote:
> > +properties:
> > +  compatible:
> > +    const: airoha,an8855-mfd
> 
> After assisting dt-binding reviews in the past, I get the impression
> that "mfd" in a compatible string name is not going to be accepted.
> The bindings should be OS-independent, MFD is a Linux implementation.
> In principle this could be just "airoha,an8855" for the entire SoC.
>

Ok I will use an8855. The DSA switch has the suffix so it's not a
problem being that generic.

> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    mdio {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        mfd@1 {
> 
> And the node name could be just "soc@1".
> 

I tought there was a constraint with node name but this is not the case,
will change to soc.

> > +            compatible = "airoha,an8855-mfd";
> > +            reg = <1>;
> > +
> > +            efuse {
> ...
> > +            };
> > +
> > +            ethernet-switch {
> ...
> > +            };
> > +
> > +            mdio {
> ...
> > +            };
> > +        };
> > +    };
> 
> I hope it's not mandatory to duplicate in the example also the bindings
> of the children, especially since you link to their own schemas.

I checked other example and some duplicate the example and some
doesn't... My idea here is to try to add the most complete example
possible. Especially to how to define efuse and how phy makes use of it.

-- 
	Ansuel

