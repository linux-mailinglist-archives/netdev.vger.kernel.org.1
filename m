Return-Path: <netdev+bounces-97139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225058C952F
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CABE1C20B72
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759947F46;
	Sun, 19 May 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p0lmc2Qq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F314A81;
	Sun, 19 May 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716133076; cv=none; b=anY+wlgU0V4lSMgEnoyhdNJzKhxwVwz2Zks407AEFcsGzI79NEj2TH2lbLi6vJezjo8dSOZtKtlSMKbhE/dtKr9r6FLgu+XyJtcsY0oFG4RP1/8MByfUU7CqFrP7eH34Fk+JuwF5EwMZ2cwjOM1kIdKjqg5NHYVL2S5+05Ezmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716133076; c=relaxed/simple;
	bh=NXeERUwyQjx2KQdGfzB24z/wueRuWMxAyk0OIBGtnOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTJP4CJKF/E7sXNkPVBvoh0LJtdAyEGSEn0fNdzOmPSLEgwc+rShHFkTNMBST67WspqljNzwrLcmO8elQRAVLuA0+WW+K44KiviiipWT3f8WLJequilZJcxYP8UdBlh5B4tRx+79P7uBBteCrHoXqfYIQFp6tuv/Y8gU49APi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p0lmc2Qq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yPnxnFfwVRXtYrtep56kjTn1ZNOzZhEEVBAwe35GIWI=; b=p0lmc2Qq/5//84h/ZOoyKw8i5d
	CTXWeKEwbvJK+gEqt69LaFX/W7o54IK4mZumoM5JcIX9KHTToXjux+pZM76MnA/TFfSqZ0vRheXBn
	AiMJ1a8bbjn35L3L4OIcNH4FnVe+kAQ7D+o0HgKjZvnktM9jwcCbmgbBKzepTNXhpAdU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s8ibT-00Ff0y-7U; Sun, 19 May 2024 17:37:39 +0200
Date: Sun, 19 May 2024 17:37:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthew Wilcox <willy@infradead.org>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	MD Danish Anwar <danishanwar@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Roger Quadros <rogerq@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	Sriramakrishnan <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH net-next 12/28] net: ethernet: ti: cpsw-proxy-client:
 add NAPI RX polling function
Message-ID: <433ffa6c-7ad3-4e28-a2ef-de699bf0e03a@lunn.ch>
References: <20240518124234.2671651-13-s-vadapalli@ti.com>
 <f9470c3b-5f69-41fa-b0f4-ade18053473a@web.de>
 <ZkoGCpq1XN4t7wHS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkoGCpq1XN4t7wHS@casper.infradead.org>

On Sun, May 19, 2024 at 03:00:42PM +0100, Matthew Wilcox wrote:
> 
> FYI, Markus can be safely ignored.  His opinions are well-established as
> being irrelevant.

I personally would suggest ignoring the nit-gritty details for the
moment, and concentrate on the big picture architecture. I suspect the
basic architecture is wrong, and the code is going to change in big
ways. So it is pointless reviewing the code at the moment, other than
to understand the architecture.

	Andrew

