Return-Path: <netdev+bounces-97135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66CD8C94DE
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 16:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07C328157A
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225184503A;
	Sun, 19 May 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y1C9pHte"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB08BEA;
	Sun, 19 May 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127255; cv=none; b=vEd9OiRMzeU+TW5nmcTocpS2BCxptANcuFM/KYnGh0Y75k0um3fdnNqoN0ukvUpsttBljisiVbhEmRI0LGrpj0drbJcI/8NNaXp6CrU8TY7Ap0w9rUncKixOOEq73UB4TZt4hrFLOsJV63ukRWYjc+T+uHijHkTbSZPlQR5SXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127255; c=relaxed/simple;
	bh=q29JoiujTS2XkolE6zF5+VhKvwJw4Z7qx2SIZperaRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qys5xQ58T1atpNBOzkb2jfIhM8RHW6WIrogTvvxmG/pFhC5a0boWMJ/gbmcG2gdy2dX4vA3WSSTSww3DyfXNjYFxwZOAjFfd/TBk+iUONKrPLAskeJBmPd0DgAzwwAE7crS3sZDlELsk71EViYKfA2ogli8nHsRiqIzds9aCmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y1C9pHte; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UYsczhSMQVTcPtKcf8myz36ovdn5xE0T0cUehFANQaI=; b=Y1C9pHtertFWleTQDsvZ5j/0kD
	TXtqk93sdYj1Ugwm8ZnYXN65UV8D4FvavTl6n2e2IhROmLQi3dmRhHk2F+M6rvGjMj6qHQchnt4h9
	SYdkWzpkt6/v2p/duAGLGF9cQP1wgwu7tXZAXigVVYSXOoRrvn26Mzetr7R/BW9j3wr6NsrJFtDq9
	Yw37NPG8xX79BEE4pRHxHXKCpU+LVCrR0/1rjXbPoEaXWYjQ0r2vhxb08qbV1tZnEUvcjvNP9HqWj
	gCc6QBm6OKThPwIfv2to8eQGh5NsKViokgz0A96Xpx1b0LCrq8YevSfW4u+QGrGBfYhZ8yiM8zE+0
	DzoCTXcA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8h5f-0000000F4a1-07t2;
	Sun, 19 May 2024 14:00:43 +0000
Date: Sun, 19 May 2024 15:00:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	MD Danish Anwar <danishanwar@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Roger Quadros <rogerq@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	Sriramakrishnan <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH net-next 12/28] net: ethernet: ti: cpsw-proxy-client:
 add NAPI RX polling function
Message-ID: <ZkoGCpq1XN4t7wHS@casper.infradead.org>
References: <20240518124234.2671651-13-s-vadapalli@ti.com>
 <f9470c3b-5f69-41fa-b0f4-ade18053473a@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9470c3b-5f69-41fa-b0f4-ade18053473a@web.de>


FYI, Markus can be safely ignored.  His opinions are well-established as
being irrelevant.

On Sun, May 19, 2024 at 03:18:52PM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
> …
> > @@ -988,6 +994,189 @@ static int vport_tx_poll(struct napi_struct *napi_tx, int budget)
> …
> > +static int vport_rx_packets(struct virtual_port *vport, u32 rx_chan_idx)
> > +{
> …
> > +	if (unlikely(!netif_running(skb->dev))) {
> > +		dev_kfree_skb_any(skb);
> > +		return -ENODEV;
> > +	}
> 
> I suggest to move such exception handling to the end of this function implementation
> so that it can be better reused also by another if branch.
> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources
> 
> How do you think about to increase the application of scope-based resource management
> also for such a software component?
> https://elixir.bootlin.com/linux/v6.9.1/source/include/linux/cleanup.h
> 
> Regards,
> Markus
> 

