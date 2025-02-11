Return-Path: <netdev+bounces-165000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47DA2FFB0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187EF188C2F4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6741C3BF9;
	Tue, 11 Feb 2025 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH88J0Nb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587413BACC
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234640; cv=none; b=Z8f/NWMg+HUpDHnKJzSFS5b1w9ZRw0OjJ/XpPMMgHI6dt7SfuU2t/Rouer4zkHDbGq0rnuJeilxRzqqMGqAjK4l7uJTjTqRRn1F5cCZ+VTssPsSbvTKzLwIUOBfCTuZo7EMrKArEqGHevVzJ2QdYDiHMK7NmfTxL+nY/FJCgj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234640; c=relaxed/simple;
	bh=YMmaKEak/03dwbRH8YweIpN1T4YJ+s4Tz7bZtxPZan8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGTvSIgnxhmvSWdhUTBDkrPsiaDNGycdL9KmGSgx453NakZiRL/dR+8w4BR+pr3zffh7AEF4jrLm7CbNlNOFD/jB0rjB5wMveW5r3/SzhM4bUq34FCuBq3EynchuOaS02X9SrgZpUoXGgU5qBW3VAxVRPSMht0WnARA581UzoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH88J0Nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA265C4CED1;
	Tue, 11 Feb 2025 00:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234639;
	bh=YMmaKEak/03dwbRH8YweIpN1T4YJ+s4Tz7bZtxPZan8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VH88J0Nb8hFvwrmN4T9tM9X8/Cxtu509TKSkI7uugbTYbsd9mGvd9VM280ZzBYyAh
	 syrHScdbheKi45nfLEelhvEOY8NUOGxMnQoZ3CkeZnY0F53P1/XLrxSJDb6dHLS0y9
	 iLH63WOyUFeOR4ZqMP/sI68vOOPbrCOPxA7z4A2QYcpDI2smgCGXu+H80FIT4oJNS7
	 gQtSDU1w3adsUYe7jgxh5e9A5IxRxln5nk5LTiaY923ve3HJQZj0bUN8KkzxWF+76i
	 aHP2aoBiwqma1Uc0NeKa1Kc9RYvHM98W1vxp0LnPAxlPyyWoqN41hkBeT+Id6ILIQy
	 98sJ+WF0Tlmhw==
Date: Mon, 10 Feb 2025 16:43:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.co.uk>,
 "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
 <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
 <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud,
 Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal
 Pressman <gal@nvidia.com>
Subject: Re: [PATCH v6 net-next 3/4] net: ena: Add PHC documentation
Message-ID: <20250210164358.11091722@kernel.org>
In-Reply-To: <01fd0c4d50c7493986d80e22b0506fdf@amazon.com>
References: <20250206141538.549-1-darinzon@amazon.com>
	<20250206141538.549-4-darinzon@amazon.com>
	<20250207165516.2f237586@kernel.org>
	<01fd0c4d50c7493986d80e22b0506fdf@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 15:28:19 +0000 Arinzon, David wrote:
> You are right in the regard that it is not a network specific functionality.
> Having said that, PHC is a network card capability, making it a network-related component rather than purely a timekeeping feature.
> Moreover we failed to find an existing tool which would allow users to get valuable feedback of the system's overall health.
> 
> Researching its existing support in the kernel we noted that:
> - PHC is embedded in network NIC and is supported by multiple NIC vendors in the kernel
> - PHC information is visible through ethtool -T
> - The Linux networking stack uses PHC for timekeeping as well as for packet timestamping (via SO_TIMESTAMPING).
>   Packet timestamping statistics are available through ethtool get_ts_stats hook
> 
> We have found `ethtool -S` as a suitable location for exposing these statistics, which are unique to the ENA NIC.
> 
> We'd appreciate your thoughts on the matter, is there an alternative tool you can recommend?

We try to steer folks towards read-only debugfs files for stuff
that's not strictly networking related. You also add a custom
sysfs file in patch 4, I reckon adding stats there may also be
a natural place for the user? 

Patch 4 FWIW is lacking slightly in the justification, would 
be good to clarify why it's disabled by default. Single sentence
of "why" would be great.

