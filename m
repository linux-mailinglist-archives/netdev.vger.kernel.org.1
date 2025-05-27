Return-Path: <netdev+bounces-193679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C17AC5121
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9990B1BA15C8
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787A2798E5;
	Tue, 27 May 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSHoFZqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257C279795
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357062; cv=none; b=N71Zf2cYwcBw+Q/zXy7IAX+FDQc5KcFnwYnV6IJ3XBAEFSYF2Pfbu+eC3XZNrFgLTzwiAc7EevS1+5ynfL1FKc66vpgsXq50LB630+du5z35yeiaEsZLQwecwhyCHv/HdOZaIaZdVYeDn8M6zUEkUvitHhoPhdhGS3MFagwd/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357062; c=relaxed/simple;
	bh=RN0PjJnKPOqD8+uhDQW64JmPn2YyPexaHPC5FUhbnd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlxZTT7Xn/U6hpT7+BKEYaujhK64+kdJL5u0RLog6+D/PRInIdAcFnHOAzxS4XxIcOWTKkWyjD26Rhd4OnRPmosNHwevvCpCUiKO1xNh99pd1CVT8mtdwNMabC/KlMxtMe6Yzj/tbtRvBlfBGHnz7A35pxlny36fO5ezJxxLaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSHoFZqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AE1C4CEE9;
	Tue, 27 May 2025 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748357061;
	bh=RN0PjJnKPOqD8+uhDQW64JmPn2YyPexaHPC5FUhbnd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSHoFZqLLaorccC12Td6uKe+9AIgbRsx3RRF5o/o8qheH/pBQoLSxw4cxGny3gfB2
	 /UX5EwsZ87ZM/fafmCxoobiZ7lEb0Pfj6Kxom7usb353hbe7vJvyd+ODJE81NK/BCz
	 D7AFpT88osK3L2DNlEYzbeZhC2hPIPfa7EIZB0oQa+u2hVXMvIuBm98b7Sph66pcav
	 VL/Bby7Jb2gYDV+DGG4zJBpf82VobTeF2EVo31YjDEX7ybemdb7qYfjG/BLF/MQ96J
	 qkZEflbgGsWq7+WHDjDwgaINwQVxN7b64PKIef0ryYorz/rMB0Iv9SRxrEb9kW6MBv
	 p/Yo4W1fUke8Q==
Date: Tue, 27 May 2025 07:44:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
 "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
 <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
 <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
 <leon@kernel.org>
Subject: Re: [PATCH v11 net-next 0/8] PHC support in ENA driver
Message-ID: <20250527074419.40163789@kernel.org>
In-Reply-To: <jdkiblbwiut4x7t7gtpiatdbiueehvhuqdhn5caoj2ijiil2yr@6xof3oyhruxa>
References: <20250526060919.214-1-darinzon@amazon.com>
	<jdkiblbwiut4x7t7gtpiatdbiueehvhuqdhn5caoj2ijiil2yr@6xof3oyhruxa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 11:53:14 +0200 Jiri Pirko wrote:
> Could you please add very simple devlink_port instance of flavour
> PHYSICAL and link it with netdev? Having devlink instance without the
> port related to the netdev looks a bit odd.

'Physical' seems inappropriate for a "host side of an IPU".
PCI PF if anything, but also I disagree that we need every devlink
instance to have a port. PTP clocks use devlink and are not networking
devices at all.

