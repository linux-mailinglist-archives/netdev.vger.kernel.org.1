Return-Path: <netdev+bounces-78086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A95874057
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9B8B215EA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B713EFFF;
	Wed,  6 Mar 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gzwM8ODA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B060250
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752978; cv=none; b=KezThE9Ds8N4Qb9JNvb8uBHSPkwd5DmyfcXxFrbUI1PxNgTV/Odkn8sWUKWQWDwyqmb3kWraRr/OUVWApKDz5D39rbxxeZdVMj+ew1FxUP+fKzW4omwEhB5GLcN4iS9IKmI14cNet17GTnvTESxs3YyWw9hEWpKb4s315CfNS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752978; c=relaxed/simple;
	bh=7PZKADDCMBQELEi7onycP9HXEULKPSQv0v65LaY444g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGyYvJH4Pf+SXWIo5c7wUuA9bx6OA9Zuo0Q0uOP9qkbQ5CPajGqMNvyvXPDMK5iNlBmtNjQlCkbrFWtCEKAOkkZoBvFCmOGN4DaDLz7tzeliD9yFfYPFtHIxqPPx1tEDq4IWSu+cNOmLVevuZPSGuiQ8jHEVWpg/ScmuG+TyrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gzwM8ODA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tle7UsNh695gOO3ff8To8ybnxQU0kDxdWp1PmuWCoq4=; b=gzwM8ODAVkVMiHylDhFRENCj24
	8Pih2qsBFuMboGL/DDQAo+G4H5Y6fcxfO+3Ox/BNnSxAf4R5B2Phnh52cGkTcOr2P6lqEw4E6PC82
	OtXkeD931ZRO70nuXhJL9uLMDmo8KcilEA7ut1e3AYUXMLP+0Q1/yvbcCn39hWBzekbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhwrL-009Wa3-JO; Wed, 06 Mar 2024 20:23:23 +0100
Date: Wed, 6 Mar 2024 20:23:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Message-ID: <f98d9f01-f9c9-4990-ad51-aa46b77ef63d@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
 <053db969-1c21-41db-b0b5-f436593205dc@lunn.ch>
 <91005d44-8a51-4c6d-9f5c-d5951d92f7c5@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91005d44-8a51-4c6d-9f5c-d5951d92f7c5@openvpn.net>

> This is a very good point where I might require some input/feedback.
> I have not ignored the problem, but I was hoping to solve it in a future
> iteration. (all the better if we can get it out the way right now)
> 
> The reason for having these rings is to pass packets between contexts.
> 
> When packets are received from the network in softirq context, they are
> queued in the rx_ring and later processed by a dedicated worker. The latter
> also takes care of decryption, which may sleep.
> 
> The same, but symmetric, process happens for packets sent by the user to the
> device: queued in tx_ring and then encrypted by the dedicated worker.
> 
> netif_rx_ring is just a queue for NAPI.
> 
> 
> I can definitely have a look at BQL, but feel free to drop me any
> pointer/keyword as to what I should look at.

Do you have any measurements about the average and maximum fill size
of these queues? If you could make the rings smaller, the whole
question of latency and bufferbloat disappears. NAPI tends to deal
with up to 64 packets. So could you make these rings 128 in size?

	Andrew

