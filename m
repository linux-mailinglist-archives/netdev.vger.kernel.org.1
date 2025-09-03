Return-Path: <netdev+bounces-219457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C70B415A0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815FE1B6226D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498F2D8370;
	Wed,  3 Sep 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOowhJkS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A627A900
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882415; cv=none; b=SD5/6Zykk+lyM1S4gqQy9O6hs7iEWgrUSLaWsRpa+WBMkY+PUKceHf0Uo2/0ECJ8SSEG14oEAu09/fu8as9z9EXldoF69RL6RDt4Cd7ojxOZwz2MrbvTIvnKlIqN8K2lerHZSMTefzWUxiDYYZ5jvrbmW+tMCaAbGXwpcj5Mttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882415; c=relaxed/simple;
	bh=8/udKkvrqwyXptm0wXQVuKYq5Iwf6OpzrsMGYjnoqPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD2weSCvlvgVCRcfrPlkU0DChbRPxPZf//zbs/llSRFQMjTEywriYEMpmi9a7DPcmar5tdesCZkgLUpKcc20/5hDvFnEPKWS+qfx/eyHATb/FO4rU2A9iIftci+96TFjO3SfH0gp09jippBtiehiDncgl+FjwSyK2Ypjndtzesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOowhJkS; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ed0be20147so57188745ab.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756882413; x=1757487213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp36T4NaDzQjVhL4NFKsibXqfpwHkoqX0HLDEK1B8L0=;
        b=OOowhJkSzdn71YRqzVhBj7ylb/H5fM0jQD74oGziceCKdEciYLpwsesisXJp4pSx1w
         lWHr1WcBSeG4yCaKWEJn6Wvhyo4YvyKc4Cjzp4BoB3KTRb6gHKdnQDwqcrHFwUVaJHT0
         ZhDSlAP4UVcgSSoOIts6u6WkPeVQxuERAafGWuGvDIRYiJCeZC/+3ilq63oKBZKq7Smq
         cEbwv329Xj03/TdrIND0zSQ5lSHz93sy6Km1MDjjKSzXQ1YM0Ee7rpGLmUIQGSyUL8au
         uadDaVjkeOfRvFbI81G941ViRDgQybvogvLl/90qV/SeJl45/GxoIW3f7kn+OogL0zZ5
         FdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882413; x=1757487213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp36T4NaDzQjVhL4NFKsibXqfpwHkoqX0HLDEK1B8L0=;
        b=kGYVRmsc4qLeXcvjmc5NoZ8mUU2f5mkh1sDuPVYIiaG7n39AVgn08UT1QrSexR4u0B
         2NLfIyXTxjrr5E1MJ12mDASowzF79yDBGPAY53nCy/s2Z8zJ0CeHiS0Onyx7UboeAdYl
         611NKm47kl3roe6lmc7ZIbzRsWd02WMFkP1RCs4jYiD6H6Qf7yUneNqJrFtQLdIUuObb
         BdGbjVPgR0i/m009VdZ6l7IyehKB4Tl7Q8a1nA3+KbmZphgous2ZO8/apeLAHbOSBji3
         2852oeO8zCTVZyakA5HwTzduxS5yrhoifzUVYH5PWuJEzzsOo/diJD/S8kDaAaJne6wg
         ILjA==
X-Forwarded-Encrypted: i=1; AJvYcCWD39KNLov5GJLtb6g/hpiznVMUcNALsZoUvBwxR0aJlv+rgkDuA+kbaynTc6pYtybFnIMRv2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0m2VOmNmJErhtPYy3A4UsI/IGe2mdf/Wdh2cbTl/GTEeWpB9
	Exh5Vp2/eSwol0GVv3erwT7Azb/T6vc+d/1QQm4wHoOi6KtLutupRyawY6+BXwtUJbKYD46nrAQ
	ptFl+D+izRH/b9ziheLYw/nbUlMZCMRw=
X-Gm-Gg: ASbGncs1ymcsg9EHL8YQaYIOAKu2YwqZ3+f8AEeIdbI1H54Qe5oxan6p0U8DiojKZ6f
	nS2l6SKUyRZLKVy6kUUUNGHccaS3eDSGnBZy+ScFOt7kswig+2/kRx7ISE59pFX0A835viDBA/N
	8g8/iG8orZhjfkvBcKAbSxrbJvt/33nI8Ubq5rSnW53l0sXZgnCVKBW1xQHIy3nF+IMlBRXH4OC
	7bKTQQQUq3kC2SL4Q==
X-Google-Smtp-Source: AGHT+IGmby9sdw57pBNoSUSr/UvjUL1aD+/l9qGBJeRa+uMZRHaUd7ZvoKC/D7bvXgle2wL+/AoifvohMja44tVWAos=
X-Received: by 2002:a05:6e02:1a02:b0:3e5:4b2e:3afd with SMTP id
 e9e14a558f8ab-3f4002883bdmr248375945ab.8.1756882413367; Tue, 02 Sep 2025
 23:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev> <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com>
In-Reply-To: <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 3 Sep 2025 14:52:57 +0800
X-Gm-Features: Ac12FXzFcscU-gwtKw3k52y5Zpu7tpf0A-Imnw_1lIFs9SuJij2_HWWM38S9ASg
Message-ID: <CAL+tcoAPdLYPu+HE=pA=T9T7J+b19Mg2BRgP3PM2d8_z6iXgYQ@mail.gmail.com>
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Eric Dumazet <edumazet@google.com>
Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, kernelxing@tencent.com, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:40=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 2, 2025 at 7:46=E2=80=AFPM Xuanqiang Luo <xuanqiang.luo@linux=
.dev> wrote:
> >
> > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >
> > Since the lookup of sk in ehash is lockless, when one CPU is performing=
 a
> > lookup while another CPU is executing delete and insert operations
> > (deleting reqsk and inserting sk), the lookup CPU may miss either of
> > them, if sk cannot be found, an RST may be sent.
> >
> > The call trace map is drawn as follows:
> >    CPU 0                           CPU 1
> >    -----                           -----
> >                                 spin_lock()
> >                                 sk_nulls_del_node_init_rcu(osk)
> > __inet_lookup_established()
> >                                 __sk_nulls_add_node_rcu(sk, list)
> >                                 spin_unlock()
> >
> > We can try using spin_lock()/spin_unlock() to wait for ehash updates
> > (ensuring all deletions and insertions are completed) after a failed
> > lookup in ehash, then lookup sk again after the update. Since the sk
> > expected to be found is unlikely to encounter the aforementioned scenar=
io
> > multiple times consecutively, we only need one update.
>
> No need for a lock really...
> - add the new node (with a temporary 'wrong' nulls value),
> - delete the old node
> - replace the nulls value by the expected one.

Yes. The plan is simple enough to fix this particular issue and I
verified in production long ago. Sadly the following patch got
reverted...
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D3f4ca5fafc08881d7a57daa20449d171f2887043

Thanks,
Jason

