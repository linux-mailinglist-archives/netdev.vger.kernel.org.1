Return-Path: <netdev+bounces-84188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD5895F4D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 00:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D7287968
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 22:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273A15E7F2;
	Tue,  2 Apr 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnpnaBdR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCC15E215
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095273; cv=none; b=iWdtjRbkO9Z4pCKFQIL616B7TU5AeXQ7VtZ5Oyob0Nt5k8GUO/vdIk7VX5ngTk9MD8gZzumyHKsITYQk2If0MHAFf4FH/hJsb138GJfaL57WNgN9vmP3FXlBDUulS1ZK7Xj+C93gJFLWLZQvDs/gQbdBpuNfdg3OLkru2pQplDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095273; c=relaxed/simple;
	bh=TmIg7E+wAFjkw7fZGj5M5J5B42Wxo9MJZcZCKxBYT1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjjp39vhxcjhKyvho4SDjK2VjhmsQK4CDNpq8cIucwH36OGj5/iNKpACxk8Tz3AkAeYszQjwZktUvtCBJhnDJxhsm5ayv0M+qChKoLW8v47K2w0Aftp7yr17yNkHTjhje1iILfu4RQEO4CIJ34lPBX2zg393W767XLvacf0dhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnpnaBdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B47C433C7;
	Tue,  2 Apr 2024 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712095273;
	bh=TmIg7E+wAFjkw7fZGj5M5J5B42Wxo9MJZcZCKxBYT1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PnpnaBdRaSx+LpkB7YW0NwOZ1tYJm9DbmtacKNrThmIRbXPh6G7j9N9hEQRpy3bY0
	 ht3AqapLnGkpkm3jbcmJ5uZbQO+O6JUCcHSWjBhYOn4zn8R5QaWFP9MYuz736FX1n0
	 1skQ+ONUOrxfXx6G3nv/zIz+pX1wMWbw9twAKGWHOyu1k7JEpBhTHPqMqNThJP+uoQ
	 J3IEAtQMca6XjOVfIPjlamPc3UIvRF0fO4PyYXhdNX4DlVTQYG4FJGra1PgzO/Grwh
	 LdkXO9QXvIPqqZPeQztftufjQ33/bim++F3y+7ggLk6eVnfoCM9hqH1vvjDYhOwV8Z
	 ypEccF1CsVKwA==
Date: Tue, 2 Apr 2024 15:01:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Eric Dumazet <edumazet@google.com>, Mark Brown
 <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ
 thread to fix hang
Message-ID: <20240402150111.170dc2cc@kernel.org>
In-Reply-To: <96ee283f-53cc-4317-8ac5-f08c4291a887@denx.de>
References: <20240331142353.93792-1-marex@denx.de>
	<20240331142353.93792-2-marex@denx.de>
	<20240401210642.76f0d989@kernel.org>
	<96ee283f-53cc-4317-8ac5-f08c4291a887@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 19:38:26 +0200 Marek Vasut wrote:
> >>   				ks->netdev->stats.rx_packets++;
> >>   				ks->netdev->stats.rx_bytes += rxlen;
> >> @@ -325,11 +325,15 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
> >>    */
> >>   static irqreturn_t ks8851_irq(int irq, void *_ks)
> >>   {
> >> +	bool need_bh_off = !(hardirq_count() | softirq_count());  
> > 
> > I don't think IRQ / RT developers look approvingly at uses of such
> > low level macros in drivers.  
> 
> I _think_ the need_bh_off will be always true as Ratheesh suggested, so 
> this can be dropped. I will test that before doing a V2.

Quite possibly, seems like a reasonable fix if we don't have to make it
conditional.

