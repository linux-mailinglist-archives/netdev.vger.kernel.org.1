Return-Path: <netdev+bounces-186220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00BA9D76E
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 05:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1DE1BA46B1
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8141C1F12;
	Sat, 26 Apr 2025 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJhqMsep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5984A35
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745639609; cv=none; b=V3nyD8PgDv3Euz6z4n6lr5fr6pz/KKuQ7RkICL1gl+cw5EIMYjxczvf6W3o0bFzgSHpRjZAMDLbRy46kEO32QFvofryE9x9AjeMJUKuDjIJooL11CQAHw4Ci0CYccPWZ0g+Ilyp6LICBNZEiQeLlYjVIpHiuV/+f2joU6vZZvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745639609; c=relaxed/simple;
	bh=e1frOWqQBqSr4la6jMb5N/BAJnnMixdSvnU9l2lgH/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEANA7YQPFwcTTWneZ1YYK9n36Oq2h6wvYakYYnQwwkSogNB/K+yErwzQc4VGKpwlAlLreBcsP4E8L5Bm1k4reZV1zUCmTv5u1cFKfGHAiKpmedsxN4mmp/473eR4bCIU66gOKaXckYYcBISrx2a7v5BOhNpIBQwVBT2NP1WADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJhqMsep; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240aad70f2so94225ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745639607; x=1746244407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHJQMCfQnCTUldZPJaQ4kHEgRJ+XJYExi6HhUb5fO14=;
        b=mJhqMsepaoHI7ewI/fHYArNZujJCO5QQM+lGtZcBuodBdj8OnoDNp8BLlNctOgr/Xx
         Z5yX62rNzQgmTNsl/wsAIbJ9gqaUvfWCUqA+CNCj5vnrODUFig3r47dcMY53UBH5TKxy
         vdzCCsDnTG5or2BrnqMD5koA/3FKMIYC6tqe5N9FEkctsWhCRf5aO5dihYdWkKbtaio/
         1VxSrSz8TONOzR0f72Yy/QdPgSIzbXslWs/DynXkyQiUy/DhLG5xCP9crQgKmaANme1G
         UGfT62PCW0Wkt1CormK3YNb+I4eN/w08NOdqBBkpI5EATl15fq+TSmYBCBQfLzqLqxaj
         PBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745639607; x=1746244407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHJQMCfQnCTUldZPJaQ4kHEgRJ+XJYExi6HhUb5fO14=;
        b=YtEV1Whdcm+vxhzT5o63j3cvvNx3VuXkABbiqAKbwtbFq1Snaw067OGVdAqZ1LA6vV
         rrxPK+SKxe5bSv2V7v9Zkd37XfDJPT4F33Mm6x8AObO06IizsvLaPd7cWCxNQRDixk63
         2D4FUks75ixnKp4Pm/LWE5OuhXbPWEHKIMDbvghWINZW0rWnUWqrXBdGPOW/JbC4eMl8
         NxG8NmmAMsRy2yCn5QUB17Pwaai+LOr34BVl4PEIPRq0k36x/ytPtdMEXR8Uuxa0eXx8
         ye/F2gUs0/5DvzjAmxdvYA21cSLWvi47+MGynRHwtgGX51rZRX4srA62SDrvktYcej98
         bPRA==
X-Forwarded-Encrypted: i=1; AJvYcCWwzFHo0E2mgGuGHW224MwAq4N/lhrCfXT4IGewLR9EZ4BpKAWjtinD1U8GfwjwL2r8ODqY7kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlmHs7ma60MOpe0hbyenr+JFECS8xDfpFSnHzyBawyLFF21i/
	FZiFSybDYN6jXDDFzfNSWwO5G4ySAaNWS2g/NToQRhu/7kHQj+AjPBFGOwB28ptNn9FhIulRYIW
	yXdHqljZq+oOJjiBRbnRNwiWZbHz3XEAUbjN1
