Return-Path: <netdev+bounces-91791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341098B3F14
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91081F236C3
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68A16FF3D;
	Fri, 26 Apr 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PhFLJSfq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40916F839;
	Fri, 26 Apr 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155291; cv=none; b=qgcKJsIUFrqv7Nc2kRmZAO2ez7yo8tf2gFSnmht3rp3yVIXvyJl1yQTUp9sYmxZd/XzWbbqq8GEOl3W5Sb1PMvXQrruMjWPJ1cgAu+EpEtl5j3xaG3AJ/UuPdAC4IBvpMLVrxH+2fu494GUBgHCTvlK7PCaH6bPg6SEA7J1RYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155291; c=relaxed/simple;
	bh=aL+AOy98y7p7r4a4ubMyOvDKADw2J3V43gkZpKNu/YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7ptNUn7Ab3rdoSuRlpbM+ZUeIN0Kg8pfq4ta5GnD4f9XN/+GSGU8sfrijeTMEp9oNTgWXHZdH8RLPqqZYaOqtBdr1FcehvUkLrHxgFfjGcz1fE8aVt+2G8axokctBM+7vAu6JzNsgsdF/qXDEfrmGNKO+bE4ogL2YVv3kEXe6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PhFLJSfq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Ns3sujM0QwOg09c35vecWwkpRlwfLNAqtRcHWhWbTM=; b=PhFLJSfqTf0Z0MWkRMYyV+tLm6
	usldLZoaXjGgadC8qgt5l5vlBisDy2uBuskWtFyN/1C8b7HjC/017h/vCGKfN/O43vrAq6TSUEmsS
	WVbUR0/Sa87dATDSPUYFVb9GkVslX6LNyWhE+UmeoShNGKsyXSG39pu6p7/7O57jVKVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0Q5n-00E636-6R; Fri, 26 Apr 2024 20:14:39 +0200
Date: Fri, 26 Apr 2024 20:14:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <4f6bac89-d6bb-43d8-8675-58a290fb8d5f@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <231ce196-6a68-4f09-8f9a-976c5ce1495d@lunn.ch>
 <9909d4c4-b3b9-4c4e-9923-64945b6c7bb3@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9909d4c4-b3b9-4c4e-9923-64945b6c7bb3@microchip.com>

> OK, I will implement this helper function as oa_tc6_enable_zarfe() in 
> the oa_tc6.c. Also do you want me to move this helper function 
> implementation to a new patch?

Yes please.

    Andrew

