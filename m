Return-Path: <netdev+bounces-128810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C582297BC79
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF061F23E5A
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE7187FE6;
	Wed, 18 Sep 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LOplVCZI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C271176ADA
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663714; cv=none; b=YONr1sJS49RU/2WpXttEE+C5xuGyV5J+7fKTxZSE12c4Gq42B1mTScuDpXkV+GhNXxqpNKLtBikJDXfxv6oxYoGemrPgp38H1qk9S9LLj1g5cygd2GxqfszVAOJSwOZh0MCFTlMQBKIimj4hALGcX0MJoPBetqZ6/r5clglRmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663714; c=relaxed/simple;
	bh=Ii9bJhiQ4cqXbwaHxZY4pNehOtyfQdHZUL/KTKVp9eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4O58aJ42XTmmn6UJIFe+kC62uaXuk5hJqUKc7e8n4Yd95puJaX7mtjjx90Fjgse1FB2jBurlK61zl0cPLvYnunON+bxxogjntx/dqxGFZtUOXcWqpwA4Qtoj0phAa3xr1CfQvuPF1YfNbqQpqzN/NVzNRERQHMjhrQCM3jXY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LOplVCZI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5udiRqP1jvW2TG5PZvBZDfeQ0D9H5Gzkihk+up/u9Ww=; b=LOplVCZI2BvneP6YHuMupnsASb
	aRMNYbcXJwD6n5HSD+Rm0/3Ff5WaN61l3ao9riO4NBLrnEK+HBq9mDfQ6LB4O59y0+x1fr9jQEadG
	xViMRQHSMLmoUy9C7sO1fL5Te02RwGHMUpBsBngqg3iG3AYIu7zrK2u2WPFM+p2s9Nu8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1squ6c-007iSo-2i; Wed, 18 Sep 2024 14:48:26 +0200
Date: Wed, 18 Sep 2024 14:48:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Saravana Kannan <saravanak@google.com>, netdev@vger.kernel.org
Subject: Re: Component API not right for DSA?
Message-ID: <bde4e00e-4f07-4684-9126-247fc84cf165@lunn.ch>
References: <20240918111008.uzvzkcjg7wfj5foa@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918111008.uzvzkcjg7wfj5foa@skbuf>

> 2. I honestly don't think that the workaround to wait until the routing
>    table is complete is in the best interest of DSA. The larger context
>    here is that one can imagine DSA trees operating in a "degraded state"
>    where not all switches are present. For example, if there is a chain
>    of 3 switches and the last switch is missing, nothing prevents the
>    first 2 from doing their normal job. There is actually a customer who
>    wants to take down a switch for regular maintainance, while keeping
>    the rest of the system operational.

Do you plan to use hotplug for this? The user interfaces disappear
when the switch is removed? The kernel will then try to clean up all
state for those interfaces, removing them from bridges and bonds etc?

It will be interesting to see what happens if something in userspace
is keeping a reference on the interfaces, so they cannot be destroyed,
and then the switch is probed again, and we have a name clash. I've
seen USB interfaces not fully disappear when i had a flaky USB hub
causing disconnects.

I wounder what configuration exists which is transparent to
Linux. Hotplugging interfaces won't deal with this.  The routing table
is one, it is a DSA concept. You will need to change the internal API,
be able to tell a switch the topology has changed, it needs to reload
its routing table. But i don't think that is hard.

	Andrew

