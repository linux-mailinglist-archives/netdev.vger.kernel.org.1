Return-Path: <netdev+bounces-116272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9C949BB5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F441F21F8F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AC16F824;
	Tue,  6 Aug 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IGIrwrvg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E091509A5;
	Tue,  6 Aug 2024 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985224; cv=none; b=BxfND/5+Bzv1Y/bvruRVy4FxL10PtsLB+RVAM3xPiJQSjynoDFgyXQaqV5RQLsq4RzqFYhaUQ0IRYZGVeKjzO1SpmJfBNzH7dwWYwjbX+Y8mOu7jrzUQI/L3tzHMh0W2cXOvgzLO4sgpQYS0gO4o3it1qFeS5s0fc+uC8T7LMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985224; c=relaxed/simple;
	bh=Frnzqhxbv9gcN+sXkiNywtxjtOKpQe/OJLFiKrjdhUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu0a2WoeBK22TRkmPvNgB4i/LJpPvEiRIeKKI1oLOQkNnAol140BX6ILanqo11SoJL//zq4I1yvDcYNt+92CwG4dMO8OOaWGFNxGKGpOCu4DNtM+nW2TKIFAwrERmdo3ti5h0PY7PDAadF6whCGiJJV+Wz9tbnPJWv1ZbUGN+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IGIrwrvg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ILlC2MFMjbmvYocuV/JrbTAwJHaG8KNMV/Nvs/dlXyE=; b=IG
	IrwrvgidLe38K0EhRmsHj0O0LY5EcxYLjOW2FX/YVaqMmy/DMOAs14sVr+znt81A1qAzH0eHqZ+6P
	qKP5ZTMOc2/34Estg3cwbXprSB2psWx2QEeWoR8VuBUg9CqE24Sj00JciD2rqPW6k0Pn0IWsLw/x2
	/8xGcpYsL5BwZ5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbTA1-0049ai-Ep; Wed, 07 Aug 2024 01:00:09 +0200
Date: Wed, 7 Aug 2024 01:00:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] net: fec: Stop PPS on driver remove
Message-ID: <1a3ef42d-d7b3-4842-b291-f5de8e8b62a1@lunn.ch>
References: <20240805145735.2385752-1-csokas.bence@prolan.hu>
 <CAOMZO5BzcZR8PwKKwBssQq_wAGzVgf1ffwe_nhpQJjviTdxy-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BzcZR8PwKKwBssQq_wAGzVgf1ffwe_nhpQJjviTdxy-w@mail.gmail.com>

On Mon, Aug 05, 2024 at 12:04:35PM -0300, Fabio Estevam wrote:
> On Mon, Aug 5, 2024 at 11:59 AM Csókás, Bence <csokas.bence@prolan.hu> wrote:
> >
> > PPS was not stopped in `fec_ptp_stop()`, called when
> > the adapter was removed. Consequentially, you couldn't
> > safely reload the driver with the PPS signal on.
> >
> > Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> 
> It seems this one deserves a Fixes tag.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

And should be based on the correct tree, and indicate that tree in the
Subject: line:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

    Andrew

---
pw-bot: cr


