Return-Path: <netdev+bounces-167777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C745EA3C3AA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238311889F94
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09991F461F;
	Wed, 19 Feb 2025 15:28:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249C1F460B;
	Wed, 19 Feb 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978934; cv=none; b=uU1F/g/JRyaGTGa3eLbbNKzoeKLPsoounyaEzCmvxNTA4AQorffgUkTWPrQ8sZY+FMAYo+si45c2Y1nSgkaA8N+nDcJobxDmovD7UE7zElQ4ynQpCKeZHdtragCsJZXy8mlDWCIP+Z0YrnE/HMYVXORlLcXjZiSYtfL6D5uKbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978934; c=relaxed/simple;
	bh=x9ailOTXzWx6wgkaOYecX06SAiQdtNujXzKhbhPfE5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rzup1sM2UrthCDdr+QJkDALpfercRslu5b9VgkcpPeFM2+LrBEMNBTGGVveJ5Q+uHjBcU0ITLJtMOCBHBPBu51aLqvbFwczrP16SFxkLKZw867/8abxf4wXzlvOkLv/OvaBoUZZTKpw5R+A5bTS3iAFEtEzI/7Tf1Dh1OcDU1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEEBC4CED6;
	Wed, 19 Feb 2025 15:28:52 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:29:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, clrkwllms@kernel.org, jgarzik@redhat.com,
 yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other()
 handling for PREEMPT_RT
Message-ID: <20250219102916.78b64ee4@gandalf.local.home>
In-Reply-To: <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
	<20250205094818.I-Jl44AK@linutronix.de>
	<mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
	<20250206115914.VfzGTwD8@linutronix.de>
	<zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
	<20250212151108.jI8qODdD@linutronix.de>
	<CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
	<20250212152925.M7otWPiV@linutronix.de>
	<mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 11:50:55 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

>      kworker/0:0-8       [000] b..13  2121.730643: e1000_init_hw_vf <-igbvf_reset
>      kworker/0:0-8       [000] b..13  2121.730643: e1000_rar_set_vf <-e1000_init_hw_vf
>      kworker/0:0-8       [000] b..13  2121.730643: e1000_write_posted_mbx <-e1000_rar_set_vf
>      kworker/0:0-8       [000] D.Zf2  2121.730645: igbvf_reset_L14: (igbvf_reset+0x62/0x120 [igbvf])
>      kworker/0:0-8       [000] .N...  2121.730649: igbvf_reset_L16: (igbvf_reset+0x7b/0x120 [igbvf])
>   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_msix_other <-irq_thread_fn
>   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_rd32 <-igb_msix_other
>   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst <-igb_msix_other
>   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst_pf <-igb_msix_other
> 

> This is the trace-cmd command line I ran:
> 
> $ trace-cmd start -p function -l 'e1000*' -l 'igb*' -l process_one_work -e irq:irq_handler_entry -e probe
>   plugin 'function'
> 
> The threaded interrupt handler is called right after (during?)
> spin_unlock_bh(). I wonder what the 'f' means in the preempt-count
> field there.

The preempt count is hex, so 'f' means 15. But that that latency field looks corrupted.

After adding the probes by perf, what's the content of the format files for them?

That would likely be in /sys/kernel/tracing/events/probe/*/format

Thanks,

-- Steve


