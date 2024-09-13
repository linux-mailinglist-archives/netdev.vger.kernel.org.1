Return-Path: <netdev+bounces-128243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E2A978B52
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83961F219E7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055E155742;
	Fri, 13 Sep 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntrBb1f0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0E14A09F
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266029; cv=none; b=A1Y9nmytbMtWQfVfw2J8Aa3LKGlWO8M51C5LGllchUz9uUDGv5kVv92MzrDXgMOVS3oLZ+lfJBRrpUNAuCZOgtQ6Ay9EDBrZ/mkcMvZY6uD6dQsW1223nIv7J533LehyEhClqs4xWOYkphorGQiGKZkAVNNWsO5yxVkAQ7t00ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266029; c=relaxed/simple;
	bh=4ReVohtII5cSTlqN3wK0UiuPDbS9FDQk1WOSWLM7E9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpnifljwXEVx0m/opLnA1SjUoIFDIEpSG1TjssU2OTSDvwbUbvlVjMGbugeXZtKl7nzVmsAonc0xF81R5g3OV53xAISq4G3q4SH4ffCsoQBDQqFmOefxtyEiSiKvWq30lXoQuV2OekbfRSl5yDjzuHjjUsEZtIRe3r9gzz2N9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntrBb1f0; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4582b71df40so33581cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726266027; x=1726870827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ReVohtII5cSTlqN3wK0UiuPDbS9FDQk1WOSWLM7E9c=;
        b=ntrBb1f0cbP22KFb+Rg20gIThFiP2ZI1+5mGlkt3myhcUIg/4pjdi+hQy7/CgKgrLn
         ws6LkoGyoDK8sVUkhVrloM9cARVJzvhP26KouOSo2JZC+3u2FDJIZ9nAnNeIqd9PiXaM
         rxM7zB07CsEO05I6Ri/dX4+Fg8J6ltnyMsFmlbtSUVV4Cgg6WfvXudTxBCdiRLlfDsuz
         GPE40cG7cfE2/3CsHWsFT6mi6VISNj0hpHK8WNRSQMtsEoJJz9zVl97Ut7ImoHGljqcK
         N7Pwgv22o0LwKCawht9ds005H9A4zcgsinTxTNcXM9xIuGEUjDkvHEQ6Vb6JGzswH6ru
         j7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726266027; x=1726870827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ReVohtII5cSTlqN3wK0UiuPDbS9FDQk1WOSWLM7E9c=;
        b=NOz/sf8PKPAtLtHxtm+qOgU22hbiRyz4LhilBMohHhAK2IViKYFpr8ohItfNpng3pK
         ujrQFht8t/WfErJI9HJ9DQgxXicb6TRnKr7G3XcoaYV5G9cxWEP8M/n3RqapO7jESKuB
         pkqgzaakrQmUWOdhsGlsei1qfrC46q/x/CLiE2y4YU1o+JFqcBFZ4fXrGefggCcKgV9p
         DzFLkSYvt7Jlv1hfdSGqucIVj1uq4Vq7o/PVrcqrF8NHjP5BW8Wqsy/7KUzEh8xU7fP3
         5ky4YoDPb409XtJswhM8bYBHbJdiG44lypr96FbwB/3g1sXFanurKylqPg4Libm/6oqs
         l+8Q==
X-Gm-Message-State: AOJu0YxCjISLpoHto8fS5OGc3g77DSPoKVnrKV4npwFLoX1I7RjqKJNl
	1b3pB5nyNtFEPzh2NsCklblju2dSXUhDcJliaKIy6Dxfwn04BbWoVJ333w2T8SqLQ+PdvkSykpT
	svy8q+0Kp4G3rvKSfxdejuL0RWZqmR1WtOlnn
X-Google-Smtp-Source: AGHT+IE0fYJ1AUzgoxfB7Sh6DszZg8+4BX/1w2yCAl0s1N4rHnq7fstPs0A7Ok4hht+CAAz8/BHHwxzYdIYuFld+XbQ=
X-Received: by 2002:ac8:5845:0:b0:453:5f2f:d5d2 with SMTP id
 d75a77b69052e-45864403792mr5623691cf.1.1726266026235; Fri, 13 Sep 2024
 15:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213351.3537411-1-almasrymina@google.com> <ZuS0wKBUTSWvD_FZ@casper.infradead.org>
In-Reply-To: <ZuS0wKBUTSWvD_FZ@casper.infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 15:20:13 -0700
Message-ID: <CAHS8izMwQDQ9-JNBpvVeN+yFMzmG+UB-hJWVtz_-ty+NHUdyGA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: fix build on powerpc with GCC 14
To: Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 2:55=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Sep 13, 2024 at 09:33:51PM +0000, Mina Almasry wrote:
> > Building net-next with powerpc with GCC 14 compiler results in this
> > build error:
> >
> > /home/sfr/next/tmp/ccuSzwiR.s: Assembler messages:
> > /home/sfr/next/tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is
> > not a multiple of 4)
> > make[5]: *** [/home/sfr/next/next/scripts/Makefile.build:229:
> > net/core/page_pool.o] Error 1
> >
> > Root caused in this thread:
> > https://lore.kernel.org/netdev/913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-=
soprasteria.com/
>
> It would be better to include a direct link to the GCC bugzilla.
>

I have not reported the issue to GCC yet. From the build break thread
it seemed a fix was urgent, so I posted the fix and was planning to
report the issue after. If not, no problem, I'll report the issue and
repost the fix with a GCC bugzilla link, waiting 24hr before reposts
this time. I just need to go through the steps in
https://gcc.gnu.org/bugs/, shouldn't be an issue.

--=20
Thanks,
Mina

