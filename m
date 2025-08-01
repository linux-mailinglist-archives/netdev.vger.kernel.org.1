Return-Path: <netdev+bounces-211310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E68B17DAD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3DE3AA447
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830C1F463C;
	Fri,  1 Aug 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sx3ZH6hd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253183C38
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033728; cv=none; b=M32N/ZRslbDtqX7lOb8j9FprHiM5XQxHFDI34hx3BCTyv0u94x53F13bAEuurHTYsmjuYALWlqySTK/z9HOrJ0fwrckeveKelGq5sA3nwlGDylYCsIhipIBOqIm3tfw8fYKR3JPckbQDFLfPRiNzGLwJYpGUuXSU38qhXGPmINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033728; c=relaxed/simple;
	bh=xJcglGO/H/USD83iCgW/pOpy3okJd22Z1PFabqX1UJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvIjYad+YPRPHPGxYI5A9/59bAq9eBhPGNtFhpSfX2B5CO1Btxa3odIJbAtfdjwwN5N15UcLEHEUCUiAD5R8KBg3j62GnDtftV7Qh+HqQr5c+RDkyKytwBv4LkElcFrUZAVS5+G3EADiRsS/gmwlWeZbYCXBFe51d94nyiQDQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sx3ZH6hd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4abd3627e7eso15319651cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754033726; x=1754638526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbhzjCL9JPZs1dC+k5leCvxZq6ylOFNygLdnBlbpqHY=;
        b=Sx3ZH6hdP3fovy5FFQJ36wdcUFk3LDeN7+k3eJZ5Pi4DDrupYHm78Q3okLM6qPWf/1
         OdmWIFCvg8AgdAAAyzjrSKPZJ/LPKVExMohVXlsRFDixVgmtxNR3PJGWONsh3SXp4aBS
         VtDfrbJTQcb18PoKoeYA1HfJRs1qr9fpPh6rgVL3DfUS23uHdTb6OCgnX6GoEfPeAnwf
         4BSzEAkYrYHL1dgPDz1U6Qhg3D9ZGP/LwNJTH5D1zbZoCVi95MjqglBDiTa5tLhLiWA+
         FdMbNoaKpnTIXLZ6vERUNK/Lf500nfF3E1qQ2HX5I1sM2i1vBv21bslJj32Yk0NpqcYy
         +jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754033726; x=1754638526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbhzjCL9JPZs1dC+k5leCvxZq6ylOFNygLdnBlbpqHY=;
        b=P7qLggJsA9qg1G+yPkV18Jp0WMhLRaKfiMSRANjyPtf0pB2QUTO5178awbA/luyqW2
         SYmJ411Dt6aaOTxOi3I/RlOJ/f+QXat1uuZ/PSqFLLBglu5Ck4Jn6sp7Qk+Uk+Xj94Qg
         A3+4Hu2bPx98+vPbwDOWxfrNp46lcnwFJelFRBOh2UijG6xa0LASF+S7TzcZMPBw5NsN
         hIYvCM9GQBYxsv715iiRy44Vg3dR4LXQDz44Qh0KmorqHK9wtR2isGQ1A/t9qutFxAhv
         1IZbCeV02/jLG8xMwxeX0ULa5Rb+PzHIVFF1CfuloXCDG+r+NA1TvtRpqwD6my0YzQvw
         qmqg==
X-Forwarded-Encrypted: i=1; AJvYcCVoG7DeB5dRfo7e8KJPqRdQZsybLz9FtMMGfmPoaDS973cHC5ixgELRbaPP3NAp/QUCYKJZvF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bKMkQ9u4qbXOcm05XvJ+Sztv1QaU3Zy8yUdhxkDYqeZEXi/+
	qSlRKp5kM6sM1HYdcIrviDgnfY3rzURCuY7vnK9EsjPvOkVcP8RIJFBarsLckuwfeTFGUc5cAku
	ckK4R7ZXqIkYuINOhuv9J4LVB2PkVyR9NXC0a2HAt
X-Gm-Gg: ASbGnct5EscSJozY7jVqd1KyEmUIoOYiBGGmyALQYyedY9BKeCNNM/qckqb9HRqSvKU
	lHs6L72VzsvokQhdEsxGCU0KmnyB7DhyNQJCt/Wtu5MsTi6yhGhVDyB4IhdYOs7E3ac7t8AQEOE
	HhiB8woQQKgJVgakwhQB1X7iMWdMMCzrvlzHKbhI5hJPvPhZze/V8k59hSmp3k8TtgC0EKcqetW
	mFU7RM=
X-Google-Smtp-Source: AGHT+IFW4MnkNdUhwyQaa0KplnCGy6TiRHpjkhg3H7kikISciKGvWAm/eYkKfstZ9B7WK6STZEDRo2gay/fqqgCc2QY=
X-Received: by 2002:a05:622a:2b49:b0:4ab:72c0:dd39 with SMTP id
 d75a77b69052e-4af00708864mr20494501cf.19.1754033725490; Fri, 01 Aug 2025
 00:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731184829.1433735-1-kuniyu@google.com>
In-Reply-To: <20250731184829.1433735-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Aug 2025 00:35:14 -0700
X-Gm-Features: Ac12FXynbiINKKk0kP0byXTknFP8NximlPihv2IzaANs9G7aa7DpzE7_UkqdfYA
Message-ID: <CANn89iJKYPAMR+ofaJLsQpew2E-0DH4eLh5-QF7tB56-8BfWxg@mail.gmail.com>
Subject: Re: [PATCH v1 net] netdevsim: Fix wild pointer access in nsim_queue_free().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 11:48=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> syzbot reported the splat below. [0]
>
> When nsim_queue_uninit() is called from nsim_init_netdevsim(),
> register_netdevice() has not been called, thus dev->dstats has
> not been allocated.
>
> Let's not call dev_dstats_rx_dropped_add() in such a case.
>
>
> Fixes: 2a68a22304f9 ("netdevsim: account dropped packet length in stats o=
n queue free")
> Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/688bb9ca.a00a0220.26d0e1.0050.GAE@=
google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/netdevsim/netdev.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 39fe28af48b9..5cbc005136d8 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -710,9 +710,13 @@ static struct nsim_rq *nsim_queue_alloc(void)
>  static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
>  {
>         hrtimer_cancel(&rq->napi_timer);
> -       local_bh_disable();
> -       dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
> -       local_bh_enable();
> +
> +       if (likely(dev->reg_state !=3D NETREG_UNINITIALIZED)) {

I find this test about reg_state a bit fragile...

I probably would have made dev_dstats_rx_dropped_add() a bit stronger,
it is not used in a fast path.

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5de4b0a433c6613224b53750921ab9f5a39c85..0b7ad5ae4b85d480aee8531e821=
027e6ebe7119b
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3021,11 +3021,13 @@ static inline void
dev_dstats_rx_dropped(struct net_device *dev)
 static inline void dev_dstats_rx_dropped_add(struct net_device *dev,
                                             unsigned int packets)
 {
-       struct pcpu_dstats *dstats =3D this_cpu_ptr(dev->dstats);
+       if (dev->dstats) {
+               struct pcpu_dstats *dstats =3D this_cpu_ptr(dev->dstats);

-       u64_stats_update_begin(&dstats->syncp);
-       u64_stats_add(&dstats->rx_drops, packets);
-       u64_stats_update_end(&dstats->syncp);
+               u64_stats_update_begin(&dstats->syncp);
+               u64_stats_add(&dstats->rx_drops, packets);
+               u64_stats_update_end(&dstats->syncp);
+       }
 }

 static inline void dev_dstats_tx_add(struct net_device *dev,

