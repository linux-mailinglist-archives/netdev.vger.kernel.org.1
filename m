Return-Path: <netdev+bounces-186547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00391A9F971
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C4D3AFDDA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5DE2957D0;
	Mon, 28 Apr 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxjYLudi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFD29617E
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868328; cv=none; b=iFIRrVKcgnubLXkYi21/ZScMiuxwv+SPHaSlsVh39tPF/kZ1y1c5N+KhOIl52BeAObdz8jzl0i0Cn9+OMO14dpo6b9vuH2YHj0DSAiPbNFXIfKfhU8rfV/s46lz/qH1zkQmDAu3s89YDUmZ6ThxhEVbeK9R3KXiMmL5znfkSMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868328; c=relaxed/simple;
	bh=deYWNn+xoLucMs5bRG847VffwN7Ka0ydrTwTALfI90g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL0fpFjyl6ZuxQ/BgdA3fUrKqCqeQMiQYqesGoV7C8h4ayqH9UmWyxX4Uuk4qwYQY+lAfEf9fmwQX6nFspCF8y7w9G7fNFLJc9wVIZVh2V2brSwS5qWKYDZexLCcXsqIbJxv1RrsA+P+xWxfE9wrcgYBZd0e27Qn8fAj06Ca1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxjYLudi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2242ac37caeso26055ad.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745868326; x=1746473126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deYWNn+xoLucMs5bRG847VffwN7Ka0ydrTwTALfI90g=;
        b=cxjYLudiXxAstCElqFd6UCbqywjsIlEXOA3PS6qoVcOXWnUrN4TB0xZRFayP1bI1k8
         Pax7PranDFGKxDKuaByXjlZWj7MR0VJiJ80FXZDcJ/1J2xj/8lSACLhTXl/VbXafo4Ou
         g1hTDdHDMBJeAX3apPYn/DJ0Xj4xKwe5QC5LJUzxo/9yfnDKWD5BrDTQP2+Wduhv0fXU
         Wdsc3hXXZkNltpHtbuk4srbP1jkolumkJ/YsZATHrBdr++McIlJOlB07Eej+/PqYdSLL
         B7Y8OyaaeJoloR0I7kNjOrzYYCEUdwpqMU4HrIHKV/OorPmrjJ9t/vx0Q0b6FzFQVQ5D
         f1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745868326; x=1746473126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deYWNn+xoLucMs5bRG847VffwN7Ka0ydrTwTALfI90g=;
        b=sg5EX3zl3DWoj5eMD4jv2csZpP8AesVJlm+YvdbxNzFRBzyL/i/DJAit1P99L/fOqX
         WDUWJ+8SCuJJGiWjXMKDNRr6ZVH7oXjpRgCmNI7ph2+gWCY5+0+jA36S0Tg+W/1yNJap
         pRwxSwLeR/cTX+5a3JzzMDXH4oY3wFFcp46JC6j5m1DDfWLUgd0E9yBSND+xFt/2zQFA
         6WDpriSpLUlBCEWq2Tlma542j3ucgp4QzraRgVqfnkFT+/dIFcoj4XPLqWTahQaXKucq
         lKSXHpgdM7PLcZH9grjfAJ1+GUITsuuQFrww4vndKJojnVX+qMrLTydJC95cETQ1aCUY
         /zDg==
X-Forwarded-Encrypted: i=1; AJvYcCWk3atO8Coo3fHxRsZL+oheJq5jZXLZP/mds2lX8CBj1mJzBwZ5h+lM6adne753IS1AS1Bxya8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRowd1PQtoQRRFwaA/pAv1IZQWm0M0cu2ANr7YWg/thpfcrsz6
	NZbnfG9s7/+Fmw9EIvSE0qTzDxCZaoEL340XYGFCTewEzr3orTqqWEs1A6vHLaRJ+pcahy8xmTX
	/+yF4+ELJdcjoF8JVaTFu6BRFkQYyEt/ZBV97WZho8o4cCmvNbEfg
X-Gm-Gg: ASbGncsUJfQ2tlZxsgX1e/xAMwdEI5vi2zIIfWC0v5PAwmokWqvfHrmj7BcqLxdiNmd
	2zEsiN8LLcFjlvRwEzRJTV1glariVPwDNUE5PqxefFtQW4XZkjJvmhJioHY+StasVqg8CNMohiC
	bPXiu9udV24oV76yNkpGQCDR/4IpdPa276pOoUN2InrEdkyC9Ayaw=
