Return-Path: <netdev+bounces-131744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E0D98F682
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AC51F22C67
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81901AAE1D;
	Thu,  3 Oct 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvPyXDO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471781A726D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981534; cv=none; b=giS4hlc5c022rCASPrLVb9AZRKtasRedoInfnyDOwo/GGyBEyag2nD9YzlIX1CEHJV+YKSKJ6CNhprUFZiAdTx59UOsQohVhkxwHPsIZejcFlsrawry6duIZo5eCazZqovDWZ3YXchxtSC+GHAB+e/I7XaW1nwZeyPhgVUDcpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981534; c=relaxed/simple;
	bh=e1NYu7I5qkmnVTCQzfdWFgW/1nATCpDvamcoEXMui70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3xENmtNCRhE+sRddRC4a5wZevLFPN2I15bK0MJA9T1QEPHOcSKDcPtx5ALvdLJdCa5AE2b4OXxmJ9E66MnLz1GU3jGkJdoEoDDJEcAXJ0GfiOhdItshygjhDkk8RMNqnxpAtXzjRqGEDdbY8SGYMh7xINUiL7z+8ptw9bcTl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvPyXDO6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45b4e638a9aso47401cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727981532; x=1728586332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq4aPmlefZj71TTv9ryf0cTAO/gElDk68NnVGBgBEJI=;
        b=cvPyXDO6vJc+t2zulvpyLOrlpVX7Dg+TitiL6OfiZ256lmfEKSCRsDgxmEB464t7x2
         ZIjh75jopYqmAYPwVwXcHb7pCoEGZRTRJZws3KnUFJwn6jIY+sEIYvDjkxNWN4KvoYB4
         twn4oxvl7wJqhhKPfI/MsljsEKKH0SE0dk7/DXFOst6wpncgDm+uHGh+l7C26mQMsCU0
         leZrazGEhSk/3wMqYqGgcfdnNbOwDgoTswifTFj4IWpRN7PLBeJXUKicx/Z9ZMVeCrd7
         qlyNCYSXtTkXRjJIZmJQJFfOsJXMtqz2ZL7MblYlGNaBlGxHM6HR6+eyNOV1Xq0o70HF
         7U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727981532; x=1728586332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq4aPmlefZj71TTv9ryf0cTAO/gElDk68NnVGBgBEJI=;
        b=nQyo1C/KE8ojRmdYsEjlGzLz78ne16n4OtTP96zGCaQdkkm0HsShajXMrgPy3JGT4c
         woksz5V+/gP/pTw5fkvaKBZxnTdTgMuyCa00dW2HOE0SH/87Q/SGArEc+kMj6kbDIvSS
         BmlaaamrSiis3xnJ4xv6aTii3Ez7lGZmyxVufeyGbLKaA3T+c3VdOpB0cQq9Ul4mP7l6
         TuPt6RNdUfKfOL803yVWYAcyqaKH3iQrdAu6KsoihAWXrR42z69bdUb4VJ/KulM/Kbj8
         A0kp72D2hu2/lZzwFawr+BUVQkAWRMIfSnCNjEESod5ak2+Dq2NMfoxq1VZ4v5Ws0jCV
         fXzw==
X-Forwarded-Encrypted: i=1; AJvYcCVdK0x1tZ0AJo5asl3AE/LRmYmDAmhczVTK2gcm9rBdO5H1JPKRwa5glTOZL0e03ACeM4DD0Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjENA2Fm34G2WtHGKB//92V44NeTmAj6GZyf1FcHjbYZC8uiL
	35f3enNkFlrT+X6lSxh61lJ5xp7tO5ANSZxcbOVOzIiKu3cj3Eh+3y0iq80cIakU1jKV9FeEhCW
	N3wMCO6DPUKMcTy6IV/TDi7/7nDHnAglH1Zs9
X-Google-Smtp-Source: AGHT+IEDKI5ur8infGRx7X61AnPXphtUWV6odlnyjGCpYzC/1H0FChihtbivx+/7TH2GKRW1HzfeIZjPNqbx9QFPfBo=
X-Received: by 2002:a05:622a:a707:b0:45b:10b4:122b with SMTP id
 d75a77b69052e-45d9bda22demr61171cf.6.1727981531833; Thu, 03 Oct 2024 11:52:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-6-sdf@fomichev.me>
 <CAHS8izPbGa7v9UfcMNXhwLQ6z2dNth92x6MF7zwgUijziK0U-g@mail.gmail.com> <Zv7IFJqBbASyl26L@mini-arch>
In-Reply-To: <Zv7IFJqBbASyl26L@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 11:51:58 -0700
Message-ID: <CAHS8izN8KweeMsYOtP7BqB_XaTcgpbZi0aust9ehOqnwrq08DQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/12] selftests: ncdevmem: Remove default arguments
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:36=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 10/02, Mina Almasry wrote:
> > On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > To make it clear what's required and what's not. Also, some of the
> > > values don't seem like a good defaults; for example eth1.
> > >
> > > Cc: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  tools/testing/selftests/net/ncdevmem.c | 34 +++++++++---------------=
--
> > >  1 file changed, 12 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/s=
elftests/net/ncdevmem.c
> > > index 699692fdfd7d..bf446d74a4f0 100644
> > > --- a/tools/testing/selftests/net/ncdevmem.c
> > > +++ b/tools/testing/selftests/net/ncdevmem.c
> > > @@ -42,32 +42,13 @@
> > >  #define MSG_SOCK_DEVMEM 0x2000000
> > >  #endif
> > >
> > > -/*
> > > - * tcpdevmem netcat. Works similarly to netcat but does device memor=
y TCP
> > > - * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
> > > - *
> > > - * Usage:
> > > - *
> > > - *     On server:
> > > - *     ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5201 -v =
7
> > > - *
> >
> > No need to remove this documentation I think. This is useful since we
> > don't have a proper docs anywhere.
> >
> > Please instead update the args in the above line, if they need
> > updating, but looks like it's already correct even after this change.
>
> The client needs '-s' part. That's why I removed it - most likely
> will tend to go stale and we now have the invocation example in the
> selftest. But if you want to keep it, how about I move it to the
> top of the file and cleanup a bit? Will do for the next iteration..

Yeah, the 'docs' will need to be updated for the TX path, but I hope,
not removed. We don't really have any other clues on how to run this
thing. The docs will become less important when the kselftest is
properly up and running because it is self documenting, but just in
case anyone wants to run ncdevmem manually the docs are nice. Any
cleanup and movement for clarity is welcome indeed.

--=20
Thanks,
Mina

