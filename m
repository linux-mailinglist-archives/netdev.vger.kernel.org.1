Return-Path: <netdev+bounces-209541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB87B0FCA1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 00:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E864C586ACE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F0270559;
	Wed, 23 Jul 2025 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZIvS/82"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880F215F4B;
	Wed, 23 Jul 2025 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309313; cv=none; b=BIbAz6vQbVzGi7ch1yrwJFvGM/2OND4UJeVvErXF86bNThksrm3Y7jKMW2UrDLMS/qUdRaIpa3HZrfEmrVYK2gJanj0SUfFbq2fUHdWTSDTG/bCyABIAxQ272oWE1jMq5T73FzM8JWqSEJG2p9ULLaugmkkfjSlBtzKI6p5N6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309313; c=relaxed/simple;
	bh=8PVTetr6krJCl5NHxCBpcVdg4mQmrN6W/cxBYHIjJ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2kLen3IUl5FBnAbmzKhZnu7UR0MbicrmgiTP9mrSj2MQsj1OBiTlcBETBWYlZyP5asSYFn58GsekALkVDek89u3CpGRZSZxgluphzenbAZwvdCztmnIVkLbB2sdViqwWYI5ME8PXflBH2rUdflWj0JS3DechZysJWvyLWIjt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZIvS/82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC9C4CEE7;
	Wed, 23 Jul 2025 22:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753309312;
	bh=8PVTetr6krJCl5NHxCBpcVdg4mQmrN6W/cxBYHIjJ4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZIvS/82VzPmU6FCNpG9SyyBLyy6kdbb+itSmVciLY6C2X6rVe/E3E0wJ8JMx06R4
	 ggQBvsmkb0+ST8NcyCST6kG73J5MdLUg230qEwQRWdmtKNx7DlgUGa89HpDCN4Jblc
	 rqmvYyR2LmgKHS2WMqeaCEo4xH5Faa+koafuAUAT5JUneqczexdvmbgSRkkuyGMGre
	 6susTZcUBSBTjqhQOPaDM4lUn3W4vCQbVgsTXTe/Ur9b3+XMBxraHKHVPYF+zJIosh
	 zSWxM1NlZTYnMgKNkJ/jrlcSgBDxoFuYQKOp2PrfSUcqFr1gNg3mx96gQD+88KDarq
	 reo57r7VpTjaw==
Date: Wed, 23 Jul 2025 15:21:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, oneukum@suse.com,
 yicong@kylinos.cn
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of
 MII
Message-ID: <20250723152151.70a8034b@kernel.org>
In-Reply-To: <d8852211-e3ba-4c9e-a9ab-798e1b8d802e@lunn.ch>
References: <1c65c240-514d-461f-b81e-6a799f6ea56f@lunn.ch>
	<20250723012926.1421513-1-yicongsrfy@163.com>
	<d8852211-e3ba-4c9e-a9ab-798e1b8d802e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 15:05:27 +0200 Andrew Lunn wrote:
> > > Thanks for checking this.
> > >
> > > Just one more question. This is kind of flipping the question on its
> > > head. Does the standard say devices are actually allowed to support
> > > 1/2 duplex? Does it say they are not allowed to support 1/2 duplex?
> > >
> > > If duplex is not reported, maybe it is because 1/2 duplex is simply
> > > not allowed, so there is no need to report it.
> > >  
> > 
> > No, the standard does not mention anything about duplex at all.  
> 
> O.K. So please set duplex to unknown.

.. and update the commit message and the code comment to reflect 
the outcome of the discussion better.
-- 
pw-bot: cr

