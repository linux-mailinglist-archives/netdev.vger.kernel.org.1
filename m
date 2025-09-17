Return-Path: <netdev+bounces-224137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1BB81225
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270EA4A7884
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91E2FC898;
	Wed, 17 Sep 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t5Qa5nw6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FB2E2EF2;
	Wed, 17 Sep 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129135; cv=none; b=rwgjMPTquUcvQ72ah6PykrX4201vaMvqNNunoHApH9DMPrVPjzTdNbKXEWzYW/Zckxse7kWRaAtd1LM7QhcSnBw8iks5kIR/7GmfUd1Q0RsiFXt5tX3hexlGylQAStQcgVodkDPH8liExUyA0hlRCA17RGLa9LuukHEOq4ladpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129135; c=relaxed/simple;
	bh=eSUjqv60FM6O6Ej4B1kJKa4oYjfyONZLs9M+I5HZJrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg+YyxoZTpHilCWT15P2QnI1wjbiSixWAfnHm5J+0Jit2c7Em0WQR/vOGgJKipMBhQSw8yu+HsTXaxHiZDN/HPEEwyDmZx6zMXc4eAsHQiGHmNcrDXeUvedyUdDoKXinXl9ug4c9amvAvw7pbuZCitnc1xnLAWyC7/DcJaZOXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t5Qa5nw6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yhimBiuzX2NtgOvEBVXPvzGFi0XcvExBGfaoY1UoICg=; b=t5Qa5nw6hGo0XDdW7a9xR62erU
	m7rldIxJpHvuv1jyzdu2rQb2dsL/RbXdINNnlmlw0uAthDtEfr5z22lbLkWUcwrR9ZfZdjKoC61eU
	uUQOfN/OB7YIfMNi++uuARmWXldN+qCYUAqPkd1XTi4dC+vKD7L1dc4hHsFpd3O93Zpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyvh8-008ibt-RT; Wed, 17 Sep 2025 19:11:50 +0200
Date: Wed, 17 Sep 2025 19:11:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	huangdengdui@h-partners.com, jonathan.cameron@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: hns3: use user configure after hardware
 reset when using kernel PHY
Message-ID: <5188066d-fcd2-41e7-bd8a-ae1dfbdd7731@lunn.ch>
References: <20250917122954.1265844-1-shaojijie@huawei.com>
 <20250917122954.1265844-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917122954.1265844-4-shaojijie@huawei.com>

On Wed, Sep 17, 2025 at 08:29:54PM +0800, Jijie Shao wrote:
> When a reset occurring

Why would a reset occur? Is it the firmware crashing?

> Consider the case that reset was happened consecutively.

Does that mean the firmware crashed twice in quick succession?

     Andrew

