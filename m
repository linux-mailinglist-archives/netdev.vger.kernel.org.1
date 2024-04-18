Return-Path: <netdev+bounces-89127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5558A97FA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814511C20B96
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700C15D5D6;
	Thu, 18 Apr 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZhZG3Bu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422A15DBA0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437814; cv=none; b=EJnwdE1xhz+tMENsc4j/c3TXBjPq99yAeJNyr3Pc8Q5ELE0sPKb0LPSNGngazPsMxX32uRobSIwGV1HbWe6SmOoc1oVKWG480bV2a4f3sorF3YkPb+0uy/nUGUsU6y96YBphzRhyCR76JKYTcpAqUSIT7Br9aI/zfbDqMPQNe/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437814; c=relaxed/simple;
	bh=gy5rFnEcMbHaQs9f4pioxmeZhdMa3GQG7gHTFdUD7DU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WML6QVD6HPPk30UG1X6cx3LCGn2JuxAW3LjxVVJW+FVFUmTjJXhZS4/lvNpWxst/tEviMQeC4EfB0tnneQ+eHCLOD2mtiQv7qLI+ML/pE5tZl6/OiLExKnsrwWdAka+XpZjjLqOYTELoV9l84bct33BqaDQSclG9qUnKbdojqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZhZG3Bu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713437811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yfCPrnN+R2L+ohL34J4SDJTHiHwngI9ibvQYum6Tb84=;
	b=NZhZG3Bup6yULyftzDuUtPOW28/4DTGNDdM1jxdEiitUuOMVTwT+crBFAyJRNMFBi0d9Cj
	0YI1ieNXeNIdBC6sL4C3+YQbLTwG0Isrj/jWVJXljK2+ROxfEJ7Z92cISPMGbL3IkWd/Pu
	BKgSDAP+R5xWSEgM+3R/f3HET1TmIrY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-X6k0ZfvxPZ6YiKxEC1Yztw-1; Thu, 18 Apr 2024 06:56:50 -0400
X-MC-Unique: X6k0ZfvxPZ6YiKxEC1Yztw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-349a35ab5a9so105839f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437809; x=1714042609;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfCPrnN+R2L+ohL34J4SDJTHiHwngI9ibvQYum6Tb84=;
        b=n2YWiNdTvSwCnarm8x/1lr8BcIhOLHmNKK7Bnn1X35NLufYlVproxlr7De+4qmksu6
         MnLkdLZqjTIpq6BYAHidN4rD4JNZcuwjHkBPm9ZsTDxEIt7+yMCztfOF9uwSZ6sEya6G
         bINpU4a2yddhetwJIXQGkKGk3yUfJ2pLlRu3RLeaUOIMxQklwdjSoWKWNUvZ4VUkhzwB
         g5LOFViC+gInTMNq8QPiFBo6z4HgkpdOeRfFy4C/3hsox+M+g+iCfYZSK6qa8JWCqaad
         BKGS4tmiMsz6g8vHaF1GBOxZdgCWi+x5pjiY+iEMMe9MYJ4oV1uVzstIg/VDahQe7yVW
         U6hA==
X-Gm-Message-State: AOJu0Yym9J4jNtBAgoBu9XTHzaBV8faF3XNbXos5oGMuhiPy558sbNCN
	FbZIKel97zTyEzd+XcdndIKtlqEkHmjkiaCa8HeMnm4p5bQJ76xi8ybhcpKZNe6OUbDC34eglrT
	5pNdXI7RqvR0IF8SgFOZQj/hOBw/UEmYXqoUDp3sjaqPKeaXSOH6+0Q==
X-Received: by 2002:a05:600c:3554:b0:416:7b2c:df05 with SMTP id i20-20020a05600c355400b004167b2cdf05mr1666274wmq.1.1713437809385;
        Thu, 18 Apr 2024 03:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDydnHxXLhYRO/5ecRKDDdodscNT1B4+zM0g6SsX5vgGVrrnndkD7K5KRLwzWfVwueAy99g==
X-Received: by 2002:a05:600c:3554:b0:416:7b2c:df05 with SMTP id i20-20020a05600c355400b004167b2cdf05mr1666261wmq.1.1713437809020;
        Thu, 18 Apr 2024 03:56:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b00417e36953a0sm2303519wms.20.2024.04.18.03.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:56:48 -0700 (PDT)
Message-ID: <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, 
	Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, jiri@nvidia.com
Date: Thu, 18 Apr 2024 12:56:47 +0200
In-Reply-To: <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
	 <20240416193039.272997-4-danielj@nvidia.com>
	 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
	 <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-18 at 15:36 +0800, Heng Qi wrote:
>=20
> =E5=9C=A8 2024/4/18 =E4=B8=8B=E5=8D=882:42, Jason Wang =E5=86=99=E9=81=93=
:
> > On Wed, Apr 17, 2024 at 3:31=E2=80=AFAM Daniel Jurgens <danielj@nvidia.=
com> wrote:
> > > The command VQ will no longer be protected by the RTNL lock. Use a
> > > spinlock to protect the control buffer header and the VQ.
> > >=20
> > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > ---
> > >   drivers/net/virtio_net.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0ee192b45e1e..d02f83a919a7 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -282,6 +282,7 @@ struct virtnet_info {
> > >=20
> > >          /* Has control virtqueue */
> > >          bool has_cvq;
> > > +       spinlock_t cvq_lock;
> > Spinlock is instead of mutex which is problematic as there's no
> > guarantee on when the driver will get a reply. And it became even more
> > serious after 0d197a147164 ("virtio-net: add cond_resched() to the
> > command waiting loop").
> >=20
> > Any reason we can't use mutex?
>=20
> Hi Jason,
>=20
> I made a patch set to enable ctrlq's irq on top of this patch set, which=
=20
> removes cond_resched().
>=20
> But I need a little time to test, this is close to fast. So could the=20
> topic about cond_resched +
> spin lock or mutex lock be wait?

The big problem is that until the cond_resched() is there, replacing
the mutex with a spinlock can/will lead to scheduling while atomic
splats. We can't intentionally introduce such scenario.

Side note: the compiler apparently does not like guard() construct,
leading to new warning, here and in later patches. I'm unsure if the
code simplification is worthy.

Cheers,

Paolo


