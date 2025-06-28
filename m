Return-Path: <netdev+bounces-202102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F17AEC38E
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AEE3A7C9C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB02A4D8D1;
	Sat, 28 Jun 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmcmYqo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099031E505;
	Sat, 28 Jun 2025 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071120; cv=none; b=VHFXcP9sqNYg7jh1vzw6llqcBRLiGpXC6MCZIl6+RbKQKrn9hoSetCnU1tg5Pg1D45Ul29hiJxo4rykgt0gyPfNMvTXWKCJzP9rUvXHaydaoVA4ekQ9+5WmOupG1Knj0DNaGaKLXnSMaLoSp+nkXEqNEDBNttrKxWF1DP+SkYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071120; c=relaxed/simple;
	bh=qMnr3KPr9Xn+lfvxXZlzLkavCtcmOsXL2ErlM9xNhNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NA26Go99RA4P57GVI4kjEDpCATWngArvL8BhTKIAAk1p3eNF8uthnSiv/yrhOBanVaZR0vcP9Vh0eGJ9D1B85cAas7AQFiIrWlZPZqhZJsX6ZYAyE0W33nhz2ETGgkV9+/cDjHqirUleFldQXhpHvHtGRr6UROQvodCzMnnNkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmcmYqo/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fada2dd785so4606846d6.2;
        Fri, 27 Jun 2025 17:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751071118; x=1751675918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KmbYvv/p8QkJFOIHHC4rmh9tFFrEsA16VC6+yNOxFU=;
        b=BmcmYqo/JRT6fB9EhmRfqJ5EfUqIHkAwjpBkXcZJTRebsQfVyq9QVBepVU6C90hRMo
         VEPWYFRK1Ri0c5txlCCi69vb+6esDRqfk0sSqXSP/IoSYA9uY6d0SK2yx7Fcxrlv1Q0l
         xd6QrunwaBQcGGBV6TXqiUdlSdAaeBVIG5g7q1GseApaWmbOuBEfbRkTyxYs9De7Pd7q
         9gP9eKS97lvnpdqaT8MTgkDhNJ1gxVtk87lS5DBibxerWuMSuw7LK96pPWjJgXBo0DES
         VkHJmDAHMEbSaJV/EQhGCnPyDjjFApemSrydygLALT53nQYy0HbgwHiES6HaO8La+ohX
         /J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751071118; x=1751675918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KmbYvv/p8QkJFOIHHC4rmh9tFFrEsA16VC6+yNOxFU=;
        b=gNoAdl1RSMN0RRBlpr3Rb0fG66//Xm4M2H7gxR1srwBpg/eHOdl5oTVHRNZgLirjWc
         DlrH4KKjsXVDtl9G/gzEMfbi1hWvQDQTVRbzl/519rAiC87Wt6rGYEk2NvNxxQLts1Pa
         bA6+NpJs1I6EiVsJ9A+UbohlS+GVpTHxdzKMOOTm2pIF6mvqAVR74CATNAoe4pBXq280
         MSpQBQ+LFb38E60XncFXUQqtd7QE0XYZRCqnpROLXHHRNvgavxo5WR0RrljZof72BuSL
         sCPYXpOYVOv6RrzAfP3lbhjH+YhffuJZLPxUxOl95KMDGdvWzgQrowHXT6GSfMZVxBCm
         YkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nZAWNMwgWpwo4nTEXA7wxO3tPNSPOUqppDIHbw1qDj3c8r8ywfOwpJJOiprvdIvr8HUWE9Ti@vger.kernel.org, AJvYcCUf000A5yLsYP0yZrzLqH5PdjYCjQkRbufILpaWBoHSFQq+hca2MwbYAeO+e5+Bm6ICj/Cg2Bm4iuvoNtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtXd9naKa0wK1asXtFugf1wl0yBCtE6k7fzR3/GdntNdUObhR
	wX1KS6x5lcbml7iEsP4rltIsiRRTDr7wR4iKIEPBVCuM0W9WnQQEnLwOV22dxKcoJRzeQi1ruF/
	nOXmnDkRuumwqzwiEpY0kvABIm0EJwBo=
X-Gm-Gg: ASbGncsYnnggVld7g5RKILhY53hz3ByyaiiTkinMSry/go7GIDcmUqnenZzA48DNT7v
	V/7hNehrDyFMH5Qkf484ktm/OSiL41MxTXLvcm7xg/XDhioPmcTeQ1gcj9Xgk/u+11sOblih8hQ
	/rKLTojSG8FZsGIvRJrNp/DFs/1pJpQ4Pqc6+DWoJC7A==
