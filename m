Return-Path: <netdev+bounces-138373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93F9AD253
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510301F23B02
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC421CF7C5;
	Wed, 23 Oct 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUgUUQrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5071CEEAD;
	Wed, 23 Oct 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703685; cv=none; b=qKotbod5Ac0Qm+WNaZWKlsHlrrJ7pqjsLvYtZbnhwMxICQnGWH+mTFkJFqo0dodKmdz12DjKcXtxmEd337IqFQrXV6bNR5leZkxHxmNKEv5k80XGoLNCxL29V/3r40fB14HClvrvFkqn0vl4SBGWzgjrtl8CXxJQqTsJlFaRPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703685; c=relaxed/simple;
	bh=03rvAucDFVViHgLY7FYrkzqH16K8nKRKNMJsJ6AgZZw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVfWNvSop/bej241ZEOEYSHz1a0AjhWWfQkdK9V1QP9rPmPCVKSkmX9tR2qQqEpZqT/JgCxOb24v+Jf6snTQLNPztsFrFYqEZzMFjaLjJ3KiGvYm++D+wd9WZp6H1CKDIQakiT5Yj2l/UV/n5DnLLE2OErq22RznGjndAn1NHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUgUUQrC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43152b79d25so24035e9.1;
        Wed, 23 Oct 2024 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729703682; x=1730308482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=24JSccvs0HSbNmxvOVItJ4JQKqdo53s7Emj+lH9aPyw=;
        b=JUgUUQrCxIs8x29jkbhE9aQZErYlAdb17jBcYs1JgJkub0nvl+AGNwQYqQtxdJ+aDK
         JwlTv4O34i3xsm5MYANtXge3LLVJ051QBdvGa3HMCB6Jz22VeM650Bur86Nfit8rHI1d
         nrZoqFrFLA6OvuDvWbu6nqzL4upL/5O95YCrhP2FDC4j2xBo++zrFEWoEnSpJS87BGEp
         HBvBeqNjqF/8rQnst+P+c8ykTdsJyOs5m4SL3rAGtiHRWmqKb/zoIs1vLl1+Vdql2Pw6
         9Y+qaSpr/ODykSU4etOnmNfAOBcWVof6o3X51ISxO/T9BmNY2W9tyKKybSGydmEqC387
         GVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703682; x=1730308482;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24JSccvs0HSbNmxvOVItJ4JQKqdo53s7Emj+lH9aPyw=;
        b=FIXx+h6t2v/pNJJmdOciVnUOx/jjIry06VPrdgXeZsUSWuufxeN7DAWbSmggrAGH37
         4+O/VYLY6iYiEIlmNpqv4K0sZiDod+cSR2d6eSeZUJZP6zuz72j3e9dl/cuINP4gYYh1
         02GzFugeF92sk1ES9rP/wFI+CYrFP8AamaKEpLvK5iOdyx5RZUA6sVe0fr8yu/6ZHMw1
         VUQ2AoHunlsePNvro4BtoRUHZhhUhumDqpX5rg6P/lB+dAaxD3yRqDtdu83woyVAr6VV
         3hp3Bg/LDi2MvHeTwf88BO2J+zNE+3pW9OmgMcugrgqURssIuGopehgSEyZZHAAKOXk+
         AI5g==
X-Forwarded-Encrypted: i=1; AJvYcCU1SKveE0VVy1wM49zh12MrF0tC0nm+jyzjmfiNe77KyvcWO4gLw00rZWHgVFJKeRJgABAfPh4JRJyAFgRg@vger.kernel.org, AJvYcCVKUQ8R2CDGCok0Z7YYsTmSTVoByvpC23zHRNsBpOJLDmb0X+qCElXVh73fqMekD90MKF9SrTyS@vger.kernel.org, AJvYcCVn4Iu+OEsRLq5yqavWh2c6hOAS91+rwFaYHag8kXskSPb2jud1vIhZqapmFrBp6yWsqT064XrL4NI+@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGGYjzxk7qqqWG6ZZxQUrScW9UpSBtuJPwlFaV+0WGfyBqvM8
	m6Id0XW5kDhxfKqngbMPyqJKn5eInOhpVYDsoiDnlGUDE79EaVXl
X-Google-Smtp-Source: AGHT+IFyL3faonwfZbopJADep8Fb7q5nglJ4asw2OSvMdOVlChDa7XsFH3HgPggJz4T2SeNw/my3rA==
X-Received: by 2002:a05:600c:1c95:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-4318413e532mr24981595e9.8.1729703681340;
        Wed, 23 Oct 2024 10:14:41 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c3a44asm21554805e9.36.2024.10.23.10.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:14:40 -0700 (PDT)
Message-ID: <67192f00.7b0a0220.343b2b.9836@mx.google.com>
X-Google-Original-Message-ID: <Zxku_anuVj64p9nq@Ansuel-XPS.>
Date: Wed, 23 Oct 2024 19:14:37 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 1/3] dt-bindings: net: dsa: Add Airoha
 AN8855 Gigabit Switch documentation
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-2-ansuelsmth@gmail.com>
 <5761bdc3-7224-4de6-b0f5-bedc066c09f6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5761bdc3-7224-4de6-b0f5-bedc066c09f6@lunn.ch>

On Wed, Oct 23, 2024 at 07:08:57PM +0200, Andrew Lunn wrote:
> > +  airoha,base_smi_address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Configure and change the base switch PHY address to a new address on
> > +      the bus.
> > +      On reset, the switch PHY address is ALWAYS 1.
> > +    default: 1
> > +    maximum: 31
> 
> Given that this is a 5 port switch, what happens if i pick a value
> greater than 31 - 5 ?

The PHY at those address won't be reachable, I didn't think of this, you
are right.

> 
> Do you have a real use case for this? A board which requires the PHYs
> get shifted from the default of 1? Vendors have all sorts of bells and
> whistles which we never use. If its not needed, i would not add it,
> until it is actually needed, if ever.

Well the first case that comes to mind is multiple switch and conflict.
I have no idea if there are hw strap to configure this so I assume if a
SoC have 2 switch (maybe of the same type), this permits to configure
them (with reset pin and deasserting them once the base address is
correctly configured)

But yes totally ok to drop this if too strange... I assume it's problematic
that PHY change at runtime.

> 
> > +  mdio:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description:
> > +      Define the relative address of the internal PHY for each port.
> > +
> > +      Each reg for the PHY is relative to the switch base PHY address.
> 
> Which is not the usual meaning of reg.
> 
> > +            mdio {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                internal_phy0: phy@0 {
> > +                    reg = <0>;
> 
> So given that airoha,base_smi_address defaults to 1, this is actually
> address 1 on the MDIO bus?
>

Yes correct. One problem I had was that moving this outside the swich
cause panic as it does conflict with the switch PHY address...

-- 
	Ansuel

