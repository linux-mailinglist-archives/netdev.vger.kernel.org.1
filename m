Return-Path: <netdev+bounces-158521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E272A12599
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237AC167DE5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170013596F;
	Wed, 15 Jan 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irzahDcP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FD2BB04
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950135; cv=none; b=j6iV5xytZ8cmvkpB2sQCLQY1AJ0+JFIT32KnIVcWDRcKg/k/Gu+agtvq9G4JzeBRBfAfK5U1BHTsq3usvG0wqlYKGnrgYJ9b7N3s4GWShAr+YGz0vsXfWqkPzU5tKXqrD/QaqWMrpSu5J0y67pbbkJzm+MPAzK7T6AOsxCj4gyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950135; c=relaxed/simple;
	bh=0A4vE5y/i+GEpN1PHegU9wS46NVDEpUOqXd4+Q/0Hww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIlcC8Es/83ACT2R+CGB+M1r3IUBmvG4fZUGRwtrJ1wN16109Upg45GBFH7Lys17x1OnoZCcLfuyzdPHLeZ0ciL6dbYVgiwGbVJeWBmN2yQZ9A1c5Ima1q7it1gPyk59DSycQrNa/gdijR1OWcWHm0p3Zp3RZkDhV1/ihosjF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irzahDcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F87C4CEE5;
	Wed, 15 Jan 2025 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736950134;
	bh=0A4vE5y/i+GEpN1PHegU9wS46NVDEpUOqXd4+Q/0Hww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=irzahDcPakl18KvZYOWGTdCFx54eXlTi1neQEoZ4ndvhGJsI5ztP7hRdDHAgsmw8m
	 JPRFiFic+t5iyQlJyxK/SMIYa73q/JcxcQhHSl8kL2imi+GFuQpXXHa/EXP4WKSuSm
	 P4MirFCzm6L8FQavY2PpzIaUPDsQ/zx7PtkyGaNbUjxRT7y6Ozq/+jO1EOqN6+rU2b
	 /ItoT1siulBU5H8UfMOfIu1q4M795+5rQx6VW6D5przduLRySYkiKdNQ0eKWtU027f
	 XKo/g3MuB8bjai59XV7S3b91w7aD8zfzEvkMeyAkWFefD1sGU/ZOl1+jKThYcnMAl/
	 munLvgxr+fgbg==
Date: Wed, 15 Jan 2025 06:08:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <jiri@resnulli.us>,
 <anthony.l.nguyen@intel.com>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <jdamato@fastly.com>,
 <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 01/11] net: add netdev_lock() /
 netdev_unlock() helpers
Message-ID: <20250115060853.0f592332@kernel.org>
In-Reply-To: <e7479c79-525d-4796-b9ed-7ae2ddb5435b@intel.com>
References: <20250115035319.559603-1-kuba@kernel.org>
	<20250115035319.559603-2-kuba@kernel.org>
	<e7479c79-525d-4796-b9ed-7ae2ddb5435b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 09:36:11 +0100 Przemek Kitszel wrote:
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index bced03fb349e..891c5bdb894c 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2444,8 +2444,12 @@ struct net_device {
> >   	u32			napi_defer_hard_irqs;
> >   
> >   	/**
> > -	 * @lock: protects @net_shaper_hierarchy, feel free to use for other
> > -	 * netdev-scope protection. Ordering: take after rtnl_lock.
> > +	 * @lock: netdev-scope lock, protects a small selection of fields.
> > +	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
> > +	 * Drivers are free to use it for other protection.  
> 
> As with devl_lock(), would be good to specify the ordering for those who
> happen to take both. My guess is that devl_lock() is after netdev_lock()

The ordering is transitive, since devl_ is before rtnl_ there is 
no ambiguity. Or so I think :)

