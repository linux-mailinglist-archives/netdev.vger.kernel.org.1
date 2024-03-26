Return-Path: <netdev+bounces-82058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C988C38E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68ACF1F3857D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733C76901;
	Tue, 26 Mar 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdhOSbQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22085763F1;
	Tue, 26 Mar 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460078; cv=none; b=mjILfgYoVi8D+gaQWYRWd2kjGdzqoQVt9mOO2chIObYPJduu7Vd4968fhHPe4NXoWofSfZ3mgoM5+1eh1nZd4sgBRsY+ajhZ9qr+8Ao7meMjWGasi/hB0gAMiKan9vr6nIOiKAJdEFNacDzE6KBuElSD6svR3WXYBnatdl5PvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460078; c=relaxed/simple;
	bh=hv+PGuhsTxD1BcgqQtHnAlyD2PF/guDaBxGu+ZRp8zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPRqeIH5BXWdectTuw3HOwDDmS3m6fR1ImrByEWalRWlp+YhwM1eHVdqxxt3XhNEfx3tIGBLWUvLxPwzztJeo65hqngqxZAnvvnbLcbKuWVEqFgb7BwZ0oAHXWHo/1EeY8gKodZcz+62OR78wONADt15t2Cb9jgMiNbGz3wpSTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdhOSbQv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so7112773a12.3;
        Tue, 26 Mar 2024 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460075; x=1712064875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv+PGuhsTxD1BcgqQtHnAlyD2PF/guDaBxGu+ZRp8zI=;
        b=PdhOSbQvTQe4ZlihtMxLYHMeC+R3mJLN2Go3YtKj+Xv4kMWE1BiuTHIKdETyz/K5Fn
         LGxBk1OKI3xQSc3gT6Fmp6SKDmuz+4O1N1vD2Ng1PpNPIZEf66tnP5RupIPe/o6WeEnv
         LDZdTNeawI9MBLqUsl70axIARbwRvD6ldHb1Lkc8ctzpioKITaHjqXYgdutDu+ECOZDX
         wjBpkExgJVIBJ4BYg4JqZLRtIaiBbrfu/A25XwIczHGeXyCyCwg80yjbbkKd5XOrNSQj
         J+ExZZnutNHUie91dwVjq9CbHnbHK4qBCjicRrxeDW7csOwhEFkAO0eaWBfWcWTbpNJ7
         v7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460075; x=1712064875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hv+PGuhsTxD1BcgqQtHnAlyD2PF/guDaBxGu+ZRp8zI=;
        b=MMftFFj/o9o1tYcWDlWJHHQU3lpKv15ig8Et4x4Rwah9lWSlVqO5HN2DyExcFyevIV
         UexDgHEfrjcvW3c+DfXDuysQ7VmqR/pmKpa54/gjka7P9nLKfUeQ8cwZno+lLhzhRt3i
         HK8cn7Sp8nFmePjG2cMjm0TEq/Jtbhr1/WVPHY1jYMv0lrL50pQ+wj/ngd84k2Nt7ULx
         tiDcTUbKtcSF/l/sM3SFMH+TkuOWpdxXEMHOBFZT/ZJylHE/ILkCcxHVfHdiK34Ybha2
         c2I5Vj4OcuCBNyOfIIY6E+z0e70LXfMVvKLspdqWKGSlrUrJhlSes4sn1aMlTbaYT+/u
         CDVA==
X-Forwarded-Encrypted: i=1; AJvYcCXVtQNPhAfsoa2XD4F3AXHeTrVPaOyiRrE/YvjPcZJHhRHNbxWVUtEWfoaobI3abg931GqJmHLYHxiu2UjyuZ8sH4a+Djb4ktBQzNs9dVmr1mRqs3YiTuTTDn09siipWYhfrdVhyduC3xVd
X-Gm-Message-State: AOJu0YwQCLs4+UCFjNtLXfJdqjPIZnSkzMoA7wzDH/XPLl+F0Eou+I8P
	gtTgAeS+xCIzSKL3cwerkZLLAyqG40uDpJYWdVBUEVOZKRT83inQkmxaG1YjaneSyE8zU76k8t/
	zMpYBvBcqsxRFrF8G4s1ibNUDOY0wSCyGyo8faw==
X-Google-Smtp-Source: AGHT+IFebIu2ouRnyG50yataUMJvTNYmfp4RjbN16ta5wmEBUPaemij5rqIzEi9D6Ly7a9bVF6i7k5+sYZHb4FeuZzM=
X-Received: by 2002:a17:907:20ab:b0:a46:7e07:e66f with SMTP id
 pw11-20020a17090720ab00b00a467e07e66fmr967510ejb.0.1711460075172; Tue, 26 Mar
 2024 06:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
 <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com>
 <b84992bf3953da59e597883e018a79233a09a0bb.camel@redhat.com>
 <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com> <CANn89iKK-qPhQ91Sq8rR_=KDWajnY2=Et2bUjDsgoQK4wxFOHw@mail.gmail.com>
In-Reply-To: <CANn89iKK-qPhQ91Sq8rR_=KDWajnY2=Et2bUjDsgoQK4wxFOHw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Mar 2024 21:33:58 +0800
Message-ID: <CAL+tcoCpOqBrnSko2rYYCAqfbZxSj0jmM1uMB58HgPLYCAuiMQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Mar 26, 2024 at 11:44=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
>
> > Well, it's a pity that it seems that we are about to abandon this
> > method but it's not that friendly to the users who are unable to
> > deploy BPF...
>
> It is a pity these tracepoint patches are consuming a lot of reviewer
> time, just because
> some people 'can not deploy BPF'

Sure, not everyone can do this easily. The phenomenon still exists and
we cannot ignore it. Do you remember that about a month ago someone
submitted one patch introducing a new tracepoint and then I replied
to/asked you if it's necessary that we replace most of the tracepoints
with BPF? Now I realise and accept the fact...

I'll keep reviewing such patches and hope it can give you maintainers
a break. I don't mind taking some time to do it, after all it's not a
bad thing to help some people.

>
> Well, I came up with more ideas about how to improve the
> > trace function in recent days. The motivation of doing this is that I
> > encountered some issues which could be traced/diagnosed by using trace
> > effortlessly without writing some bpftrace codes again and again. The
> > status of trace seems not active but many people are still using it, I
> > believe.
>
> 'Writing bpftrace codes again and again' is not a good reason to add
> maintenance costs
> to linux networking stack.

I'm just saying :)

