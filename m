Return-Path: <netdev+bounces-176458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C3A6A6EA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94679188DAFA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD001BD014;
	Thu, 20 Mar 2025 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eupG+15v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4C33CA
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476469; cv=none; b=bLf0BakBOIwqoERv+R2fdQ7jApNR0wOclRdsowKSO0UEbkNazlseWnwuh6MSXBFOQxm1s42LppLNDLTnbI5dexaShldQ7g6r8lbAWIY6tICS+qkonAWLaLHyfPbi7yQE+srUGEqq7sQhihbZGvsWIzFKGzMD//ht1bWH2dx5OwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476469; c=relaxed/simple;
	bh=StIqtI3oxvpeIa7pmInY5NC6S4dHA9bnkvhXjmUsquc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLn8aXbewGLvzY3Tfvb+n5d661ntC7eO7mvYLv0TcA5slvRNbLBJiQ++VsGeFE/3CQJ1nBtFU25O8AxkEEX0tYtZxSJoVnEIfUk4/5oOP5FRbtV9UDCHTOaaRvVwIRvoBA3RW0W/NHeMOvPOFH+10LNqpYKc1KJKToSIHzxVo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eupG+15v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sz2sSkH1ong3fjmxmo3nFV30+W3gGqWoxCEg1bDnGJo=; b=eupG+15vHW65M4kVPTUeh6BlO3
	VrfWA1vOfA1YgZz9yb3Nyoj5CxG5rBjlYcz5jlsC5qPRA1qo70UzBesQTs0uOEPjYGicK7Af0sg+0
	HowE/ulx5MXm3yaDYNa1QvzoZLbpHcxpEpB6c3oIoKv5BHa7ufMVc1vhcppb3RwDcNsA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvFiy-006Tg3-EQ; Thu, 20 Mar 2025 14:14:16 +0100
Date: Thu, 20 Mar 2025 14:14:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	kuba@kernel.org, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
	edumazet@google.com, pabeni@redhat.com,
	ezequiel.garcia@free-electrons.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Prevent parser TCAM memory corruption
Message-ID: <16143c70-de5a-4f30-ad29-eae33d2e5b0b@lunn.ch>
References: <20250320092315.1936114-1-tobias@waldekranz.com>
 <20250320105747.6f271fff@fedora.home>
 <87zfhg9dww.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfhg9dww.fsf@waldekranz.com>

> We still need to disable bottom halves though, right?  Because otherwise
> we could reach mvpp2_set_rx_mode() from net-rx by processing an IGMP/MLD
> frame, for example.

Ah, that answers the question i was asking myself. Why does RTNL not
cover this...

Maybe the design was that RTNL is supposed to protect this, but things
are happening outside of it? It would of helped if the code had put in
some ASSERT_RTNL() calls to both indicate this was the idea, and to
find cases where it was not actually true.

	Andrew



