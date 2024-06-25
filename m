Return-Path: <netdev+bounces-106544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34A916BBA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD4E1C2530D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D817C9E5;
	Tue, 25 Jun 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="upz0EOn+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6F16F913
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327699; cv=none; b=ohCxB2oGpNuBuQVKkxCsz+5tFNHC5QenF/3AtjJHd/6qL0N4GFziKRwcnAMegw8yDzmuP+7QNjDlwK3IFvQ4/MBEPY1bJu1D6fZVQFKhEHFzvAmSBBS6QXUxaORYm5wl9KRIJCUoqd0UUhWzvxXCIhWWoGflZCjNGZMOQv8m29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327699; c=relaxed/simple;
	bh=DNFfEZX52eLhWoRP7oVF8N6JLDoD4+HANgiJaJA0HGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir5clR2UtgoDy+sYiYjjMa/rf9UPMtAK81jfTyIpdTz9U5r8jaKF4jXniDj81CFxLWPV6cRdGyXVHfGV5YtthPHxzP1FaKNlNrkDNnSSgoDoDZu2JWJlx2K3kutJdV4WH1nl8PEC/Fd00Hky7mHOfVb0dqU9huxoGV1809VHxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=upz0EOn+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gNCAfiH5tjEXyA6CozYSd+qGCQ3yrPxtaZFG0aeSG0I=; b=upz0EOn+nb/ObjKGx9lStFr2Xj
	WddYeVL0lRBmYj81h6HzUdyj1DDCJ11EtiphGUSyVUAueAX3aKOoXcQBd/68osCa2DuXnnlsH0MoH
	yKeohk0x9J7eMk1mfmwhFtu0+uuLo2iO7FB6ffcEvmdw3Lwpfe7BrTitPte2JUNIevUg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sM7fq-000x8Q-GV; Tue, 25 Jun 2024 17:01:34 +0200
Date: Tue, 25 Jun 2024 17:01:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH v2 04/15] eth: fbnic: Add register init to set
 PCIe/Ethernet device config
Message-ID: <4bf37ab8-2a2f-4692-959c-531519651949@lunn.ch>
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932615131.3072535.4897630886081399067.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171932615131.3072535.4897630886081399067.stgit@ahduyck-xeon-server.home.arpa>

A nitpick:

> +#define CSR_BIT(nr)		(1u << (nr))

Isn't that just

#define CSR_BIT(nr)		BIT(nr)

which makes me wounder why bother? Why not just use BIT()?

	Andrew      	   

