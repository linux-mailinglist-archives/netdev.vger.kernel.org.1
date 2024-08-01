Return-Path: <netdev+bounces-115120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA339453A8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 22:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0E71C23345
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A1145B28;
	Thu,  1 Aug 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JUIqVero"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19F15AF6;
	Thu,  1 Aug 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722543378; cv=none; b=DV5rJ/2XEF8wHzE3zu9kwdhFYCTpOZJwTtXhn8o074JEgk/uecvTmcUTBcJPVIb+3kUq8Gpv2BGyRBxXLZpKT6KIINuxhl15rwvX5h2NoSaeeNNFXXdJzFZ09ISAdHJQ/JLHDnco7ld3Pfw7SPKnNYVYoukXt/RafhTOMluJPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722543378; c=relaxed/simple;
	bh=HV00eI47Pzy+kSFI2YlGlKofUYLFQNkZUvmbI9iDXHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjCVbTcJZxk3GzB9kA1T/NvVcMfZc6D1yFlW0WyOlrBg2vT4SKiIrfoFVjlb5g8AQBYb/EfJxKVgEQA0IuygfdHb/OvbYwHj8Dnj7f4aGmQEGVtC3D1iPCGJqw8Y9Z/jvUE4owq63cWq9q8aObhop6h01l7Q8pXSaaHidCMADo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JUIqVero; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Z5qHbRWDK6UZwvRWDPgZgF1CMjtK2kNw6T+7ggvU6g=; b=JUIqVeroumW4Uevr6VmgZe5ABW
	Zi7GKG3qWOEwWu/jMKlvA2crTeEDptIZL5v8/u2IB0NkHPtD5TqzeOwKz8mdkNXAQWklWQjV6w8JI
	iKxkSQkQ2m5eIojCehbm55JB506lJ+xQSJNWgWU8hmd3QsWUk0g4n4agCw246q62FFDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZcDQ-003oGh-Ie; Thu, 01 Aug 2024 22:16:00 +0200
Date: Thu, 1 Aug 2024 22:16:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 08/10] net: hibmcge: Implement workqueue and
 some ethtool_ops functions
Message-ID: <a2f67eb6-63eb-40fb-a181-b320481514f1@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-9-shaojijie@huawei.com>
 <b20b5d68-2dab-403c-b37b-084218e001bc@lunn.ch>
 <c44a5759-855a-4a8c-a4d3-d37e16fdebdc@huawei.com>
 <f54fcc51-3a38-49b6-be14-24a7cdcfdada@lunn.ch>
 <199c085b-a2ed-4d76-bdc6-0f8dde80036d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199c085b-a2ed-4d76-bdc6-0f8dde80036d@huawei.com>

> If the network port is linked, but the link fails between the SGMII and PHY,
> is there any method to find out the cause?
> 
> I've had a problem with phy link but SGMII no link due to poor contact.

So a hardware design issue? Has it been solved now, or is there
shipped hardware with this problem?

I would say there is a difference between the first prototype board,
and real products. If the real product has issues, then we should try
to address it. If it is just a prototype board, i would ignore it.

One option might be to expose your PCS as a phylib PCS. Do you get
interrupts from it when it has link up? Link down? phylink will then
combine media side status with PCS status.

	Andrew

