Return-Path: <netdev+bounces-61428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC054823A6D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702FE1F2624B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B41859;
	Thu,  4 Jan 2024 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejbGjvzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10D184F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 02:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11A0C433C8;
	Thu,  4 Jan 2024 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704333637;
	bh=V9qK9vHaVzVPIrQ/kgZ2KLfqJ+7wmCFXutvrGJqjALo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ejbGjvzXljenZkzfjuYvdjNgi3k4wc13IuOwZbfCSDtjwn4j5zvCxN5pO2KypOzFS
	 Zfo1FcACsGaLDGmI0+qGOe6euD4aIxIS4KgsO2ND4LWNhDtHy0k7dfiGSjX0IEd9Bu
	 s7eJiS8Vb7Tnv4zBmWvZ7kLcyamma9mTPtMInN0tLAo/Hr89RxfM+QJTZM7cCZ3w8W
	 B8i5Db4uOMwXsRFLeutUWcanl3ayGJP56PwHYRV7crMRFiLGm5UtXlFXz1Qz38wu+2
	 LbYgzuRJixnz9z3q9Fz7oy3JrrCLPD6bTavNQaTujS9xA7kWIJoNqtpU2A3niT4fHa
	 3aMVAHcPDC2PA==
Date: Wed, 3 Jan 2024 18:00:35 -0800
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
Subject: Re: [PATCH v2 net-next 07/11] net: ena: Refactor napi functions
Message-ID: <20240103180035.1fc5e68a@kernel.org>
In-Reply-To: <20240101190855.18739-8-darinzon@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
	<20240101190855.18739-8-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jan 2024 19:08:51 +0000 darinzon@amazon.com wrote:
> -	xdp_work_done = ena_clean_xdp_irq(tx_ring, xdp_budget);
> +	work_done = ena_clean_xdp_irq(tx_ring, budget);

Not related to this series, but please make sure that if budget is
0 you do *no* XDP processing, Rx or Tx. XDP expects to run in softirq
context, when budget is 0 we may be in hard IRQ.

