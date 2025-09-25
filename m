Return-Path: <netdev+bounces-226203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17858B9DECA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42443B8677
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF725C821;
	Thu, 25 Sep 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvi4XKDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A422522B5
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786849; cv=none; b=udrhGVYar9NwKyHjVVBov6AtKQuvYor/1GBUJXvI7EmqerOiGOKV1tWYmLI7eySNuLjSKWkgpdrITLEGw4is6dewS1zVl30wJUyKRblGosiEmFouLkjEWjV72kSmR1A9U2x2bFJe39Lze22asmvEZCv05iA7zYOCCj+ey6S5E1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786849; c=relaxed/simple;
	bh=sXuIRkcSDSwCLbzqCXPg43cRNCGp6GBaCd28CalI5TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a88jTPOw1PjPoIjacwUOECkqge5FUGviEzgtXRE7PeMyDkBPxEeYErhuZFe8GCPBP69+Vr32owxrFIe5hpYTnK/iFiHMm/zqlFg6ihva0jM9TzJApL1vU3maLXmJMfJ6REhK+WbRPVhDbHudgErbCjLQKFDHO1oLK72GYfeluM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvi4XKDY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57abcb8a41eso13950e87.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758786846; x=1759391646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7H/7dcF0DnQCzlj6kekKQKqU8yy+jLuwRDWAmlb5u4=;
        b=rvi4XKDYMii9sh9Tck+pN0/aZPhYWq5fV94XWht/GgNui81tQBAvyx9qcw0AZCZqh9
         wSQLt+21AH3sIRPr5pEk3m6DqxsZ3dtMSKRHxSoCZ/LCmjHNF5FD0T4eVu6xBcU3hAon
         oybp5EFAkebGsppPiw9aBtVOL5RlrR6Vlq21ljFeO+vluwyYBLkdLhexjq5C8zjvF6fO
         8HsqsBK/+dTjUypjjWvMPOshM3qN2XpBjcH5J2KKJ+Qao0VTNMyWRMdQ1NlCrAMeFD0V
         wRzwEcssrfbHokwrC/clD+863pAm2ia0vcf5u6R3tjBGv+u1Ju0ljH86A7Xqbcnby8In
         ySpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786846; x=1759391646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7H/7dcF0DnQCzlj6kekKQKqU8yy+jLuwRDWAmlb5u4=;
        b=ShaSzJVDUBCQ8EZoaqM01XiplvV1xMeO1MojOM65GKWP0tYv5QuHvr1MUADkBIiO/y
         fdMOWqsJKswa8NDL76UmvoOCwwgSUNtK1m0qtHPYEpwfimGadlTB88rcMCMJOvAxLRhI
         0zKGnXYX3rBZrEx1s7tK1I3TWo1hqJlZMAtodJsdZ0Bpv9ncV26Ylh7WBO7d9Wh4mYvJ
         ec4AxO7IU/NDxbGBigzGX1+QnWN+FQgad3QqohCHjiHXI1/2MLz5GVLwSJ0R4h+FocZ8
         zRw9PZuyZEGDHe7hHZPYfCrIyIODqB2l/Mm0/uXS52LiCtpPsWWvGvUH0EWC7w4OQYCp
         9dkQ==
X-Forwarded-Encrypted: i=1; AJvYcCURrTHwnRYk94jCwU1O9Ty9y7ST/dEQ73oBXJtjbB64aDaXTj7jQuQ0BWpRLLrTPbASkz/5MCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1I/X2CSkrdPx+4QeJ7aFytrmunYYVPpAyg5Z7yQU9ZdT3HJuz
	7KX0YxNmBkArylte1kMhhJgojB1v0Hjv75Sh5u7os6FAPwRr2zGimAO90mhkGMLaV3ohxh3Xy8o
	McUHIR3CqltbGmn/mMv9xOgjlUBvdx+gyG6SBp8N+
X-Gm-Gg: ASbGncsUUPeP1Ys3kEqL/WpUtdGZHB33JXIAycqmQZHtN62MIchN4TPukiI5AMiZ5am
	PhXF8bROlvw8nFhLj/iXp/0AVAdmM2Dsl6iitifjnvq4kp5KsAj1BtwTWyQq9VT7//6zXcAwNDu
	Uttzr7pG8PapfnfhMxeV0hn5WuCkGC2gf9nxvqCIYIPYCOUGzYiV7Ldm9qfZJOk66OAqBzOLPlD
	9fYwMyUeMGoTViWvjGe+PzV
X-Google-Smtp-Source: AGHT+IHYxQQEMpheS5fEalhtIA/pXf2Md494D4DDnhf5j1AhD8VDSh22QtqaZpxTT9fx/YzMYoa7fKWF0ANV5bv0djM=
X-Received: by 2002:a05:6512:2288:b0:55b:528c:6616 with SMTP id
 2adb3069b0e04-582b1b17861mr280355e87.6.1758786845720; Thu, 25 Sep 2025
 00:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924060843.2280499-1-tavip@google.com> <20250924170914.20aac680@kernel.org>
In-Reply-To: <20250924170914.20aac680@kernel.org>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 25 Sep 2025 00:53:53 -0700
X-Gm-Features: AS18NWBEX4g5KLKkNf-lBld4t5AZRDgZiFWedmr4AlhJPhNdQgc3_QoeOfHdbBE
Message-ID: <CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, toke@redhat.com, lorenzo@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 24 Sep 2025 06:08:42 +0000 Octavian Purdila wrote:
> > When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
> > bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
> > crash occurs due to detecting a bad page state (page_pool leak).
> >
> > This is because xdp_buff does not record the type of memory and
> > instead relies on the netdev receive queue xdp info. Since the TUN/TAP
> > driver is using a MEM_TYPE_PAGE_SHARED memory model buffer, shrinking
> > will eventually call page_frag_free. But with current multi-buff
> > support for BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the
> > page pool.
> >
> > To fix this issue check that the receive queue memory mode is of
> > MEM_TYPE_PAGE_POOL before using multi-buffs.
>
> This can also happen on veth, right? And veth re-stamps the Rx queues.

I am not sure if re-stamps will have ill effects.

The allocation and deallocation for this issue happens while
processing the same packet (receive skb -> skb_pp_cow_data ->
page_pool alloc ... __bpf_prog_run ->  bpf_xdp_adjust_tail).

IIUC, if the veth re-stamps the RX queue to MEM_TYPE_PAGE_POOL
skb_pp_cow_data will proceed to allocate from page_pool and
bpf_xdp_adjust_tail will correctly free from page_pool.

