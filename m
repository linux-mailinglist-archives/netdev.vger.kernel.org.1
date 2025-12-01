Return-Path: <netdev+bounces-242944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A6C96AD2
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FE93A137A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F22F3617;
	Mon,  1 Dec 2025 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jt9VKbJS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C3286D70
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585263; cv=none; b=OIOuOSo3WU3zWRN61UIlq7ro/ep/6Pnvwxtw41du4U13yvAikvjL7Fupzo0A7M+PPn1NsUQHRvHVAnVKJm9j8PW16E5cWCXBfmP0K48i9VxTOygnt6BoQCRLp8nmWILQS0lOpRAeT60NQEKw3cC4/ZZwhdCg74T+N7Dh9q/B+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585263; c=relaxed/simple;
	bh=Oxi7nT6VurSzH9fhI7KO+xkGyW7GtdhIMvsYfOPw7UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxjsl2XMcyWFo1vFkZT/c8vV4CvmY16uVuqMim8OY/iIjHnkkuCpnLrlozMoaHqXt+DJpoogTbDvnjle2w5O2s8D9fBurJWdGM+AgbO97YvtCOXmhjtsxXTJc92r0gBOG/zjsuQCDPWzGeIdnzzTpeCFojG808nZmvre8OARmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jt9VKbJS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eda77e2358so34990751cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764585261; x=1765190061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NFC26iZ51Jq0FMro6cx4anMEPoTOz73Uuc7um5nw/A=;
        b=Jt9VKbJS7lwcuQaoB9UY5Omyr6CPTG5avcVKd0dVXFC7eaAYU5X0EGyzhHqM3LBLJg
         c6GSFUlGSMimdUzNCWOWiDP2m/pYIaPlNV5831Eh2KdwxajFb0L67QToanuCe1T8o8Qd
         AnB6m5H+eC4jsAxyQkQQuhov9vP3UyO/WPUm5Dh95UERWbrjaCA3wAUtpF8Xjs+d429k
         C0nvSpyZQXAsgzqN+uwGoVDuq6uFmiUUXDiYUgshsUSxGYAfz+0SQmdI7z1iALXABnGd
         WoTTFMcveTG/Akd4jAIsqHBRuXUx5bQ1X/atgFAynYkZELy6qMF3ziAxGov5jSflnVTj
         OUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764585261; x=1765190061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NFC26iZ51Jq0FMro6cx4anMEPoTOz73Uuc7um5nw/A=;
        b=a8jbxiIMf1sOIWowDHkEmxeXC/ckdJtju1lN16tuC676onuqWD/dM0bA6YaTaiplbt
         ot1v0BYG/iDIXVL8lrQBU0kaRtKtsq0YPSCGGBiB5BcqGslHJ0UocvZsLEsRd6A0cmVg
         VUuVHaC4Al7F1aD/2ZSanCZtIn5z5EooDjo8arGgwb49obpyeJN0F5Vr2CmLVSKQZv7l
         t7Y9xych2SkgB6F1o49DqWuf4xqpQjZqwsvoRd06dJbdG/KsnnteeoG88pmhHwK9wUAT
         6WYXyFpNjCJUKrFiDPXfhkEcb8SAOq3EwxgQyuwU9ybSNJWkDoNS/f2fSuz9mx6qE+j/
         B5ng==
X-Forwarded-Encrypted: i=1; AJvYcCUFpvVyjYtUSSZDQNrjkLeV0j98UpDciuYkEwBvPu4j0PFAcdFwyN3v9VwJaASpYTsb3lNYFUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKEPIcZDe+SnPbB8SLwiYinoZ/oAQStjVKTcAOasSQQUaTQGn
	MgEqd2vm9bbs+cxz+h1GwV6ioZ3bEwmrJ4HegZj+m167cbPJFnsz1gOzYn+9V9/34JgGmmr40St
	HT3fCmhPAQd6WvAjjYdfVbh6lBxkIsxs+DzMThXm7
X-Gm-Gg: ASbGnctN/qdb3gkJZ0qeyN1asdJDYSkpTijl4nNiOQ/yZ/sj4YjK0LwJG5z7untaRi6
	eRbjwgXIO0NjE5PXmbdXtdUZM31N76vfVsl7imTFlzmWxlfEcOTP4IAOjZwRMVmbhvRdwHhYIy8
	WZKkY1zs3Q7ZytTet4rUcr6s+MPficxjKJUGoX4c2zhkk9zoYiZGnqT8gLi3fXPYwqPzXrIi1mE
	A9hnNl+E2rz+nPQgORnZD6zGSl8P9INfF8BYwvn/767fUVgS2sepbGBRJZPkIx2pc0TmU4=
