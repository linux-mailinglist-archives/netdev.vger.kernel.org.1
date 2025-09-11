Return-Path: <netdev+bounces-222245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B68B53A99
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4863E7AA006
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460071EBA14;
	Thu, 11 Sep 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dhZWErX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6941A8F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612736; cv=none; b=FgZX98m2YQ2ZoujIIdKbokR0mIpB2h6doTKo1TqdYfJPMTUsfRoPs5eLNJhXvEEbf6xl2A8CkpHXpNOyxGTTtrebhbiZwy9AqWwXhVXZjFEzbElVL6AQVYyWohWJip9ON95mVjzDtQuRlr4p4LGe3rvNGj9LyXGsgaW0j8CGnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612736; c=relaxed/simple;
	bh=/nHpAWqYD2tKnha6x0XreH89BIrbfc21iMX6BLcP+FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxj6+BrkDIcSE6ATgrIRdAV7fJ/APliOOKPeE1oySuBnTdgqTcp68NKaUBK8LNaua2HiKvWtjbfDxb4r3jgmZeIoJUk7M44qWzzkhWtNJ+2W8DR9K5MlXtGFQrqntfus8/Qd1NQpoleut8haOAsgMT5fhqaQRm3Z+d01COOaAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dhZWErX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b21006804so11074295ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757612734; x=1758217534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIDXrbSC6UOck2vb5ofWkAL7Y5qvL0omsEwcHkXaHLY=;
        b=0dhZWErXrJLmAOzuiVGM9yWI298wBYVstVACmzKc/pqnslK+bZgWBoI/6D+jhfepT3
         oql+NAI4nk4A/ik4Mgw6VTWavBftISS/Tm26MpAvsM8+yEcBcuQinToLpsrjtzogWE7D
         KcHk/RlVrKOQC0vTTsO24O9kpFAZ4YP9/E8GbSCnORKucf8XK7vpOAR2k8IsZhEAw8j9
         P77Yubec3ih9qpaSIryCqwIExPVC+/wxP6LbyovgecJ7nQChjxb5MD1jUO9L+8UkZ9mk
         crJ0uQYHWds7zDpjMBzOG/y5ea7dSNeSr709A/1S0JtkfPt5kKC8bI/FyprXd8hqJXkk
         7SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757612734; x=1758217534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIDXrbSC6UOck2vb5ofWkAL7Y5qvL0omsEwcHkXaHLY=;
        b=Hbs6lTblrhTdCzqGYLvuL74bcDom7PzwoCv7MfmTxPMqBuc02Qzg9L5Ea/gF8DVt9l
         1Suhuov99O4N4eWgLePg+jA1udM3gpTvziLsMH9m3CpI3Urr9M2tqAxUkMc1FT9FTDXz
         jiGoZaOZoF/4r0lsNVbGg5Pjon18+WryhLeM6IgHaphlFdyiHvumra1QOD7KKuYgfy+l
         GhaDf5Qic6fA4hOt1oarYT4t7clB5BxrLZUOb28o8FOcnnw0S7cnNYImeurvqFp/Fxqm
         fg/il+W+qZKhl7rmaXDByK+Y6B37JuGQvrF7oAmWh6h1t5JGRZDAO8pYigpEp61SwgZm
         Inxw==
X-Forwarded-Encrypted: i=1; AJvYcCWZrnlP4veXNv/AIPum4NVKNuZHfsuC+XJ2M6SX5tJPG2q7PzNwj9lNiHDbWl8KoKf3zwH9apw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6EwEMnKqXIQtqEpI3txKI3mNRRSIdTwI2HmqgBuXXnhTahMTW
	5Kw5nYMI8uCOKvH5hLo+NyaHXNNjZhPc6Q+4GzxuppInFGyNnio/ZQWuIYQDnok6eRy19TQPVF/
	Ber4Mjro7xgMe6iWPUQqZqeh3vZaloIFh8wZX4Mae
X-Gm-Gg: ASbGncvYkRG63dIayYwAqXB5RCjylygPxrOD7ZEljAMJR/eUh2w4aoH0nK8i+1T2UvY
	/g0M46ktvrkstMow7rauA+G9Tx/TFaazdBfzs3kVedVVAD5ip6n6l2mBiesICmaeNPCLHtiD19/
	UEZ/Dv0tJwPfkI4k1GaQCvP5lhgrWYRSqlBU5dyFB71UDS56T9fr6yCxxRJi5qcJXba9zROI8sO
	sjABhRB2G0/6PC3/S8xwmvxShIXL/a8EjViF1zEaD8Y/PFgfK5RrlMCnQ==
X-Google-Smtp-Source: AGHT+IHIn8C6lOWdI+zJlJd7pZkkHxpa2w2Svm/nZBtc24pdPe9O1TKt0+/2OUZjF7yD9ol7AbWe92PUv8sPtUKxc60=
X-Received: by 2002:a17:902:ce92:b0:24e:81d2:cfe2 with SMTP id
 d9443c01a7336-25d23e11172mr3242085ad.7.1757612733782; Thu, 11 Sep 2025
 10:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-7-kuniyu@google.com>
 <CANn89iJnOZ-bYc9bAPSphiCX4vwy4af2r_QvF1ukVXF7DyA4Kw@mail.gmail.com>
 <CAAVpQUA3cnUz5=2AYQ_6Od_jmHUjS0Cd20NhdzfDxB1GptfsQg@mail.gmail.com>
 <CANn89i+dyhqbd0wDS+-hRDWXExBvic4ETm1uaM2y1G9H4s69Tg@mail.gmail.com>
 <CAAVpQUDgfLp3Ca8M0Z-Q1Jf00ufDsJJQCcSASTGBJkKTOGMO9A@mail.gmail.com> <CANn89i+hNzxZMgHXHsqZs7XaMcxQKyXK-aM43uqrS5Yj-iZNKQ@mail.gmail.com>
In-Reply-To: <CANn89i+hNzxZMgHXHsqZs7XaMcxQKyXK-aM43uqrS5Yj-iZNKQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Sep 2025 10:45:22 -0700
X-Gm-Features: Ac12FXyT-QxoGLnfkIDS9Y7109un6vOjKZoOHa_cNKmvcu6_JpfPTga1o0Zxr40
Message-ID: <CAAVpQUDe3uStevAzpQ0nreUrJRGgJYY9wF1-k=JT49jL2K8oTA@mail.gmail.com>
Subject: Re: [PATCH v1 net 6/8] tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:35=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Sep 11, 2025 at 10:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > On Thu, Sep 11, 2025 at 10:07=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Thu, Sep 11, 2025 at 9:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > >
> > > >
> > > > Sorry, I missed this one.  I'll drop this patch and send the
> > > > series to net-next.
> > > >
> > >
> > > No problem.
> > >
> > > Main reason for us to use net-next is that adding lockdep can bring n=
ew issues,
> > > thus we have more time to polish patches before hitting more users.
> > >
> > > We also can iterate faster, not having to wait one week for net fan i=
n.
> >
> > Thank you for explaining the reason.  That makes sense.
> >
> > Then should we keep or drop Fixes: tag ?  At least it will not land
> > on the mainline and thus stable until the next merge window.
>
> Fixes: tags are fine.
>
> I usually do not add them for all patches, because I know that
> everything will be
> backported anyway because of dependencies.

Thanks for clarification.  I'll keep them this time.

