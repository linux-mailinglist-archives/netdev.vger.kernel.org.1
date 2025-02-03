Return-Path: <netdev+bounces-162308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEBA267ED
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32791885186
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 23:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D61E7C19;
	Mon,  3 Feb 2025 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="LauHgtoA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE03597D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738625668; cv=none; b=QftWe+d6qGL2w5lQb5FFwVT0cAgSW6PVd6qPwr+eEmlUl9hufdyIiRdcysUs32+bp9T+WeDoJj5Kea1T6dKK4p3C9tp0sIMXQ7pLNvAhX02vF4peBC3sb2c6vIYdP6OOFar/3y3K8Gqvt69rI7TZEbeXxnOy7PdnbDOvRNuWSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738625668; c=relaxed/simple;
	bh=O8xxJmvJLF1jhrXk/a4JoFHTRv2oe06hzo4CYs7NTXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOuRNnI+K5j8+P1nG8Cac6GR/7pe9+TVpr9TdcEZgR9PfTfoVzNJb1W3HRMBZMnQhn7G4ECUgTqRc2SvvWeGoq6Ytu9DJ/yKFg4XQ9W2v0yV8SsJgASSeXuMd+Zbuag0U7vaqILOF9jLyRx+1nlDY27Lgm+a3l+bXI3zZJI11wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=LauHgtoA; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O8xxJmvJLF1jhrXk/a4JoFHTRv2oe06hzo4CYs7NTXY=; t=1738625667; x=1739489667; 
	b=LauHgtoA6CPUhRtdE+0h6Mh8/6EifzyW28pgs5JYC/0mPE1qkXLLBMAEf6JxN+NujpsZmyaur6E
	u+OuT3JrbhhtweDJ2/t2zj9UqhbOEW+Z3gZpo6ZPQjPSDElVtwtXF1MojeyQ/dvM8PJlyj+6w+R52
	jbTSlPC0CKLW1DEu1YSr2LYa3v7K/6MjtJ/XH4oJfsMxo1s4pRGwpBRzsM+PFEEdaw9cBP/FbxA41
	dhnbo1BtLLbp3Friy/SRdiCvQ8f5YXBLDjNW+Tq6JfMpviK8E+vlUCs8BImPtvWHaagAEldO0U0iX
	oB5hCellqU/8cx7uJQ5tNO5gqqJaJzTHSjag==;
Received: from mail-oa1-f41.google.com ([209.85.160.41]:58837)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tf5xR-0004y0-GE
	for netdev@vger.kernel.org; Mon, 03 Feb 2025 15:34:26 -0800
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29fad34bb62so2700117fac.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 15:34:25 -0800 (PST)
X-Gm-Message-State: AOJu0YxYj9u4CI3bSEVzHypUcsyfwaOzrfPaPfXWdXo6iH+e5Jbbytrm
	bxr7BfqIIGTz+7xWa8rmTMFu5IgKp/ufKp4p97SNkVjgyeae6RP6x3znx3b2R5z4OHMJ981n+8N
	d8v76+L7GzYY/x6P3KcytLxS96fE=
X-Google-Smtp-Source: AGHT+IH/S3k1MAY6Q9UkhXT3oHFdz5EokheetZXK9tf/ZZ/LCvGWHe7GX7cSM5BOLZ07dIXQ0tPMmgRAy9R/sqDoliE=
X-Received: by 2002:a05:6870:638d:b0:29e:787f:b294 with SMTP id
 586e51a60fabf-2b32f3078bamr14468056fac.38.1738625664948; Mon, 03 Feb 2025
 15:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com> <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
 <991b5ad9-57cf-4e1d-8e01-9d0639fa4e49@redhat.com> <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
 <7b05dc31-e00f-497e-945f-2964ff00969f@redhat.com>
