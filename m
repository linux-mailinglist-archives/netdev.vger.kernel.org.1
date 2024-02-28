Return-Path: <netdev+bounces-75785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEDA86B2C6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC6FB2850F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2615B969;
	Wed, 28 Feb 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6RNvx1X0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027F2D022;
	Wed, 28 Feb 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133022; cv=none; b=fMal7qlApT9h3lT3504Bkk8Hz85cdWJU7cMMKwzLvBo3i22l4BJ80aEzQIn/zE9/cU1jKS5x+rxBzgCRSuTgo2v0Ax2l2Zr/dYKj3lMWVh/qD/s/tuIYqruNLCaWdaHuLhGQUzE3id0AyzN+idGuYzhT5zAQmdlg08O5StXnebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133022; c=relaxed/simple;
	bh=hbU6soSNIhde/HbBZmF1+OQ6a8o7ZDnBxNw6usm4cqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwU2Iz1m59//6p+nd0UePDcZnJmc/GhzBOdCYW3haZufLNVggYAidRXpI0rL3COuGbEopk3ax4eRx9q892VpKBS/5cz9H8fpY0chZv7N88nQsBjny3WIIL85O+U9eUOQzhHmYKPwaRehMYUnuVmiUv0JJUmjW4PWbooC6jMboXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6RNvx1X0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=88pAabs67d/TaG18mZs0ENtHJpAhlznp1aL+eyjFIZY=; b=6RNvx1X0aVSuyP/gI8PFf+trpL
	HwXlVYgad+kq4p21jk4hI/FBs7Nqpwh4BylkoAlZ9v233Ht9VswGXAm1jIFerp+am4LHEp8w7Ddzw
	litSe5pNwbCeQF4z1zait7ziaFW5Wn6D3SHr3EF5vO9J5wxLHzt4DVBUgzH+np74PSI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfLZn-008xVg-Ue; Wed, 28 Feb 2024 16:10:31 +0100
Date: Wed, 28 Feb 2024 16:10:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: dm9601: fix wrong return value in
 dm9601_mdio_read
Message-ID: <1ed82980-6fa8-4ad6-b031-2bdd07207fe0@lunn.ch>
References: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
 <20240227181709.7159d60f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227181709.7159d60f@kernel.org>

> Andrew, 
> mii.h files seem to fall under PHYLIB in MAINTAINERS, but mii.c does
> not. Is this intentional?

Probably. There are big parts of linux/mii.h which phylib
uses. However drivers/net/mii.c is not part of phylib and is
unmaintained.

      Andrew

