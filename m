Return-Path: <netdev+bounces-124544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554E2969ED2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8859A1C23709
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E555188CDA;
	Tue,  3 Sep 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m/HYaQzP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A11CA6B4;
	Tue,  3 Sep 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369359; cv=none; b=n41mghzy2kX0pC+dQhJ90oexuYFFxm2wm0d6IRjt0QFePzNAtk11izZyoyC4Pw31eAtcUQ4s5dFgPDwPWKaauFcjPthZgYBCBCvekyKYBWe/iyod6ZA7WT9/hMw+9O3j/Z++KKeS+r5ucA9fUTnispbJK74VxbGAy9LQ7RlhU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369359; c=relaxed/simple;
	bh=2qYlaHVxCy4Zib0zPVUee1oIRr+SkDTPQaAOcALw4yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhpyGtaPUll31JxyePPDmFQl/5ANmz7cCsTFRhuSmmtrIrj+1ZT6tLf1TQ4aGxJjjkxFt1kDeMKKcz0zyxVKGwDliCTbdCzEtmkcgBthQSWlUaASSuKrN3aXQxfUg8qX98rXDl0DMo3I2PJQoiQy3C6iC7zx+L3m7+5CrvJ4mlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m/HYaQzP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=w6FJTTCbsbtC33hu73PQZTdhaOGjzulZgM4Z1SFNj+E=; b=m/
	HYaQzPFJjOTRy/fYH78Mm3YFzM7LLt+pqI4ZVNhmlS7SbEaqhNQH9VDtnI5hX92NzldKGW0q7KQuX
	jTIdwWBvdPnZeUtZDmIv1rYWWFHbQ/HQ1OOnUjG/eyR+Ft/D+RoRRAX9HUUlubixkIqfnbMnWdiNt
	CoJgNe7x7/22BBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slTNt-006Qf0-An; Tue, 03 Sep 2024 15:15:49 +0200
Date: Tue, 3 Sep 2024 15:15:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
Message-ID: <58fe658a-ab77-40fb-b24c-59c5cf2645d6@lunn.ch>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-4-shaojijie@huawei.com>
 <0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
 <0341f08c-fe8b-4f9c-961e-9b773d67d7bf@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0341f08c-fe8b-4f9c-961e-9b773d67d7bf@huawei.com>

On Tue, Sep 03, 2024 at 08:13:58PM +0800, Jijie Shao wrote:
> 
> on 2024/9/3 19:59, Paolo Abeni wrote:
> > On 8/30/24 14:15, Jijie Shao wrote:
> > [...]
> > > +static int hbg_mdio_wait_ready(struct hbg_mac *mac)
> > > +{
> > > +#define HBG_MDIO_OP_TIMEOUT_US        (1 * 1000 * 1000)
> > > +#define HBG_MDIO_OP_INTERVAL_US        (5 * 1000)
> > 
> > Minor nit: I find the define inside the function body less readable than
> > placing them just before the function itself.
> 
> These two macros are only used in this function.
> Is it necessary to move them to the header file?

Put them at the top of the .c file. That is pretty much standard in C.

	Andrew

