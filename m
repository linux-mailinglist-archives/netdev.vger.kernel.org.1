Return-Path: <netdev+bounces-152633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B19F4EF6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3158B163C25
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC31F707C;
	Tue, 17 Dec 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TBhCCGaV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196D1F4E46;
	Tue, 17 Dec 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448276; cv=none; b=oQhezV8NzbCzY/m7EnEKLauzKr45pOnqtK53VUJe8+GokGfbbn55Eoy1DTkKwRWT1nGV+M9Qe5CuYg7v4yuGB1tOeubs1f1W3GVQKQgkygRUkoroBV62w6Rg4465dW18SwoqfANHPkDcD9vYaUiDIG5Fy2eIcni+iOxtLjkXBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448276; c=relaxed/simple;
	bh=iIxj60BpwGbbLJ0CF9MIoq3xCALMe+nrXv3lmpkl9/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adQIvWrk3OD4/uXhG/vvaWdy/Lh6+tzhORYgtpl6GDWXpAAPpDTcHXFalpgrQc1wjAwMOZhoIJ+BlUBOwD3VnZpHHQjzRVah4BOXuo1jzCIv9zXNKqpYULK63IUK8TWC2A27T+4Re0ZKnxD2W7Ol83kzKH4RX0bOw4r9gGgMWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TBhCCGaV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EibVegeAU8u3QVeD4V32NwkFOPCcH2a2IW1x32pLl7Q=; b=TBhCCGaVs6LNtQkkyrPTMtNDfP
	0ovU5iENa5n7TXyg4QWXgIkwdevkgyjoaFvQ2VAiXXU6kx1iahc0+2tOu6i+yHfR/e1bBCrP3tqB9
	24cdlr24833fu+fK5FmuIjme8YJx4GIP1rueepoZt0zjBX3tgkMO4VRWbkSrtCf0vcXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNZE2-000z5b-Rn; Tue, 17 Dec 2024 16:11:06 +0100
Date: Tue, 17 Dec 2024 16:11:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v7 5/5] net: phy: microchip_t1 : Add
 initialization of ptp for lan887x
Message-ID: <44fd803e-f3b2-419a-878a-67ca8b67325f@lunn.ch>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
 <20241213121403.29687-6-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213121403.29687-6-divya.koppera@microchip.com>

On Fri, Dec 13, 2024 at 05:44:03PM +0530, Divya Koppera wrote:
> Add initialization of ptp for lan887x.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

