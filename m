Return-Path: <netdev+bounces-88139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6198A5F08
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 01:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0428C28345A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145CE15957B;
	Mon, 15 Apr 2024 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqqrMWSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2E54905
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225515; cv=none; b=kWBprEEL+a6mOCSPM6t7aKC9qar3Zr3FZ1lgCp623x9hESBTQWRN4zATvJjFAGaSIXdPVmhpMR69+LrTf6dbAdAaSp/rMYt3Viv1foEFM+9vyn1vooyc+IM8poTwnbLOyzfb7ANResqw1/AX1756H8c1wju1RzZlYYR10Ex71ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225515; c=relaxed/simple;
	bh=FhAihzpnQ1OaStOGK06/I1o1g7+fUCXm0YEK7c6AvuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSPMh64JwGc5IJDpnwwRy2/cyV8RFJbg169tYtpp+R5fIrpGLeBR1BRAL298+7y0dyKWht9TwCwJo5/US3x0cK+DmLjoI5aq0pdwA+zNS/VPosu8D0OSUkaGn8EJ7K9QhXNgHl8uDbnRmWPgWuuOHifv6vFRE4i/RvvRf7SoDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqqrMWSs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4187a98705cso6493345e9.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713225512; x=1713830312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/lok0GUUnQjmlid2gudXdIk+tRy9i/M2t28rzrad7I=;
        b=JqqrMWSsI0o6H76PJ7xQb54gOq9FP+xnmeDOO0yAG/7TfdaPZhc/3hFga3FJ67lqFZ
         J9vFbwknv0ligEsxti6v2HUgWRYV76dzp5AV3nWhypZOTSm9EjlZkWpjPxH0YrnzCkEO
         H7GGkghE3wxFVChSZ2St9X1sOoWX2wcIkAfE26ZxZ0Pb0vmOH3V7pZrhyRcuMJ3XdTDR
         hFYn4ts9DGRyBh/gKVT73WxqMjM33NVyVRKn6xqOCTukDWFnsS5bzngG0v/EkoODrq2t
         p3G4VhLpVSAsEiWuP+fNdK4qN3BmyS9g051RMD8hDcyYGQn1Mk4jzdEzfR4rzuUK5ynJ
         BtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713225512; x=1713830312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/lok0GUUnQjmlid2gudXdIk+tRy9i/M2t28rzrad7I=;
        b=fZnbFetDBJBQ/bGitVi/AiYJAk4VK5Bmbubq6Tf4WybmZqXBS/cR2GFCryRY33TTfc
         L4bH9qMSyQqbu0iwjNAGtPx7lJfKKDgCJXR5katVgNbeYivcFSy99VXOedKViYZLqXIO
         gMXvtfI5zKCI/Asx11tx0B6kApjgHR1OTRuOEzTiYFSfeG7AUyDtUKYLKGIG2+aG9I6o
         6Rf2Rya9e8bV4vrRCurcx+7uxBLTPyY25OS7piEUMCIZXF0ZaXxKSKflguB3mk9tNkEs
         2vpEVyomyY0kiwFPR06POViO9IAAFR54ebASJrNCkQcXX9PWUhjaHmcXCJqWL8mCnR9l
         +dEg==
X-Forwarded-Encrypted: i=1; AJvYcCU1P1ftdozOXZQ6TOvEChVztnXiV0xT0N8kYaf0rkZXSs0qvaNdAS6k6BFz/hFayAjx0ZOPi1uQbNCZUWUDR1VpKIFypyay
X-Gm-Message-State: AOJu0YxPPihuvTZaJ5ItKHjk8Hl7Hr1gwgzyPcLse3sATjqoFZztQUat
	jk3/PgSiyGoHBq7IADrzC6A832nGTDcxwEKL3A98XLuEGtQkrZkepegRYV9v0Iv0QL6NWLURGVu
	fbuau39iqfmxFAMSE2c6HR6cKUhQ=
X-Google-Smtp-Source: AGHT+IFpFPPoECc9qJT8j5DjhD3UbUE3FmXTOu0oPfOt2X/56xyHzJgMllk3g8RqBTq1Nc9EvDpYvFAfjaGxOqUFVng=
X-Received: by 2002:adf:ec08:0:b0:346:fa0b:bee8 with SMTP id
 x8-20020adfec08000000b00346fa0bbee8mr7545985wrn.1.1713225511402; Mon, 15 Apr
 2024 16:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com> <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com> <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com> <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com> <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org> <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <20240415111918.340ebb98@kernel.org> <CAKgT0Ud366SsaLftQ6Gd4hg+MW9VixOhG9nA9pa4VKh0maozBg@mail.gmail.com>
 <20240415150136.337ada44@kernel.org>
In-Reply-To: <20240415150136.337ada44@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 Apr 2024 16:57:54 -0700
Message-ID: <CAKgT0UcNPBE17T7g4y0XSkEZN89C69TfjWurAap5Yx_8XWLk1w@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 15 Apr 2024 11:55:37 -0700 Alexander Duyck wrote:
> > It would take a few more changes to make it all work. Basically we
> > would need to map the page into every descriptor entry since the worst
> > case scenario would be that somehow we end up with things getting so
> > tight that the page is only partially mapped and we are working
> > through it as a subset of 4K slices with some at the beginning being
> > unmapped from the descriptor ring while some are still waiting to be
> > assigned to a descriptor and used. What I would probably have to look
> > at doing is adding some sort of cache on the ring to hold onto it
> > while we dole it out 4K at a time to the descriptors. Either that or
> > enforce a hard 16 descriptor limit where we have to assign a full page
> > with every allocation meaning we are at a higher risk for starving the
> > device for memory.
>
> Hm, that would be more work, indeed, but potentially beneficial. I was
> thinking of separating the page allocation and draining logic a bit
> from the fragment handling logic.
>
> #define RXPAGE_IDX(idx)         ((idx) >> PAGE_SHIFT - 12)
>
> in fbnic_clean_bdq():
>
>         while (RXPAGE_IDX(head) !=3D RXPAGE_IDX(hw_head))
>
> refer to rx_buf as:
>
>         struct fbnic_rx_buf *rx_buf =3D &ring->rx_buf[idx >> LOSE_BITS];
>
> Refill always works in batches of multiple of PAGE_SIZE / 4k.
>
> > The bigger issue would be how could we test it? This is an OCP NIC and
> > as far as I am aware we don't have any systems available that would
> > support a 64K page. I suppose I could rebuild the QEMU for an
> > architecture that supports 64K pages and test it. It would just be
> > painful to have to set up a virtual system to test code that would
> > literally never be used again. I am not sure QEMU can generate enough
> > stress to really test the page allocator and make sure all corner
> > cases are covered.
>
> The testing may be tricky. We could possibly test with hacking up the
> driver to use compound pages (say always allocate 16k) and making sure
> we don't refer to PAGE_SIZE directly in the test.
>
> BTW I have a spreadsheet of "promises", I'd be fine if we set a
> deadline for FBNIC to gain support for PAGE_SIZE !=3D 4k and Kconfig
> to x86-only for now..

Why set a deadline? It doesn't make sense to add as a feature for now.

I would be fine with limiting it to x86-only and then stating that if
we need to change it to add support for an architecture that does
support !4K page size then we can cross that bridge when we get there
as it would be much more likely that we would have access to a
platform to test it on rather than adding overhead to the code to
support a setup that this device may never see in its lifetime.

