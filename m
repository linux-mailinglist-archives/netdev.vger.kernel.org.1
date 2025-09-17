Return-Path: <netdev+bounces-224145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC8B8136D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CCD620A56
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C102FE599;
	Wed, 17 Sep 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/HQQqC+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153C2FF143
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130901; cv=none; b=KDPg6fpPJGn8pFBdf8oA6/TIQ7KR6rgE0YBOMYhFSEPDOGqVGxmRqiMf1vhCc36pJ/s9ygUOZJuxddGwG6v+Qo/bCKfWTRjVVYh3KRnYLrOhdefck3ztzvnu7T3TN2Nn5OmnhcFBk1m8LGFttwFw1TaOFL6v1PH8B9OHywAx15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130901; c=relaxed/simple;
	bh=p1RVBPiw73on2khsQlaXk61HowjZ96wWJ8qSKc/79Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw8ApzV8skRnEPhFyKnrRehKLwJt61TfCO92gvRyivbp7uwK1N1tfEbM6mdXXHg6gzaYgCtUnoxfbPAel8cs1DT8YaXPu6PRs+8NKALZfXRNSTrj6EK7RjfX8XungJ+fsTgOZHCySSVRnLcXSEwObSvpWNk3e1hFAqWQpfF2YdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/HQQqC+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54b0434101so47999a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758130898; x=1758735698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1RVBPiw73on2khsQlaXk61HowjZ96wWJ8qSKc/79Y0=;
        b=E/HQQqC+gOAuUcqYYfdgP4qUvhFjstkNE81WLdIB55hOGFArFjzxzBYsJ52A1dQ0a5
         F8eP4AaYl77OYxRmiievkACplFbQ1HzLp8FBpFs3IlTPvOx/mzlK7lcdi7yf9ZZg4UfC
         F2sm5XweFZIlA8RUPDpds/ikOWT9pCXKZbX6uCzjVfjdOaLho3/4pad4w9qZOXgCETYY
         o40bDx+16m6iXvWWQrd9SkzRGrp66OabzK680pqWVJu7j9nx6fe+BeBzaDxleJE7mt0g
         Av+QkMmFx6LGtse1pGCTLBl8lKn4T9md5pTHC8Wbz5cccSxYgUwWgX3SF8eTPTvGkQjZ
         PEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130898; x=1758735698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1RVBPiw73on2khsQlaXk61HowjZ96wWJ8qSKc/79Y0=;
        b=lieHt3EJ/A6BrKTUgS9YxfHwi5gjntkkRvIzfPcMIlLk3VN9RyHr4WIusYcCycdD37
         cJqDb9pwZ8NgDwUb40Q+5HjWy4c0vZHDFDuvlWWSiA3xNFfHr3pVoqWEIPx8GGu9EVQB
         890+nOI8rorTATWnhBmP6l0t90tVOXsLzJCUdEFM/XJWcwF7sIxriQEVEzSbV+qI6HpS
         igLFqvnlhASiLNaj4BBp3vFsuwQnW8CEZ2b+a44J7ePuumqkohHmKcWbTbRZVdaRWKAE
         CfrwbEMEl4kWXpWDsq/aNwEssACpbdnToWgT06r4WCd62mL3eO7rFLPaHtNenK9qQv94
         tivg==
X-Forwarded-Encrypted: i=1; AJvYcCVaQBwRye1WcDqPtSAU53ss17PMJLOajd38VwQ4Gx56wAHT9hQalgqMLnwoZMMp/mmumZCGluY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUUUmrMg86fYDlT4hIuMfiWTj/aXGt3JVT5s+yWCJD1jtchPQ
	vvnBkjYjt+Jt1FO1NjtFwdZtEm95N9ibcbFOiTsCXC6H+34pP41aPEdkg5j68XL3uYE4Vu1gA67
	SO4L7Qn3k3FVA9aZI8FAwQEJI4iW5KWmT7ssxIBtY
X-Gm-Gg: ASbGncuiHm11w/62xXJYnk1nkc6bQqQTYym3Gsw1cIMvpd/YcKeeKa8FQT7l4LDXHR7
	jzKCZgqgq2l6jhb2lapw3+xkwshz9/XY50oJsjiU/aU6KeECb3UCEXStBQU/TGSnkQlyqPYNnMv
	+V08tMAr7YXmCKJ/fRqb5IFHK73qh5qlge3J/OSJSVHA/QuE4yptGQEWitQUwZvUB14m6GRbPg2
	XC49NU7HDpv1BvTn/E22SHQ1nk5zB0q5hr2nrwlsdfa
X-Google-Smtp-Source: AGHT+IEyOgdCA3opQ4TgiENz3BerWeLtm8q5QGA8rWiWeF3RTJ+Iw57iN9yrvnbY8A0/PEgohW/o+3x6fOnD1R89DlM=
X-Received: by 2002:a17:902:e5c6:b0:267:a230:c657 with SMTP id
 d9443c01a7336-26812178234mr34293985ad.24.1758130898192; Wed, 17 Sep 2025
 10:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-5-kuniyu@google.com>
 <e1bae4d7-98f7-4fe6-96ba-c237330c5a64@linux.ibm.com> <CANn89iL39xRi1Fw0N4Wu6fbNjbbNjnYS4Q8BD3q+8HrY2XB_4A@mail.gmail.com>
In-Reply-To: <CANn89iL39xRi1Fw0N4Wu6fbNjbbNjnYS4Q8BD3q+8HrY2XB_4A@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 10:41:25 -0700
X-Gm-Features: AS18NWADG6hSlZavxF8PfewtDsaxK8HBJjYwCTtzoT7YF5HuB8PwPyHgyKfYC7M
Message-ID: <CAAVpQUBJFpcBUgez6Pni0H2uQbeqLodDcOzvy+fPfGj6jgxh4Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/7] smc: Use __sk_dst_get() and dst_dev_rcu()
 in smc_vlan_by_tcpsk().
To: Eric Dumazet <edumazet@google.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:09=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 17, 2025 at 2:14=E2=80=AFAM Mahanta Jambigi <mjambigi@linux.i=
bm.com> wrote:
> >
> >
> >
> > On 17/09/25 3:17 am, Kuniyuki Iwashima wrote:
> > > Note that the returned value of smc_vlan_by_tcpsk() is not used
> > > in the caller.
> >
> > I see that smc_vlan_by_tcpsk() is called in net/smc/af_smc.c file & the
> > return value is used in if block to decide whether the ini->vlan_id is
> > set or not. In failure case, the return value has an impact on the CLC
> > handshake.
>
> I guess Kuniyuki wanted to say the precise error (-ENODEV or
> -ENOTCONN) was not used,
> because his patch is now only returning -ENODEV

Yes, that was my intention.

Thanks!

