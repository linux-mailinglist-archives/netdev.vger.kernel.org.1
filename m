Return-Path: <netdev+bounces-162748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB7A27D2D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854C31886B94
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A07C21A432;
	Tue,  4 Feb 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="tueCOnyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A782045B8
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704062; cv=none; b=PenGD/F1JOiKytQ6VUzM1a1MbVODXbimgWk8JN7R1/SelwyhKJBIXUv+7Wqw5cdQLYPkDvJUxoq01/UoDaQ/aFYEMUcIAIAxOvxM6yL3pixZRvj66+MbKRgGq6lh5Xa4B5JWW9sx/V6yzVjQJum4geopiB/X889iQL3PIfle1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704062; c=relaxed/simple;
	bh=OssfpCiPgui0vIAiheo0OZ4vOe8AnF4Yx4gyHsoKpmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZazXkZZgaqQ0mnyF2Vp0UTGDFA2QOarGyJ8LBS2QiSlC1GUBa2G3K/lFAh6rYjAP5Y2khRb6cEw2SBv/1eBR6Zdkq2fzkVMbKJTh5Y4RKe2FOIdANVD8rUftJ21M5kCeavUXbEktc1XdMZfq4Rfc5ckw0qoc26Ftpu2PQPC7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=tueCOnyd; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OssfpCiPgui0vIAiheo0OZ4vOe8AnF4Yx4gyHsoKpmI=; t=1738704059; x=1739568059; 
	b=tueCOnydwWyqVvLgqTfIQEesncTMccLzjD5J60t1VGTC/4ZCXgCkJUws3JJQuI850hVB7calpE5
	MrbpdxKXs73haPosMr3WCDnyvcVSdc/dIv0T+LVJZRRWpfxya/nvrLtwiHam4bWtj/GKxJyky/tAg
	RWird13ePKEIW10gnLKHJtRcU8ci757yXWAHRiHvAq0DX5RozMKUMiI8yNUiwa8FKY9IxWtzpR2nR
	AzBlurpHk3kDA73xmorxR+7OUlPDUVZkEdp9QqCW7BqQq0gkTyoVZKFrugWLSZR+KBsxcYOvjK3AJ
	URGHgCuj+MqKV6ciItb7hVO80BMlxD5FljlQ==;
Received: from mail-oa1-f48.google.com ([209.85.160.48]:54700)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tfQLk-0004q7-MG
	for netdev@vger.kernel.org; Tue, 04 Feb 2025 13:20:53 -0800
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2a3939a758dso1911148fac.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:20:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrZO9xg1givjPOTihqtT2LNz9XvpPDTp3QwHRfy8o7MOQgdTZE+3iu5Yyi03/hLPVsObSer2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfl/I7qqfdAcQmMNeMD8avYQbNvhBP24SNoNO+EPvh/NXHvsq9
	niPs8j+i+XdU0lU88UQV5g3GAtqbWycabNjkOUAgyCfGjxDspUU5f62qiqikgnFoeReNoSxw6Qp
	gTqaeZIuAhU3FtKOVMn8iNRMLo/I=
X-Google-Smtp-Source: AGHT+IHUows4YOLrW3RMuIR/yZzbMi8TNa/WGFSpePUTVUN8SBUXXQB5ChfxiZ/xDIiL2vosP0tytOZk9Vnpom0Uuhg=
X-Received: by 2002:a05:6870:65a6:b0:29e:6bdb:e362 with SMTP id
 586e51a60fabf-2b804f9375emr285790fac.17.1738704052072; Tue, 04 Feb 2025
 13:20:52 -0800 (PST)
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
 <52365045-c771-412a-9232-70e80e26c34f@redhat.com> <CAGXJAmzL39XZ-tcDRrLs-hiAXi3W79cAoVe18hHkD7iGDKe7yQ@mail.gmail.com>
 <a3295c97-9734-4baa-b9c7-408c54b0702c@lunn.ch>
In-Reply-To: <a3295c97-9734-4baa-b9c7-408c54b0702c@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 4 Feb 2025 13:20:15 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzEn=pGfRcR+xA41pYLUZb8kU0o_4WHvf=dw9t=W6rQ_A@mail.gmail.com>
X-Gm-Features: AWEUYZmHY681rCJuvD9Lw8fCvJH2padxmA8S97IODSGgL7hhNbWVzRAz8fHnKDc
Message-ID: <CAGXJAmzEn=pGfRcR+xA41pYLUZb8kU0o_4WHvf=dw9t=W6rQ_A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 9dddbef7dbf47a29383c7a3c8e5dce6e

On Tue, Feb 4, 2025 at 11:41=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > If unprivileged applications could use unlimited amount of kernel
> > > memory, they could hurt the whole system stability, possibly causing
> > > functional issue of core kernel due to ENOMEM.
> > >
> > > The we always try to bound/put limits on amount of kernel memory
> > > user-space application can use.
> >
> > Homa's receive buffer space is *not kernel memory*; it's just a large
> > mmapped region created by the application., no different from an
> > application allocating a large region of memory for its internal
> > computation.
>
> ulimit -v should be able to limit this, if user space is doing the
> mmap(). It should be easy to test. Set a low enough limit the mmap()
> should fail, and i guess you get MAP_FAILED and errno =3D ENOMEM?

I just tried this, and yes, if ulimt -v is set low enough, user apps
can't mmap buffer space to pass to Homa.

-John-

