Return-Path: <netdev+bounces-250312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49937D285B9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 825303002878
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C864267B05;
	Thu, 15 Jan 2026 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I92j7Tnl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597F218592
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508224; cv=none; b=Ze1aVnhKL9jtGeduHpsFnqwOurUk0SpUV6m+zudGWtOId+Oi08itpeI3fGGxw0rUPbylhLvv08EQsjt+ZkKz1ZLSeFiU4YBHPLxR3giZNQTTaAGCL7JLuuDBGpUZ2dHld/TE5cCr3rsR9UY8lSObKrMrS9dizu0D9lHAPAStAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508224; c=relaxed/simple;
	bh=sr/hdWFQ9KkD+TzkczJguG2xe/t5a33rnbeMI16o8vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA6JOK0OTbh1oD4ekuI2mS9UPl9U0fgUI/4BVsKa7twD0/ZoaEwuTTOTgms/zW7ijBJWL+/g8x3O4HwxEVajOfZ00TtXciKzJvk3jdtAxZEiA8lzqjNjoIbdO7XJNAxXUFBfXlzPIro36qcPrZqZqbA9J0fdPBS6+AbtcuuDXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I92j7Tnl; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5eea9fbe4a4so498855137.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768508222; x=1769113022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhclwvWvzEdw1QOphaqNrn+NFyAYXreTgP2FFPklQQc=;
        b=I92j7TnliemfJnMFfkzH8K1qOtoPPhKuxyFWjqRGET/VEkq5JEcMZ2WIQWM2HYgvGo
         cEVN/5HRn9XNfKDIJRTxs19ysbUwamA+EaNaZZUWF7sEtNSj3U/gxsVCdgDy4/QsIDb1
         XVCRHbiuqK2I7gzq+eEWlPDrL5zMRt1lT2C16H58HkIybrJkp5dU7K++IyjaIdPOyT9M
         0vZtVtlKCO1jXkTYpbdh00zxRVczsEklcd6XeDz4s6poA+aTL5pDyfbfxD0iLnULMo/8
         Aog/aGXmLXT2NJNHSDGNK+XgvpfCVUQlwXR8FWzHe68Vx4LUSsyCqfEBO7hu0vQlKPSD
         d8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768508222; x=1769113022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhclwvWvzEdw1QOphaqNrn+NFyAYXreTgP2FFPklQQc=;
        b=tzxUjIUMq+GDNsupzLAtPN4eJ781RWk2vLnpaVAbf/fz44nB059NbTAQhg4v9IkKjh
         FfXdLZ5TKYu9dmjbV/Ty1zsurpLkbXvflO6aBgncWRcWPiFVpGN+OG/h40437KWSWrzs
         LeAXpR56AXBO/OptgSyr38tMgMSLuRtK1faByDhVRHeFPeCvBgoNEG0BuLybOomA6z69
         0Oly7YUFprs6yOYKnHCE1mYa2DziousyDMx1Nt1XZ1h2PL6kOp15y0U57EOCNcXj9CYe
         8M2OKVQbhc4TZt400WRWRr0LrIJa0wzEAjNEg+kP/VZnOsuWloXNO40rkJtveMzxKF69
         0BHg==
X-Forwarded-Encrypted: i=1; AJvYcCWvwbiFr3pDLfRp/WQID/m6pIk8cSZD46XuxC2XiNZfhnYNBIqaK5FEOMjZbHkZZZxw0XNTP5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRAtIw8smB1BERak0OeMPPFgymfS7oIdVc62ZfJXjAqMcPrmX
	WQ3TKyLim1K+Zy0PhshSRfPouPe/J0qYdUOWy4l4kVwiLYgyXo6XqPGTpclHeHzCP4phqjP4A7B
	hyVteU9tvpGNf7apPf/CX7coRCZxNfhs=
