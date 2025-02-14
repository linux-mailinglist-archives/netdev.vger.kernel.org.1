Return-Path: <netdev+bounces-166600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B99A368D5
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79CD1893E6D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3C1FC7F8;
	Fri, 14 Feb 2025 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIp+9xfH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942E1C84AC;
	Fri, 14 Feb 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573977; cv=none; b=jbPCplYsQ2+XmR9pNKM23CDKrxWvbTJlp1iLHlL7puxQc4xhyyatvX2skTDafJFZl1mbrdEV0PzY+8d/VjKd2FpoW9KYlg+qeY8ofnQGIkWAy9pY5tJsDPgudMq6rTqe6tID8qzy+N/K4ok8eeswOCsH/TNG9pHRUG6gk3Zrw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573977; c=relaxed/simple;
	bh=cQhoYmtsFTO9kcJDJ6IeQHZWotIegqqN2P1ohC6gW44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4LM8QRK8UcVfCzznQsaH6NvxlTHCNqNmiAyyfVLHV8nIseck5+ZzUGEJpioiyPsQ+c4x0PK9t2SPgAIuWQRP9CEU1/22X4fmUmm99nhyK2iSg3/2XVWi1uXPH+265vCf1I+qdjJ9nYNvdHccNBSq36/V4aO8AnKU843FZFMBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qIp+9xfH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ovYAtQst84BNMqpH2z5l0LR8Rh/ENQjtitjbgAf1XAM=; b=qIp+9xfHQNA+Tbji57jabejQNG
	jMOQX3RXzzu4FpcWzbiwuhXUuWIlj2SPD1VOhz0YVdkcL7YVMufolOsSE/A5CYivigPNuqS9SDBRP
	3aZJ6nQvNmeAsXkRayA4g8CBctxMUVATr7rp3kDWLKw0kHyJQCXGIjrhI7gKzilufhe8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tj4eX-00EDGa-3N; Fri, 14 Feb 2025 23:59:21 +0100
Date: Fri, 14 Feb 2025 23:59:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: cadence: macb: Convert to get_stats64
Message-ID: <d4e1438f-511a-45c5-8e77-29be1b85e62e@lunn.ch>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <20250214212703.2618652-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214212703.2618652-2-sean.anderson@linux.dev>

On Fri, Feb 14, 2025 at 04:27:02PM -0500, Sean Anderson wrote:
> Convert the existing get_stats implementation to get_stats64. Since we
> now report 64-bit values, increase the counters to 64-bits as well.

It would be good to add some comments about why this is safe on 32 bit
systems. Are the needed locks in place that you cannot see a partial
update?

	Andrew

