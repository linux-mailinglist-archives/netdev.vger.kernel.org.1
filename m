Return-Path: <netdev+bounces-200154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BACAE36F3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E320A18931D0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE51FECDF;
	Mon, 23 Jun 2025 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IYpsOIP8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A61FECAF;
	Mon, 23 Jun 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663964; cv=none; b=tbjpAQr9G+vCyuoXxLgRWG+6rOhKjrEmBb2C2MFkOTaM8PSRn5ELUYTldFE/4JcaBKrs53aNRArU9dwC0sawSpuER2BwmXHY36LDCqiFX6cVFNJCkc2IQV5hQT/EiGxaXDRMBQSJObkWyrnBTC1xMZjvwO4EHN+bAk2OtfH7Okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663964; c=relaxed/simple;
	bh=Ns/SrFWIN2dc+XgtJpoHD+knchMMyncm/VnkXJ2yQf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXGJewmNnFlSgR5S/s9h5gfEmjpl3pE4PIjs15Ug/jwcXIwV80laNq3zOfqwpZx0OefeL3HzGqpDlJcQh1tWVfKvz48UbXgdjrfzbjTcQzQFYGFUZX4hBhK5RtWglvN6SbnzUNkGayFOUlHOipc1RhMmNBkQEQdjLWQSgP8qYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IYpsOIP8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lJb3LQhfG17yK7huNXZM1LaaWXrW/89Lfygnm9psnzo=; b=IYpsOIP8+iHSIGR2lP6jW9caOa
	RkP/Xc1cz1BJ48g3FXC0DSIzZ0YcO21GYhuH5bQj07JkX5oLHUO3qh47is6+wcMPSgLExiM3EFzok
	XurcYBF1S9R55sg0DhdthjFwp5s8dyFCpwY0okEv2cjh4TGkVFhpBxLF56J+fcSsQQoE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTbfJ-00GfMQ-Ad; Mon, 23 Jun 2025 09:32:29 +0200
Date: Mon, 23 Jun 2025 09:32:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/3] net: hibmcge: support scenario without
 PHY.
Message-ID: <51a9e27a-8a67-4188-8875-8cd81e34765a@lunn.ch>
References: <20250623034129.838246-1-shaojijie@huawei.com>
 <20250623034129.838246-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623034129.838246-2-shaojijie@huawei.com>

On Mon, Jun 23, 2025 at 11:41:27AM +0800, Jijie Shao wrote:
> Currently, the driver uses phylib to operate PHY by default.
> 
> On some boards, the PHY device is separated from the MAC device.
> As a result, the hibmcge driver cannot operate the PHY device.
> 
> In this patch, the driver determines whether a PHY is available
> based on register configuration. If no PHY is available,
> the driver intercepts phylib operations and operates only MAC device.


The standard way to handle a MAC without a PHY is to use
fixed_link. It is a fake PHY which follows the usual API, so your MAC
driver does not need to care there is no PHY.


    Andrew

---
pw-bot: cr