X-Google-Smtp-Source: AGHT+IEdRAoHbBMKmCEWJX3ys0dN1ONhqSP45WlKwiu1CScn9ZsCGdjUKa1RD5Z4bDif8sjrybPrg+j7uvow07e2+xw=
X-Received: by 2002:a17:902:be04:b0:216:21cb:2e14 with SMTP id
 d9443c01a7336-22de6ec5722mr280205ad.21.1745868325559; Mon, 28 Apr 2025
 12:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423201413.1564527-1-skhawaja@google.com> <aArFm-TS3Ac0FOic@LQ3V64L9R2>
 <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
 <aAwLq-G6qng7L2XX@LQ3V64L9R2> <CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
 <20250425173743.04effd75@kernel.org> <aAxGTE2hRF-oMUGD@LQ3V64L9R2>
 <20250425194742.735890ac@kernel.org> <20250425201220.58bf25d7@kernel.org>
 <CAAywjhTsPXtKGQejc_vOWzgF18u9XG74LzjZeP9i3TQGxUi6NA@mail.gmail.com> <20250428112306.62ff198b@kernel.org>
In-Reply-To: <20250428112306.62ff198b@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 28 Apr 2025 12:25:13 -0700
X-Gm-Features: ATxdqUGFp2Y-s7RKfEWCWuv9o9R9oiAmAKOMgHuRUys7tzta43o01W4pdkH6tJM
Message-ID: <CAAywjhR0TPKZ-xzqjSP709OVmZWUisDNv2CVc_VxgOrXRtop+g@mail.gmail.com>
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 25 Apr 2025 20:53:14 -0700 Samiullah Khawaja wrote:
> > > > We should check the discussions we had when threaded NAPI was added=
.
> > > > I feel nothing was exposed in terms of observability so leaving the
> > > > thread running didn't seem all that bad back then. Stopping the NAP=
I
> > > > polling safely is not entirely trivial, we'd need to somehow grab
> > > > the SCHED bit like busy polling does, and then re-schedule.
> > > > Or have the thread figure out that it's done and exit.
> > >
> > > Actually, we ended up adding the explicit ownership bits so it may no=
t
> > > be all that hard any more.. Worth trying.
> > Agreed. NAPI kthread lets go of the ownership by unsetting the
> > SCHED_THREADED flag at napi_complete_done. This makes sure that the
> > next SCHED is scheduled when new IRQ arrives and no packets are
> > missed. We just have to make sure that it does that if it sees the
> > kthread_should_stop. Do you think we should handle this maybe as a
> > separate series/patch orthogonal to this?
>
> We need to handle the case Joe pointed out. The new Netlink attributes
> must make sense from day 1. I think it will be cleanest to work on
> killing the thread first, but it can be a separate series.
Yes, I will be sending a revision to handle the case that Joe pointed
out where the napi threaded is not disabled after setting it at device
level. The switch from threaded NAPI and the normal softirq based
polling happens already, this is existing behaviour. The thread goes
to sleep after doing polling cycle but it is "kthread_stop" in
napi_del and that aligns with your comment below and also Alexander
Duyck's suggestion on original change. Please correct me if I read
your comment below incorrectly.
>
> > Also some clarification, we can remove the kthread when disabling napi
> > threaded state using device level or napi level setting using netlink.
> > But do you think we should also stop the thread when disabling a NAPI?
> > That would mean the NAPI would lose any configurations done on this
> > kthread by the user and those configurations won't be restored when
> > this NAPI is enabled again. Some drivers use enable/disable as a
> > mechanism to do soft reset, so a simple softreset to change queue
> > length etc might revert these configurations.
>
> That part I think needs to stay as is, the thread can be started and
> stopped on napi_add / del, IMO.
Agreed. This is currently existing behaviour and this change doesn't
modify that. The threads are created when the
napi_set_threaded/dev_set_threaded is done if napis are already added
Or when napi_add is called. The threads are stopped/killed when
napi_del is called. And this matches Alexander Dayck's suggestion when
threaded mode was added originally:
https://lore.kernel.org/netdev/CAKgT0UdjWGBrv9wOUyOxon5Sn7qSBHL5-KfByPS4uB1=
_TJ3WiQ@mail.gmail.com/

