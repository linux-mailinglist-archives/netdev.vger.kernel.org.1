Return-Path: <netdev+bounces-111923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBA934253
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9BC2821D1
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09B182A4E;
	Wed, 17 Jul 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4AiQuo6z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D61F94D;
	Wed, 17 Jul 2024 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721241205; cv=none; b=GortY2vJl6oCxYQvjlc3Y7geWf7YzETTpCidN/Mx9+7onq0VQ1wSOMc7sNm14TPq63vZ9T22Dvu1/tMUPhyhb99r+NEOC53hQAMRhch7YvQOHYBdYBEdyFqpDayqVlTb0kvVDn1dddhlKZv7SNPNe6VhFZwgNbIZBIqmFcwB5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721241205; c=relaxed/simple;
	bh=wNFfyU3fmlSuNSEHV++kDx3lWB1kKqgz5eu+4+sd+kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBQTZixK3q3O4rbZxoiKx67WwJUoS36v1je0xJiqHuV1N+yyvfoE/7YDWN5WVPCBq5PJzRmi0/rSX88mG5CBaJVaJiYmwE1lcC3BH9eKKkxDP/dINFkZhPZoRai3im2oUFUs2bn/MYtS/CG041xdSp9DsM8KomH94onl190UYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4AiQuo6z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yAQJjnfS8FUtmLtJ14bUmjvpA37muUFgKZUF7wK1P+M=; b=4AiQuo6zk1xveRfzmp74hue0LN
	gqJE06JdaXqEiqU6hPiAE9HbAO9mQeoHMcLERnfcBc0o/FECSuSFrHeI7Yj+SXFuivrbDIVrfRI2U
	IdI5XaGGMNIsAKB7rQlmwyKG+nIhyh1Tbyx+ghJvRmeXMvknlKQxk1y2WS+zynAazDhI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sU9Sl-002jHQ-M7; Wed, 17 Jul 2024 20:33:15 +0200
Date: Wed, 17 Jul 2024 20:33:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: dsa: vsc73xx: add
 {rx,tx}-internal-delay-ps
Message-ID: <215e89ce-f06b-41ae-b0bf-f3d6a22a502d@lunn.ch>
References: <20240716183735.1169323-1-paweldembicki@gmail.com>
 <20240716183735.1169323-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716183735.1169323-2-paweldembicki@gmail.com>

> +$defs:
> +  internal-delay-ps:
> +    description:
> +      Disable tunable delay lines using 0 ps, or enable them and select
> +      the phase between 1400 ps and 2000 ps in increments of 300 ps.
> +    enum:
> +      [0, 1400, 1700, 2000]

It would be nice to document what the default is if the property is
missing.

	Andrew

