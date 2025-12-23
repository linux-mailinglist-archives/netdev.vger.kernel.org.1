Return-Path: <netdev+bounces-245887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6573CCD9FC5
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5728C301A028
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086731A05B;
	Tue, 23 Dec 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="gIAtkT4E"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE22DE6F9;
	Tue, 23 Dec 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507798; cv=none; b=Tl9AkRaL6AEGJd0LRNy40SqSbjf9L/w3WnwgPbC5KqZiv2omyE3q7U7+SKJFFlDsvFvpxhmd8FDXqGCJVxzO8rC2w1dmUZ6qGpDYdA/glzSF4343PvUm2rms9+H0tgV4B9ULY+uC4pp200Er/4XNC5ccbk4BDAgzpBX+Ooou37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507798; c=relaxed/simple;
	bh=bAf2zhDG92BfEOZaentRA+gGdi3r4MU+evnsLIJLRC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeMxYYeJMl+SRmlNOk+UOaOqru0ub376E9tGhzEbtTc85KDS17bfAzqJTWZG0lEzy878VAXtZhpTUXz7t60vWqbrA68rH3RmuIdcctTmoirlm9KJlccVylHXI7yHw21pebYd+mh++22sbbPUR7BOj/fYK6xL+rnDHdaQw303ZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=gIAtkT4E; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 1B0161FE02;
	Tue, 23 Dec 2025 17:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1766507793;
	bh=weSDYEEDsPi7QMYHrZ0GmXY2iAT3tRHUV6SOV3zayrs=; h=From:To:Subject;
	b=gIAtkT4ERN4nQ7V8kT4f8IDSXmyQhUTqD9p9f6BVMnTS+lc0stSuQFEzxv209dDi3
	 i50mz/zwbSe0hqScUREHYxRzxuxIRcqcZ56Jq3SmccEyQPlAuoqeR5FT0P+XUooglk
	 TXSLcyRhjd+Q1REmwJf3hv/7e/CEQmGXB3OESZOUGS4GlWIPHjOO3fC5JCkqEFC2ku
	 tvfCDTvTK7WEW4B9p3ShOA7K1RKHPxS80FJWH0VmYjbvAMoRwEdx3371T2FbvOzvZ1
	 /wAPktOfBC5AF43CTwaMGhiKmkpuUhKSw3/GtrxhzY+GZ0c2vqs87Mp9GuYdq/2WL8
	 77G6ugZ6oQZ5A==
Date: Tue, 23 Dec 2025 17:36:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: fec: Add stop mode support on i.MX8DX/i.MX8QP
Message-ID: <20251223163629.GA138465@francesco-nb>
References: <20251223163328.139734-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223163328.139734-1-francesco@dolcini.it>

On Tue, Dec 23, 2025 at 05:33:27PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add additional machines that requires communication to the SC firmware
> to set the GPR bit required for stop mode support.
> 
> NXP i.MX8DX (fsl,imx8dx) is a low end version of i.MX8QXP (fsl,imx8qxp),
> while NXP i.MX8QP (fsl,imx8qp) is a low end version of i.MX8QM
> (fsl,imx8qp).
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Whoops. I missed the destination branch, this is for net-next, sorry.

Francesco


