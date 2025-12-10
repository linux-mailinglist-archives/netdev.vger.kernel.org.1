Return-Path: <netdev+bounces-244187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CB0CB1ECC
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 05:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15B8B300F9FD
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 04:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161B242D83;
	Wed, 10 Dec 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuEuiywi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762C22D780
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765342116; cv=none; b=Zj3WOr/JxXu++T8Vh5T5ERSA7rO4WjAiWY8PcR0KCBwLu6VoE+Yf4Gz3ZUI3FW8KAEfR1z1pgoAbc2rrj+8U7sSQkCsBAhRKUa8QLD837q+SWVJPqyUxvMuVjPRNmINWN/NraP477QUWZ/2aoRvAULphr8FcJ16w0ajO1qdBKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765342116; c=relaxed/simple;
	bh=wOnWHf0V8T9o0xAAo2KSV6duT9nLdrmW8L6IjwTruJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHcrwU4CFhDkNEutvQKToafX2uv9HLsOaGumpwsYPGA7pVx0po9A4F5LRXbndOkVEzzEHkxp657PAty/4ygP5aAtVXOkIx25/aj8kLODfPi3sl8DpY1szekeSuqHUj670XJoJK7ITM63Fsqr2ZjRL3HyFOa3dkNN+55kpi6SLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UuEuiywi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29806bd47b5so38438355ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 20:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765342114; x=1765946914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOnWHf0V8T9o0xAAo2KSV6duT9nLdrmW8L6IjwTruJA=;
        b=UuEuiywiUuIPEDjMcb/cVnXf7bfla8JgUON9876grREf5MzvMLyQvlOoyhbhyEdIUl
         CAV4aDWbtAmo8clvkCQ0ko+cW+wNDC8CstnDDDGetKzjg5+tuGhdKj02ElmbX4wQzwP2
         XOyLMnqKkDjAB1p9WffUaXgWPIulxP59bnev52fz87yvqAZ935I2/M2BfGaSOR6HlHEL
         h65LF0NpR1BvmRcAW/qlvI05Tp72HiU+6WLXZH05q6CBuQ/yBqNDt5MIIm1dLRa3LYER
         g9Cn6HLxd1nROWgYwg3atXc8m1E8iOMvnHImh5D9o9se++VEvB/dkFNzCmUTs+rMsoKG
         fTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765342114; x=1765946914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wOnWHf0V8T9o0xAAo2KSV6duT9nLdrmW8L6IjwTruJA=;
        b=Sipg1i250fdoGC56cYwlf0kzg+kaZAm49xRha8JezN/zLa9xxM4wvZVmSQbMKyOJgm
         zz2EyNqKs93qIzn3322a3UZWd+xHVb/J1MV0E4r9TM+VBk8HuG6m9usZgZisghfqS8H3
         1YBf72ioQ18WbwP8uwaVs0U+AMuwjZTtpbyLAP7Ak8QPxaeft8IYehoAN1EFOSD1NNuO
         uquqTDmK2jTxrVRFDLuuA3d31CKCaEYovV2/fb44xnvuE6D8Pgkb4bjUWKMdAwmpzkYz
         yvpddZ/4muWH7+5Lo6w8ipBbXRm/jAkTLED71aYbDYSr945L47KMDn+OoekN5vVh6Lqs
         4bRA==
X-Forwarded-Encrypted: i=1; AJvYcCXNArOhDoB6Q0tQ0oUaUkTZux3AeE/1D35P/zjDFMNQP+Hzm7/lm19gdVia7IU/tdSJumZZ6zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6BgSbm68/i+IRKa5AftnctuRYss1TVb+gvkDCihHCTmQI+4a
	PG7U1mDIOPRsQFrAuUsa884/AbJO3ugSG1L3pSd2EnjuNnkP5ROycNjEnZSJRcnLMuAeym8Ws3m
	/9vFlVmXD5wi0qsXUHX7pGC6qsGH02WvEck8kWRVB
X-Gm-Gg: ASbGncsww1WUgIHzATU40jDdnWoBu63WlagtVfyLDVraSgwtq98ULqr7qiMn2Rt32Fm
	3i5IJAns/j0s771qnuN/WBg3BAo41la6o0SOWD/+Nt21ll3QD90eYviB44dTc0A02ckarmgj1bS
	j+g+Esdc9a5lAKxzTCp28hQjIA2/e4Bh0BYe5ReZAbDj0yLL1n5EO9uxIZ0raMEvcAT55XiguuC
	2CIZU4/WvH4DMMkAQ5ubU4UNmEWxkSPz+PH+FBaNq94Qwhdp3IPBxJRn4GoOi9tu4IWRjeZNwbS
	kz29wmZelUyVJ++hHegr6JDapYY=
X-Google-Smtp-Source: AGHT+IG1ny++enHGr41p6l4klX73jNYpvn74ye2e4xfxXbAOYSPN4zxugGjK/F9Ha8OapZ0cNlk2A0VhPG8+v05WqM4=
X-Received: by 2002:a05:7022:629b:b0:11b:a514:b63e with SMTP id
 a92af1059eb24-11f29654b10mr924519c88.14.1765342113209; Tue, 09 Dec 2025
 20:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208133728.157648-1-kuniyu@google.com> <20251208133728.157648-3-kuniyu@google.com>
 <CADvbK_dEk5a1M0tO8MULiBMwcyYV99zVCdhNC+mfOkv=RQauHA@mail.gmail.com>
In-Reply-To: <CADvbK_dEk5a1M0tO8MULiBMwcyYV99zVCdhNC+mfOkv=RQauHA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 9 Dec 2025 20:48:22 -0800
X-Gm-Features: AQt7F2qfEc1SP6sJ6iK35RmjcQzXMAU4RRFrVumoxxrg5hC6uhQjGMeQk9gTJ_s
Message-ID: <CAAVpQUDH711WYOn68SCJDzNO+d0L19erDBQrXg4tb3_JBwA-iA@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] sctp: Clear pktoptions and rxpmtu in sctp_v6_copy_ip_options().
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:26=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> On Mon, Dec 8, 2025 at 8:37=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > syzbot reported the splat below. [0]
> >
> > Since the cited commit, the child socket inherits all fields
> > of its parent socket unless explicitly cleared.
> >
> > sctp_v6_copy_ip_options() only clones np->opt.
> >
> > So, leaving pktoptions and rxpmtu results in double-free.
> >
> > Let's clear the two fields in sctp_v6_copy_ip_options().
> >
> Hi Kuniyuki,
>
> The call trace below seems all about ipv4 options, could you explain a bi=
t more?
>

Oh sorry, when I drafted a patch a month ago, I cleared
newinet->inet_opt instead, and I found other IPv6 options
could have the same issue.

https://syzkaller.appspot.com/text?tag=3DPatch&x=3D16e930b4580000

I'll add inet_opt patch with this stacktrace and separate IPv6
change.

