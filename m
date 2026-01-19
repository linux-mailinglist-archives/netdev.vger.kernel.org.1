Return-Path: <netdev+bounces-251193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94213D3B474
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C4073001C98
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1722EB85E;
	Mon, 19 Jan 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD2Gf0aV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE6281369
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842277; cv=none; b=OFXdO45VeOugmff+IH/2flZkyV8gyGBkbkap+S4wlHv8dUVTq4vv0v3in4fVE+vJnvm0RYFFHgSu5yRyiyvH0rNoVVgLTUpM7yRTAPjOfJ58yy9YWRzqvaV8ZcDLDc5dIFr16ZHj5zcLs/ZbmELpWI6P7b/vqx3Di7SRv7+WFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842277; c=relaxed/simple;
	bh=Srr968woNABGoOESQcpP+dBa9pFWTSYiDZYxBonnKvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwPVUnP2Q6j8e+UhxNPGYSMlKx7ErpKji1WVdONI9gGI37stfnuk5eiyHiZwS2Pk/FBHb/Ofj6MwJJrqALL6SqsZZz9xFgUbn7b7w48Vy0O0+BXE7HP4L6AvrlPbqSJV1E+wrZr5C6TtyrAIbbgVx0PIRyWM6UeABngrl+iVVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD2Gf0aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90478C116C6;
	Mon, 19 Jan 2026 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768842276;
	bh=Srr968woNABGoOESQcpP+dBa9pFWTSYiDZYxBonnKvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WD2Gf0aV35Q/64BAvoGXfUDZcfLz6ph8ldUMxWYp0q1Cp5pIeCbOsLG7HTcZN6Ykc
	 aaNaQGJFoM2AAkGzPdFzIttQ83xuP+/JnvrHG3ZaFmJ0RGdRuDiYdedJ1CyI/y3k1m
	 Bom10uILutgw+8pBveX+iZfNIDtAScqa+dkyIozs9eA8/H6Hup641/4EJ/eDP2Bc1g
	 5zt4E/PUgNIQimCjUxv+lQWG4iRAmycK62sCQIidX8PAD/UrNciKc96WnGJQnCpimj
	 iyoeQBxVlKMeGK9QKAC8PJaTiS1dSvzmj3fGv/je7Z3LSgIH9TN+WHSVg00wHNIJcz
	 HeEnEf26g1J2w==
Date: Mon, 19 Jan 2026 09:04:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260119090435.44b1da2d@kernel.org>
In-Reply-To: <CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
	<20260117150346.72265ac3@kernel.org>
	<CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 13:15:00 +0100 Eric Dumazet wrote:
> > > Also, if workers are away from softirq, they will only process the
> > > defer queue in large patches, after receiving an trigger_rx_softirq()
> > > IPI.
> > > Any idea of skb_defer_free_flush() latency when dealing with batches
> > > of ~64 big TSO packets ?  
> >
> > Not sure if there's much we can do about that.. Perhaps we should have
> > a shrinker that flushes the defer queues? I chatted with Shakeel briefly
> > and it sounded fairly straightforward.  
> 
> I was mostly concerned about latency spikes, I did some tests here and
> this seems fine.

Looks like selftests run into the zerocopy Tx latency issue.
I'll drop this version from patchwork..

> (I assume you asked Shakeel about the extra memory being held in the
> per-cpu queue, and pcp implications ?)

Under real load it helps quite a bit but real load flushes the queues
frequently. I'll talk to him.

