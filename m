Return-Path: <netdev+bounces-82046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0191D88C33C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23803B24D0B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12DE74BE8;
	Tue, 26 Mar 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wxul+hoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A667A00
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459139; cv=none; b=RyMXi7rQrf2DUJEgYmn/nCUtgwJs5xxSFerihv/guDA1T0I/MJdexG9yeaeuLAwosJN+8Qh5JC8hRopPishuk11CsQ5zphMEr/Ogl8Bb0f5POHDOC3kynZoyZE484gyb2u3R+EnZpJN9pHV6FITAsh7LhCuigPSj5YKYLgJtcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459139; c=relaxed/simple;
	bh=GkNJWEH5CqftlvwkYmOjBPCjRnY/1N8DRLYtCKkFu+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmC8PijXbuHclIF8BwxXxOyBXGaomnWM306WwF3jCjqEPJmc4uePpdTlatzQV/+PDpISsDXANhLQenirTadMcvJw3ic7HvfC/AA8A0E2sZPGWboNTGM7C/pfoFZ/PvrMuit6tnkAz+BmjXspFyv4IU604v0L0Q0l6UheJM6uCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wxul+hoR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so4739a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711459136; x=1712063936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkNJWEH5CqftlvwkYmOjBPCjRnY/1N8DRLYtCKkFu+Q=;
        b=Wxul+hoRqE3FDD6i4OiwYYohB0HVZbma/AWfcafgcreu8szkK3zyQyd7bpWNR1UvkP
         pjUAv+zdGnut0KLAxuw1J7/PlShWJzfOgnroQlWAGykKBMrXMsStA14KgZOBdSEz/hDi
         PSeVd/EPjAMtoio7CabUOoof54h1tjoE8zS4YAP4KVLxB+HlsUAQrxu35VhPLrK1QdhK
         QC4q3yxlD3XfLvJDnOiO023nxK2U3mBm/v7+J5kZBaJX+k83VESq7zSU1Qg7von2lu7m
         0aoH+H8+uFr232/ue3YZcHjyOaC23JHIFNL+lmAceaF506sKssKzLeCf/0NCxv0DzyXJ
         v07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711459136; x=1712063936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkNJWEH5CqftlvwkYmOjBPCjRnY/1N8DRLYtCKkFu+Q=;
        b=P9qHFWTPzTtmuLcl4J9fAOxGLCKpSjkcT7lwjMmGAzR914IAJYuBHiPBtIjj99MfwE
         O4/l8anRlFpln28FDZ91xd3+yXhcBgeCEYAbKRvAVLqcW9FGw+2jLZ6k6zZtrVapSZfs
         ukfARsIxoK4bU3VBpmfjei9IavKchLolXS3fJHnD41gNejrP3NMQRI08b/ETHVPxJ12t
         stFckYCjZskyqMisb+tKO4iEtoWzXTCDsqJ79KRWc+T5EzTSVLNj/YREjwDoiXRVxe1C
         6QEab+KSXdhHDwnK2pWtz9sDP7h1YTFmXr2/uSLnY7YF4YK6ltnKk5j/oV1ebV8hp1cL
         LVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc/0xtREdxbC9BE6NYldhRf1FiJoF5BxlRJ30b3+p3vgdqFqjXc6C7a9dUQRpbOrjclnjS/8hvEA9ytDLQk6gI4SGuG1bX
X-Gm-Message-State: AOJu0Yw5JcDY7Wx1bevje5KmOOiolJdzv2k5oHLreF5AgTVH5sLxoQhw
	In766gZuKORqH6Kcgc8YIbIAleqPJeRp34eCg9O+0wdtzLJztgetev3/0x6hVH9kOi4UcqZOTFd
	NTucQ6LBG/Vc/mYA4LbB9xTwVRYcgKXr04HRg
X-Google-Smtp-Source: AGHT+IHi8Prjn/pM5ByDmdywvVWKS0LKIb81JDGzPnk4MzG+yQ1Dkqp91W2gUekWaLabtcx1vUU3ZCVd8ljiN7a/sBs=
X-Received: by 2002:aa7:d951:0:b0:56c:303b:f4d4 with SMTP id
 l17-20020aa7d951000000b0056c303bf4d4mr23008eds.1.1711459136081; Tue, 26 Mar
 2024 06:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
 <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com>
 <b84992bf3953da59e597883e018a79233a09a0bb.camel@redhat.com> <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com>
In-Reply-To: <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 14:18:42 +0100
Message-ID: <CANn89iKK-qPhQ91Sq8rR_=KDWajnY2=Et2bUjDsgoQK4wxFOHw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:44=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:

> Well, it's a pity that it seems that we are about to abandon this
> method but it's not that friendly to the users who are unable to
> deploy BPF...

It is a pity these tracepoint patches are consuming a lot of reviewer
time, just because
some people 'can not deploy BPF'

Well, I came up with more ideas about how to improve the
> trace function in recent days. The motivation of doing this is that I
> encountered some issues which could be traced/diagnosed by using trace
> effortlessly without writing some bpftrace codes again and again. The
> status of trace seems not active but many people are still using it, I
> believe.

'Writing bpftrace codes again and again' is not a good reason to add
maintenance costs
to linux networking stack.

