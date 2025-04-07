Return-Path: <netdev+bounces-179745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB0A7E6DD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C669C422536
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0429720E333;
	Mon,  7 Apr 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEpQSv55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1D20E323
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043271; cv=none; b=kRh2BLsg33jxdeazuLpFMv63GCcGML8nhf/yKOayO4/7edb24AnWg4LNJPbrXk5ZbW8hNzpHHuxdTNccttaFnlU3zafRB/FIZvkUmtKHQiBSZ0tSu5If6A6y7Ysy4MTHZHDU6PhLHtclX6i5PsRYHMH+GJmMHIgaFtZuhy3/0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043271; c=relaxed/simple;
	bh=laEhGKu6HiI4MbALIplrQ0ybK68/Tgxg31sxjdkQQs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECwIdBgxGeVOIYAlb+3EB0H4P71jrrJ3Tb8+6Pxfw6qpkBBI+G2Zv9odSIbjqdQJ58JT0CWqHRgb9W4G0TsCDlVP/WnxRDPrswtkZ+YpMFCfqcKkNUkx5cts2jf6hmHU9nxH1tmdQzIqWfOXpyfF2HZ6EdtHlIOq6R6Ea/i5XFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEpQSv55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFF4C4CEFF;
	Mon,  7 Apr 2025 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744043271;
	bh=laEhGKu6HiI4MbALIplrQ0ybK68/Tgxg31sxjdkQQs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kEpQSv55RSwq0HQ+86mOtQhQC7oGyCbJ/CNn5qr56OHX7Q8kSsZjUBs1HRWNGdlFs
	 5NotJ9Us4hbCDDWx+3QQGPQ/xNZxZ1Vcnmbb9qygSpEZs6o3HZzoKTagLawEx3Em3i
	 pT9I+txMZP7ekzJLwb/i5C3mlIBFbSwpyGUHS/KTNgz9TcmAnXB0xjqOdkd/hy8/Ld
	 GBPvJUNnjMi5MQpZCC0LOwG7S5nQ9IHjkqv46IsKcc+jQJ1/Y1XfdEfW8c221tQi2D
	 ummKMezTLRX2UiplmnblO5KRxkU7w/3i2x0ifmi1N9DYxO30DOILnYN9inFGwQEz4k
	 bcWZt9ZWttVOg==
Date: Mon, 7 Apr 2025 09:27:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Arinzon, David" <darinzon@amazon.com>, David Woodhouse
 <dwmw2@infradead.org>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
 <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Allen, Neil"
 <shayagr@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <20250407092749.03937ada@kernel.org>
In-Reply-To: <0294be1a-5530-435a-9717-983f61b94fcf@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
	<20250304190504.3743-6-darinzon@amazon.com>
	<aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
	<55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
	<dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
	<20250402092344.5a12a26a@kernel.org>
	<38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
	<f37057d315c34b35b9acd93b5b2dcb41@amazon.com>
	<0294be1a-5530-435a-9717-983f61b94fcf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 16:02:33 +0200 Andrew Lunn wrote:
> > Thanks for suggesting the devlink params option for enable/disable, we will
> > explore the option and provide a revised patchset.
> > 
> > Given the pushback on custom sysfs utilization, what can be the alternative for exposing 
> > the PHC statistics? If `ethtool -S` is not an option, is there another framework that
> > allows outputting statistics?
> > We've explored devlink health reporter dump, would that be acceptable?  
> 
> We seem to be going backwards and forwards between this is connected
> to a netdev and it is not connected to a netdev. You have to destroy
> and recreate the netdev in order to make us if it, which might just be
> FUBAR design, but that is what you have. So maybe ethtool -S is an
> option?

The device has to be reinitialized, I don't think full re-initialization
makes the feature connected to other functionality.

> Or take a step back. Are your statistics specific to your hardware, or
> generic about any PTP clock? Could you expand the PTP infrastructure
> to return generic statistics? The problem being, PTP is currently
> IOCTL based, so not very expandable, unlike netlink used for ethtool.

Historic parts are IOCTL-based, but extended functionality for PTP core
and drivers is currently implemented using sysfs.

