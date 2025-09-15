Return-Path: <netdev+bounces-223178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FCB581F6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0471B2022C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA0279DA6;
	Mon, 15 Sep 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSoP02Cs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A92773E3
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953628; cv=none; b=cfHDIf53cw597QZSOwCXklSDrc5JAOQIoFHZYYjDEUeqalnWFideuSsKUYKnnHPOR8+M59y+Iy6U1LrlRu+53Jc7gf9XGgj1FPhXgBrfTRK5JlMQq7h2dpc0CHH4Cg8eJnJEZ7T6pJ3g5cSn+2PBGCZRO10qC1Ty8AscSOG2gHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953628; c=relaxed/simple;
	bh=K72aTny/foI39RTlEvGtWZn6BiHzkdjqS0krzaYEY3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqxVVzhbqBvuaQBM4bdM8WZa4MLqHTnNMSGqQLT/EhDt+sI4pjqiSKhpCjJIvSZW8SlewKXSGIQC+cdrOme0w1RCgKQc5VYW/30I+5B3PCNflxxa7J6tp8RulyXA/6rtklJOtvJ/EmCHZBDARpRQQrYRcCGLM9yqfhH+Y3lNkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSoP02Cs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2637b6e9149so353065ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757953626; x=1758558426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K72aTny/foI39RTlEvGtWZn6BiHzkdjqS0krzaYEY3c=;
        b=qSoP02CsjT+GCpJdtAgfkBWXnAsJU0Buh9hTL8QPEPMUxjpEIAUHqeUWKNVqOPkUL0
         kpsNZM3A2e4UubkF1KFP5pCb3Ox7BxOBVB8kLJfdvYuqdQCesCRslkZXKAINmd6zN6Ut
         A+UYiVJxTY6QzFUp2mXjQ+n2gY6gkKFNWqpXWTAzyOoGl2Yb08AmaMgHuqhuTjgiBBb0
         0oqds8szRX0Jpx4yzyKQoavLn+C9KQ8rHIF9FU66LNXcoOa1HJzHeUW761vgu/8hXCe1
         qO1R+5xGYaTZ7hBJ3mDC2QieL8mVftYPE1w1w5+Iz1UiZNjxL4erFC6POt3LcSxTAX1S
         WI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953626; x=1758558426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K72aTny/foI39RTlEvGtWZn6BiHzkdjqS0krzaYEY3c=;
        b=fYiSVSatx8o60/mLEuIaHZhUEykh2s6pg9yl3XdxtFqJ+jCurVzZ8P2lmxkD3cc25q
         xEomhuXtcGJyn7zgoAGsNZGhoq39o5FYUVSXkbYse71qxtA9tBSYXFnXizhotrsGnYsH
         8DJJon/bUcN7zKoN5kUGoFiwrF3Z5eYAVMIvmMF9mZnRElq3uqOtccWZtRSFlMyVC6vq
         kmGgitxgDoPIR1u6c0OUpQsHJDUxLgcIrRNoehag8ORBFpZhM+p9BFThSoj4GAzz7Bla
         RA23Wc3LBvKMUxc/8GMGJ9v9TeKjf5XW7xfi/q98b/mfw+j/XEHLISljVZFxc7Gb4aZ8
         MX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZnakpTWQl55kgKOsG43lNMuCRp3MurbJKbLxGzM4q43NPHZEXauPIJaDEkXuAuX2h7Mgc6r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+AVXkZXkPnGpAEdHoRVbZXquHj7rh6+HtjiGFBpCrNixpR2Ht
	DAmGzP2L7tsTZlpOGztImGFC2OBpckB8L5OWWfp1QPU2+7tlzGf49lWoT3bOf/4LvuGCr4HIxEA
	CK7sTTOR0S08kDLC5ugwGTQ1CN5NbL90oTLbh0dVB
X-Gm-Gg: ASbGncswWsPnzocRotxXvFvK1/TFj41oIurg0quCocR1PNZfKPHox8YkHJYwg1m8i3z
	Ggs5kWTka0H3eLFhCmVg/zMIThE0BulVTlxYwEqn31EobPnYqVKbbJpkm4tcXRXnSNW6fuQV/xE
	wv3sEwQWGFOeilAxoreCjLjMbvBuw2lcVsW00pibuu35JH5wn2iUTAS7xZcBk5SDuTWGChr6c6Z
	w9bRD5X4dpi4jMkBA3mlozSMgm2dhotrvk2FNhGhBk4AkcIdxREypN0209pmZY=
X-Google-Smtp-Source: AGHT+IHI/kbw17DXHqTYYVv1WP3kfyR7Z6wsUf9aj5t3lF9b55WJe1QvW2KmealNZH7KxM7QUM7wpF2G3GruHZqeQG4=
X-Received: by 2002:a17:902:d4d2:b0:265:f30b:ab00 with SMTP id
 d9443c01a7336-265f30bac8emr3837415ad.17.1757953625626; Mon, 15 Sep 2025
 09:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911212901.1718508-1-skhawaja@google.com> <17e52364-1a8a-40a4-ba95-48233d49dc30@uwaterloo.ca>
 <20250912190702.3d0309a0@kernel.org> <727f0c1f-8ffd-46ba-936b-28db32463c39@uwaterloo.ca>
In-Reply-To: <727f0c1f-8ffd-46ba-936b-28db32463c39@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 15 Sep 2025 09:26:54 -0700
X-Gm-Features: Ac12FXxTBu_OahdkhWpZuiE5NrBRAGORu0ftHj1X0gt7k-Ccg0fUQb30KRfldI4
Message-ID: <CAAywjhT7p=6MHw6S5SBmq5aPt8QaxCewpUGNQdTbur=9SfLFsA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 9:03=E2=80=AFAM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-09-12 22:07, Jakub Kicinski wrote:
> > On Fri, 12 Sep 2025 04:08:21 -0400 Martin Karsten wrote:
> >> The xsk_rr tool represents a specific (niche) case that is likely
> >> relevant, but a comprehensive evaluation would also include mainstream
> >> communication patterns using an existing benchmarking tool. While
> >> resource usage is claimed to not be a concern in this particular use
> >> case, it might be quite relevant in other use cases and as such, shoul=
d
> >> be documented.
> >
> > Thanks a lot for working on this.
> >
> > Were you able to replicate the results? Would you be willing to perhaps
> > sketch out a summary of your findings that we could use as the cover
> > letter / addition to the docs?
> >
> > I agree with you that the use cases for this will be very narrow (as
> > are the use cases for threaded NAPI in the first place, don't get me
> > started). For forwarding use cases, however, this may be the only
> > option for busy polling, unfortunately :(
>
> Yes, to the extent possible (different, old hardware) I am seeing
> similar results for similar test cases.
Thanks for reproducing the results.
>
> In terms of summary, I would like to see a qualifying statement added
> prominently to the cover letter, such as:
>
> Note well that threaded napi busy-polling has not been shown to yield
> efficiency or throughput benefits. In contrast, dedicating an entire
> core to busy-polling one NAPI (NIC queue) is rather inefficient.
> However, in certain specific use cases, this mechanism results in lower
> packet processing latency. The experimental testing reported here only
> covers those use cases and does not present a comprehensive evaluation
> of threaded napi busy-polling.
Sounds good. I will add this to the cover letter in next revision.
>
> Thanks,
> Martin
>

