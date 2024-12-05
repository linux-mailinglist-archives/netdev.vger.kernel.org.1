Return-Path: <netdev+bounces-149507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD549E5E77
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 19:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AC82822A5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6122B8D3;
	Thu,  5 Dec 2024 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmZ3jAlZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537ED218EBC;
	Thu,  5 Dec 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424645; cv=none; b=T/EdoKUx1r+J/bUbkiNMRKu9YxEPlLC1Scx/FDNiKQFFgn3/JobZ3XXBxELW0B7HdoOii4SPE2qlvR0h6C5CKKGCwTBTno4udKKh0bnLCaphtZPQ9vaKcT/St3/nn2azTsssEf2gQnIncZ+on9LiV5G+hol6Ej+hakgZTONGjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424645; c=relaxed/simple;
	bh=JWDj8QlLbidNrhEz6lafRDRkIXsUvesuWlCtZKS2h0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFc3PPBtp4pfaSD5tMx8S6SVr//3iMS4kAHA7up89hjNIFRSg9Ap8kmxUGg/sO2fDpKcpLZZi4YBMXbmgK818BA8n8FnUAaUrP8yEZ9M8nPuQik6RCupiw0db3VpXoCx9+gNkUCdQ1EF6OCkHUz90oj7daCUkjN0nnNv1xZ5BvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmZ3jAlZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0cdff12b4so172765a12.1;
        Thu, 05 Dec 2024 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733424641; x=1734029441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuL0vSwcp+HMpPwWDWVKgActioYscbfUsEOUicYp0kE=;
        b=JmZ3jAlZaxndoWTHGQxz2EAZxg8diDf1gzwWwn16WF6Jhy54RbQVswoYlG4+AcyYGS
         6Xu8TfQRYDbyQXXkFlYf2BMPlBakjtXo6E+3kpWQT96njYu8EADuj3CRlUG52P7uH3NL
         WP508hc3+P4ViGlJmTUK4ekBos7zQzBCoLspx0sTLB8mY6/6N8qYc7VBsBpmFgcEejD9
         0VgNnr8rIAOhV1jAHrej180jQZeTLbsq2Hij6Vlewfp3sYig2PCHb63XegPJmemmiKfQ
         B9VUdF0k77dqFRN9RBMQOkdaqVHvTHwDuworb7vfHyLTtTfjZOJtuk3jmwyDVrINHK+V
         8GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733424641; x=1734029441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuL0vSwcp+HMpPwWDWVKgActioYscbfUsEOUicYp0kE=;
        b=KhmiOjz6jVblghoN88NMqx6a+H1fpO4enaA7em7JZ/UCq29WLAb4rOJO5bll6Kyakd
         cxXvPpuZlRBXppEbvB4U/33SJ7UssD6l/sFY39M4rjwxsq7NggNcwBN7mo8+2r68Ggjs
         mXSgObFmik+vUJgBDbMBDQ6lrhEam43oR7cgAiQGjT1LOg3xCLl90xEBGZVMMPcsKgUW
         FcJtI3wGHXQ3RfKM5g79IfigNUnvr8/T8ffuiJMbRnCC4OEldVhpn8gHqHp7fJhukFNy
         4qq07WREb9QHQ+cHADbDzhTSb8T0mOCkJNk73HAMclLToUVscrVW0Mg+lgQMLKN5patr
         i4sw==
X-Forwarded-Encrypted: i=1; AJvYcCVNzIvzNbBUDYnYAbG5iNxMSOUrqSP3K7ifApqAFCQNfal1UcvNJeLKBRbudapFK5xPajH1PR0pzhtG@vger.kernel.org, AJvYcCWndcC+8gbO1W90Hl63oq4i6xM7TImNhQ+93CBIvrk9r50a/qFdsoidOzEkeMjohppjg1iuT34z@vger.kernel.org, AJvYcCXV9mWgv/IEjc8tomkr5jvXdqgPVvGM3r0JvsGbTIBrGc1TUtf23DHSxUCNnlQ08v0TcrzGFgfIEE/RGk34@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWUQt7QPKBA5p8HApnrhkyYA7/cA+h1n4ZrHe43bqAHq6AAlm
	qxHjaB0lkegub92VF+1V/jDbpYQqB4FDyVg0WCCGGovrCraQOpkmgFIEUw==
