Return-Path: <netdev+bounces-176744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2704A6BE04
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7A93A85B5
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522E1D79A0;
	Fri, 21 Mar 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LAsuQIo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EB18858A
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569999; cv=none; b=DWQ+fbF0+Tk8ZnU5AU3xWkRWqUenVSCVz2Xd0BqgkLSVDnksxNzLwf8zqx5KeztuqZ85wqUfLGgIOb6pGttuFP82g+eBbPjZBuDi9PbDGbCHGkV6pTS+yuICuql0XkiUtkcClL2+vkzJKJ32HSRZAEssqegdQhTpARfPpMe9Dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569999; c=relaxed/simple;
	bh=rR79tbWP+1YMxLCZkPMGkxbByXOoDSm03FZ0WSLrUsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA/opNoxCkt+W9hnCPzhwfAp4srHkwSndy8VR/mK5MA1s/FJj8C4VZcDT8LZa89WTMiFy4pX+qY+hQ7v4Fhv5wJYBAS0vc7exw4BM+40eHvu/ZslO7xsDeWTB98JObWe1NGn6UZTvMbFRiUbQJ0DdNUknWTdo3e1oVPF/SPlUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LAsuQIo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47688ae873fso20920501cf.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742569996; x=1743174796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tHHIrPqJW/dhMbJ42KnhCWqKTqIVh+RwEH2sp+CKGY=;
        b=1LAsuQIop4ZGt4ydKa4+S6NQgxzqVWJv+puw3niTsSD5xI5Z1FGzoDTU9soTwMBFyZ
         7oDToWn+j5gJvjZEFJQ0q1sTUl2O9b5ZWTAIXKcj7Lh/sT5dxc6rDoJeAjY3ElwbznC3
         Lk3fb9iua/ZMjztk/vES9ScRzFxxtBe7TNAdSZQ52UMK1Ry2E+Agjg5Eo6F+CPuTRG76
         NTGeUF9lBgz2A8W6v6IhY7bNRuygbrqgaS9KVjT2rzs4ZuKILp3ye5Out46j87Yv6Qf8
         g2LGw6KiUIYRCueZdFHYoVVIdmio+r5XlYEbLlWGkwvZtp8z35uPakx9UPP03k46pLVU
         NhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742569996; x=1743174796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tHHIrPqJW/dhMbJ42KnhCWqKTqIVh+RwEH2sp+CKGY=;
        b=IUS2+5+Eo+ZqmN8rs7wRfajmobQjTqeCNgv2nVVnNOVdpOcbYCs3/25Jh4oQttcsji
         a/uV4nPXM+TkbXlU5ao6nahv3+BE5EUL7LfOHXJ6cJJsKPmG9RGpdY8zEZDwgE9rJXnj
         KlZx8GnKLnSTcfsSBZlfDDW7onfCreJ+5qPFAK7F/LVsvfmWUtO9VnvooSSxRPX0NRTW
         SK0GjOznJCcIGRXybkNNYae4vBNMbyyGFz7vKNVN8s0DHI6NaR5vNy8SfFN0U1SpEfu0
         lqH9OGvhgzP2JAVbFIqySDTF6precX1/BN0QQTa2oGSRp1VUVYx0qMZ2BbMTroeym+77
         tWSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0yk4PyfBK0yiSYqsYTaZSyL4yMxg2O8mX4/jvM8Fh2hIVHfx34baBxHszCTgYln8HOQ93MpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCz4wGOGj1qTxPzrMIgh5evPz81TzNNpv16AWxNIyTl/gnmMg
	cwnwLVlNz1hCFMbDCJESeWosmnXcRqdI5hHBjk6It71MMPdUI7bbAN84Evl1XNIgq139B9eR6/Z
	5pnhEk+dX5NG27WwirPUlLswjMT5Qcq/i8/X5
X-Gm-Gg: ASbGnctCZ4KSmKlUd6/RoGYetqxmh2B/0XlXXNNad2RIzAeifUO0mOt/QsRTiiH3IFT
	EOCDbFNI0R5dcZrRbAAGaBI5NfldMq1a7kqk/PUyAWL6Uk3ictHHZFq43gzZG+1E62ql8ezm8XK
	7BDErhq6A9uY1e4vZyd+JYRIJFLZYAEXqzwqw=
X-Google-Smtp-Source: AGHT+IG7KBMcJue7QheRLhZKBDvi1C8hUdlYyAMS4RYvgI1oMECk6x11bhhwn+ySWnwDiOb99R8WzGGs0BOeVderSkI=
X-Received: by 2002:a05:622a:1e0f:b0:476:afd2:5b6f with SMTP id
 d75a77b69052e-4771dd9b3a5mr48681641cf.29.1742569995636; Fri, 21 Mar 2025
 08:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321121352.29750-1-qasdev00@gmail.com>
In-Reply-To: <20250321121352.29750-1-qasdev00@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Mar 2025 16:13:04 +0100
X-Gm-Features: AQ5f1JqyM7auzV4r3GFGYZ-GyXF3263m_GX_tJo8yJ2yPw2NWRFggXNPfQlg2EE
Message-ID: <CANn89iJ+VtuyB1tRLeNqVzx3ZpxEiusyfAJv855B90P2XcpDag@mail.gmail.com>
Subject: Re: [PATCH] net: dl2k: fix potential null deref in receive_packet()
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, yyyynoom@gmail.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:15=E2=80=AFPM Qasim Ijaz <qasdev00@gmail.com> wro=
te:
>
> If the pkt_len is less than the copy_thresh the netdev_alloc_skb_ip_align=
()
> is called to allocate an skbuff, on failure it can return NULL. Since
> there is no NULL check a NULL deref can occur when setting
> skb->protocol.
>
> Fix this by introducing a NULL check to handle allocation failure.
>
> Fixes: 89d71a66c40d ("net: Use netdev_alloc_skb_ip_align()")

This commit has not changed the behavior in case of memory alloc error.

> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/net/ethernet/dlink/dl2k.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dli=
nk/dl2k.c
> index d0ea92607870..22e9432adea0 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -968,6 +968,11 @@ receive_packet (struct net_device *dev)
>                                                            np->rx_buf_sz,
>                                                            DMA_FROM_DEVIC=
E);
>                         }
> +
> +                       if (unlikely(!skb)) {
> +                               np->rx_ring[entry].fraginfo =3D 0;

Not sure how this was tested...

I think this would leak memory.

> +                               break;
> +                       }
>                         skb->protocol =3D eth_type_trans (skb, dev);
>  #if 0
>                         /* Checksum done by hw, but csum value unavailabl=
e. */
> --
> 2.39.5

