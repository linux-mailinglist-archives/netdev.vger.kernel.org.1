Return-Path: <netdev+bounces-234203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C1C1DB46
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AAAD34A35B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C3331AF1E;
	Wed, 29 Oct 2025 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwFEiEah"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CA31A7F3
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781471; cv=none; b=vGExYElQ41qWO7PTxjfHSOUXC4F91pTirD49/4X5IYjGnXswjxFOeBfn+LfAUmtRZGjyS9BZaDifNDBbQf7ygX7FwWCiVTpZ7RkrinQXqDMLE1U1ADZbZAb328DrHVtlvA2G5ZgTHpyw/t7wP/eydHZDgfwuQEJHyZyyv/MeBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781471; c=relaxed/simple;
	bh=C14yLC6DsL60xkjRCmGeFPk3Gn5KURyJgVCcNTU66fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME/hd2qWfjm7k3fnj0gn5dwLhWHvaFgu7ombi7sObhZCWFFeyMyR/j+4w8m7zk3QyYl71wjGqddAZcmJHeFL3G4XlHK42IXV14UbHkRnwxZJwFqiw4majf0sxxCiGplfE0xF+FcRKqp2YeHRPvLyJa/dlr+G/5InmlBU6BbLx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwFEiEah; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-945a5731dd3so18022439f.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761781469; x=1762386269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C14yLC6DsL60xkjRCmGeFPk3Gn5KURyJgVCcNTU66fU=;
        b=GwFEiEah8BDlzxvMA50AAe7BwLeYSjyJI4GAA+G0PQJuwuiHhpnHsI5xO2Exe5dB54
         tmiVrGG5vw1pjUhmHDYcp93+qI2dTXm1gp/8256+gIzvC7G0pGOKoSh52nTNnRuZICYn
         B/80q2vJLpNj3v/lCxTu0lXlnAqk3p1NH2B1klbUjD3PbYItpIP98LT2xMHSmc5Mvf5U
         U+YyWGLYKgXg3rpqisy9ozRBzS2XkhuGesMa4aJVjZh4s2IBGscb+ntOzAspDIheB/pt
         67tgoXN7eSi8eBW5dzUv8kDuB4aop/Myc4r0bggYSEEBJheG5TtFMbZlwoLxyXxbwoJo
         o+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761781469; x=1762386269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C14yLC6DsL60xkjRCmGeFPk3Gn5KURyJgVCcNTU66fU=;
        b=Gpv9zBaeZcMEoCBstGEW7f2vITs5tMVs8C3LnGIvt9vdln6zM/aOZ8p/x0U1Jp0iTP
         +3Fc/mhzKZ8Ns0Wsisl/0VvkarTf7tvAoZL3jtm0RsCDwJJa4+uqq2YCAg0fSgCoUfet
         47wOh66Yfbv7fbX5N4B4sTdlwW4K9uF4UeKtV/tU9N8bRXrxPmYq8QNdxD77uVvZCyOc
         HTLsCXslB5GIeXyjuccLqzsrQnRoiF2e863Ua6lsulid2pM1DLwqsBSW/K3KUaiFr0JW
         vQvmyRTyk54Nc+YUbnLeT1+57mc1OLjd1ARR+t1bqhFGOmvcs9m+G/mck6geZg7dWRdD
         jaZw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Gf5shkhvvYnME0YaHoBDKcvsqeIc80/hGXe8snt4RwYMZal8xAEwCPkfhfqHsOXfSWubkIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8mQ7XSc9rP30cugMfpvmMOEK1n54rvmPD8J/3A0o8w1TJeGv
	a57Up0xVrGCo2dOBXdFfeCfSWvecbtHjyB1DzMB0ZPXwtpP4CvjTQwC71F0EVmKbMY+9dW2dvdV
	wZ2kG+wwsy+j/ZDgUI+xrcR5RBGJxCbY=
X-Gm-Gg: ASbGncsdzZ3qyhSLIFdMunW+dZZMRt1MTc2y5hqFzt4mahkOs0lZZZ1oUojBPQ20Dah
	sPC4d+HXjqSJdbOgzQ4bWT/oV/NCQ56aoX0gLJH2Qvg9CfQzVUNsRE0Hzh+w/6xgxn/AxbZzSTV
	bq53rx4o7MndmwZRFx58RReOcyZLA/tktJD+nunnkbcxs96XOCPwxewfBy+Jp8CLWABPXSFk3qX
	uuoZzlwIsu5IonU0URKw6CYz002ItcOkSMUMf95twstsK8AjTWVnjb4/i4=
X-Google-Smtp-Source: AGHT+IF051QtcmqoluW3Zbt6+K5qGMnPgAEPPNdIeK5IV4SWt6/GI3ng/eThxjoKwT+TXLjEFXmmdl07QJrrQEd1DKg=
X-Received: by 2002:a05:6e02:1a44:b0:42f:94f5:4662 with SMTP id
 e9e14a558f8ab-432f9036ee7mr65960145ab.18.1761781469434; Wed, 29 Oct 2025
 16:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
 <20251025065310.5676-2-kerneljasonxing@gmail.com> <aQI3TfFZPPaWQOS/@boxer>
In-Reply-To: <aQI3TfFZPPaWQOS/@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 Oct 2025 07:43:53 +0800
X-Gm-Features: AWmQ_bnb6zOVaQ7G9s4oKpQ3eRGnQtV4E_7f8NgI0IC-42GOSl7f17rWn3b6mng
Message-ID: <CAL+tcoBwKd9v6A8j_6wgN7y8Y-_4N6VM-Pdnv4x49eUx5RcGag@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool is
 not shared
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:48=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Oct 25, 2025 at 02:53:09PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The commit f09ced4053bc ("xsk: Fix race in SKB mode transmit with
> > shared cq") uses a heavy lock (spin_lock_irqsave) for the shared
> > pool scenario which is that multiple sockets share the same pool.
> >
> > It does harm to the case where the pool is only owned by one xsk.
> > The patch distinguishes those two cases through checking if the xsk
> > list only has one xsk. If so, that means the pool is exclusive and
> > we don't need to hold the lock and disable IRQ at all. The benefit
> > of this is to avoid those two operations being executed extremely
> > frequently.
>
> Even with a single CQ producer we need to have related code within
> critical section. One core can be in process context via sendmsg() and
> for some reason xmit failed and driver consumed skb (destructor called).
>
> Other core can be at same time calling the destructor on different skb
> that has been successfully xmitted, doing the Tx completion via driver's
> NAPI. This means that without locking the SPSC concept would be violated.
>
> So I'm afraid I have to nack this.

But that will not happen around cq->cached_prod. All the possible
places where cached_prod is modified are in the process context. I've
already pointed out the different subtle cases in patch [2/2].

SPSC is all about the global state of producer and consumer that can
affect both layers instead of local or cached ones. So that's why we
can apply a lockless policy in this patch when the pool is exclusive
and why we can use a smaller lock as patch [2/2] shows.

As to how to prevent the case like Jakub mentioned, so far I cannot
find a good solution unless introducing a new option that limits one
xsk binding to only one unique pool. But probably it's not worth it.
It's the reason why I will scrap this patch in V2.

Thanks,
Jason

