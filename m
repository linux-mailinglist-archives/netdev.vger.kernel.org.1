Return-Path: <netdev+bounces-137275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B49A5493
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5B31C2103B
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D93192B99;
	Sun, 20 Oct 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0v1s0QmU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4A1925B8;
	Sun, 20 Oct 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435816; cv=none; b=lUhbYaw3WsWRYh/g7gTveCkbQ/y8Y5l8Lkc9KMjD4CenH3STegE0aOjDIK1PE4hrr4LAqyiL8XParhnz+qHelvl9Kan5Lukh63jqtoE52ftnuZGvZ/aDZWriUjH4ko+1cfbDbROlTdkBHf7eNGqTHgR4Hh9bqXx9nS6xnTkRH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435816; c=relaxed/simple;
	bh=AVfTH01SvlduefmUhsSdFUoQPyygoRL2NA627woyiEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaD6h4hNVfyBD5srgbLa91tRD6XhclmXoicdauqSVlscXPwfeEeWxrgSHJPqMjdNg+zXG8cJCg6aeLRN5+BQ3DsUhemCTfGIEWg7p2MN+y/Sa9mMeLkGbC5XWLy6jlUMkPxdH97cunjxW6gxKpT+2dR9YBfsPW6gp6/E/Cs3qY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0v1s0QmU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=8zSrv9jMkJqjVhr6qHqhDSITJsgarczXcoOi1N3rASw=; b=0v
	1s0QmUx9NfH7UbqmHsqHUILQYfngh/pdwOJtpC2seEo0UECRM+MMTJKK4uAYWgong3kB/iIr23Vmo
	ZB+geJc8FywMWksxBRHgGO6ZYOq0IleJVmNIBHxQiQqKrAheyOwN0t17Rl30PNpCmEAhnCBjzVCD/
	6T5qdsV5pLThyv8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2XFU-00AeVi-UT; Sun, 20 Oct 2024 16:49:40 +0200
Date: Sun, 20 Oct 2024 16:49:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fan =?utf-8?B?SGFpbG9uZy/ojIPmtbfpvpk=?= <hailong.fan@siengine.com>
Cc: Simon Horman <horms@kernel.org>,
	"2694439648@qq.com" <2694439648@qq.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?= [PATCH] net:
 stmmac: enable MAC after MTL configuring
Message-ID: <ecc1aaf4-8676-453f-93bc-fd93d121b694@lunn.ch>
References: <tencent_6BF819F333D995B4D3932826194B9B671207@qq.com>
 <20241017101857.GE1697@kernel.org>
 <bd7a1be5cec348dab22f7d0c2552967d@siengine.com>
 <9a11c47e-0cd6-4741-a25b-68538763110a@lunn.ch>
 <daf687938ae1413bbc556134b47d0629@siengine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daf687938ae1413bbc556134b47d0629@siengine.com>

On Sun, Oct 20, 2024 at 01:45:41AM +0000, Fan Hailong/范海龙 wrote:
> Hi 
> 
> Please find new patch in attachments, thanks.

Please read

https://docs.kernel.org/process/submitting-patches.html

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Attachments are not accepted.

	Andrew

