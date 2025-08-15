Return-Path: <netdev+bounces-213913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1EAB27497
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA231889AA0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181B519D087;
	Fri, 15 Aug 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOsbJrBV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690ED189F43
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220087; cv=none; b=lTSzgk1kRIFiD/Mih36cAtH913UVhk6J0TWFgn/IUPnpunoluHfaZzhJ2FKy056xgwOUdekUb+qxItmngKA+bSKVLeCgHbTYwi2pYtDKvOaZt7l8oUKcqrEiZlgH7vfF9L/FTNdw4FdJd1peYYA6wvsnthiG+B9UK2sR9rAlAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220087; c=relaxed/simple;
	bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENs/rHts0TFuzew3gg3P8LjkI5fUOZ2k4EvJ4i0V8gmjJDLts3sYsE+h2055Tb65vetjMncQGTjlm9tNljEAFllHtPFEpwATl6i+UPs0J3nWWXZKSDXbHwpK+HHdEQ0IqE/y1yw7159ZQumhnbKP4Vbqy0azIovF5fiiwFcT+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOsbJrBV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755220084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
	b=EOsbJrBVoGtAhQBN82HrVak/wYS6z4ZrSJ/0B9JXr+ZMIruVO9q//SipAtYqqa4ictLXI/
	zi677iD8D10SUvDJosfmEWMeE61Q6i6Mj/D14syuWx93qr2HpmPoRwol+nXYxFe5CcIqdd
	DVw3f6ly75GDtyLBms08s3zBosh0fds=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-hoki_hEeN7irMkvMXl80sA-1; Thu, 14 Aug 2025 21:08:03 -0400
X-MC-Unique: hoki_hEeN7irMkvMXl80sA-1
X-Mimecast-MFC-AGG-ID: hoki_hEeN7irMkvMXl80sA_1755220082
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323266b700cso2935468a91.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 18:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220079; x=1755824879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
        b=dQDl/00+Ec3/yWrC1Z3YdHQQgJW70qHSgisKrk322Al98BHWmfS6L2VUuMPK7rc0Eo
         PxTTARt5jziAFFkTFQHeIBjSxEQwJi3kHlDvhoPARnPD5E1d/kNqBy6HGzHNeyJ85ZRo
         +1J6SDc624dlFTc8+Rc/G/37WAhrnu5jG+Brqr0kfvJdbFCfcsXcW44LxeC/SysAE1tg
         NK0ex4IhHuBgMa+lNIsm+qAWzuCUNXyNghMMS82xoj7el0ggnszpZLdAEd/hQyhiCIXE
         ETbpo/g+p89BIYAquEVVkCGRoxI4U51oNefGhVtdQBE+epMSvbRTGjW63MYQeAdj+5Ks
         zj8w==
X-Forwarded-Encrypted: i=1; AJvYcCXObMs/En8g1pHGflZunlillpS0gpEEUq8lM++kschGQKkaRO6QVHc1k1zntk2W7OiAWj/1GBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYLIpw/KjBMb9+xnrR2cViaigde8lTorasCNvRnkDQ+3NkYHL
	o9qNqzgkYF2ourAPFXQ6UEojA8+Q6ZWEkArntlyKfU6y9mGrBjEosNsJcQt5NaLhaJkfnun0B57
	quYhXgsXKyhfyl4kkyJGHPM52LawnagP4LQubdfU6Yv85LeSm0ULnP3RaUEFJ144CYiJKxd7MZL
	R2EWYCk8H09/WqYKCJxiAopjbMJxIx3Luf
X-Gm-Gg: ASbGncuiDvQdorSqSbLjXrKLpmlSCKzMiG4m35UNtaFk+YM+NG3aJQ4+Dsnc838dK0L
	DJv3o9Q5x4DwTbUuXhZ6eAlRcQkrWMas64keuLyI4PAppMaWfC7y1EPVarK5aRS04zckITFt/w1
	sywyO8WJbvLqf4N3I+yzQasg==
X-Received: by 2002:a17:90b:3c10:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-32341e213b1mr438754a91.15.1755220078810;
        Thu, 14 Aug 2025 18:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFftEd7ZpwZlhPeUYgWI8U5PeEZpBHT/0Rw+KUFajkX3bgGwgq+MWu5X1o7e1+IYTjAp76m3/T46kYaLuJcso=
X-Received: by 2002:a17:90b:3c10:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-32341e213b1mr438714a91.15.1755220078289; Thu, 14 Aug 2025
 18:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3@epcas5p1.samsung.com>
 <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com> <20250814054333.1313117-1-junnan01.wu@samsung.com>
In-Reply-To: <20250814054333.1313117-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 09:07:46 +0800
X-Gm-Features: Ac12FXyMnzmmCYkHkvMnS0G6q-NfxdLkSUe4o0bafIE3pCtKzUtrQtDJ_G_v9cU
Message-ID: <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, kuba@kernel.org, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Junnan Wu <junnan01.wu@samsung.com>=
 wrote:
>
> On Thu, 14 Aug 2025 12:01:18 +0800 Jason Wang wrote:
> > On Thu, Aug 14, 2025 at 10:36=E2=80=AFAM Junnan Wu <junnan01.wu@samsung=
.com> wrote:
> > >
> > > On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > > > Sounds like a fix people may want to backport. Could you repost wit=
h
> > > > an appropriate Fixes tag added, pointing to the earliest commit whe=
re
> > > > the problem can be observed?
> > >
> > > This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414=
633"
> > > After this patch, during `virtnet_poll`, function `virtnet_poll_clean=
tx`
> > > will be invoked, which will wakeup tx queue and clear queue state.
> > > If you agree with it, I will repost with this Fixes tag later.
> > >
> > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> >
> > Could you please explain why it is specific to RX NAPI but not TX?
> >
> > Thanks
>
> This issue appears in suspend flow, if a TCP connection in host VM is sti=
ll
> sending packet before driver suspend is completed, it will tigger RX napi=
 schedule,
> Finally "use after free" happens when tcp ack timer is up.
>
> And in suspend flow, the action to send packet is already stopped in gues=
t VM,
> therefore TX napi will not be scheduled.

I basically mean who guarantees the TX NAPI is not scheduled?

Thanks

>


