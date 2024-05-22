Return-Path: <netdev+bounces-97485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B88CB990
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 05:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CF21F246AB
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F0642070;
	Wed, 22 May 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ebrf31jA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856657CA6;
	Wed, 22 May 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347701; cv=none; b=Iots8qRtOkE4/Q9SIAK9J5ciWVgLkXx2aFKJaj0mgFq6BP0CMVsCfQB5nTWGyB10nxQhsXMH+S7eoXw5+ZTJ+uBxMfOVIZyyFenqrxac5uruChKuiBAdQC+7v8eyMWgq9DZkcVojBuVho6UtSypjRtF45cEsD+/hSW0Nhq1EGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347701; c=relaxed/simple;
	bh=ChglAZipxV2i+Kmf05G6SqfC7g6IDrIHEQA4dmpQ+eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUsjwyONVkF1RGUy32WRekU4UjglMvl0r1r4UaYUbfkveTo08mrTgnqzLF3zRZFb4+OAn8rTP2cSi992sh1zFgx5ZuTV7VO0SLOfxMi3zGx2aDZS2QaR3njROSnadomKB8rg8agoz9a7HLb57521bFHVdk04YZrQDqfjmLkKE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ebrf31jA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ml/iZayzMliUKM4mSTJoLQHObAM5gqhB0ErOZcdzWh8=; b=Ebrf31jA/1hC4iw7JHnXa04yJM
	tAuosdP8SRk+X/gOTDxpg86xjpgtUZ62f5jXr2ecsr98iRFJ8XuT6T84KNgTfJcmwGSxa39fo2oAk
	lxu5dZqqAsfZ2WjXlk8HYqo7NDDzM5cZ+mbXkNQpnW4FJZH0ieH7OVOc+7RUSBJRbsto=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9cR7-00FnqS-VJ; Wed, 22 May 2024 05:14:41 +0200
Date: Wed, 22 May 2024 05:14:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH] net: fec: free fec queue when fec_enet_mii_init()
 fails
Message-ID: <8bbf2c1d-5083-4321-bded-f83aba5428fa@lunn.ch>
References: <20240522021317.1113689-1-xiaolei.wang@windriver.com>
 <PAXPR04MB8510B1D6C8B77D7E154CC6CF88EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510B1D6C8B77D7E154CC6CF88EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>

> The commit 59d0f7465644 ("net: fec: init multi queue date structure")
> was the first to introduce this issue, commit 619fee9eb13b
> ("net: fec: fix the potential memory leak in fec_enet_init() ")
> fixed this, but it does not seem to be completely fixed.

This fix is also not great, and i would say the initial design is
really the problem. There needs to be a function which is the opposite
of fec_enet_init(). It can then be called in the probe cleanup code,
and in fec_drv_remove() which also appears to leak the queues.

    Andrew

