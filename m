Return-Path: <netdev+bounces-168246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261CA3E3EC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5959E700556
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CA2135B9;
	Thu, 20 Feb 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNDGmZCS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5ED1B4259;
	Thu, 20 Feb 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076344; cv=none; b=Q8+0dW8PemTByourJ+L7JqUFYHqzIORiOcSzc0EitF5N1SWxE9ARggORzP4LToFYURPELGzaR+K51l1XM9f2zTxUn61/A7XGSJJJ1ZlHWlUFyJlUyhb+QoMDJ4AwhxXh8zYvgyN2Ys0+xhiwum6sZ1fUYa+tpp/GeBlcihesAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076344; c=relaxed/simple;
	bh=KlJOptjrK26qqI7fYyBqDOrSDWsN94m39++SbP5EdBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4WCasYppwd1Hj4wNC8PzkOiEL39v3LmrSL7bhrwytTp/iNyW+cNfZh0YLVXkVDauJBephVDp9Mk3jASgpqHAZd5+6RDV7VbiQOGnl9N12t+YrC0A+s6K6bYAvp9BDBDV+G2rjVNpn8rFVXxzTWSU2sm6HJngfhGKflvk0uZfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNDGmZCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF936C4CED1;
	Thu, 20 Feb 2025 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740076344;
	bh=KlJOptjrK26qqI7fYyBqDOrSDWsN94m39++SbP5EdBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PNDGmZCS7So9OWKTTcvxLUv1MQPsJ9soDwDDyqQPPlfi2KfQ94I6m2iDZcDf6xknC
	 GTY2pE0PKZ1+vmBwuH/cCl3XnOvXqkoODU2cKozeRDW7EnFt5J7GelBwkXHN18R9k/
	 FZFKVLuVrLPGq8vZeEro04GSGUIAnxDpT56jmkqKUbV/clgx9UzSwtWmUbpNLsjlTv
	 OQOGhfgIskf8IZcINd0GZw6ElAH8KZCjYy2APIFmkkReJsEmhl4NyOgYyo0GcKYLSV
	 euFU5u10F+RV5t76PxFLjEATo0ywO3U4kg2TBxs4n28Nc5W0BIMiqnGKnfZ612FBMz
	 f8Blyxl6EO1iw==
Date: Thu, 20 Feb 2025 10:32:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: patchwork-bot+netdevbpf@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
Message-ID: <20250220103223.5f2c0c58@kernel.org>
In-Reply-To: <1510cd3c-b986-4da2-aaa3-0214e4f43fe6@linux.dev>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
	<173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
	<12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
	<20250220085945.14961e28@kernel.org>
	<561bc925-d9ad-4fe3-8a4e-18489261e531@linux.dev>
	<20250220101823.20516a77@kernel.org>
	<1510cd3c-b986-4da2-aaa3-0214e4f43fe6@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 13:22:29 -0500 Sean Anderson wrote:
> > If no - will the code in net still work (just lacking lock protection)?
> > 
> > If there is a conflict you can share a resolution with me and I'll slap
> > it on as part of the merge.  
> 
> OK, what's the best way to create that? git rerere?

rerere image or a three way diff will work

