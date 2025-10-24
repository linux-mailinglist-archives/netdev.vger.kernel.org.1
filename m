Return-Path: <netdev+bounces-232629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1EC07709
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10C6C34F852
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6403D342C80;
	Fri, 24 Oct 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5R7YQeC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7B33EAE4
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325378; cv=none; b=J89Vzr1JbmO54VUZGav+kDd+zMD0HHecPRVh+20b50/dqMBhgwPO5oTfsT4RRPWb6DrQSCOnooYmlmSTHmw/ApSmBloEHskCYJHni7p9KmOAd/Xu7v8VRNCkvYbAyGdFCLP702wBKgSSYbUxz0RdiwwE10ZecXhe5jHlPk5onao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325378; c=relaxed/simple;
	bh=0lgUeGSBFp8vZVsfUQP4sAWjlut2BFJBh0VzjaExPRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPPZUtPt/bv7pHwZ1PlplU0jHo3S5bppU68g2dI2uzzPdzZDpnzSVMpP1yo3vAzWm2GAnvsV4iMZGR634+Pr4sJHi+LZ0qdFCh2JScY8oRB3gABO9b0FSEqoQ6aGK65zHBTE59zS5Ypf7TDiuVpYcixm3D4QUNVYs8KA96WN1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5R7YQeC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e8b6144288so19350921cf.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761325376; x=1761930176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lgUeGSBFp8vZVsfUQP4sAWjlut2BFJBh0VzjaExPRg=;
        b=F5R7YQeC9v66vcuk8yuEmllIeIsk2DfRY+cNlmKaBPiGxrYEn6tFw9SlFwniMhukK/
         1h3A0xW2Lx0u2sgkLdEuSz35j5eOner1dIV4SoP8ZXJU2VVhKVJu3Ir9NN7214dwouej
         e1eqL0DGPFYJZTg02Ar/jiwuJlay4zFSLsmh4B+KBmvpHISAm9V9CZpliiPjUp/kZJ03
         c+8dEFn71vlzuOsiIC7WMl0cQMXlsVDGj09IqYtke3BIA3/sPCkddd87wrHi0efFGD6F
         TUtb1uS4XZPL6D56yRnl97wzrYEMb7KiWhWNolTrIyFZSRwLMQc6Xx25rWl8IW4wseR5
         kHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325376; x=1761930176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lgUeGSBFp8vZVsfUQP4sAWjlut2BFJBh0VzjaExPRg=;
        b=sZnfuiIB2Vt/DCN5ZicJMkdDc9EhLrAJnpYamLahgV/SiQdbobE+KyOMziXE13DzLa
         Edr2CcnmokYdB4O0DPjy4pn0Ie7nXx6m75uuq55ob9xrFFrPLCgMKhOTMswubFmDe/FA
         zajn0vcUVgzeMInoaG+OBzHX+bqwtu0yBDXHIPRn0976eHbqf/97Uz4O3NBfcPNAujce
         kAWLNZN2QWV4TMmqZT4/Aw29GrzHM0oVGZsw3oQXMynw1clCgky7GOp6kbCHL4V/9h/f
         ZCm4GNSOW0k5Xo9rO/EKX/M/jzG+4On1KhQXmp0kafYl9EF2R9LU9EOZfYK9Uv4hwphG
         vafg==
X-Forwarded-Encrypted: i=1; AJvYcCWr0CevOfQKkBmCSNWuuZNRzOkyJER5WiAHPaB3LZ6gJ/qxKZzuTe220n6xMjvpEGjolxCHZPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqw9RONpUJhyExG/0K9B3sjf6TlEmEAmhcc7CVWeReDkF2xcDG
	mNa7j2A29u8Ku2GJNN0vTMv/IG3hBTyMVzjDItErOPvPz+Q/6UoIvKLtwHZK1NlHRieKolzBp5u
	pZUlj4LXT5s45AXImngxbEzlR469MIakalivKKgRW
X-Gm-Gg: ASbGncvIHVQXVE0Rf2uQkc+V/OTe+wLB/Slqe4Jz8VWX2xKjp3yIEBFeGSCIqPqkM5Z
	U+fCzw4Z/BeKwHeYSnt1AkNuzOtFZoFSh3Ecf7/56T+lcW/TnsyZoFRuS3aLC/e/0W1+t/GymYR
	eela1SgnWLJf1VkiuKpltYvsLzgjP2g9GMEtGcTgEFvtlsgGSyoA/xz+IHiqud24uzbJHsaduyW
	BLENg6RR2/4VEa/+A0syAxJ0wa5jDLpoItHckvylT3dKM31Dq5a1M2K6ygHKlbUH/U/5w==
X-Google-Smtp-Source: AGHT+IGY43V3QoFGqbSqtG38LbLRBiJzXSxcn5ImHu6m5amKrBRR6EPPQ6rqb9xR9yV1mz2IrUEr5ost0KlL2mjkd90=
X-Received: by 2002:a05:622a:1808:b0:4e8:ae23:58b with SMTP id
 d75a77b69052e-4eb948df990mr37862701cf.42.1761325374996; Fri, 24 Oct 2025
 10:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com> <20251022054004.2514876-6-kuniyu@google.com>
 <CANn89i+Wv_tzq7LR64bN=x76=HBBmtR+GG5nDEi4fX8zokj71A@mail.gmail.com> <CAAVpQUBd8ZW1BZMN0FAPbr=MzP7drSN8YsxdJLmQVeTfmvNqVw@mail.gmail.com>
In-Reply-To: <CAAVpQUBd8ZW1BZMN0FAPbr=MzP7drSN8YsxdJLmQVeTfmvNqVw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 10:02:43 -0700
X-Gm-Features: AS18NWAMDmEqy_0ehrg3_xgMbrcd9RSY8m7xw3jTsegcpfPE6Lv0phnBQZCRSYk
Message-ID: <CANn89iJ6TK025Dac-K9-oZLuPLiFVF+Gnp1UwcC3OQfc1x4PkA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] neighbour: Convert rwlock of struct
 neigh_table to spinlock.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:42=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Fri, Oct 24, 2025 at 5:31=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Oct 21, 2025 at 10:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > >
> > > Only neigh_for_each() and neigh_seq_start/stop() are on the
> > > reader side of neigh_table.lock.
> > >
> > > Let's convert rwlock to the plain spinlock.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> >
> > Do we still need _bh prefix ?
>
> Yes, I think _bh is just for IPv6 ndisc calling neigh_update().

OK, this is presumably to protect tbl->gc_list.

This list could use a separate spinlock, given neigh_forced_gc() can
spin for up to 1ms.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

