Return-Path: <netdev+bounces-192388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD40ABFAC8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050BF1BA5D78
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA822D4D8;
	Wed, 21 May 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcdtLl5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2A22D7A4
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843019; cv=none; b=URFw/1hOAFvSm8+BB69JGwWEayUw9EMDSWd5d9rwrY0cxlw/aUNRoY3QubqsoHOAzkc9TniPk2ECaCi18I8nIxVv+9ctIRNoWjvPOvbgR+6dy6StMdz4f5wzr4o+itbRv4q5KBEL0xeItR17ZmqpGRpXo5ugNDvT0kATQt79ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843019; c=relaxed/simple;
	bh=ycOICGq410eJ0S7Ho5F6jZmlbC0WZarTGfqVATdQ9i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDJ54iLHeJUEoTxbEx6b8KEwErSwppdArr1fWZIOVtShO0c+/RDaZnbBJpGGS8SwhTSH9GVAylvv2Oyj1KZ7N01oWBCGboKDLPMh8YsnD7oHCKHY+4D/YSE+a+FShRHFANAlTLs1sqyCu9dlnCAZcG8oqEQs6apV0VYhodRkTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcdtLl5K; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4774611d40bso1190851cf.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747843016; x=1748447816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkp8/KQCYPe4X4RChScWld8jG0gqKsuj1b9ATe0EBbM=;
        b=kcdtLl5KW9QmorJpFMMAqxXFHdEsK+JbL5mYUVxCR3TKOl56IbCqZQlY/LMFo+vp+z
         1ZNNeq+gVGMw64NGvet4oW49FKoInfcD3XYBaa6cbe6ggqieT1lG9XuBdsHLJSEinm1S
         XfPO4fNF6ufLOtlRtNzIfuxPy/u0IMTsnpQTWNmMNLxaWomDp8BixAXhtvXYt/XClPp4
         NUT1gRPEgxFJeOifFFRXAY0VHw24nFEo+wwQ3dgptsznQUbzCRx1E+rVGADEROwZXvAj
         OPmQxsJ3GNXBWJrWjm2X8PBuZg4t/KyqltIhpt28zIXDcxrgtehHlpqSl1w0aKvh3aV7
         KS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843016; x=1748447816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkp8/KQCYPe4X4RChScWld8jG0gqKsuj1b9ATe0EBbM=;
        b=G74DN8AM0Z+3iodNJpWClvx8hRzvvG9NvvV1iikDUw4COmBv7eTsz86Fc9TuOTr73D
         JhgpPzeomKTGtVNLsYcb55gPcLSpTssELFNJcLX7+/re4nk3/a2IBBJeFkmjvnTAXHsz
         4STbDQUUPyu63eM75Fu//PYEb+EOFuLjlaz3kOuUrZKdTpXwRxQAioqLNDmmnSbr56ck
         qT7hSLjSupbO7hx/QNfvrDGTx9A+uvCusVHt7Gkr5bgPnIPuci2f4fPP4g0FRI5xtG/1
         kVJutts5+tB9n0v/6IyWxCs2hp+YGAYdFGoebDP1kyoDvcRzeTt1g1fqqSvIlekSvjv/
         quaQ==
X-Gm-Message-State: AOJu0YzbiScifeQP3+sHoSgeLyksEKckek+DC09YetAcB/Ueh7OPZwDe
	+OYkmK68YXOJalx0bH3yvFtIm5G2SrdDT/yG6cEbppoI7YFU4aUxA/hikKAt91BOyExXXy9Qv6r
	zKCLW5Q8WjFolJU1NWKLEEhxAFZFxgFO1YPxU7QQj
X-Gm-Gg: ASbGnctEeSgc+o/8iRl4S4Iqk2r6MISOf6uCvMYtilt3ZVwpKTnLsWS/vUPy//CtZPk
	0sZnSPHqtOLSuFcrt+1C5b5FWgPSwv5hj90M2ce2yNHYMCORKXCKpVuLpmntjCpPTkwTFjTKSbq
	m7dGWDlDe76BLZMvzkUBlmEHuXaPQsKcIQwBB2OJK9nCHGfGC65guf/wns3CiPxCYC5vDJ2tuwk
	qM=
