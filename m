Return-Path: <netdev+bounces-173076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C8A57193
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF05B3B2165
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341CC2512DF;
	Fri,  7 Mar 2025 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9opeFQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF4250BFB;
	Fri,  7 Mar 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375391; cv=none; b=BjsNGNgBpfMBcw88hEdM+RNwX7NEzU4hlElXoejCZyxYEAed3aoAmExws2q0lXCm2aqu4SZ1VmIjF1ubwfGENN/KR2p+eH8XZbcnnqngvU4H2vTfF2hX3VLI6t91lWqaPErsskFhNXzNcTZ+LQMU8+BZBgYSO3NqIg/xhvtw7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375391; c=relaxed/simple;
	bh=7GlVd0V/EedW0bDmkVw/rKRm1b7/IHKp8oyprPziWYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMH802BHmr73OiMQmfD1WzQSMW5oMYvu7GlSitU5ky17sLS76E2JlzPMwQEj1DukGhtB/P/qfgbb8btbSpB4bhfIdRh0fCa6rEkeBOwfgUEex+Yh7wAt1wlFWwkDihGMjAjxAcoqi55WLoO0sBLWZCqm6D7NZZFtdsVzdbRr+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9opeFQQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so25960575e9.3;
        Fri, 07 Mar 2025 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741375388; x=1741980188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1+RmpRBuPh+de0SwHONnyOjz2fjlSyauEN398sj7MU=;
        b=e9opeFQQC6Tph8RJqZTm1wlyAHuvMBe6GDJMXl51MwYo/PuRI/UmgfuMbuTmrCtrOK
         jIEvpraRqt8RO6EdMMBdx5uBHzDarKofUS3aa/45C3th9CNryL05HJi/CfrxQ4PWMGFY
         8MOvZfDU0S/zKEpBizCGk9sypqYK1M88k/Ny7+XrM7mE+G/KXWQuOP8oDu3EdL+n6R+h
         ZJW0JsV/mS9BPDdpxosZOOSK9iMjF3t67B591o+eyJle3YgEhotakkb+Dvv9ts6OWUn0
         +/AifI6tFNdL3+6ue2IQpEHINEgzb50WaiAcc4xdZZ3EF9uXlLLle66IkZO83FTtFq6+
         cZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375388; x=1741980188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1+RmpRBuPh+de0SwHONnyOjz2fjlSyauEN398sj7MU=;
        b=AlCpJt3mcJFZ7vJF4sgUfQV8VzXC85xRDeWCLnkoGn7Q9te4wEC3Re3KH6fFIrseUf
         IrGwg5mdBfxsNE6+FWW5er0D2i7BEAAZ61BDxFVItipKU67p8d8ZKT1iUJp2f/6hvSSJ
         hG6zNdompueWyT0VYXyNfCzAj+ExFiFvuW3+ShBa5erRcvceCMQWwahw02QWnr9gaICy
         mrp+DSN6Q6jn/DsXsy9LELe+cKpZS+jO7+eWs0uctpiEWRaMTMhq8iJdIoQQcR6aLw98
         j40iZzm196K99q1bcwZ7jcM3vLPIPsOfcN052PoFeJW4VVAlU9s6dBQDVrXrSS6nnRJ4
         +tNg==
X-Forwarded-Encrypted: i=1; AJvYcCUxzaIcK24a5xiNKyjbO55y5tab4yEaLpG1+JPRQ8SZtpaMjZR/yI0WbNAwsF7JdwPwUIsbaAx5xC4mnQcm@vger.kernel.org, AJvYcCWtCYRHMjLuKoaXUCyvrR6TBW2Z4x9uTZt/0WWEs5fw5FUio2njZAnk2dGOOWnv2biIwwfUqYql@vger.kernel.org, AJvYcCXpYclT4lloVuheSWYHS9FSZ1+7G5Zvpnyc+Wnl54oF4AJ23yQCroniCUgzVXjfOlnjG+30uxsOafHL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6LUNPSPf8q8VGf1qkkz6UzX73yu9rs2QqMqs53f8kqkU9l42
	5yrY5kQrMT5/XESWvkBbMqvM64FuHZ6KhZW3IqW4NaGsRuLSlBWZ
