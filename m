Return-Path: <netdev+bounces-192657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB964AC0B9A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA3F1BC5548
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE328AB12;
	Thu, 22 May 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TF+AWf/a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256E28B41A
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917013; cv=none; b=lhSOrIEgh6Ug5nTrppNdf4yRtwXVhY0jNXhgFOd4BMGBV8cNePrdKbCiXwChu3pWxCIQ3r9CSRaaMviGJMiOkaOZ/0oUat+lHiXbexoZLit9AQuxpnJrW0wsDKPB+4kFG3/elerYHgS7iveJuOYraLErmoceAU274xaQXWNPsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917013; c=relaxed/simple;
	bh=Gac4+zSqOFgZP8b/FlbLVQWAbELY96H275svZbRTUFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP3CUSVHYA+D+NnhnSyIvdxK9NpiqG+qR6A2ilatOfvktAww8nhyHQYe8vSMKeZqw93RHdXrjxHbkP5SFPT4Uy9uCY3bqbeHj/6G31nLbF/dsIgWqW856E7tHDEVZi/PkQ5pBYGqcid1JRUqO75J+k3dvaoGDdCYMNN5zZMV2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TF+AWf/a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E9WXMhK4l3RlK7B2gxhPqbmwHHtvcoh/EBUmKFm+nto=; b=TF+AWf/aMigAbT67u2PubAtLfl
	zY47zb7o8QXugAbsWGD8c8Fs05Ou/0V5sD1vpCRSuqxCWIvTmhxrzwJ6Gp47fhKBCNVm4mAz8af08
	Q5jv48qYPPiL9QAWGzLIpVunFLbOgbHAwO9q3HwRbCwXIHsZFFzMUGfSbaG6DdKmj7kk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uI53g-00DUbU-6A; Thu, 22 May 2025 14:30:00 +0200
Date: Thu, 22 May 2025 14:30:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Allen, Neil" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v9 net-next 5/8] net: ena: Add debugfs support to the ENA
 driver
Message-ID: <42091367-4dce-4c6f-8588-ffad8a66de3b@lunn.ch>
References: <20250521114254.369-1-darinzon@amazon.com>
 <20250521114254.369-6-darinzon@amazon.com>
 <0754879f-5dbe-4748-8af3-0a588c90bcc0@lunn.ch>
 <8b4dc75950b24bd6a98cb26661533f70@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4dc75950b24bd6a98cb26661533f70@amazon.com>

On Thu, May 22, 2025 at 05:24:10AM +0000, Arinzon, David wrote:
> > > +void ena_debugfs_init(struct net_device *dev) {
> > > +     struct ena_adapter *adapter = netdev_priv(dev);
> > > +
> > > +     adapter->debugfs_base =
> > > +             debugfs_create_dir(dev_name(&adapter->pdev->dev), NULL);
> > > +     if (IS_ERR(adapter->debugfs_base))
> > > +             netdev_err(dev, "Failed to create debugfs dir\n");
> > 
> > Don't check return codes from debugfs_ calls. It does not matter if it fails, it is
> > just debug, and all debugfs_ calls are happy to take a NULL pointer,
> > ERR_PTR() etc.
> > 
> >         Andrew
> 
> Thank you for the feedback.
> We were looking to get a failure indication and not continue creating the rest of the nodes (patch 6/8).

That will automagically happen, because when you pass the ERR_PTR from
debugfs_create_dir() to other functions, they become NOPs.

If you look around, you will find bot drivers submitting patches
removing such checks, because they are not wanted nor needed.

	Andrew


