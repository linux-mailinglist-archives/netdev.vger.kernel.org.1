Return-Path: <netdev+bounces-182146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B245AA88045
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F8D1893B4A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F30F29C32A;
	Mon, 14 Apr 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NfTxNvVz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32426FA78;
	Mon, 14 Apr 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633225; cv=none; b=kHUwNzT7BRWdtVkuH9iVsGGDjisXiJ67B26jmGNjaRpTEnxhC0ReIWEd9rv2U/md+NcZZ1IqGCw5Sx+yDzdI2awkvYgt+0NhWAy0AXGXShAeQUQcDxqGjfkSdCDQM9S+7GtbO4Q+IyvK+S8zt5jdygN6OwiLrotQd/2YZZcsAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633225; c=relaxed/simple;
	bh=oU2Flb76N8H0GLNvP228Z1xIW2gXY5LHuzFW3s/0B2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mosThkaW5DbEAoPAKg4qhcjPALorShQ6fnkYeyPYr54FHEjeHBKBzLE41kKklTEnM2vrF5pUeXPwm7e/AxTWO3KMANru3IYEta2BhvaGGGQwEARgHGdTPuWV1lGGzHzKU9wa0Ri1tO/6YZnNtEl4diSLSzqQLr6Bv6eQ1TkClKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NfTxNvVz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PNHZtS8sVjVT0+BlEBRwFQcd3ErC+6wK/oQOfJC8K9o=; b=NfTxNvVze4CYHtjsZfPHuLVCfa
	D1fgRWXb0KwDYse7x2Ru+a6gIUabHPR4gvkSoaEfLi1pMKYU9Y6s05n08OGBDIig/5eRosLKlbRlh
	rPYLCQilKQ5P+lrQUAyjuN1JelOpjNc7fgc76bpxoQ16d4O1K5PblU4oVeR+mT+wDxTg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4InM-009BL5-Cf; Mon, 14 Apr 2025 14:20:12 +0200
Date: Mon, 14 Apr 2025 14:20:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: ethernet: ti: am65-cpsw: handle
 -EPROBE_DEFER
Message-ID: <627424ba-8f43-4a25-af85-6a050e5e3716@lunn.ch>
References: <20250414084336.4017237-1-mwalle@kernel.org>
 <20250414084336.4017237-3-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414084336.4017237-3-mwalle@kernel.org>

> Fix it by handling the -EPROBE_DEFER return code correctly. This also
> means that the creation of the MDIO device has to be moved to a later
> stage as -EPROBE_DEFER must not be returned after child devices are
> created.

I probably would of done this as two patches, but it is O.K. the way
it is.

> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

