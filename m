Return-Path: <netdev+bounces-173020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46682A56EDB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8077D164417
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84521A45A;
	Fri,  7 Mar 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0vR1x4S5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DE101F2;
	Fri,  7 Mar 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367719; cv=none; b=okG3W0pBsbXnleJCwXvAHYhwx4HfNV15HHloTMmaeW95/peSC3FXhYpIwScP+e1JZ8xZhYaMrWIA38Fv9rX+BOfN9HYRip44nRwf+THjacFdV3ts9oTsB+ARaCztT8XDXfU8CvtBOaw7NvrqLzVcos3wqL/hiyqY3TOgcxre0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367719; c=relaxed/simple;
	bh=3BahQm5SlDJBdR5+KwEJ+91JdOtYIMdEQszQ3pvKMhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEKUBBC1c7cJ5TRyaBP9aUmqwnNcAfHjF5vPULXb4tx/pFNdxTIvtkIct5qmvq/YXhqVikrUsfzJLy2gbfVclA2M2Oyc2Vn4hnXQVFBtcvdPg2YdRWq3IcsHOW3QDoAsFuRAnU04ylSm1aodR1CNj2m4FV81YRZd4NPCj+43/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0vR1x4S5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7iCfeCNhNbSrVOG/TQp6z3O5xsMhBDg1NtYO7QQkYWU=; b=0vR1x4S5bgxV4e+q8kztTqAS5Q
	FZaQNPmxqGbP43RmbWr8HlU0OPAcKw8UrBdet7aVdujyV7eYAoR69y2AZjCxL4k7++Kgr/0AAwLw8
	Fkrx4cZsD11XbOXigk7VXhIuhC/tlX1eUTow5XtzblBl28J/We/kxNk8JqogbMksssAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqbHq-003CZh-KO; Fri, 07 Mar 2025 18:15:02 +0100
Date: Fri, 7 Mar 2025 18:15:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and
 php-grf during probe
Message-ID: <1995782a-0a1c-46dc-8929-7fa3428a5ca3@lunn.ch>
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-3-jonas@kwiboo.se>
 <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
 <1dd9e663-561e-4d6c-b9d9-6ded22b9f81b@kwiboo.se>
 <20250307085558.5f8fcb90@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307085558.5f8fcb90@kernel.org>

On Fri, Mar 07, 2025 at 08:55:58AM -0800, Jakub Kicinski wrote:
> On Fri, 7 Mar 2025 00:49:38 +0100 Jonas Karlman wrote:
> > Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe
> > 
> > [encrypted.asc  application/octet-stream (3384 bytes)] 
> 
> Is it just me or does anyone else get blobs from Jonas?
> The list gets text, according to lore.

Sorry, already deleted, but i was able to read the contents, so either
they are plain text, or mutt is clever enough to make sense of the
blob.

	Andrew

