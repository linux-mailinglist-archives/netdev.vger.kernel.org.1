Return-Path: <netdev+bounces-227475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56202BB0593
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B95B4A288B
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E412EAB82;
	Wed,  1 Oct 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfhBiI6q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27631E3DDE
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321581; cv=none; b=nw+MiweKikb6O0Vh/5y8M04FLGHF1zlLByxLmxGg8C99AoHKjTake55sFRzWtIN2mAyTcMOQiyWgi/TFOz+ZNuDlZyebaSLBZCmkP4XjwmMNcDudT6/oO+2ewGfSrJqqlpyhH0pzFX3Ua7C2nvdy3LreRZIT1oZUJdbcREdTQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321581; c=relaxed/simple;
	bh=qy7txqkW5BSNHP6j1XZzAPzZUyZMeeypr7i2u3XbOBo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXeP+bBBhhu2o4uvkOi+KWwq8EwPLBoVV6HgZ+vx9xf2ZBYivuHu5mWV7yLrQbK+xOSMw/sUk6VwVkz2HkVMTp/bZmk1UUOkDvRLSbRrKWgXXWr4gi5OFc7/8wkT08uaMcy+HGdZFQphA3zukLNHZ9EktXEd8OSMXj46CNHEz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfhBiI6q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so4869108f8f.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759321578; x=1759926378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPoFH2OgXjiMR/517MdQhxgMLk7cY9ZkfsDrDGNqx3Q=;
        b=YfhBiI6q/0ps1qYbkkNEavc5y3qyTCVQQMDEiLvWaqDs/LKHkikWTDtlZSD41UgneI
         xiD4iyqEiP1Zp8ktEsaqbip0sNqIRXBApHcPXG+ik+UQDcxMTsDKlIO7AH4BBOOP1ubL
         pa9e4KwU20fafB5nkU7rCSBWVi11CoNKOG/A43rEUXZ0oTuPmJR1W1GuD/4jwYRKn5Dh
         tM2fm38WjEgzqHW3v5+Zmkr3dtDCLGMTMa98adNL91SbVYUJqPfC9fCeWFNiIW+7lWUs
         O0sEMJ4lVrjBC6g18SxFW8znT2Fd5k4ab0mUwmF3tX9UV9H0i+t5Ux7DxdkapL0qpBp+
         35Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321578; x=1759926378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPoFH2OgXjiMR/517MdQhxgMLk7cY9ZkfsDrDGNqx3Q=;
        b=S8IFzH3KNalaBIPGs6LF8p9FoZadnovIqw8yxukOvrZ/P76vcNPJlLO4x8NvstiI4w
         YqocbKdhoYO0xoeWciB8Sn7SaMkID/4XYhkol4tCUl5S2EpL2QRy4evn0l0hgjc/xaCH
         rg2vd9doHU8kW2ahRjAh6mTO1FTJQKOtJhns84ofG8p7s33HpKhpwt18QCRM9lowe9UB
         y8AAZzcgGiq9OJMBz05Lst8bt2XK+bLjJgJ1lrIKHcOXEPbv7kZandoHl4E+pXYmeP8N
         kOuF1TvTZUOL6H59MJn1A0q04lbM7RoceCxddTBA1mudY3f16L1mOFFCwBIDAxiPsH+4
         /1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhi/XpQTPd7P3gbgPotKb646KeQwFUdO5XGkd+lAGyfF/9Yqtq78ezttHUK1LpuJzznXJj5KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh/fKyhlafbC53vtWLjFcHZxT1ue/r2RK2LsEFTIjl73aDCMu
	KDKJBy2OxFMttlLQpFWiOV6DxAVr8N1t6NJzBIR2qddUfGItdoDTYKNR0Zbd5Q==
