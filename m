Return-Path: <netdev+bounces-128221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3369788E6
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709C4283ADB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBDA146D6E;
	Fri, 13 Sep 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fz33angr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D212C54D;
	Fri, 13 Sep 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255426; cv=none; b=Sxg2an8vQtvzHyNYEbj/D0SSWDQ+s61EuOlQ60vG7t44zglQRIt5i4HDJmc9qiGxs2t0C0Iuvz1/FZhj4UhPKknYOR1LZ01+APqGwR8m2t+rpisJ2WBwSUa6ZvzzBaw0QNIFBFJ3Xgf1i9HXJt4K8BEGxYjnjy79utBgNRCmavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255426; c=relaxed/simple;
	bh=LcnOMbh1qvm3zhdrSHVO6mUT+Z0nOqKVjH3uiOQkS7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8hYUIFXX4v5Z2I2U+jvf71a/kRzk5SAnLztCS9BbpP4oa3roYzIxJxcrO3K0LuNMAlovdiEUSRhmJ413j7EbOij1Dx6+xu0Qaub5ECuJxbcowe4pcsOSmxrue+xHXFqAktaEDmcGQW7M73kQzVi2gvRJ++8GZAPaT5NJF+obXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fz33angr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ehW2zOOXQpeUuabw+vDK6zCAezWgQxAYBOm2PkG7Hw=; b=Fz33angrn1YqfFcW+PLQzRKCNH
	/3P0nU3j8biXCd/jXjjJthouDUlgeTuK5A2HB+5magrNifjvDmlLWvfHqH8mv5Pf9PkWlhkDGGY7L
	kNAEEs1UVIvorKQWbkbzJ43bP6LpMpkUrY8psWNScx3vjj1FqCdJbjvoX7fDTnlulARY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spBtG-007Pzj-LJ; Fri, 13 Sep 2024 21:23:34 +0200
Date: Fri, 13 Sep 2024 21:23:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: dsa: the adjacent DSA
 port must appear first in "link" property
Message-ID: <695c4ffb-5a68-41b1-8fef-8a356dfd57b5@lunn.ch>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
 <20240913131507.2760966-3-vladimir.oltean@nxp.com>
 <20240913-estimate-badland-5ab577e69bab@spud>
 <c2244d42-eda4-4bbc-9805-cc2c2ae38109@lunn.ch>
 <20240913185053.rr23ym5otprgiphb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913185053.rr23ym5otprgiphb@skbuf>

> I have unpublished downstream patches which even make all the rest of
> the "link = <...>" elements optional. Bottom line, only the direct
> connection between ports (first element) represents hardware description.
> The other reachable ports (the routing table, practically speaking) can be*
> computed based on breadth-first search at DSA probe time. They are
> listed in the device tree for "convenience".

If you have this code, then i would actually go for a new property,
maybe 'direct-link = <...>;', which only lists the direct
relationship. Keep the current property with its current meaning, an
unordered list. If the new property is present, use it to compute the
table. If both sets of properties are present, ensure they result in
the same table, otherwise -EINVAL.

    Andrew



