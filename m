Return-Path: <netdev+bounces-199313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EE1ADFC4D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518DE3A849B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8623C4F5;
	Thu, 19 Jun 2025 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh1HfRYm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32D18D643
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306797; cv=none; b=Ex0Ok0C0mjQrrHQGsYKuinCPlay9bQJJcBLdrWZCLhNVLNL7GsvMchl+2cq8jvnmvjgAiXHV3h4BBBBpD5AbTBZ+/U7uH47N9GBnkJpHp46cSO/suyhA1eHh9gZ6pUHVasc2R7BLg0MA9ggVYxC1F70QBBxSVT39IRMZu1GX4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306797; c=relaxed/simple;
	bh=42+ZcWihADi6feelct3b85p6eGrRRLvD+RD7THwAKIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kciJiyRv67aeUjxHDFiuwpqHsidpJCj43Y3CSL3ikZEv8YwPrI4juytR4kYmLe8p0AVgyVuHpIPpvUJD4kAqEqOGwQe8HX+x48c9mUi2r6sxY7Yi6kp45VNmIXktGZZTWMCsB4u9N5Hb8Krm4BlqREoeaDhb7uLoVh+1Gez6/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lh1HfRYm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235ca5eba8cso93715ad.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750306795; x=1750911595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdPPLCnOw1JLV4SAcVZKzEB7UTqx2yTdOYlcY0aplos=;
        b=lh1HfRYmZOM7QoSsVjJssw7UGIlzRCqGywIXld6UFxwME6B+JaMhB3KyPP0RxWBP8u
         FqvbGul5cJyTmDTTCCmcpa1Hk091H0GbzLDlrgiBqkCbV769ozj35bjGyRkYmX2iWL5u
         7e+oTA3ghvmJQF4MK3GGHOt7GCjYqICINowCUBBOtpl5ZQib4JhIEJ+rRKLvdSnBlTI9
         +Dp1n6Xf6G8tU38uUi9f2MelY/xSXgfcTXW3Y+Fai1y/FlGoFxnyKFvHfL7AQxDzTxDP
         asHjKzumuPpOyAyW6oW6kzNt0D8QjqBcVsSx8v90HPvJ1oLoinVh4lTTH++PkmcM08G8
         WyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750306795; x=1750911595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdPPLCnOw1JLV4SAcVZKzEB7UTqx2yTdOYlcY0aplos=;
        b=SYlpWPvXq5QGAL7BPIe+H+xXUyjzqHv3V0FRPDDB+L70N8kdWZ68u3SSVBAChe31ra
         bGzFYMjxoCGTA0qQZa3jDVM2cF1QpZIj0IdASSyEw7pEqTNxccbBuy8y94UcmCE+Yvc6
         QG39/KJGOlD400adl6FVtVT4rc+CXywYYee88+QLWrJE1VGXW960QKep3pckgn6Fa1us
         DkRa/m0QDC8YYA9VKFyjOo5dFEn5w3D6HR7/NDDR3orbbrZ0uzybob0OaKpXQbL6Ts/M
         o59MJRyFRKhrvfNHn2PxqAf6ZKQeRPNnlcan+2uPhB+GSSkFl6wV8ykUBqhYL3x7X23P
         ifvA==
X-Gm-Message-State: AOJu0Ywt5VOJxPijhQIjqCerHX861FJTXGpPU6+XqLny5EC5JyXoqsgh
	ReMkb9I2v+KnaabUBl93T9DoSTmOhox0iUAUaRHVr1jyiPAWch5d9UrjNB2NKTnMFm7L4kuHkja
	K/2Hk0BSUkopaRZsSLw15iub5GTaY3huaaMt/pJXj
