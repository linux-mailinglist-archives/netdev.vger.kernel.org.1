Return-Path: <netdev+bounces-211788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFEB1BB9D
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898E13AE9F5
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7D222562;
	Tue,  5 Aug 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l5A1mj8q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC398632;
	Tue,  5 Aug 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428043; cv=none; b=hrlF6UZZq6yd0IsxYU7VIi/7UBajxk/OKSt18JhjNY0G/ya2zXU+gtCV6R37xunZoNroi5RHJP5nREPdY420vEQ/7GKEZzYTUrhbbea+JIbJZL1vcrp7ez9OQSalm4vLJaA1d2lX06wvVGGYenaTdSWYIDBb72pbeskupBNiwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428043; c=relaxed/simple;
	bh=35Fdsr6wjHQ8skd1EwEzUFjigS1x6HVQWmfRkNwHPAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7qQ6nc/S0Lj7ejwvJ8IW43Ja1RURByeyQzRMBerj6+ORRqL9InOa/b5VIm8oiptSzQ68NYyjpVXi7sEg1+MOLdfqZYwl8GOqULAyh9n702F2x81HSfOw4HqvmbzznNq2hzhBg2TtFDoR1O7/85pds7LeMHNwqtCRHXOyTNAFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l5A1mj8q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9b9i47N2hN51JYCksU49+E73DkaYdsYznNi6qRyjP2o=; b=l5A1mj8qyUXiNYdEnCROkG0fnc
	CfxTeZVTkTS3GEMvYksMoX3/JG/ftB6ekDLe/RZkysQlnskMNp031c7eAfC1ZEf0qMGCFK92mCo50
	MmJjUSV1Yq2KTrepkbA0tuOxDVqLojQRwX/wt696+6X6dgDE2vau+A9h5NpBWd1pOl1w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujOsL-003pKI-WA; Tue, 05 Aug 2025 23:07:14 +0200
Date: Tue, 5 Aug 2025 23:07:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v4 3/7] net: axienet: Use MDIO bus device in
 prints
Message-ID: <8a28ce41-f28d-4089-8a8e-a82ae2ccfc82@lunn.ch>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-4-sean.anderson@linux.dev>

On Tue, Aug 05, 2025 at 11:34:52AM -0400, Sean Anderson wrote:
> For clarity and to remove the dependency on the parent netdev, use the
> MDIO bus device in print statements.

> @@ -186,28 +187,31 @@ static int axienet_mdio_enable(struct axienet_local *lp, struct device_node *np)
>  		/* Legacy fallback: detect CPU clock frequency and use as AXI
>  		 * bus clock frequency. This only works on certain platforms.
>  		 */
> -		np1 = of_find_node_by_name(NULL, "cpu");
> +		np1 = of_find_node_by_name(NULL, "lpu");

There is nothing about dev in this change?

	Andrew

