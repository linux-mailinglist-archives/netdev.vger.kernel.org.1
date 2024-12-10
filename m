Return-Path: <netdev+bounces-150872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037699EBDD0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648F01693BC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF51EE7CE;
	Tue, 10 Dec 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaT4HUGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDB2451F1;
	Tue, 10 Dec 2024 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869585; cv=none; b=QTEVnNxJHQ5b0vIbKVleOLWZLqYF4+1OSPEL2bYQkEOTwXVhwIsqFFg+jUiafuAAUvcRafgZWGEorofpvbV2Uf/9ICKTv7AOQDB3PjyTcNgtnRiktwQxVit6EzlsGfVYl5cJ1kZIfMtEdz6I4kXY/fwN0L+GjFnbQyNKM9+N3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869585; c=relaxed/simple;
	bh=7dyBhkgm4N/DLXAeBBU91aVdSrvgFws4aFL8S4LxIyw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2U4WgD/+OdjOrkgech9cKdN4crX5R4ZdkuIzdLhIS0+S1X043Bo/6m+u2pi7EEXbraHSQnW7cXCaWUN5fx0XCBpwHIDWnlcc+oMOgfLaI04jgvGhDVcBFK4z8elgSjOucYmcdjXtQoc8SVAEyhwHBNj+xU3HWJFQQsROUOxhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaT4HUGZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434f09d18e2so35620055e9.0;
        Tue, 10 Dec 2024 14:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733869582; x=1734474382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UAnLPvcXxqQcZMFvRdGiegZqvPuvQ8o1GFTUSOFQNIg=;
        b=YaT4HUGZ29KbopI4xPnFV5yQ1k3CiVqjDm/2OVTrr8Yfw5Ln2YIw2BhEfnUR/AL10l
         9hQfs3auWSyaCXaLs+h7OoEB0LzQ6x9l6oNxmNErFwftnxMBleSx6T3z2/DVADz6sETH
         r5LTskDTQbETsgswj/HaHaT/fwKYI++8jRkP+o4d61vaQ62j6k7b/0IN5gpDeADQfPbB
         xKNi1S4IiIM1nmWPQ5zgUEDYvGdUv1KDXAKnuarHq/nWVg2/7u2HCDg7KAW3gIGfjJ76
         k0tMPTnjm+jnIgS2r89rhOWm7AUJ6Ilct0DFaBtQLKxYDOUz138ZJZzzLJbhEny05CGb
         u5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869582; x=1734474382;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAnLPvcXxqQcZMFvRdGiegZqvPuvQ8o1GFTUSOFQNIg=;
        b=CSrpfwLfxRDKePVTXdOaTWTgk5VfPFtIK9rIlhAoXW8AE+Xq/roLQBOkrBV9k9MLyH
         EdDy+KQDw9i7EI5QC7A1hIZ9QgG1habUlPLOLvU6SBlPzloWWFvu2CeeWXUhsB7PfsP7
         aTYeAaWjNbkbucDNFV5TSTaeKRt5IW+mPQE8+dtLG8M0AyTo2qNV/7k9cyBGglcm14jV
         dGoqCD5SOtRJFlPark5QrqQm7KCh17p6mNnG7U5dcSMA3PxjZi/jq2IH/goVMNB22CNV
         HsUsjl8DGia/v4IGVcNohAdNvkJLi8bbBixnQzdhrVRTabK1lVpQGE8eBv2VRQK+/IE9
         I88A==
X-Forwarded-Encrypted: i=1; AJvYcCU7HEu3ja6dGw1PQ2nqJ6aqQday7chUpVIE2Sr8DJT2KYecYeFozmNeDRzj62Q9q9YOekzNtyfs2IvvVoMk@vger.kernel.org, AJvYcCUiQDCvLH5U4CfUqTu6jl1pLXDVSzbeqE9At0a8FGvqKfmCnVPQa+Ts2EbHGRFwSwHgA2wOMMjj@vger.kernel.org, AJvYcCXt203kkPm5aK3kEykN08bea2hNwOvtucB7JfuF4BIxmk7CPF/Ck7U8Jr+z2bZOyr3wSH8CCb10jrln@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsG+pmb5iELhLTDoawhN00tM9yhMV5DFgia2vuIjFRou8QYWS
	b9HaQGAmKvXwD/SIVwAjtIOP4HzoHLP6IUJwGYTjg8XRX0DNS4uS03WNXA==
X-Gm-Gg: ASbGnctTl0747H2s8bSZtF6QmB7ke0NrWsfEh5Z5KQbTZdbYWEOYAKu+XlVeSlp7pRg
	cb/Nf+Ceyy8RS5RE5U2QV8G6lZAi5/y8CeV9gyst23lrVDCmsqlFSYyQn8L0ZUMr/R7PZGOVjyz
	Z+WeR55rJv+NJnAyinrZH2IuqXBPTFYzm6P4LNazEN55ZuS6osZkeS2y4DaD0/odglY28eQd/fU
	yk4vv9RbJLt0zhVf7f026BCSWAyq4BY76S2b4pS9+JF71c8Ax87u2wRRw2TANccxRNNN9JlrJm+
	FPYhwam5nw==
X-Google-Smtp-Source: AGHT+IEIx73L8V9Xn20US5TZdCSs05hwB1+pqofuOI4Tftmw7ho7qTCb/DpbVER3GSlQTeepdonLzw==
X-Received: by 2002:a05:6000:1fae:b0:385:e30a:394e with SMTP id ffacd0b85a97d-3864ce862d2mr561573f8f.3.1733869581438;
        Tue, 10 Dec 2024 14:26:21 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f9da4cd0sm81688025e9.26.2024.12.10.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:26:20 -0800 (PST)
Message-ID: <6758c00c.050a0220.1dd14c.63cd@mx.google.com>
X-Google-Original-Message-ID: <Z1jACflOJaLJmhgy@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 23:26:17 +0100
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
Subject: Re: [net-next PATCH v11 3/9] dt-bindings: net: dsa: Document support
 for Airoha AN8855 DSA Switch
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-4-ansuelsmth@gmail.com>
 <20241210204855.7pgvh74irualyxbn@skbuf>
 <6758ab9b.7b0a0220.3347af.914a@mx.google.com>
 <20241210221602.ohyzlic2x3pflmrg@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210221602.ohyzlic2x3pflmrg@skbuf>

On Wed, Dec 11, 2024 at 12:16:02AM +0200, Vladimir Oltean wrote:
> On Tue, Dec 10, 2024 at 09:59:04PM +0100, Christian Marangi wrote:
> > > > +  airoha,ext-surge:
> > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > +    description:
> > > > +      Calibrate the internal PHY with the calibration values stored in EFUSE
> > > > +      for the r50Ohm values.
> > > 
> > > Doesn't seem that this pertains to the switch.
> > 
> > Do you think this should be placed in each PHY node?
> 
> Logically speaking, that's where it belongs.
> 
> > I wanted to prevent having to define a schema also for PHY if possible
> > given how integrated these are. (originally it was defined in DT node
> > to follow how it was done in Airoha SDK)
> 
> Does compatibility with the Airoha SDK dt-bindings matter in any way?

No it doesn't, the requirement for nvmem already deviates a lot so changes
are needed anyway.

-- 
	Ansuel

