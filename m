Return-Path: <netdev+bounces-121761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956895E679
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DF4281275
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51844C96;
	Mon, 26 Aug 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xVQlJqDj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B666D502;
	Mon, 26 Aug 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637263; cv=none; b=Aq1YuX6pgPhXNFk4WpQJV71e/SEZSgxgAiWBHql8ntJzUlTAJu6xkel1/r5f24y7S21flplZZm1pKcNrYdgI2m8qm6iOPc3P/MFZNS/tKFADS3MMNZh31SMEfhmsahsuSBMyz3w9d21ob13hin/OTV9UDRLWvmTzZWmkbzegw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637263; c=relaxed/simple;
	bh=JJ9I41ebwPsORR0t+NEim9hQzR9nXT0CaI/ZHX95cWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STWaCGvMVSGcTEwfh8/qYqo6zDdubAo+hR/aBm0ZAh4nnf7RYHq9rB/vCElwviyd62cQAczTDk48NtvxpBtM6nfV4BnCy3909+chr3IubWZ6jZnbYPvGo6lj8zzTHlHhdXCVIh7QSnBDYXq0y/M2WTs2eQulzzEn7RsmOmBjS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xVQlJqDj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GDqUgUondx9Elzr2JcpDBL77GHtc93bNuT9L5BzRRAw=; b=xVQlJqDjpO0FBR37e2tX4mTind
	jRvCX1za2ZI3IKLPk9LmCb2UH7bBDnJu59Qj6knoNc+Yj3rSKiyr0+LXYKdrdV67k1usGWAGKhvTf
	MfvJzu3S0MR5R47QZEbOsUm3hLd/5HbxG3+SZjQ5VYpH9inLJ8EYRU5SpjHWr7yS0DoM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOvt-005fHF-Cy; Mon, 26 Aug 2024 03:54:13 +0200
Date: Mon, 26 Aug 2024 03:54:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: Re: [PATCH net-next] net: ag71xx: support probe defferal for getting
 MAC address
Message-ID: <a8d36852-d4c5-450d-9296-e8a07900985c@lunn.ch>
References: <20240824200249.137209-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824200249.137209-1-rosenp@gmail.com>

On Sat, Aug 24, 2024 at 01:02:37PM -0700, Rosen Penev wrote:
> Currently, of_get_ethdev_address() return is checked for any return error
> code which means that trying to get the MAC from NVMEM cells that is backed
> by MTD will fail if it was not probed before ag71xx.
> 
> So, lets check the return error code for EPROBE_DEFER and defer the ag71xx
> probe in that case until the underlying NVMEM device is live.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

