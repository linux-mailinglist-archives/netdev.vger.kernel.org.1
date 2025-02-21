Return-Path: <netdev+bounces-168680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F9A40273
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9233B94E5
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039E205ABE;
	Fri, 21 Feb 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4+ZOIuD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA71FBCAF;
	Fri, 21 Feb 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740175954; cv=none; b=KIuKwSMt3gvsK2bBgRcmRP7gHokbteLpHQT8StIv5a7vZ2akdAJaCzq1WdFePdbrDYYpdtRMJyRdbtKEYIHvhlCdcRUbHiWe5cNC5sHBDw/bT3SxRsJ9AoipVUDdaeZcEcs0YRaslhdbIQNfkLVdvay3RHWe/RcVG/uN3ziK+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740175954; c=relaxed/simple;
	bh=QSPmPn9rB0FtHMJ7t2ehUU/3Kz0rEJ2Cgdfl1iIJkBc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTLKgBo8B51rcwG+V5snepwkydVkjEX5Y3lpcuHGraASiUpIj4h8nCVG2lHUSHBhM9RsMnPLoF9F5OMMzLXSvf4Qvyr04lKEXnGDTmWmlO6WU5oNqmPauINsqFRX4wshmcuGSJELNFtKd++5lZTsu1+PGsdrkjcfw2O4AfrgBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4+ZOIuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA38AC4CEE4;
	Fri, 21 Feb 2025 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740175954;
	bh=QSPmPn9rB0FtHMJ7t2ehUU/3Kz0rEJ2Cgdfl1iIJkBc=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=I4+ZOIuDt8lhQzWB9X/VMoguesRH/GbwC+thPWvbqRNKAjXLgdne3Fc9aNwNPsAFc
	 KwGW/BdYdngrooDxvj2dBCNWt/PewvFVwYDcYApolTBn5FD1TtIw+DbZ/jAD5cQIKR
	 5hQasr0eg0rdX3qIALqFHJbNmg/gJCWoKBfpkLhr9ToVZxIhyUIEjhdyHsRUnRytuT
	 GUdEYZ+HjBQbEiu4jx+1bMxkcNZdeBGu3+7DxDZs3SwYrH/hP8w9KEIiJhpVDk+X7r
	 YU9HM5/nermig09SD6ZfmUUmCJGUUHVxxqmrJ2zLJnyxppwBPWIX/DXYpQxxPWxFKt
	 9YfrME1PchXSw==
Date: Fri, 21 Feb 2025 23:12:31 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joe Damato <jdamato@fastly.com>, LKML <linux-kernel@vger.kernel.org>,
	netdev@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] net: Handle napi_schedule() calls from non-interrupt
Message-ID: <Z7j6Tzav6u6Z0A8B@pavilion.home>
References: <20250221173009.21742-1-frederic@kernel.org>
 <Z7i-_p_115kr8aj1@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7i-_p_115kr8aj1@LQ3V64L9R2>

Le Fri, Feb 21, 2025 at 12:59:26PM -0500, Joe Damato a écrit :
> On Fri, Feb 21, 2025 at 06:30:09PM +0100, Frederic Weisbecker wrote:
> > napi_schedule() is expected to be called either:
> > 
> > * From an interrupt, where raised softirqs are handled on IRQ exit
> > 
> > * From a softirq disabled section, where raised softirqs are handled on
> >   the next call to local_bh_enable().
> > 
> > * From a softirq handler, where raised softirqs are handled on the next
> >   round in do_softirq(), or further deferred to a dedicated kthread.
> > 
> > Other bare tasks context may end up ignoring the raised NET_RX vector
> > until the next random softirq handling opportunity, which may not
> > happen before a while if the CPU goes idle afterwards with the tick
> > stopped.
> > 
> > Such "misuses" have been detected on several places thanks to messages
> > of the kind:
> > 
> > 	"NOHZ tick-stop error: local softirq work is pending, handler #08!!!"
> 
> Might be helpful to include the stack trace of the offender you did
> find which led to this change?

There are several of them. Here is one example:

	__raise_softirq_irqoff
	__napi_schedule
	rtl8152_runtime_resume.isra.0
	rtl8152_resume
	usb_resume_interface.isra.0
	usb_resume_both
	__rpm_callback
	rpm_callback
	rpm_resume
	__pm_runtime_resume
	usb_autoresume_device
	usb_remote_wakeup
	hub_event
	process_one_work
	worker_thread
	kthread
	ret_from_fork
	ret_from_fork_asm

There is also drivers/net/usb/r8152.c::rtl_work_func_t

And also netdevsim:
https://lore.kernel.org/netdev/20250219-netdevsim-v3-1-811e2b8abc4c@debian.org/

And probably others...

> 
> > Chasing each and every misuse can be a long journey given the amount of
> > existing callers. Fixing them can also prove challenging if the caller
> > may be called from different kind of context.
> 
> Any way to estimate how many misuses there are with coccinelle or
> similar to get a grasp on the scope?

I don't think Coccinelle can find them all. The best it can do is to find direct
calls to napi_schedule() from a workqueue or kthread handler.

I proposed a runtime detection here:

  https://lore.kernel.org/lkml/20250212174329.53793-2-frederic@kernel.org/

But I plan to actually introduce a more generic detection in
__raise_softirq_irqsoff() itself instead.
 
> Based on the scope of the problem it might be better to fix the
> known offenders and add a WARN_ON_ONCE or something instead of the
> proposed change? Not sure, but having more information might help
> make that determination.

Well, based on the fix proposal I see here:
https://lore.kernel.org/netdev/20250219-netdevsim-v3-1-811e2b8abc4c@debian.org/

I think that fixing this on the caller level can be very error prone
and involve nasty workarounds.

Oh you just made me look at the past:

  019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
  330068589389 ("idpf: disable local BH when scheduling napi for marker packets")
  e3d5d70cb483 ("net: lan78xx: fix "softirq work is pending" error")
  e55c27ed9ccf ("mt76: mt7615: add missing bh-disable around rx napi schedule")
  c0182aa98570 ("mt76: mt7915: add missing bh-disable around tx napi enable/schedule")
  970be1dff26d ("mt76: disable BH around napi_schedule() calls")
  019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
  30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new  function to be called from threaded interrupt")
  e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schdule()")
  83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule")
  bd4ce941c8d5 ("mlx4: Invoke softirqs after napi_reschedule")
  8cf699ec849f ("mlx4: do not call napi_schedule() without care")
  ec13ee80145c ("virtio_net: invoke softirqs after __napi_schedule")

I think this just shows how successful it has been to leave the responsibility to the
caller so far.

And also note that these issues are reported for years sometimes firsthand to us
in the timer subsystem because this is the place where we detect entering in idle
with softirqs pending.

> 
> > Therefore fix this from napi_schedule() itself with waking up ksoftirqd
> > when softirqs are raised from task contexts.
> > 
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Closes: 354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de
> 
> AFAIU, Closes tags should point to URLs not message IDs.

Good point!

> 
> If this is a fix, the subject line should be:
>    [PATCH net]

Ok.

> 
> And there should be a Fixes tag referencing the SHA which caused the
> issue and the patch should CC stable.

At least since bea3348eef27 ("[NET]: Make NAPI polling independent of struct
net_device objects."). It's hard for me to be sure it's not older.


> 
> See:
> 
> https://www.kernel.org/doc/html/v6.13/process/maintainer-netdev.html#netdev-faq

Thanks.

