Return-Path: <netdev+bounces-238692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2DFC5DC7E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74FD4EB8B1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F0325732;
	Fri, 14 Nov 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lfIiszTG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8A265CDD;
	Fri, 14 Nov 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131900; cv=none; b=QApgfSjCCz7270p6bLhDGsek3tysVCFQTq84sohnup3iYNr4K4mSLtTEo3A/5mT9J+c6jP7Aab9nnsgZq/4PxPdbwA8JDey1X89HLsP/ZxhjfgrhsuW3cCh6dr+nyyGy9S8hl6u7S787wZGGx+ktrfYz8zNwQiRY7Ffbs4s+McQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131900; c=relaxed/simple;
	bh=n6TR6UJ04asWKpay5qgyC8Bu1X0R34m78tY9x+YFrMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp63PF9Boy8aYFsE8YEDO/SSTdcMPnki2NAPSL1RzCJ+E2Wt1Zl9tdfREytCe4yzNIr5bEaFq52GxJrHkacx6eEwbwYo4uocjLLSDoHHiFk8eULmV7OQ4xrKKaVm0F+x81JVZS2ic0xvL9rGIyaWgMF1wjqsapTPKTexbnPsvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lfIiszTG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8NCh6lfOOeU+XW4tbTYJrgPV0YvWjUIlZDOZcUa0mUM=; b=lfIiszTG08SwaOzwho6tuhOB2p
	pMhekgIdGgFXG8vRAYyLyRiPS7x+7Sv7puS3iKcrg1qy+vq1AC6cExV6mOdILtP9aEKdRXlQHnLD/
	sSsLjmR0XZBVcicI1p0FsYmiQfks3mJ8TicbpV5NS5QgkHNrfil34z6rZVl/TKPw9luo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJv99-00DzLX-1R; Fri, 14 Nov 2025 15:51:31 +0100
Date: Fri, 14 Nov 2025 15:51:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/4] net: dsa: microchip: ptp: Fix checks on
 irq_find_mapping()
Message-ID: <7909a98c-7ef6-4902-a1b4-c2caba47a086@lunn.ch>
References: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
 <20251114-ksz-fix-v3-2-acbb3b9cc32f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-ksz-fix-v3-2-acbb3b9cc32f@bootlin.com>

On Fri, Nov 14, 2025 at 08:20:21AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
> but it never returns a negative value. However, during the PTP IRQ setup,
> we verify that its returned value isn't negative.
> 
> Fix the irq_find_mapping() check to enter the error path when 0 is
> returned. Return -EINVAL in such case.
> 
> Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

