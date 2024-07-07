Return-Path: <netdev+bounces-109679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CB92985E
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BC11C20619
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5825569;
	Sun,  7 Jul 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lg4diSOy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266F25634;
	Sun,  7 Jul 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363422; cv=none; b=eYSt4tx8TYmey+uoHJ+gIwIzYmBOJsZXoHvAHrY1IV3XCtQPNOOIPHVkHvPMnSQYex9FLEuLBTqlp/XQ8AzcA9f/hiv60nzkj5BqAUBafbDqkCMF7mNG6/zkAotk2WeksZmY0RsRJOQLoPPIIsI9auu415KxErGhYWco2GlmfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363422; c=relaxed/simple;
	bh=SIEbwpjTXW7Uwj3MBOJdM7a212KIh53gSTLNUWRhLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztzn8H0NUvRKeFeQMpgb+zZsHBnNVhyU33CTIRgzXpyTVIzCo8feAoaB0zLBEF/9hAn3TF+shBzI+TH2FLbPvALOnxwr1UFZZigFPSjSJf/2YHSFjKiWveIYHfdav8ZZZWUbUUStBJStfPG8lHwIiHCV4A0BNq+6zMCxxZRZtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lg4diSOy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cjRKsN6ub/8uCcKFZqN9SviIl4u+WaB08jVTx0tnWZc=; b=lg4diSOy/x1bs4ruhR3J5Qx1TX
	5SEknxE27zgPOkeR7z/sIB6VnFvfFObp33jsjTgrcOwdhlI92EgMlJOPYIkl0tuHDZQyy5dL4GrUA
	eTKRkDWBNuq72cv5Dk+9fPz8D6hyQzTA1FOy5kHEY3qC06HPNTUUzIk0xvx1WOJq8yqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQT6e-001zA0-Vj; Sun, 07 Jul 2024 16:43:12 +0200
Date: Sun, 7 Jul 2024 16:43:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jacob.e.keller@intel.com,
	u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] net: ethernet: lantiq_etop: fix double free in detach
Message-ID: <0a18329d-2098-48cf-8787-d86099b0bf0b@lunn.ch>
References: <20240707141037.1924202-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707141037.1924202-1-olek2@wp.pl>

On Sun, Jul 07, 2024 at 04:10:37PM +0200, Aleksander Jan Bajkowski wrote:
> The number of the currently released descriptor is never incremented
> which results in the same skb being released multiple times.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Closes: https://lore.kernel.org/all/fc1bf93d92bb5b2f99c6c62745507cc22f3a7b2d.camel@perches.com/
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

