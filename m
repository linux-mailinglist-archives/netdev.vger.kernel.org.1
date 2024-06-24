Return-Path: <netdev+bounces-106259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9784D91598F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5281B283A0A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54831A0B0B;
	Mon, 24 Jun 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3qO2ehN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6E135A46
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266576; cv=none; b=TizDeDrc5vqkseEvm4Iy/cny0yyOqPsnVKOxmCiNkyKjFbnUUHrNg1P5tQcwG1hDpa59AtKYKRMhUpyrg7wKdMHo0bbBU2g71L4zJaN5kj46pAT04qQRtv2XfS4DemimSXXzoZNVU3C5lDmegfg0wH4UqbpHV//0SgjKRepI1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266576; c=relaxed/simple;
	bh=ro33OYcpWqwsLEX2VJTkf9im+2a0Snx3vxaWBm0KQG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dujCzxJSmy/JE5W0wosWNVPPb14rz7hbvud2wXMFfdpW4+WZRCOHQ4O9bWXdJ55UE5lwD8UfdqMFEu4Gu/FztoP033ehz8y5zdRfPop3aRiBme5GUfja5v3JEj7bb9txHwR6TNY147FC0jeRIbkP9BBJfJuSKw8mAgEecR/lwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3qO2ehN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05A9C2BBFC;
	Mon, 24 Jun 2024 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719266576;
	bh=ro33OYcpWqwsLEX2VJTkf9im+2a0Snx3vxaWBm0KQG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r3qO2ehNmjqpLhPgIH11VldPjcm3MU6GIFOqCmpIaPDiXynPlMww04xvqH7zma9Pj
	 kcACOA39oPPKQmCvO8Y5LLIGHltOr3NLrJKoE5INZ2d+lV5TWy8fDQSMCyRerlpT//
	 KLMP3vFhj6lI5UCJlPCSRgb52PH/1BrHeouw3a89X29Lm7QfTOXTwzx3CuXL+nmXPk
	 wn/Zo1aE/oLb4yxEkARGZTW9u4qpf+aNGA8mqcvLpy/kEt1yd3cw2ofV+YIiU3Dvci
	 MGaANZV1zAVO5mJUGJ0I7fP0QYJts0nnfJ4WzkY/rXWptJk472Mk/drJ0WyB/g8Ywb
	 mpPAZ4qMV9HHw==
Date: Mon, 24 Jun 2024 15:02:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Adrian Alvarado
 <adrian.alvarado@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, David
 Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: implement
 netdev_queue_mgmt_ops
Message-ID: <20240624150254.053d0c00@kernel.org>
In-Reply-To: <ba5bef44-c823-4ec3-bf2d-66f66821d043@davidwei.uk>
References: <20240619062931.19435-1-dw@davidwei.uk>
	<20240619062931.19435-3-dw@davidwei.uk>
	<20240621172053.258074e7@kernel.org>
	<ba5bef44-c823-4ec3-bf2d-66f66821d043@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 11:20:59 -0700 David Wei wrote:
> > What's the warning you hit?
> > We should probably bring back page_pool_unlink_napi(), 
> > if this is really needed.  
> 
> This one:
> 
> https://elixir.bootlin.com/linux/v6.10-rc5/source/net/core/page_pool.c#L1030
> 
> The cause is having two different bnxt_rx_ring_info referring to the
> same NAPI instance. One is the proper one in bp->rx_ring, the other is
> the temporarily allocated one for holding the "replacement" during the
> reset.

Makes sense, as I said please look thru the history - some form of
page_pool_unlink_napi() used to be exported for this use case, but
Olek(?) deleted it due to lack of in-tree users.

With that helper in place you can unlink the page pool while the NAPI
is stopped, without poking into internals at the driver level.

