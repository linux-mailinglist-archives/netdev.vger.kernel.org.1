Return-Path: <netdev+bounces-51143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A127F9514
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 20:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32798280C67
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EB125C6;
	Sun, 26 Nov 2023 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EEMCwfkM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A60FA;
	Sun, 26 Nov 2023 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mk7SDcFSL7B3ppHTk9/onNe9s3kcpJLUTe7gaGAWUj8=; b=EEMCwfkMOXVsQNMyVQn+iEIRN4
	5wTzPkhM6eUSSy1fc+z45XYcN/Dar/fF79pPKQf2eV6oiLXy+WsDlhPOIjtGerLXZ7nN3RzC1QVg/
	stjhJlcOmQT/EgQa76Xl+avVKtgJwrJ8aeTPpsIM0eBsFIPYtC7F8CrlboyUlfycXz8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7Kyh-001GiE-1M; Sun, 26 Nov 2023 20:39:39 +0100
Date: Sun, 26 Nov 2023 20:39:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: extend PHY package API to support
 multiple global address
Message-ID: <4759bf58-0e9f-4d06-8b8a-d33df378c003@lunn.ch>
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <cc37984c-13b1-4116-99f8-1a65546c477a@lunn.ch>
 <65638967.5d0a0220.28475.43b3@mx.google.com>
 <240c0d9a-38d9-44fc-a56d-cdd88d9144a9@lunn.ch>
 <65638d0a.050a0220.5d4fd.3082@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65638d0a.050a0220.5d4fd.3082@mx.google.com>

> Well yes I think we should assume those API to be called only in
> config_once context or in package context. But is it Panic ok? I would
> at least use something like BUG() to give descriptive warning instead of
> NULL pointer exception. What do you think?

BUG() is way too strong. It causes an immediate stop of everything,
and probably file system data loss and a reboot. WARN_ON() is
generally no better.

An Opps gives a stack trace, which is what you need to find the bug,
and kills the process. Generally, you can do a controlled shutdown,
without any losses.

	Andrew