X-Gm-Gg: ASbGncviYECqA1luLndSi2OWMk/UIggjM9eGxuthoJ7nOsdPiZeIZE2UjX7WkpEvlbw
	yeD4QySt5OIRc+MFz9/erXgy9qPkJ4iGhPuyUhwqfI19h8/dh8i1OzSZ1GjdkIB49+kjIx6yGup
	jr8znNv7kQBSypBJLbIPFN2AgVHBF9Z2a3005We0sAIv3/ukE9er0E1X+pFvZJnuzMCyqeNQ4VX
	syVm5QYOHU7VGQDmn0/br2Qf7r/4HdiCe8b3Vk2OQ+W17KyzPwL1wQJpBJuiZbGrlEYVc63xJDi
	toZd+4IgUnaZUOEv+KgE0BYke371SC82Ji4cilx1O3bOCfeY/3gPmvAxJdLZfQ6KOlk/sK7+o+w
	UI73kgUwjpIiCYwV51T0Z
X-Google-Smtp-Source: AGHT+IFMxUehZm4RmBk35T4ErE35MfkeyTks80Tv+WCuRXdWd7WgPUOMXsBPsVBVvEuiXnecwU5VwA==
X-Received: by 2002:a05:6000:2408:b0:3ee:155e:f61f with SMTP id ffacd0b85a97d-42557803a43mr1866587f8f.8.1759321577941;
        Wed, 01 Oct 2025 05:26:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm26918628f8f.55.2025.10.01.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:26:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Oct 2025 14:26:16 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, peterz@infradead.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [GIT PULL] BPF changes for 6.18
Message-ID: <aN0d6PAFg5UTKuOc@krava>
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
 <aN0JVRynHxqKy4lw@krava>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN0JVRynHxqKy4lw@krava>

On Wed, Oct 01, 2025 at 12:58:29PM +0200, Jiri Olsa wrote:
> On Tue, Sep 30, 2025 at 07:09:43PM -0700, Linus Torvalds wrote:
> > [ Jiri added to participants ]
> > 
> > On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Note, there is a trivial conflict between tip and bpf-next trees:
> > > in kernel/events/uprobes.c between commit:
> > >   4363264111e12 ("uprobe: Do not emulate/sstep original instruction when ip is changed")
> > > from the bpf-next tree and commit:
> > >   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> > > from the tip tree:
> > > https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> > > since Jiri's two separate uprobe/bpf related patch series landed
> > > in different trees. One was mostly uprobe. Another was mostly bpf.
> > 
> > So the conflict isn't complicated and I did it the way linux-next did
> > it, but honestly, the placement of that arch_uprobe_optimize() thing
> > isn't obvious.
> > 
> > My first reaction was to put it before the instruction_pointer()
> > check, because it seems like whatever rewriting the arch wants to do
> > might as well be done regardless.
> > 
> > It's very confusing how it's sometimes skipped, and sometimes not
> > skipped. For example. if the uprobe is skipped because of
> > single-stepping disabling it, the arch optimization still *will* be
> > done, because the "skip_sstep()" test is done after - but other
> > skipping tests are done before.
> > 
> > Jiri, it would be good to just add a note about when that optimization
> > is done and when not done. Because as-is, it's very confusing.
> > 
> > The answer may well be "it doesn't matter, semantics are the same" (I
> > suspect that _is_ the answer), but even so that current ordering is
> > just confusing when it sometimes goes through that
> > arch_uprobe_optimize() and sometimes skips it.
> 
> yes, either way will work fine, but perhaps the other way round to
> first optimize and then skip uprobe if needed is less confusing
> 
> > 
> > Side note: the conflict in the selftests was worse, and the magic to
> > build it is not obvious. It errors out randomly with various kernel
> > configs with useless error messages, and I eventually just gave up
> > entirely with a
> > 
> >    attempt to use poisoned ‘gettid’
> > 
> > error.
> > 
> >              Linus
> 
> I ended up with changes below, should I send formal patches?

I sent out the bpf selftest fixes:
  https://lore.kernel.org/bpf/20251001122223.170830-1-jolsa@kernel.org/T/#t

will send the uprobe fix shortly

jirka

