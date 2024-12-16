Return-Path: <netdev+bounces-152131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F12609F2CE1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B11B167012
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C720102A;
	Mon, 16 Dec 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N7hXh2Hj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333511FFC6E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340941; cv=none; b=DVwsfohgiH+wM7pw7EArwcXq4VWTxpwHJmqUP7kIQ5i15gXj/kXa2S46xnDbZWej/bd8IdNF9puU7m94EoD7jlLAfCmPYKAZuBIEHVUB0+pPPTN+QPDokbAX63X1fmysRrh49ppuYcVZ6tRPow5Qsgqb8XXZ8axD4PZhDXEns+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340941; c=relaxed/simple;
	bh=6QntRhJ9mNJuETdRXruzoVGhsnovezCi7BtkZoy96HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjCjjzPGM9e3GCj2ye/LLqwGekLZ5zSptnpfpu63HhCLrFAdR1QcLcI3StV7CnmMJzwDQEOUrkQihj8RXq1GD+GG4mgtbAu/sa4zpQgTJoCpUHp5lhASs9ysRSfJvJ7mBBtbhYKPmie2s4XJps2HoXqV+0UKdKXa1lOUGaqeK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N7hXh2Hj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+qLFQxEvouf6IRdH/9Qrw3/+Xm590ALFChi5WSWsuo8=; b=N7hXh2HjGbppR9HUtaibHnQKNV
	XbugUkpHL3VgHa30RQjRoWJC2Cfie4VvVaAAh8QkpPkEqOy9/XzA7SwkNPWtudclSi4devQMB0lpS
	kJznXkwpu1WWcUNi4M9PpKQB2La0bjG59lXQWf1VEW46qDpNSzRx5MaPFHTfzqtMhYNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tN7Io-000ZXI-2Y; Mon, 16 Dec 2024 10:22:10 +0100
Date: Mon, 16 Dec 2024 10:22:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
Message-ID: <ed5a65d8-468f-45a9-bd27-7cb7c792e221@lunn.ch>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
 <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
 <87ldwt7wxe.fsf@waldekranz.com>
 <9ba73b5b-1b76-48b2-9b37-fd8246ef577a@lunn.ch>
 <87ikrt98d2.fsf@waldekranz.com>
 <878qsg8rrc.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qsg8rrc.fsf@waldekranz.com>

> Andrew, have you had a chance to mull this over?
> 
> If you want to go with a global timeout then let's do that, but either
> way I would really like to move this series forward.

Please increase the global timeout.

       Andrew

