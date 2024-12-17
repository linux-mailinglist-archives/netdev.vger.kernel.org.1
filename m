Return-Path: <netdev+bounces-152642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B79F4F7C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B313188277A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475E01F4293;
	Tue, 17 Dec 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="esFnBqER"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155D23DE;
	Tue, 17 Dec 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449469; cv=none; b=Fjw0gcjpInjqsogmf08mSfjO8GkIUd+SlQMnMajiPxELbkImGvAghH1dJruGgwntuT+XIlRo0O+5CIyZdooRdPpHMEziNzhkTBPx8vnAgW5Dz2/TesSBYLPjIqDkntmvOsE2r7AEKPXFdwQaPowd38+s+I7/SGzKn1P7Z1PEPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449469; c=relaxed/simple;
	bh=LH+u52El4eJuW6tlodccRYEdSm8ys4Ozz406z1uibkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhLdjM3Sdg8qwkfhEFMLuNJfJcgWSOZevILmtrEcE40+BJhsBoP2jNoSaWJYWbb/K0s09I/FCN8jKdkbYhfyh0xK/pYeGCo4qJEfPwBC8XWDN6vU2zuuSgFdy440xyHps5PI6LDzZdy62Hy6cgcjf+nmlpwKOyGiVS6J5oABtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=esFnBqER; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b1SNfDI1ZZp+kuZp2eJyy8k7g0+fJHQ+1bu9bfsYOuM=; b=esFnBqERE6O2PRiFu+NOufY9AN
	sOQsoR1pzaIetyG9Mej8/p8RDsSR6fw2tWtlsXz91AFwQGcCM0GGV/yNBdP8ZPEzbopUfBLI2r4Wj
	+wouj/Q89ObUvVMs9zAE6meA7xECaH7uhhmix1WXlxoIwvcYH5klIem+Tkg1dVkNWUXs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNZXC-000zRs-Or; Tue, 17 Dec 2024 16:30:54 +0100
Date: Tue, 17 Dec 2024 16:30:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>,
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
Message-ID: <c0a07217-df63-4b5d-b1a5-13b386b0d7d7@lunn.ch>
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>

On Tue, Dec 17, 2024 at 08:18:25AM +0100, Christophe Leroy wrote:
> The following problem is encountered on kernel built with
> CONFIG_PREEMPT. An snmp daemon running with normal priority is
> regularly calling ioctl(SIOCGMIIPHY).

Why is an SNMP daemon using that IOCTL? What MAC driver is this? Is it
using phylib? For phylib, that IOCTL is supposed to be for debug only,
and is a bit of a foot gun. So i would not recommend it.

    Andrew

