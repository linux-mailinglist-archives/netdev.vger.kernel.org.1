Return-Path: <netdev+bounces-161538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63703A2225A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E653A51DD
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C6D1DFE16;
	Wed, 29 Jan 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="VJqbtEEO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716831DFE02
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169721; cv=none; b=VFAxoJGMfEDYpJxMDkNxarZgAO3wCo8K/fvuNuG0j2e+3FJxmK6yWFIxLd1lG7iGHbam7W/FT5OTt6GjPEpwKTsdHLy7VIV1MSfvtYRYXkuPxTNjM20bIDW3dUdYXB24ZSeoCAkW1mZ1n3OVHhym6QQUaOBFyn+IUBiYd/a9GjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169721; c=relaxed/simple;
	bh=OTOt3a3xCZ3d+amh6jix6pNcBFDs2cLOK/auAucstEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpidFQxrKCriNDfWErGdHx1ZOeP3bR//0qVN7MBnACw2AYx0rYactvxx56MwlHgyE3s7+vg1fp3v0AmqPiSyatBen8D5zET6/y+mkUXpS0xOT4NOxVfA/+nFfABo53NBQ6JTmAlea1IM4hyMy48LHI9uPgG551QXXFZSY3tRyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=VJqbtEEO; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OTOt3a3xCZ3d+amh6jix6pNcBFDs2cLOK/auAucstEs=; t=1738169720; x=1739033720; 
	b=VJqbtEEOwLCeH+BegHJqzKwn3MVhkCnw9uBd09nlrhuLovN1MMORwsrahrKOyDV1UUeVmnA9IjG
	bTXQtysBh1UT9jELuiiFfA9ThQ8tTpIKJvOrQWDAa1wMd/oaF/PD49h5BOI2STG+E1hceA+FcocHT
	wfKyMqBER2QE4BGxJpDzBrQIjhWODDt6yrjtjySm7sldgNlhCJE/Rf5Bq1nIQQGlEHPZSqXaG2OeC
	CXFlhgdngbXCUMEd0cqt6+GSySMLmuudYpJt/qa0BRN0FgBbXehI8a18/pMdCfyQa7q8ri4oRKAV5
	Epoe76RthAijh9XrdDlIeq8cTdPkEzhj5jlg==;
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46395)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdBLT-0004nA-8U
	for netdev@vger.kernel.org; Wed, 29 Jan 2025 08:55:19 -0800
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3cbd0583so1627353a34.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 08:55:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDVmXNjn5vlDfT0SUNVPvEOUSWHqLS+5m4pJaGwYVjaiP28UZg8yIm1q9j5NHxW+IfZ21O1MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOsbuef9/CYHQhsp+LpjKpzj5Bt2fL135UF3UiiaxPnW2l81a
	1A/dE0mSV7yGw1DehfNrwgsJM6o6Onp2IWOHooddBYXXEdr2jshF1tCk1X8h8lHe4tvdBJnC/OJ
	tN4ZQS62OOvxxRdbvVsoNBcCh2fc=
X-Google-Smtp-Source: AGHT+IFVOejpahZKuGbmRgf6UsC9ioPA4FtIivBtVJm3CICFrBSe7ftBB11UuovB338qU2xk2y4lR34IhLVwRmI2B3U=
X-Received: by 2002:a05:6870:6190:b0:29e:2422:49f9 with SMTP id
 586e51a60fabf-2b32f28f374mr2152890fac.25.1738169718702; Wed, 29 Jan 2025
 08:55:18 -0800 (PST)
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
In-Reply-To: <CANn89iL2yRLEZsfuHOtZ8bgWiZVwy-=R5UVNFkc1QdYrSxF5Qg@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 29 Jan 2025 08:54:43 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyKPdu5-JEQ4WOX9fPacO19wyBLOzzn0CwE5rjErcfNYw@mail.gmail.com>
X-Gm-Features: AWEUYZlzO6CXv5EpIf_u4w6fsS5cBTku2r6a413bSZqavVBFCPuJWmyxLOMzXRU
Message-ID: <CAGXJAmyKPdu5-JEQ4WOX9fPacO19wyBLOzzn0CwE5rjErcfNYw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: acf3039aa8d32d1ac60a71149e52b94c

On Wed, Jan 29, 2025 at 8:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jan 29, 2025 at 5:44=E2=80=AFPM John Ousterhout <ouster@cs.stanfo=
rd.edu> wrote:
> >
> > GRO is implemented in the "full" Homa (and essential for decent
> > performance); I left it out of this initial patch series to reduce the
> > size of the patch. But that doesn't affect the cost of freeing skbs.
> > GRO aggregates skb's into batches for more efficient processing, but
> > the same number of skb's ends up being freed in the end.
>
> Not at all, unless GRO is forced to use shinfo->frag_list.
>
> GRO fast path cooks a single skb for a large payload, usually adding
> as many page fragments as possible.

Are you referring to hardware GRO or software GRO? I was referring to
software GRO, which is what Homa currently implements. With software
GRO there is a stream of skb's coming up from the driver; regardless
of how GRO re-arranges them, each skb eventually has to be freed, no?

-John-

