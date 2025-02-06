Return-Path: <netdev+bounces-163369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F8FA2A071
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C722A1887791
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4A22371E;
	Thu,  6 Feb 2025 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T45Bgkpr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714113C80E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821476; cv=none; b=hV73XSt/wyGnQqGr7qAgaHLoH8g8sDZIIcVCsvjtODfNyZKosCSbktua+3cw0w1zv5WukXONIUjadS4Jyg5hO/tG06GlR0IYKn+nwdbwn1+XpZPeUWTQIBv63MRz8g3iKR8IPOMvVDyV3z2TTp0Q0wUT5VLCY4M3XxJnk91R09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821476; c=relaxed/simple;
	bh=KZ6GzSKVNvQUBgE7p7ZRfNJRnFA4vGZWZpX8qTjphZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnO1PmyzL6xXPe3uiEmak+mo3CZz8Q2B7A62zhydfiGAICiudsEky/f1HR8VJUXdzHabLt7r9RP9UqRhyEto7uu73e23w/UdYAk1WavDbrYr1hww1+hTWfb2MD/LJRr9fT/c9Fq4nPFHSby/GdWgdNbX4dILPOLjfqG6O5t0V3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T45Bgkpr; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b82949bad0so81429fac.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 21:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821474; x=1739426274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ6GzSKVNvQUBgE7p7ZRfNJRnFA4vGZWZpX8qTjphZw=;
        b=T45Bgkprw8eOmpZZmXGdhjG2N7MUIH0bVNRQ7w2TlaW4pxw6fz4uvZ50bUw54huC4S
         J29PeTk+uz/PckoXMYrUbgrx9t3J1W5yUMoJblX1nu36Cl+NGXtKv9K609KqG4HdUACN
         hjY2pRtqE6VUjKMmes/1rxLLdzDi0HkBMr4bBaLoUQ49AZvdH4mED+1Xeo4/ODOTTy/0
         5VfO853J9q0m1Jw6wr9cw34jUIDFGfv9EMLyXddhGhgwBHFFkVRapCiJpwV0dtRN/1B+
         sernvpHgnYxon3RVTfAfwnI/JLwYpTo3eR32FRbRwLHIJNubFAJNI8LRRXpRMm33TKf7
         onAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821474; x=1739426274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ6GzSKVNvQUBgE7p7ZRfNJRnFA4vGZWZpX8qTjphZw=;
        b=QwpcmM4bJAhVBHHT/KfPpXt7mTj1KBbZkzWKD02EbC2RO9qhABRSuahqI5ZbgacSlO
         QtAVLF6EpYxJTNnEZb9pKansCNL82R1MG+VhoSGeSr69lBWAwR6e+9JETYSB5lh9HSvS
         vENdaYzk2GXR7NFdTHmSCuiXkD1BToG5oqUei2l7kGPE1vGIcxLKkAR1ErwLyyoHRUwm
         TmgDmgVHZPcgObsdhnWJHIBS/XnsNF0eDQ4bNm/tvULsdTGAH6nSQH3shbHVF8xSUx23
         mExrIFB3TmxEWZOnLrbI+RcGvR2CBh3X3Ty6aFEDctzOmgcbrsin0izQ7Z3vz/oWr2dj
         PERQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpVk7zAgk8cGvfUdY7f8Um7r/mj/m9BdETV9qL2DTL24JXgfkh2afm8GT0HBNH5f6MBdt+EyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOo4dl16QtZ1WJALIkwfR9DLW4J+Ou19LqcjKrHfTpZ2CgDQ+
	HOjk8Lz4cOJhZ2KKVhls9RjyfaDB092Sz0jeD4VWh75YBKMF9UiiQM2U6m3rQD8cda3C3olQ6CX
	A5uhfz7l0LeN5ZWgcYjsevZSAYHQ=
X-Gm-Gg: ASbGncsK5nc4D06lumnT3xdRw65yaqAKTmx6UAhvIJfMc6C4N8tTeUd36rLPQiIreX0
	/B20h1VMuOhdNKPSWw2LkwCw/9+Ck1J52xSbjpfzIKnckYR3OjmRJNJPdO1bnhMvPYq3es8qSyX
	Gd7qW+W02mnRb6GGqhn9ZouAxjvZWv
X-Google-Smtp-Source: AGHT+IEtTv9bNEGyUDH0GRmYJaT6wcw3R9Dkb/yEro0H0S0tUu/YBNxOM26sdiZIzZmNjgQQFVw98gol0+8azQ0hTHM=
X-Received: by 2002:a05:6870:2427:b0:2b7:d3d2:ba53 with SMTP id
 586e51a60fabf-2b804f2066dmr3435563fac.12.1738821474136; Wed, 05 Feb 2025
 21:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <CAA93jw7tVyiz6Kj8B5zXMqYKxLZSnctGiwbH5hC+4_ZTWpg3fA@mail.gmail.com>
 <CAAywjhRd-tQz3ra6uUvZf_rwTT+5a04BfeA59bcG8ziW_4FLWg@mail.gmail.com>
In-Reply-To: <CAAywjhRd-tQz3ra6uUvZf_rwTT+5a04BfeA59bcG8ziW_4FLWg@mail.gmail.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 5 Feb 2025 21:57:42 -0800
X-Gm-Features: AWEUYZn-K6nbjUDXoNnf1r5m2s7Sn8oXqvrc5pamXlDRA9w4HlFAhBzOqs699Ns
Message-ID: <CAA93jw5a71Egu9xwjwvx5RLmPa_j7EvU8ztRgTsLNxH2xFV6yw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:49=E2=80=AFPM Samiullah Khawaja <skhawaja@google.c=
om> wrote:
>
> On Wed, Feb 5, 2025 at 9:36=E2=80=AFPM Dave Taht <dave.taht@gmail.com> wr=
ote:
> >
> > I have often wondered the effects of reducing napi poll weight from 64
> > to 16 or less.
> Yes, that is Interesting. I think higher weight would allow it to
> fetch more descriptors doing more batching but then packets are pushed
> up the stack late. A lower value would push packet up the stack
> quicker, but then if the core is being shared with the application
> processing thread then the descriptors will spend more time in the NIC
> queue.

My take has been that a very low weight would keep far more data in L1
before being processed elsewhere. Modern interrupt response times on
arm gear seem a bit lower than x86_64 but still pretty horrible.

It=C2=B4s really not related to your patch but I would rather love to see
cache hits/misses vs a vs this benchmark (with/without a lower weight)

> >
> > Also your test shows an increase in max latency...
> >
> > latency_max=3D0.200182942
> I noticed this anomaly and my guess is that it is a packet drop and
> this is basically a retransmit timeout. Going through tcpdumps to
> confirm.

sometimes enabling ecn helps as a debugging tool.




--=20
Dave T=C3=A4ht CSO, LibreQos

