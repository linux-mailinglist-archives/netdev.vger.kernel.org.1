Return-Path: <netdev+bounces-223006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9FDB5779A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A333BB909
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1943002AC;
	Mon, 15 Sep 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf81PQ1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DC2F2906;
	Mon, 15 Sep 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934160; cv=none; b=jFaB2oxc9mS0bBeKqtjyRY0SOol+bYdde1+SEskqWqd+KKVpS7fGE1phgTruNZeFkbchlwQN/amXJsVaS0em0FSlkj1obwLxumfLPZpVXQan7p1sTyg44NzQvCOKfW/b2zlCaT17u/jz9bBRMa5lpKdQ17P1XsvHX3YxV2X2n8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934160; c=relaxed/simple;
	bh=NuAPghNBbEeMoQfj/KDPyEmoT7CNKEs46PUUsk73Hxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUhz2M1o1wYNVX1fSQti4YEQKFjYS+ab7U9My1vy0V76UCnDPJSsCAqNfj5H2+q2FHzc8Lv5Dr2wcJW578ge5PK8GP8tNfQweSB/BO2k5WRSOcgIXxjnsay45Wbue8kIB4tY0ny0cShiCDIMjUnr4oYHm+s2TMZ0UhB3xVzBIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf81PQ1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3162AC4CEF1;
	Mon, 15 Sep 2025 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757934159;
	bh=NuAPghNBbEeMoQfj/KDPyEmoT7CNKEs46PUUsk73Hxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sf81PQ1US69vWJJL6Gp2AQ2dASB+blYHnLKq2DXxAnO9p2xk/km516ZQhePj0wG+e
	 3C+EDslmHIlL3TihkcrL3gmA0bAHyAizd/ZhCVT6nIULkHhEVZIY0VamT4F5deB66j
	 lFOrSV5d+knmwiwJEvy8Uv/rWoSA5hGkgS+HSUzihVE0ssIHG5IVahlmoM9zu2algM
	 CWh3f9TjqS+j5KDUxG2EJ8JoWtQWbmrZ6BvjBa3855KpKaXlSDudQD1qiQJajd3U7G
	 FSGQj+JlzFV25rRBdDYXr7BHACeJuru4PgRBLdRhdRTAR4scwOKhbsUWrJcZVI3WWY
	 1EbltiwzcZW9Q==
Date: Mon, 15 Sep 2025 12:02:34 +0100
From: Simon Horman <horms@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v6 0/6] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <20250915110234.GT224143@horms.kernel.org>
References: <20250913101349.3932677-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913101349.3932677-1-wens@kernel.org>

On Sat, Sep 13, 2025 at 06:13:43PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi everyone,
> 
> This is v6 of my Allwinner A523 GMAC200 support series.

Hi,

Unfortunately this series does not apply cleanly to net-next.
So, after waiting for review, please rebase and repost.

Thanks!

-- 
pw-bot: changes-requested

