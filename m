Return-Path: <netdev+bounces-88371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD28A6E9B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D19B260CA
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6F512D203;
	Tue, 16 Apr 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avodo1e6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE21CAA6
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278146; cv=none; b=AeFsOfVx9v9QV5O1fQZnASuI+NeKxpvWMmpKj7AwiSJtJJPRCEjbP/ad1Hwu7MI3q4JscIlZhv1LC+J853MSaFe1b8A32C/AD+iZ9PRFttMTBwMOztGKjPIldSqMeXKUjdNavRLGbBUzROqe+/JcFjh6SEeFfVEXx+jP6IhgAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278146; c=relaxed/simple;
	bh=R2aZvhNp+Rf+64BcKlxWRa4Zfgc4xnS1zXhNuMgnwUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVhYDtvmX8ugivcvHh12ArdAofly8GN1euUgEPd4HUQ+2Olr7Oy3M4coIO5/wvE80MWS+DrkkQBJnFI++EbDHhSWdAy9dYOeSqUB2GgKltHF3nuCDlImPr53lPzfYi3qEbTnQAGEBFVnm856gXKXxlaSFTI6qhIR+0IlHmtdEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avodo1e6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343f1957ffcso2676370f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713278140; x=1713882940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neOc/Dpw59RF7ud53ejx/znC7Itf/4I5NFf8iGSF8EE=;
        b=Avodo1e6CIR6yLsYUJ1sANlHjZl38BW/QF6LMfl9tVsnbJakjtKeirVcXRdC+jBmnR
         JhdtIIGvGrEjs/ee/CdLBWoMKT9xCM4XRX3Hk8fO08IvRdCAmJKbn501QGPzFzkWyDrM
         pmSTwF6Cb4wRsqmUCSJ51r9Vpp8H5dW9rG4HvT4GaZBPFp8qrU63KaZyYpZQMoUC28DR
         7AOhvMSf7Rzbwr1CxxW36+ifgiUjmZGFzQhKkRrniXAQRpRXjh9Q7wQDOcn7EtJi9Jek
         GxKqQ4HAeN6XN9R6ixVqs09ACLXXJ8c5XYW4kcqeFcyXJT8miGY/ucYJTunEIhM2MslN
         +7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278140; x=1713882940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neOc/Dpw59RF7ud53ejx/znC7Itf/4I5NFf8iGSF8EE=;
        b=ipZtw8824c+pgIq3f/k8QWJJoPXAC5A12s4RFXWOuT0PyMeb9gQOD4fsqHQMxYS8eH
         cMJlmbWL9Z/xZy4G1lfiZ9bbxSu9swZqDSU4pk/JM/OEFFS8/ZFj4TipU6weES/DqyhI
         sDYXtCBaWupIbtMtoRrYYb7c5Gqlo2TGTtz3WwBmgJz55YQHOET5ZJE2i94PmavC1tp8
         oaV7liKXPtVxLR/MivGs4VSJ3gpSiGMUrlO21WEgJ0gyY+r0a/aS6vraG8guc7t50cHj
         vqoQFsPNa7b6c7tZZ3PFvS0TLHZdUHMBhpjnTF9+5srcNCqEp8Br4I4BvJlH+5ARNdGj
         4B8A==
X-Forwarded-Encrypted: i=1; AJvYcCUk3dCySeRVSk/Kj5NHg0lsQoPBBEyt+dZ/j/5gEl+NWD0gEZqe0Wggow9OSjNExuvnO6MQolBkyyqM8kmjcy6uVhV+EKsU
X-Gm-Message-State: AOJu0Yy2ZYD70OQZWIwXBGwLBAX6J/6vLujhAn6tYOoglWcfjY3cEdzK
	DLw41G9/rIKkhiZtc009UHgi/Y7x22RktiwHQgzzQWvS9wyuilZcU9YPrtMij04ltrRwvRHPHxL
	UmEmK5dniuXjRMnIyQSf773LO2kg=
X-Google-Smtp-Source: AGHT+IFjYKnGfjQd5n0HAAgtXpG+19WSfEDB+KXHlqsXWplteZ7ixPlzhVyaiPIonXqMbgw30xfZnX+U7kHSXdXvnAE=
X-Received: by 2002:adf:eec2:0:b0:342:d5ac:c712 with SMTP id
 a2-20020adfeec2000000b00342d5acc712mr2248305wrp.7.1713278139505; Tue, 16 Apr
 2024 07:35:39 -0700 (PDT)
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
 <20240415150136.337ada44@kernel.org> <b725331c-ae88-b9dd-de12-e8e9b9fc020b@huawei.com>
In-Reply-To: <b725331c-ae88-b9dd-de12-e8e9b9fc020b@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Apr 2024 07:35:02 -0700
Message-ID: <CAKgT0Ufgn6O7GXZd8+YR53ciRdyBbWmw-qShy8vo1Es_Xn5KBA@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 6:25=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/4/16 6:01, Jakub Kicinski wrote:
> > On Mon, 15 Apr 2024 11:55:37 -0700 Alexander Duyck wrote:
> >> It would take a few more changes to make it all work. Basically we
> >> would need to map the page into every descriptor entry since the worst
> >> case scenario would be that somehow we end up with things getting so
> >> tight that the page is only partially mapped and we are working
> >> through it as a subset of 4K slices with some at the beginning being
> >> unmapped from the descriptor ring while some are still waiting to be
> >> assigned to a descriptor and used. What I would probably have to look
> >> at doing is adding some sort of cache on the ring to hold onto it
> >> while we dole it out 4K at a time to the descriptors. Either that or
> >> enforce a hard 16 descriptor limit where we have to assign a full page
> >> with every allocation meaning we are at a higher risk for starving the
> >> device for memory.
> >
> > Hm, that would be more work, indeed, but potentially beneficial. I was
> > thinking of separating the page allocation and draining logic a bit
> > from the fragment handling logic.
> >
> > #define RXPAGE_IDX(idx)               ((idx) >> PAGE_SHIFT - 12)
> >
> > in fbnic_clean_bdq():
> >
> >       while (RXPAGE_IDX(head) !=3D RXPAGE_IDX(hw_head))
> >
> > refer to rx_buf as:
> >
> >       struct fbnic_rx_buf *rx_buf =3D &ring->rx_buf[idx >> LOSE_BITS];
> >
> > Refill always works in batches of multiple of PAGE_SIZE / 4k.
>
> Are we expecting drivers wanting best possible performance doing the
> above duplicated trick?
>
> "grep -rn '_reuse_' drivers/net/ethernet/" seems to suggest that we
> already have similar trick to do the page spliting in a lot of drivers,
> I would rather we do not duplicate the above trick again.

Then why not focus on those drivers? You may have missed the whole
point but it isn't possible to test this device on a system with 64K
pages currently. There aren't any platforms we can drop the device
into that support that.

