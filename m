Return-Path: <netdev+bounces-215725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7617CB300CD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0946C3AC7F0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E61F3B8A;
	Thu, 21 Aug 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyzzzmGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0481DFCE
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796600; cv=none; b=X6Ayx2gvU5oR77wVOd0KypmqFQelGBdysSOmh59PvFkLeU32N11YxRlRG4g2kMNAdYfMYOqhTRCj0Kh+cZmLD30mPxBdLpqaY5OKFlBJz0+bX7+qMxW1wp3Z3fzbQwAzF5wQv2lu32f0StYroH+0Hh3Y4yOtdvJRp4tYj/IZ2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796600; c=relaxed/simple;
	bh=sG9gw97/xN4Fmm573+D6R/ttTm8lbK8pFoA8+n6aD18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay5jmiCdtrQsWeMcuUMN79AMkjlZ99DHr/mokk9cNtY24mrt9Yw9NTERguREgTYDwGOqBDI/kOJ9J3JEtDcOWWB0/yqdoSNqCb+Ph06Wv7m0+pwpHYTz/0DmSu2EL38cFfkaUntq36Cyp4p5j8nwcWCnl5cCzxUxO+7gwZPEMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyzzzmGj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b474d0f1d5eso859747a12.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755796598; x=1756401398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn6RFxekK6wwxwmLxk+JcZN8Gv5xjqhu6qhbEYljcW4=;
        b=AyzzzmGjSlkxwSc4tUoB3diU1MkL+XzsOKVZSs0JcWdbUgvIw/bZ/H58FfsWt75tuc
         x3kzSEvdt56w93uGZYL8aXdGXJybxbChL6d1CWdp95X32nP+g8d2dFEEt7vOop8G+cGW
         raGjTFmBmpkECppJd8vh+xzDIKaYVklTrdx0Omcucwp78WPRik0KDbib5PVBlBLVbgCl
         zf4OxnnsTWqMjPsrGF/A3m2EmtxYHWPBor3oRxo2lukiqTFH++z4lbtq/j2H1gYDOMk8
         5QLlixpFbAqyHdsRJhxKMLcmzgs3MXmFr5Pw055daN5HZVknDEzASuV7mjfLL8D9L8K8
         a5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755796598; x=1756401398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn6RFxekK6wwxwmLxk+JcZN8Gv5xjqhu6qhbEYljcW4=;
        b=wIL+s+c9VEYVWaTqOylcLcp0cDXFIX4MU0ckQIzYgMMmcGySPvSlJUjpEdjfIOvWIG
         8CvNasN0HPvYgwgAc1Dz5bM/7FLX323j5EXQ2DJc+fyuxy8raNifMXAxaIpEjmBQ5wfX
         086hxKVSfDXAkyCfPd4mLK48bOVQ4CEpnZIoGW0eLQOvb8m9p//HgBeJhKZ8Ci0vO5+0
         El5eX31DE1Ax5F07Ib8TJW/ZcwOggdujIFcinOhcquhCozMyz7mqkC38BI2L0MSl0g90
         WEVyGbVLM/BH/veCrkNcucAlvIa/vsuCIAZAe5DW9tu6bIpejutQMQUgbHxFQBA8Enkw
         CZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUvpKsiCqdNkbOpuOfGlM1v+ZiIWszPQ/P1qLAM5JYACvRDlHSq1JMRwFtGpIcVYccWuTBOrRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9KxboxRmsLypQA8zFdWHYFl7MlnNLBM7lFOEzOqZ8z0LzMRHE
	6wqjaA+VMgYdP2XA7QREVc0IRSgVuGErT7fYxivTbXIcgw+oyZgGnTS3rAkNTpSE1TbU3ETGs54
	KClT7psPjVnYyK5fKm1NjglawrEkzueNBl0RX42pF
X-Gm-Gg: ASbGnct42DsDtBXtZOxRER6NHL6GAqpf340YYdapDWBzessF4AnWtaLQ4qlPKbaQ/XL
	BI3rV6rXnUwFHXPxEzVckmiNxdbAquyoiXqL907a3qL4dEBn47WBY7vd+88NlTL4FBeeU5rW2GP
	VVef660L6UaQ/n7EqUcgQ3vAQ1Fs7ysoCz5HWAVsdU2WmZmKfZCRMbd2vXvXCz69X2mcv5kN/Xv
	SfBCzOiArrspDiBVLvM445+gsjyYNhSSHsDqa06NzEltsJiAEDbkOs=
X-Google-Smtp-Source: AGHT+IFBXd/0e2DLFJXLp/0oSMxjZPHgtybQSQQpObD5ngG01Up4DhIlAAbdr9+kgsZdvIm47WsN1xwOi3EvAJbAEvE=
X-Received: by 2002:a17:903:1251:b0:234:a139:11fb with SMTP id
 d9443c01a7336-2462ee88d12mr1717245ad.27.1755796597992; Thu, 21 Aug 2025
 10:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com> <20250821061540.2876953-3-kuniyu@google.com>
 <CANn89iL+D-OcDgxWYVP4vufeuOESrz=jy-wknM=Bbb7qVZoJuw@mail.gmail.com>
In-Reply-To: <CANn89iL+D-OcDgxWYVP4vufeuOESrz=jy-wknM=Bbb7qVZoJuw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 21 Aug 2025 10:16:26 -0700
X-Gm-Features: Ac12FXxdV0mFSalMbCqK7sgd1AA6G-Sp9C-R8IWvybI1EKfVO3e2vp8ADFgnHiw
Message-ID: <CAAVpQUC1yEB-VqKr0qPCmGEKHkfSyGt-bZn7bdEgCHe6c3FH+g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/7] tcp: Save __module_get() for TIME_WAIT sockets.
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:46=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 20, 2025 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> >
> > __module_get() in inet_twsk_alloc() was necessary to prevent
> > unloading tw->tw_prot, which is used in inet_twsk_free().
> >
> > DCCP has gone, and TCP is built-in, so the pair is no longer needed.
> >
> > ULPs also do not need it because
> >
> >  * kTLS and XFRM_ESPINTCP restore sk_prot before close()
> >  * MPTCP is built-in
> >  * SMC uses TCP as is
> >
> > , but using tw_prot without module_get() would be error prone to
> > future ULP addition.
> >
> > Now we can use kfree() without the slab cache pointer thanks to SLUB.
>
> Right, but kmem_cache_free() has extra debug checks (SLAB_CONSISTENCY_CHE=
CKS):
> we check the object was indeed allocated from a precise cache.
>
> I would prefer leaving this in place.
>
> Such a conversion could be done globally if you think about it, no
> need for hundreds of patches.
>
> static inline void kmem_cache_free(struct kmem_cache *s, void *x)
> {
>       kfree(x);
> }
>
>
> >
> > Let's use kfree() in inet_twsk_free() and remove 2 atomic ops
> > for each connection.
> >
>
> Where are you seeing the atomic ops exactly ?
>
> TCP is builtin, so .owner is NULL.

Ah exactly, I think I was confused with DCCP.
I'll drop this patch in v2.

Thanks!

