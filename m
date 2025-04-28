Return-Path: <netdev+bounces-186460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B13A9F3B5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD433BF1FE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710826FD9D;
	Mon, 28 Apr 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HxF2K4Tu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDA211C;
	Mon, 28 Apr 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851536; cv=none; b=STzoMnmDP0O9ZivNR2T+76dp2E3ofwXPpGne5FDo18R0ehR+N0pUnQ+uS9hhZdP1m74VA8YeEVUnlQe7sJ/Zwja1kqh6kJenUUb1elOqdqBxPuo1lNAPKIgJM0+XVebox3QvhyAWS2BtySXIGStACTW9wWr/KzNWTjTZfrZldFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851536; c=relaxed/simple;
	bh=0qaxyed43SixLZaczHjhBLWkwQQOVtcs72WgDQpM0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYRIBjjfLorcBLJ738uja8E2Gu7l5+VlsdAy3sS+AZcq5Y4uh/E3VkV79w8r8zIqCXO70f4wwBmzWSo7Hg4BDY+yCXxnwrmmKoXdZBKFOeYimf90GIgjYsecwuzIR6QaCYsonyQd25UCeTN0Yvkg106Cf0muEYJcINuGiEGS8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HxF2K4Tu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XWuVVEEzCO6CTK/zeEtGw6vKXtOS128jKZE/G/8MKJ0=; b=HxF2K4TuhzmH1NjzQixF1OySKO
	6MKUqFdnxdCWEKsJdo/LQnQxKBW241ZeAuPOLZ57ZLBLUd/Be4x7yxuNKTOpt3Kjrah/W39Ja9icC
	q6pyoJ12YKinvnVisGPYKJqe1oQDgDObnQz2WSjrqlXLFcpLszegSM8gg16lbr9btloM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9PjR-00AqaV-0z; Mon, 28 Apr 2025 16:45:17 +0200
Date: Mon, 28 Apr 2025 16:45:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <e5f75ff1-a4ed-40f7-9919-aecd2f9a0ae8@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
 <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
 <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>
 <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
 <8b166e41-8d21-4519-bd59-01b5ae877655@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b166e41-8d21-4519-bd59-01b5ae877655@ti.com>

> A complete description might be something like:
> 
> mac {
> 	pcb-traces {
> 		mac-to-phy-trace-delay = <X>; // Nanoseconds
> 		phy-to-mac-trace-delay = <Y>; // Nanoseconds
> 	};

> In some designs, the "mac-to-phy-trace" and the "phy-to-mac-trace" are
> treated as a part of the MAC block for example.

PCB traces cannot be part of the MAC block, since they are copper on
the PCB. In fact, such a consideration just adds to the confusion,
because how do you know which designs do and which don't include the
MAC block?

	Andrew


