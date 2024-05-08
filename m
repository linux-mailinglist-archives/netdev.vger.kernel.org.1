Return-Path: <netdev+bounces-94373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4F8BF492
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C469B206B9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292CBA38;
	Wed,  8 May 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvZd+vbW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237D33F6
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135585; cv=none; b=c9sYbP12COXI6LHnrvK/IWA2J488Rb3PAyiDFDTep55MQcJEjsksvrDkBODICdC/axyJqQs902IR425nmaQi/hYSCrwzQ6nes+t+SxUKAmmuEVLV/juxP4DfuBqOupvQ+U4tQmyXHupJrBfosWGkTwTnw/D90zyj/8LVwJLQiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135585; c=relaxed/simple;
	bh=DhzteD6OrtchTzfy93rr/r+V1QQyXfFHK1YsLCVgM9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHYPCCXCiIuwxeX5BFsADePfII33hoSxh8EHdPl6Pq6Q4TM5+Dzht/Tk9Gv8LcxqfLlIJuqlDH91YBD6v4fkXs1xUJ87c9LTXBk26m528iM5ANzrlx+RoY58o/VLeOw/fBmoeS0CLPNm+kLH4X+KtswJ080TNU4oUynRfMgYq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvZd+vbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E18CC2BBFC;
	Wed,  8 May 2024 02:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715135584;
	bh=DhzteD6OrtchTzfy93rr/r+V1QQyXfFHK1YsLCVgM9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EvZd+vbW2ZU2UArZMQp2vzWTKgxCSULOtPxJRdUHI7sN3qlQElWfvNSjalHGEwAJx
	 FN7yjktsHK2rXM5hE/DP/8UzA7eVfcQaY/PIf9yKkjJepH3RabEm+KkdNI6Va/gO/t
	 g4KconPNKwUBMy7T7NSqHohAGa9zbFThCa4LwC1Egee2DgPRHt96+oXx919dvwwANQ
	 Z5ed3gYW0q0H6nQtpziaiJWY7SWinD4jHmyvmCdcuvcZjMXZXDE5+n/UWTiMJcncNL
	 8Xr4KYozGXbOPvB9Bh+5P2iFr8ihKpwY321OrDQ6uGHlhCHGHw5j2bfiJxRrGXq7pz
	 QjN5gwedoXqBQ==
Date: Tue, 7 May 2024 19:33:02 -0700
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
Subject: Re: [PATCH v1 net-next 3/6] net: ena: Add validation for completion
 descriptors consistency
Message-ID: <20240507193302.440feb6e@kernel.org>
In-Reply-To: <20240506070453.17054-4-darinzon@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
	<20240506070453.17054-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 07:04:50 +0000 darinzon@amazon.com wrote:
> +		if (unlikely((status & ENA_ETH_IO_RX_CDESC_BASE_FIRST_MASK) >>
> +		    ENA_ETH_IO_RX_CDESC_BASE_FIRST_SHIFT && count != 0)) {
> +			struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
> +
> +			netdev_err(dev->net_device,
> +				   "First bit is on in descriptor #%d on q_id: %d, req_id: %u\n",
> +				   count, io_cq->qid, cdesc->req_id);
> +			return -EFAULT;

This is really asking to be a devlink health reporter.
You can dump the information to the user and get the event counter 
for free.

But if you don't want to use that - please at least rate limit the
message.

