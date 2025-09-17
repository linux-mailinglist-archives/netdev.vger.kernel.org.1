Return-Path: <netdev+bounces-224135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77966B81186
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48308620E94
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA172FB978;
	Wed, 17 Sep 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WsU5spqP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F942FB97E;
	Wed, 17 Sep 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128359; cv=none; b=F4XgyXH9H17rhlFDxnd2ydLHSxcejS1dt19bkacreS1/z6viuMdxLVBUs1qqNO+2BCtQYQ1Us2rnb+4MxnEQxDhciRmzTdF17rsxrzapUueUlaTp2TaHkFLVMY6vOJu1xN+0AqqPNH9d4tTTunOE+jRjDBx+B8zKLXHKPcTTy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128359; c=relaxed/simple;
	bh=LyRoG4EagDIB2pRE+5aY/rsh9XhcSfatt0XDUTGFxQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7CJnUu/UPZOtxXUDaKkaZSZqGkZcwXZGTW95Btw6PSyRsbrm7ZIjrofZHYFzLo/k5Y7qpDerhy666sxvSWoc42zV6AiBF/KvnHx5miLdSyhux04LRz5tr8cLpv/DmZPm1PtAuuCPjgLLn+C5f7ClO/I0oXtVG3pCYdOeBpTD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WsU5spqP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BVoadd5F/9NL1Kfvm2TxEXN3h6uo1IEKqiMc/UGEVZY=; b=WsU5spqPHlpgxmikqRVXl5+fBm
	mJ/dwE3WD9XA/CEjjeQxsmCReWAj+HiEi+ooG5ZMvEVdYZaWC6eF+T8hkdYiOLgLWs5cSYxo4FdPV
	l/0FVSTGq7eirPyu1KjfVt7SIn+aIF9knbf4acZiaFMVj0aBoSmoQuj/jZNA5QPpuMuw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyvUd-008iUe-T2; Wed, 17 Sep 2025 18:58:55 +0200
Date: Wed, 17 Sep 2025 18:58:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	huangdengdui@h-partners.com, jonathan.cameron@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: hns3: fix loopback test of serdes and phy
 is failed if duplex is half
Message-ID: <a060e5cf-c1cf-4dfa-b534-ddb72e8652f8@lunn.ch>
References: <20250917122954.1265844-1-shaojijie@huawei.com>
 <20250917122954.1265844-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917122954.1265844-2-shaojijie@huawei.com>

On Wed, Sep 17, 2025 at 08:29:52PM +0800, Jijie Shao wrote:
> If duplex setting is half, mac and phy can not transmit and receive data
> at the same time.

Lets think about the fundamentals of Ethernet, MII and half duplex.

Is this specific to your MAC/PHY combination, or just generally true?

Should this is solved in phylib, because it is true for every MAC/PHY
combination? phylib returning -EINAL to phy_loopback() would seem like
the correct thing to do.

Is it specific to your PHY, but independent of the MAC?  Then the PHY
should return -EINVAL in its set_loopback() method.

> +	hdev->hw.mac.duplex_last = phydev->duplex;
> +
> +	ret = phy_set_bits(phydev, MII_BMCR, BMCR_FULLDPLX);

A MAC driver should not be doing this. What if the PHY is C45 only?
And Marvell PHYs need a soft reset before such an operation take
effect.

    Andrew

---
pw-bot: cr



