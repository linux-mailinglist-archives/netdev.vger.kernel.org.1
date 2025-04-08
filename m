Return-Path: <netdev+bounces-180338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522EA80FF7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50101BA7DC6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C01185935;
	Tue,  8 Apr 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI6kxX8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7239AD6
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125882; cv=none; b=Z+ztaO4gts73kueC6HBs7OOZ8rUJfDhgVnjQ8iBb64S+2P/2+MbcgfWaKkDO2HGU/leFplFLc69NlguQnuq5NTlhe3WlSAJ8VsHPkGJZDYp6lXCHuelA7fx0RfaA2oy3veJuwpN8a4rHX5ousyxnQ3ihv/5y4nH93/q3X/f79jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125882; c=relaxed/simple;
	bh=AJ1BkR5/ob2JxGtACbvYBWLHCcWlTlTqvCcwgVCHA9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3ofoIMuOObekspSK++rjUCF2XZSDpxm2X11/CWsaAPE4CUuZY00ct0wbk3YgsngvLwjE96mA//yJMY4nQ8yFX1tn5YBmImTtahqGCgkN8pckobj1+OpAtA4TvnwvQhvnUOVLnLrDuJMxyA4qJf93zowUaRGqabrqTkMrXgjlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI6kxX8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196DDC4CEE5;
	Tue,  8 Apr 2025 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125881;
	bh=AJ1BkR5/ob2JxGtACbvYBWLHCcWlTlTqvCcwgVCHA9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HI6kxX8FHuJskcu7M/Fazs5CEs0s5JuQ24yKlN3G+pYlNiAaBzaBebUWAHkl6ENe2
	 OaGX80GvXReN+6kHQW6Ge9G2q3d5G1HHFWf7Da5hXhW3rNm1WMB7GgGEOO9LtyQPaw
	 9LCVGHsH4p3Wdg89f3HsIKKG34G1gdOyvTGpU9Ur7YbJg/EsNuZI3Dt1AkiREzPrEq
	 HfRbVASAPlkjXCarz6T1KOfpb/1cRA1dOE/dbjMEqmzHDjFRcG6G/bQoeq4LSlQ8h9
	 7cqhdt4fevEWLgupLRDf9v800xmqw+l81SZtlP/gzJiZxMdjoIkN14xzX/PPCgiaN5
	 twgnOovGNVomQ==
Date: Tue, 8 Apr 2025 08:24:39 -0700
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
Message-ID: <20250408082439.4bf78329@kernel.org>
In-Reply-To: <Z_U2-oTlrP6TPuOy@hoboy.vegasvil.org>
References: <20250304190504.3743-1-darinzon@amazon.com>
	<20250304190504.3743-6-darinzon@amazon.com>
	<aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
	<55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
	<dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
	<20250402092344.5a12a26a@kernel.org>
	<38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
	<f37057d315c34b35b9acd93b5b2dcb41@amazon.com>
	<0294be1a-5530-435a-9717-983f61b94fcf@lunn.ch>
	<20250407092749.03937ada@kernel.org>
	<Z_U2-oTlrP6TPuOy@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 07:47:22 -0700 Richard Cochran wrote:
> But overall I don't those interfaces are great for reporting
> statistics.  netlink seems better.

Just to be clear, are you asking them to reimplement PTP config
in netlink just to report 4 counters?

