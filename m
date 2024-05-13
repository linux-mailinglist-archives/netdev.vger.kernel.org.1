Return-Path: <netdev+bounces-96153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465C8C481E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A945285B53
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E587D40D;
	Mon, 13 May 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RHVUT5fc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AB39FD8;
	Mon, 13 May 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631735; cv=none; b=hDOxKTpf6XdcqAKOU1RVyGsaz4/L6HR8DPnx/tNI3kA0ftO73nMSjZkX+nxiXSGqLZDiLblQLbfq+jiROL5ZteQacBtk9u2KOysm1vaK4Cx8lel5Sim3uxN9WaTcuP1vXvos3I+dRH9pp8noFEvzG2LpoR+EvGwcC1JDod/Vph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631735; c=relaxed/simple;
	bh=xkIyIbZAjoDJctNIIOzX6lUajmD5zufFz56zALxN/9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtDL3AuNsusCK1F0DJmhpK71vZmXzDiN8DBPB7ov9DVgF1im5WxJ7hvWzMFFJ0lE3L+pvAdmwP8P05/WI+bmff0V1hZ/1zH1j8avc98FfVwGJ9WNIfR99DSE1V40k+t8zjDC0n2WDHHUbRWagXNY+lnZRHmrOpVTHY2D2eccg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RHVUT5fc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DtIfyWjCrgt1EGu9Lx9mzz635kI1F/8RrAF0bzMyy8M=; b=RHVUT5fcdaSQi2xY9RuDoEotGV
	D8Q+vaZuNHykP1iItOiM1cP3c0rgA5U+5D8Qj4ptLlD8F1ZnjX2oXjeq0RlIJvbaNIRCwArPTWLJv
	3NBJMBQR1GPStEAWw9L9unnnBaDgNM78dbtwHi9Sixr7hmAn2IL72LbWfJ5JBY9rkmJc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6cBQ-00FKk3-2V; Mon, 13 May 2024 22:22:04 +0200
Date: Mon, 13 May 2024 22:22:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <9006463d-27db-4715-a1ab-61c41823ce3c@lunn.ch>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240513173546.679061-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513173546.679061-2-admiyo@os.amperecomputing.com>

> +struct mctp_pcc_hw_addr {
> +	int inbox_index;
> +	int outbox_index;
> +};

> +static void  mctp_pcc_setup(struct net_device *ndev)
> +{
> +	ndev->type = ARPHRD_MCTP;
> +	ndev->hard_header_len = 0;
> +	ndev->addr_len = sizeof(struct mctp_pcc_hw_addr);

Another reason you should be using u32. ndev->addr_len is going to
vary between 32 and 64 bit systems. I also wounder if when calling
dev_addr_set() these need to be byte swapped? Does the specification
define this?

     Andrew

