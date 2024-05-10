Return-Path: <netdev+bounces-95540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149468C28D6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5421C2185E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AC101E3;
	Fri, 10 May 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tmqpq246"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78A944F;
	Fri, 10 May 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359267; cv=none; b=WlLqr9aAjr9P3Oe6bjBgQ6G4H8ys8auUywpFBm7N4T9k2YyD8hZn/uDnXhcHYD8uoI5/0B4dqZNAu0ux9xOHePCkum3CLlez8R4mm3BBwHmhRaSCAa/81kvGkulNemO/Bg6Hl9d3F8rXQ/zev3Jom5q7eGR8Es1nZA8r602krvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359267; c=relaxed/simple;
	bh=xfRjOrQWpkFkYRyjrM5afF91/RXXzlY/Nebpun8maTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igW+++PqsGIRDS6sIWsZrgPom+yIL6p6r1b11iCFhraKqVxKIX7e/N8Jv06vYj0uWiFQhfSWEbyvHqOqajmm83y0JHTdm7nbBfVb/In3yJ3RywcWvy3ry6aLa+80DjCZ6Jiog/VLPVYnm1XEugv3/IYsImTkAsT95SWUVTFpmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tmqpq246; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w1c2swpE732RMxnnk+KeFHljfGUTrIAHWAXm+YYF3L8=; b=Tmqpq246D9GzLE11q+1Bhe3TOW
	kzvmGDytr1lt3wk6s/2qhQV5eo+nggFEUJdgmmfOPYKQnzX55HZaSySlcMqgd79BEW0EQPluSsQYb
	Hh7FJK9UaFuZeEGtFN+w2cxys9nVHhgJMXOVSc/vyhVJCUnIchsIPexXo7w9aF3SVbEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5TIo-00F9Xd-Uq; Fri, 10 May 2024 18:40:58 +0200
Date: Fri, 10 May 2024 18:40:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v18 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <1bb2d174-ccae-43e3-80ec-872b9a140fbe@lunn.ch>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
 <20240508123945.201524-7-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508123945.201524-7-justinlai0215@realtek.com>

> +static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
> +{
> +	u32 csum_cmd = 0;
> +	u8 ip_protocol;
> +
> +	switch (vlan_get_protocol(skb)) {
> +	case htons(ETH_P_IP):
> +		csum_cmd = RTASE_TX_IPCS_C;
> +		ip_protocol = ip_hdr(skb)->protocol;
> +		break;
> +
> +	case htons(ETH_P_IPV6):
> +		csum_cmd = RTASE_TX_IPV6F_C;
> +		ip_protocol = ipv6_hdr(skb)->nexthdr;
> +		break;
> +
> +	default:
> +		ip_protocol = IPPROTO_RAW;
> +		break;
> +	}
> +
> +	if (ip_protocol == IPPROTO_TCP)
> +		csum_cmd |= RTASE_TX_TCPCS_C;
> +	else if (ip_protocol == IPPROTO_UDP)
> +		csum_cmd |= RTASE_TX_UDPCS_C;
> +	else
> +		WARN_ON_ONCE(1);

I'm not so sure about this WARN_ON_ONCE(). It looks like if i send a
custom packet which is not IPv4 or IPv6 it will fire. There are other
protocols then IP. Connecting to an Ethernet switch using DSA tags
would be a good example. So i don't think you want this warning.

      Andrew

