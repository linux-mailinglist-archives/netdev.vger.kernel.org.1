Return-Path: <netdev+bounces-181342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06BA8492C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331AC188DE50
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A29C1EB1AB;
	Thu, 10 Apr 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUbwObqh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54105189F5C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300918; cv=none; b=jm19baCahVtYE8KqrCt7zEk9p+2sotFXYXWtg0Y7H7zhf5D4dxVoZgY23Ac0hqNQn6XIEUy8NKiaFjMR3DZUnTndHeQm8GrZQfpZyVYB1PjieQkzRR4AuPenzQH2Y07vmM+INx76ExVFNUCkl9MbcIy9LbwAhtXLbs4G3Qcesuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300918; c=relaxed/simple;
	bh=XTam8G/QSTj9gFXh35TR04Xp0UHGI/oEVf/w18QxKEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV1ckXQrg6IZXSAL9bF6p1+KRTWrLu9xejfZzLPZPgCmZkoL0E0smOS/ydU/pBnFa2Ly/Heg7GjMuFER6YHA4OIewIJ7l7zeu/nvrZsvMNEg3L07+RX88fMwcmB0MQkFWtdWt15P95ddrvlJtCsO7BlhD6K3jy64YEgJgJEO+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUbwObqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1FFC4CEDD;
	Thu, 10 Apr 2025 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300917;
	bh=XTam8G/QSTj9gFXh35TR04Xp0UHGI/oEVf/w18QxKEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TUbwObqhxr3Vw7GH2zVEM9+19Et2PUz+kPIimrWK7PdjwBqd7at/efrw3BL/pSJ/F
	 OmBsfunPCioGmoljNNYhr+G0aPiWtpVH39EKhhaMbl3jSRqumv8Lh4f7fdHdGDQyTy
	 n7MF5BOBA6x6l1n4E8dy3BNii1/jhBVbo22c6ExiuudcP+qEvgYyjycR2aW9nsoLDU
	 u+8qpHuTvGrh66VBJ+9WwhbKmAkOaXDgGzkwDw8O4fZw4e0O0A5Jy/DWaJ6VYyh0Cv
	 ZM0LMe+z8GNu88NUIes/7VkekdC3WFyz4hFC75qsLNCxgvBa42shlsXcD8xgu57UPZ
	 o+mJVBvq+IMNQ==
Date: Thu, 10 Apr 2025 09:01:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "Arinzon, David" <darinzon@amazon.com>,
 David Woodhouse <dwmw2@infradead.org>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky,
 Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, "Allen, Neil" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <20250410090155.0df1df1c@kernel.org>
In-Reply-To: <Z_dEH9tKRCT0zOpt@hoboy.vegasvil.org>
References: <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
	<55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
	<dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
	<20250402092344.5a12a26a@kernel.org>
	<38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
	<f37057d315c34b35b9acd93b5b2dcb41@amazon.com>
	<0294be1a-5530-435a-9717-983f61b94fcf@lunn.ch>
	<20250407092749.03937ada@kernel.org>
	<Z_U2-oTlrP6TPuOy@hoboy.vegasvil.org>
	<20250408082439.4bf78329@kernel.org>
	<Z_dEH9tKRCT0zOpt@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 21:07:59 -0700 Richard Cochran wrote:
> On Tue, Apr 08, 2025 at 08:24:39AM -0700, Jakub Kicinski wrote:
> > On Tue, 8 Apr 2025 07:47:22 -0700 Richard Cochran wrote:  
> > > But overall I don't those interfaces are great for reporting
> > > statistics.  netlink seems better.  
> > 
> > Just to be clear, are you asking them to reimplement PTP config
> > in netlink just to report 4 counters?  
> 
> No, maybe four counters can go into debugfs for this device?

Works for me, FWIW.

