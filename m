Return-Path: <netdev+bounces-153744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A759F9938
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63547189E167
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993CD22756E;
	Fri, 20 Dec 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WCYD3YzE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978821CA09;
	Fri, 20 Dec 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715426; cv=none; b=cmzwcxwy9BFWMeZhfZvKvzjDejF5YHGUosm8uWZeW8P9nSWFPjARZAUwG2Yu+WZIgEJtJlcL4RVzSW0r4mY3fbB5Vr3VDP2Ks7zKkGUP6B8Ozjsk/d6q+IaNV5UolHA5QwYvJVQkNRc2PsCIxVQ/Es7RhY/I42BbRv5MgjH6Igk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715426; c=relaxed/simple;
	bh=pB22/j8NqAiHhB7OLNKZqfW1Mp/dMFCM5XyVKMdz4dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMMjJs0p51Mmo7VGirJL9eEXsjMElc15qjvnWLHCpq/YzIOe8kigUjBF+4veFyQRFZhV98Z+D5UIO/aiQvRzmGFwzqadrpRWkFHypeNZ7dVT238IFnFoMPl0iKSIk6RFZ8NrEccPdKrqNcXyfuTKfkjmJaZQ3rAwwSadlWmKsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WCYD3YzE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IXrxemTVaqUjgMVsYG39XHX92KiKfDfge1KnIOy6Lp0=; b=WCYD3YzEOme2+6CQaXwzfrsCTq
	di+xwAqH1nAdbCdo89GUac0ngarb0K2jnYqcSx0JQjPIzxgJxhLDtbV9nGca9vUzj85NK6wM2Nilg
	OOhmV28llWu/OFv9teDBD10neohtmNuyT56qbxoTfTRTHxBIJAClHiQNWXJYWORt2y/E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOgil-0023oA-K6; Fri, 20 Dec 2024 18:23:27 +0100
Date: Fri, 20 Dec 2024 18:23:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	robert.marko@sartura.hr
Subject: Re: [PATCH net-next v5 9/9] dt-bindings: net: sparx5: document RGMII
 delays
Message-ID: <cb42f0d7-d2fd-460b-9f38-3b9ebfec7607@lunn.ch>
References: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
 <20241220-sparx5-lan969x-switch-driver-4-v5-9-fa8ba5dff732@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220-sparx5-lan969x-switch-driver-4-v5-9-fa8ba5dff732@microchip.com>

On Fri, Dec 20, 2024 at 02:48:48PM +0100, Daniel Machon wrote:
> The lan969x switch device supports two RGMII port interfaces that can be
> configured for MAC level rx and tx delays. Document two new properties
> {rx,tx}-internal-delay-ps in the bindings, used to select these delays.
> 
> Tested-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

