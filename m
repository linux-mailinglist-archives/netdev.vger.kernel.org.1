Return-Path: <netdev+bounces-170635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E28FA4968A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6F87AB1C7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64425DCF3;
	Fri, 28 Feb 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVJSBrlf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732125BACB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737076; cv=none; b=naGtUxAxnJ5AcAJBRIA/VZwU91WysWbiTidMlb90+337HQMkckL/ld6BYL2CHzbds2KJn8XHgv2mELcBu+ky7rPbz93O7AWkkvzcEIpCsEyJfsXMU6U3kZihNulwUmk58ESWf4wBN6ZApE139usLIyltL3Vxw+a/gvQRtxEOmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737076; c=relaxed/simple;
	bh=UuKQE9PiNiWTjYawC0D2E2T+N47JBs6uLT6vnIJ4QQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnuuNyFBYtqJhiEowtY1wlfrFvRkdDi2PENfSCiBJfgrAmQEJmBGZZk4HnWCkEEHbJCvTp6tdbIs8cnUiqQh2eZt7OhLt800KQ2WAo4fSdKWwt+v6UhmSMQdAOxsryz93qdfxMULfpOL0jcLU79lsE3tWJkbhur42g6/iA4Eeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVJSBrlf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740737074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFknwG0iNq5Q5kJsZueQ+sfyg2R708bSAk3Lf0iOtWg=;
	b=BVJSBrlfHGWgpzCaTankw/BLSmB/YBOlTPgPe5irykpHrvNQdW6ETUI60KzL6n5KPqt7t+
	tq+69CpjdJ6aTIjP4YztT4UsXtXYe54ZqyT6Lkn258+8xzOBKzP1nU6nCFKnDe3VwA4oSI
	DE8RvNSHZzPZLPUzwFaEDNn7HHsvAJ8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-XtFO4JR0OlGqLtQsa4OsgQ-1; Fri, 28 Feb 2025 05:04:32 -0500
X-MC-Unique: XtFO4JR0OlGqLtQsa4OsgQ-1
X-Mimecast-MFC-AGG-ID: XtFO4JR0OlGqLtQsa4OsgQ_1740737071
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abbc0572fc9so242983766b.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737071; x=1741341871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFknwG0iNq5Q5kJsZueQ+sfyg2R708bSAk3Lf0iOtWg=;
        b=I1LnybHVkpDBTYw7g2yRSx/OhEJ5mJYganlhVOO16/Nn4T10Nk493LvQDxwzQr+Gej
         iPE5KUdUjgNIgA6QizBXBBqGfFSdSaQne5MB4eVs4oNQEPct5f5tXF1MtCJejgnbSWkB
         TLkGTniOiaNhsXYn2VGMizyzE1T7Io5bN0ADZSx19ySXbcieV2vuQswAYZEsKy93W0DI
         Wx23ctoBWpevgWUXyF0tNI7d+NEPUpPOpHXcKVgm1L09pTjrAvlpvr+nVK8aQ+zKuf+k
         MNIxZIRQXvBT2tHqn4+pD/pOl48+s/9lBwzdsBehhaJRcq52GosSRLNIUwmPx+QFfyBy
         qc4A==
X-Forwarded-Encrypted: i=1; AJvYcCXiHwEOH+Pii+HVStWAHOWsAit9rqSEvblgydjpKF2Inq+uZbT0gPm9f07eAE64oOknH4q7yVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmt/C4sUrwpnXyzEEvBtLpQjETqz+U7D9wdakemrqJZi7ibR+
	V2KWzHCjy/iZek5hLhiT1YEYx1lxlUD1UoQvDBI3OagaGqBVmeZW5RBIUVrlJt8Z4IvCoM935gm
	JVos3OY5TUsMgNfoUgNAePFfgkcDg1lu7Ao4k+S471mm2TQ05n7LIfm+9iulchPLR2zVuBTV3mS
	+8cj1/4XYTgTx6MVL9abFO7JIqac5C
X-Gm-Gg: ASbGncvSZ0N1vU8GvIN9sjREh+VXsUfi5qgKNGy6MRwOQdyMWmX8aTB2ROypHRHBRKs
	lnhmlXnM7a6PGM0w+AHaKINuLVVJvlr5BW22NnqXrPGuLjAvWd4XsfKa/Exe4Togf1nL2NgUkRA
	==
X-Received: by 2002:a17:907:3d88:b0:abc:919:a989 with SMTP id a640c23a62f3a-abf2682e053mr246635466b.48.1740737071091;
        Fri, 28 Feb 2025 02:04:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlP3JKJrSRB/JTuQ4dTL5H95aY/z5Nm2RXbOFZIVZJxtaPYIfL4JwvtC2IWGfuLodoaul4Om5m1WS3z/d2xWM=
X-Received: by 2002:a17:907:3d88:b0:abc:919:a989 with SMTP id
 a640c23a62f3a-abf2682e053mr246631866b.48.1740737070662; Fri, 28 Feb 2025
 02:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218023908.1755-1-jasowang@redhat.com> <174038523026.3048719.1870378720430783513.git-patchwork-notify@kernel.org>
In-Reply-To: <174038523026.3048719.1870378720430783513.git-patchwork-notify@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 18:03:52 +0800
X-Gm-Features: AQ5f1JrhkprlWfBZR5KYsNgoMHpIaTrKPDWKrlUwM9FIxE_uaiyMqKH3Hp4X8Tg
Message-ID: <CAPpAL=zF3oFO3OSO793Hk0YQGh2PK7RsdjZ5bD19-EHFe_6CyA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	patchwork-bot+netdevbpf@kernel.org, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Feb 24, 2025 at 4:20=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Tue, 18 Feb 2025 10:39:08 +0800 you wrote:
> > There are several issues existed in start_xmit():
> >
> > - Transmitted packets need to be freed before sending a packet, this
> >   introduces delay and increases the average packets transmit
> >   time. This also increase the time that spent in holding the TX lock.
> > - Notification is enabled after free_old_xmit_skbs() which will
> >   introduce unnecessary interrupts if TX notification happens on the
> >   same CPU that is doing the transmission now (actually, virtio-net
> >   driver are optimized for this case).
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] virtio-net: tweak for better TX performance in NAPI mode
>     https://git.kernel.org/netdev/net-next/c/e13b6da7045f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