X-Gm-Gg: ASbGnctju1AYAhppGWt9S3lF+pKH/F5P5ezh4tzIUjETBwz4s6ZvA3rHGfmF0eXWVZg
	p+LxsOC9u6nmJDXsH589Ev4C5QELCktcEzvOeKDZt3Kb0lY9rtCrZnEKQYpSkMy/pqQJCrj9T02
	hIsaSw7j5dttE/qgRzHl/tMxyT3o8oi1y9nhazsLZi6hlVjnBR29Jys/1qZn1pznSHOJ0HeWHeW
	YqNqs9Pdib08fDMhypJz++PcPidEJA/B870SeVwgPvh/uRmGoX6nQXcWcv0Xqb3FrHNn503QcR4
	IPQ4w3o6uGSvAZcGRNa0E/VT8XMi0VwRgo2GCU9R6g==
X-Google-Smtp-Source: AGHT+IHWmU/+ViicytjGYK5fn4UCskJJEuhITp5rYhpxrYYlvOK7Z9KmnpTMe1nfseuXDV0mBeUeKQ==
X-Received: by 2002:a05:600c:1c10:b0:43b:cf9c:700c with SMTP id 5b1f17b1804b1-43c601d06a7mr53392505e9.16.1741375387295;
        Fri, 07 Mar 2025 11:23:07 -0800 (PST)
Received: from debian ([2a00:79c0:614:ea00:3000:d590:6fca:357f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm6348819f8f.99.2025.03.07.11.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:23:06 -0800 (PST)
Date: Fri, 7 Mar 2025 20:23:05 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dimitri.fedrau@liebherr.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: dp83822: Add support for changing
 the MAC series termination
Message-ID: <20250307192305.GA8328@debian>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
 <6aee57d3-8657-44d6-ac21-9f443ca0924e@lunn.ch>
 <20250307142252.GA2326148@legfed1>
 <d57aff5b-7d1d-43bf-95a1-ee90689f5ac0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57aff5b-7d1d-43bf-95a1-ee90689f5ac0@lunn.ch>

Am Fri, Mar 07, 2025 at 04:34:59PM +0100 schrieb Andrew Lunn:
> > Should I add the proper description in the bindings ? Description of the
> > properties are somehow short. However will expand the description.
> 
> Yes, please expand the description. For well known concepts, we can
> keep the binding description short. But i would not consider this a
> well known concept, so we need to spell out in detail what it is.
>
Ok.

> My knowledge of transmission lines and termination is not so good....
> 
> So this configures the resistor on the PHY outputs. Do PHY inputs also
> need termination resistors? Could there be PHYs which also allow such
> resistors to be configured? Are there use cases where you need
> asymmetric termination resistors?
>
I think they are also needed for the PHY inputs, but termination
resistors should be placed near the driver. In case the MAC doesn't have
them integrated they should be placed near the MAC outputs. From PHY
perspective we just care about the PHY outputs.

https://resources.pcb.cadence.com/blog/termination-resistors-in-pcb-design

I don't know if there is a general rule that states wether to use series
termination or not. I think it depends on the PCB design and if there are
issues with signal quality. Maybe this one helps, there is a small
chapter regarding series termination:

https://resources.altium.com/p/gigabit-ethernet-101-basics-implementation

Found it reading this:

https://community.nxp.com/t5/i-MX-Processors/Why-doesn-t-NXP-use-termination-resistors-for-MII-data-lines/td-p/1360873

> My questions are trying to lead to an answer to your question:
> 
> > Should I rename then "mac-series-termination-ohms" to
> > "output-mac-series-termination-ohms" or similar ?
> 
> We should think about this from the general case, not one specific
> PHY, and ideally from thinking about the physics of termination.
> 
> https://electronics.stackexchange.com/questions/524620/impedance-termination-of-marvell-phy
> 
> This seems to suggest RGMII only has termination resistors at the
> outputs. So "mac-series-termination-ohms" would be O.K.
>
Ok.

Best regards,
Dimitri Fedrau

