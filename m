Return-Path: <netdev+bounces-173886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BB2A5C1B6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E42E7A82FD
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E5250C11;
	Tue, 11 Mar 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pdxrl0nV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28B2222AB
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697914; cv=none; b=uneKJcdJi05dQzWLWx6Z1Ipf2w7wt9/nDF3nBJ9JKYskTK0a8EfJ60EhqeWklZJelp68H4oMBNxuFCJXwN21rHFYm3W+1svXQbWI+bW2fy6KoMrtEJVhTdprRbPYbn3LSvUj59PobjLP4tcwHMsd1i4u2rFvY21z9iRXrN56I+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697914; c=relaxed/simple;
	bh=osjCzFGwzxQMlZAO3+Zf7makLV4ImWBcJl+zp/cYFek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4+XD4ZFxJstI2e3tBD/LXvrzK+7wGKPmFgo6RuCOtIGKxBPeWQtiAFcspxDWcMazeCsupRFp2UGlDqK6AEI6NS15UnCcxznnN+8mCpq/9ZZ6xsdRaqU18/nZZnbnjG6bmVCwDVoFOqAmX8sE8px2V1D5nZDA9MDGJVBnrAjxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pdxrl0nV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rGSbZkfucclYzQjJjcBSVL/ZAw1z6FAPh4oYQEww2Nk=; b=Pdxrl0nVYoNvgshftqhhyIFYjp
	60asgnmAp9FcmM1wbyegAASaSeGjgOPjIXkLtNOT582poP7rvs4ll39uMbLQggqBK8S8piIeg9nFn
	c7toDzvs/xkW3J/17ko2fGS6ldTYfggmku07jz5bJqvj0a/92iUk6fq6RAUqwym+KxPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trzBg-004LJH-LH; Tue, 11 Mar 2025 13:58:24 +0100
Date: Tue, 11 Mar 2025 13:58:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH net-next] net: bcmgenet: use genphy_c45_eee_is_active
 directly, instead of phy_init_eee
Message-ID: <01fdd095-d46f-4cf4-a493-e2193985ca55@lunn.ch>
References: <e463bc66-c684-4847-b865-1f59dbadee7e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e463bc66-c684-4847-b865-1f59dbadee7e@gmail.com>

On Tue, Mar 11, 2025 at 07:43:10AM +0100, Heiner Kallweit wrote:
> Use genphy_c45_eee_is_active directly instead of phy_init_eee,
> this prepares for removing phy_init_eee. With the second
> argument being Null, phy_init_eee doesn't initialize anything.

bcmgenet_set_eee() is an example where EEE is done wrong. EEE is
negotiated, so you cannot configure the MAC until autoneg has
completed. So phy_init_eee() should only be called from the adjust
link callback. In this driver, it is only being called in the ethtool
.set_ee op, which is wrong. So all this patch does is replace one
broken things with another broken thing.

Please consider my old patch:

https://github.com/lunn/linux/commit/c226f4dbe9aa9c51c1308561aba64c722dab04fb

It will need updating, but this is how i think this should be solved.

	Andrew