X-Gm-Gg: AY/fxX7KsVtKP5wDoo3OYgUXk3H1n6HAt+Vhy/PXBDimQ5KUU36S8/U077rNj32QriN
	sx4XgpY8Zws5DweHqMdKgIkeJM3xbxM8uUiAKTksP5SiyuI/fFEDOuVJWZ6UOamx0Y9f4FVmvNJ
	A1DEt2Kpe45a6krpxpprb/k7jPYuHvopeLnbXZ2wb/Vvg3xs0xWcsjMUbLyzasmBOe7nMj3CiMa
	5xarEWbLnFC8X7wG7ftXxQ6NXR1fRayirWI3as5RO+NBkrbaTS4Z3+mdpaEVrYfNSuGzjH2RR3J
	WboG82EIF7S00+nr/M5ZiYTD/opi
X-Received: by 2002:a05:6102:3f52:b0:5ee:a068:b349 with SMTP id
 ada2fe7eead31-5f1a53b0fc9mr385805137.15.1768508221761; Thu, 15 Jan 2026
 12:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <CAM_iQpXXiOj=+jbZbmcth06-46LoU_XQd5-NuusaRdJn-80_HQ@mail.gmail.com>
 <CAM0EoM=VHt3VakG6n81Lt+6LFzOVKAL-uzjM2y_xuWMv5kE+JA@mail.gmail.com>
In-Reply-To: <CAM0EoM=VHt3VakG6n81Lt+6LFzOVKAL-uzjM2y_xuWMv5kE+JA@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 15 Jan 2026 12:16:49 -0800
X-Gm-Features: AZwV_QiCf4MFAT586C7BvNoVP7RL0PfDmrffbC94GvHxKxhZrmwebHR7iUFKT-A
Message-ID: <CAM_iQpUGvHLB2cZmdd=0a4KAW2+RALNH=_jZruE1sju2gBGTeA@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me, 
	William Liu <will@willsroot.io>, Savy <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:34=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jan 13, 2026 at 3:10=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> >
> > On Sun, Jan 11, 2026 at 8:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > >
> > > We introduce a 2-bit global skb->ttl counter.Patch #1 describes how w=
e puti
> > > together those bits. Patches #2 and patch #5 use these bits.
> > > I added Fixes tags to patch #1 in case it is useful for backporting.
> > > Patch #3 and #4 revert William's earlier netem commits. Patch #6 intr=
oduces
> > > tdc test cases.
> >
> > 3 reasons why this patchset should be rejected:
> >
> > 1) It increases sk_buff size potentially by 1 byte with minimal config
> >
>
> All distro vendors turn all options. So no change in size happens.
> Regardless, it's a non-arguement there is no way to resolve the mirred
> issue without global state.
> It's a twofer - fixing mirred and netem.

This makes little sense, because otherwise people could easily add:

struct sk_buff {
....
#ifdef CONFIG_NOT_ENABLED_BY_DEFAULT
  struct a_huge_field very_big;
#endif
};

What's the boundary?

>
> > 2) Infinite loop is the symptom caused by enqueuing to the root qdisc,
> > fixing the infinite loop itself is fixing the symptom and covering up t=
he
> > root cause deeper.
> >
>
> The behavior of sending to the root has been around for ~20 years.

So what?

> I just saw your patches - do you mind explaining why you didnt Cc me on t=
hem?

You were the one who refused anyone's feedback on your broken and
hard-coded policy in the kernel.

Please enlighten me on how we should talk to a person who refused
any feedback? More importantly, why should we waste time on that?

BTW, I am sure you are on netdev.

>
> > 3) Using skb->ttl makes netem duplication behavior less predictable
> > for users. With a TTL-based approach, the duplication depth is limited
> > by a kernel-internal constant that is invisible to userspace. Users
> > configuring nested netem hierarchies cannot determine from tc
> > commands alone whether their packets will be duplicated at each
> > stage or silently pass through when TTL is exhausted.
> >
>
> The patch is not using the ttl as a counter for netem, it's being
> treated as boolean (just like your patch is doing). We are only using
> this as a counter for the mirred loop use case.

This does not change this argument for a bit. It is still hidden
and users are still unable to figure it out (even before your patch).

Regards,
Cong

