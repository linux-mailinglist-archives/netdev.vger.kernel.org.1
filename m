Return-Path: <netdev+bounces-64051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04189830E2D
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8646E285459
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8C250ED;
	Wed, 17 Jan 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ng3Ps2zJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D6250E6
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524529; cv=none; b=MTXRr4hngU5//OIdJ4WBX30jWzno3AS3WyFMEt5elMC47AFYtFKgElgH853Hk6sxEVXNlDDHi9TyUey8CaxrKfvzTXi0ejPOuxKvmpzrBMByZaHgNfacps2A9S8lpEdr0VIYz/MKqdi1oFLKT2FcZK3iSucg6X+IC4Bq5xaidkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524529; c=relaxed/simple;
	bh=Nhq+zCtB3TjKin/FYavAXEnUR8PJUzpaRUEabWUZSeE=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=WQe37+fenxPSJvxskyUNQdHGo1O35+a/sN5SjA96FYq9MAieA0Hp/wGyZgBOeOocov3jh0zDOw+Fb57lqYiSKw5YlI1Jdhul8PxPzl1328rtuyHIGAirZwvgCUFvNOcOUiSufqajJK75rMgCxuCcfRv+FsmyUs7fjCO0nnKw7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ng3Ps2zJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jlBF40dhKjgjMNY8YC3pbdbOnXrZY07Sem4y2KimocY=; b=ng3Ps2zJ9Jhm8dx8+QCNsoDPUF
	EOZnhQCuAHIM0XSus8oDxgzVdoWFYavRoMXXQcfwm+cNnnBh8qIQPuqoLYfHTnpQankoGc7EFC5U8
	L2ZvnE+u2HkDR2ZgJr8GfdsqAjKAcjU17L3Q/w/P5vdCXED8LGXP1ZyZaaQqzmO8xM5A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQCpu-005Qrl-To; Wed, 17 Jan 2024 21:48:34 +0100
Date: Wed, 17 Jan 2024 21:48:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dan.carpenter@linaro.org, robh@kernel.org, grygorii.strashko@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 4/8] net: ti: icssg-classifier: Add support for SR1.0
Message-ID: <17893c04-b589-439a-a056-7996467b8cf7@lunn.ch>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
 <20240117161602.153233-5-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117161602.153233-5-diogo.ivo@siemens.com>

> +void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
> +			       struct net_device *ndev)
> +{
> +	u8 sr_addr[6] = { 0x01, 0x80, 0xc2, 0, 0, 0 };

eth_reserved_addr_base in linux/etherdevice.h

> +	u8 cb_addr[6] = { 0x01, 0x00, 0x5e, 0, 0, 0 };

This also appears in etherdevice.h, but will need a little bit of
refactoring to make it usable.

	Andrew

