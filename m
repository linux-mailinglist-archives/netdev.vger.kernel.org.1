Return-Path: <netdev+bounces-158152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB03A109AB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE2C169A0F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A399785626;
	Tue, 14 Jan 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5WnpL2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF218615A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865940; cv=none; b=IM/U0Oul7YtcAbDpXjas8mU/OX7xmWveNuLvPKfWp5MMV7b80Z8T49OMx3a/6CC9v/xlVgSHAhQOSPISmlZ/n2iPOl3LRG4Dr7GHaK7lqavxEG0o4uiNogqlp2rE3Mq1ugXE1Gox2plwZMXjSvNaFUr29D7YYw6QfBy0UUKcDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865940; c=relaxed/simple;
	bh=2uIoKQURXiUt+OZoxi828kd+F5HpY1IlIEjQ7K1mYH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwrxG61umH4m1eAARqjevwnbOIWGkvr40hO6SIO3Vmua1oHi7jznA6Z7L/7CitBohV2tv1d4f7+D69LNeYIRD/nNWF32QZq8Lt5frr9EQbAOkAkZneHwWfIvGQ+Xogde2O6A0cp7lPKrWamYfuXfz0Odx26CncmcSIZgZakD02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5WnpL2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB42C4CEDD;
	Tue, 14 Jan 2025 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736865940;
	bh=2uIoKQURXiUt+OZoxi828kd+F5HpY1IlIEjQ7K1mYH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o5WnpL2VjMJxFitA+iFm00wF7MCUfQCnZEcfqb0BYAeSeFKNUdXaNpD4McbfYjRMU
	 +3CYPn85da4bIJdvtSRPrm5Zp+C6wG+EYQncovKHpoF2EbXasDmoL4mMQLmTGHNir2
	 +AVQg5qbqvkpcgYO4dMUlaLTHpz07aB/Sg+EriEK4YNSLH6O8SV9EJ9+xA6FDq9HYZ
	 JLk7xA51v4qHi5sLzzRnYzF6FWYjVTv5EqaViOF5Jd/Z1nJtjx7iqlr6SXj6+hv09K
	 lHlWr090pCLg/bwQs4EX0OnTgelK/xqJfjyVkql1UxLZXNxjcCsMFf8sqJVVs1Ia91
	 GKa4hgC7lekgA==
Date: Tue, 14 Jan 2025 06:45:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Subject: Re: [PATCH net-next 02/11] net: add helpers for lookup and walking
 netdevs under netdev_lock()
Message-ID: <20250114064538.7f47e587@kernel.org>
In-Reply-To: <CANn89iKo4k7PaUof+qjiUGT+-25WNed-1+UkWadnASBAMcZ2Bw@mail.gmail.com>
References: <20250114035118.110297-1-kuba@kernel.org>
	<20250114035118.110297-3-kuba@kernel.org>
	<CANn89iKo4k7PaUof+qjiUGT+-25WNed-1+UkWadnASBAMcZ2Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 14:03:35 +0100 Eric Dumazet wrote:
> > +struct net_device *__netdev_put_lock(struct net_device *dev)
> > +{
> > +       netdev_lock(dev);
> > +       if (dev->reg_state > NETREG_REGISTERED) {  
> 
> I presume the netdev lock will be held at some point in
> netdev_run_todo and/or unregister_netdevice_many_notify
> so no need for a READ_ONCE() here.

Yes, the only unprotected write is in free_netdev(), but we're holding
a reference here so if we get to free there's a bug somewhere else.
I'll reorder patches 2 and 3.

