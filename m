Return-Path: <netdev+bounces-118113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAD9508EF
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DCF1C2402B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0919FA6B;
	Tue, 13 Aug 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L6wEfXzG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0619925A;
	Tue, 13 Aug 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562602; cv=none; b=Nn9iKOtqZf6RuiXRFFQmA7H2cGJP5+qMqDkLR5P1MgcK8H2iavFQoBG7O3xsjeV5PIJjL9/W4BXphhrKTet/YjYluItAciHbWTsR6qZgsZt+wICCDgYMFD/odOCxOEzk3SR3HxQBwW89cVmudYik0kzk6O4MmNEEGuzgGTHyj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562602; c=relaxed/simple;
	bh=NTkQs0Af3L/SAagPlvcpiuyXx574nzjMiR7hobHTfVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6gurXijJFdcpTcdCqVyBpPvH66JJE+XNe45CJLBYhR7JJt15X2uwdqmxAbOQNHrb1yCAAlndzYBP4N6chxJl4A26LONkbP9aP1WGXLGE+wIP8cdSKymKlmgeglG6wl9eHeV7pZpIBiXASR4GmZmVH/iwaJFSmg6+W3nqXf2KIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L6wEfXzG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JZ2l5RamidfdZzqlVKYX21MPAXo5/WvszqGbg4rd2KI=; b=L6wEfXzGshZS6PUtqrntoDwdWJ
	2hqFVOcto6hCkLdSrksn3/49pKfETy23+AwkSTs9GJjEMWtgQ8l+HHIh2C60ZWctv9uzDU8TA7jia
	zIe5K487f+k3+rNY6T9cnHkebbsMOSGqEdI3FGGXjFlgBA7tuuoE9crVcQF4YM/DFFCQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdtMY-004h9S-7y; Tue, 13 Aug 2024 17:23:06 +0200
Date: Tue, 13 Aug 2024 17:23:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] net: ti: icssg-prueth: Enable HSR Tx
 Packet duplication offload
Message-ID: <985e10e4-49df-46d8-b9c2-d385dab569a9@lunn.ch>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-6-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813074233.2473876-6-danishanwar@ti.com>

> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -41,7 +41,8 @@
>  #define DEFAULT_PORT_MASK	1
>  #define DEFAULT_UNTAG_MASK	1
>  
> -#define NETIF_PRUETH_HSR_OFFLOAD	NETIF_F_HW_HSR_FWD
> +#define NETIF_PRUETH_HSR_OFFLOAD	(NETIF_F_HW_HSR_FWD | \
> +					 NETIF_F_HW_HSR_DUP)

Ah! Now i see why you added the alias. This is O.K. then.

Maybe NETIF_PRUETH_HSR_OFFLOAD_FEATURES, although that is a bit long,
but it makes it clear it is a collection of features, not an alias for
one feature.


	Andrew