X-Gm-Gg: ASbGnctktWZxuU4rQV/x71iwhko1BGP4FbBrfHDxJwmLxExAjczxySyAcShkKZZE5+3
	5rjtN4Jy3sDdMihyufiC7O2eLynb9knLcUiVO/si9UtRv/PEIZ9StJfWKepMpwrkaShTsRWLg7f
	YgJHIVFMl6BJwiikHKvKCI3O+LWNxr8zTUsx4Ud43ZDmvOQkvI9ev430ECzZpqlfTLc28TMW3qV
	MaRSUY2pdFcyP8Mheor9TceYU35X5TaCiYwIck=
X-Google-Smtp-Source: AGHT+IHXBo4XbdE1KRXT45i7tcr0tQbymXLsF4fYU2CO5TAKnlDgiYLqOd3ZY8+xqizacESzgmiQQg==
X-Received: by 2002:a17:906:db03:b0:aa5:3b5c:f638 with SMTP id a640c23a62f3a-aa5f7ccc944mr453434466b.1.1733424640392;
        Thu, 05 Dec 2024 10:50:40 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e972c1sm126626266b.76.2024.12.05.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:50:39 -0800 (PST)
Date: Thu, 5 Dec 2024 20:50:37 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20241205185037.g6cqejgad5jamj7r@skbuf>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
 <6751f125.5d0a0220.255b79.7be0@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6751f125.5d0a0220.255b79.7be0@mx.google.com>

On Thu, Dec 05, 2024 at 07:29:53PM +0100, Christian Marangi wrote:
> Ohhhh ok, wasn't clear to me the MFD driver had to be placed in the mdio
> node.
> 
> To make it clear this would be an implementation.
> 
> mdio_bus: mdio-bus {
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> 	...
> 
> 	mfd@1 {
> 		compatible = "airoha,an8855-mfd";
> 		reg = <1>;
> 
> 		nvmem_node {
> 			...
> 		};
> 
> 		switch_node {
> 			...
> 		};
> 	};
> };

I mean, I did mention Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
in my initial reply, which has an example with exactly this layout...

> The difficulties I found (and maybe is very easy to solve and I'm
> missing something here) is that switch and internal PHY port have the
> same address and conflicts.
> 
> Switch will be at address 1 (or 2 3 4 5... every port can access switch
> register with page 0x4)
> 
> DSA port 0 will be at address 1, that is already occupied by the switch.
> 
> Defining the DSA port node on the host MDIO bus works correctly for
> every port but for port 0 (the one at address 1), the kernel complains
> and is not init. (as it does conflict with the switch that is at the
> same address) (can't remember the exact warning)

Can any of these MDIO addresses (switch or ports) be changed through registers?

I guess the non-hack solution would be to permit MDIO buses to have
#size-cells = 1, and MDIO devices to acquire a range of the address
space, rather than just one address. Though take this with a grain of
salt, I have a lot more to learn.

If neither of those are options, in principle the hack with just
selecting, randomly, one of the N internal PHY addresses as the central
MDIO address should work equally fine regardless of whether we are
talking about the DSA switch's MDIO address here, or the MFD device's
MDIO address.

With MFD you still have the option of creating a fake MDIO controller
child device, which has mdio-parent-bus = <&host_bus>, and redirecting
all user port phy-handles to children of this bus. Since all regmap I/O
of this fake MDIO bus goes to the MFD driver, you can implement there
your hacks with page switching etc etc, and it should be equally safe.

