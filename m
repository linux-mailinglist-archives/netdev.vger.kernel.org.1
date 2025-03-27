Return-Path: <netdev+bounces-178002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40168A73EA0
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEE4176155
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2C18FC84;
	Thu, 27 Mar 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3X3aydH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88828EC
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104144; cv=none; b=uJWRM0TRcpnHKAqi9rb2ueh9+uU5xy4acWqRg/6YqWTHpVrnWJOAenQP3EEStqPpEIKy9GFZ2KLwwXWCsv0VBomYajGuHp3fbc5gkEW6T4fwWa3RlmU458uY+5I/8O3fzG5YrasiShzOfZjtl5HeblePxL7aEjY3+zk1BubyTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104144; c=relaxed/simple;
	bh=cTxhuEnj6j/Ddquo6gG+rIjeVt0e0JaNdHhRwCGycRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LEQlNAXZ1ed5lnpBiryhh6C6D2YPeYs74ab9GEvQzTW2tweW10nCu68w0hUnRrq90vf+xTZa1gayZ9JXnj9iDFZn/PlRHsHPXOIozWdBaU2WJ5ARuEy9h0UXZryC9atcM8k3lW3572F5nVnPK3/oFBycS8bTYcx3Tk2n3yTqfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3X3aydH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240aad70f2so48575ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743104142; x=1743708942; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTxhuEnj6j/Ddquo6gG+rIjeVt0e0JaNdHhRwCGycRc=;
        b=j3X3aydHGj+f9NK4xLyO1OWO0rxn7NR9o12nP8YcpdaqzZuilyJAka1GRFPNsx6uHT
         nQBL+rPaVh93YuB0FKCj3rfggGOBDb5HLlB2AoZg9XQZhT67B4NGmH2yVvIkZ9EgK2w1
         3r+uqdkyD/ZAjnHaogVnjEurtKWg6b4q1MrQkMl16SXSgQPg0uuSCXxB+MNo39PL/tly
         6K4QoZR4ZwZilsanuecqnTGg6bJ/JWhHSpMHJdBkYrOZaPROWiYk1RK9LJA0mNfTK5E4
         opFEx1fzDs5RqOxc7wk/LQuEDCjYZyZA9CwXJ14X0NYcl8UD6K6yjMQLBlENnPVgWaeY
         oknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104142; x=1743708942;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTxhuEnj6j/Ddquo6gG+rIjeVt0e0JaNdHhRwCGycRc=;
        b=UTlpSYeBPnR5huuQEfQPtQFPb02Aqv80OQAy6pnjsuNMFHcGxNPT4U2S+veGfTF3sQ
         Ts4yYV+IUT7lkC4XeZyn40QYG9tZmea/dcgCtuklOY6i0zTN1AH2dFHfRqLtY6uWhN87
         hnWFJg8FK8/eRLozRVNi4dKO1+FiRx7SSPlYVbLs1srXxylrZ6vnigE1LPElScy02UrB
         1vrEyqvN+cYEJUJHZUMSq/nNgQ8DDnRpvDcZOBRXmnB4DdF5fKHPd8A2uzR1g7siyBtZ
         t9Iu7OiY6MUC0C0PPhn/A+S9wiXdttpYsQ4TlAL/hDfyAwu8+Q1AYjreaiAX1d/iVzy0
         FVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAHRA9JhF71e3oMiDOv7BaFHFJ1QJqp5veExnCLA22p0mkbGncdMh/2mdwzDin2m7j9RFLlVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lNVeBh5LZYZuVsOJ01pw08k+e0DSOuL5oriER8AlcWKhEooq
	MZTVivS4rWhX2aOBaW24iM2ufix+1CW/gqZ5rW3ZKHpM+q8WKBdy1CcbSCVF63R1R7Mg1VUB36q
	UyQv+4lNF3w+gJfmHr5444evwNembiZEDL1P0
