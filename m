Return-Path: <netdev+bounces-162636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A7A27731
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C6E1883708
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55820D4F2;
	Tue,  4 Feb 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="mHXKJ88Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3B2C181
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686673; cv=none; b=d+DGNjWYK2+RXq5BkjAVC6JSwqXvwAkoDm5Ac758b728qAaV9P8Lbs8zjyqqHh7uLZdnmmX/ad8NlPvYW0IEbUUqtQv6B2g2usYjTkXZgtia/9RgQeDQ820AU11zifziC/Jq628sQCcRzWERO3JGA1VPxVRY9g9Z8RSIbYnnHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686673; c=relaxed/simple;
	bh=CtAA7LWYT6zJvtipRuZeqBk/XlfSDT+KZ36VX35CXho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNaKxjkdHBEdjlCrBsPPYkiLg3cJ/aTnWgHFkgRDicKGlG+xUiO5CAthq/eQ8IR7cBVw5sNgK4jCuEbrMz1l4Amc4/dylhVcL6r9oGo34fak0AvOTmSYIp8uANyplUxs/fZ2xMiAM006hys00hN0A7+/i9hiMZZEOleAIRSWM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=mHXKJ88Q; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CtAA7LWYT6zJvtipRuZeqBk/XlfSDT+KZ36VX35CXho=; t=1738686671; x=1739550671; 
	b=mHXKJ88Qq30cdX8Fj1+53vnQVuKlAPoMcWBQWabojfFp/6o2RquoNLuVyp4zgc58zOXeg/EwtXg
	GSklhCJ1dZJ9vk2BOLKpVHVw3kJq3Xr7RT01kHNDiu4Y0HB24QVbU7KxtY5fHTDVSFsqq3TIolzmj
	n82EF617SpLQ1p3A38m9cPF64OQJdxzXjlI4I5XGNxWQoiL7/3FMPG8f1NpinBaqu60ioWbZtHpMe
	KJ2KiEzxqiAEg2DFNEgLir0gLy/QHhE0v3y15d02sKpVtHYAdyVzVtr0qgNA38QzJHbSV4S0zA8zQ
	qC2e9/mYf4huiYI+4nme5czSDCiLpo+zDPtA==;
Received: from mail-ot1-f41.google.com ([209.85.210.41]:56568)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tfLpN-0004IQ-UT
	for netdev@vger.kernel.org; Tue, 04 Feb 2025 08:31:10 -0800
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e3f291ad6so3506099a34.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:31:09 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/WcP/blvqtoOeciaCKkCKGHcgwGcro0WmNNFTpgM2iyNSIcdo
	a0e1MLjpWyffMcX+NdxT9gaPRU6l7y36Wg0pI3BivQS2/2bPRXqlHTY2x7fk5mEzLjBeisuZidA
	fe3GRI0Uyol0sCOqWGIzAvsB8Ev4=
X-Google-Smtp-Source: AGHT+IE6fjsFPvkB2tDeNLkStxDarOgUPzPnRUTjUaLxYr0vD+HQr/iU0bMCfRl+3Dn1paRK2Q12s6By0P4muFCKsGg=
X-Received: by 2002:a05:6870:c69c:b0:2a0:d2d:e606 with SMTP id
 586e51a60fabf-2b32f2f8538mr15165940fac.38.1738686669366; Tue, 04 Feb 2025
 08:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com> <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
 <991b5ad9-57cf-4e1d-8e01-9d0639fa4e49@redhat.com> <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
 <7b05dc31-e00f-497e-945f-2964ff00969f@redhat.com> <CAGXJAmyNPhA-6L0jv8AT9_xaxM81k+8nD5H+wtj=UN84PB_KnA@mail.gmail.com>
 <52365045-c771-412a-9232-70e80e26c34f@redhat.com>
In-Reply-To: <52365045-c771-412a-9232-70e80e26c34f@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 4 Feb 2025 08:30:32 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzL39XZ-tcDRrLs-hiAXi3W79cAoVe18hHkD7iGDKe7yQ@mail.gmail.com>
X-Gm-Features: AWEUYZm5Y-AfBSGjbhHNw-Fze6qttyfmnKq0f-S3SxazeGQq-SGh5-lR8H25zMY
Message-ID: <CAGXJAmzL39XZ-tcDRrLs-hiAXi3W79cAoVe18hHkD7iGDKe7yQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 127ff6e1eac6b45a32dc112250ed777d

On Tue, Feb 4, 2025 at 12:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/4/25 12:33 AM, John Ousterhout wrote:
> > On Mon, Feb 3, 2025 at 1:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >> I don't see where/how the SO_HOMA_RCVBUF max value is somehow bounded?=
!?
> >> It looks like the user-space could pick an arbitrary large value for i=
t.
> >
> > That's right; is there anything to be gained by limiting it? This is
> > simply mmapped memory in the user address space. Aren't applications
> > allowed to allocate as much memory as they like? If so, why shouldn't
> > they be able to use that memory for incoming buffers if they choose?
>
> If unprivileged applications could use unlimited amount of kernel
> memory, they could hurt the whole system stability, possibly causing
> functional issue of core kernel due to ENOMEM.
>
> The we always try to bound/put limits on amount of kernel memory
> user-space application can use.

Homa's receive buffer space is *not kernel memory*; it's just a large
mmapped region created by the application., no different from an
application allocating a large region of memory for its internal
computation.

> >> Fine tuning controls and sysctls could land later, but the basic
> >> constraints should IMHO be there from the beginning.
> >
> > OK. I think that SO_HOMA_RCVBUF takes care of RX buffer space.
>
> We need some way to allow the admin to bound the SO_HOMA_RCVBUF max value=
.

Even if this memory is entirely user memory (we seem to be
miscommunicating over this)?

> > For TX, what's the simplest scheme that you would be comfortable with? =
For
> > example, if I cap the number of outstanding RPCs per socket, will that
> > be enough for now?
>
> Usually the bounds are expressed in bytes. How complex would be adding
> wmem accounting?

I'll see what I can do.

-John-

