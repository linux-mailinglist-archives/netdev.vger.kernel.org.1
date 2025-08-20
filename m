Return-Path: <netdev+bounces-215392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED447B2E628
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9108A3B02BB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9F286402;
	Wed, 20 Aug 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oCxxgO41"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8E24A054;
	Wed, 20 Aug 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720429; cv=none; b=MHy+C1X5c7cGkleqWkF0/zV6TM8oaocUfhFpbCXyTnRq6foynjGweppnNVkdQqbPTnUu3IHAVbX1zRQkTrYCnVqzone6JrZ4hcsZdoOIKqf3RHY70C0vCFfKkQLgZ2l3qhKiQ+rqbwr7sNKHDpVjFgS7MHYIXH8SLr7UTaMTgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720429; c=relaxed/simple;
	bh=kj+fB2aZ4ZqK/MsQRWpunhH/gnS5xOGJHWMeka1INOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftj7C+IvrEsnKJ18Jj6f7gcZN+DGWlIKqI/kQ/eDeYNPZCzPZrwwo+nyg247T7sqoKkm2e4C7b42s9ZufJsYpRsqClWyAvoJ1FKj6PmX+SfCEUsnpruqgCyFPggwFl0219+FIYpyR2VG1hcwVgysZZjuFH8KLYKtTzN+SqdVGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oCxxgO41; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yf6LE8O4fjTWA5texO7IEIZE4WTXHc/PcEGOsOlivII=; b=oCxxgO41avMzcFl0mrmyDR2dhe
	JoK87SRaxwePP0rEFqqC8wdyRldktHdseD8EsA7TNRAKy07iRy7gqg1X+8f+ADjVBv9WiiM/JQ8QB
	1eKI+ANp+YLN9c1RQq4WUJAH6ZNV/fP8vYeHV0AuPJmP2I3eEyhxcBYSCLPmhPf70h88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uop4K-005MU7-Vv; Wed, 20 Aug 2025 22:06:00 +0200
Date: Wed, 20 Aug 2025 22:06:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <7696f764-7046-4967-813e-5a14557b9711@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112856.1446278-2-dong100@mucse.com>

> +/**
> + * rnpgbe_init_module - Driver init routine
> + *
> + * rnpgbe_init_module is called when driver insmod
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int __init rnpgbe_init_module(void)
> +{
> +	return pci_register_driver(&rnpgbe_driver);
> +}
> +
> +module_init(rnpgbe_init_module);
> +
> +/**
> + * rnpgbe_exit_module - Driver remove routine
> + *
> + * rnpgbe_exit_module is called when driver is removed
> + **/
> +static void __exit rnpgbe_exit_module(void)
> +{
> +	pci_unregister_driver(&rnpgbe_driver);
> +}
> +
> +module_exit(rnpgbe_exit_module);

This can be replaced by module_pci_driver()


    Andrew

---
pw-bot: cr

