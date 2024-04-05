Return-Path: <netdev+bounces-85233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D523F899D99
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5629EB23306
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0816C872;
	Fri,  5 Apr 2024 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbom+KMi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B116D307
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321675; cv=none; b=KjUhBIOQMcgWoqi0iITxfRvftHgH09aaczTErfD223WUSFp26LrXZUetGimcKJrwk5TNG5KOrt2PJA/PQ2WcX5qsawNwDCQfm8Ft8K4vouG/427ztRG81CytHn9F9OjGrpjzgphjAaGN659DeMQ7+BZcPG7eZx7h/TJPiGCQuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321675; c=relaxed/simple;
	bh=detQ/3XT5iQi9YbdIGwLeghEa/prwlJw0dwlakSgtq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5hgQoG1VAoSRulezvBcX1JoChorBsJ+fS42alN3nq563fq1a085tM5sLF5VsucceNTrK+Lh438wboxR9NYAQC5Ap5iAnOO8R10nCe+vID60OBtEz3lZ1G6SGhbwfbJn5f6lFF2uPEHWFPhUIiLSyf9XskqU6QPcThaRp6HvhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbom+KMi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5199906493so156144866b.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321672; x=1712926472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOJXLsB4r3zFE10CJCa01KFUnMUQmt1ShT4BK3qkO30=;
        b=Jbom+KMiCM6InocuDP4c1sbSoXjUPGo2Vz1XiZJ86NkoqFfPNiGe36Vxj9lNiOrUMv
         08M6ro/iShZoTPy4lEc3NkM6Prn6M8Dn96CkynnS6G7IE67wIpcvvU7NI7TXHVLJWkID
         m+M73NLtSYstCOfcpB7iNenCw6pZuWp7ZQbFXK7+01VPiKdFGyPeTpxUwOqVu3x+ENNd
         LrAemK/UzxUgxzh4TAeDv5BX+1+kPVh5EwIj0FCNmnCnhb1votxeCfZmeIlHtvhYmat5
         L1iqb/QUQC7QDMdKgCCWSfsGVRgylZJg7qmwI2Uq31gXal1ZWOfVs4k24WqYs9gWQIRE
         8bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321672; x=1712926472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOJXLsB4r3zFE10CJCa01KFUnMUQmt1ShT4BK3qkO30=;
        b=gwErrmnHnFWaEOCONbIozHn680NIzOM59t8qTbPg5bPbkfnuDCAq6htBhR8swaIbmF
         JOXvL1gsX4PSWEH8XTpXPTsmwujo3vyc2WWXZETLCZKT8i5tAphGNfl9EQQbcQYBwCqV
         sbJksygDEu7O/Xw5l4CL6k7de4IBXUN9fjwNqgv+qo5I70SQCHHH7xbuozNJ3eRjvYXH
         VYuZrqzx2/mVewDRaV/kpkuUc8BYW6R+td/+qsEVL0lQWpp3XocsIHxRG9UidhAIbUBB
         KwHjzfdpPKrZOV2uo+smH7t9u7wia0yRBzSP8vjOxvBcftlS3PhNfPZVsZsx0z9jOXSD
         Ny+w==
X-Forwarded-Encrypted: i=1; AJvYcCUGekO+gLfaO8xRWRqPZsoLe+kPPHqUJf3Y/6EzlxzjYGcwQyhMaeCVNOdxKcQsLHWVYm6C7spVvCdEKr7fw8qYwv/5QfWo
X-Gm-Message-State: AOJu0YyySjn+MbrkByY/6YPmEjZO9X0qHln4jj9yraCQUwucp4kI2Ti9
	h5OofB57AHQ+hwSvgNU6mRm33E/azy8yn+wJyL4ICcFInrKJn+Su/HABiCzxUPgkG5huVtHzwfi
	rSTsDdlXxfLyPnBAh/jaRNDtgoBBAcy3MYe0=
X-Google-Smtp-Source: AGHT+IHUCGfE7DWJIwp+HUF379z5MAcjbtnNLsGzqvQZQGFTwnfFEPQp9q9fyOMohw1l1fy5Cr3lnZKeAZ5CcG1vx7s=
X-Received: by 2002:a17:906:b257:b0:a46:575c:a9a2 with SMTP id
 ce23-20020a170906b25700b00a46575ca9a2mr874151ejb.45.1712321672086; Fri, 05
 Apr 2024 05:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
 <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com> <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
 <CAL+tcoC4m7wO386UiCoax1rsuAYANgjfHyaqBz7=Usme_2jxuw@mail.gmail.com>
 <CANn89iJ+WXUcXna+s6eVh=-HJf2ExsdLTkXV=CTww9syR2KGVg@mail.gmail.com> <CANn89iLUQ1DsBd_nemdhcgfvc_ybQmM_sGwWLwzeyOW+5C2KnA@mail.gmail.com>
In-Reply-To: <CANn89iLUQ1DsBd_nemdhcgfvc_ybQmM_sGwWLwzeyOW+5C2KnA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 20:53:55 +0800
Message-ID: <CAL+tcoCCog3HWTWkEV5+5RggxGGMJaj9xYZ2CfzO9v18BUyrCw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
To: Eric Dumazet <edumazet@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Apr 5, 2024 at 2:38=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> > There are false positives at this moment whenever frag_list are used in=
 rx skbs.
> >
> > (Small MAX_SKB_FRAGS, small MTU, big GRO size)
>
>  perf record -a -g -e skb:kfree_skb sleep 1
> [ perf record: Woken up 84 times to write data ]
> [ perf record: Captured and wrote 21.594 MB perf.data (95653 samples) ]
>
> perf script
>
> netserver 43113 [051] 2053323.508683: skb:kfree_skb:
> skbaddr=3D0xffff8d699e0b8f00 protocol=3D34525 location=3Dskb_release_data
> reason: NOT_SPECIFIED
>             7fffa5bcadb8 kfree_skb_list_reason ([kernel.kallsyms])
>             7fffa5bcadb8 kfree_skb_list_reason ([kernel.kallsyms])
>             7fffa5bcb7b8 skb_release_data ([kernel.kallsyms])
>             7fffa5bcaa5f __kfree_skb ([kernel.kallsyms])
>             7fffa5bd7099 skb_attempt_defer_free ([kernel.kallsyms])
>             7fffa5ce81fa tcp_recvmsg_locked ([kernel.kallsyms])
>             7fffa5ce7cf9 tcp_recvmsg ([kernel.kallsyms])
>             7fffa5dac407 inet6_recvmsg ([kernel.kallsyms])
>             7fffa5bb9bc2 sock_recvmsg ([kernel.kallsyms])
>             7fffa5bbbc8b __sys_recvfrom ([kernel.kallsyms])
>             7fffa5bbbd3a __x64_sys_recvfrom ([kernel.kallsyms])
>             7fffa5eeb367 do_syscall_64 ([kernel.kallsyms])
>             7fffa600312a entry_SYSCALL_64_after_hwframe ([kernel.kallsyms=
])
>                   1220d2 __libc_recv (/usr/grte/v3/lib64/libc-2.15.so)

Thanks Eric. I give up this thought.

