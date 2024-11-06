Return-Path: <netdev+bounces-142175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B59BDB2C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CD81F23582
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823D6188A18;
	Wed,  6 Nov 2024 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoRkCT25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07710E5
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856541; cv=none; b=fjQ0lLjYMiVZs7PJy+ikWyIXtYQe3dLOYrqPVuYoZO6NTYjuz3wMvxwd5VWFY6kqbG60IApzgggXPQoHNjvhZBiXFyN/h7CSEjSCFRZcBJxwBVVMTrQGNoL18ZtlMUyFZFnjiQpy7f0fuphCyHBXWZeE+AaVatETsaz+kG3t8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856541; c=relaxed/simple;
	bh=cK62hpzSu8c1dbEbyu+aYB/rI7CF0Cb3ZDPREFu98tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0uePaZbe3BCArZE7FadwWEsnOwDqxVTh59zP4EQg6qLGcNdR5oUTnIIpqMWOS4vFKFOLOQd7Dq1qGFbVGSyE4dMbDgXc8jbNhujfsrvRswl9+iGUts272lKe+LCl0uC8I5XRK1rv5y7WjlvKu96b+CQMaBCAlOQfL7dszvoXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoRkCT25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAA2C4CECF;
	Wed,  6 Nov 2024 01:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730856540;
	bh=cK62hpzSu8c1dbEbyu+aYB/rI7CF0Cb3ZDPREFu98tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hoRkCT25sU4BILw21M5VXMkXtff5kontRnn5Km8mVPRgB2ATBuOUbuc5Us01Q0cd8
	 4WYSNpod8q4JIxuDcGAnXr8DuVh1DN+Rm4qUUG19oSoBYWKk+BWjG5QULIIWxBToEy
	 ke4ujaPN+xK/M+hAnxIczz35fSp6Pj63aJQ1hJUCakWmqkwDsvHCWz1bLIEQzXONyr
	 1w8emJth2SzZcaNZJmYM0L0WmkjtAI01Z8OPpJAeKOP3vZ+o70Jowarv1aaXRxbwSF
	 IX7Gwd7FhCftPUGJpcAg0CChOeRuKn6K1ZVN44hNDCXRV4eoUQUqInEjBIt/bq/Ocg
	 Mo00FXv13whrw==
Date: Tue, 5 Nov 2024 17:28:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>
Subject: Re: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Message-ID: <20241105172858.273df3fd@kernel.org>
In-Reply-To: <4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
References: <20241103113140.275-1-darinzon@amazon.com>
	<20241103113140.275-4-darinzon@amazon.com>
	<20241104181722.4ee86665@kernel.org>
	<4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 10:52:12 +0000 Arinzon, David wrote:
> Just wanted to clarify that this feature and the associated
> documentation are specifically intended for reading a HW timestamp,
> not for TX/RX packet timestamping.

Oh, so you're saying you can only read the clock from the device?
The word timestamp means time associated with an event.

In the doc you talk about:

> +PHC support and capabilities can be verified using ethtool:
> +
> +.. code-block:: shell
> +
> +  ethtool -T <interface>

which is for packet timestamping

also:

> ENA Linux driver supports PTP hardware clock providing timestamp
> reference to achieve nanosecond accuracy.

You probably want to double check the definitions of accuracy and
resolution.

We recently merged an Amazon PTP clock driver from David Woodhouse, 
see commit 20503272422693. If you're not timestamping packets why
not use that driver?

