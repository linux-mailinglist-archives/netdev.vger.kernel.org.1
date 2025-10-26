Return-Path: <netdev+bounces-233042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2FC0B804
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45153BB151
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C93009FF;
	Sun, 26 Oct 2025 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1PkiU1/Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8332F656B;
	Sun, 26 Oct 2025 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522891; cv=none; b=QUPXKOGvnS7151ObuBX+kHYRIHXrv0i24FjEMGhHsRnqSM8Ln8Vkq8m/EK7QKx+UIA76gsS/imYVyUB3B43P16BGlvqo9+jGtcdj6rxrATJNGsKEton1rHb5dRkNVs9MjzdgBsB/Xjh+ccC25AcWhrBJfsFKX6rPLv9xGsoLnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522891; c=relaxed/simple;
	bh=vwZTxe+ObXBjMgYQ0gvodtEMXgf1fA/8IMgB3QhUv9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUECmX7Z41VkhkvW/I/UUPRTL+KikxETf05uw7v75k8Iiqe17HOsMROCtD2QBlPSF+wyaNp61et9kM7qqv9nOVZOLTfLA9J6aFDe/UuAybLKhUKHlVwPEtZT5yN3ZmuhM6r2OPsP7AGu4hGOnQ/DHCRRRZ9VT+VdhBvX9HZC80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1PkiU1/Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vof5s1/Zw1TeJHjv7+1s4o0cLwd9aghRs+o0h+wWhTI=; b=1PkiU1/QZqsPOzHFz8Vfh/fZBQ
	jCH1GNmPIO3tczm6DM1WN7JBk1ECstBeD2x7+UOLTcOqCxA2oqV/AA4TfPJCQLX5aXp5KwlAvnonX
	EU6GVihy+UUvLeNYvKD+hwzx5TL+7Yaq7phWNaVkN6U4QsinKb4jHf/R8WEXPB1lw+vQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDAZN-00C8ob-LY; Mon, 27 Oct 2025 00:54:41 +0100
Date: Mon, 27 Oct 2025 00:54:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
Message-ID: <35d469ba-6ff5-42da-b4b2-cec11c50857d@lunn.ch>
References: <20251024033237.1336249-1-mmyangfl@gmail.com>
 <20251024033237.1336249-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024033237.1336249-2-mmyangfl@gmail.com>

> +static int
> +yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
> +			 const struct switchdev_vlan_msti *msti)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u64 mask64;
> +	u64 ctrl64;
> +	int res;
> +
> +	if (!msti->vid)
> +		return -EINVAL;
> +	if (msti->msti <= 0 || msti->msti >= YT921X_MSTI_NUM)
> +		return -EINVAL;

I see there are a bunch of build bot warning emails, so this might be
covered already?

msti->msti is a u16. It cannot by < 0, so <= should be =.

	Andrew

