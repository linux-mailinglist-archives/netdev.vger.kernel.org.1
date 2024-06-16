Return-Path: <netdev+bounces-103824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD23909B1B
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 03:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D112825FF
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46D215444A;
	Sun, 16 Jun 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f1ePalmS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E32F26
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718501339; cv=none; b=h/jIi6yGfj9DBYMWYGzQkCcxRaeqN2FRz9FoeabNKCzJV3aIczo939gQTen2lI8Ue4MvwZ8X1q3XwhvVH2u4HLlbcq8osVmOY516DRY6wBjq+5ocY0SD9Sz6eOqPwG/QBYSB0RpuCIv/0oTXVMylvo7em7qMh78dPrPfEE1kSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718501339; c=relaxed/simple;
	bh=WZb6QemE0YMVCSk9AeHnfPI+fJA0YPn2LOrbCYrHaBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y18GvEMunjzRLDB8ZdTfgKSH3nqGthDVhr29+L4VPwukbF7hCDMgj/wJzlvTt+0nxHZG0isPU0cZLEpDzqo0HizFz1ZgebczXZqkCEmBfhRdMaimJv6t/mUSNJh80y7Qepo1zvSLZyUBREud43PEtK7yZyM1sHUYo53j2wh7UWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f1ePalmS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r4A2afidkf5Ijhhpp5wDWOozCCjDfrWJG2qc5f9aS1o=; b=f1ePalmSoauJo5vbhulYs6wp+q
	C8U79O9XGLVtFLRqSrANA1s3qESS/oqfWdX+1eLzfQMbypNTWV3dU5E2DwwaTlnCR5o3OU/hsV1PK
	zn+WulnTNVRKo2Eqs7UV/B91+F+YCmnM/CjgSEDMAgnV0OqDntIu4TBF8sVsACG5X8NQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIehS-0009yX-TL; Sun, 16 Jun 2024 03:28:54 +0200
Date: Sun, 16 Jun 2024 03:28:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Laight <David.Laight@aculab.com>
Cc: 'Shannon Nelson' <shannon.nelson@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>,
	"drivers@pensando.io" <drivers@pensando.io>
Subject: Re: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Message-ID: <ead82f17-b890-4834-9b18-8c548ed985d5@lunn.ch>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-8-shannon.nelson@amd.com>
 <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>

> > --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> > @@ -206,7 +206,7 @@ struct ionic_lif {
> >  	unsigned int nxqs;
> >  	unsigned int ntxq_descs;
> >  	unsigned int nrxq_descs;
> > -	u32 rx_copybreak;
> > +	u16 rx_copybreak;
> >  	u64 rxq_features;
> >  	u16 rx_mode;
> 
> There seem to be 6 pad bytes here - why not just use them??

Or at least move rx_copybreak next to rx_mode so the compiler can pack
them together.

It would be good to include some output from pahole in the commit
message to show the goal of this patch has actually been reached.

     Andrew

