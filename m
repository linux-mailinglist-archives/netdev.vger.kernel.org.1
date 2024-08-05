Return-Path: <netdev+bounces-115616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B129473EE
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899571C20B3A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 03:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C57143C4B;
	Mon,  5 Aug 2024 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuJ/wcd/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9413D524
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828434; cv=none; b=OHXbhyFSwfL7faumJU3T0dEkt+OfnsJ4uPP9LEDigjxmbKQLtCvmTkk5e95HU02VFgJIKImyGgePEuDEI6/W5L4+OOmrq1mUc99SeDC4xW2n6jt2vlau9KYDQq2jDDZBnksZ6HrQiKK8W7uUDrHSefpYAnG2RiDZeKTzwx7swLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828434; c=relaxed/simple;
	bh=90c+ZQB86O9U7nLZt85X6YxyXXWvWON+rsMFn7ETuUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOvkPM6dU8bRJMg+a7/QhpwGhs1L5BAlV2Nr79mpbac0CR2mSWLP5FFlTRjiia+u37nC8oJTLjz5WvLlf9Kf4r3zWMCjfLZWAfbUZIWKKt62WosdkVMzgb2B/7leigbLRVsDH/YBFkC/D9ddgCUfWuyegnxMFDq+T76Z/8U7Z6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuJ/wcd/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722828432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtHik+Vl0bOC1N6N8c3ZMa3D8RPocG0B3oRPUI134fU=;
	b=EuJ/wcd/3/AzBJEYSVhY3hApehi58Y3LCqUocui+k/sB2Ru7JY6z+3aMi+xXILRDUPWjnn
	1T3daN02rE25sWfXvvUxXFv43WkrcC1HR4y55EQjjJXVuZK/6CQQWcaM5hza1wrJHXSs+m
	3F/4OQRHc48KN4Y0dfx6/QrjRoSe4qE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272--iJ0EyA7O0ShMwulD_8VyQ-1; Sun, 04 Aug 2024 23:27:10 -0400
X-MC-Unique: -iJ0EyA7O0ShMwulD_8VyQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7104d2cac39so4434470b3a.1
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 20:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722828429; x=1723433229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtHik+Vl0bOC1N6N8c3ZMa3D8RPocG0B3oRPUI134fU=;
        b=sfymg/YAHmo2aKY6Dx6bQKDmYv6Fl5bEFHUXbTr19M8Pil8OUXprS8tafo5lCkvOst
         OE8H+UwK8hRIs9BvGcHLS8EQ8g5nPv+IRfofwjK7zFf/UQib57BOiV+iruHlShgB9bnb
         OUp6D9LNwq3tHuifWeOPHqAsYaUqTUWVEP8b7A8j98uNRLvkdze97gPkpn5hoVf180vX
         2vRp1eW/IBk87QavtsbAYEoBFbHJTjvy2ISK/V3YDKYBQO8vXp8Pu6alfpLZBVckY6JS
         FEW11HVaqECfeMaZt0yLH97laCA3gIOIDF/1+lzZeOIQ5R3GY7VgyGM1fmfnbMj1gLdo
         dpwg==
X-Forwarded-Encrypted: i=1; AJvYcCVrvA67uDZE8gSL+WPvhJp8kG3+9uJNUvOUXa0qIWCKs5Y9YS8I+ymF2XWWbmnk5omOOSIR7POzvgDvfq+Z44aTvZ4bMoZu
X-Gm-Message-State: AOJu0YxJOiAjj3+mHmqtjGf9dqxKPp0vipIC42YQIGEHhqeNqUp7Yd5p
	IlITb4kEOJBnl+TV2QMDkUn6i8T87pYX8Lt3gi5mF5BSPDVdOKGQyc5wrTpnBfrtPxkJgw2LI2t
	s7eWYM7nICFBZMv4/F7NC+xTQ2OerVhEOBbdxhCNcXZiLeO+JuYfryYhAL1r1qj5h4iqooh/sIM
	M6S4OZMwz8Gl3QEaMFa3UNd+9OTCsU
X-Received: by 2002:a05:6a20:3d93:b0:1c4:8876:299 with SMTP id adf61e73a8af0-1c699615756mr9843096637.46.1722828429496;
        Sun, 04 Aug 2024 20:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdee32I0F/lZQKgive/iLfpyom2uV29anWJkaLZ/wtYbMXFG4HhaaQWLAgjTmBdC27xh+jafSXk9WYMl/tbUo=
X-Received: by 2002:a05:6a20:3d93:b0:1c4:8876:299 with SMTP id
 adf61e73a8af0-1c699615756mr9843076637.46.1722828428903; Sun, 04 Aug 2024
 20:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com> <20240802090822-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240802090822-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 11:26:56 +0800
Message-ID: <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> > On Thu, Aug 1, 2024 at 9:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> > >
> > > Michael has effectively reduced the number of spurious interrupts in
> > > commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabl=
ing
> > > irq callbacks before cleaning old buffers.
> > >
> > > But it is still possible that the irq is killed by mistake:
> > >
> > >   When a delayed tx interrupt arrives, old buffers has been cleaned i=
n
> > >   other paths (start_xmit and virtnet_poll_cleantx), then the interru=
pt is
> > >   mistakenly identified as a spurious interrupt in vring_interrupt.
> > >
> > >   We should refrain from labeling it as a spurious interrupt; otherwi=
se,
> > >   note_interrupt may inadvertently kill the legitimate irq.
> >
> > I think the evil came from where we do free_old_xmit() in
> > start_xmit(). I know it is for performance, but we may need to make
> > the code work correctly instead of adding endless hacks. Personally, I
> > think the virtio-net TX path is over-complicated. We probably pay too
> > much (e.g there's netif_tx_lock in TX NAPI path) to try to "optimize"
> > the performance.
> >
> > How about just don't do free_old_xmit and do that solely in the TX NAPI=
?
>
> Not getting interrupts is always better than getting interrupts.

Not sure. For example letting 1 cpu to do the transmission without the
dealing of xmit skbs should give us better performance.

> This is not new code, there are no plans to erase it all and start
> anew "to make it work correctly" - it's widely deployed,
> you will cause performance regressions and they are hard
> to debug.

I actually meant the TX NAPI mode, we tried to hold the TX lock in the
TX NAPI, which turns out to slow down both the transmission and the
NAPI itself.

Thanks


