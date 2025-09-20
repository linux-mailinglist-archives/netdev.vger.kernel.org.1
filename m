Return-Path: <netdev+bounces-225000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16701B8CDDD
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF926244A7
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857830DD27;
	Sat, 20 Sep 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XjfB/23o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532319C566;
	Sat, 20 Sep 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389354; cv=none; b=XT3TIKzyB4KipOIepaZ+xgOUH6r7v11u1MEkE2XK+4SEEcYPecVQe2cG2Rm72WSXburbdbJZzvcSLEcl5bIvHB7rsrp2AFoesH+JGzUEmqRRB8KLLTgNZNy+RztC1Ewk72Y8DCtZkdhJcBlrNv9Uh1NWFWE00kDzEix8ZurBr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389354; c=relaxed/simple;
	bh=Z1EmUIMTRNQpjVvyMLucljOfuwm27aKN7P3aCl2Vv/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct1xJRQ/C7P/MQpjPwue6BdyTIlKmOGOPH50vJaKcimcCHx9Jj2j5iLy3cd0hJaTMp8DCggXIOZPVm3jvoGivFHrPZnCOIJ+5rZs23fmDDEmNTukrF5Zd3HEYRKVKPGd6ClMsPj0DkRQSUJX1V74Cf6mKrKdo4uYRMs7AHHYVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XjfB/23o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7nlJ2AgBMaomcoS8yeLKra15jd7zP6CEuq6aZpUoDR4=; b=XjfB/23oD+MJie7rF4thlj02aS
	304kJjEyUkFk6w4QyddzTbg60/96t3xxyTd0aAxayOYPYpR1MmymUWUGirvSD81YEOP4lxCNVm+zp
	y7zjwDWXBoi7Gd2oVfR5qfxYAm9bxxqhWTmiDCu43E92bhNTM6jrj51CttQRPjZ/GCgI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v01ON-0091aW-VT; Sat, 20 Sep 2025 19:28:59 +0200
Date: Sat, 20 Sep 2025 19:28:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: viswanath <viswanathiyyappan@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
References: <20250920045059.48400-1-viswanathiyyappan@gmail.com>
 <5b51d80e-e67c-437d-a2fc-bebdf5e9a958@lunn.ch>
 <CAPrAcgOb0FhWKQ6jiAVbDQZS29Thz+dXF0gdjE=7jc1df-QpvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPrAcgOb0FhWKQ6jiAVbDQZS29Thz+dXF0gdjE=7jc1df-QpvQ@mail.gmail.com>

>     Thanks for pointing that out. I wasn't thinking from that point of view.
> 
>     According to Documentation, rtl8150_set_multicast (the
> ndo_set_rx_mode callback) should
>     rely on the netif_addr_lock spinlock, not the netif_tx_lock
> manipulated by netif
>     stop/start/wake queue functions.
> 
>     However, There is no need to use the netif_addr_lock in the driver
> directly because
>     the core function (dev_set_rx_mode) invoking this function locks
> and unlocks the lock
>     correctly.
> 
>     Synchronization is therefore handled by the core, making it safe
> to remove that lock.
> 
>     From what I have seen, every network driver assumes this for the
> ndo_set_rx_mode callback.
> 
>     I am not sure what the historical context was for using the
> tx_lock as the synchronization
>     mechanism here but it's definitely not valid in the modern networking stack.

Thanks. Please include an explanation in V2. Also, please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

