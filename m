Return-Path: <netdev+bounces-76462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F786DD1E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E91F22887
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1ED69DFC;
	Fri,  1 Mar 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGXprctB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364AA1E886
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281846; cv=none; b=mXZoaDEAhMs6HKwg0U6ZRjbyw0ApRlA0Yp1GDnxopFsgN05r9sW3Lup6jYIyxY6UEp2DfIeE/GBMegFIN5CjqE2ktzJZwtc5skBkuM7ENLtrWZERimizNyiy7yX1nAMQ+t8dWDmFAz3mM3DXZFcylttVskGJZ7omAtgMILo+XcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281846; c=relaxed/simple;
	bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDd6k2oL9Vp0EB5SGyIlaqWQefIgk6OpPodr9FiaSeil2O03/dwqeudOQj075Z59BVrn5hwl6lg5+NKL5yCwGofIWN4me35tgGiceImMB3a6L/jtesTHuLmXc2IpFKnPUit7o0hdZng6KD5Vd5wgIVep7Fphn6MsK1umjmxJ+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGXprctB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so4036a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709281843; x=1709886643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
        b=rGXprctBDcRXELGRZjuJjUglDPm4/EGZQqkhXTQ/CVqpVjQ1vO9ClIB8VJjDsvvzP1
         tHuX1uKzcss99uesUQNo9NHEU9IyAb9Shd9sh/E2QYacSWlO6ZzpeUxa4+7s2f3lkUv6
         uQr7OSexv1DfIFUVmSmu95u9vPNExqqW55M57ibHkpn1sLBhaT62BIm+Rrm3mM9IVCwh
         bKpWGSSKogKIJo+g+yM20PUXg8Qmx0NQvWzXdFNTQUdvETtkym/AJrv12ylTlsF2IinR
         S5kIL44DHvqujGfOKlT0HHV7EH7j3nYIASHUxNMZ2a6DIV/G6WJarQI/8oo18olAoMni
         MALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281843; x=1709886643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
        b=xRcYopbwYJeys8NEUwBC1RAStDvPhzsG3N6MOz4yWqoHGv3VYgrilSOzbEJAFPgi4o
         39JZ6iHVBpwVY8qBWNOtacHuYb01L7e36YqYlqUD45CdlKe6sTi2gy0jOfIlSo5/Y0AJ
         UbVJbiNEo80kehLB3v6VI7tWVUAzRUtxj5sY1W2aCDEBz2fo4RLFysRNPSDlcc+jEbTY
         qpC/Xp0tkwp2aqKkDGExmav67G9kQ4jTuDth7FearKmzGZ8NX6bzHsBauWMwKkT1ClG1
         gLQb3tKgspDPdzjKor228uzjLN7f2mLV5JQ5HSQCX2LYG7UE5jcioF+AezDLfvdHbMAv
         qMJg==
X-Gm-Message-State: AOJu0YzFsPOEQkoC/H8cG288ml/Bm4Kd4u07Iw+Ojq+M2oiBBnaNGapT
	RBLnl+e/FreuDqgvJXp2EXLQQZj2oAAYeK3/Q0LDxtXu4GBCn4RXcV3wVJ+C/Tz2yjyAotgKf5n
	krWMKvOskNbrWtiplEe+m9STQHgnMVO6jlGQH
X-Google-Smtp-Source: AGHT+IEwf1M0NlR4bQMpE6O2swlKwBptVLThyMgoIRxdaxLQgX35Cs6YnZnFaBd9av2rZ/03Z91FM2azqVxy5Ou4Vt8=
X-Received: by 2002:a05:6402:b10:b0:565:ad42:b97d with SMTP id
 bm16-20020a0564020b1000b00565ad42b97dmr90989edb.0.1709281843426; Fri, 01 Mar
 2024 00:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian> <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
In-Reply-To: <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:30:32 +0100
Message-ID: <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: Yan Zhai <yan@cloudflare.com>
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

On Fri, Mar 1, 2024 at 4:50=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote:
>
> On Thu, Feb 29, 2024 at 9:47=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > We noticed task RCUs being blocked when threaded NAPIs are very busy at
> > workloads: detaching any BPF tracing programs, i.e. removing a ftrace
> > trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> > ranges from hundreds of seconds to even an hour, severely harming any
...
> >
> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop suppo=
rt")
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v1->v2: moved rcu_softirq_qs out from bh critical section, and only
> > raise it after a second of repolling. Added some brief perf test result=
.
> >
> Link to v1: https://lore.kernel.org/netdev/Zd4DXTyCf17lcTfq@debian.debian=
/T/#u
> And I apparently forgot to rename the subject since it's not raising
> after every poll (let me know if it is prefered to send a V3 to fix
> it)
>

I could not see the reason for 1sec (HZ) delays.

Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?

In anycase, if this all about rcu_tasks, I would prefer using a macro
defined in kernel/rcu/tasks.h
instead of having a hidden constant in a networking core function.

Thanks.

