Return-Path: <netdev+bounces-139706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2119B3DFC
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10BB282C44
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B218E049;
	Mon, 28 Oct 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRoU/j5x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9941547CA
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155543; cv=none; b=upFDkjcGbwL51v/rKC2rLlfbRDySx7kEoRoz9uBXwNc3G1mRJGiDI6yp4ceRVVJU/jhSNKfqe+6idx8eZaEnrPoEHBadLfSwRnwiRjmeNI4fD3djgugOgsiHqHEB71MVB4dYhU0Ztdx3ySTcp8ooyg+hJD0GVcC17KNaeos3GqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155543; c=relaxed/simple;
	bh=PakjCDbAkx0e0abthJ3AueRHSKJanhWrhmcwvkBaI4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfE+w82bxLbI+f5Bk8HO4vtwc3IIrT7gZqkHr/Jwmz+iMIeYGe6s4gVnunu0euYbKahLN4mVU1jGds6GU9vEeRpTTdJBfJj41mi7LuN7LYMvT8zK8bT29StQXOXCUA93Pp4p8Mz0+SdbMmvXUaUhe951WdUVxYcccSVhkZId8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRoU/j5x; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so3416566a91.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730155541; x=1730760341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kfsp5rQRorGMlZCXCu2Jf1tRAtBRCcWvsYQDV5MsXRw=;
        b=gRoU/j5xtOvmifZVsADzVmu8p3y+QqlcpQZP+YrDPD3JxJOQrTLGzmuP2RU2eKIDDU
         EqxBcFjxZmmXJnSbosITqb1RkdvJJkRFbHE3E5fwYoLjMi9z99If0bGE2RGwgsVRzHYo
         ZjLuxmRNWimGgszyWPxhSYgsFsXGcbuMPpV0AiVaLLbqHcxuWnJs5Dw8Dtsdt2G+Azz7
         ZzYCt9gFLUg71/MRXggMo4o39g0qrp1l+mPEiHvyeQBp35aL2bTmyMz0FbDZeS4sPTa6
         u/TeGXGW+skZNmmHFxD8vdMt+MpOfi/iamGGT8lTb1Y+E6HZ13NSRIvTCBGbaBa8essR
         0vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155541; x=1730760341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfsp5rQRorGMlZCXCu2Jf1tRAtBRCcWvsYQDV5MsXRw=;
        b=D4h1c3W3MxdsDw38eX8Dg2SqFuhq6n06gKxUAzTtKdb9zm1Lrl+WntTWOafj1in614
         q9EL5e7tizeSqBWL89BjExs2+H8QxXGnnZ5zO2tS9ynFSktGggmqqbGOUNPWqCBw7NTq
         t39f2mjo1Thirut8EfyHAQcev7K0di2PybPg2p6kYKCf9/fnZN2BtA1D3yZuwT4bxiZ5
         HOyN0iMwI4HvxwEOQaXWVcE1ax4031xCTlk1seA7vNKIQVOkcEkEc6r8FVmDa2Dba1kz
         L7Mp/DLTP/CokP0khvQBay43RPmIT1+6d2i5R5qWlr+wauQ9OB9ElkrgXnZV0g7pGtIr
         Xrmg==
X-Gm-Message-State: AOJu0YxyPaiWw2JqsYweJsiKHFm/g6wRyOPXRwXURpdno5nCiU6BailA
	2YCEkvjKT7sGxMvRI/EGc4Sc1WJY07QmVjay2AMwmfywqWm0baejRs0tRabpFNXn8hijgooreJx
	WVHWuSGIXp5i4+S1TgdManXOnxRU=
X-Google-Smtp-Source: AGHT+IEeavmqxDerzVZaYHnGHo8jM/l5kUcHXhUwRebBTqHnaPTw5WBFAfZhy9KkOSCvIMnrm0ZRtKpUo+FaqM+irtM=
X-Received: by 2002:a17:90b:3504:b0:2e2:e09e:b910 with SMTP id
 98e67ed59e1d1-2e8f108618amr11581563a91.19.1730155541164; Mon, 28 Oct 2024
 15:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028152645.35a8be66@kernel.org>
