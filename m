Return-Path: <netdev+bounces-177091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE3A6DD2C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C2169222
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFA25C6FE;
	Mon, 24 Mar 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZXtf9nU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948C10F1
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827153; cv=none; b=AQJLJpT1fJGvDgMvhG0E4AdEm07U7ddzM/j5tmTCgF5iOHEAvZeSrbU2q4+bTiwWsY3XBYIQj90kDPPFgxFvTOwKeIkRbxBwQ9KvnK0Ax3n6bmv+XJsqzMXeUXSyFfHrZqtEgLsEuu0lfH/7f4gvDq/zIbfDA/sl9oL7Isb1geY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827153; c=relaxed/simple;
	bh=nTliLNqMZBbrK6UBfCB5qUOnQ701+cm9BjDjoUn7wrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/tOzoZpBICtqR/F0SkkdvxJylK7vOcqwgdBCwVAxbHyr/xSd681p0YL1wNDL6NqB/p9wUXOeuTtUA4mrjUKWvYJsCDHEby7zKTirxsWGbXC60VnaU+yzW3lnAoj1XXMPRwiwQxuvUeFeaMHS5rzCHE0S4aBSI+c85gmb4yWmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZXtf9nU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742827150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xq0MDmj/bWYFPGaNLprQBYbBGHp/cGo+8wXXgvTKy6U=;
	b=hZXtf9nUckxN+HTJb9rCDDldJI6OD3T8wHRWe6eTB/9xPKcoUK8YN3O9B7Sk3slPLqCfeh
	i2erVWqVvf+jQ5v0aQtAqkwtEjWKIAhwiiGiKVZt4UfFc3ZYQy9A/fh7QK6mHf6GB6l8vw
	OpirbcKzan8HDcBSR4bljsGU55+f/8U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-A04wKZIWN5ijSImvFpG6cQ-1; Mon, 24 Mar 2025 10:39:09 -0400
X-MC-Unique: A04wKZIWN5ijSImvFpG6cQ-1
X-Mimecast-MFC-AGG-ID: A04wKZIWN5ijSImvFpG6cQ_1742827148
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e5dbd04225so3248466a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 07:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827148; x=1743431948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq0MDmj/bWYFPGaNLprQBYbBGHp/cGo+8wXXgvTKy6U=;
        b=cZByZiqGQ22yE2g9O+F6UVM6SR4moAsIcMdUhoyNHcWDQwrpVvittS463Hw1t14zSQ
         D1q+ESJDiWyHoSGoaT7XDbhwmScTBOAnEUMlaKxPZdZ6ycmfNbtW+6NG+qkKkrx1YgAD
         iUKIWOg5tNov+PbftL7qLnais5TK2t1EABWIHjLoRQgnjnaat0P/nfxv7VOu7HueY04G
         7D3EHwDtcQZfa8Y/+2MT/mvXYCPIiS2FUQXeHNsNHKUldu26W74rNrxyRGvVuw4WZ/HE
         kqxiFP/tSwOwTkyPVtmeCIPyPfckfvVYHskxiUsYbPhBAI/2ka/friZa2XkM6wlftgGV
         d4vg==
X-Forwarded-Encrypted: i=1; AJvYcCUcFfS3D4tG13j3lsAGE3ThAZI5jvFEo28AuSC3bdgQK2G3BoZzztQfj0dGDRfAWpd80K2kLqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhzaUgfprGziLxQI8kONQN/pD23x1tzfy+vNc+gbHdn+tRg9A
	Ejr4xg9d+0F+7yRyHf07iOgJM3nhYuZO2DehYjnTvzWvhH73VjoHydwd60pacgljiYsqJ/NWmdP
	Z+BHOmVbPlex45Dng2IdY/BZSlzYqy+8W9Ek7Gj0s0v1eo39BFUmvLqOfVPriV8ugbistyCcX7E
	1Z6L049L8qo/eHY0bI72GnRVZmBwRQ
X-Gm-Gg: ASbGncubVGhODsGcoichakmfAHfrVHskIJp68LEzlybrFx/vfusFNT6M8nNW4KNQbCQ
	xDGZppkWb/RRS7PWHmTnvJ69pELJg0Jtjv9TxfZP1WLYfuKwxATzLloRQr+4z20iwdbxRsFOn/g
	==
X-Received: by 2002:a05:6402:909:b0:5e6:e68c:b6e5 with SMTP id 4fb4d7f45d1cf-5ebcd51c105mr10515839a12.32.1742827147996;
        Mon, 24 Mar 2025 07:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9DKx6B3C9S8Xr5iUK6i6jAmqu93CsYREN/zAlEYF/Sj4+lRsLtO/S8UYF8aFRkQ36lLETXWAjFegsoIHGZa8=
X-Received: by 2002:a05:6402:909:b0:5e6:e68c:b6e5 with SMTP id
 4fb4d7f45d1cf-5ebcd51c105mr10515798a12.32.1742827147499; Mon, 24 Mar 2025
 07:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com> <20250321142648-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250321142648-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Mar 2025 22:38:30 +0800
X-Gm-Features: AQ5f1JrTYgZzgkgv85az98_SpxBT46ja6zriWYT-n8Fbp7M8MZtf2vAwTdHHOlk
Message-ID: <CAPpAL=w1BRdeEKnPa2Gxgq7F_xcyieOSms1tFXETUpzE3An4sg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches v2 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Mar 22, 2025 at 2:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 21, 2025 at 03:48:31PM +0900, Akihiko Odaki wrote:
> > Jason Wang recently proposed an improvement to struct
> > virtio_net_rss_config:
> > https://lore.kernel.org/r/CACGkMEud0Ki8p=3Dz299Q7b4qEDONpYDzbVqhHxCNVk_=
vo-KdP9A@mail.gmail.com
> >
> > This patch series implements it and also fixes a few minor bugs I found
> > when writing patches.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> > ---
> > Changes in v2:
> > - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> > - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336d=
dd@daynix.com
> >
> > ---
> > Akihiko Odaki (4):
> >       virtio_net: Split struct virtio_net_rss_config
> >       virtio_net: Fix endian with virtio_net_ctrl_rss
> >       virtio_net: Use new RSS config structs
> >       virtio_net: Allocate rss_hdr with devres
> >
> >  drivers/net/virtio_net.c        | 119 +++++++++++++++-----------------=
--------
> >  include/uapi/linux/virtio_net.h |  13 +++++
> >  2 files changed, 56 insertions(+), 76 deletions(-)
> > ---
> > base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> > change-id: 20250318-virtio-6559d69187db
> >
> > Best regards,
> > --
> > Akihiko Odaki <akihiko.odaki@daynix.com>
>


