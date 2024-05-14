Return-Path: <netdev+bounces-96407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CBA8C5A88
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D8B1F2135E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257117F39F;
	Tue, 14 May 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/oTkoCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E35A0F9
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708861; cv=none; b=owP3wEQSdiCPSjt6ilKYNOJeFwFBSha+tPwWMeF8ng7jLnvSbiPZqNmBD2joqaJOe0FuqlKRSW80n/Ufiyjq3Kyu0N5iFP28n3So6Gh633SZDY39SWhzj0rjSPPLJtkiMHrBxI/MaNGMKDSS4hCKQJP9JIDdFbljpL00exSfk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708861; c=relaxed/simple;
	bh=H0YQel5UVsCvqOQTzaxRjq80OzFEuRkrPi75g5JtH34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIi7LQE6BoIAev5T/xHp192V8MWVWfK0/YPekiZ/oeqbQYxgDXFZLmA4EYZhmunnc18Ku7GCKsmDOd+MV6C0yb0g/CqH5eVxs44sQVJAylmCi3qCSqniMVgHwY/QKx8i3kkVtgUJhTEMXkGEFFkJAMlUAwAsR/kDQkldXbpdFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/oTkoCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC784C2BD10;
	Tue, 14 May 2024 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708861;
	bh=H0YQel5UVsCvqOQTzaxRjq80OzFEuRkrPi75g5JtH34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o/oTkoCx2ww1B/Hmy5jux6y1JSL1WCOj5XqBsbn6Dz3xw1hHJLNwGMlmzjyQ0WjY0
	 fa3+YayuOcHNk2CXDHpNil8hzgp5zvyAnfijVvUr+yrY8WFkEPIfPA0PrKLGPmgeMS
	 wVaWAGHJoR9qK8qYF+IG+ahKF+d/zetDogHw7xnLbmSfi5HouWQC7jEg+ViTuyJuyt
	 QnvgeMCtHm+I9UMHzYuQpLxlLq04A6dCScr2Esvs0kd3PLpyMsqQiHvzycZ4syeC+K
	 Z1W9oLg9JgitMn9/7T9KhXPn2L6Coe/6NzJTbWAq5hHxTNp0obBenT+9sNHS5+HJuq
	 SlsBGaJiu7ooQ==
Date: Tue, 14 May 2024 10:47:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Miller
 <davem@davemloft.net>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for
 GRO-scheduled NAPI
Message-ID: <20240514104739.2d06fb10@kernel.org>
In-Reply-To: <cdaf9e9a-881c-4324-a886-0ed38e2de72e@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
	<ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
	<CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
	<e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
	<CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
	<20240514071100.70fcca3e@kernel.org>
	<78fb284b-f78a-4dde-8398-d4f175e49723@gmail.com>
	<20240514094908.61593793@kernel.org>
	<cdaf9e9a-881c-4324-a886-0ed38e2de72e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 19:09:21 +0200 Heiner Kallweit wrote:
> Thanks for the explanation. What is the benefit of acking interrupts
> at the beginning of NAPI poll, compared to acking them after
> napi_complete_done()?
> If budget is exceeded and we know we're polled again, why ack
> the interrupts in between?

That's a fair point, the main concern for acking after processing
is that we will miss an event. If we ack before processing we can
occasionally take an unnecessary IRQ, but we'll never let a packet
rot on the ring because it arrived between processing packets and
acking the IRQ.
But you know the driver better, maybe there's a clean way of avoiding
the missed IRQs (not sure it would be worth the complexity, tho TBH).

> I just tested with the defaults of gro_flush_timeout=20000 and
> napi_defer_hardirqs=1, and iperf3 --bidir.
> The difference is massive. When acking after napi_complete_done()
> I see only a few hundred interrupts. Acking at the beginning of
> NAPI poll it's few hundred thousand interrupts.

That's quite odd. Maybe because rtl_tx() doesn't contribute to work
done? Maybe it'd be better to set work done to min(budget, !!tx, rx) ?

Or maybe the disabling is not working somehow?

napi_defer_hardirqs=1 should make us reschedule NAPI if there was _any_
work done. Meaning we'd enable NAPI only after a completely empty NAPI
run. On an empty NAPI run it should not matter whether we acked before
or after checking for packets, or so I'd naively think.

