Return-Path: <netdev+bounces-126040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3596FB76
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 20:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D04E1F23C1F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799AD13C908;
	Fri,  6 Sep 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uJqed49R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GkFvc/6r"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F01B85CA;
	Fri,  6 Sep 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648447; cv=none; b=DlrT6X83K9B3vgV4YOo1AU4dQzHoOcQGk64johAWtS1keFvh7fZs2U1QieLqwxpzzyxxNXHc2SDdlOhT/6iq3v3Hvxm/Ymqpij1Iy489MpAITtJ5yilzx5/2FBMotfxJW/aN7gToRfiLFMB3j+Px/M4T+qnri0f290V4qIC60gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648447; c=relaxed/simple;
	bh=3d+ZXf/xSm/nN/v5nB+l5Xe8ZmKcrLjpKFIQMkr6+fA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBNELC60vp9bYjh2UY3ZmnD/ptIa2Sgq9PrPLQdO2QozryaZThc16IQBlgfgCu72Bq8hVNCS3imDAEIk4b8iZ9zS/0xtF45GZ6mfGg4Q5qGEmCcB7Z1/I87zKkeQv99ts224dGWD2tFz7+Ks6XDI6+i8XIoJ/jqjv2V9l1O0Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uJqed49R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GkFvc/6r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725648444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Tm800FinU3/T8yilkTveTHCBvpI8WQ9vtzpkJkFbS4=;
	b=uJqed49RtQsYyAVPvdEI/L+r+DTyZ7zmXQ9YLsmckmWF17ZbjZ3mbCrVSvVwLOw4hKgd0C
	Q5TbhTxQ7d88r1LIkx3i7fhHcpbYKPfGVkAZ95wvPjb9v5yal9Zq+hTuur5p80SWXlTx5T
	mfBXMenNHy+MkKBAlSWK0pV0n2R8BKI52WHh3ySL7K5Ac5yMBlgb8Iwqq2r/nyMV1SClnu
	Ht/XUC9WYlvJt3WoFrLGmcKK007KTeJuT9HE2a5WzbDVwGuqllnvX39tzBmmjhUIO0faAN
	RVIc5u7FzzIPcCJ7sduosmJZUMpQiV6plvzb/pXkY1R9M9TzIkyMhsN15Ciejg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725648444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Tm800FinU3/T8yilkTveTHCBvpI8WQ9vtzpkJkFbS4=;
	b=GkFvc/6rkDMBQ4KoA+IiFadYOo+0SmLlR3sWmZvI9kK0g6B9dctl7y4RzTlT9xEz3E4Qv2
	a58FYEIFoKxv19BA==
To: syzbot <syzbot+b3f9c9d700eadf2be3a9@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, luto@kernel.org, netdev@vger.kernel.org,
 peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] possible deadlock in __run_timer_base
In-Reply-To: <0000000000006d27bb0621752b84@google.com>
References: <0000000000006d27bb0621752b84@google.com>
Date: Fri, 06 Sep 2024 20:47:23 +0200
Message-ID: <878qw4ei10.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 06 2024 at 08:36, syzbot wrote:
> HEAD commit:    b408473ea01b bpf: Fix a crash when btf_parse_base() return..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=10840739980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=eb19570bf3f0c14f
> dashboard link: https://syzkaller.appspot.com/bug?extid=b3f9c9d700eadf2be3a9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> ------------[ cut here ]------------
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.11.0-rc4-syzkaller-gb408473ea01b #0 Not tainted
> ------------------------------------------------------
> syz.2.317/6997 is trying to acquire lock:
> ffffffff8e813cb8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
>
> but task is already holding lock:
> ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: expire_timers kernel/time/timer.c:1839 [inline]
> ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: __run_timers kernel/time/timer.c:2417 [inline]
> ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: __run_timer_base+0x69d/0x8e0 kernel/time/timer.c:2428
>
> which lock already depends on the new lock.

Right, but that's not the real problem and I fear we can't do much about
this potential deadlock. The real issue is this:

> WARNING: CPU: 1 PID: 6997 at kernel/time/timer.c:1830 expire_timers kernel/time/timer.c:1830 [inline]

                if (WARN_ON_ONCE(!fn)) {
                        /* Should never happen. Emphasis on should! */

So some code enqueued a timer, which at the time of enqueue must have
had a timer->function set because there is an explicit check for this.

Now something set timer->function to NULL, which triggers that warning.

That potential deadlock probably cannot be cured, but that warning
should never happen. So that's a really screwed up situation and trying
to get the warning out has priority.

No idea how to find the culprit though.

Thanks,

        tglx

