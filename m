Return-Path: <netdev+bounces-65937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CC83C8A9
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3D82964A9
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B47613DBA3;
	Thu, 25 Jan 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vDjAXjXo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE813DB80
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201073; cv=none; b=goSG2V/VCPIGtVJ+B7ADNaAMm24QwvN6G+e8iKP7GGJlOR0vWbLeDUkQzF9+KHZ08j5ICxQ6SoNGKmtDku0Evi17op2iIYa9iP7jJ1yCweG1nbH9dLsFYz+uysnzsz8+fzuJzuAbEUlgW47XciAxp2neJmcFDHSfJvKNtS6BoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201073; c=relaxed/simple;
	bh=V/FiD0FG3PIF2CE8OYwEbGQOcTZXenRcqEAoI8yNncI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzDe8sp5oV/gKdQbIvb2BtOqzCRxONtZxm02vd8dLO224haZl4N5kALhZk91kt5m4oQUHLze/+RiPm2Xo+ksxSL7jawcvLb9Dclfc0aOHfoKq8CuqaC6R7JsfX3sHz8dIbVLl4zuWse0Z3ix3BFWvl1xFfKRWlh+211K/Dd+300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vDjAXjXo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CatSwD4YtlSiXbd6Jq7QbblIMTQApIl1yIHb2cQxXvU=; b=vDjAXjXoeBb26UrzfFNw6EmXvF
	LNt/StM2ea+FjsJTmE3XWHK1iqff4TYsTLVcusojioGNjcrL/DmFwC/Ee++/g8F7i9JioiecwzkEx
	njBPb5wUKO38qN5r0N6F0WwxsBeRyOmnITWntsnYopcnsEaHsfBex/toFoM7yTjnDrGQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT2pw-0066Jo-7B; Thu, 25 Jan 2024 17:44:20 +0100
Date: Thu, 25 Jan 2024 17:44:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 2/2] net: txgbe: use irq_domain for interrupt
 controller
Message-ID: <d077ffb4-ab5d-47c1-875d-bb73744bcb17@lunn.ch>
References: <20240124024525.26652-1-jiawenwu@trustnetic.com>
 <20240124024525.26652-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124024525.26652-3-jiawenwu@trustnetic.com>

On Wed, Jan 24, 2024 at 10:45:25AM +0800, Jiawen Wu wrote:
> In the current interrupt controller, the MAC interrupt acts as the
> parent interrupt in the GPIO IRQ chip. But when the number of Rx/Tx
> ring changes, the PCI IRQ vector needs to be reallocated. Then this
> interrupt controller would be corrupted. So use irq_domain structure
> to avoid the above problem.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Apart from the TRUE vs true, this looks O.K. to me.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