In-Reply-To: <20241028152645.35a8be66@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 28 Oct 2024 22:45:29 +0000
Message-ID: <CAJwJo6aF4YJjhNzfp1a08W6tzqUizNYvkww2t+se44ro92HS8g@mail.gmail.com>
Subject: Re: [TEST] TCP AO tests failing with CONFIG_PROVE_RCU_LIST
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Mon, 28 Oct 2024 at 22:26, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hi Dmitry!
>
> We just enabled CONFIG_PROVE_RCU_LIST with commit a3e4bf7f9675
> ("configs/debug: make sure PROVE_RCU_LIST=y takes effect")
> in net-next. Looks like TCP AO tests now splat, eg:

Thanks, will take a look at this today.

> [   42.597861][  T235] =============================
> [   42.598195][  T235] WARNING: suspicious RCU usage
> [   42.598452][  T235] 6.12.0-rc4-virtme #1 Not tainted
> [   42.598697][  T235] -----------------------------
> [   42.598959][  T235] net/ipv4/tcp_ao.c:2232 RCU-list traversed in non-reader section!!
> [   42.599319][  T235]
> [   42.599319][  T235] other info that might help us debug this:
> [   42.599319][  T235]
> [   42.600044][  T235]
> [   42.600044][  T235] rcu_scheduler_active = 2, debug_locks = 1
> [   42.600443][  T235] 1 lock held by bench-lookups_i/235:
> [   42.600734][  T235]  #0: ffff888005bd9098 (sk_lock-AF_INET6){+.+.}-{0:0}, at: do_tcp_getsockopt+0x40b/0x2fe0
> [   42.601327][  T235]
> [   42.601327][  T235] stack backtrace:
> [   42.601628][  T235] CPU: 2 UID: 0 PID: 235 Comm: bench-lookups_i Not tainted 6.12.0-rc4-virtme #1
> [   42.602077][  T235] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   42.602605][  T235] Call Trace:
> [   42.602796][  T235]  <TASK>
> [   42.602930][  T235]  dump_stack_lvl+0xb0/0xd0
> [   42.603178][  T235]  lockdep_rcu_suspicious+0x1ea/0x280
> [   42.603426][  T235]  tcp_ao_copy_mkts_to_user+0xded/0x1050
> [   42.603657][  T235]  ? __lock_acquire+0xb3f/0x1580
> [   42.603917][  T235]  ? __pfx_tcp_ao_copy_mkts_to_user+0x10/0x10
> [   42.604221][  T235]  ? lock_acquire.part.0+0xeb/0x330
> [   42.604463][  T235]  ? __pte_offset_map_lock+0xfb/0x280
> [   42.604707][  T235]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [   42.604947][  T235]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [   42.605220][  T235]  ? do_raw_spin_lock+0x131/0x270
> [   42.605524][  T235]  ? __lock_acquire+0xb3f/0x1580
> [   42.605796][  T235]  ? lock_acquire.part.0+0xeb/0x330
> [   42.606049][  T235]  ? find_held_lock+0x2c/0x110
> [   42.606300][  T235]  ? __lock_release+0x103/0x460
> [   42.606545][  T235]  ? do_tcp_getsockopt+0x40b/0x2fe0
> [   42.606809][  T235]  ? hlock_class+0x4e/0x130
> [   42.607058][  T235]  ? mark_lock+0x38/0x3e0
> [   42.607273][  T235]  ? do_tcp_getsockopt+0x10dd/0x2fe0
> [   42.607508][  T235]  do_tcp_getsockopt+0x10dd/0x2fe0
>
>
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/835822/1-bench-lookups-ipv6/stderr

Thanks,
             Dmitry

