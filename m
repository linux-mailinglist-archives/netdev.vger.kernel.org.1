Return-Path: <netdev+bounces-216234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435CEB32B7F
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7B23AE9FB
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639F2E62D3;
	Sat, 23 Aug 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xsJFFZZP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C51F5838;
	Sat, 23 Aug 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755974722; cv=none; b=Pd4n86vAP+CqIPsDjtN5DXqewO64/JMNK7MXdijmsEqCIjhliN9hLj2WYyDrRG7q2oPqQP1AmoVdZvcW+KVnRK0YF53ri7L4TqZSbkSYmEUTzQikNok2OwVGtG+Qs6ImSQ3z41Gl7dlPrKaJj5e+I4POPYn/aElnSRREzquamQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755974722; c=relaxed/simple;
	bh=/kx6ReJ9E9iPwUIpfG3tE5xhpeN+C75aaSwoOx/mmzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXGVUjzPuhc112BePYypj0o343dyLJM6GR36toRmgLTWAqhNBKz06ebbtaobYJRKJN6lxYXyLUwIFIfzKuNYPjjX+GLDS7Wo3GzzjbCEVmK6ZAAM5+J8hdDPLjtgn5Voc4oJCnEloYsbkk4/Nbq0d+Pt2Gmc0k9HhltVwAUGS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xsJFFZZP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+ZVRc8QlXB6Tq5PLL72iybn+cSPZrX2KEyq6ZWRL4OU=; b=xsJFFZZPLqJLL8/35T8WllSHN9
	BROWEjFHPqFiiebPZqDVNYMTJpuZN6OoqXF4y05iaPDNDy4FzsWoj5RJe72uggM4cA6OlpV1PJOUB
	GDv2miQBLHCHXcJXIZUa9dNZZH6UU7TOMGdY+LNUK7XmI+BOhSW8q+c1wHXY2Zj+xlwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uptEj-005m5e-0P; Sat, 23 Aug 2025 20:45:09 +0200
Date: Sat, 23 Aug 2025 20:45:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: dlink: fix multicast stats being counted
 incorrectly
Message-ID: <c064f823-f271-4501-8a0f-dd1e2d89d045@lunn.ch>
References: <20250823182927.6063-3-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823182927.6063-3-yyyynoom@gmail.com>

On Sun, Aug 24, 2025 at 03:29:24AM +0900, Yeounsu Moon wrote:
> `McstFramesRcvdOk` counts the number of received multicast packets, and
> it reports the value correctly.
> 
> However, reading `McstFramesRcvdOk` clears the register to zero. As a
> result, the driver was reporting only the packets since the last read,
> instead of the accumulated total.
> 
> Fix this by updating the multicast statistics accumulatively instaed of
> instantaneously.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

