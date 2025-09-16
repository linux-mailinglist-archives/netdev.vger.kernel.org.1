Return-Path: <netdev+bounces-223324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52444B58B8B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082B43B4B0C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497FD229B36;
	Tue, 16 Sep 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7jrtFBe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D4223710
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987741; cv=none; b=kN4mCpdKzuHt/TcfsMr6VaPAKHRGPoV3X8ugUE9X2x41ImfMBTK/7LWfxaNdcjFS4NZSoDBakXSLMTvIf0rCoeXf0zRa0Zz8eVpe1fB35uGBQ12GiOt4VP7ho6daTEiOCNKBVNtjTkmv0u3ByL9UNFkmXOf0ttKVuwnEYoDLnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987741; c=relaxed/simple;
	bh=jep2u5VNTk538PUR4KP/b48BjYybUEbcPCBXSSZj1Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0ly1KPgSuDkY1EwhB0jU7hiGsC6xspckYp2JsGo/hQUJ6c2PV0YTEdvFEO37snap3W4s4LKiM6B6DdGf7VGVrOyz/eyW7x+shXGtCVtzwm6cBiWTV1yLUJw3RWSKQ5QsTnhimPwQ6kf9zC3Y+UulX7EAdT2iWVhBqgcOAT1wM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7jrtFBe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042cc39551so817574666b.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757987737; x=1758592537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JiJuCf5fDbcsVFqie8KviQvSHh9fw4OMPm4D25E3/I=;
        b=L7jrtFBeKsXLrJDFDYYmH2CyVHVGaP7NniIcPoVRTVVLg7SFE9957XIvhw3x8MgICw
         CDpPEd/EvkXVp9dPXf1Gt53xcIN4DTYeAO3uejVWSujOZM9uyd36wYS6GMlsLZdT6UnW
         7HYKpyB74OKpRCums2wzPDgp4aCBWP+hhOmTDPahklmaFkFJaDxaUqwpTMnEWIL4wYhJ
         k8ZieHGQYUcarek1roI9rrQRmip+Wz/0Zk9V5+eJJVC+HOOwSnB/dSpO77nC8RzFxzfd
         F72+Hx13bHOcSLWvv/YOj3CYWyDS3b7dhzjLh+XgHPDoLwdjeuc9OBclZHONhptg+yB/
         j4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987737; x=1758592537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JiJuCf5fDbcsVFqie8KviQvSHh9fw4OMPm4D25E3/I=;
        b=NYvDzW2hjnBizg6r4nFibJG2H3J4YPRnqmmjFhDRIPpHgJl1ooYb7M8h00Xv8D20sC
         Kr7ExAyiiX1l115RDZ4OBqgJBC0R4u5b8kh831wSh0UlcJotdTNxowT90OWq+KHzWNTi
         XzxuxbVSnaI6/ItcGyXY/lHsUMt4jnOcSnq3RZl+8giuRG86OB7TGEXVUzL+v9zYqbm4
         pr2PC0trvPaOyHJr3+3WSV3K4WD1ue+VtsTwVIur2vQ91Oot/yiQzi34sOMxArw94Ztc
         ct7t6eDNK8fbg4HdgR0dEcbwZOiqoNW3RLuS+kRCeqBUd8jnfQT23WUhR27EbIirDo/n
         OXgg==
X-Forwarded-Encrypted: i=1; AJvYcCVxbe4FcgtfrIBnmgengYFQhJ7GgzI8iETXY47uzCpJuape8oHn4DFFb9+G4dwBag9gNAIRC6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKTRlpINAm2m1+Va3lte1jH/JmNH1IZ3hb8gPFbxlTgRCrchA
	2xmt3zLdNOZ/DOfA42Kqzs8ERm8SMXRArAFgM9hbEOmRqI7UcECxQbNyBeWqr0sC0QClhFpvqg8
	IF1++SeMLw7+NpRjG7FXsjYZjmle6zU0=
X-Gm-Gg: ASbGnctWLomKmmmh6AZPYiaTwqRezjGSTWhKK2LbkFtKYgmBhK+2D3zrVjyWKij3MJ8
	YDJhnK9uX1YmYxUzv1AFxEWrD5KVrvWNBrYgE0tma4RQ1ghiEEykwEEgmThEflcY6uuqhZSNMKy
	EabTTs4krAnh+SmxY5sqnNLbJ5KVtDFvyZkMUMC6PmeDiFatu9hxAnGoXG1iray/rHAJwzF736/
	9IX0s1Y
X-Google-Smtp-Source: AGHT+IHJugXW7PgqM4C561Es6pZ+yMEeghRxxr249HgOnA0uY3PnwVnYPJp7RZWq/M8Ro+g8NAKFEnS73k9uc/Q2N9g=
X-Received: by 2002:a17:907:969e:b0:b04:6c19:ed8d with SMTP id
 a640c23a62f3a-b07c35bdfa1mr1378153066b.26.1757987737286; Mon, 15 Sep 2025
 18:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915134729.1801557-1-dolinux.peng@gmail.com> <20250915144052.VHYlgilw@linutronix.de>
In-Reply-To: <20250915144052.VHYlgilw@linutronix.de>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 16 Sep 2025 09:55:25 +0800
X-Gm-Features: AS18NWAOIt4gv03twwvlmnUbxI3Di3y_xFKnQycCNlJ75R-ks7_KB2ty8Keq5J8
Message-ID: <CAErzpmsW7=3RmLZxByxVD+vD=FV0YDF6POHVZZce784r7jMQyg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com, 
	ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com, bcrl@kvack.org, 
	trondmy@kernel.org, longman@redhat.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-s390@vger.kernel.org, cgroups@vger.kernel.org, 
	Hillf Danton <hdanton@sina.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:40=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-09-15 21:47:29 [+0800], pengdonglin wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
> > consolidation [2][3], RCU read-side critical sections include:
> >   - Explicit rcu_read_lock()
> >   - BH/interrupt/preemption-disabling regions
> >   - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4]=
)
> >
> > Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regio=
ns are redundant.
> > This patch removes them, simplifying locking semantics while preserving=
 RCU protection.
> >
> > [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU=
/rcu_dereference.rst#L407
> > [2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.=
com/
> > [3] https://lwn.net/Articles/777036/
> > [4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@p=
aulmck-laptop/
>
> What about something like this:
>
>   Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side
>   function definitions") there is no difference between rcu_read_lock(),
>   rcu_read_lock_bh() and rcu_read_lock_sched() in terms of RCU read
>   section and the relevant grace period. That means that spin_lock(),
>   which implies rcu_read_lock_sched(), also implies rcu_read_lock().
>
>   There is no need no explicitly start a RCU read section if one has
>   already been started implicitly by spin_lock().
>
>   Simplify the code and remove the inner rcu_read_lock() invocation.
>
>
> The description above should make it clear what:
> - the intention is
> - the proposed solution to it and why it is correct.

Thanks, that's much clearer. I'll use this commit message in v3.

>
> You can't send a patch like this. You need to split it at the very least
> by subsystem. The networking bits need to follow to follow for instance
>    Documentation/process/maintainer-netdev.rst

Thanks, I will split this into a series for v3.

>
> and so on.
>
> Sebastian

