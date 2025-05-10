Return-Path: <netdev+bounces-189472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE0AB23FC
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8897B7DA5
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85191EB1AF;
	Sat, 10 May 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s2mDVlei"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6B18E02A
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884889; cv=none; b=J/yL5sUNVHXdeRjWW7wVhoOUhs0ZpcJBAMjb2DM8iMVWvQxgjsJ7i/GPQGkUVGZPoniit4Cza1RDw5EY4UPY6d5QkNAq2QYx8n4vgaCFXdiXCZOSRKQFiqEswQbsh097bvb80V16BGPKKUTeMrB0PIYU4uP0Uybcg20B/H1yK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884889; c=relaxed/simple;
	bh=7nvBHqklsBKPQkPWKWO+ie2HYbIb5+o9ltX8U99aKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6J8CkI9r6T49pQd15jX2NI6yKRy7JNpDkxx++i8Ffz7anhnFiTuCUbSrqA8EkQjVigbTiotlmOJ0TIFyK2c7TsQkH2fh+69RSKysAQ1lo+DBRXgtm4UhcFr6iBT9/xcPLoCo8QEZLgRs6djbV/f2XB2RfYkEnjjK7qWRYP16jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s2mDVlei; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QGpM9odZ/0lgkNBIT5XVHrERDr2nPXCqQTURWBLf4Uo=; b=s2mDVlei8QlMzUqMSO4sz0lO3k
	adtCS8i/OvqgsIzBNhRzWmmux60z2O9OIkL3FsyzmJGSB9YNnA1trv6ksxEmKtuNB/aH5InHi64aA
	2YEAnUUtlf7OSrSi4Wnr5HlF0CObKEeRxxxZ6FA20CweANiNX+0KR8nGv08vecHzmWus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uDkYN-00CCss-Im; Sat, 10 May 2025 15:47:47 +0200
Date: Sat, 10 May 2025 15:47:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: tonghao@bamaicloud.com, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
Message-ID: <269b7f80-e11f-4b93-9b89-cc75293b0039@lunn.ch>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-2-tonghao@bamaicloud.com>
 <1133230.1746881077@vermin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133230.1746881077@vermin>

> >+static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
> >+				     struct net_device *dev)
> >+{
> >+	struct bonding *bond = netdev_priv(dev);
> >+	struct bond_up_slave *slaves;
> >+	struct slave *slave;
> >+
> >+	if (bond_should_broadcast_neighbor(bond, skb))
> >+		return bond_xmit_broadcast(skb, dev);
> 
> 	I feel like there has to be a way to implement this that won't
> add two or three branches to the transmit fast path for every packet
> when this option is not enabled (which will be the vast majority of
> cases).  I'm not sure what that would look like, needs some thought.

Maybe include/linux/jump_label.h. It is what netfilter uses to hook
into the IP stack at various points.

	Andrew