X-Google-Smtp-Source: AGHT+IHrOCxJDylsnf5RjbZYp5/hq9LRYZJVRZTrh485sxhY1zvrz1HEnuJgz8DasBfdSKWNNqOGg7kYZ0BBwnjm3h0=
X-Received: by 2002:ac8:5ace:0:b0:4ee:1d3e:6aba with SMTP id
 d75a77b69052e-4ee58b29568mr578454331cf.74.1764585260665; Mon, 01 Dec 2025
 02:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130194155.1950980-1-fuchsfl@gmail.com>
In-Reply-To: <20251130194155.1950980-1-fuchsfl@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Dec 2025 02:34:09 -0800
X-Gm-Features: AWmQ_bkHbwPbn9xWGDfCo5ilV01Qvn8Z_JeT-bzbJliOYcgsFkjYCR2lM1YMuIM
Message-ID: <CANn89i+q_KBrrhY-PjqdG9gxkdYyWy88Vbgu=PAr=SqDmvOyUw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ps3_gelic_net: Use napi_alloc_skb() and napi_gro_receive()
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 11:51=E2=80=AFAM Florian Fuchs <fuchsfl@gmail.com> =
wrote:
>
> Use the napi functions napi_alloc_skb() and napi_gro_receive() instead
> of netdev_alloc_skb() and netif_receive_skb() for more efficient packet
> receiving. The switch to napi aware functions increases the RX
> throughput, reduces the occurrence of retransmissions and improves the
> resilience against SKB allocation failures.
>
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> Note: This change has been tested on real hardware Sony PS3 (CECHL04 PAL)=
,
> the patch was tested for many hours, with continuous system load, high
> network transfer load and injected failslab errors.
>
> In my tests, the RX throughput increased up to 100% and reduced the
> occurrence of retransmissions drastically, with GRO enabled:
>
> iperf3 before and after the commit, where PS3 (with this driver) is on
> the receiving side:
> Before: [  5]   0.00-10.00  sec   551 MBytes   462 Mbits/sec receiver
> After:  [  5]   0.00-10.00  sec  1.09 GBytes   939 Mbits/sec receiver
>
> stats from the sending client to the PS3:
> Before: [  5]   0.00-10.00  sec   552 MBytes   463 Mbits/sec  3151 sender
> After:  [  5]   0.00-10.00  sec  1.09 GBytes   940 Mbits/sec   37  sender
>
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Patch looks fine to me. My PS3 died years ago, so I can not test it :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

BTW, I think we can cleanup gelic_descr_prepare_rx() a bit :

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 5ee8e8980393c3491bf9cf91eb8e0dbb2df0f427..f4f34e9ed49c5b7fd1cf4ea3f5b=
fe7297e97ea23
100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -392,10 +392,8 @@ static int gelic_descr_prepare_rx(struct gelic_card *c=
ard,
        descr->hw_regs.payload.size =3D 0;

        descr->skb =3D netdev_alloc_skb(*card->netdev, rx_skb_size);
-       if (!descr->skb) {
-               descr->hw_regs.payload.dev_addr =3D 0; /* tell DMAC
don't touch memory */
+       if (!descr->skb)
                return -ENOMEM;
-       }

        offset =3D ((unsigned long)descr->skb->data) &
                (GELIC_NET_RXBUF_ALIGN - 1);
@@ -404,13 +402,12 @@ static int gelic_descr_prepare_rx(struct gelic_card *=
card,
        /* io-mmu-map the skb */
        cpu_addr =3D dma_map_single(ctodev(card), descr->skb->data,
                                  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);
-       descr->hw_regs.payload.dev_addr =3D cpu_to_be32(cpu_addr);
+
        if (dma_mapping_error(ctodev(card), cpu_addr)) {
                dev_kfree_skb_any(descr->skb);
                descr->skb =3D NULL;
                dev_info(ctodev(card),
                         "%s:Could not iommu-map rx buffer\n", __func__);
-               gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
                return -ENOMEM;
        }

