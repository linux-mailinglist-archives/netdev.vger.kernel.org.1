Return-Path: <netdev+bounces-76660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A1986E754
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E221C23906
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952B182B9;
	Fri,  1 Mar 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d6DDV6/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1A23776
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314244; cv=none; b=lakfQ2aTqEt6AsOsnSMBGstj1ixjs2NCOeeFuu+Yy3EGLpw4TQKPda+Jv7yhMUq68ekd3I7w2zn87rnpwrvzCkisvvf+N0BKSAIyA3dVMQVqraabd5ZRlSPnot3E284mk4qkpeye3X/IYx/LYgl66a6UO4KJtrn1B5v5NsYuYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314244; c=relaxed/simple;
	bh=ylK+D7JueGqF19SPnHZNe+5mxcvVGQNvmcj6EMAxZD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqzdp1DbgGqkn3LwueSh7t1k/tf9sd+8enk02fY/yoDk2d1s2kDZnNx/FFhShJQsD/uq3DGBGIvC7xjx9ju9ZCv4DaLxmE+3N6vKjtvE55e7daAy0rW/lGGKya7rb/+za7bYwR++cLMGTv+8SgRZ/DB2nPo41PrZNngQLprYlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d6DDV6/E; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56698eb5e1dso3299435a12.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709314240; x=1709919040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im9Umr2T85hMOmj0bpnRxcaABawqPpPhu4ZR7NKNsVY=;
        b=d6DDV6/Eiarm0bJq1DNTlh7R5wtoJ1ISKdiLl35Ys/jOwOfcieS/bmafgVOQVrkXeY
         ESnDnJkis662XNZsXul5BOhCtq55yO9ZIiVPwAB2TuZVEYRZm/SIxvqDJA6V9M9iJQZl
         9T+b9NmKN2s6RgXn4cDFSevOL2kfTYkO4/z+ceLX8eEzOlWcfDb9UICjw6K+kjB/i3Eh
         E+tW80Zd9ALMirEfyGDsOdlREIDyG4cV484rrH/5CT64fkpaKiq4ZEsgLt2K84pI7WjT
         GPOKDPvrhcN7rlmx7VPKSPm/UFdw4pEyJHc8EtNQeYnh+GiWdg8VU9bNhU8/zxZUWvSs
         q7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314240; x=1709919040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Im9Umr2T85hMOmj0bpnRxcaABawqPpPhu4ZR7NKNsVY=;
        b=rkDzcFceVYhB1r44pU0ngC2XM72WFuPLWgi62zKsbVkpsHz5NpbssYHjg/KjOPhGrk
         OEMCNp7mQjanphDtlH8cqlCenGxGrRo4TnVskuLzPKW/5xPHNtU52eQf1Dh6xqNA5ryl
         diSnOnPWlfvPk0uHMV9IdGDMqTOVNLHYdvJDk/2vGSHRw1p0hZj5rpO+sHR2REBa6s3N
         Oq0qgr7y1/RPISBfOHftfaKoRY/VCH51tizQLk6ePZ3oHAct4m51vKnQxCN+C7FwWqkL
         OHWC7TKyCr/2voBzK3rdLiJ5kp1MRj+vt9F7PTKDjGDutK5rh//e+Tjnnp7oSXlHUZCY
         iNVA==
X-Gm-Message-State: AOJu0Yxc2xkiqSIEwnAt6LyATwKyDWS2Cr0wz6eLCMXn10wV27WDwhpy
	yY6dnjRzfxzi8t5tiTA/DBuPyUPZ1gJDM53Mk7gHDtFhX9NRYJDLtsgZ77bAjomi4XherdgOFnM
	vl+M7G7u9H1jykuj79e0q6q202NK2/UBt+nhlVg==
X-Google-Smtp-Source: AGHT+IGYLJyhVjmMRjbUCITVxHrHFq3SYd6tnAK4qRR5cHKptQ5mXdPAN6On8sZlA3S5Bv7Ldr+4yWiPY5SAqyrDMao=
X-Received: by 2002:a05:6402:35cc:b0:566:f851:f53b with SMTP id
 z12-20020a05640235cc00b00566f851f53bmr334043edc.35.1709314240646; Fri, 01 Mar
 2024 09:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian> <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
 <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
In-Reply-To: <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 1 Mar 2024 11:30:29 -0600
Message-ID: <CAO3-PboZwTiSmVxVFFfAm94o+LgK=rnm1vbJvMhzSGep+RYzaQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, Mar 1, 2024 at 2:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> I could not see the reason for 1sec (HZ) delays.
>
> Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?
>
The trouble scenarios are often when we need to detach an ad-hoc BPF
tracing program, or restart a monitoring service. It is fine as long
as they do not block for 10+ seconds or even completely stall under
heavy traffic. Raising a QS every few ms or HZ both work in such
cases.

> In anycase, if this all about rcu_tasks, I would prefer using a macro
> defined in kernel/rcu/tasks.h
> instead of having a hidden constant in a networking core function.

Paul E. McKenney was suggesting either current form or

         local_bh_enable();
         if (!IS_ENABLED(CONFIG_PREEMPT_RT))
                 rcu_softirq_qs_enable(local_bh_enable());
         else
                 local_bh_enable();

With an interval it might have to be
"rcu_softirq_qs_enable(local_bh_enable(), &next_qs);" to avoid an
unnecessary extern/static var. Will it make more sense to you?

thanks

>
> Thanks.