X-Google-Smtp-Source: AGHT+IHeXX/ytyIIvpN2oIAb6FB+uwhRuxKdFeJOBggJqqTAJfOjXYxpwE1kJmxFrPksbUis4eMEEXus7Y5v6Tmz1/Q=
X-Received: by 2002:a05:6214:262f:b0:6fd:cbbb:b02 with SMTP id
 6a1803df08f44-6ffffd77b1emr97546376d6.15.1751071117860; Fri, 27 Jun 2025
 17:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410163022.3695-1-ansuelsmth@gmail.com> <aF7xlqRLXlZu0DZr@makrotopia.org>
In-Reply-To: <aF7xlqRLXlZu0DZr@makrotopia.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Sat, 28 Jun 2025 02:38:25 +0200
X-Gm-Features: Ac12FXxOGlOHKTJ_xVAxIcad2hrEhIUVAWgcdm3E86cKjX76u9mT4U48z3XgCjA
Message-ID: <CA+_ehUwzyEXvOj2J2vXaSj0tSsEH-+cktHLkSZ1ieeuK5+NN-A@mail.gmail.com>
Subject: Re: [net-next PATCH 0/6] net: dsa: mt7530: modernize MIB handling + fix
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

>
> Hi Christian,
>
> On Thu, Apr 10, 2025 at 06:30:08PM +0200, Christian Marangi wrote:
> > This small series modernize MIB handling for MT7530 and also
> > implement .get_stats64.
> >
> > It was reported that kernel and Switch MIB desync in scenario where
> > a packet is forwarded from a port to another. In such case, the
> > forwarding is offloaded and the kernel is not aware of the
> > transmitted packet. To handle this, read the counter directly
> > from Switch registers.
> >
> > Christian Marangi (6):
> >   net: dsa: mt7530: generalize read port stats logic
> >   net: dsa: mt7530: move pkt size and rx err MIB counter to rmon stats
> >     API
> >   net: dsa: mt7530: move pause MIB counter to eth_ctrl stats API
> >   net: dsa: mt7530: move pkt stats and err MIB counter to eth_mac stats
> >     API
> >   net: dsa: mt7530: move remaining MIB counter to define
> >   net: dsa: mt7530: implement .get_stats64
>
> After this series being applied I see lockdep warnings every time
> the interface counters are being read on MT7531 connected via MDIO:
>

Thanks for the report, I will try to fix this and post a followup
patch for this.
Also I assume this is only present for MDIO and MMIO is not affected.

> [  234.374708] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:579
> [  234.383200] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3667, name: ifconfig
> [  234.391202] preempt_count: 1, expected: 0
> [  234.395226] INFO: lockdep is turned off.
> [  234.399150] CPU: 3 UID: 0 PID: 3667 Comm: ifconfig Tainted: G        W  O        6.16.0-rc1+ #0 NONE
> [  234.399158] Tainted: [W]=WARN, [O]=OOT_MODULE
> [  234.399160] Hardware name: Bananapi BPI-R3 (DT)
> [  234.399162] Call trace:
> [  234.399165]  show_stack+0x28/0x78 (C)
> [  234.399179]  dump_stack_lvl+0x68/0x8c
> [  234.399184]  dump_stack+0x14/0x1c
> [  234.399188]  __might_resched+0x138/0x250
> [  234.399197]  __might_sleep+0x44/0x80
> [  234.399201]  __mutex_lock+0x4c/0x934
> [  234.399209]  mutex_lock_nested+0x20/0x28
> [  234.399215]  mt7530_get_stats64+0x40/0x2ac
> [  234.399222]  dsa_user_get_stats64+0x2c/0x40
> [  234.399229]  dev_get_stats+0x44/0x1e0
> [  234.399237]  dev_seq_printf_stats+0x24/0xe0
> [  234.399244]  dev_seq_show+0x14/0x40
> [  234.399248]  seq_read_iter+0x368/0x464
> [  234.399257]  seq_read+0xd0/0xfc
> [  234.399263]  proc_reg_read+0xa8/0xf0
> [  234.399268]  vfs_read+0x98/0x2b0
> [  234.399275]  ksys_read+0x54/0xdc
> [  234.399280]  __arm64_sys_read+0x18/0x20
> [  234.399286]  invoke_syscall.constprop.0+0x4c/0xd0
> [  234.399293]  do_el0_svc+0x3c/0xd0
> [  234.399298]  el0_svc+0x34/0xa0
> [  234.399303]  el0t_64_sync_handler+0x104/0x138
> [  234.399308]  el0t_64_sync+0x158/0x15c
>
> Note that this only shows with some lock debugging options being set
> and may not actually be a problem, but I believe it anyway should be
> fixed somehow.
>
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
>
>
> Cheers
>
>
> Daniel

