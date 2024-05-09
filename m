Return-Path: <netdev+bounces-95029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A48C1445
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C204B20DC4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AC77109;
	Thu,  9 May 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxjG3anD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3E770E5
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276763; cv=none; b=dah2nuvYgONABh5tuHAckQELOjJ7PHSx+gu+LhYExkQlSOPNHuMcWplcopKuXjzBRX4CY9wB6P5Qs2bVP2PqLbcLm4B+s1IeKySKirp0IvMp7heQ5XoZxkHTfQq2o/AqfA+T1EEBH2gaQEUyGRBD2Wgy9Epe+a7Mi1zs2Y8fBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276763; c=relaxed/simple;
	bh=/oSWOWjkap8fv/UuIsI6Isx0EXquObmcwzLznfIJKkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlcXOxukjJH1Z2odCciDVAFQ7wykaTAm3WdPOmhFxxshwqVDmBKjLeNFW2oTtd1nkGVLPFe8pvMoJWHJH62hKHvHPStMMO5Cz3jCODIB9IR0JQfw0anppbcKxHnND+VoVHWHNX87BGBnn42aVNuZCUmffrVp3LtfMnPMUfX/PWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxjG3anD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso1542a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715276760; x=1715881560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9dUf6h0ZONDc1o4IvKX4JCSR1LfcFcW4NQit96LWug=;
        b=fxjG3anD83hFoJAGJtRblIDGAlzmSLRG8ntKPrhQt+HieXxnkLfNrfeXZDA4DRCfMe
         sREmIk4QaB74Bb5+DiGkytekIaBjk/rvNTyhi/v/+B08R+Q8xkpAkxzNLVstuVDGDd25
         GEmOAe0DeZO+QlgQrqL3aR3rKTQi9U4Emep9ofkbHs2DXyOlZ4NdO4/806fVK2YkNxcS
         68XAqfV/h5ZcRctT01utJ8bJz8tN/N7w4zhbOHBNLRylB0WWfQX5euwEKpNKnO8tR0BU
         G2FjQBn80cFSqwU79je9zjjKho3HbMYZc8xJ1oeIamcwBM68P2fSXUSvRXeo5wFqsQOv
         z1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276760; x=1715881560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9dUf6h0ZONDc1o4IvKX4JCSR1LfcFcW4NQit96LWug=;
        b=xM5fBo69lJay4fTiSsjiNoPfGynZv/DoDkHD2EzFaiYf/u8S3Iw+/oruHeNOLg6Ou7
         N4BCMRP788KkTjC2c8dIzLqlZUjHoZfp36zeNNuz+J/KLZzcdu8UnpV/7m1mHv80WMWY
         wVIpN0wJ5TleRhTc8rLzkEL+5EUB/rNYr/lAJ7zslnRZono16sBarWFyzXauXQUcOxic
         xjwOfPfqAREaFYAf5q4jkeGh6f9TDkm6OksdN7yBgbydxZYFiGMNQmIxqJa+2B2XksXz
         JY1K9vjR1Rm3Bmr50YLBz6Av4a/TbSsYHm7XsZMRKm4TAGEFsDr5Pdw4eWHaS1VuTKVs
         q86Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/aT6+r4Bie+c9CAL4JSwYBLJCyiMUrFidRfxhgdk8vvMoomPmU9kNnbO1kmW1jCCdhgHAqF+UMoOsoh9XYcRi+sWV3jy1
X-Gm-Message-State: AOJu0YwMt67pXg+3eUu5yBKwx5DlOlKi77W4xVFkUmHOIRj7874Yp3im
	uRYrhm0A6JlEq3Rxy+C8vPtArSFCjh1JVfueea/dwA6vqyl0dlTMjRND1RRLVbBLo2FsN8H8QIJ
	y+WiL8D8hT45XBVPMarQvyjKl5L2HVQu6A5oK
X-Google-Smtp-Source: AGHT+IFG+qZVP+GdGsJ0bfuXNwufKAJIRBglqYr60vsLU06TQKxk62S9P+fDwyd1v4jS3rVgg+dEQp+BJ2xOYW96LJk=
X-Received: by 2002:a50:cac7:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-5734f8fe9f6mr3018a12.6.1715276759326; Thu, 09 May 2024 10:45:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com> <f4e45604-86b0-4be6-9bea-36edf301df33@linuxfoundation.org>
 <CAG4es9XE2D94BNboRSf607NbJVW7OW4xkVq4jZ8pDZ_AZsb3nQ@mail.gmail.com> <946ae22f-a4af-448a-92e1-60afb6ed9261@linuxfoundation.org>
In-Reply-To: <946ae22f-a4af-448a-92e1-60afb6ed9261@linuxfoundation.org>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 10:45:31 -0700
Message-ID: <CAG4es9V2CcBJr0josSoGNsD+ZPQ6vasVXh_Hc_j88oeSqn__yQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Seth Forshee <sforshee@kernel.org>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-input@vger.kernel.org, iommu@lists.linux.dev, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 7:37=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 5/9/24 00:13, Edward Liaw wrote:
> > On Wed, May 8, 2024 at 4:10=E2=80=AFPM Shuah Khan <skhan@linuxfoundatio=
n.org> wrote:
> >>
> >> On 5/7/24 15:38, Edward Liaw wrote:
> >>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> >>> asprintf into kselftest_harness.h, which is a GNU extension and needs
> >>> _GNU_SOURCE to either be defined prior to including headers or with t=
he
> >>> -D_GNU_SOURCE flag passed to the compiler.
> >>>
> >>> v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-=
edliaw@google.com/
> >>> v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
> >>> location.  Remove #define _GNU_SOURCE from source code to resolve
> >>> redefinition warnings.
> >>>
> >>> Edward Liaw (5):
> >>>     selftests: Compile kselftest headers with -D_GNU_SOURCE
> >>>     selftests/sgx: Include KHDR_INCLUDES in Makefile
> >>
> >> I appled patches 1/5 and 2.5 - The rest need to be split up.
> >>
> >>>     selftests: Include KHDR_INCLUDES in Makefile
> >>>     selftests: Drop define _GNU_SOURCE
> >>>     selftests: Drop duplicate -D_GNU_SOURCE
> >>>
> >>
> >> Please split these patches pwe test directory. Otherwise it will
> >> cause merge conflicts which can be hard to resolve.
> >
> > Hi Shuah,
> > Sean asked that I rebase the patches on linux-next, and I will need to
> > remove additional _GNU_SOURCE defines.  Should I send an unsplit v3 to
> > be reviewed, then split it afterwards?  I'm concerned that it will be
> > difficult to review with ~70 patches once split.
>
> Please send them split - it will be easier to review and apply. You
> might as well wait until the merge window is done. I don't think
> anybody would have time to review now since merge window starts
> next week.

Sorry, I have them split already; is it ok if I send them now?  I will
be on leave soon and may not be able to get back to it in a while.

Thanks,
Edward

>
>
> thanks,
> -- Shuah

