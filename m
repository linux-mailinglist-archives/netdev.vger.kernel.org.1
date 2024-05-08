Return-Path: <netdev+bounces-94372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C649D8BF48F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D8282152
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8D111BB;
	Wed,  8 May 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9kBTwr8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D34111A3
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135473; cv=none; b=ADipx1MzGWeFRP5pE2L3nXQktUgQ1Yh/kkrxIwoxYeYnxyIuDc4rD/9y1gybpzQWGiXF4aoIIhGrLfBGzw8pKl/cA4tzD77JKeV8L9KQR0HlJXnbhyfB9sxeKX8zajWSxIm/Aga/8AS1TaELJmvTuVuRgWCxLFJXPZnVe9NPD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135473; c=relaxed/simple;
	bh=PzUN7as8hvaHEfJH3w49ourLnthqU87g9wzN7k+jD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9yTDxswd0yLEhYAu4Ka2IIC6zMlWBV/UYHFuh17WL2ROi9JUAV1rPcSr0jWdz0nDIzeR9xnWOAut0BuPtBeEdrCkeGLTtCmnwBeC6QEDNQUCfIPLrM6M76F4rkWkMTPn4SAVw+qjhDRWD++6IA+UKEBQ0z2/sz+B1Wjs9/G/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9kBTwr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5BAC2BBFC;
	Wed,  8 May 2024 02:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715135473;
	bh=PzUN7as8hvaHEfJH3w49ourLnthqU87g9wzN7k+jD9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h9kBTwr8rgIj/vSgOUbJOP2430siw/Zm8fKsIMd7vYz6vPgiMYyL7eLqHEWmnnIQq
	 IyqwDZxMaQcjvPtjHaCqhX2ro7CKcu8xsG1hiKNDWHsu0/35v6C/ErIKmcl7FQ+kFR
	 +ZzXJcsGCJ8W62JmwSzQyB7PqlpYLWeTvebccPtbyVyl0E1WBhDlkEr1AvcOxwwRCT
	 5VO5RVpBZf6d5lvIyXYVzlU166ZNFdS3QfJ4iwqigMeFzuAfpkIgqR8DqtG6ByxvIN
	 7C8kte2WocxgYKzucIMM55u/3b9AQlhgevrSue8k0Xb1Rk899aMUiO08mw8CZjy18d
	 U28af+Pv1ZHmw==
Date: Tue, 7 May 2024 19:31:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH v1 net-next 6/6] net: ena: Add a field for no interrupt
 moderation update action
Message-ID: <20240507193111.5d24343c@kernel.org>
In-Reply-To: <20240506070453.17054-7-darinzon@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
	<20240506070453.17054-7-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 07:04:53 +0000 darinzon@amazon.com wrote:
> +	for (i = 0; i < adapter->num_io_queues; i++) {
> +		adapter->rx_ring[i].interrupt_interval_changed =

Shouldn't this be |= ?

> +			adapter->rx_ring[i].interrupt_interval != val;
> +		adapter->rx_ring[i].interrupt_interval = val;
> +	}

