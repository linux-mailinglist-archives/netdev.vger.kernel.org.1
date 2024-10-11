Return-Path: <netdev+bounces-134435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA79997FB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 02:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7721D1C25F43
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C680603;
	Fri, 11 Oct 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gMQQ8Kg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3723BB
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606770; cv=none; b=PUxSd1tDYeLPMMjJOuwu4yqQ4LYEyiX/vxDCimk5bnXRvJJ3nfkuDFLVNYdGel0L49qczHWxh/wHwLmYgCSCmDNWY5QdHxLaLTyvcQq4VucWajq6wDBguZLLogR6jtdmiCbb0riBvWQYZt/oLWYmzgr7zFfoVeiHjYS2afjwyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606770; c=relaxed/simple;
	bh=UEm4w1+/BayVnYEyIYhV9w3Mjz/x786XWJdv52Ozd44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caftJwgv8pKTA8vzfyVVa6JOFQp7lhWcI03liBAij/zJB+AmjJe+RBf2C0yh33brKmNPjgPnYjCvZzdWN/Y8oF2T41USwCiwybLr1HndD3kIfTGjddWqXPy+IbW7KjooIJoc4Hklbqm82jS8j3tB+dNsArr6Z4hBfaegGf0xOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0gMQQ8Kg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4601a471aecso77621cf.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728606768; x=1729211568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEm4w1+/BayVnYEyIYhV9w3Mjz/x786XWJdv52Ozd44=;
        b=0gMQQ8KgXrQRX85BoMveORkRYFrWllAqf5g7PNXYyDxJ4ftIB9hWMKDc8Japsoehn3
         2Wxm2XXuGzUfSrMxwSbZ2Jh/paBp92LRjI5xOEDydzjA3m16PsCAf/R8BX3AqThSxrXK
         qnZOC6moVn5kylGayrcnebFuDjiOYvf+9vvEy6SHxWstJ3YCggyi373VrKkJNIaT/kl4
         lJHVcuh43A3DZM4fald8MR0obCCVDh780SwzglI19jtA0rhcAN419z7Zp6f6aybVJu4m
         wPUXed649J9iMNWBH5GmGLXvWG9ALyo3M1D/CTxdTxd296DR5Z+9Cao+rOoGB3mZxooR
         ZDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606768; x=1729211568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEm4w1+/BayVnYEyIYhV9w3Mjz/x786XWJdv52Ozd44=;
        b=FlWnaCEu0BcTQA8KRHi6OpvgFmT7uZJgwDtWBI3UTJaxR+uwmemvrM9nPuSCNJJC7M
         +VijNeZKaJEExUV1JQ6R60mkBBuuAd+8MVYVftAJPpHN2RtE5j3/cmEYvQ2CF7k28P0e
         zuDa7APNgKdJIMKtqYSATy4XRo164GSKodOTSdH5pmyLwSORpMqtj6kaJOEJmr21nuP5
         LSOB31wycmLQs4JQ3wgDAQOrQtbHioBqL+xQdnfVpA9Gsf5CZax2gLEIXOFCU4YaurQF
         OEKYsCtCGV51xgkz5dlkBzDC5DMHsmmdSsUjUFMiaGxbiJGJXOFXswRPwgoLjSTfNMqn
         vplQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPAfttRIsOxSIS8B5qAxTVGb//uGEdqxsCxXA3ODxZ6stUAYKtby319MPEml1Xvsuc0cV8LQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73I7Qi80jSMFEW4vZCmyV6r4MmCzEiXmOWjB8vEyAzA+wr+Vi
	Qw4Bv7L1C2ES7v6A/jcDiO5KpbM+bPstu5W9SXiokYddigr/TS5tncPxyln5uYWK228PTJWrGTP
	TU5vPa4zHtH4D192O2r62hK7WBA35v9ZHn4h1
