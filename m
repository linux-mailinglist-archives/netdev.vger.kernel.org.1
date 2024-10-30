Return-Path: <netdev+bounces-140258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCF9B5AE0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEAE1F24A9C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 04:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEE1974FE;
	Wed, 30 Oct 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="di6vNmjI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91717BB21
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263904; cv=none; b=AkI5wVNxLyqHaMCnKnpKChAmvT/mFgDIgamo5xitSGvrdLK6aRTvbyceD2Eqmfy15Pl6mg5KA2vW3dbU9rd+b8c30qSOW4HA+ygWfWWOZahbmeaaucAvikRC178QA7EOE0p77iYuk0NPXkOQ8bX5eDeZivp4Apx3Lv6xbaJhAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263904; c=relaxed/simple;
	bh=iEoe/dpFSsSYgaQARfbg+umaQiT4fehoYGwQqojoqcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3j470IrfTjJIPQ5P05xvCVLDVx6VZ1ssc03yPZLNG3YF7zRWk8fh3LQlRGUYTDHm8HnfCBM4mBoo2LAEPZEUJgPlPJYPWpU2JBbtMV5pZgzXJ//vhInqo9FmwWD/ZNuH4J9xUTq4rg03LLmsWl7ZhSq9rnYiDdvGYDM9IBmhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=di6vNmjI; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ebs0TR2J+jkHH1n14ZRY+Ry9J73X6zCMMzABdsgiGFM=; t=1730263902; x=1731127902; 
	b=di6vNmjIzV7s9UJP7e0MM99nXXPL5b2JB+IrFMw8wn5bHDdveT7LSW+URoZhfGYRM6Ky9ivUPBR
	fbUlclwMpPJTKX6m9Haq9rq1wsE1RRERCzoGj+SMVPVy3AnFScy9X5fb+XUCNrFreRxx4I8mHPLeB
	bwbsMYJVDk8euA8Uszl0WrB0uZl4KPjEZjV0vQLOu5Wn1wYitgspUIR/zf+KN8YZBFOLuzb+hK/6t
	7FYdUY6PGR5Se+oHs7CopeMbP9KQ8dE5jPInwp6WfgEESvFztC7MHT5XBle+lLVctkV0sPe4Li/Oy
	0SLkl0YMwxu/EWWWsAVtuo9F5TypxXyFP8xQ==;
Received: from mail-oi1-f173.google.com ([209.85.167.173]:58688)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t60gG-00010V-Gb
	for netdev@vger.kernel.org; Tue, 29 Oct 2024 21:51:41 -0700
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e607556c83so3619080b6e.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 21:51:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YwCThmPmBp3w2QH48ivVNo4yAFaBLT3jKbeu8wcYe1Lq+Zxt53c
	K2I2/T8byxS7f7sQ0toU40d/eJcZS/9FUCo2DflQjSxXWRtQi+Co/kgaHsWmFHspdIK19VqbTlc
	59yUwzkNB+c61Ay6cb6GmNpiGHpo=
X-Google-Smtp-Source: AGHT+IF6T8CtmSRl/jtALfN8be7uF65AvEoMqSUxfGFn6I/g0DF+PP+4P4yzcdLV61ed8bdhyqTNmkmIS40TxuLOtP0=
X-Received: by 2002:a05:6808:3a07:b0:3e6:2889:5fa7 with SMTP id
 5614622812f47-3e63846bc52mr16160289b6e.27.1730263899951; Tue, 29 Oct 2024
 21:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-9-ouster@cs.stanford.edu>
 <1ec74f2a-3a63-4093-bea8-64d3d196eac6@lunn.ch>
In-Reply-To: <1ec74f2a-3a63-4093-bea8-64d3d196eac6@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 29 Oct 2024 21:51:02 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwaqMs12YtHMZRN5bbqOor2gVe+cCo=JqduaoXsErCY=w@mail.gmail.com>
Message-ID: <CAGXJAmwaqMs12YtHMZRN5bbqOor2gVe+cCo=JqduaoXsErCY=w@mail.gmail.com>
Subject: Re: [PATCH net-next 08/12] net: homa: create homa_incoming.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 7e839a9fe5d3c1ffc6f045e071031982

On Tue, Oct 29, 2024 at 6:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +int homa_copy_to_user(struct homa_rpc *rpc)
> > +{
> > +#ifdef __UNIT_TEST__
> > +#define MAX_SKBS 3
> > +#else
> > +#define MAX_SKBS 20
> > +#endif
>
> I see you have dropped most of your unit test code. I would remove
> this all well. I suspect your unit test code is going to result in a
> lot of discussion. So i think you want to remove it all.

Makes sense; will do.

> > +//           tt_record3("Preparing to poll, socket %d, flags 0x%x, pid=
 %d",
> > +//                           hsk->client_port, flags, current->pid);
>
> I also think your tt_record code will be rejected, or at least there
> will be a lot of push back. I expect you will be asked to look at
> tracepoints.

Oops, I have a script that strips out all of the tt_record calls, but
it missed the ones that were commented out. I'll take them out.

BTW, I did some experiments with tracepoints to see if they could
replace timetraces. Unfortunately, the basic latency for a tracepoint
is about 100-200 ns, whereas for tt_record it's about 8-10 ns.
Tracepoints appear to be more flexible than timetracing in some ways,
slightly worse in others, but a 10-20x performance hit is a
showstopper for the kinds of performance analysis I do. I can imagine
people won't want 2 different tracing mechanisms in the kernel, so for
now I plan to keep timetraces in the GitHub repo but leave them out of
what's upstreamed. The downside of this is that it will restrict my
ability to debug problems that occur with the upstreamed version.
Maybe we can revisit this at some point in the future...

One of the issues I face is that acceptable latencies for Homa are
often 10x or more smaller than acceptable latencies elsewhere in the
kernel, so it's hard for Homa to use existing kernel mechanisms
without sacrificing its latency potential.

> > +             UNIT_HOOK("found_rpc");
>
> I would also take all such calls out.

Will do.

-John-

