Return-Path: <netdev+bounces-96400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A98C59E3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4751F21E0A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80A179647;
	Tue, 14 May 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQy9LbOa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05CF501
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705350; cv=none; b=uPmZcf+vct1URjJ5Y89kVz1u2EiB7Yij8yen8hMrqGMCd1q2feVEeime0aYG0CUAOzon1u7qLR/TOPR02cCOfY5j3Z7vkvdxKTQygAYNz7fjGntCrc3pTrq2p0XcuAkzoZf6+bOFliDGyvkj2sJNi2HS377/e/VliWGdwQ+6vzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705350; c=relaxed/simple;
	bh=uZIxiLbqPeEM51hn5tB74OvRp0QvLuGB8WNYmSsQVEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dq42NFejtEYavjb27y6S2l9Ar+jYO5hb2z99n1mgTd4AiZgGzQIywxGTfAZcqRJ3JtOewOyqora3PtGNAfIYFz26Q2MCDE7Aoou/s/LGSBWVzvDdhYUZNjo0fjFMS8Ft5WK/J2ISS93vzLSi1n2FrTVasaa8uoNb2jC05gypZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQy9LbOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C00C2BD10;
	Tue, 14 May 2024 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715705350;
	bh=uZIxiLbqPeEM51hn5tB74OvRp0QvLuGB8WNYmSsQVEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQy9LbOaJw8dhWXqFy8aTEQLbPXjJzNZjQYAfsmmcVCXtxpizEHI2VO3C4wp8+SIe
	 gmmlA83TB3Pv/1d9vbiIIzYDeB8bl5h2E5ZUudn4pcbMIRyszIEwIedv9OGyuWmrje
	 RuYUrNjVKf8QMsbu06IKIsAClkxqkCw41A509ddduhXojDiARrcyn5Qc0s/8MUtZA1
	 3hRZrDaf9G7KAe1h5J3G/3OLVuRQ43uPEHgDQjy04PIZGS6RWlhAZzgxyXER/bAAFn
	 XwOICyHVhfd+188jPHT8SbcuhmJ7lJrJvXu7XZ2X4RJnEQt4HGbG7Kb7ZlypTVlZ5f
	 lW3g/e61ASkCQ==
Date: Tue, 14 May 2024 09:49:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Miller
 <davem@davemloft.net>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for
 GRO-scheduled NAPI
Message-ID: <20240514094908.61593793@kernel.org>
In-Reply-To: <78fb284b-f78a-4dde-8398-d4f175e49723@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
	<ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
	<CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
	<e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
	<CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
	<20240514071100.70fcca3e@kernel.org>
	<78fb284b-f78a-4dde-8398-d4f175e49723@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 18:35:46 +0200 Heiner Kallweit wrote:
> > I thought the bug is because of a race with disable.  
> 
> No, the second napi_poll() in this scenario is executed with device
> interrupts enabled, what triggers a (supposedly) hw bug under heavy
> load. So the fix is to disable device interrupts also in the case
> that NAPI is already scheduled when entering the interrupt handler.
> 
> > But there's already a synchronize_net() after disable, so NAPI poll
> > must fully exit before we mask in rtl8169_cleanup().
> > 
> > If the bug is double-enable you describe the fix is just making 
> > the race window smaller. But I don't think that's the bug.
> > 
> > BTW why are events only acked in rtl8169_interrupt() and not
> > rtl8169_poll()?   
> 
> You mean clearing the rx/tx-related interrupt status bits only
> after napi_complete_done(), as an alternative to disabling
> device interrupts?

Before, basically ack them at the start of a poll function.
If gro_timeout / IRQ suppression is not enabled it won't make 
much of a difference. Probably also won't make much difference
with iperf.

But normally traffic is bursty so with gro_timeout we can see 
something like:

    packets: x x  x  x x   <  no more packets  >
IRQ pending: xxx  xxxxxxxxxxxxxxxxxxxxxx
        ISR:    []                      []
    IRQ ack:    x                       x
       NAPI:     [=====] < timeout > [=] [=] < timeout > [=]

Acking at the beginning of NAPI poll can't make us miss events 
but we'd clear the pending IRQ on the "deferred" NAPI run, avoiding 
an extra HW IRQ and 2 NAPI calls:

    packets: x x  x  x x   <  no more packets  >
IRQ pending: xxxx xxxxxxxxxxxxxxxxxxx
        ISR:    []                   
    IRQ ack:     x                   x
       NAPI:     [=====] < timeout > [=]

