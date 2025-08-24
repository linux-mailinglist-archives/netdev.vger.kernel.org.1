Return-Path: <netdev+bounces-216264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 760FFB32D5F
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 05:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B7A1B6349B
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 03:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38219E968;
	Sun, 24 Aug 2025 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTsL18P+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09041EEE6;
	Sun, 24 Aug 2025 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756005834; cv=none; b=hUjzAykIwySbkLguW5GXhCqdssRrvGAHuNruOFBIWImWCYHHpEF18tgO0pfx/Zv7BnVVe9rBS0xl9WqDQ9CnCwF+/Hgr+0XEXEDY48AfC5E/U7Lzgd9gAYPz1sJ+bcZh91nowt2/gkF8XDbzRb2OH0qAxIlmopz3kV3R3YVBRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756005834; c=relaxed/simple;
	bh=pg/dlUkuztYMXWaPFPqoc72X3qOIYAxeaje7mI10Y0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unfhtKUZGAEaLjkmJaKdF/JaxkjRGLQxQxaJE01KngxUq9cVVQ5l5AfhBH/kH+gxezjcfQgj11DsX7W+nbXN0IyrygskpYgtKN3gCSjUdS5xkC4TWeV4ZaGTHUiqQ9RTN8NDhcqTpoSURuzsGZ9G/5ZoMuM540Vg7U8eUwqpJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTsL18P+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e8005bso3526318a91.3;
        Sat, 23 Aug 2025 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756005832; x=1756610632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iW6U4cBUPheNzlaaIZxWL/gjHUJeJ0gapkBMT8T3g/w=;
        b=QTsL18P+/g5fTTaqK8oAjPdErkOaRwCYHbeTwG0HzmOQvVu+rP7IVyChD7hC8PMRv7
         kPNYyLVkikrokIH3DCdpcTcHYc+LtZN+lcAVFYpkK4SqQzIBA0rDoSnfZ6uNxUA8OrwE
         4T+jQYx/QOUcV7kiP9CTE9AlR8Tx7bZodpx+dFl4ryq/zRf9LjYfFzaRyO/Gl5NOY55Y
         BXwDhGX4J6vMNe3e8AIxybVcBWFVaVF71RWFGB8MY3hg9vuXRvM56cDRgudSLKfRUCk/
         StR/m4CtVM/dDaMkwXDLIIAoMXBOCZnGS5I7DGLQzfZOQYZZ+N3jWrnW0su/brUcC84E
         6PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756005832; x=1756610632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iW6U4cBUPheNzlaaIZxWL/gjHUJeJ0gapkBMT8T3g/w=;
        b=GcPz9fNRMxW7Iba+TCUHhH2Y65eOXpyVkp70nqP+FMNgfs74xIQfABMmqjZj2talwG
         UmN23aJS7itNWcM1gZZR6iE/vbFVTqKBIHueUMzYbr6S2UnEDs2yovgAh1S7fndk+XB3
         X2mtEl+kDqycSgW7vfsJbaqcStog0SsQ6Hlv8naQpnN2dv+4M97cGX43uwKbRy3pNrS5
         ic598H4EklXQnTLYd+5jdvO3pK3icUMrDQRBzqWhvYcGUtJVr2IVMmpwvNFud45RrhAb
         +zKkP0yKmihUoUszbWRLiq9w/LWjq3Bu5iFN+suXRqX9vcbSDa0NzTaZ21/9Hj8GoIqE
         5Xfg==
X-Forwarded-Encrypted: i=1; AJvYcCUwyPcfMdKDOupVf1oZT2HoY3yMaBQ/pBEACyPerALGZJDBj823jjq5Jbnpm8QGU6gANBs2pbwGDUw9lbw=@vger.kernel.org, AJvYcCVhbChtspLtg5vgnPcInlhAcuVkDdILpe2QlVFkVbWspoyWnnSjVxeySv4HdSfoXxytyTxwypFQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0F9SNFhLgtC9Lg4BVjuERkVnO4HsP4sS19hmvvzA3E/jnsJS
	XN9qdNXX/CceAdyXsFcYrUavjt3Z95ejQ0+STI485bjoGk9wOonD48/cKMnF9It2wXoe/pfmx7H
	9pXnXLGC6Xv07bpcfd0sI5bEysYheZfI=
X-Gm-Gg: ASbGncurG02etLeBjEl1j5/bcA9UZ+r27Dds9U4g0i851UTFf/dC1zgFhWdv9S2Y50Z
	p7Y/8QeP2syiPgL8JsaMQeXJJP1egpp1gQH0d0bzVmjhZGxleF0PKuonBLNsE9SFGauZt5CAzK2
	CqdHF58I4w08XY6/a9fzxsRD9ryTxOcHln6VbI0GSnoAlJUUaQpGAWyYkfzVdXcpXshnHFB3512
	kgY5Zw7g9M40TnWt28EYSiTDhbAqGC6IrLgqhg=
