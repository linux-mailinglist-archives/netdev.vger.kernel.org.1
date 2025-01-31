Return-Path: <netdev+bounces-161782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57694A23F47
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF057A0668
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555BD1C1F13;
	Fri, 31 Jan 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pcSCMT6z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBD219FC;
	Fri, 31 Jan 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334890; cv=none; b=DVYikWw03Nbpxa4qcxSDuS9X/BEzCN5Ds2+xfGSWj5KXbp/ZBjiQyo3fTCpRMc8Gyhru4HnVoRdSOXoFoAKwBb1s0k4Fq7dZPVoqIsszqmDgbKcwBR1uQTCP6+raZpXMYLYvYeQznv2KuKEAoT25gAhqBOODI/0Ba04dsFlXsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334890; c=relaxed/simple;
	bh=nU69uETKpWF2F7Yg9M0TKEPpyQXqPi9etsrOLG5dARU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBz1mmTFKEKz3LAUIQZQ1a3x1ampCgbkFvDcxsNYkTkUgc5MZ5E1k1k2kHpC9RrsCepd/j9zOkjl7QTb6Zgc7Hcvt0YWvg7GQQaOyBSybpE46EOw/gMn2kB7jbzlyU6Z60CnnTDPAjl+qXgTP8m07SaIcUiKNALGQox+Ksjz1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pcSCMT6z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dNcchyzdUcu2AsYFFJOvHUFw3QqnezpZp7xNZQD6k90=; b=pcSCMT6zB7lvMPhHEpxqdc+cDu
	BeLdDoxtJ+n2KGZxTAZ/bm3dXrrYPDKT8hUV4j2kZ/7+Pz8N/aOL4i2OMTDDQ/Iep6arMz7bgYU+y
	OFlJxDxxd75mqk/6ZBdCMGrO4OItN6B3cWKt8n7wpux+zOj0RUZg5eflKBnBLXMn3IBg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdsJ7-009ida-W3; Fri, 31 Jan 2025 15:47:45 +0100
Date: Fri, 31 Jan 2025 15:47:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steven Price <steven.price@arm.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability
 value when FIFO size isn't specified
Message-ID: <a4e31542-3534-4856-a90f-e47960ed0907@lunn.ch>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
 <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
 <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>

> > I'm guessing, but in your setup, i assume the value is never written
> > to a register, hence 0 is O.K. e.g. dwmac1000_dma_operation_mode_rx(),
> > the fifosz value is used to determine if flow control can be used, but
> > is otherwise ignored.
> 
> I haven't traced the code, but that fits my assumptions too.

I could probably figure it out using code review, but do you know
which set of DMA operations your hardware uses? A quick look at
dwmac-rk.c i see:

        /* If the stmmac is not already selected as gmac4,
         * then make sure we fallback to gmac.
         */
        if (!plat_dat->has_gmac4)
                plat_dat->has_gmac = true;

Which suggests there are two variants of the RockChip MAC.

	Andrew

