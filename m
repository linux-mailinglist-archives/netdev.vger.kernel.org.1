Return-Path: <netdev+bounces-227506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE371BB1895
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767D83C27AA
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B9E285418;
	Wed,  1 Oct 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSwN76dc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECE25A640
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344794; cv=none; b=Lv9vie5Aee52E9c+mqofICPu6gCMTa5ST+2S+hKFBukrOwD3IvTdAgO+XcTjvbUJK4xqsyFT3VFtZQaw6C/UVZcjFoq+fS+VoS90LIraInDxmTgPcTebJRWrkFuPYr+M22+0VHEH52c4HPQV84olA4J0819qTjdi0Hw66+IFNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344794; c=relaxed/simple;
	bh=Dq6UfPMQCqEBZX+otAh5+J79sRJLozDPqZmucnnBAi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMn5qFAnde4auH6knsBt4WSgc9CabmTebP74F6MSP+zsUMAwYkfycmXNv8hbzPx4ROqa/MMGbBRE0KA4tApyXm8CsGqHl8KEpKg72LI1kowGslu3yxFxlgZy5t1m8ak3w7OOHcVi6dkNqkCU/mOWRUQjQdKuEW2ceQwklOOMUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSwN76dc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5516e33800so243742a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759344792; x=1759949592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3kRQBYtBSvBEbrMe5qbWOmreAR4hdh7zqCKJgoYK1Y=;
        b=aSwN76dccdMPeyepKyEclQfpvehXrhONL5FLhQcX4s2oDHleTX2YAlLAV619MT5kjU
         GdVDCj4gkBQCUdRqo0U3tplj0CPue5nOpxg7Yz0A6agG5StB173xIAwnI7osfZpK24Bv
         i8NYse+pkU9Q+DeFwQD6P2sSHNdOH63fuaHoTwDi0gb9otSCWRZ25tu0grx+xIZ8yiic
         c9pckClx1b8fvMongs9zx2NDBdWHKy6tfWsHNoHTwrm0VHSV/4/duXb+xrFBbk/nYOb6
         pTQYslSPy7O/+GtyqWUb8pP9GbGLFUCFzoOjpVDU1M1/5B3wobC9hS90W4+upORSvr20
         bhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759344792; x=1759949592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3kRQBYtBSvBEbrMe5qbWOmreAR4hdh7zqCKJgoYK1Y=;
        b=DP77qlgHiuQ8fFPLR/1R8OwTZM50Xw46s+WIGEIod5+1jIe4JEsSEM4FgxDPkFKEMT
         eaB0hCfmX+62ZE4TA+LcDfG280lavDi2YKO/srJtlfBS13xneoPl0AtqB+WTzE55J2Y0
         Q5tLtid6Y0YVLq/wKrcaJLw64x+QT+T2t8EJtitmOktgD3eeDyZY+7DFI9AwkiVEvDhJ
         fsN0y88QTEIZupjihC63L/Hl6hUegQDEjRwdB8oFXGHXWRHT/ex254yziaQQpQ7KZO13
         Lb8iuWP7F6HrMAsEjw/RyW9N4Adu1wonaLYSBEPMdZjVCIiwHq/O1H64EP8ejP/wtBI9
         LEZg==
X-Forwarded-Encrypted: i=1; AJvYcCUVU5o8+odim3818BKA4KU//pc7Tbo67Qt9128Mouqp3/yQlMBLF6Pv5/1pMWaLERpZ8wxNYBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyQ4tANSDAQFPPTk1HdQS1AN8np4evISSDWL6EF61rJ6RsqFZ
	hKCNjUjOcdGjhHjfYdoRtAlLwhdfv8idZ4/n+kvF71m6PKyOClYJXtqrC6d1bgVJEL6GKFzCK3m
	nGcz5wQ==
X-Google-Smtp-Source: AGHT+IEMasXuNBSDleMooNxT9wAQdL2sSwx+alrYdaSzcqJWuzbM+Zz848Sf+C2BLKZwvS3ARYi2T4utLcE=
X-Received: from pfks21.prod.google.com ([2002:a05:6a00:1955:b0:772:744e:e65a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7346:b0:2dd:5588:49eb
 with SMTP id adf61e73a8af0-321d1a90630mr6306641637.19.1759344791893; Wed, 01
 Oct 2025 11:53:11 -0700 (PDT)
Date: Wed,  1 Oct 2025 18:50:22 +0000
In-Reply-To: <20251001102223.1b8e9702@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001102223.1b8e9702@kernel.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001185310.33321-1-kuniyu@google.com>
Subject: Re: deadlocks on pernet_ops_rwsem
From: Kuniyuki Iwashima <kuniyu@google.com>
To: kuba@kernel.org
Cc: edumazet@google.com, fw@strlen.de, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 1 Oct 2025 10:22:23 -0700
> On Wed, 1 Oct 2025 18:46:16 +0200 Paolo Abeni wrote:
> > Not many here. The above are debug builds, so we should get a lockdep
> > splat on deadlock, the logs lack it. I guess the request_module() breaks
> > the lockdep checks?
> 
> To be clear -- AFAICT lockdep misses this.
> 
> The splat is from the "stuck task" checker. 
> 
> 2 min wait to load a module during test init would definitely be a sign
> of something going sideways.. but I think it's worse than that, these
> time out completely and we kill the VM. I think the modprobe is truly
> stuck here.
> 
> In one of the splats lockdep was able to say:
> 
> [ 4302.448228][   T44] INFO: task modprobe:31634 <writer> blocked on an rw-semaphore likely owned by task kworker/u16:0:12 <reader>
> 
> but most are more useless:
> 
> [ 4671.090728][   T44] INFO: task modprobe:2342 is blocked on an rw-semaphore, but the owner is not found.
> 
> (?!?)

Even when it caught the possible owner, lockdep seems confused :/


[ 4302.448228][   T44] INFO: task modprobe:31634 <writer> blocked on an rw-semaphore likely owned by task kworker/u16:0:12 <reader>

modprobe:31634 seems to be blocked by kworker/u16:0:12,


[ 4302.449035][   T44] task:kworker/u16:0   state:R  running task     stack:26368 pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00004000
[ 4302.449872][   T44] Workqueue: netns cleanup_net
...
[ 4302.460889][   T44] Showing all locks held in the system:
[ 4302.461368][   T44] 4 locks held by kworker/u16:0/12:

but no lock shows up here for kworker/u16:0/12,


[ 4302.461597][   T44] 2 locks held by kworker/u18:0/36:
[ 4302.461926][   T44]  #0: ffff8880010d9d48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x7e5/0x1650
[ 4302.462429][   T44]  #1: ffffc9000028fd40 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0xded/0x1650
[ 4302.463011][   T44] 1 lock held by khungtaskd/44:
[ 4302.463261][   T44]  #0: ffffffffb7b83f80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x260
[ 4302.463717][   T44] 1 lock held by modprobe/31634:
[ 4302.463982][   T44]  #0: ffffffffb8270430 (pernet_ops_rwsem){++++}-{4:4}, at: register_pernet_subsys+0x1a/0x40

and modprobe/31634 is holding pernet_ops_rwsem ???


Was there any update on packages (especially qemu?) used by
CI around 2025-09-18 ?