X-Google-Smtp-Source: AGHT+IHRLV0RP1aq8S5aiZBbBrOetAWgneSR9mnAFwe+pANIfARu2Bgi9xflrZAwPui9idjgashSlwcHLyC4ShfKLfU=
X-Received: by 2002:a17:90b:1d8a:b0:321:ca4b:f6cf with SMTP id
 98e67ed59e1d1-32515ef1564mr9688413a91.35.1756005831909; Sat, 23 Aug 2025
 20:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728062649.469882-1-aha310510@gmail.com>
In-Reply-To: <20250728062649.469882-1-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sun, 24 Aug 2025 12:23:40 +0900
X-Gm-Features: Ac12FXzgLDu2LqkROQf_pTUZGbSVWSlaFao2L9SkwHpBIHYauUERIDITwV08hAI
Message-ID: <CAO9qdTGswktFP=VLx4sqF6C25Shmory3TauSHYufuir+4N71nw@mail.gmail.com>
Subject: Re: [PATCH net v4] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
To: richardcochran@gmail.com, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, yangbo.lu@nxp.com, vladimir.oltean@nxp.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com, 
	syzbot+28ddd7a3988eea351eb3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park <aha310510@gmail.com> wrote:
>
> syzbot reported the following ABBA deadlock:
>
>        CPU0                           CPU1
>        ----                           ----
>   n_vclocks_store()
>     lock(&ptp->n_vclocks_mux) [1]
>         (physical clock)
>                                      pc_clock_adjtime()
>                                        lock(&clk->rwsem) [2]
>                                         (physical clock)
>                                        ...
>                                        ptp_clock_freerun()
>                                          ptp_vclock_in_use()
>                                            lock(&ptp->n_vclocks_mux) [3]
>                                               (physical clock)
>     ptp_clock_unregister()
>       posix_clock_unregister()
>         lock(&clk->rwsem) [4]
>           (virtual clock)
>
> Since ptp virtual clock is registered only under ptp physical clock, both
> ptp_clock and posix_clock must be physical clocks for ptp_vclock_in_use()
> to lock &ptp->n_vclocks_mux and check ptp->n_vclocks.
>
> However, when unregistering vclocks in n_vclocks_store(), the locking
> ptp->n_vclocks_mux is a physical clock lock, but clk->rwsem of
> ptp_clock_unregister() called through device_for_each_child_reverse()
> is a virtual clock lock.
>
> Therefore, clk->rwsem used in CPU0 and clk->rwsem used in CPU1 are
> different locks, but in lockdep, a false positive occurs because the
> possibility of deadlock is determined through lock-class.
>
> To solve this, lock subclass annotation must be added to the posix_clock
> rwsem of the vclock.
>
> Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad

Reported-by: syzbot+28ddd7a3988eea351eb3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=28ddd7a3988eea351eb3

> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
> v4: Remove unnecessary lock class annotation and CC "POSIX CLOCKS and TIMERS" maintainer
> - Link to v3: https://lore.kernel.org/all/20250719124022.1536524-1-aha310510@gmail.com/
> v3: Annotate lock subclass to prevent false positives of lockdep
> - Link to v2: https://lore.kernel.org/all/20250718114958.1473199-1-aha310510@gmail.com/
> v2: Add CC Vladimir
> - Link to v1: https://lore.kernel.org/all/20250705145031.140571-1-aha310510@gmail.com/
> ---
>  drivers/ptp/ptp_private.h | 5 +++++
>  drivers/ptp/ptp_vclock.c  | 7 +++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index a6aad743c282..b352df4cd3f9 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -24,6 +24,11 @@
>  #define PTP_DEFAULT_MAX_VCLOCKS 20
>  #define PTP_MAX_CHANNELS 2048
>
> +enum {
> +       PTP_LOCK_PHYSICAL = 0,
> +       PTP_LOCK_VIRTUAL,
> +};
> +
>  struct timestamp_event_queue {
>         struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
>         int head;
> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 7febfdcbde8b..8ed4b8598924 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c
> @@ -154,6 +154,11 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
>         return PTP_VCLOCK_REFRESH_INTERVAL;
>  }
>
> +static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
> +{
> +       lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);
> +}
> +
>  static const struct ptp_clock_info ptp_vclock_info = {
>         .owner          = THIS_MODULE,
>         .name           = "ptp virtual clock",
> @@ -213,6 +218,8 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
>                 return NULL;
>         }
>
> +       ptp_vclock_set_subclass(vclock->clock);
> +
>         timecounter_init(&vclock->tc, &vclock->cc, 0);
>         ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
>
> --

