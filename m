Return-Path: <netdev+bounces-97909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B868CDDDB
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 02:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574F91F23015
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069A19B;
	Fri, 24 May 2024 00:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7F18E
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716509098; cv=none; b=ksooz3U5XVNpSfi/tH1ozXlZPCt3AZGzLc8w0OU7bSjXC4MD89vdJjzKU69uG3KNrlct2xCcEXI97OOQM+n8co4OlHB9WN2W+yvcPLCZVwOqbv3gSxuzVDC6XccNMN+BdfjqHf+RSF+z36Qncm1xlvBwV9m6yccLFKu9VFsZcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716509098; c=relaxed/simple;
	bh=bbB8+5ELLNo69kVmjK60ILBvDMKMxXKh0Jpat5aK0Ss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXgN+DP7Y9CUmek1iX9zXei/5ESxI2CUP02W3/YbHOfNqhiXz+2dWsOhkYT3KgDCty+71uXNjGnIhVjJarEICVvB2E2vbO5+9LWZMp+Qaq1lfHEC+by+btS2pqSSwZIuW4vaWJZoQu+MVZco2U9MRn7+r2Aaxs9IkRwheMomYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 44NNr8GY003634;
	Thu, 23 May 2024 18:53:09 -0500
Message-ID: <9d7115cd7737014e05406d9c965a116943a341d9.camel@kernel.crashing.org>
Subject: Re: [PATCH net] eth: sungem: remove .ndo_poll_controller to avoid
 deadlocks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, erhard_f@mailbox.org, robh@kernel.org,
        elder@kernel.org, wei.fang@nxp.com, bhupesh.sharma@linaro.org
Date: Fri, 24 May 2024 09:53:08 +1000
In-Reply-To: <171539102901.31003.5030547780750327077.git-patchwork-notify@kernel.org>
References: <20240508134504.3560956-1-kuba@kernel.org>
	 <171539102901.31003.5030547780750327077.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-05-11 at 01:30 +0000, patchwork-bot+netdevbpf@kernel.org
wrote:
> Hello:
>=20
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>=20
> On Wed,=C2=A0 8 May 2024 06:45:04 -0700 you wrote:
> > Erhard reports netpoll warnings from sungem:
> >=20
> > =C2=A0 netpoll_send_skb_on_dev(): eth0 enabled interrupts in poll
> > (gem_start_xmit+0x0/0x398)
> > =C2=A0 WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370
> > netpoll_send_skb+0x1fc/0x20c
> >=20
> > gem_poll_controller() disables interrupts, which may sleep.
> > We can't sleep in netpoll, it has interrupts disabled completely.
> > Strangely, gem_poll_controller() doesn't even poll the completions,
> > and instead acts as if an interrupt has fired so it just schedules
> > NAPI and exits. None of this has been necessary for years, since
> > netpoll invokes NAPI directly.

Well, I wrote that in 2011 so ... :-) But yeah, sounds good.

Cheers,
Ben.

