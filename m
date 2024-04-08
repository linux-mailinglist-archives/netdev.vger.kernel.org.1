Return-Path: <netdev+bounces-85907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0489CCBD
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 22:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34D81C214F2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83DA145B2E;
	Mon,  8 Apr 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kPeJHMY2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7391272C4
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606548; cv=none; b=TN2Os2FdEP5af3Jden79DEB9eHHUZzKu3qOAIlDCroThA1rZhLlpmOELHUdtjRQhwXpXNhubpnrYNlki0LwBebNpWG3DLgc5uoXVQ/a2tZGAKg+OpKoTMUMFbfVJDoYRCaHgsXXSaM5X8Qp3/Gg9EwCW8wnVt8NxKs+ObgUxxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606548; c=relaxed/simple;
	bh=QAKpxMjZt3/RhljaIPEq5IaSVipt/wGiTCqwy8AZMLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQVpTNAqc2uUKhJJx4H4NcHmG6q1RfIO5/kOVeTjMXPp7Ow8yFh3PAUEFarGuREAIKTceouUf+7khOT7yjHxZiPaEMGMLMwlxvquNObKGS8hTpzgHSfvP/BBxdPLBgG9545mz+/bvSUgooSbKaJzL02FftRJX8he9phAlHn+hPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kPeJHMY2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8JiKojeCDyw8ONe2HgoWsLQFvQ/+ztrzP7Y2yJ38UbE=; b=kPeJHMY2iM53/YqJAsE60XM2QS
	QMA2+F1+FMptMTebw7/U9yimBnL8USaXghESqffPhJ9Qy2xOnRNdLUB60OJ4DEzof8fl8jrZe1zWW
	hEcjbH/rW9HilfzUBO2wFFeQAI4vF4xaS0SRiUb8JNPbcnaQmHLH4ZLMpv5b616m0S3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtvBr-00CW4B-Dn; Mon, 08 Apr 2024 22:02:03 +0200
Date: Mon, 8 Apr 2024 22:02:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Lukas Wunner <lukas@wunner.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net] r8169: fix LED-related deadlock on module removal
Message-ID: <984692ec-2f76-47ea-a59d-35d5e74e085c@lunn.ch>
References: <2695e9db-a5a0-4564-9812-a50b91fb1b46@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2695e9db-a5a0-4564-9812-a50b91fb1b46@gmail.com>

On Mon, Apr 08, 2024 at 08:47:40PM +0200, Heiner Kallweit wrote:
> Binding devm_led_classdev_register() to the netdev is problematic
> because on module removal we get a RTNL-related deadlock. Fix this
> by avoiding the device-managed LED functions.
> 
> Note: We can safely call led_classdev_unregister() for a LED even
> if registering it failed, because led_classdev_unregister() detects
> this and is a no-op in this case.
> 
> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> Cc: stable@vger.kernel.org
> Reported-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

