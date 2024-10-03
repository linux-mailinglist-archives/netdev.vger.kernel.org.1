Return-Path: <netdev+bounces-131749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A854898F6C4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507E51F21041
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971A41AAE31;
	Thu,  3 Oct 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrkC6Pwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB31A4E8C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982449; cv=none; b=hmJSMdWKBV5KmoDumbdlWzo5388XDkxhcacBsVEAKXBh7w23m83Ss1GyT4D4Uh9Kvs4Oi813YOP+tjeu97kl32llUNL6HNmBe76smKuSRfj8HlHDQJfcnMQ8yopU/fSzKDifnk1aGAkSRGJtI8f+wFPxu5fvmSWtIwa+yQVql/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982449; c=relaxed/simple;
	bh=56+W8I5rf/VRMtxZ0hYiyZDrcwiHGW/bQCHLgD/Onh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ymx38gbXzKwYKvB7ajzOSaIibEAykuOCB/h8aPjwU0VlWVzB67vLd6sEE0yaym6zMeBOp3Se9m9MuNnIjWkpgzSPSiVGqBlgcVLnu/UW5T+RNrjtwup6uJeQ3taiD7guwewTrulUOhlkbL3Vk33eaujIvWbKvrA2CUB92UkSeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrkC6Pwf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45b4e638a9aso52721cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727982447; x=1728587247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I3Ez1fkxWMYJUikFpXnxqbNaL6WRzAzJoASsMuh6D4=;
        b=PrkC6Pwf2zzxkq1LxK8sqri+Yj1X+6aUuJUTC3JBccj4alFoHP01IPy913qKksqDQn
         RztRTusEv90zC02T3FmqDrwuOel0RPamBRGWIF9vI+bIY15c4u+21C1fLTGpV5TRBEbe
         21bWzVrbgfV/urtOTTgoWrwlxt3NlvGsKRgh60MWcCWfoiZTsjABkmKdk/sId+JAEjJ4
         1ozMd+7MqPyE3OCI05DX8u3YOjyIWN02Mf013oH3NBMes13XV7UaIX8JsQ1Qrgql6PAc
         3dCvhVP4C0Lrj2+9DDRl7f1cMhmNfZt3XzTbqS4X5rn9Vkb9axtny5z95GQEQeXJ9Dbn
         ciHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982447; x=1728587247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I3Ez1fkxWMYJUikFpXnxqbNaL6WRzAzJoASsMuh6D4=;
        b=Jj7qauhQDkesm/DDFreDSnH2p0ySVa10JTcjg57Ra5hD4ENoB8cB0I4Sz5vuT6tRg0
         oqXHv3R9c3KGpwNeVvU6GeMFH7AZhkmPkkUnYWNO8cnfYryNdit7Q9PHZMECLXkKPMcO
         ciwdFCOOLkvtCI6q5SakyXE4LoWV6fbbk3gZah3tvQxxpPu6p+ZeJxiuOnzBfsBt4cUh
         Wvz8M3S/2h9t541iiNAcxBDhmQUrc5fbWS5YvhMWcqIbvZG6UQ19A3GnSb4mVuGgqyKn
         ReGnD+FI9i/H1zKthr2nqxNKKpN8nUZriQfuZWWQy2vDBA8nLCdn2BvgaoMY1qYjM09h
         aqPw==
X-Forwarded-Encrypted: i=1; AJvYcCXXgp6WvXZPcpxGaZQp++FtEYPX17RRm/Qj7VbEUc3lVJFl3mfIUipmdBMMCM1INXfrtjDy6qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTCUXwCNVTbJ372cm5uAqQkpdZ3CDHJY8HlQh9O1Ohwg5SpeI
	Wf00aXmAGnlO5F4mDkjfEgX5/n8q7A7WwRYrFAh77LKYr68tGcSXT5mI0kTKSWkmtte6N9ZZu6D
	UfgFXH5Lel7ipp9bI8RplXH9gIgWVmKWsHvCgocu1d9P3YCaj5w==
X-Google-Smtp-Source: AGHT+IGzMRpQURueoZCJcRy8QJvZ2wcGZhf1Iw/lbS3ZvjG9aXFEMw/enW89HpX8WC3jO5BJaEmayqbpzIyyL/BOlTU=
X-Received: by 2002:a05:622a:458b:b0:456:7ef1:929d with SMTP id
 d75a77b69052e-45d9bda1f9fmr105171cf.12.1727982446639; Thu, 03 Oct 2024
 12:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-10-sdf@fomichev.me>
 <CAHS8izNK+DiQUUkkvnPQvBRJiQ32WRO0Crg=nvOW9vn_4kCE+Q@mail.gmail.com> <Zv7OMcx2yff-QSO9@mini-arch>
In-Reply-To: <Zv7OMcx2yff-QSO9@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 12:07:12 -0700
Message-ID: <CAHS8izOJaGk5g9m-DgBJE13XDcgdXNAbbBq9MmcjH229cSVoxg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:02=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/03, Mina Almasry wrote:
> > On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > Use single last queue of the device and probe it dynamically.
> > >
> >
> > Sorry I know there was a pending discussion in the last iteration that
> > I didn't respond to. Been a rough week with me out sick a bit.
> >
> > For this, the issue I see is that by default only 1 queue binding will
> > be tested, but I feel like test coverage for the multiple queues case
> > by default is very nice because I actually ran into some issues making
> > multi-queue binding work.
> >
> > Can we change this so that, by default, it binds to the last rxq_num/2
> > queues of the device?
>
> I'm probably missing something, but why do you think exercising this from
> the probe/selftest mode is not enough? It might be confusing for the read=
ers
> to understand why we bind to half of the queues and flow steer into them
> when in reality there is only single tcp flow.
>
> IOW, can we keep these two modes:
> 1. server / client - use single queue
> 2. selftest / probe - use more than 1 queue by default (and I'll remove t=
he
>    checks that enforce the number of queues for this mode to let the
>    users override)

Ah, I see. Thanks for the explanation.

My paranoia here is that we don't notice multi-queue binding
regressions because the tests are often run in data path mode and we
don't use or notice failures in the probe mode.

I will concede my paranoia is just that and this is not very likely to
happen, but also if it is confusing to bind multi-queues and then just
use one, then we could remedy that with a comment and keep the
accidental test coverage. It also makes the test simpler to always
bind the same # of queues rather than special case data and control
path tests.

But your 2 mode approach sounds fine as well. But to implement that
you need more than to remove the checks that enforce the number of
queues, right? In probe mode num_queues should be rxq_num/2, and in
server mode num_queues should be 1, yes?

--=20
Thanks,
Mina