X-Gm-Gg: ASbGnctp6hHA6bQCXOmyfD+64mPB8GgnsCIGK5hdZABUNYbckVCLPpXKJJR8x6WtewJ
	et2VFxqZGs3z+EepVagTycxUVLUyC22fmRkffFfPZHKG7YosDZyDCXhFTBYJ9ohpmeSsOUMIYIP
	1FLaTHATjOU6T/D/NcY5F1ywqjdxm01Bb001lWSyBmFdRgwlJt565xtM8=
X-Google-Smtp-Source: AGHT+IFI98UaAu2e0f23jhXgY6ahs42wCGXoLX3gPBmbHEdbls2VD4/Dd+j/PRhFQKbXZG/28DQs43wsAgfv5CUiCOY=
X-Received: by 2002:a17:902:ea12:b0:22c:33b4:c2ed with SMTP id
 d9443c01a7336-22dc75fc751mr1104145ad.26.1745639606895; Fri, 25 Apr 2025
 20:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423201413.1564527-1-skhawaja@google.com> <aArFm-TS3Ac0FOic@LQ3V64L9R2>
 <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
 <aAwLq-G6qng7L2XX@LQ3V64L9R2> <CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
 <20250425173743.04effd75@kernel.org> <aAxGTE2hRF-oMUGD@LQ3V64L9R2>
 <20250425194742.735890ac@kernel.org> <20250425201220.58bf25d7@kernel.org>
In-Reply-To: <20250425201220.58bf25d7@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 25 Apr 2025 20:53:14 -0700
X-Gm-Features: ATxdqUFyKh1VTmNXCA-Vu6_5Qnzs9xb6qRlxCTzBUjS0n5YY1jTLb7T6euy8yoE
Message-ID: <CAAywjhTsPXtKGQejc_vOWzgF18u9XG74LzjZeP9i3TQGxUi6NA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 8:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 25 Apr 2025 19:47:42 -0700 Jakub Kicinski wrote:
> > > > I haven't looked at the code, but I think it may be something more
> > > > trivial, namely that napi_enable() return void, so it can't fail.
> > > > Also it may be called under a spin lock.
> > >
> > > If you don't mind me asking: what do you think at a higher level
> > > on the discussion about threaded NAPI being disabled?
> > >
> > > It seems like the current behavior is:
> > >   - If you write 1 to the threaded NAPI sysfs path, kthreads are
> > >     kicked off and start running.
> > >
> > >   - If you write 0, the threads are not killed but don't do any
> > >     processing and their pids are still exported in netlink.
> > >
> > > I was arguing in favor of disabling threading means the thread is
> > > killed and the pid is no longer exported (as a side effect) because
> > > it seemed weird to me that the netlink output would say:
> > >
> > >    pid: 1234
> > >    threaded: 0
> > >
> > > In the current implementation.
> >
> > We should check the discussions we had when threaded NAPI was added.
> > I feel nothing was exposed in terms of observability so leaving the
> > thread running didn't seem all that bad back then. Stopping the NAPI
> > polling safely is not entirely trivial, we'd need to somehow grab
> > the SCHED bit like busy polling does, and then re-schedule.
> > Or have the thread figure out that it's done and exit.
>
> Actually, we ended up adding the explicit ownership bits so it may not
> be all that hard any more.. Worth trying.
Agreed. NAPI kthread lets go of the ownership by unsetting the
SCHED_THREADED flag at napi_complete_done. This makes sure that the
next SCHED is scheduled when new IRQ arrives and no packets are
missed. We just have to make sure that it does that if it sees the
kthread_should_stop. Do you think we should handle this maybe as a
separate series/patch orthogonal to this?

Also some clarification, we can remove the kthread when disabling napi
threaded state using device level or napi level setting using netlink.
But do you think we should also stop the thread when disabling a NAPI?
That would mean the NAPI would lose any configurations done on this
kthread by the user and those configurations won't be restored when
this NAPI is enabled again. Some drivers use enable/disable as a
mechanism to do soft reset, so a simple softreset to change queue
length etc might revert these configurations.

