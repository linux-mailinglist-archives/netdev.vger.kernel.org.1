Return-Path: <netdev+bounces-102208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6598A901EAE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636811C21705
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7D7440B;
	Mon, 10 Jun 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QbwMMYgS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F242AA1
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013561; cv=none; b=V7atwSKzqLH4vWwEP62qiMI8SOpnkgr0DMxx8dz0/LlmcDBAMg+2njrsqlhFKBUXGwWf72UE45BB778anPrvHxneUsA8iuRHGZ7rNAyskaeFSuq5gxrt81YoC10I+zOfrwQYTFqxUM0w9mO0Fi/dQCshvnK32Q6IQ87TI36t1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013561; c=relaxed/simple;
	bh=X3avnWcdAQQnb02yEUgwbHqmnlbhkLCrM0PFfi6OjnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvv/37TsXtZF30UVgeTQ+bKr31/SxKLTEcj36CXRjOBPvev9k23woSpO+809kajrIw60Semc+JgpdHcnDFjr6Oi7XlNY5BZQrO34tT/LY9GkH7MK6wQk2CsDJ9+BxXCVCzxLJasvWIjkhYkOxHIZ3c81bOonHXXLqEJudF1hUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QbwMMYgS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hPFJ4/o1y8HqDDSDHnCpeKjF3EupMpapZLzzfsx6684=; b=QbwMMYgSPagTIY0+Z1IE6d1w40
	a/c80fxf/cJqC0Gp8XmxwOh0UedZqO5HYZVlbFjdZc+aFVtLQ8WCfTrItNtu6e2mIUOFn+GHXSDML
	xJSkauvOM6SBqn1h+0RjlFVUhplnIY1IidilKRGHDcp2usGAOOgkWHquy7I9Mv8WkHirRfgduBwqr
	t28yDVQJsmhUx4ykts+IblH9BdBvmWtsx5DGM3Y6N/8gLpLPFB1eEPbYPPCGNoCwkKw7RMVqgdcF4
	c84b9A3w+N0Oxx4BhX7cntJ2icpXkAv3PkXFXmPxI3tIw6GidFwA+dkZkMy9KZPSJf5KtVEY40eaF
	uPcmRkaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55318)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGbnx-0001GK-26;
	Mon, 10 Jun 2024 10:59:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGbnw-0006mb-W9; Mon, 10 Jun 2024 10:59:09 +0100
Date: Mon, 10 Jun 2024 10:59:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 4/6] net: tn40xx: add basic Rx handling
Message-ID: <ZmbObG9lRO8w0FkJ@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <20240605232608.65471-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605232608.65471-5-fujita.tomonori@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 06, 2024 at 08:26:06AM +0900, FUJITA Tomonori wrote:
> +static int tn40_rxdb_alloc_elem(struct tn40_rxdb *db)
> +{
> +	return db->stack[--(db->top)];

Parens are unnecessary here.

> +static void tn40_rxdb_free_elem(struct tn40_rxdb *db, unsigned int n)
> +{
> +	db->stack[(db->top)++] = n;

Same here.

> +	dno = tn40_rxdb_available(db) - 1;
> +	i = dno;
> +	while (i > 0) {
> +		page = page_pool_dev_alloc_pages(priv->page_pool);
> +		if (!page)
> +			break;
> +
> +		idx = tn40_rxdb_alloc_elem(db);
> +		tn40_set_rx_desc(priv, idx, page_pool_get_dma_addr(page));
> +		dm = tn40_rxdb_addr_elem(db, idx);
> +		dm->page = page;
> +
> +		i--;
> +	}

While reviewing the rxdb stack, I came across this - this while() loop
is an open-coded for() loop:

	for (i = dno; i > 0; i--) {
		page = page_pool_dev_alloc_pages(priv->page_pool);
		...
		dm->page = page;
	}

Is there any reason not to use a for() loop here?

> +	if (i != dno)
> +		tn40_write_reg(priv, f->m.reg_wptr,
> +			       f->m.wptr & TN40_TXF_WPTR_WR_PTR);

...

>+struct tn40_rxdb {
> +	int *stack;
> +	struct tn40_rx_map *elems;
> +	int nelem;
> +	int top;

I assume neither of these should ever be negative, so should these be
"unsigned int" ?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

