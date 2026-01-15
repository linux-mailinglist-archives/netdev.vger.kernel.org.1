Return-Path: <netdev+bounces-250125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD867D24348
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 128413014598
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20535E523;
	Thu, 15 Jan 2026 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INKnG8Ds"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3D33AD83
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476924; cv=none; b=I+cJqvN9Dd/DaWQtMBqeh/LKFCqBCj4UidczL21HFkgWmq1+2fRkpp+Jsp9MmE47VyaN+N2DcIV58kQ2cKiLnmaa8W0jbKmiiOum64HUV257fb5g6a7awAstvcTf2HqiV+tT996ggxuAHuCHsgsDPzHIrMpiKcxrie2ONYedLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476924; c=relaxed/simple;
	bh=HGK8KU2XQHQLnkvp6F85E2i+Z8ViAFYO0nG/sD3SBFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4EiRPTP3fuF4UIhsuheosV59UA3Gv3gCg6M0aG5Ny0cIZGSFSO8N1nQfwjksljajHSUPxQtEwBJN+UawnOIWd+vqyjI2o9muZKSXxKTa4dA7mIVITOri5u2x2NIIjyE6RrCnRQPkFk06vFiAo8vkUadajobDlqRSGSJ1sdapkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INKnG8Ds; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5013c912f9fso9537721cf.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768476922; x=1769081722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W0S2/bK8xUoCrZvoVCNOu1N9wLhj86+1jh6DZFbWek=;
        b=INKnG8DsaKcQOMQDWrFLiNwiihlH/huHsh7lS3NmqFxR0WcD/NP5mFUKaHbBWfXo+z
         B01cglhxuwlxy2N9E8iC54pQK6qaMNOyv++JQYxtpLJEPHGOvq1ICwQxZupkN+7ogfjD
         N0V4xD3aERaWewYglHMBk+0MyV3i7mbS2it87bXNPj8nOI9mq/GbAVdeBL6bA/sMYQN+
         ONcQNThS0bB18weI6eK9tKbSjKoL3QYihVCMQ2AbWlravLS8e381rtvunoVtRJCVghOG
         v/McXODBYFvkeyzhJiz4sz7zqdk2xmrOdmnmFwP/nsnBDiAuwHXHsX4BWW4BnaCVgtTe
         5bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476922; x=1769081722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/W0S2/bK8xUoCrZvoVCNOu1N9wLhj86+1jh6DZFbWek=;
        b=etHsyVkma1XWg9gQs7fWVCZkiodZL3unUhBz3yVGL00UCP7NQLzu8qBW72oo+zSlOB
         XZ2iHFZvTKyjttqctHReSObRzVq/XimRUCTIj4T26nATfkrL9AwNYGJCvgArHnkDAo7G
         YcIhdmn5jAG0498WW1RIVUbsT4eTc8KsYEEZqkeOmMBCywL28udVr5a+KsPqkzUxaOz3
         Cf/t2mM+cb4gTwdmuplMUTdzJ9oNZLNvKLkD8tuwZLKLHuPr/NNjP3w5tMe8u0EztTx0
         Q4HKdTtGs8x13EwufSbJI7qDbKT9ET/KDOZ7NzBp6jLjqcF7Ot5IofaJVqXUmPbu8Du8
         J1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCX3mZJGwG+Gl+abVyBcKAKb++NloKESwtpNWImw7l6Edr4Dm80U/oBYuPA63UTvsOSKkQ1z67c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvQ15291iiKwcyyriEf/LndAwVTe0mL3jrdqpf2hGZIGDGlbW
	cbwcZ59btKQ6Cr1FeU9mKI3A9KTck3nfvYawkFao6+yj8uS16JCMF8luoVfCsVNtH8Yq7HTKmsJ
	FJuq49e+s5JRxElWzDoc7jZ2dksyWeHt2Ef2EDBH789TmqTl990mNEAE82rE=
X-Gm-Gg: AY/fxX5idRt3Cm81Q9V4672oaHeNiHvg1ICYdbsTdKnWPfW3uyAGoUnqT1/viD1uKXD
	lDYDISUmAQgV8QdmEArbvQBxAUF75OCQqw3Xq/SvtZzNTMxMxj3QRu+sMlO1YhwbjFsVdF94n+7
	xs9G2Y4SeZ/yyy0/fQ/BwTS3AcUSjHMi3hpuCcYVWMELca+Izj919TrX7zMwzjYeJxvIP/HaOkb
	2wrCeQH2KfT+DW6fKgHNb/GBscwM0FO6wpvzcltMFCP05epeFt5P18u+f3n8k+DK59FPQ==
X-Received: by 2002:a05:622a:a05:b0:4ee:1301:ebb3 with SMTP id
 d75a77b69052e-50148278431mr78671091cf.54.1768476921830; Thu, 15 Jan 2026
 03:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112131515.4051589-1-edumazet@google.com> <bc1b8d79-2229-486b-aea2-bbd71d1fc74f@redhat.com>
In-Reply-To: <bc1b8d79-2229-486b-aea2-bbd71d1fc74f@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Jan 2026 12:35:10 +0100
X-Gm-Features: AZwV_QjTWUinG0vB_TeYpanXX9GF35uvCincNiTgIy1fFa__45zDZGX_h3aay2Y
Message-ID: <CANn89iJdpMQe9M-ubvc1bZm+KFdpOOL_EPmyhUjka82L8YJpDw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: inline napi_skb_cache_get()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 12:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/12/26 2:15 PM, Eric Dumazet wrote:
> > clang is inlining it already, gcc (14.2) does not.
> >
> > Small space cost (215 bytes on x86_64) but faster sk_buff allocations.
> >
> > $ scripts/bloat-o-meter -t net/core/skbuff.gcc.before.o net/core/skbuff=
.gcc.after.o
> > add/remove: 0/1 grow/shrink: 4/1 up/down: 359/-144 (215)
> > Function                                     old     new   delta
> > __alloc_skb                                  471     611    +140
> > napi_build_skb                               245     363    +118
> > napi_alloc_skb                               331     416     +85
> > skb_copy_ubufs                              1869    1885     +16
> > skb_shift                                   1445    1413     -32
> > napi_skb_cache_get                           112       -    -112
> > Total: Before=3D59941, After=3D60156, chg +0.36%
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Not blocking this patch, but I'm wondering if we should consider
> defining an 'inline_for_performance' macro for both documentation
> purpose and to allow no inline for size-sensitive build.

Yes, I saw mm/slub.c was using __fastpath_inline, but conditional to
CONFIG_SLUB_TINY,
and forcing __always_inline

#ifndef CONFIG_SLUB_TINY
#define __fastpath_inline __always_inline
#else
#define __fastpath_inline
#endif

(For some reason clang is not very smart at compiling mm/slub.c, I am
preparing a series to help with that)

