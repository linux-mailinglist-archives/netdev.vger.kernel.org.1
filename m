Return-Path: <netdev+bounces-97998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D48CE841
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EABC28224F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7D12C49F;
	Fri, 24 May 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9a2dBtA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BA6E5ED
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565839; cv=none; b=NhV0eKVOOlp8MDhMR/6qFxc2XPNO7v5moYSBYT8Tdjl4XxW4fBv1bRXLVajThXT4WABoxE/D00EAj82w0+PHyOaOv4N6Kdbw/TcJm+wDJP6ZYhJbhKBa86GZEcCS2sqoPf18OVgB7583HOO3Fh7K27MLRtcZ8MAAjv0HhZD2M7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565839; c=relaxed/simple;
	bh=xfGEK0HyQ6+S+8Cu0YxH3wz26VT0rKBDA4ViNqVVTOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noFHCMqASaGTet97yZbXcv7Lu9LDoNZhH7qxUTqBcHLMwtIlvXZKdRbEMKsGy/+Rm5385Cg88xToicSSfAfvfzV7jmcgSy+RGFWgXSJQXVxlu5McYf4j+bCI9h2cII72Bn3EuipUBg+5Bp2FxwT3yY99vWl5oe1jG2s/qB4cmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9a2dBtA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso10430a12.1
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716565836; x=1717170636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khPwdSFpWA9j42MFhxCYJ1NmS4R6lGHspST2K/NqsQ4=;
        b=x9a2dBtAv3rYAbsGdkpfJKEoxUTLljh43bB9qp4vGeOG7EF4zttYdQvelUEZmLV/KT
         RpdgoTFsvOkd6jnjIYL927+cE/FDtFNRvn4SLtY0xE26xI4uwPLDs9jWxcaEsjqvA0af
         IW4oovqMktyXmLK7JWPlXx1+tPHqUW0VjtwTLFvE4hkKiCfrCoD45pqsJlJPehTicMql
         p8vmyitfGtD5KNd6MsT6y/QTn1X8t+M4oPOd7ykxVoVgAQlj8Ig5L4XwqnyXWHeQ/Y+v
         1iO1B7DSePzl9pq5FZ0Hun9FxIKYJN79g/GTBtRkxHciespudUOoac/1GlKMjXUhQ6+I
         FAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716565836; x=1717170636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khPwdSFpWA9j42MFhxCYJ1NmS4R6lGHspST2K/NqsQ4=;
        b=aj998ozGzFQUbyvj4TGfzN+thAapByS02wPmmpXtYGHa8BRLRdQqo/CDEFBbHyIeXQ
         kZiVz4S+99+5856E2W+E7jd4rWdBRcKUPXFssqS31vIHK86JvEFR1R7VjERxtNeYtghS
         ySyEwxpJ5uu67eipey4WoNephVPAbjS6ZtBbHodFi+ngFYYGijKmiI2H6jQgue1M1Tnz
         uHBKwcxnHMGBRE7ERgrVW240A/XqjvsJqAqVBr3UgIbkvSk63e8j8NK/+W08Ol30ZWLC
         b2YO3G0coZC6hmVd4jR+Nf+cjs1kUaAYSXKAksBwfnG+p9ACF2h3Puj5Gxdy/MkJDGpG
         F+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWaTJTlJlUKpgUnPlehsg/CCziK9YafEq00Buu4KRfR4mKVy1/jIsxUA81eQIU/rurirp6yAsoRZr1ndvlnNryYhBE86q67
X-Gm-Message-State: AOJu0YwAj72jHUfdCD3LSaHPxKbY9P9EIAdE7FoIhb1V/7Nhx6CmSgRL
	JlEy7jy8whYlOrlLXXVskKfT6hfIXUSx3ODTXZ0IvMjv2mCIL3DRYOE90+Qb5694icD3jLf2v4a
	qmlyti222hhaVUqfXdNAI926LN63Ei+Xn1/jl
X-Google-Smtp-Source: AGHT+IEJR705/MsE9Jihv5sdHIrF/H6Icy1m3jKCZjft4F9iqJeC/qbO5CmTOO5LnpmRMOlGllLi03K8SDl5uar16j4=
X-Received: by 2002:aa7:d702:0:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-57851666b7dmr180641a12.2.1716565835572; Fri, 24 May 2024
 08:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523134549.160106-1-edumazet@google.com> <20240524153948.57ueybbqeyb33lxj@skbuf>
In-Reply-To: <20240524153948.57ueybbqeyb33lxj@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 May 2024 17:50:20 +0200
Message-ID: <CANn89iKwinmr=XnsA=N0NiGJhMvZKXuehPmViniMFo7PQeePWQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 5:39=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Thu, May 23, 2024 at 01:45:49PM +0000, Eric Dumazet wrote:
> > duration_to_length() is incorrectly using div_u64()
> > instead of div64_u64().
> > ---
> >  net/sched/sch_taprio.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 1ab17e8a72605385280fad9b7f656a6771236acc..827fb81fc63a098304bad19=
8fadd4aed55d1fec4 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -256,7 +256,8 @@ static int length_to_duration(struct taprio_sched *=
q, int len)
> >
> >  static int duration_to_length(struct taprio_sched *q, u64 duration)
> >  {
> > -     return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_=
per_byte));
> > +     return div64_u64(duration * PSEC_PER_NSEC,
> > +                      atomic64_read(&q->picos_per_byte));
> >  }
>
> There's a netdev_dbg() in taprio_set_picos_per_byte(). Could you turn
> that on? I'm curious what was the q->picos_per_byte value that triggered
> the 64-bit division fault. There are a few weird things about
> q->picos_per_byte's representation and use as an atomic64_t (s64) type.


No repro yet.

Anything with 32 low order bits cleared would trigger a divide by 0.

(1ULL << 32) picoseconds is only 4.294 ms

