Return-Path: <netdev+bounces-72215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F985719F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 00:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F6A28495B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 23:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB4141995;
	Thu, 15 Feb 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x3QJhEtB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE212C53A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040002; cv=none; b=pBmovggiQsyp8iCT0Qvl52a4wsxlIPvIt4cZD6Io3DP9Ol5LwqFaL/Tlgd8M0czwnEQiSvAYigkGiDnU2/ZwRn+1ZeNqpG+K8VxrATxgn35M7kMNuiHF0DDf1yt7AqphQPkX2jJxpvAK96k9hEFHwc2qwDCh9xTGSyH8zX0pY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040002; c=relaxed/simple;
	bh=goLYH9/JQzERA85X9HA2W7b54t0FsA8aZa/ed96S/3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp8LVCRjpruFNis+gtnpl5jgNSZKrD5aiB16J/2tcJjNOa3XJxBNncAGryj3tZO+mZ3PU+Xiy4iLdpND/U/A+vbDSSHQJhACNYsXxydG/H58R6GEjIk2FwI3lPk69/LCJ8+oMwr9Fpaof2rY1MPPjpzWDmR0/oiEkhtuzFimvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x3QJhEtB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ut2takEv/lTh0QQM0d9Rd54jW9GTFw0XGLxgs44u2lI=; b=x3QJhEtByfBnAMDsSrkM5qOPhx
	vh54VlTnJjPLBUPJPPMk1a9evt3NiMbZA+1xgn4rdm8V8xSpVsiIjxRfSO5MEgUQde0eLzj8uGxk5
	jJvszgAczYtbK60rHZIoQ/rI49q8xDS45ybd79hKO153rwTCMFRjJgs1unLcw9FNB2XI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ralEF-007vcc-Nz; Fri, 16 Feb 2024 00:33:19 +0100
Date: Fri, 16 Feb 2024 00:33:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] ethtool: check for unsupported modes in EEE
 advertisement
Message-ID: <ab9ec289-3d40-4541-b22a-a72beaf1e742@lunn.ch>
References: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>
 <Zc4zhPSceYVlYnWc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc4zhPSceYVlYnWc@shell.armlinux.org.uk>

On Thu, Feb 15, 2024 at 03:53:40PM +0000, Russell King (Oracle) wrote:
> On Thu, Feb 15, 2024 at 02:05:54PM +0100, Heiner Kallweit wrote:
> > Let the core check whether userspace returned unsupported modes in the
> > EEE advertisement bitmap. This allows to remove these checks from
> > drivers.
> 
> Why is this a good thing to implement?
> 
> Concerns:
> 1) This is a change of behaviour for those drivers that do not
> implement this behaviour.

Hi Heiner

You say phylib does this by default? Are there any none phylib/phylink
drivers which don't implement this behaviour?

	Andrew


