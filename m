Return-Path: <netdev+bounces-88701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CD8A84C7
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A261F2189E
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E713E8A5;
	Wed, 17 Apr 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RxEGi3nr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459213E02D;
	Wed, 17 Apr 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360851; cv=none; b=DgsKHuh2I6Hc9EijE+o3okXTQgXCgaFqk3i2pOo3OTfHUG9rNWpIVPxOQt4wOaBPNJrpVBA9wi0yxWMjxYHlrq3JL+gArDfjDOQWfDEfQ187CuxjRNRxpkPG9t3NdEk8J+gR9wLt3kNRyr2m+/E5+YlTTh5u6Jpqot5J74hruzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360851; c=relaxed/simple;
	bh=aQcO95X2YDayvEgZwYF7Y0HH5gl2nj4E2k40yFkxmCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeOcveOvH3Qn+uM+pEJRxK5snC0CSG2Hbuwr9VIqwI6O+pyE2GOOzbFABiLUzpxzgEydskHcvhAjv75TKwp0pf9ZGA+cs5d0/ZsitNo9FarNrps3e/77N9njYgidFI9ppmLQiEwloj5r5ZFJxhJqxrOkz4ejUnUZUT6IxsElQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RxEGi3nr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ip6osXPpFGLAydoGMS8624o8C0UaDT270P9fTYsmPSs=; b=RxEGi3nrirqL9fBPouI8bztsWG
	yD8aGsUbTN4nrYkPOq7O21ANt0KpwaSV7+7yioRpsMKfxOSYyF6zf06Gf8+i/BPDfCac1bE59cpmJ
	dI9J+y9Eod7YtgP+uTGeFvqiw+UbFLCbkCXawJVnlJ0tDChybDLLrHq6tfYcHYYr3Bms=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rx5QI-00DFK0-U9; Wed, 17 Apr 2024 15:34:02 +0200
Date: Wed, 17 Apr 2024 15:34:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Message-ID: <49c221e6-92d0-42ef-b48b-829c7c47d790@lunn.ch>
References: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
 <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com>
 <26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch>
 <20240416.222119.1989306221012409360.fujita.tomonori@gmail.com>
 <b03584c7-205e-483f-96f0-dde533cf0536@proton.me>
 <f908e54a-b0e6-49d5-b4ff-768072755a78@lunn.ch>
 <92b60274-6b32-4dfd-9e46-d447184572d2@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b60274-6b32-4dfd-9e46-d447184572d2@proton.me>

> If the driver shouldn't be concerned with how the access gets handled,
> why do we even have a naming problem?

History.

The current C code does not cleanly separate register spaces from
access mechanisms.

C22 register space is simple, you can only access it using C22 bus
protocol. However C45 register space can be accessed in two ways,
either using C45 bus protocol, or using C45 over C22. The driver
should not care, it just wants to read/write a C45 register.  But the
current core mixes the two concepts of C45 register space and access
mechanisms. There have been a few attempts to clean this up, but
nothing landed yet.

Now this driver is somewhat special. The PHY itself only implements
one of the two access mechanisms, C45 bus protocol. So this driver
could side-step this mess and define access functions which go
straight to C45 bus protocol. However, some day a non-special
device/driver will come along, and we will need the generic access
functions, which leave the core to decide on C45 bus protocol or C45
over C22. Ideally these generic functions should have the natural name
for accessing C45 registers, and the special case in this driver
should use a different name.

       Andrew