X-Google-Smtp-Source: AGHT+IFa3X3kXCvbMNV8e/CL1FECdovrHzWeLXI7K0gOLD45vSyGS+b4KWyH5KzMfNcOFtFTiBBiLpw+Z9LcZ01I2vQ=
X-Received: by 2002:a05:622a:7b8a:b0:460:463d:78dd with SMTP id
 d75a77b69052e-4604ac30a33mr1830201cf.4.1728606767741; Thu, 10 Oct 2024
 17:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007221603.1703699-1-dw@davidwei.uk> <20241007221603.1703699-12-dw@davidwei.uk>
 <CAHS8izO-=ugX7S11dTr5cXp11V+L-gquvwBLQko8hW4AP9vg6g@mail.gmail.com>
 <94a22079-0858-473c-b07f-89343d9ba845@gmail.com> <CAHS8izPjHv_J8=Hz6xZmfa857st+zyA7MLSe+gCJTdZewPOmEw@mail.gmail.com>
 <f89c65da-197a-42d9-b78a-507951484759@gmail.com> <CAHS8izMrPuQNvwGwAUjh7GAY-CoC81rc5BD1ZMmy-nNds3xDgA@mail.gmail.com>
 <096387ce-64f0-402f-a5d2-6b51653f9539@gmail.com>
In-Reply-To: <096387ce-64f0-402f-a5d2-6b51653f9539@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Oct 2024 17:32:34 -0700
Message-ID: <CAHS8izMi-yrCRx=VzhBH100MgxCpmQSNsqOLZ9efV+mFeS_Hnw@mail.gmail.com>
Subject: Re: [PATCH v1 11/15] io_uring/zcrx: implement zerocopy receive pp
 memory provider
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 2:22=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> > page_pool. To make matters worse, the bypass is only there if the
> > netmems are returned from io_uring, and not bypassed when the netmems
> > are returned from driver/tcp stack. I'm guessing if you reused the
> > page_pool recycling in the io_uring return path then it would remove
> > the need for your provider to implement its own recycling for the
> > io_uring return case.
> >
> > Is letting providers bypass and override the page_pool's recycling in
> > some code paths OK? IMO, no. A maintainer will make the judgement call
>
> Mina, frankly, that's nonsense. If we extend the same logic,
> devmem overrides page allocation rules with callbacks, devmem
> overrides and violates page pool buffer lifetimes by extending
> it to user space, devmem violates and overrides the page pool
> object lifetime by binding buffers to sockets. And all of it
> I'd rather name extends and enhances to fit in the devmem use
> case.
>
> > and speak authoritatively here and I will follow, but I do think it's
> > a (much) worse design.
>
> Sure, I have a completely opposite opinion, that's a much
> better approach than returning through a syscall, but I will
> agree with you that ultimately the maintainers will say if
> that's acceptable for the networking or not.
>

Right, I'm not suggesting that you return the pages through a syscall.
That will add syscall overhead when it's better not to have that
especially in io_uring context. Devmem TCP needed a syscall because I
couldn't figure out a non-syscall way with sockets for the userspace
to tell the kernel that it's done with some netmems. You do not need
to follow that at all. Sorry if I made it seem like so.

However, I'm suggesting that when io_uring figures out that the
userspace is done with a netmem, that you feed that netmem back to the
pp, and utilize the pp's recycling, rather than adding your own
recycling in the provider.

From your commit message:

"we extend the lifetime by recycling buffers only after the user space
acknowledges that it's done processing the data via the refill queue"

It seems to me that you get some signal from the userspace that data
is ready to be reuse via that refill queue (whatever it is, very
sorry, I'm not that familiar with io_uring). My suggestion here is
when the userspace tells you that a netmem is ready for reuse (however
it does that), that you feed that page back to the pp via something
like napi_pp_put_page() or page_pool_put_page_bulk() if that makes
sense to you. FWIW I'm trying to look through your code to understand
what that refill queue is and where - if anywhere - it may be possible
to feed pages back to the pp, rather than directly to the provider.

--=20
Thanks,
Mina

