Return-Path: <netdev+bounces-117003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4A94C4DB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84681B23F3D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CEA142E6F;
	Thu,  8 Aug 2024 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMhvR5RT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF94A1E;
	Thu,  8 Aug 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142933; cv=none; b=raQ6HQKllP/J7Vt1tbqs0gZdPkhyDuw07GknMYOfmZuEyAYiFP1wl2vR7mvC5KecKXod8qopYySkwpq3SS5aGv30wOmNTgjJXQoo602gYsLG/dvYKcxRQQQxB/qBkDWYMRPE+ibjGncZLn1JY6Wlw6LwWbkY2PDGywQJfuCfHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142933; c=relaxed/simple;
	bh=/ehFHaaDMn0rzQxH1gATB74JG63gId7TneNI0Ylmf+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4R+PnLJ78Ldeq64JoOIiF6ZQkACtnRDVRxW86BwS98En4HErQ/W/Wou1GvqFF7gyfiztWSWqRocmVBbUW8GGU1dvqcA8b6TuU9Hk+Ek0Qfh+cIaq12avhOonaesOWwehYTMwtnPYSxNjULpBlIrZqI5cyIf3nYJ4vOhHgpDuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMhvR5RT; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e05e94a979eso1852511276.0;
        Thu, 08 Aug 2024 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723142931; x=1723747731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ehFHaaDMn0rzQxH1gATB74JG63gId7TneNI0Ylmf+A=;
        b=YMhvR5RTNzxymIWgL7ZxJb+BRqpTrb5kfUkrNeFHNw8d/QE+VffHP1SmOSsvQ0E8JU
         0lql5Teeu0DtPh0C+/n3ym0wAol0odK1+XWzjHDBpu5SwdlVe7tuDr1r3rVPbyBqeAez
         NjFcyADKFowzMEgBty94XYg2ptypk7Rr8hxDhcBqbRcbvk8GoT1s88Vf3B99QNtX4KCj
         +HBdQ89HUOFei+zymGbhXIGDxFVcZLwfHwd32ByYs1vqIIn9+yQRqTe+zF/+eYo75oHD
         9B8DePyrYfiZV3j0MSph+1LqimotFwiprM+jcw3KpBwAapaCXO7Ph9nSJBsaVcYskty7
         y2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723142931; x=1723747731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ehFHaaDMn0rzQxH1gATB74JG63gId7TneNI0Ylmf+A=;
        b=Op2URbAkVKYoF5pO8qsWnqfNThoZmSYjFdCe3tRsK13rZSARGAaOK0l4HVByMC+tti
         DKofvXZhbV1uXCPkg7AsMntaEXdTBAQhzXylPHapYQ+uFD9Iwre4p+HubvQJNAGavKha
         RK9aUALLTGexhH68meVSIHJXjEZMg88WEYWNansESQL6MurexvoG7DoGVT4RLWEE31kE
         hnA77YQK0eZRNp0+x4EjXziyRl2jufUlMjVUgF2EHjKg3a2UELy3L4VDlamvdfWYLGfD
         lajwbTB3poElqgfGDFDNBcD8JK63b2YZ/l6H08U8gxJzF9oLMEwOYINceDkdKlNQ42xF
         Wwhw==
X-Forwarded-Encrypted: i=1; AJvYcCVEqGeOlv5rV+auhK260nbJXG438WfCMq6WkzRusdz/AkorpInSRIP9/aOkZnUg4jnFxlxQ0ZiOrFJQfjV7ynD4kb4r40FbpA1SU+9nrAsn8feAbfU7WaYlDireae1uxyb6IqBN
X-Gm-Message-State: AOJu0Yw5ELHO/fxKmJ90tCCjahA43dpXs698uImKSBuBfMrLzPJsp3ty
	RwJoVQWKc17EXuur7YMUqVJP1c1uXJlQ+D9DGhVfB5GP32fuJWHqYN32Qyc/FXSHitgXH9AM/wA
	pyaPY6TVuJdcyh6P96QN/R/U5M2c=
X-Google-Smtp-Source: AGHT+IFW1W8XU3tGNGYJodhTWxFp3JWvIfGQTKMaOKZXObePiPsAj++tbm+UuE2g930RM+PEfiymaMkzELPr4+685Qk=
X-Received: by 2002:a05:6902:1894:b0:e0b:28f5:3ff7 with SMTP id
 3f1490d57ef6-e0e9f6f387emr2518589276.4.1723142931094; Thu, 08 Aug 2024
 11:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF=yD-+2SnOzALmisVVBZAKNKrCMv07FdEDP1ov35APNMYOTew@mail.gmail.com>
 <6C9DA933-5EAA-4711-BF89-0B71834DA211@soulik.info>
In-Reply-To: <6C9DA933-5EAA-4711-BF89-0B71834DA211@soulik.info>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 8 Aug 2024 14:48:13 -0400
Message-ID: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: ayaka <ayaka@soulik.info>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > So I guess an application that owns all the queues could keep track of
> > the queue-id to FD mapping. But it is not trivial, nor defined ABI
> > behavior.
> >
> > Querying the queue_id as in the proposed patch might not solve the
> > challenge, though. Since an FD's queue-id may change simply because
> Yes, when I asked about those eBPF thing, I thought I don=E2=80=99t need =
the queue id in those ebpf. It turns out a misunderstanding.
> Do we all agree that no matter which filter or steering method we used he=
re, we need a method to query queue index assigned with a fd?

That depends how you intend to use it. And in particular how to work
around the issue of IDs not being stable. Without solving that, it
seems like an impractical and even dangerous -because easy to misuse-
interface.

> > another queue was detached. So this would have to be queried on each
> > detach.
> >
> Thank you Jason. That is why I mentioned I may need to submit another pat=
ch to bind the queue index with a flow.
>
> I think here is a good chance to discuss about this.
> I think from the design, the number of queue was a fixed number in those =
hardware devices? Also for those remote processor type wireless device(I th=
ink those are the modem devices).
> The way invoked with hash in every packet could consume lots of CPU times=
. And it is not necessary to track every packet.

rxhash based steering is common. There needs to be a strong(er) reason
to implement an alternative.

> Could I add another property in struct tun_file and steering program retu=
rn wanted value. Then it is application=E2=80=99s work to keep this new pro=
perty unique.

I don't entirely follow this suggestion?

> > I suppose one underlying question is how important is the mapping of
> > flows to specific queue-id's? Is it a problem if the destination queue
> > for a flow changes mid-stream?
> Yes, it matters. Or why I want to use this feature. From all the open sou=
rce VPN I know, neither enabled this multiqueu feature nor create more than=
 one queue for it.
> And virtual machine would use the tap at the most time(they want to emula=
te a real nic).
> So basically this multiple queue feature was kind of useless for the VPN =
usage.
> If the filter can=E2=80=99t work atomically here, which would lead to unw=
anted packets transmitted to the wrong thread.

What exactly is the issue if a flow migrates from one queue to
another? There may be some OOO arrival. But these configuration
changes are rare events.

