Return-Path: <netdev+bounces-54896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFEA808E18
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20017281723
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459E46BAE;
	Thu,  7 Dec 2023 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMUhrtqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A951703
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 09:02:06 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so1108366e87.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701968524; x=1702573324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Pwe3YBA5UG9UkG+sVNwMWmUm/BEDRYKqzUTKwcYJZs=;
        b=LMUhrtqF0YqvYn+rfhm+w/tq8SzgsUnQujYnPWshwwsZMSIs0Z0Z07EWe8XEotipP+
         rFYc7Q0AYckqX+l7U/bf4naM6OuV3xP8j4jTEzN3kC7bUi6lrMrRNdZ2z0uSsIgFo1zo
         qTXAHOfNqIvXR8Oxhv9PupoKcXRPJW/gBQ5C/QSOgIqKhjfZGADC4L/HkZu3CwdcniVK
         inDdnwt8cHj4ttjKnoyetoeyTmv/TLnUBaxBatVPi0wyCTE8t0fbq3wsFJodJIOBZSaS
         rvAT2mtlfuKVbalu/Et3Ko+i4T1wLyf1QXSBfw61D2FRn3imtNdx4PUE5Kba3R+/+5Di
         21Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968524; x=1702573324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pwe3YBA5UG9UkG+sVNwMWmUm/BEDRYKqzUTKwcYJZs=;
        b=BvgY+kcecS66XVDA/Hg/rYmK0q/HL37euzeponoB1EdkDnBBRZQ5fNZpu1L209P0R/
         N+L4fECSfvVRDvxgOhzzrT51o7QoI+iBsYXOtuk65INRyoyofFy7GP6Xo+AkhGg/6BOD
         0Qe56WhBBcbN0s9ZZs1qmysLuPZb2k0L7+DzjuX+R4ZHCIvnaVjibvjV867LAX6IcuYk
         IlLvGB77QlyKv1YYnpHVOduqgLpdDNKQOLDg8XBVlH7g0R/JHk1h4UjVjoRlRL29F4y4
         QlODZv+JQXmwJfed4L2dseR5rQeLtJ+OeJRG6Y0Ai8uULrdBJ8YleaWcw+TpLkVqkiH/
         8dVg==
X-Gm-Message-State: AOJu0Yyl2iBoZ234U1Z4plWBxlRrOtLIgexo6ae2ZGGTUjP4cdXGyGq/
	RJ2/Z7j6HxB1PktgGtpl2Z0=
X-Google-Smtp-Source: AGHT+IHcmMl4kmkn60Kxrbp8J40wA/z44GBjZh2+Fi7+xfmKipO1IikRj03iLFa7L08ROWtwzmLSRg==
X-Received: by 2002:a2e:b0ce:0:b0:2c9:f58b:70c with SMTP id g14-20020a2eb0ce000000b002c9f58b070cmr1646820ljl.10.1701968524140;
        Thu, 07 Dec 2023 09:02:04 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id kh10-20020a170906f80a00b00a0180de2797sm1046611ejb.74.2023.12.07.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:02:03 -0800 (PST)
Date: Thu, 7 Dec 2023 19:02:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Message-ID: <20231207170201.xq3it75hqqd6qnzj@skbuf>
References: <20231117235140.1178-3-luizluca@gmail.com>
 <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org>
 <20231120134818.e2k673xsjec5scy5@skbuf>
 <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
 <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org>
 <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
 <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
 <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>

On Mon, Nov 27, 2023 at 07:24:16PM -0300, Luiz Angelo Daros de Luca wrote:
> I'm not sure if getting/putting a module is a problem or if I can
> request it when missing. I would like some options on that specific
> topic from the experts. It seems to happen in many places, even in DSA
> tag code.
> 
> I wouldn't say it will invariably require both interface modules to be
> loaded. The dynamic load would be much simpler if variants request the
> interface module as we only have two (at most 3 with a future
> realtek-spi) modules. We would just need to call a
> realtek_interface_get() and realtek_interface_put() on each respective
> probe. The module names will be well-known with no issues with
> module_alias.
> 
> Thanks for your help, Alvin. I'll wait for a couple of more days for
> others to manifest.

I'm not an expert on this topic either, but Alvin's suggestion makes
sense to have the switch variant drivers be both platform and MDIO
device drivers, and call symbols exported by the interface drivers as
needed.

If you are able to make the variant driver depend on just the interface
driver in use based on some request_module() calls, I don't think that
will be a problem with Krzysztof either, since he just said to not
duplicate the MODULE_DEVICE_TABLE() functionality.

I think it's down to prototyping something and seeing what are the pros
and cons.

