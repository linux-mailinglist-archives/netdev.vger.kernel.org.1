Return-Path: <netdev+bounces-198358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8AADBE34
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C02C3A892C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB3339A8;
	Tue, 17 Jun 2025 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1HADDBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA4F9C0
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120322; cv=none; b=pJVUhUajouaFC0+8SvinuRbcc+OgqIjSbVgsJx1VZpAJEUmC3MyGWlAUlYoN0/qXdwwxGFcN31lIQsgn/NvNsxOB8Gn0Qeue8lQw1jOweCG16/1hHaskanyZz1silQZ3f5REpyVtBU5jJswpHcML9XYMm5ZiYw/g6dQjQ8SEcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120322; c=relaxed/simple;
	bh=AUi6T8XvVT89DlTgWc1qGfarsC/u+6dDBSqIhCogNPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4odTytiCnRenF4KVXoHZWhT8BYSYxi9x+PngzK3xLizdOk/YKsUY1YEfAftb5/xwBQfxaH3jtiEr6WVxn5IEI4A+hrdIRvw2kGzHS5QcmPQMVcRUdjuitvqR93PAwTZsvAV8/ygvj73Ier1ycTz/y2PswziMSL1IeLaVmITPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1HADDBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B79C4CEEA;
	Tue, 17 Jun 2025 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750120322;
	bh=AUi6T8XvVT89DlTgWc1qGfarsC/u+6dDBSqIhCogNPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H1HADDBEgWjiCycSodynhALBnaWwSVawNveOV8gry9LJaE09qGB0zkYmzO+zU9P6f
	 vMQD8jMO5DbRJa8yu/wx8ifxp6FuDZwIpLktylASF4ZZvEbhx04cZwvsriXQG8n/Sn
	 uwMUZLkfvajoES7KAa1F/28t22ATrvPD9W34oDQYkGQowhXx2zNaxcIA9dLLIpmqlX
	 S1/o5A/u+uM2I+Z53RXq1oSmGt+84oApU6HLQd7kBrVt5eE+YaNMvjgHfRLzKkhorc
	 Z5Rvmx6CmwhJ4899ajmSlh9M+etMB2cVKGoC14JwUpWQ+5PooeVUl09k+cZRW51fQb
	 HbcAarDmpenaA==
Date: Mon, 16 Jun 2025 17:32:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky, Evgeny"
 <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski,
 Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
 <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v12 net-next 9/9] net: ena: Add PHC documentation
Message-ID: <20250616173200.103a5654@kernel.org>
In-Reply-To: <20250611092238.2651-10-darinzon@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
	<20250611092238.2651-10-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 12:22:38 +0300 David Arinzon wrote:
> +- ``CONFIG_PTP_1588_CLOCK=m``: the PTP module needs to be loaded prior to loading the ENA driver:
> +
> +Load PTP module:
> +
> +.. code-block:: shell
> +
> +  sudo modprobe ptp

Again, I'm not sure that's true. If user insmods the ena driver and
PTP=m then sure, PTP needs to be loaded. But modprobe would load it
automatically. So this appears to be an echo of out-of-tree docs.

