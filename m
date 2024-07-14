Return-Path: <netdev+bounces-111350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10350930A85
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 17:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCE81C20A1C
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CC21311A3;
	Sun, 14 Jul 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um4pv8Ve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76A28F3
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720970578; cv=none; b=sGu0mgUvdCsaCdUuGHPf0nGUVYU+kqw81MNLm8QMdIFuvjHYlc6AUmcAoqdnMuSQmvwWk1ROxzMreboDr6qR9NC9hgP/nVRICJl1cyKZ10lWV743dDqf6nyrrIgINNn+6+UbvgnBNFS0Mj3FC1eymgLEyj1+KxWDCH7Ow7/obc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720970578; c=relaxed/simple;
	bh=A/7KX2Wq6BgQMYrYNlRQ5NEQ3/3WiCOKdmc2Yqp53s8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePw5L2iDfJi4VhR24C1o+tetKHdbc4mZZmap36aB4x6uFP2VlhErAOvmiw9ysA810O/syzcnJpsQkW/lKE/PMXm3+1JUILvJFRK1XSB92FGRsVpMHBhUSioEQ1LFUj6aRFbTbSwsTzbD/WY0ToDFyHcusu4tdC0bbUYNdHNeL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um4pv8Ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508E1C116B1;
	Sun, 14 Jul 2024 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720970577;
	bh=A/7KX2Wq6BgQMYrYNlRQ5NEQ3/3WiCOKdmc2Yqp53s8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=um4pv8VeejMy4o5zoa11s15uiRHg8ieGrBipV9RFlc8FSsLZPM1H31zLCT5V4sMxt
	 pT7R32fRS1F7zojz8KcStDAYYfMMd1y2IIbHHUrvFeU1QwODneO9PvNDKGhcQ0lYV0
	 C2fg6RhP41tzXWESNZq2w0ehWuxn87yVl3YPqUZOe81/VoWUWgJYIro8RELeifGYBq
	 sRCxKALwRRZdAZ8gGPPX9l1jY4mrPc0NsfrMtypaTteJTvJTCb08JHtVt3VITFC5uP
	 rknjL26vMtAtTcy/3GaQMmkSKWPDuXp36Wik074SHjs9qr3tTdSKcGl0o8XfA44A2e
	 peR+pSjX8yjqg==
Date: Sun, 14 Jul 2024 08:22:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Niigee Mashook <mashookniigee@gmail.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: Questions about the chelsio/cxgb3 Driver - TX Stall
Message-ID: <20240714082256.53fa86b8@kernel.org>
In-Reply-To: <CAN9Uquc9Ji2o4WA-Bo6JCY-4X4G54KaLPS1c5VOcCbhWMkR0KQ@mail.gmail.com>
References: <CAN9Uquc9Ji2o4WA-Bo6JCY-4X4G54KaLPS1c5VOcCbhWMkR0KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 21:19:57 +0800 Niigee Mashook wrote:
> 1. Why is not using Tx completion interrupts considered better?
> One reason I can think of is that reducing interrupts to the CPU can
> improve overall performance by allowing the CPU to handle packets more
> efficiently. However, I am concerned that using skb_orphan might cause
> issues like invalidating autocork and leading to bufferbloat(TSQ's
> functionality), which could negatively impact performance. Would this
> not cause a performance regression?

Indeed, this method will have negative effects on any backpressure
mechanism. It's an old driver =F0=9F=A4=B7=EF=B8=8F The perf benefit comes =
as you say
from fewer IRQs and very good batching.

> 2. The comment specifically mentions skb_orphan, and not using it
> would cause a Tx stall. Why is that?
> My understanding is that when sk->sk_sndbuf is small, it might allow
> only the first packet to be sent. Without skb_orphan, after sending
> the first packet, sk->sk_sndbuf becomes equal to sk_wmem_alloc, which
> would prevent subsequent packets from being sent. As a result,
> sk_wmem_alloc would never decrease, leading to a Tx stall. Is this
> correct?

Yes, pretty much.

