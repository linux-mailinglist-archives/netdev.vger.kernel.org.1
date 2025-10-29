Return-Path: <netdev+bounces-233974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E1C1AC7D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B38D3582424
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98B92D12ED;
	Wed, 29 Oct 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o0X00eBP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65E2C0F65;
	Wed, 29 Oct 2025 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744128; cv=none; b=PpgnlRMjAZdRrZ9eHm/UsOwEQjPq0ujK59Ww33lvfu/pqVgRagYcLjYGj1NapZQjJLU9V6/aB5xni7quQqBShyr6t7CG0q9vsiS65gyA6slt51EzkKPSoekYR4X+kp5pEpdfB1TrhWSNXJZH4mrzeGk5JjHgmdqZ1kgyCtWhWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744128; c=relaxed/simple;
	bh=2ctRIPm99+M7iitbifY15ujTBuUoeaqIZZQv83ZZgZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFZioqQkI6kiBYdZIlT3bhGojJ5kb0BmvCXjwzsAcHCjg0qgnPOkbA0fHF1YbsJrsSjljQ5aXDZEDHIKOZrN1fZt/EloAM4baEtHAuzQuONsEigJL8nTnqnm7uKlLKoAIMK9yzXv+4pqz7z5ydSVhp8yPcgjbeQYFOU1bwCn0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o0X00eBP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ybahCxXjE0nHGYYGlqJZgmamiPJiayf3RnZC9cqrlTs=; b=o0X00eBPqOzKd5uxQ0rOckuK7e
	V+JrQSWvYulWASgE0dZ2/OP7Dnho5n+hRz6ts2NS4tDzce3xzGWICz+EmvF+B0zu08zK6AL5S+n7e
	CNAvDIydsxBk6Yc+g4qeuqYL90ekDXUn5HrgrzTJRkXL2+DBhwjF2AFOt78X23xeWdF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE67j-00CPRC-1K; Wed, 29 Oct 2025 14:21:59 +0100
Date: Wed, 29 Oct 2025 14:21:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/4] net: mdio: add message when resetting a
 PHY before registration
Message-ID: <3201a211-d95a-42b0-8c84-1d4390228799@lunn.ch>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <30736cb54c803e8992c9c4fd3ab38960a85dbc80.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30736cb54c803e8992c9c4fd3ab38960a85dbc80.1761732347.git.buday.csaba@prolan.hu>

On Wed, Oct 29, 2025 at 11:23:44AM +0100, Buday Csaba wrote:
> Add an info level message when resetting a PHY before registration.

Please add to the commit message the answer to the question Why?

	Andrew