X-Google-Smtp-Source: AGHT+IHvcf91D6CA7OElud24r53H8QDbn9PzX10MyepsKFpPSEz0PuohoCUeHFZ8Wyc8IdyM4y8lmd85fn24EoYlj8I=
X-Received: by 2002:a05:622a:593:b0:494:b06f:7495 with SMTP id
 d75a77b69052e-49595c5d6aamr18623181cf.24.1747843015686; Wed, 21 May 2025
 08:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
 <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
 <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com> <CAAHxn9_++G0icFE1F+NCfnj3AkErmytQ3LUz2C-oY-TJKbdwmg@mail.gmail.com>
In-Reply-To: <CAAHxn9_++G0icFE1F+NCfnj3AkErmytQ3LUz2C-oY-TJKbdwmg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 21 May 2025 11:56:39 -0400
X-Gm-Features: AX0GCFuduFn5NPvhgTcm7Z9k_s3CpBU5G0pvphrEvzFE6V-Y3ih1Yhi9W-NssTY
Message-ID: <CADVnQymURKQQHHwrcGRKqgbZuJrEpaC6t7tT7VeUsETcDTWg2Q@mail.gmail.com>
Subject: Re: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Simon Campion <simon.campion@deepl.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 11:08=E2=80=AFAM Simon Campion <simon.campion@deepl=
.com> wrote:
>
> Great to hear we have a potential lead to investigate!
>
> We've now seen this problem occur several times on multiple different
> nodes. We tried two workarounds, without success:
> * As far as we see, the patch Neal mentioned was included in the
> 6.6.76 release. We rolled back some nodes to an earlier Flatcar image
> with kernel 6.6.74. But we saw the issue occur on 6.6.74 as well.

For clarity, it sounds like you observed the issue occur on 6.6.74
with net.ipv4.tcp_shrink_window=3D1. Is that correct?

> * We disabled SACK on the nodes with broken connections (not on the
> nodes they connect to). The problem occurs in the absence of SACK as
> well:
> 05:59:05.706056 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
> [P.], seq 306:315, ack 1, win 0, options [nop,nop,TS val 2554169028
> ecr 1041911222], length 9
> 05:59:05.706142 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
> [.], ack 315, win 501, options [nop,nop,TS val 1041916342 ecr
> 2554169028], length 0
> 05:59:07.846543 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
> [.], seq 1:609, ack 315, win 501, options [nop,nop,TS val 1041918483
> ecr 2554169028], length 608
> 05:59:07.846569 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
> [.], ack 1, win 0, options [nop,nop,TS val 2554171168 ecr 1041918483],
> length 0
> 05:59:10.826079 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
> [P.], seq 315:324, ack 1, win 0, options [nop,nop,TS val 2554174148
> ecr 1041918483], length 9
> 05:59:10.826205 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
> [.], ack 324, win 501, options [nop,nop,TS val 1041921462 ecr
> 2554174148], length 0
>
> Another important piece of information (which I should've included in
> my first message!): we set net.ipv4.tcp_shrink_window=3D1. We disabled
> it to check whether this will avoid the issue.

Oh! That's a big deal. For my education, why do you set
net.ipv4.tcp_shrink_window=3D1?

If at all feasible, I *strongly* recommend running with
net.ipv4.tcp_shrink_window=3D0, since this is the default setting, and I
imagine net.ipv4.tcp_shrink_window=3D1 could run into all sorts of weird
problems like this. :-)

It would be super useful if you can share results for whether you see
this problem with:

(a) 6.6.74 (before "tcp: correct handling of extreme memory squeeze")
with net.ipv4.tcp_shrink_window=3D0

(b) 6.6.83 (after "tcp: correct handling of extreme memory squeeze")
with net.ipv4.tcp_shrink_window=3D0

Thanks,
neal

