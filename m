Return-Path: <netdev+bounces-151464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1D9EF773
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CDE188BA25
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB422333F;
	Thu, 12 Dec 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2hxl3fO9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AE223327;
	Thu, 12 Dec 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024044; cv=none; b=bf0ojfZO9LUvWx/ooY1DeWq54kGqkOfIM2KdLpgIRoQ8AhvKXF9Msp5xsVlAtrqnNBmiz4bT8iwBfO0mBOEIxab/4t5npFjCa6lqWQO855GvguOuhrczIhvuchFt6d2BHEior9IUwmcD0fmZaB0Obcp15PjOA7mTFm3rZ9EWah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024044; c=relaxed/simple;
	bh=nEL1Nln5VbF6WYXX3rYFidkTq+2qanCp3O2YILnbY5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APzYXdWZLoegApSRe9zgH6wZXdx1C/YDsc+HpgAxxGwVPSxsRnOZqiwqXZy3L9ssmHFYHJ1vfx9uW4Bjl/UywQSnfQ1tKpHg9cybMa2/J+WNKidoui3PC4mzissj/7d0mVrgY9IkpryKG+Emspsv+DqWP7dsHo4ukJYI4v38W9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2hxl3fO9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b9F8LqdRCf2qX612itKyqaJ6Zd7zPIwHtJcTZ/FJ7KI=; b=2hxl3fO9ZovTuvQfjRMhY2NJEf
	Gky3y4qBJyIwAU52dKZIjodmDn2RmDz9MbLmG7mgz2biRfyltkyD/2BJ/+1YzBCzUy6B/1AbbG02o
	cgzMLQOvMjfiE+PUmzbw/H9XUd71XjtI+pzo55r504PuHY1RfbX7EtaqMahIxCfHly8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLmrS-000Eck-C8; Thu, 12 Dec 2024 18:20:26 +0100
Date: Thu, 12 Dec 2024 18:20:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenz Brun <lorenz@brun.one>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manuel Ullmann <labre@posteo.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: keep rings across suspend/resume
Message-ID: <bbcd37de-c731-4f0b-92f0-8c332bb01c5b@lunn.ch>
References: <20241212023946.3979643-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212023946.3979643-1-lorenz@brun.one>

On Thu, Dec 12, 2024 at 03:39:24AM +0100, Lorenz Brun wrote:
> The rings are order-6 allocations which tend to fail on suspend due to
> fragmentation. As memory is kept during suspend/resume, we don't need to
> reallocate them.

I don't know this driver. Are there other reasons to reallocate the
rings? Change of MTU? ethtool settings? If they are also potentially
going to run into memory fragmentation issues, maybe it would be
better to use smaller order allocations, or vmalloc, if the hardware
supports that, etc.

	Andrew

