Return-Path: <netdev+bounces-93824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F88BD4D9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B972836DD
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7534015884B;
	Mon,  6 May 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xWvhwPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB3156678
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021243; cv=none; b=gLoWZuq4htCiQyaoxsbGJbd5gGf81NsRNxc46x27Vvq7xq2UtUTOvJFcfmuYNIUk2K9yGAIWt4phXcxcJhMGsyRGOlLs2AZGVDuWfFEJ7B3LZPKBr/AfaNstyO6DP1OOsXU5o8+6BIsvxSdGmVAwud9ccXiCUuu8mxkJ+4sovqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021243; c=relaxed/simple;
	bh=SHC4arp51s53uy7cQAV37tTGClBxFzKwBKbWvAlgQis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3I0fkK4b1v9CUsxoKzk5Kw/PrMqHK5sxqixhDYxhg0ZLGnr0ZRe53Zyu6PAuu8F5fB35h7B68al9xrHS0+Y/BylQIphU28HVi9zkwJwVGDwPn5OzAxjJ6wXRqfNOL1HIeBhPkXvYI9idrjRmS+x9kNULWfvHvN/VYwpBStY0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xWvhwPO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a387fbc9so549869866b.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715021240; x=1715626040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgLpplDVCN6W/x3MW+l9bmlAJmRDG6fAhG2BiX4Yj4I=;
        b=3xWvhwPOEHQnrqvbkL9Sc0xbFtg+fg/QkgaS0G7HtClcwUBOUPzL2NrVgqys32uHX1
         l+dt9NsCWFmQzKDlcJdQ1aTmAateIgCKL7mpEZN3n6JkFn7xEqBaUslGHE6ZELB1LNqY
         6CsoxDNgJEgE2sL8/nPC8dFIj9DIFQ1ozes8RraXxBojo2LpViEXol91HjHekLmXALj4
         6TgjoGHPqiZhq/+MAYTGzz52+RobfKQVLeoAcJL1q8Dy+VeEgH4Rt3C7SidjNqHwAhBE
         XLb9VoxyZuvUs2q0UiBfRCt3Mo1RP6razs6MKjZy/59YkPrzvdF/hxeeM4C4LUDT6t1Q
         zDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021240; x=1715626040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgLpplDVCN6W/x3MW+l9bmlAJmRDG6fAhG2BiX4Yj4I=;
        b=cc+IPSMxi2rFr7ks6Y65BttQfp3fhGis8tCdLHxUKxQkrtS542bYm6bJJMkhm2+ox1
         1B04mU24hGnjo16DuZKf/9dgyE6v7Q/g9cg67iNP098wqIRkMuH5S7KX3R/w9xPcTHEN
         CbzBecxf2IQhQvoWYqfZ1HLtM4yvl27iqz+bUwHsLbAdxx+Xr0W8Ubj/1lKGv2LaqACa
         YNbVOx2+lrBWDGz8YmECo+JDEV5DDCYtjF9Qwbd8UsQLQS9nYXZCDJ6qw0DS8LDrPgKi
         ogM7iirPlzhBf98BMoDGFZQmDDBpl7r+N3pHudrWmamF+ngXQh7Ki21w+SbZGqhl7cBP
         3Ebw==
X-Forwarded-Encrypted: i=1; AJvYcCUfXZU2UECnSzHvVrbo/8dzeVnkK1wV3S33KtrsdEncwlXcgOUF402jDGzk1GjvC/sundVzwos+WnQEPNLKC8KH1L4Vu7J7
X-Gm-Message-State: AOJu0Yx8Pfe9mr8i9CKT6yWdSjXvxCr7GYrQeYFXL3kjv3FrLPaJsj5Q
	Bg47nB6+zqedZ0YK8DIADwINXIrfPAn31gCatIi3monD5mjPG4yeONBqmiG5zEPWPhC6KUv0wgy
	VMmuARw2zikIBGjDoVE80CtK2w4Z5Q7pD3Zcd
X-Google-Smtp-Source: AGHT+IGr6rpITQIDo9QbG5Y3R4uWDW3xI4XFPH9yzpQ7W0CyOtjiYUYkdHcbJek41mpnqAiqNoWzexesWoWYkV+9HUQ=
X-Received: by 2002:a17:907:7e8b:b0:a59:bfab:b254 with SMTP id
 qb11-20020a1709077e8b00b00a59bfabb254mr4104551ejc.64.1715021239785; Mon, 06
 May 2024 11:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com> <20240501232549.1327174-11-shailend@google.com>
 <43d7196e-e2f5-4568-b88b-c66e51218b2b@davidwei.uk>
In-Reply-To: <43d7196e-e2f5-4568-b88b-c66e51218b2b@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 May 2024 11:47:05 -0700
Message-ID: <CAHS8izOYj-_KKgpPm7Tn3SkcqAjkU1b4h9nkRpPj+wMyQ23JqA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/10] gve: Implement queue api
To: David Wei <dw@davidwei.uk>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, hramamurthy@google.com, jeroendb@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pkaligineedi@google.com, 
	rushilg@google.com, willemb@google.com, ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 11:09=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-05-01 16:25, Shailend Chand wrote:
> > The new netdev queue api is implemented for gve.
> >
> > Tested-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by:  Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Signed-off-by: Shailend Chand <shailend@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h        |   6 +
> >  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
> >  drivers/net/ethernet/google/gve/gve_main.c   | 177 +++++++++++++++++--
> >  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
> >  5 files changed, 189 insertions(+), 24 deletions(-)
> >
>
> [...]
>
> > +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops =3D {
> > +     .ndo_queue_mem_size     =3D       sizeof(struct gve_rx_ring),
> > +     .ndo_queue_mem_alloc    =3D       gve_rx_queue_mem_alloc,
> > +     .ndo_queue_mem_free     =3D       gve_rx_queue_mem_free,
> > +     .ndo_queue_start        =3D       gve_rx_queue_start,
> > +     .ndo_queue_stop         =3D       gve_rx_queue_stop,
> > +};
>
> Shailend, Mina, do you have code that calls the ndos somewhere?

I plan to rebase the devmem TCP series on top of these ndos and submit
that, likely sometime this week. The ndos should be used from an
updated version of [RFC,net-next,v8,04/14] netdev: support binding
dma-buf to netdevice

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D840819&state=
=3D*


--=20
Thanks,
Mina

