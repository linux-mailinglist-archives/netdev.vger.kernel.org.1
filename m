Return-Path: <netdev+bounces-169951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6112A469BE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E063AB498
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F27235C11;
	Wed, 26 Feb 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OO1aq1wo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402CF235BF3
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594459; cv=none; b=gpqGJvqPhWgWvTTPO9ABHMiLWh0MPzluhQL74M4RBL+PXlhQ90Jzmo7r53IeinXH8Yu5yeM6YgL+tzVMhpNnXsFeZHe8lVpjBF3b3s/lDoXuwxtHwXgGz46HmpN/4GwTY0LtxZJiLiS/Hm7QSo41qLNuTH6Mk6MO/d2ophha3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594459; c=relaxed/simple;
	bh=mDtSh+HotHwurwAnAYMDhlSrEAza9DEiUdKcOW4Tofc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBLMEcAg0rTe/4DI19PTVO+guSM4QA2GOWzNMxHt5pmgJLJKHTtYrwZBGxU+sq6GrVHUzHU9D6LeIRBjayHOW7G4V88Zt8XWsMSBiVBdCy5Lfu0QBHr+5x0Ghvxmw7nbyIJ8qP2Seoh/AukVj+0QUDFnKSmc8ngLiH/dlImCEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OO1aq1wo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so3466a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740594455; x=1741199255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbGtNrkjyYgBwz5N4tw3xyPtem5v0qKByNJMW7ySY+w=;
        b=OO1aq1wopHfDM+lD8qGRFMqeZJ2sGH1q7obXwZno7UsWLKg5uHHPVSz3z0PhSdrokS
         Q+zU8R5DI45MB6sMckzr4pHmiXeFBPmeKD+Z8xcdBzXN190zFJ27BxW1e402nZThBWhb
         G1PZ0X0JbCVJSiq/p9xpPvLBxDOog7QQjXrt78NdCVfVx1ZBfMja76wuDdaKuJiuQqSJ
         03LQ+U7wpHoTcHrX8HHHcczS3tjNCbfpaGGPRTwB3avKZEtBSxPMGrNUdG0Mb0HBrUPX
         854L9Oiht+eVvPz17+oerc/NoIfbRy9WQwziL+JG/4Pm+qMMYrHui5qoc8RuVoYuGCC9
         Qo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594455; x=1741199255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbGtNrkjyYgBwz5N4tw3xyPtem5v0qKByNJMW7ySY+w=;
        b=GTVMSXViVwP166wH3OVizcuKZ2Giw0jl37YF0KH4mH8Q4HAdeUMrbRftRRkxiaX0/5
         wC4WZL8mTc17IiDFolgcNXCitAys7ipg+tBUl1BDIz9risVTIQyAyJazIcFPgxvH6usx
         g3QU9SZLG7/nFvMf58Qrs/Ief/ioZ6YkH5PhtLVLVvx8NOQODQ3E4sJ36AA5sFCiTlff
         isSy+LgTCpoAhjQy4MknvG1oKT+IOT1VVGofbSqWSjn/dIO5L6dJUsXkIucKeiGNmZa8
         jXvsKlal03m8NvZzblYjKQxXCANb7vfRwNVru+ng+8bELzUoJcZvmXTYBh1QYMI0UFNU
         B1tA==
X-Forwarded-Encrypted: i=1; AJvYcCW39UQfInW+zYot+pUZDrXZQELtcsfrAWCb/Qk4RYRuofCQBZqDLqLs1aU1teb8yu+ptb/8GEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMn3d3OvsMD0Dn0XhyTnVnoxCBGKvm/LFxFmqkLF9zOTEResF4
	WNhGuPcK5Mw1RC3mPp3X55zqrcYroHdJPfOyRej4eWzIf2XgcacD/7QcQJ2h2eDzixEI6Tm5QFk
	x5S/owcd1zXs8vy3Dc24tHhjRZW0Xkz5to4WT
X-Gm-Gg: ASbGncswhpkPxT4E/MQ8EMYs6twAXVkWXiZhG5UursdzlfRp+MQH0GphPWLfCS/kjCc
	PUGKJTpMcvzBx1LdPeeuiKlTT/VpsB76MdX4bROk5uxSOIMXFFjmPr9FNfrqbiN21WGHf0sL3W+
	gf02xMwn8=
X-Google-Smtp-Source: AGHT+IFZBOT6NZJ9lqdYQz9B0TtJE7SWPmI7w9k6cI2+KrhsOlofGrsGYOh36W2Hth5j++vVYOH1PeRrrnRFKS92TvY=
X-Received: by 2002:a05:6402:26d1:b0:5d4:4143:c06c with SMTP id
 4fb4d7f45d1cf-5e0b7222d3amr22842943a12.23.1740594455410; Wed, 26 Feb 2025
 10:27:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org> <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org> <20250226-daft-inchworm-of-love-3a98c2@leitao>
In-Reply-To: <20250226-daft-inchworm-of-love-3a98c2@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 19:27:23 +0100
X-Gm-Features: AQ5f1JpnOes8jn9vTB8ptmBjvNQ7ShU9fUjTVWe0lA4VmH95ahg0G8P5C9WLQq8
Message-ID: <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:18=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello David,
>
> On Wed, Feb 26, 2025 at 10:12:08AM -0700, David Ahern wrote:
> > On 2/26/25 9:10 AM, Breno Leitao wrote:
> > >> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would c=
over
> > >> more use cases (see kernel references to it).
> > >
> > > Agree, this seems to provide more useful information
> > >
> > >> We have a patch for a couple years now with a tracepoint inside the
> > >
> > > Sorry, where do you have this patch? is it downstream?
> >
> > company tree. Attached. Where to put tracepoints and what arguments to
> > supply so that it is beneficial to multiple users is always a touchy
> > subject :-)
>
> Thanks. I would like to state that this would be useful for Meta as
> well.
>
> Right now, we (Meta) are using nasty `noinline` attribute in
> tcp_sendmsg() in order to make the API stable, and this tracepoint would
> solve this problem avoiding the `noinline` hack. So, at least two type
> of users would benefit from it.
>
> > so I have not tried to push the patch out. sock arg should
> > be added to it for example.
>
> True, if it becomes a tracepoint instead of a rawtracepoint, the sock
> arg might be useful.
>
> How would you recommend me proceeding in this case?

In 2022, Menglong Dong added __fix_address

Then later , Yafang Shao  added noinline_for_tracing .

Would one of them be sufficient ?

