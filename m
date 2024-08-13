Return-Path: <netdev+bounces-118102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD89950826
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CB92823BA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9B19E7F0;
	Tue, 13 Aug 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TsVuNFJk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D831D68F;
	Tue, 13 Aug 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560564; cv=none; b=iUfchYFDkJRI+iK99k7DDBbdNRjOJY5fM+l6zoagJgJUrbADflpJp98+DlDSQ3SWAGsfnysYeeTWKdisTxcND12ta6EJ110xJH1hZnbIX5eco2FLRVYUNCDo71rvlab60Kr++8We7tmmR91KV1Flrfh4Y34s5rzCFbtXEZLTdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560564; c=relaxed/simple;
	bh=eKAFtxfe3WjpD/wJ9WqgI8OwGa3aCiCULBhyS9dJYXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2tjocyXHKKaCXWtCl4DOEWGWoWiXAVLTMfS2L2ne79T7a2t5K7rcn6QY/hhDsG75MyChuLcn31T9pZACzaLKHkeSOXDJhCnqh+bBVunf/pdB+YV0IWANnvT6r9jWA/4GZw93JvJGy+wL6+Oo07F1W54c1CrQ2HLnir1eWmc9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TsVuNFJk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0lfp6nagyhciCgC/QzGGnBlgoKe5jE6/jttac0345ow=; b=TsVuNFJkeT228myPosyARUBkx9
	ZARDi6JW6vugzRx86naIbYOgoUC5GyKsCwK85ecY5PVqzNIcRdXcnnoS79/zNikW8a3BWJN8Rbj63
	UG27h94hQrLqenUBISbiG3JO1XAFd6bHcvFrf26hcgSGtW+vsYJ8mcn1jmxLAMX99mX0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdspe-004gxr-2e; Tue, 13 Aug 2024 16:49:06 +0200
Date: Tue, 13 Aug 2024 16:49:06 +0200
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
Subject: Re: [PATCH net-next v2 0/7] Introduce HSR offload support for ICSSG
Message-ID: <d061bfb6-0ccc-4a41-adad-68a90a340475@lunn.ch>
References: <20240813074233.2473876-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813074233.2473876-1-danishanwar@ti.com>

On Tue, Aug 13, 2024 at 01:12:26PM +0530, MD Danish Anwar wrote:
> Hi All,
> This series introduces HSR offload support for ICSSG driver. To support HSR
> offload to hardware, ICSSG HSR firmware is used.

Oh, no, not another firmware. How does this interact with using the
switch firmware and switchdev? I see in your examples you talk about
HSR to Dual EMAC, but what about HSR and Switchdev?

How many more different firmwares do you have?

	Andrew

