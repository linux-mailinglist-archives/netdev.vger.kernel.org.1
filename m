Return-Path: <netdev+bounces-101005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5A8FD091
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A9B2A317
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98D1ABCBB;
	Wed,  5 Jun 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QSC43s6W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F71ABCCF;
	Wed,  5 Jun 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591915; cv=none; b=dzr93W3gUrjYO0sj66KY/Vt/58DNdrSZKVl8BUg9IFVjkmAzKP8gJ/F2OO3T483eaq2jyhJzMhkUageszfPy2rAnHuqkjrxvDRZRz+eWpC+GspwGJZ0yMSjCuM3oV+TLtXYUn6XqloThzQ7pm1a77kzPKBMpwqNOqEtiEiUyFUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591915; c=relaxed/simple;
	bh=7b3K+w7SU6Zgx7gYPaVhHcjQsYqx4h6QADPUjr0DOwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWfpWYKE4h4nVNrCGDEW7ChcqlBB7mT2BY96Fr+gR5o4zc6527yw1zTuxmLgdb/CrgXSLSw94HqZGtnUr6G/D4I6bOAIB/JXzsSbXIpx9kDKCF+0j63VGDdknKcrolL1IwzOJ0dRmRdgPTD9gb6mRbYA6AXfd6C5KP44mDstZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QSC43s6W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jHK+VGXx/XSDdyxRt8MiiLhiSv486K/yj3Pv8VY4j4o=; b=QS
	C43s6WkA1BfEffX0y0mPjIiwyYSmhTMkTIbiSiXOOQzPaqfHI3pDwYrxfev20cqJOE5UFgqtzYt9E
	uhLb74yHIxCifYsPiIzjMI2NvlTmnEwYjhDQFt0z9w8jlDUTViFtyvCk+X2ZSt/g+wZqnRbQfK490
	dIKmj/Kt5M3ODCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEq7L-00Gubz-G3; Wed, 05 Jun 2024 14:51:51 +0200
Date: Wed, 5 Jun 2024 14:51:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	trivial@kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/2] net: include: mii: Refactor: Define LPA_* in
 terms of ADVERTISE_*
Message-ID: <331930db-f5a1-4ad7-947f-7aaf5618c646@lunn.ch>
References: <20240605121648.69779-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605121648.69779-1-csokas.bence@prolan.hu>

On Wed, Jun 05, 2024 at 02:16:47PM +0200, Csókás, Bence wrote:
> Ethernet specification mandates that these bits will be equal.
> To reduce the amount of magix hex'es in the code, just define
> them in terms of each other.

Are magic hexes in this context actually bad? In .c files i would
agree. But what you have in effect done is force me into jump another
hoop to find the actual hex value so i can manually decode a register
value. And you have made the compile slightly slower.

These defines have been like this since the beginning of the git
history. Is there a good reason to change them after all that time?

	Andrew

