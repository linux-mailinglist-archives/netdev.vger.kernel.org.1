Return-Path: <netdev+bounces-103610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F2908C95
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B74A283351
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ED2163;
	Fri, 14 Jun 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f4XMhyHB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF25184E
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372236; cv=none; b=uFxNmTyERlniUbdnvpwGtj4eidyKTl6FwCfgwxx/2t6dXjOURmzjrCJ+cIZ+U2dFzOtnWl9hn/XazNB188uM0tMj7aXePxNZR/dj/G0HSeSli9cp06wTg78e79xikTaq6h3fI/Mn1FltIoJGifMtvpdO3jTo9qYJD3UitzLCzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372236; c=relaxed/simple;
	bh=/wyEaL8v2WmgdHw0fWOb9FEhssTzuyLZ37RSrJKw+hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQyJ185GjLRBBOy/d77R4Cg3yicnqlUdnFXKz+082EpVKaU4StRZ+6whzcO8tV/ZOBPSOtdsUbeYuOuj8T0s3czBAUS/IUCNvQCANzdUAeGiDewiOUdP/0dRt2MAIEZeP8exHFh2CHFXj19EsWXsgq5FqlTo1aItQZU3jb4u3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f4XMhyHB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LF7RsX3cubk21bOH6HgAt01Py1oeFRfuUmO3KjwGCqY=; b=f4XMhyHBmILJzVoFIV3ijbi1am
	Zmo0x4Mdnb391PiFD8ySWqeC4iVgg8t7buF9r5W5iJxmW2zS/O4vO6qjcneiZR/Gx8O/Tvmeby9dv
	/rpDuBMN6885NlRLSFaaOoVD5kyDdKrfJpf7KHzmN3qgKXHJZ2UjDF7AlCDkfdubpHaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sI77A-00047j-Um; Fri, 14 Jun 2024 15:37:12 +0200
Date: Fri, 14 Jun 2024 15:37:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	horms@kernel.org, Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v6 3/3] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Message-ID: <28b58ff0-599f-4157-9ccf-730c53217cf7@lunn.ch>
References: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240614094642.122464-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614094642.122464-4-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Fri, Jun 14, 2024 at 09:46:42AM +0000, Enguerrand de Ribaucourt wrote:
> The errata DS80000754 recommends monitoring potential faults in
> half-duplex mode for the KSZ9477 family.
> 
> half-duplex is not very common so I just added a critical message
> when the fault conditions are detected. The switch can be expected
> to be unable to communicate anymore in these states and a software
> reset of the switch would be required which I did not implement.

If i'm reading this code correctly, every 30 seconds it will test to
see if the link is half duplex, and is so, log onetime this could lead
to problems. Also, every 30 seconds, if the statistics counts indicate
there has been a late collision, it will log a rate limited
message. Given the 30 second poll interval, rate limiting is probably
pointless, and every one will get logged. The last print, i have no
idea what resource you are talking about. Will it also likely print
once every 30 seconds?

Is the idea here, we want to notice when this is happening, and get an
idea if it is worth implementing the software reset? Do we want to add
a "Please report if you see this" to the commit message or the log
messages themselves?

	Andrew

