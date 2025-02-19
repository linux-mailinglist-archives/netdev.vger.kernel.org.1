Return-Path: <netdev+bounces-167791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11D3A3C527
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C549170100
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB51FE45B;
	Wed, 19 Feb 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6o2RNbz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/wdJWz7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE61FCCFD
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982958; cv=none; b=Pmw7JS1N5dbLz8g3fw2pUSDa2dbFMITxByzCIHFvLru+akdfqOF/HXLWuH6Z90yTUgcIVtHzllx/iOMntn7Ns94k+QDITvbv6cKrkWnrxipD1YGvUksS2akCMNO6nkikQf0f4xSv4dSXNl5Hv4rXpFuqLkpWS3/dNi2ABbcFWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982958; c=relaxed/simple;
	bh=HzoPRcbo1sZJr6X53Gir4NnTtYTOh1eIxNPN8BggoCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmwAP8Y1e9QsQUO3O9C/zU8GqZHIVM4g/p7Pkl/uOcdM6BekyNnSWfPFFYI1KAY8bR8+7o9maI5fObHGnebLJN7Gnn0IgkYXXS6cjtz+ylESy7X5X/fiI4qzBaxqKp4DZNfRpdjjiU4ZKdyXvZb/J4KbGnsAAls8mm7/BjodHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6o2RNbz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/wdJWz7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Feb 2025 17:35:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739982955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYLiK0NZ1Y+3yos+Ly4zbYhqrH33YW8FKzguWH7YSvo=;
	b=q6o2RNbzUlBVpikoJNK35XG+ep9xFP7zN1k7BMr7uwEWEzG3pcOSRywEUyOBAiz1ad5HzE
	vEycc3d+0/HY0uZo+7PCdxJGojxL8cfYEIua2ffz4niCM6IjdmvCxxxv872Gbt2N+mIuS0
	T1dKQi6YgkhLAtrm5GFw/fm26YqeX3sFOnNUnGC9eSnDLzXbvR7AByGsxljbPUhQzMkSds
	Dk8PauuONtuP2iIQ5ye8MAllQ8DxaXRo2wHl38V5sZuH7m6pP9BxJthIS7vka8hqVA2osE
	5qmHFR0BNl5sgNSPvzMAl30+KuaEe/jPP3afNOWMsJUJ8fsteeJgjHVLt333rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739982955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYLiK0NZ1Y+3yos+Ly4zbYhqrH33YW8FKzguWH7YSvo=;
	b=F/wdJWz7STdeMlCDT7MaxHD82w1S85+JnuocMsP1kOTrzjkF8oA77yvJAdivkzGMoY6MEL
	W3UBSGllO2qPx3CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, rostedt@goodmis.org,
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250219163554.Ov685_ZQ@linutronix.de>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
 <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>

On 2025-02-18 11:50:55 [-0300], Wander Lairson Costa wrote:
> These logs are for the test case of booting the kernel with nr_cpus=3D1:
>=20
>      kworker/0:0-8       [000] d..2.  2120.708145: process_one_work <-wor=
ker_thread
>      kworker/0:0-8       [000] ...1.  2120.708145: igbvf_reset_task <-pro=
cess_one_work

This looks like someone broke the function tracer because the preemtion
level should be 0 here not 1. So we would have to substract one=E2=80=A6 Th=
is
does remind me of something else=E2=80=A6

=E2=80=A6
>      kworker/0:0-8       [000] b..13  2120.718620: e1000_reset_hw_vf <-ig=
bvf_reset
=E2=80=A6
>      kworker/0:0-8       [000] D.h.3  2120.718626: irq_handler_entry: irq=
=3D63 name=3Dens14f0
^ the interrupt.
=E2=80=A6
>      kworker/0:0-8       [000] b..13  2120.719133: e1000_check_for_ack_vf=
 <-e1000_write_posted_mbx
>   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_msix_other <-irq_t=
hread_fn
>   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_rd32 <-igb_msix_ot=
her
>   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst <-ig=
b_msix_other
>   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst_pf <=
-igb_msix_other

The threaded interrupt is postponed due to the BH-off section. I am
working on lifting that restriction. Therefore it gets on CPU right
after kworker's bh-enable.

=E2=80=A6
> The threaded interrupt handler is called right after (during?)
> spin_unlock_bh(). I wonder what the 'f' means in the preempt-count
> field there.

The hardware interrupt handler gets there while worker is in the wait
loop. The threaded interrupt handler gets postponed until after the last
spin_unlock_bh(). The BH part is the important part.
With that log, I expect the same hold-off part with threaded interrupts
and the same BH-off synchronisation.

> I am currently working on something else that has a higher priority, so
> I don't have time right now to go deeper on that. But feel free to ask
> me for any test or trace you may need.

I would need to check if it is safe to explicitly request the threaded
handler but this is what I would suggest. It works around the issue for
threaded interrupts and PREEMPT_RT as its user.
You confirmed that it works, right?

Sebastian

