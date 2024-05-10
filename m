Return-Path: <netdev+bounces-95588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33D8C2B3C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F7C286CF9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D345BEC;
	Fri, 10 May 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yk2OBy9B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD210965;
	Fri, 10 May 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373625; cv=none; b=bz0LOc5MlNc1adFLkbyGkxp/tjr9pLky1VSwBGrYbeaLUaUilWygFmiqEgbuEBINJIZjaGJCwrai1JsBFL/rU6SKqNMV4nq79Q9AUYP8ksfLKRcsogmuiMbfM8ioPidR1zH96dO5jo8XeFCD4VHE1sB74GQKZXHIdndgA59Pgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373625; c=relaxed/simple;
	bh=61/pXvIo7oQXuIFVhlpZF63jmnrY8nk6FU1Ool7yifc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf1DeZaGgUaYHp4l6AythJ57dJUesy3/MWefIMjagHvvMIctgpyPP7pQTMxVxAgJX7ksMuJy+U1LjallqoUwZZve1WhfWC8NarVtdd5VMsoZSbbiTDodbN5jEnDzCR26uIi4iqfsAirUVo3yg0nWt+ET/SDKfyDP0aucbxsM2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yk2OBy9B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cji/BcjdUVJRGmBr0X3w8bpMZNTFgpdcAnrohJFFXU0=; b=yk2OBy9By6p/Q0+DWDdKsJTm75
	exankjdzxizDCHsFTQR9J4ql9GnukHgPTGK5zt+VN9aj0vZbyhIntbbPavpDcK5w9HLie7KhAgImf
	KcMBCmbVdmQPz9DB0UF2CpMFf6ElmfN8ggbZ15DGENoU+Def8M9xx6Y4FZ3MeOjEoxrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5X2P-00FAA2-Py; Fri, 10 May 2024 22:40:17 +0200
Date: Fri, 10 May 2024 22:40:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Jurgens <danielj@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and wake
Message-ID: <184399e7-b2c6-436e-91d9-9ad6e0404fe3@lunn.ch>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-2-danielj@nvidia.com>
 <1b16210a-c0dd-4b79-88ac-d7cec2381e11@lunn.ch>
 <CH0PR12MB85808FC72B8F48C3F6BF3A9DC9E62@CH0PR12MB8580.namprd12.prod.outlook.com>
 <26e8aa14-b159-4a3c-ab67-bec41f15f7c6@lunn.ch>
 <CH0PR12MB8580577826135FEA6AC52F8DC9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR12MB8580577826135FEA6AC52F8DC9E72@CH0PR12MB8580.namprd12.prod.outlook.com>

> It wouldn't be trivial. The stats are queried from the driver.

So are page pool stats, with the increments happening in the page pool
code, not the driver.

      Andrew

