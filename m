Return-Path: <netdev+bounces-103520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC756908692
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FCA1F202A3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5119006F;
	Fri, 14 Jun 2024 08:40:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EXCEDGE02.prodrive.nl (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C31836DE;
	Fri, 14 Jun 2024 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354457; cv=none; b=rKAmObHBtcCO3rffOCjQ8DvGufwAonI6P0Icc+YzQtnJ7kQOgT+cZtDCRbstSe9HbmqVRZ/UKawRi8rzD8LcxRa8/5oAYgdjiG4uHLuU899Cu99IUD0tey/ePLdlTSc47GG9xQPxAD43Jvg6j6wvv/YQKU30MGyeRINxfbE+up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354457; c=relaxed/simple;
	bh=jLxkqDgK66uSESkHcfpgG41Y+W1bF9Kp28hKCuGXkno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHKjPzKmgfzaP2S4Xkw+nx8T0ipSt9wPpNHIqS2Mmm+D4gzF/7Ab1uXXoDBLLICMnoa0cHKBg6wy9mxWa2n9WKk3hYTdllgnUn+gqS7kIbF22gG4wdxP8NqFC78UVHzVrBpzICi73xsB9wxM9HpjiYbMDGCnpR0nYt+xoL3ZmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by webmail.prodrive.nl
 (192.168.102.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 10:40:47 +0200
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 10:40:52 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Fri, 14 Jun 2024 10:40:52 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.94.2)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1sI2UO-0053sY-58; Fri, 14 Jun 2024 10:40:52 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <andrew@lunn.ch>
CC: <wei.fang@nxp.com>, <shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>
Subject: Re: [PATCH] fec_main: Register net device before initializing the MDIO bus
Date: Fri, 14 Jun 2024 10:40:50 +0200
Message-ID: <20240614084050.1205641-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <51faeed2-6a6b-439b-80e6-8cf2b5ce401a@lunn.ch>
References: <51faeed2-6a6b-439b-80e6-8cf2b5ce401a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> On Thu, Jun 13, 2024 at 04:41:11PM +0200, Paul Geurts wrote:
> > Registration of the FEC MDIO bus triggers a probe of all devices
> > connected to that bus. DSA based Ethernet switch devices connect to the
> > uplink Ethernet port during probe. When a DSA based, MDIO controlled
> > Ethernet switch is connected to FEC, it cannot connect the uplink port,
> > as the FEC MDIO port is registered before the net device is being
> > registered. This causes an unnecessary defer of the Ethernet switch
> > driver probe.
> > 
> > Register the net device before initializing and registering the MDIO
> > bus.
> 
> The problem with this is, as soon as you call register_netdev(), the
> device is alive and sending packets. It can be sending packets even
> before register_netdev() returns, e.g. in the case of NFS root. So
> fec_enet_open() gets called, and tried to find its PHY. But the MDIO
> bus is not registered yet....

Valid argument there. I was trying to make the initialization more efficient,
but you are correct.

> 
> So yes, DSA ends up doing an EPROBE_DEFER cycle. Not much we can do
> about that. We can try to keep the DSA probe functions as cheap as
> possible, and put all the expensive stuff in setup(), which will only
> be called once we have all the needed resources.
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

