Return-Path: <netdev+bounces-95152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F18C1840
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6651C21015
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995E48595F;
	Thu,  9 May 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnFg9Uay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8884FB1
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289576; cv=none; b=Zu7NGxnLL2bNXIEjw3+1gASrxS1/MHSNv1NfUDByg0A0Z72yWPlAVSX69w5USVoVOikxrXZhhtA4OXzIW8fiEGmr6o6e8QAd3yJ8Yp857LcWzKI3skJjqzXSWWs5hpO9kJc4E5UMB9+ZS48F1/ellelduKMXHJbFMdq8+iKUZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289576; c=relaxed/simple;
	bh=Um2iaQ7WeSFO93nhxJoPQRrULk9qwBNcQZW38ADgIuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUjBSR7yvt5AJWCkLMMtNvDbbdDzQtNIJtVwOBHFWNnzUi9i35m53efgBR95oDGcE0fZHQbDOA6pVIlgtS1UGhin7pKbYNi0Y5m8gFixvwYxZZKsFKrHwDSMS7IS/lraF+yShhu+c69RbjuCUB5Hmpvu/NWZBAPA4PjRX9ctBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnFg9Uay; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso5066a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715289573; x=1715894373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj/ruisSex0Kp0dBhUAYPvC4ARDFWMxrTjQLMO36++8=;
        b=RnFg9Uaye0V/wEh+CofUbF/mTFaDJpOUF8VKlUbKgZlaCK0AURpyjQnS5iiUUeX+CI
         380Gk+cOTxS4ES63Fm/f7YRVqECJNayQkwf7EmTz5hepGgr9pzF4M76aeWBmJ9fz2sUv
         45rFJOHLglFzz83XZG3gl9OmXF7QibIStYoLr7v52nKMLwOgxUl6Tvo8MrFh7oRZni4d
         R2tO8IgBonNDCIm5nNBU3WFFk06SDvKjyYXYk9bWfhoGvtUQq2IEUN8lXx9ElPKRjyjR
         TNaTcaIT59ib+5cxbSeAYYE1rpVGXf71rszDUvJ884VTRnVvKMvG2BeBOkSZCbJcNzYn
         phIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289573; x=1715894373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj/ruisSex0Kp0dBhUAYPvC4ARDFWMxrTjQLMO36++8=;
        b=IKsErbA0uauuzYGEEyo6dD3fD7O9bMjelVjnwmh6Urw0exUCuPvYmaNz/S1Qj5LePl
         gYx1AzTbezEtMGy+XP9eCa5m+om441Fkg6FbpD3Vb+sCJslotCwTg8pSyQbUERgxST0P
         M/D/tc4ZYd8/gq/1TRz4aHb6wTyy9dYoKektZiZ6IYHhWvQu0jurMKikUZjEZGiDEdVB
         IFaCGXGhvDTXZh0nO/AMHaWL+Tq1nM+Ja09f0zH5LPQ/t1uSvzs3zU7keYOnrmWSavJ1
         s5Sq+/mop+IOuYHXrsuoklBpm0f7cdTb36HpftS1a3kPJadxPdxK7L+CjcQ2noToq4f5
         Kyow==
X-Forwarded-Encrypted: i=1; AJvYcCWrqjNKcQdpUFZUC2rBrYb16g5diBGoW/hPUEvEsuR4gAgh+2H4csi0iq//lnTXNctHaYbS8090b0dXNvHjxlrjPtA7E2iC
X-Gm-Message-State: AOJu0YxVrKEmXPucpOtE0Lhlu+CGJ5bh+RAWyJSrjq7S6ch85iabAKGl
	0ng+ecEf6YujofbC2gRj5sdfRVul35yvLkZK5odIAcfs+KZZtSnGMsVmPiJDNQObdQbMNNRkM9P
	KMUTN2XHj77DONhPCEthZn1O3OrBo1Y+3e4A+
