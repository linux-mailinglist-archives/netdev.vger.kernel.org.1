Return-Path: <netdev+bounces-153140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E59F6FBE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 22:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29E71886D82
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7441FC10E;
	Wed, 18 Dec 2024 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOUlter2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27371F63D5
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558905; cv=none; b=a1IfRRugLlMUuyqwW6VI19IKbd9b4fzkUsKM7v0okfY93yTuMwTdWMZqa/rqiXcCJ0KDCuY5ZHuaUWvqKg8NON+CEfWzi9fU5w+lg7FAS8auIj5a4s5Hzwuw6bdk1c/O4s7O7Toyt4O63q37JVDQCvND9C/gWg2zNYot8MYlYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558905; c=relaxed/simple;
	bh=33GsVGcs8tFusQKx8Tz4AK2j9DQ2B1yrNdYgSQOiOZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VatNk9lfk/8HVWb35mYPVuf2xmDoQN3ty+rxvRsBTijxo281Q82mdg6KXDNPi5Ha8zOvLvNpQ32xqGYYW3iIm4UXzoSo8wVUXWpt2/po88OGqPKN84l5SYjttW3UeQGtSAvVVgrLVYpJvXOsj+1Q1JLNo1a9I4NdK4jVfn2IIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOUlter2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso2418a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734558902; x=1735163702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBXbazmsr/FXkj6C6IAXXrrqrhyeVUZG8tR4z3dZLAc=;
        b=MOUlter2BOR9mhJDiqaY2gkkPntyT+JM/cjXb2jLnVJkhGb6l/K6IBBWZl3iu1mTI1
         pwwVbxe6Y9ypXcCJXYFWTLD9bsLapZJdqZyTqEZQIb0yLME7fAqPnzYL2emnQn7kLozF
         DtTWuzF2+av/Geg4mOQzg7y0eukZ9kKq7j7WjR8yxrlg8ocHZeq66fPk2BT/pNaAPMOZ
         UiCh7axW+V19YPr0RASRnl91ZQ8YCfgWoz4Fx/McTDcT6RGooeyo7bHAEEuNNJETtuj9
         /FDnkEE6xpZ9iu5jD//lo66ut6eQs5/EXudSk5MTam0GUz7tGC94XSvzJzHTcu+8WbxZ
         RfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734558902; x=1735163702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBXbazmsr/FXkj6C6IAXXrrqrhyeVUZG8tR4z3dZLAc=;
        b=B6uMjBU+NO+r+0iyYM4OhsWjLPvR7qRoGekVy3Jhy8U4HUVj47yJOeZ7cJMXVcT9Pm
         8tfwmXYP8zJnFPXZN7lWX8WWTR6IZnnN22K/kbxjN4Qcw9p+KXSgbpeVJm3WAcK4w7Bc
         ejJYRJ/3YwXpO8eot0tg1uLsthO1QIwnQuj38Axtqf/IOJp6UvlUKhTPRsVKt4Gyx0HV
         eyM86zSaLfb2FS9QKnw8fI08iMX1ALrdBOSqoPWTgp1ue7z1smq2EBeOscOFUPHF12R8
         MMbxdn4H735R021dpVCc1gOO5lbTAMf9ig0vl9XQH9oOvU/rp3TlK6J6qy56dfny6DKJ
         lGmg==
X-Forwarded-Encrypted: i=1; AJvYcCVudeNVUCp7Vr3Fu9liBHlPQUmP19tgqnFRUEQ/80wqsiM+ZdHuHtefwVfRWhurRM2bTceJbJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhrGBuY4HzQjGCOJb0ahfRnKQsxufx+omoVevDM84vwVAvBA+5
	3025kLhJvVBotfs96bxHyjAihTcuxzAGP5e67phbowV8/25BF7ja4V3Jmv0bia1e3e2EJ31cB9D
	TvZQOaxeiyJHjCOEz2eo7Dre+k+3YG3275djC
X-Gm-Gg: ASbGncvtTNWjc1QNmaYrXU2PWdcoRRJ+pcFKJCPtLrCh6kQr/2v/WstnOxZWjLy3iOI
	ciz9GR0FakkBo//nTXqLmsA9ask90z1IxZwE=
X-Google-Smtp-Source: AGHT+IGYctwYI0rixsW0LJ5aka+BkAzP9Yu6RyaRtj+kZ8DPSxVmCBRyP1j0QZHf294KWaocBgBfSwT0PZ+xNLXdN3s=
X-Received: by 2002:a05:6402:649:b0:5d4:428e:e99f with SMTP id
 4fb4d7f45d1cf-5d805cac45amr1478a12.3.1734558901965; Wed, 18 Dec 2024 13:55:01
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217224717.1711626-1-zhuyifei@google.com> <3280aeeb-bddc-ee1f-b33b-eab95a91084d@gmail.com>
In-Reply-To: <3280aeeb-bddc-ee1f-b33b-eab95a91084d@gmail.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Wed, 18 Dec 2024 13:54:50 -0800
Message-ID: <CAA-VZP=NxTVR4wyTzRtm4tX7v_5RrFLvN4k5kX8oDEMR=SsioA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] sfc: Use netdev refcount tracking in struct efx_async_filter_insertion
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Martin Habets <habetsm.xilinx@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-net-drivers@amd.com, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:09=E2=80=AFAM Edward Cree <ecree.xilinx@gmail.com=
> wrote:
>
> On 17/12/2024 22:47, YiFei Zhu wrote:
> > I was debugging some netdev refcount issues in OpenOnload, and one
> > of the places I was looking at was in the sfc driver. Only
> > struct efx_async_filter_insertion was not using netdev refcount tracker=
,
> > so add it here. GFP_ATOMIC because this code path is called by
> > ndo_rx_flow_steer which holds RCU.
> >
> > This patch should be a no-op if !CONFIG_NET_DEV_REFCNT_TRACKER
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > ---
> > v1 -> v2:
> > - Documented the added field of @net_dev_tracker in the struct
>
> Please do not post new versions of a patch within 24 hours, see
>  https://docs.kernel.org/process/maintainer-netdev.html#resending-after-r=
eview

My apologies. I noticed the missing docstring while backporting the
refcount tracking in tc_encap_actions.c to OpenOnload, so I thought
I'd send a revision to avoid inconsistencies, and to avoid wasting
reviewer time to point out something that I've already noticed. Was
not aware of the 24h rule, sorry.

> > @@ -989,7 +989,7 @@ int efx_filter_rfs(struct net_device *net_dev, cons=
t struct sk_buff *skb,
> >       }
> >
> >       /* Queue the request */
> > -     dev_hold(req->net_dev =3D net_dev);
> > +     netdev_hold(req->net_dev =3D net_dev, &req->net_dev_tracker, GFP_=
ATOMIC);
>
> This line becomes sufficiently complex that the assignment to
>  req->net_dev should be separated out into its own statement.
> (And the same thing in the siena equivalent.)

Will fix it in v3.

> Other than that the direction of this patch looks okay.  Have you
>  tested it with the kconfig enabled?

Only a compile test. It was a blanket change from dev_hold ->
netdev_hold in OpenOnload to wherever it made obvious sense. It was
only after, that I found that it was the driver for solarflare NIC and
was told it was a copy of the in-kernel driver. Since I don't have a
solarflare NIC on hand, the code path is not exercised.

YiFei Zhu

