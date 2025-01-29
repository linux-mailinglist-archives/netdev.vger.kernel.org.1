Return-Path: <netdev+bounces-161558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC050A2251F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983223A211E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592F1E2606;
	Wed, 29 Jan 2025 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="afj+OXtY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96C199EBB
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182476; cv=none; b=nbV17j6d8qhtD4wwCe5xbqTN7rLEaS1W1g/KRvW8BTk0IRxB9QUHxPy1RyI3NJdTET5wz7+vraV5Xc3A8Z3CXeO6OjiraF2n1VoxG4Vgd2VJIxCe8Izb3qQFP94rB5sk3uVLuUGnr6z90xgdCN54JzjyIq5r5GnoMCRcBhvjNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182476; c=relaxed/simple;
	bh=Ad94CEG7Be3qgYF7zPhi5GiXMkoMukgzQwABnrlrEe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnIxyGZeAsyJS34fVCz0g2oLSQXq3fEAZFDKR0xY7Jv3UBXmVT12hnzPISdHghFA1cMDWfazNoxclJ0ngIOVV14DIDqaZ2/9bPvYHbOecJhWvLx+VwaDXmdSGSZ183I4lF8IsipI3THfifftCpia+kU5RgqW4mCG8N6ciIKdzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=afj+OXtY; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ad94CEG7Be3qgYF7zPhi5GiXMkoMukgzQwABnrlrEe8=; t=1738182474; x=1739046474; 
	b=afj+OXtYcAnCmY0yGHovnNJxFqXd6/7jQJuRAs/5bjpyxTTabIgMV7U6PpgRwUoDd7zzFtiM+PY
	jPPhyRAk14FBtNnQOQ06LftdE8eBOM+xMZn63gK6cPMlgnJt1I35yOSWe8oHyZIbVctZ7t94g+Isk
	I4H2mv//60bvqb5S2xtv2bixVYYbLiUKCCfGXnbeplOUbM4+s3m2NqXh0enR/WekORgREZlUWhL7j
	rW73lUxccsRU02sr6eA6QZEwSBy45l5X9kIIDDuN1u4uEzz7Gux5JTw/uPSzCMbbqiEKYaN4qJut+
	iFrswQ7KrITXSyAZG+P6aoRPpfVpcjYMCR4g==;
Received: from mail-oo1-f49.google.com ([209.85.161.49]:46476)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdEf5-00050P-Hz
	for netdev@vger.kernel.org; Wed, 29 Jan 2025 12:27:48 -0800
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f2b21a0784so36635eaf.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 12:27:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtc8zwq0o28ULXP+ZylYXX2eY/AdRPPOtyljJ3ptXFDKae7sDlaImqWyGBVleXtval4vEiq4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYPluj5O/XkjQ8p4x/FWHRLGmA3b8QIDMf6LKFpGxEBxo3j0Q
	Jr5JGEBz1wx5dywp2iK/Sjz9mlR1IjfMwMNmmGEzUg6RQAj9WTqEbAaJRybGhZ2WlUiO/VXE4Wc
	p1Z7/tt4OGL6Oqta3fUeW9PqMT8I=
X-Google-Smtp-Source: AGHT+IFXD9lfG0JETd4xaJz8vpBMTB+f3lxaTbF1MJv2wsO/hoZcU5rk51EEw6Ff39Q69L2E57IMd8w2DfxJiL/VPU0=
X-Received: by 2002:a05:6871:ea0c:b0:29e:2bbd:51cb with SMTP id
 586e51a60fabf-2b32f2908cfmr2495090fac.24.1738182466970; Wed, 29 Jan 2025
 12:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com> <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com> <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
 <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com> <CAGXJAmyb8s5xu9W1dXxhwnQfeY4=P21FquBymonUseM_OpaU2w@mail.gmail.com>
 <13345e2a-849d-4bd8-a95e-9cd7f287c7df@redhat.com> <CAGXJAmweUSP8-eG--nOrcst4tv-qq9RKuE0arme4FJzXW67x3Q@mail.gmail.com>
 <CANn89iL2yRLEZsfuHOtZ8bgWiZVwy-=R5UVNFkc1QdYrSxF5Qg@mail.gmail.com>
 <CAGXJAmyKPdu5-JEQ4WOX9fPacO19wyBLOzzn0CwE5rjErcfNYw@mail.gmail.com> <CANn89iJmbefLpPW-jgJjFkx79yso3jUUzuH0voPaF+2Kz3EW2g@mail.gmail.com>
In-Reply-To: <CANn89iJmbefLpPW-jgJjFkx79yso3jUUzuH0voPaF+2Kz3EW2g@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 29 Jan 2025 12:27:11 -0800
X-Gmail-Original-Message-ID: <CAGXJAmz5=V2DmGHHh2XRHKQYynXmqYk_Nqw-y_QBWBQBMjbuag@mail.gmail.com>
X-Gm-Features: AWEUYZm9GUiGvc6JW_dedYW7xtCfwShNRYqyiAi2Nncs6eR4CnlQKKo4mpPmv9U
Message-ID: <CAGXJAmz5=V2DmGHHh2XRHKQYynXmqYk_Nqw-y_QBWBQBMjbuag@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 1.7
X-Spam-Level: *
X-Scan-Signature: ae35470b07fbe4e2dbb6b33d1de23969

On Wed, Jan 29, 2025 at 9:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jan 29, 2025 at 5:55=E2=80=AFPM John Ousterhout <ouster@cs.stanfo=
rd.edu> wrote:
> >
> > On Wed, Jan 29, 2025 at 8:50=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Jan 29, 2025 at 5:44=E2=80=AFPM John Ousterhout <ouster@cs.st=
anford.edu> wrote:
> > > >
> > > > GRO is implemented in the "full" Homa (and essential for decent
> > > > performance); I left it out of this initial patch series to reduce =
the
> > > > size of the patch. But that doesn't affect the cost of freeing skbs=
.
> > > > GRO aggregates skb's into batches for more efficient processing, bu=
t
> > > > the same number of skb's ends up being freed in the end.
> > >
> > > Not at all, unless GRO is forced to use shinfo->frag_list.
> > >
> > > GRO fast path cooks a single skb for a large payload, usually adding
> > > as many page fragments as possible.
> >
> > Are you referring to hardware GRO or software GRO? I was referring to
> > software GRO, which is what Homa currently implements. With software
> > GRO there is a stream of skb's coming up from the driver; regardless
> > of how GRO re-arranges them, each skb eventually has to be freed, no?
>
> I am referring to software GRO.
> We do not allocate/free skbs for each aggregated segment.
> napi_get_frags() & napi_reuse_skb() for details.

 YATIDNK (Yet Another Thing I Did Not Know); thanks for the information.

So it sounds like GRO moves the page frags into another skb and
returns the skb shell to napi for reuse, eliminating an
alloc_skb/kfree_skb pair? Nice.

The skb that receives all of the page frags: does that eventually get
kfree_skb'ed, or is there an optimization for that that I'm also not
aware of?

-John-

