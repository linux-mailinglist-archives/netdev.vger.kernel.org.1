Return-Path: <netdev+bounces-197534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D3AD90E2
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C851E3A28
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605571D5141;
	Fri, 13 Jun 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vB5VNW2c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF21A5BBD
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827434; cv=none; b=RZklKwZqza77/ujMEGnEKTwsCVX7kTJ6S5ILRzTZri0ARTFFNZLktowNKdHpshgN9tFyA5HcuovdTEnHfT4QIf6i6+diLYNYxJnv54Y1MLigbnx5RgKLQblIdTLeF/9YMPaf3wCK8PwHhxRVxLXssIHRsL0pedzdr35p5PMabAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827434; c=relaxed/simple;
	bh=vfyp90m7HFXHUzIYGz6aV6tNIYDbQE7NFY6ppApIaFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5FFnTzcHowZjewZVdiuBBGjWpqFdP6380zuEpYxicr4yFb/PJLYgdErWIW9FJys4ZwKz7bP7mvosQBYrKaXISyEOwTRrzuM5CWWwRnOFYjjrpQ5d3mw/UvOdqN/oqOZhRnPD5M9tgBS4dYQ1EGHKTrpyeG3gywOI8VopJCS1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vB5VNW2c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hg+vpgZxtkeJONb5A1bnvQAZN6Il3JCZYnxHU/QeuIY=; b=vB5VNW2cQBxGw3SYCs4l33/2lP
	XfRuKbHotG53MkXVfMXFPEnq8hL0cBxz1zP71Blg640GbMr7tiqzyDv4J08eslQa7n62RvcUZrur+
	D1+WkVk3szeFpK4cW/MhgpjBg9DfyLlT/hAVMomD6mr58yetIkwrIwM+cwqJYWIf3p+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ62z-00FjWl-E1; Fri, 13 Jun 2025 17:10:25 +0200
Date: Fri, 13 Jun 2025 17:10:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 4/4] net: phy: directly copy struct
 mdio_board_info in mdiobus_register_board_info
Message-ID: <ac83c601-2cc4-4d1a-85ac-dbf6688ba2bd@lunn.ch>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
 <af371f2a-42f3-4d94-80b9-3420380a3f6f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af371f2a-42f3-4d94-80b9-3420380a3f6f@gmail.com>

On Wed, Jun 11, 2025 at 10:13:02PM +0200, Heiner Kallweit wrote:
> Using a direct assignment instead of memcpy reduces the text segment
> size from 0x273 bytes to 0x19b bytes in my case.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

