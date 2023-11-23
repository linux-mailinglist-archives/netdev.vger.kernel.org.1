Return-Path: <netdev+bounces-50656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5157F67B3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 20:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF125B20C65
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC04CDFD;
	Thu, 23 Nov 2023 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yPLPHwIk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BAD43
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 11:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xi5TeLOG/iNY6Oj17rJLsvxkZ5+dySdcsBWOma31PiE=; b=yPLPHwIkTiCXYhGiwr63Cdw7sd
	o9gzJEbcHiZvrvoUOGQS3medPM848FFIR6dSYwELowRmvY44ptJIp3MXRvPr2EeDkjGN1Nj9NSNPT
	yqgoqSK8Z3oQsnGYs6wszRFCaXzCngev2Ru+JKujAiLG7GT4gcEHALv1L1ptBpz5rTmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6FYk-0011qe-BU; Thu, 23 Nov 2023 20:40:22 +0100
Date: Thu, 23 Nov 2023 20:40:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Ungerer <gerg@kernel.org>
Cc: rmk+kernel@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] net: dsa: mv88e6xxx: fix marvell 6350 probe crash
Message-ID: <7d36c0e2-0d0d-4704-8d3b-2d902e29e664@lunn.ch>
References: <20231122132116.2180473-1-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122132116.2180473-1-gerg@kernel.org>

> @@ -3892,7 +3892,8 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  	int err;
>  
> -	if (chip->info->ops->pcs_ops->pcs_init) {
> +	if (chip->info->ops->pcs_ops &&
> +	    chip->info->ops->pcs_ops->pcs_init) {
>  		err = chip->info->ops->pcs_ops->pcs_init(chip, port);
>  		if (err)
>  			return err;

mv88e6xxx_port_teardown() seems to have the same problem. Could you
fix that as well?

Thanks

	Andrew

