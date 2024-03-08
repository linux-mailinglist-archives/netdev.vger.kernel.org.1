Return-Path: <netdev+bounces-78569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB0875C36
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 03:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF641F21E1F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 02:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295222EED;
	Fri,  8 Mar 2024 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WSaWCQc9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB963C1
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709863420; cv=none; b=hFkOyjwf+4L/TF9uG6xNY9i9Q6wLbx4khR1uwTggEuAM46S7Ye/HMR+tgE5Zm0Rhr9bwGtRi9WC2HnL/mN6yazy6EE/koT4AHI/pJwP7b56tOAg9OH1smCng45Tcw+D2A4ZGdB0QkwaVaf/CErin6ChzpHc+T/aYVZoaWoa4RAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709863420; c=relaxed/simple;
	bh=kAklbdXUA8SGIVHP4JDdo/T+4cndl2Zk5g3f7bJoPTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH5vJ94ayZjaLReQrHGUKxqRp0zjSS2Q/SL2r/DVZvuCm/MdWcogrfvAtREXkmE1RTFbcvC6zXdOyIcQAlNU+uukQpRWFBolmn9/+ne3wFV6kWauw+1qJYbRnmyaEL8htM3BV2mosia0omQKCwh0+jVztAFnAzCUYMJ8yd5gDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WSaWCQc9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0lw4f9Mh4IRuCgUbzdym/CLlagnqDLL6W++mGVYVT9I=; b=WSaWCQc90D/tDAwEbuQYKYZM8m
	hEwMcPmizysZ2vq3gw7rka8CbsR0x39RxiY0AibUC2NhzQkaXENiAk2+xjyHVOM23uB+mBHefB/b0
	CfzO0vjQtpDE5COCzw46wgEl5bfAZaFoQS5oSh86ASKXPhhTMOTi2mpdV0o4gq10rxQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riPag-009inD-9m; Fri, 08 Mar 2024 03:04:06 +0100
Date: Fri, 8 Mar 2024 03:04:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Message-ID: <3ee0ece4-c612-41d5-b5b9-743a849d8aef@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-7-antonio@openvpn.net>

> +static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
> +{
> +	return kref_get_unless_zero(&peer->refcount);
> +}
> +
> +static inline void ovpn_peer_put(struct ovpn_peer *peer)
> +{
> +	kref_put(&peer->refcount, ovpn_peer_release_kref);
> +}

It is reasonably normal in the kernel to use _get() which takes a
reference on something and _put() to release it. 

> +struct ovpn_peer *ovpn_peer_lookup_transp_addr(struct ovpn_struct *ovpn, struct sk_buff *skb);
> +struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_buff *skb);
> +struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb);
> +struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id);

All these look to take a reference on the peer. So maybe replace
lookup by get? It should then be easier to check there is a matching
put to every get.

	Andrew