X-Gm-Gg: ASbGncv06gTOb1bDeoP9J8jZyr4k5d0i4cwONvhn7grDBN+37ZKSF48GGlVA49acxpP
	bwFLmSlxYMi6iCEfmXse7r1The6CNfWlmHKB2SKJKC+uX4fof9PFWCsMq0RLv+UDiZlnVlLkXPR
	kAISoQd1r0b/XosYvESwOVvTUp8NcIWRN0MkytZrjWNa0K
X-Google-Smtp-Source: AGHT+IG4/KdYP+fN9Tz4EPFqPl59lyfp5z5oElErmQ39hgdiqIKMNL14Yst10Fryuqu/ixWcQkhafk8e9lBxMFD/+CA=
X-Received: by 2002:a17:902:d484:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-237cdfe93c4mr1247815ad.5.1750306794932; Wed, 18 Jun 2025
 21:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org> <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org>
In-Reply-To: <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 18 Jun 2025 21:19:41 -0700
X-Gm-Features: AX0GCFvx-B1b2Dd3L5vrSsW0UL1IAM66_kMPRqHS2OPCt7MkBpentxKfBxCiSAk
Message-ID: <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:46=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
> >> Something is off with benchmark numbers compared to the OOT version.
> >>
> >
> > I assume you're comparing my results (my kernel config + my hardware +
> > upstream benchmark) with your results (your kernel config + your
> > hardware + OOT version). The problem may be in OOT vs upstream but it
> > may be just different code/config/hardware.
>
> True I used OOT version.
>
> Just applied this patch, but I get compile error. Because Makefile tries
> to get kernel headers (net/page_pool/helpers.h) from local Linux
> installation instead of git tree.  This need to be adjusted for patch,
> such that it builds with src-local/git tree provided headers.
>

I believe the fix to that is to do:

make KDIR=3D$(pwd) -C ./tools/testing/selftests/net/bench

I.e. the build files assume you're building the test to run it on the
current machine, to cross compile it for a different machine under
test, we need to pass explicit KDIR. I've kinda copy-pasted what other
TEST_GEN_MODS_DIR=3D makefiles do. In theory we could do something else
but I am guessing the way current TEST_GEN_MODS_DIR does it is the way
to go. Does it work for you if you do that?

[...]
> >
> > Yeah, I actually just checked and I have CONFIG_DEBUG_NET on in my
> > build, and a lot of other debug configs are turned on.
> >
>
> The CONFIG_DEBUG_NET should be low overhead, so I don't expect this to
> be the root-cause.  Other CONFIG options are more likely the issue.
>

Thank you very much for the tips. Perf report showed the locking was
taking forever on my kernel... I had locking debug configs enabled in
my build... sorry... with those disabled, I get much more sane
results:

[  185.557293] bench_page_pool: time_bench_page_pool01_fast_path():
Cannot use page_pool fast-path
[  185.607873] bench_page_pool: Type:no-softirq-page_pool01 Per elem:
11 cycles(tsc) 4.177 ns (step:0) - (measurement period
time:0.041772642 sec time_interval:41772642) - (invoke count:10000000
tsc_interval:112778487)
[  185.627090] bench_page_pool: time_bench_page_pool02_ptr_ring():
Cannot use page_pool fast-path
[  185.826991] bench_page_pool: Type:no-softirq-page_pool02 Per elem:
51 cycles(tsc) 19.117 ns (step:0) - (measurement period
time:0.191178107 sec time_interval:191178107) - (invoke count:10000000
tsc_interval:516173586)
[  185.846380] bench_page_pool: time_bench_page_pool03_slow(): Cannot
use page_pool fast-path
[  186.479432] bench_page_pool: Type:no-softirq-page_pool03 Per elem:
168 cycles(tsc) 62.469 ns (step:0) - (measurement period
time:0.624690697 sec time_interval:624690697) - (invoke count:10000000
tsc_interval:1686656879)

Does this alleviate your concern? Or do you still see an issue here?
There is still a delta between our results, on different
hardware/configs but results are in a sane range now.

--=20
Thanks,
Mina

