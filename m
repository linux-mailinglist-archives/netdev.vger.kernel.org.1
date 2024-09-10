Return-Path: <netdev+bounces-126975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AE973715
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B451F22515
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736E218E77B;
	Tue, 10 Sep 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t5UBKj3k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38318C002;
	Tue, 10 Sep 2024 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970907; cv=none; b=kbdGjQ3lRCYRMFa60RExXbsZJxcTrRmLV+v55D+pdg5NsPfcHVolGwr6HeAVHiK5CvSHRM4huLdLNO/v2dV/G3v9RPauAmFuUHuo6LZgcj/qf0jAOQNnwLPZUGCT3UnKoeHiuvvha54yxluZox5dMDDHWpruNqqSc9yVemTvIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970907; c=relaxed/simple;
	bh=R4bRpoZQTJGLcsSUeZLA0bqlhVZtr6NJZtd15TdSQlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1a7uVW55MmLDzPeQIwBCaEAU1odnVGd2CkNGxa2XHzd64hlG+FB/bHPYBjo9i7iD+R6HazeL5N2KK/kMrjH/BQV3jnxoagh2naqMWRY8CtVKIQ5qfL/OKRSGandUUuIEt0aiIjo+erEN9dD1a/QmnO22BGSG9GLVKUnrtnrd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t5UBKj3k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pa3y25XPS34dk9RjXuAf0B+L/pu80i0HG9hqHjOhkb8=; b=t5UBKj3kTPpIqbBl6/qD+SKh9Y
	fswhWjaxQxTwTOEF01Hqs8pp4N2aoUDojf11IzKp7eXF/WuNE1sGsGTr/OOjQ94Ch4va3QfygpzMA
	q5q8NmmSyiTHF47XsgoMrKPAh1/zQdU96deHAg9QrzxSAQ9qdpiT+rJGD1GdJYyamfyc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snzsF-0076az-S2; Tue, 10 Sep 2024 14:21:35 +0200
Date: Tue, 10 Sep 2024 14:21:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, jdamato@fastly.com,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
Message-ID: <5a6f372d-31c3-482d-8925-d2a039643256@lunn.ch>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910075942.1270054-4-shaojijie@huawei.com>

On Tue, Sep 10, 2024 at 03:59:34PM +0800, Jijie Shao wrote:
> this driver using phy through genphy device.

As far as i can see, there is nothing here which limits you to
genphy. The hardware could use any PHY driver which phylib has. In
general, we don't recommend genphy, it is just a fallback driver which
might work, but given the complexity of modern PHYs, also might not.

What PHY do you actually have on the board?

	Andrew

