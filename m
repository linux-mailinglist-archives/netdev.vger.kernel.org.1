Return-Path: <netdev+bounces-152003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71989F251A
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60ED164855
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0FF1B3936;
	Sun, 15 Dec 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2SSv442E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113014A4D4;
	Sun, 15 Dec 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734284537; cv=none; b=i2/ZcH1JXbLMf7bR3IKMUHVQYlzwyJ27LF61oAJoxEKV49/HBoftl6UoKfMcPNnU352g/nVskBfOU6+SmLxBia0Y0XNvpM8QdHjfYBEZICMztTut0+S7yz5RTA9JBkKQAYLP9LE4Zx+iJhk0Ki9gIz8lneahpl+AxBxzSZT3daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734284537; c=relaxed/simple;
	bh=WT5AhZfT9izJ8Ap+qly/ztvu6lG/7tY6d9C5Rc0xFJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHpTZQ64lj5LCuihZl54XfJAMAEgMI2N1hRwcRGbDMwQxyHKPrW6Oe29IZnqkyYIjR3AhOCyIvWrNvEi84Qot6lB93FeHcMN9nchiG4PgWBcjejbP0lm1Dy7F5fQZHAvw5fHLOKo+c6oRF/N62GkzgwMYKA3YhFru4wk18zGRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2SSv442E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oMpKiSPuueBc+EvtoYudkvswBzxdR8PhLwf0cJdWQys=; b=2SSv442EziSRq2sEYOKAr5X6J/
	2SrtogQFFwSefbhXXjr0WVU4APOL3610I/8lK2QLzG26pwCS6StpqpQWiq3JhICXjfV0ruPwcIqy+
	C1WbQESCJ0bBeeDDXk4hH47z0pgIdeDVqbgWAncXvoiwfvGhq+A/ChSU/xTCbG5G7Qec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMsd7-000WLH-7f; Sun, 15 Dec 2024 18:42:09 +0100
Date: Sun, 15 Dec 2024 18:42:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mattias Forsblad <mattias.forsblad@gmail.com>
Subject: Re: [PATCH 0/3] dsa: mv88e6xxx: Add RMU enable/disable ops
Message-ID: <1a168ea7-92d2-47fe-86cf-c45556810d1c@lunn.ch>
References: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>

On Sun, Dec 15, 2024 at 05:30:02PM +0000, Andrew Lunn wrote:
> Add internal APIs for enabling the Remote Management Unit, and
> extending the existing implementation to other families. Actually
> making use of the RMU is not included here, that will be part of a
> later big patch set, which without this preliminary patchset would be
> too big.

Gerr, forget to use b4 --set-prefixes net-next

	Andrew

