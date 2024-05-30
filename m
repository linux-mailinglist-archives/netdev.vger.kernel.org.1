Return-Path: <netdev+bounces-99415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5388D4CC2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EADB22955
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6617C20C;
	Thu, 30 May 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oU7Lb7xD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C717C205
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075762; cv=none; b=Y+9OC5iTUsKcpk8S//XnKOt3QEumZY7NwBUo24R3pnp8mbFdxmKjxL1hGtKPjEoVvibZzaAwYBUNuqMILmlYSn6YmJkADmL+oKwC2kJQIeL+7ERJt7Vb3yTttx4dX0L0PmgNu6c6n00DabpK5jzYR+ApX36RaG2cONbKABQcgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075762; c=relaxed/simple;
	bh=kzQ/XMdWwWYH1mgeCoAAXTuW2DtzEjf6f3nCdfTKpKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGob5LAMq85R4RbFUqp8DEZpHmmPebwM4QBrLG8ESky/7XkQ2dsk14PQ19sM6sz25ApLNCHriVGGxJKU9pdP0/cXqr34o6DoxR8IJumK0U7HNs4Sx8FO5DporCa27rPi4+8WTDDv8u4GmxWV2jjbg9/EysaAbWdppOLtndQM/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oU7Lb7xD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zaaR4GEZoawvgKVO+pYrWcaDPCyAIpfrdUrWtwUk3sU=; b=oU7Lb7xDgZsJmkTuf+Fn/EqVDh
	EDy3FUv/ZeA/Ja5Qu1XicWSPA2cKuzsJswIFFGuuvUB6f3+BUe4PgDYkD06WXCd5GNGlMTaZVc/ph
	V0qdQnKxWRmO6QWSEkQmr6klb6e1fF2wvbvKDbpai8kTsmvMt584zyJXEq/YZKh4W0e0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCfqH-00GLp1-JV; Thu, 30 May 2024 15:29:17 +0200
Date: Thu, 30 May 2024 15:29:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"woojung.huh@microchip.com" <woojung.huh@microchip.com>,
	"embedded-discuss@lists.savoirfairelinux.net" <embedded-discuss@lists.savoirfairelinux.net>
Subject: Re: [PATCH v3 5/5] net: dsa: microchip: monitor potential faults in
 half-duplex mode
Message-ID: <c6db5181-2442-4e7f-a9c0-a1dbcc0d4b30@lunn.ch>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240530102436.226189-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <PH0PR18MB4474DD8CA750ECCCEB7FEADBDEF32@PH0PR18MB4474.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4474DD8CA750ECCCEB7FEADBDEF32@PH0PR18MB4474.namprd18.prod.outlook.com>

> > +void ksz9477_errata_monitor(struct ksz_device *dev, int port,
> > +			    u64 tx_late_col)
> > +{
> > +	u8 status;
> > +	u16 pqm;
> > +	u32 pmavbc;
> > +
>           Follow reverse x-mas tree notation.


Hi Hariprasad

Please trim messages when replying. Just quote what is needed.

       Andrew

