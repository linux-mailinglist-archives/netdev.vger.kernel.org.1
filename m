Return-Path: <netdev+bounces-68084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E088845CE0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4D1B209EF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18766215A;
	Thu,  1 Feb 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO1nPgyj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15F626AC
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803952; cv=none; b=oXYDeGiJ1th6OhfFDrM8iR1BmMKYic/n+HqZF51DkhNAF3hZdpyrZmdxuO4UFhe2MzKHTiyB1zapfRF+RN7s4soAVBB73Ddaogx/T3/7hD9jniTZynfp4F+BpEpNH6vvlBgCnkWZ7g1uFRq9+F03C0f1J2DjXMqRwE2ic+EAdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803952; c=relaxed/simple;
	bh=DDo0yVFBGoiG+gfJwFR2HHPZwuTH5EzlFn/p4W0v6MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j28osm/giRmf6Ndr014j1NaG5F798mLYen4H2FxKuORXpGJrNWyuxDGWKMtA3+6+sm3MC3OcZIsA6Q1K5uXXLOdQE681VLambbpRz2POPiWFNhp/V+PP8pEbpJNrpaF3q8fn+5Jcgz3dEeYfJF8Q9pojCNc1RhPo+H2Tf98DNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO1nPgyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5D6C433F1;
	Thu,  1 Feb 2024 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803951;
	bh=DDo0yVFBGoiG+gfJwFR2HHPZwuTH5EzlFn/p4W0v6MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FO1nPgyjRaCqCIeqwJ6JqIj6rC7a4jXK3q8XuqVY8e2t9q939QIEcQK/LL4LmNosA
	 wNkcHQ9Ux/YfhJhWs+bTWvDrYxQfbtPQcu8NfuXih33DbKtMA/xnL50Axt/xVqWp4s
	 amV3MRn18kszPs3q6H37/N9H0O3uKnx+FUVnu7edmng6T0vEzEBbB/UU6+WVjSSmqz
	 98EmB83VoobSWpLjQM+vRSGpVPziqs70YeYKlUb470k1YiXePIhEl4T9G7Pwikb9nj
	 LtPPtqev7cbR3uB71mtkhvWIrd+gtwNhKStIOxxzu+iRk6k0VhHEpOrv0WldqM1/Sp
	 58kw6PkcdKEIQ==
Date: Thu, 1 Feb 2024 08:12:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <darinzon@amazon.com>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
 <davem@davemloft.net>, <netdev@vger.kernel.org>, "Woodhouse, David"
 <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Koler, Nati" <nkoler@amazon.com>
Subject: Re: [PATCH v2 net-next 11/11] net: ena: Reduce lines with longer
 column width boundary
Message-ID: <20240201081230.6db58028@kernel.org>
In-Reply-To: <20240130095353.2881-12-darinzon@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
	<20240130095353.2881-12-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 09:53:53 +0000 darinzon@amazon.com wrote:
> -	sq->entries = dma_alloc_coherent(admin_queue->q_dmadev, size,
> -					 &sq->dma_addr, GFP_KERNEL);
> +	sq->entries = dma_alloc_coherent(admin_queue->q_dmadev, size, &sq->dma_addr, GFP_KERNEL);

To be clear - we still prefer 80 chars in networking.