X-Gm-Gg: ASbGncsa45vBxLR0kMFhfn0Qp2Z7EzIUnZUUSzaqFNerd04cD58eoJBSlPqLKNXxu/k
	f6GGvgUrkXct8saf48o7wqMPZ/5OjAwj0ndx++GV3XIlA9U1gJkjQKuHtFV8TWNyrZ/O41aSLQI
	jG5CpqtzpKdDiM9l3jLJyJbhdwJDP9WjMOMKsRpcfIA64R14oAfBeGJpMWXw==
X-Google-Smtp-Source: AGHT+IEUQTslbznPbNZRlqUlKjArFGQakVUrAP0hECrc5r3ly9hOnnw0X45LDZWiG+vsAm+1asiepfsVmtTtzTL9Lnc=
X-Received: by 2002:a17:902:7483:b0:21b:b3c4:7e0a with SMTP id
 d9443c01a7336-22920f7834bmr421445ad.13.1743104141699; Thu, 27 Mar 2025
 12:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com> <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
 <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com>
 <b35fe4bf-25d7-41cd-90c9-f68e1819cded@uwaterloo.ca> <CAAywjhRuJYakS4=zqtB7QzthJE+1UQfcaqT2bcj6sWPN_6Akeg@mail.gmail.com>
 <Z-R4UUzeuplbdQTy@mini-arch> <Z-Wbl6KoxKkbEemf@LQ3V64L9R2>
In-Reply-To: <Z-Wbl6KoxKkbEemf@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 27 Mar 2025 12:35:29 -0700
X-Gm-Features: AQ5f1Jrxydr35ky63DO7Ib796Ljb09oEM27TZhpA-QzmZzvJgfkdrcLYccFZAk0
Message-ID: <CAAywjhSc6+wTKs3cSmB0hvvPSKxK0=pd-8FbCivnLr3bYgFNnA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
To: Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 11:40=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> On Wed, Mar 26, 2025 at 02:57:37PM -0700, Stanislav Fomichev wrote:
> > On 03/26, Samiullah Khawaja wrote:
> > > On Tue, Mar 25, 2025 at 10:47=E2=80=AFAM Martin Karsten <mkarsten@uwa=
terloo.ca> wrote:
> > > >
> > > > On 2025-03-25 12:40, Samiullah Khawaja wrote:
> > > > > On Sun, Mar 23, 2025 at 7:38=E2=80=AFPM Martin Karsten <mkarsten@=
uwaterloo.ca> wrote:
> > > > >>
> > > > >> On 2025-03-20 22:15, Samiullah Khawaja wrote:
>
> > > > > Nice catch. It seems a recent change broke the busy polling for A=
F_XDP
> > > > > and there was a fix for the XDP_ZEROCOPY but the XDP_COPY remaine=
d
> > > > > broken and seems in my experiments I didn't pick that up. During =
my
> > > > > experimentation I confirmed that all experiment modes are invokin=
g the
> > > > > busypoll and not going through softirqs. I confirmed this through=
 perf
> > > > > traces. I sent out a fix for XDP_COPY busy polling here in the li=
nk
> > > > > below. I will resent this for the net since the original commit h=
as
> > > > > already landed in 6.13.
> > > > > https://lore.kernel.org/netdev/CAAywjhSEjaSgt7fCoiqJiMufGOi=3Doxa=
164_vTfk+3P43H60qwQ@mail.gmail.com/T/#t
> >
> > In general, when sending the patches and numbers, try running everythin=
g
> > against the latest net-next. Otherwise, it is very confusing to reason
> > about..
>
> I had mentioned in my previous review, but worth mentioning again...
> using --base=3Dauto when using format-patch to generate the base
> commit SHA would be really useful to potentially help avoid this
> problem.
I completely agree. But I have 2 platforms that I am working with,
virito-net and idpf. I use idpf to generate experiment data but I
cannot use the latest kernel with it since the AF_XDP support for it
is broken. And I generate patches using format-patch after rebasing on
top of net-next and doing functional testing with qemu. This is to
make sure that the patches don't have any conflicts with the latest
net-next.