In-Reply-To: <7b05dc31-e00f-497e-945f-2964ff00969f@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 3 Feb 2025 15:33:49 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyNPhA-6L0jv8AT9_xaxM81k+8nD5H+wtj=UN84PB_KnA@mail.gmail.com>
X-Gm-Features: AWEUYZkf1lGM4bpKkuLZG1pIHrtDfl8H0kqJ_oHx9eAn9ox9r_B6NnsrpfohdJA
Message-ID: <CAGXJAmyNPhA-6L0jv8AT9_xaxM81k+8nD5H+wtj=UN84PB_KnA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: ae7d61d5ad21aa0d569d6b6c8168eb46

On Mon, Feb 3, 2025 at 1:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> >>>> Also it looks like there is no memory accounting at all, and SO_RCVB=
UF
> >>>> setting are just ignored.
> >>>
> >>> Homa doesn't yet have comprehensive memory accounting, but there is a
> >>> limit on buffer space for incoming messages. Instead of SO_RCVBUF,
> >>> applications control the amount of receive buffer space by controllin=
g
> >>> the size of the buffer pool they provide to Homa with the
> >>> SO_HOMA_RCVBUF socket option.
> >>
> >> Ignoring SO_RCVBUF (and net.core.rmem_* sysctls) is both unexpected an=
d
> >> dangerous (a single application may consume unbounded amount of system
> >> memory). Also what about the TX side? I don't see any limit at all the=
re.
> >
> > An application cannot consume unbounded system memory on the RX side
> > (in fact it consumes almost none). When packets arrive, their data is
> > immediately transferred to a buffer region in user memory provided by
> > the application (using the facilities in homa_pool.c). Skb's are
> > occupied only long enough to make this transfer, and it happens even
> > if there is no pending recv* kernel call. The size of the buffer
> > region is limited by the application, and the application must provide
> > a region via SO_HOMA_RCVBUF.
>
> I don't see where/how the SO_HOMA_RCVBUF max value is somehow bounded?!?
> It looks like the user-space could pick an arbitrary large value for it.

That's right; is there anything to be gained by limiting it? This is
simply mmapped memory in the user address space. Aren't applications
allowed to allocate as much memory as they like? If so, why shouldn't
they be able to use that memory for incoming buffers if they choose?

> > Given this, there's no need for SO_RCVBUF
> > (and I don't see why a different limit would be specified via
> > SO_RCVBUF than the one already provided via SO_HOMA_RCVBUF).
> > I agree that this is different from TCP, but Homa is different from TCP=
 in
> > lots of ways.
> >
> > There is currently no accounting or control on the TX side. I agree
> > that this needs to be implemented at some point, but if possible I'd
> > prefer to defer this until more of Homa has been upstreamed. For
> > example, this current patch doesn't include any sysctl support, which
> > would be needed as part of accounting/control (the support is part of
> > the GitHub repo, it's just not in this patch series).
>
> SO_RCVBUF and SO_SNDBUF are expected to apply to any kind of socket,
> see man 7 sockets. Exceptions should be at least documented, but we need
> some way to limit memory usage in both directions.

The expectations around these limits are based on an unstated (and
probably unconscious) assumption of a TCP-like streaming protocol.
RPCs are different. For example, there is no one value of rmem_default
or rmem_max that will work for both TCP and Homa. On my system, these
values are both around 200 KB, which seems fine for TCP, but that's
not even enough for a single full-size RPC in Homa, and Homa apps need
to have several active RPCs at a time. Thus it doesn't make sense to
use SO_RCVBUF and SO_SNDBUF for both Homa and TCP; their needs are too
different.

> Fine tuning controls and sysctls could land later, but the basic
> constraints should IMHO be there from the beginning.

OK. I think that SO_HOMA_RCVBUF takes care of RX buffer space. For TX,
what's the simplest scheme that you would be comfortable with? For
example, if I cap the number of outstanding RPCs per socket, will that
be enough for now?

> Side note: if you use per RPC lock, and you know that the later one is a
> _different_ RPC, there will be no need for unlocking (and LOCKDEP will
> be happy with a "_nested" annotation).

This risks deadlock if some other thread decides to do things in the
other order.


-John-

