Return-Path: <netdev+bounces-49672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0E7F30BB
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA54D282D65
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4354FB9;
	Tue, 21 Nov 2023 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TWK4i6Gn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E9690
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 06:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B2CPYLX/8eQnRoedirjmdIMKwNUPyW5Mg/Pn3tECtWQ=; b=TWK4i6GnhGgothTeg733DhszKN
	BBrrgMh3LihNI1INOCDVtDB4c6y2kBYPXDU5M/KOrGEGNlp3T3V9n/5FAOVHJY8ly/UTk//aoCrF/
	VN7fzRUMwUXCePOlUzTAkBaJznLS7QUV4BM7VXnVEhT/C9bW3+NusHkn4A+HuUW+jX0o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5Rkh-000lRk-9a; Tue, 21 Nov 2023 15:29:23 +0100
Date: Tue, 21 Nov 2023 15:29:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Ungerer <gerg@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: require supported_interfaces to
 be filled
Message-ID: <650f3c6d-dcdb-4f7e-a3d4-130a52dd3ce9@lunn.ch>
References: <E1q0K1u-006EIP-ET@rmk-PC.armlinux.org.uk>
 <13087238-6a57-439e-b7cb-b465b9e27cd6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13087238-6a57-439e-b7cb-b465b9e27cd6@kernel.org>

> The 6350 looks to be similar to the 6352 in many respects, though it lacks
> a SERDES interface, but it otherwise mostly seems compatible.

Not having the SERDES is important. Without that SERDES, the bit about
Port 4 in mv88e6352_phylink_get_caps() is
incorrect. mv88e61852_phylink_get_caps() looks reasonable for this
hardware.

> Using the 6352
> phylink_get_caps function instead of the 6185 one fixes this:
> 
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -5418,7 +5418,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
>         .set_max_frame_size = mv88e6185_g1_set_max_frame_size,
>         .stu_getnext = mv88e6352_g1_stu_getnext,
>         .stu_loadpurge = mv88e6352_g1_stu_loadpurge,
> -       .phylink_get_caps = mv88e6185_phylink_get_caps,
> +       .phylink_get_caps = mv88e6352_phylink_get_caps,
>  };
> 
>  static const struct mv88e6xxx_ops mv88e6351_ops = {
> 
> 
> The story doesn't quite end here though. With this fix in place support
> for the 6350 is then again broken by commit b92143d4420f ("net: dsa:
> mv88e6xxx: add infrastructure for phylink_pcs"). This results in a dump
> on boot up:

PCS is approximately another name of a SERDES. Since there is no
SERDES, you don't don't want any of the pcs ops filled in.

Russell knows this code much better than i do. Let see what he says.

	Andrew