X-Google-Smtp-Source: AGHT+IGI4zzf79CVFYKmEZhPf2lhqJh1b8pYhjbZ5go+AXsEnSPUSUtKffiZRTXlmKPdbvdXpzTycKoV7ugVsV+l6ts=
X-Received: by 2002:a05:6402:222a:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-57351ffc899mr8908a12.3.1715289570474; Thu, 09 May 2024 14:19:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com> <20240509200022.253089-55-edliaw@google.com>
 <638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com>
In-Reply-To: <638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 14:19:05 -0700
Message-ID: <CAG4es9UxSmaSdRU7T5q2t_TgOJg+=8UPf8xmTV5bhP6gbDwJuA@mail.gmail.com>
Subject: Re: [PATCH v3 54/68] selftests/rseq: Drop define _GNU_SOURCE
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:16=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-05-09 15:58, Edward Liaw wrote:
> > _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> > redefinition warnings.
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
>
> The patch per se looks fine, except for the "Fixes" tag.
>
> Commit 809216233555 introduces use of asprintf in kselftest_harness.h
> which is used by (all ?) selftests, including the rseq ones. However,
> the rseq selftests each have the #define _GNU_SOURCE, which would have
> been OK without those further changes.
>
> So this patch is more about consolidating where the _GNU_SOURCE is
> defined, which is OK with me, but not so much about "fixing" an
> issue with commit 809216233555.
>
> A "Fix" is something to be backported to stable kernels, and I
> don't think this patch reaches that threshold.
>
> If anything, this patch removes a warning that gets added by
> https://lore.kernel.org/lkml/20240509200022.253089-1-edliaw@google.com/T/=
#mf8438d03de6e2b613da4f86d4f60c5fe1c5f8483
> within the same series.
>
> Arguably, each #define _GNU_SOURCE could have been first protected
> by a #ifndef guard to eliminate this transient warning, and there
> would be nothing to "fix" in this consolidation series.

That makes sense.  I can remove the fixes tags.  809216233555 will
likely be reverted first anyway, and you're right that the focus of
this patch series is on consolidating _GNU_SOURCE.


>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >   tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
> >   tools/testing/selftests/rseq/basic_test.c            | 2 --
> >   tools/testing/selftests/rseq/param_test.c            | 1 -
> >   tools/testing/selftests/rseq/rseq.c                  | 2 --
> >   4 files changed, 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/too=
ls/testing/selftests/rseq/basic_percpu_ops_test.c
> > index 2348d2c20d0a..5961c24ee1ae 100644
> > --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > @@ -1,5 +1,4 @@
> >   // SPDX-License-Identifier: LGPL-2.1
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <pthread.h>
> >   #include <sched.h>
> > diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/=
selftests/rseq/basic_test.c
> > index 295eea16466f..1fed749b4bd7 100644
> > --- a/tools/testing/selftests/rseq/basic_test.c
> > +++ b/tools/testing/selftests/rseq/basic_test.c
> > @@ -2,8 +2,6 @@
> >   /*
> >    * Basic test coverage for critical regions and rseq_current_cpu().
> >    */
> > -
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <sched.h>
> >   #include <signal.h>
> > diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/=
selftests/rseq/param_test.c
> > index 2f37961240ca..48a55d94eb72 100644
> > --- a/tools/testing/selftests/rseq/param_test.c
> > +++ b/tools/testing/selftests/rseq/param_test.c
> > @@ -1,5 +1,4 @@
> >   // SPDX-License-Identifier: LGPL-2.1
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <linux/membarrier.h>
> >   #include <pthread.h>
> > diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selfte=
sts/rseq/rseq.c
> > index 96e812bdf8a4..88602889414c 100644
> > --- a/tools/testing/selftests/rseq/rseq.c
> > +++ b/tools/testing/selftests/rseq/rseq.c
> > @@ -14,8 +14,6 @@
> >    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> >    * Lesser General Public License for more details.
> >    */
> > -
> > -#define _GNU_SOURCE
> >   #include <errno.h>
> >   #include <sched.h>
> >   #include <stdio.h>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

