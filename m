Return-Path: <netdev+bounces-141723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0FA9BC1BB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D841C20CC0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1201FDFAF;
	Mon,  4 Nov 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PJrXYSf2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036A139CFF
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764673; cv=none; b=oxGN9/r2ESCHNpe+fzog1zKYAiRoxPeK0gypibfsSGDRkyhbDTHmUhw5nzWGnSrP3cYKkCZ8bx/bmUrD7YYNpT1t+5HKqykwFPs2gAgKNupzTgJ4gMQgCVS7JO6KnM84X0gCDeA+XwyLTfiuNlgrZAx0/uRV6HxsBUt3lKCUdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764673; c=relaxed/simple;
	bh=dCgc2j8zsFcWKIhvPNux8ql6jRkdknqPrCg+obqN7Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt3iFDRhJT/eCiGsjeet7JgPEq12s0Dzg2Os7nx72gRf0d2+cLK2Yy9wC1kCN4IMqny7TrZUtvNb1+jViOkHmnadKgNzyQqDynhF39P+Wmi9bHFyGcbeqt6swj2SKd/NMU3vR12jYq6km4TedDqPsDCKUTtL1We+clJxz6rG71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PJrXYSf2; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dCgc2j8zsFcWKIhvPNux8ql6jRkdknqPrCg+obqN7Ek=; t=1730764672; x=1731628672; 
	b=PJrXYSf2etxgUrin5EbdzGH/eCXZNI61sTnP7NcVk0zPf5p0N+O9B0BC9VfUI6NaHIt1HvCazdk
	gncH71QlL1oxeTZL6LRjRPy4mzBfs4GYsULWwv7uhM9QxDMACfo1rR8S1YZYle/lqAY4MTVhtwP7i
	Xaw3ipjYEsiJHXfB/ilhglT6hvB92YGlFBekI0hYSEe41xrVo7+30pkDPrVLsx/sWuXeJffBRukUN
	L/HxKaiVwehM43syYIP62M7Da50Olf0Ue+T+cRBcy69PSe5qTuiSB0A6LGbOM61ilQiT4v+xbGE9T
	S13N82cddKVwQ9yel2vC50bwv/anvcjKSuMw==;
Received: from mail-oo1-f44.google.com ([209.85.161.44]:44066)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t86x7-0003f8-14
	for netdev@vger.kernel.org; Mon, 04 Nov 2024 15:57:45 -0800
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebbed44918so2830174eaf.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 15:57:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDFEt8DIzlRvrD4IpQXSxAZPQ5DWOKw9eRDCBUJKHWUKOG/c/UMOoILuBQQcyxgCBPKzBxAo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27zvODjzQ8kviRCNu9v8V/UN1I8ZDW7h3fp/0/Qzc5zEbVwCh
	YodXShryX6wVGTxki6OUbRLIwu5Le2rl6qMu8+Fs8qfvE4q3tD9wDDnThObeRjm1TDIBt1kdoX2
	glkkdTAD9roklOXG5qE6HeX6Ww8E=
X-Google-Smtp-Source: AGHT+IFwebaIGfdtOvoQWKA9KYdpstIs/QkLjX2E4vhFuzXq0yG2WlLvRTLp4gsgg+aSYMmonUEzTFPQKUlvn5wlyck=
X-Received: by 2002:a05:6820:1a03:b0:5c4:144b:1ff9 with SMTP id
 006d021491bc7-5ec5ec9271dmr15088507eaf.5.1730764664445; Mon, 04 Nov 2024
 15:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-5-ouster@cs.stanford.edu>
 <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch> <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
 <67c42f72-4448-4fab-aa5d-c26dd47da74f@lunn.ch> <CAGXJAmyOAEC+d6aM1VQ=w2EYZXB+s4RwuD6TeDiyWpo1bnGE4w@mail.gmail.com>
 <bfb037fb-ee80-4b34-9db3-bd953c24fee8@intel.com>
In-Reply-To: <bfb037fb-ee80-4b34-9db3-bd953c24fee8@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 4 Nov 2024 15:57:08 -0800
X-Gmail-Original-Message-ID: <CAGXJAmykXGrd-sQO-Q1TvEwbBwnOZXTcegfh2OxjhAQ8dUH9Yw@mail.gmail.com>
Message-ID: <CAGXJAmykXGrd-sQO-Q1TvEwbBwnOZXTcegfh2OxjhAQ8dUH9Yw@mail.gmail.com>
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: bd70d0bdda1312c8b25f7b39d1e2fb7f

On Mon, Nov 4, 2024 at 5:13=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> >
> > Homa doesn't allocate or free pages for this: the application mmap's a
> > region and passes the virtual address range to Homa. Homa doesn't need
> > to pin the pages. This memory is used in a fashion similar to how a
> > buffer passed to recvmsg would be used, except that Homa maintains
> > access to the region for the lifetime of the associated socket. When
> > the application finishes processing an incoming message, it notifies
> > Homa so that Homa can reuse the message's buffer space for future
> > messages; there's no page allocation or freeing in this process.
>
> nice, and I see the obvious performance gains that this approach yields,
> would it be possible to instead of mmap() from user, they will ask Homa
> to prealloc? That way it will be harder to unmap prematurely, and easier
> to port apps between OSes too.

Can you say a bit more about how your proposal would work? I'm not
familiar enough with Linux internals to know how Homa could populate a
region of address space on behalf of the user.

Having the application mmap the region is pretty clean and simple and
gives the application total control over the type and placement of the
region (it doesn't necessarily even have to be a separate mmapped
region). If the application messes things up by unmapping prematurely,
it won't cause any problems for Homa: this will be detected when Homa
tries to copy info out to the bogus addresses, just as would happen
with a bogus buffer in a traditional approach to buffer management.
And, the mmapping is likely to be done automatically by a user-space
library, so it shouldn't impose additional complexity on the main
application.

-John-

