Return-Path: <netdev+bounces-237599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07AC4DA5C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73174FD0E0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353083587D8;
	Tue, 11 Nov 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR/eVtqh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DADF3563F5
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863381; cv=none; b=Fr77NU0/JRyz1najUzpLX15WR0vvRKsXzEjFtC3ulq7L2AqelTISZqFd3wUA4EO9rYHu+ycXch38HhN6wYOig+LJYbwvMDBUcKYwUmmUnig86N5S5puGHBKNi9JNgp+xkquQiKzpJ2aNUbIKT2lOeW9HCpMhR9Z1SpptBxVMrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863381; c=relaxed/simple;
	bh=gCy/PT3oEpB/8w65qcMHRVRDAL0Q0r246VdaGoPxiak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex2LV3ilmaYFwV+fY1snZNYddqs35yqkHHx4w3mScyttAls7G5OdGngJd1GU4COnpfyJVVadf1VW7vdrsYQpnH9kCarhN5HFqpZ0U9mMKfd0K+egvmf+BpzCWtK3HCU4b0Ga2LUG4XAC+9zDDnCulcn34SFdans+1Gyy4yxI8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR/eVtqh; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso25282345ab.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762863378; x=1763468178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCy/PT3oEpB/8w65qcMHRVRDAL0Q0r246VdaGoPxiak=;
        b=OR/eVtqh1kyzP+yRNDHFx48lAWYGQX2u5dwbHnI0DzNQhid8NgIDgMD3/EmNgiJhIT
         TngzXvWzEqu5afHtrgaSe1Q1jr3+Fs6lC5G/RW8twpXT4He7ZNr4xLgSu8B1RsK3Dpbz
         pLe0v6cNRbNQ3UyaN2qMM4hrRvZC5S6WVZZjjuQ7CiEs2mx3fzed8rk+4XRAsgO0nvIl
         68DBO60wH14AevxmD1jderFpuvHp3H7h+jUd7wOo4fXV86VFjPBOshlhKEQOlnhJGvWF
         CxRVeCeM5MbaeJAdAMrqNgTNZD76AsDmKEgURLXi7WmTTL3FkE1VYwvoTkFJEOj2ufZG
         YEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762863378; x=1763468178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCy/PT3oEpB/8w65qcMHRVRDAL0Q0r246VdaGoPxiak=;
        b=qp0ZLm529WiW0TkKOaSBBUn4ezn1ItXByru72djAzAA2w+oPHaPvppwp5f9Hf5MAXP
         n2Py/U2QVXY/P9d1149UNSz1Cht9n/Ftm+SZIwIfvKje9pEmauChp2Pz7THY0BMKF5b7
         4xm/fxunnTHfCkySxDSqkYG/YSuC9sUOUPeJKUIlGZ02bb1JzNh32NRSWfWfA2NjaecZ
         EOZJSYSTNkr3gH49DwSNcNE4aGOeDd0VxM167yROvqRGaXYgSxjTZZWMaQkMmwEAjaTC
         r3BGeft5SqnDdmbaudkDQJ79PWGpQ8THph2CTRw8YBlV23gskyJ/j7Q7uYFQcwDeD+C0
         6nkw==
X-Forwarded-Encrypted: i=1; AJvYcCW5pU/yLTIdrYtAJTLq0VvCIuJ4WZZNUN+B0lQT1or3CU8QKJ+4MnP663DPHZald32u+svhIh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBywzxThG+kwtbOXo0aRSwXBi5XnCuy5ekGKbNaWzdwxgfDSPO
	SKbbSnCO4JRoRlZgXFn9OrAgOHkQgA0p1tKNBN/u3airpecjjB2omdRr4gJ7LcUyoi/pMJ2BQ4X
	yCvN8V8Mnpaphhab+XrDEWWpsJmUTdog=
X-Gm-Gg: ASbGncuvl96MziUJArkhgrrrxtJwUBoM00vePQkh+iHGzk1fOyui4NHTFepaWZufgIO
	+wJkhJOQXwVbHpDe4Muh1h9oI4MoEMoODc1TCXBp5QGg+e4StQ5CkYwqGbU7yVQJno6EZlz1p7Y
	qv+rnAZJAQTqvFb7FFLMPryzG+rETQKQpxZtVvOgkLqLSoFa7YH35wpAb9eZvZGIT1khZ1KKtW9
	+37OjPT3WH20mj2VNfNWb50G7OIdeKRL0HWbQLxIXiHtLX/gN014x/SVIgCQkGTx8jvhzgYWtY=
X-Google-Smtp-Source: AGHT+IHTPSeoToJ4eeWW7GAWDuNwG68AfN1KUkHhJalas2qYm1Rvj+Rhgj3GtUyrc2vqBXhy4Kv+nTWUEvBZ7IGvRUU=
X-Received: by 2002:a05:6e02:3993:b0:433:4f43:2322 with SMTP id
 e9e14a558f8ab-43367dbff97mr181827735ab.4.1762863378547; Tue, 11 Nov 2025
 04:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031103328.95468-1-kerneljasonxing@gmail.com> <a84ce374-8693-4f53-876b-973c9ddff031@redhat.com>
In-Reply-To: <a84ce374-8693-4f53-876b-973c9ddff031@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Nov 2025 20:15:42 +0800
X-Gm-Features: AWmQ_bkAkeaxlG3cI_xvK0sikoijiPae2oXoxGgFsHv7FhC8YoFdyh_Nc_IMEWU
Message-ID: <CAL+tcoA-2E2XuGaaD-_2bpbVcUt-iPX-xoo1YUWhNjEo-ybBmw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] xsk: add indirect call for xsk_destruct_skb
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 5:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/31/25 11:33 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Since Eric proposed an idea about adding indirect call wrappers for
> > UDP and managed to see a huge improvement[1], the same situation can
> > also be applied in xsk scenario.
> >
> > This patch adds an indirect call for xsk and helps current copy mode
> > improve the performance by around 1% stably which was observed with
> > IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> > will be magnified. I applied this patch on top of batch xmit series[2],
> > and was able to see <5% improvement from our internal application
> > which is a little bit unstable though.
> >
> > Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> > be when the mitigation config is off.
> >
> > Be aware of the freeing path that can be very hot since the frequency
> > can reach around 2,000,000 times per second with the xdpsock test.
> >
> > [1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@g=
oogle.com/
> > [2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing=
@gmail.com/
> >
> > Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> My take here is that this should not impact too negatively the
> maintenance cost, and I agree that virtio_net is a legit/significant
> use-case.

Thanks for your understanding :) This case is one of my biggest
headaches because I have to use copy mode :(

Thanks,
Jason

