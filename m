Return-Path: <netdev+bounces-115641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3D947540
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87408280C0D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B2F13D539;
	Mon,  5 Aug 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVZrCoBA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54312B6C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839383; cv=none; b=dT+Q2xXyOeZM4/2QNaBok7XqRZFBG5F7uKiAB5JiFfoWFr7wNoCDcBWuSSTy5fRvu3wsEJzlmjgtxBHP5hUBZPe3+Boic5UNO/LYfPTyNRfbL+PC05P1I3EacI5Ug7mof+2q7VIXHeLLGzNgQ58IL/6UKEjhQgfzoCPbrGTqu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839383; c=relaxed/simple;
	bh=udiKCboKriswuzvRHJ7hujV0tSl5RUaQqJDjUIeE/Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8eg56vtDom1+Gv5IQG4Vn8PFy1w/Z29C/ROhnuymXSbYHdIn8s3BvIEr1Z2HYvKWzvzjIl792ufN/GoiSqUhNHbqvP4BRddP0/5dBPYEnOJq/n5WSyDqc5IF5oBchtbose/0O+njpH2JrSwnTwG34dkOa5AjRVarY07PGm5Utc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVZrCoBA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722839381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XRx+lmyn6uq/ybb5wN7vybzbHC8z6mqvFUTs8GuDeY=;
	b=DVZrCoBA4RqRKukGRS2HSmDD8EFfuW+Zovn34Bpt+NvEjRC1IqnZi04EXZhgCa7PdpAgV3
	yIeW6CQ9gVe3rcmaRn82HPTS5vYa5Lexo4VDERhrHkFtvjJJxhqjFn4QMryF0X+Vs75qqw
	GfiwWRO4TINwxk0B1daG26WmKI7661o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-YAHE-EvBNLmXI2SSpGywAg-1; Mon, 05 Aug 2024 02:29:39 -0400
X-MC-Unique: YAHE-EvBNLmXI2SSpGywAg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428ec88e02bso18633925e9.3
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 23:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722839378; x=1723444178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XRx+lmyn6uq/ybb5wN7vybzbHC8z6mqvFUTs8GuDeY=;
        b=mmdeSAFZo2NtIIZsbr3ZmM651/SWpl2ir0itasDZY4cnrZ7qaLb2maQEGYLMz8yveq
         p2qYPOt9PzyNpF74axOW0tugxjnGQfbzKv04pBL+/0Esb2GzndS7q6AXU6uLwm0hDjAU
         AOYAo/zIo86K5O1E/u8PdicS02SyFsuBzV/Lv6Roim1dZDBId739vh1g7NFT6wocbA5Y
         O0ur35FzUL0g31HdFDBtwBiEKMNSK1SLmJD9fZPjqOQeXFyB9FGnRPqNqME10tFvoedi
         rOnISONmHhDoC0lKnlSm09DcglpXPWaI8gnaVLMZOrC1PBkA6oyXlQrIzK0YuhEIB3U6
         uUVA==
X-Forwarded-Encrypted: i=1; AJvYcCWoC4CADoYCRaPz1XciOhOHPdI+NaSRC8/R8/7Ro2J7COZ2SUvbD93Vm+/JolwAEgUdLoO31eMHreS9DqxZtisAh3UPfeSp
X-Gm-Message-State: AOJu0YwYoSVMCrXQoH92nBGeS1CGv5Yt94ayi70PAZ8D3Ii0sRShfP8H
	aVRINZ430ysicDAeo6ZaAN/Grr+y8yhMkQ06q9cS5qKHR6JGqBr4zUnlzwZiLK+NgyFYWVKBz8D
	f1Jeitk+lN3wZFzhoYJ+yPdXSucecXGqDPGJvDTUnYl0UQ9JkGFvSiA==
X-Received: by 2002:a05:600c:a0b:b0:427:d8f2:5dee with SMTP id 5b1f17b1804b1-428e6b00661mr77076865e9.15.1722839378545;
        Sun, 04 Aug 2024 23:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFINePCnZLcuIGxZtA2nuSnkEf6fUaBsj+jItQS7WQ6lutQQsL7pcNcvb+6vw4sT7jlfkq07A==
X-Received: by 2002:a05:600c:a0b:b0:427:d8f2:5dee with SMTP id 5b1f17b1804b1-428e6b00661mr77076615e9.15.1722839377774;
        Sun, 04 Aug 2024 23:29:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e11c8eb9sm151534945e9.16.2024.08.04.23.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 23:29:37 -0700 (PDT)
Date: Mon, 5 Aug 2024 02:29:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
Message-ID: <20240805015308-mutt-send-email-mst@kernel.org>
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
 <20240802090822-mutt-send-email-mst@kernel.org>
 <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>

On Mon, Aug 05, 2024 at 11:26:56AM +0800, Jason Wang wrote:
> On Fri, Aug 2, 2024 at 9:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> > > On Thu, Aug 1, 2024 at 9:56 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > >
> > > > Michael has effectively reduced the number of spurious interrupts in
> > > > commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
> > > > irq callbacks before cleaning old buffers.
> > > >
> > > > But it is still possible that the irq is killed by mistake:
> > > >
> > > >   When a delayed tx interrupt arrives, old buffers has been cleaned in
> > > >   other paths (start_xmit and virtnet_poll_cleantx), then the interrupt is
> > > >   mistakenly identified as a spurious interrupt in vring_interrupt.
> > > >
> > > >   We should refrain from labeling it as a spurious interrupt; otherwise,
> > > >   note_interrupt may inadvertently kill the legitimate irq.
> > >
> > > I think the evil came from where we do free_old_xmit() in
> > > start_xmit(). I know it is for performance, but we may need to make
> > > the code work correctly instead of adding endless hacks. Personally, I
> > > think the virtio-net TX path is over-complicated. We probably pay too
> > > much (e.g there's netif_tx_lock in TX NAPI path) to try to "optimize"
> > > the performance.
> > >
> > > How about just don't do free_old_xmit and do that solely in the TX NAPI?
> >
> > Not getting interrupts is always better than getting interrupts.
> 
> Not sure. For example letting 1 cpu to do the transmission without the
> dealing of xmit skbs should give us better performance.

Hmm. It's a subtle thing. I suspect until certain limit
(e.g. ping pong test) free_old_xmit will win anyway.

> > This is not new code, there are no plans to erase it all and start
> > anew "to make it work correctly" - it's widely deployed,
> > you will cause performance regressions and they are hard
> > to debug.
> 
> I actually meant the TX NAPI mode, we tried to hold the TX lock in the
> TX NAPI, which turns out to slow down both the transmission and the
> NAPI itself.
> 
> Thanks

We do need to synchronize anyway though, virtio expects drivers to do
their own serialization of vq operations. You could try to instead move
skbs to some kind of array under the tx lock, then free them all up
later after unlocking tx.

Can be helpful for batching as well?


I also always wondered whether it is an issue that free_old_xmit
just polls vq until it is empty, without a limit.
napi is supposed to poll until a limit is reached.
I guess not many people have very deep vqs.

-- 
MST


