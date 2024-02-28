Return-Path: <netdev+bounces-75914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A2F86BA95
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B5C2884CC
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917A1361C1;
	Wed, 28 Feb 2024 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QFfHYU5G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63D1361B4
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158257; cv=none; b=Rvaodf5EG7S4vfsX27o0eokX5/b7U1SId6l1JqcHCZQ1BWp5U1FvtUTaD3tWc5pJ8rrahxkdPmYNimF3l7zNByeCsUpP9XEcicI1FYKTiA5zvhSAd6rehFgy6SsYevhxRy65aZoPIkTwFG6Y5ungp8i07bvngsEPZxLEgHCqO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158257; c=relaxed/simple;
	bh=lwsd5PpQR3RZIS452KG6wuL3otpiXRrJL46luur5/d0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=TyNrqM8lwhQkwy8RdXwHrGWjKXjEW6BR0KWxM6YZ17ql0hFVo1lFKDUeX1QMnQtZCk5OEfwFwUqF6z061IamiwpweQ0qvgDtvN5HiiNrODxVLlEohospzvjYKhu62Z4ZbaOtO3EA4aiYHokKbRc168gxbenOksglEQn28vDYoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QFfHYU5G; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a35c720b8so945781cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709158255; x=1709763055; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiLPNq7f3WJtE8UP7Rn6mnVgMDg0lpyiwNDCW+PPdmw=;
        b=QFfHYU5GIZugQwozAdZgKxFcsvYJGTctVhPQk5ZvvHboXsFsZhuvw32jsd+WTimgHF
         PKyPb1AmTbgoeQUDkNxgtgROuoPItm5FH6onBmONybsf6QyKx3P//sxrY4+Fvgsw3f7i
         bzHGMSxQZky3k6eN88In2KBYjDt0ttTqY2pCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709158255; x=1709763055;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiLPNq7f3WJtE8UP7Rn6mnVgMDg0lpyiwNDCW+PPdmw=;
        b=NktAyVYWktAUkmWRWL89KpTM21cOYgdKKd6iJZ7dEUrFuvSrXluOkjNnIwLf6qk4BD
         MuqKyl6cTTiSUUKSZTMX9pf3xqL7iB95sR/U/3/AMFuGUcVRg4PN9MszPYEhYHRSQt/P
         JZ9qzdMwx/AdNdg+ksC+GkNGQKZEbdETgjP9oWUHIaRvP1UWMBYei+T6jYXI3Su325Gm
         chZqiY/rXZ/PKrv3PRnuk26h3WjTjAPZGpNYqKRoyLR0LNxbqkF+mN2V/bLnsxR1IbR8
         W5CSYveXsKe9cswQIUyhGQGLqYvEVNEed1gsHeYrqX7+YPQVLYCYcsyMNigd6j4RhC4f
         NoBA==
X-Forwarded-Encrypted: i=1; AJvYcCWXz0tWmjE28nE0xurHL9l9l+1D/DQupnwUfhmfs+H5UqzFLUcaOI/yNJ/rlEY81aLojnCTrL1TsDmiMebOt7QP6fQJoffk
X-Gm-Message-State: AOJu0Ywtfd61Y71sHPxS24toUKJty89yxJq+B3P4enfXEdSOZ2wT4BaC
	IeSDZJivnfXMoqqvORr8w6PRJFv+ifbwQoeHGTV0AH9EnD64Ab1DygpKdj3Ol2U=
X-Google-Smtp-Source: AGHT+IH8tCzGQoS5ToczmGle4TFi5nPzysC9tXD/bxa1QSdz1l/UxDbrV5V9WqVotCTj6HaT0ut/wQ==
X-Received: by 2002:a05:622a:56:b0:42e:78b9:84ef with SMTP id y22-20020a05622a005600b0042e78b984efmr277271qtw.8.1709158255268;
        Wed, 28 Feb 2024 14:10:55 -0800 (PST)
Received: from smtpclient.apple ([45.88.220.126])
        by smtp.gmail.com with ESMTPSA id q1-20020ac87341000000b0042e51739e44sm58174qtp.32.2024.02.28.14.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:10:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Date: Wed, 28 Feb 2024 17:10:43 -0500
Message-Id: <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
Cc: Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, rostedt@goodmis.org, mark.rutland@arm.com
In-Reply-To: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (21D61)



> On Feb 28, 2024, at 4:52=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Wed, Feb 28, 2024 at 04:27:47PM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Feb 28, 2024, at 4:13=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>>>=20
>>> =EF=BB=BFOn Wed, Feb 28, 2024 at 03:14:34PM -0500, Joel Fernandes wrote:=

>>>>> On Wed, Feb 28, 2024 at 12:18=E2=80=AFPM Paul E. McKenney <paulmck@ker=
nel.org> wrote:
>>>>>=20
>>>>> On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
>>>>>> On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM Joel Fernandes <joel@joelfern=
andes.org> wrote:
>>>>>>> Also optionally, I wonder if calling rcu_tasks_qs() directly is bett=
er
>>>>>>> (for documentation if anything) since the issue is Tasks RCU specifi=
c. Also
>>>>>>> code comment above the rcu_softirq_qs() call about cond_resched() no=
t taking
>>>>>>> care of Tasks RCU would be great!
>>>>>>>=20
>>>>>> Yes it's quite surprising to me that cond_resched does not help here,=

>>>>>=20
>>>>> In theory, it would be possible to make cond_resched() take care of
>>>>> Tasks RCU.  In practice, the lazy-preemption work is looking to get ri=
d
>>>>> of cond_resched().  But if for some reason cond_resched() needs to sta=
y
>>>>> around, doing that work might make sense.
>>>>=20
>>>> In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
>>>> (to me), because cond_resched() is to inform the scheduler to run
>>>> something else possibly of higher priority while the current task is
>>>> still runnable. On the other hand, what's not permitted in a Tasks RCU
>>>> reader is a voluntary sleep. So IMO even though cond_resched() is a
>>>> voluntary call, it is still not a sleep but rather a preemption point.
>>>=20
>>> =46rom the viewpoint of Task RCU's users, the point is to figure out
>>> when it is OK to free an already-removed tracing trampoline.  The
>>> current Task RCU implementation relies on the fact that tracing
>>> trampolines do not do voluntary context switches.
>>=20
>> Yes.
>>=20
>>>=20
>>>> So a Tasks RCU reader should perfectly be able to be scheduled out in
>>>> the middle of a read-side critical section (in current code) by
>>>> calling cond_resched(). It is just like involuntary preemption in the
>>>> middle of a RCU reader, in disguise, Right?
>>>=20
>>> You lost me on this one.  This for example is not permitted:
>>>=20
>>>   rcu_read_lock();
>>>   cond_resched();
>>>   rcu_read_unlock();
>>>=20
>>> But in a CONFIG_PREEMPT=3Dy kernel, that RCU reader could be preempted.
>>>=20
>>> So cond_resched() looks like a voluntary context switch to me.  Recall
>>> that vanilla non-preemptible RCU will treat them as quiescent states if
>>> the grace period extends long enough.
>>>=20
>>> What am I missing here?
>>=20
>> That we are discussing Tasks-RCU read side section? Sorry I should have b=
een more clear. I thought sleeping was not permitted in Tasks RCU reader, bu=
t non-sleep context switches (example involuntarily getting preempted were).=

>=20
> Well, to your initial point, cond_resched() does eventually invoke
> preempt_schedule_common(), so you are quite correct that as far as
> Tasks RCU is concerned, cond_resched() is not a quiescent state.

 Thanks for confirming. :-)

 - Joel



>=20
>                        Thanx, Paul

