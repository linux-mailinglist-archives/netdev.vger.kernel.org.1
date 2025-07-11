Return-Path: <netdev+bounces-206171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C20B01DAA
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4494A3CEF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330122D6636;
	Fri, 11 Jul 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rtsdmY+a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D92D46A0;
	Fri, 11 Jul 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240811; cv=none; b=i4whucAy9ja8vrQK6h5cFCwvkwK8IcM3fFkWjlIIB3acuDo9M9rJLfx6MloguD9ONhUFs6gqt+dKoHPTlP+lC/sq0O0TmQbN7W/t848U1F1tJ21INyWmJe5ochiC6iQgCGzSdMbmoHsmI371+GzzjLldktESkebBYprJRnYHuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240811; c=relaxed/simple;
	bh=w0wqKuxizQBUMM8sSroCRkS63IOuK/FYdyK/viERKu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DunEvsqeiUOfGC3GpsepVy41IWYvIqMdRUsXDDXjqRoBo9ffn2Pq4u+xsUxOzI1Zzj1WUBq+HBfp7FiErj66fNMYuG5pC/pH0ciyN9EUjaxFNnD/GDcMj1MVQHi6PGjX+iZDHZVqAlSvErXj0588U+rHtq6BK0DyO12V0y7YsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rtsdmY+a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=80n7pdzd6xQBl2rE+0CERdPnyQEG94FW6DEO244G9/k=; b=rtsdmY+aAoN5/rSuHvgkte3iv/
	Vv1SKyK05jH/B5Cz50mQfCX0JUyqcF73G3h47f2SEgQDY1rqEcAobWrTzV8QZjQURv2Fc0Dg7NEWT
	Y1mTAu5zEljUWaYBtrtTz9eGZ5RAbIsTwYbUymojnZ3Z9qw+jaADBTGk6/BpqJiLeI5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uaDsP-001EhK-QA; Fri, 11 Jul 2025 15:33:21 +0200
Date: Fri, 11 Jul 2025 15:33:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 06/12] ptp: netc: add debugfs support to loop
 back pulse signal
Message-ID: <083ef067-b628-4dc9-a3e5-ccbb37de3976@lunn.ch>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-7-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065748.250159-7-wei.fang@nxp.com>

> +static void netc_timer_create_debugfs(struct netc_timer *priv)
> +{
> +	char debugfs_name[24];
> +	struct dentry *root;
> +
> +	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
> +		 priv->phc_index);
> +	root = debugfs_create_dir(debugfs_name, NULL);
> +	if (IS_ERR(root))
> +		return;

You should never check the return values from a debugfs_
calls. debugfs is full optional, and the driver should work without
it. debugfs will also happily accept a NULL or error code as a
parameter. So even if debugfs_create_dir() fails, keep going,
debugfs_create_file() won't explode.

	Andrew

