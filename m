Return-Path: <netdev+bounces-143619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6A9C35E9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125642820E2
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2991F61C;
	Mon, 11 Nov 2024 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXLubzUn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB153389
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288495; cv=none; b=A3c0CbDt2ibgAfWq808hzp+4X9eyp0X1RY3WSjhNztJvjvdjvCy7Rha4JqL1iNHZFKWCX2qOCXfEm+W9BCSCsCi1DX/tz+CpbGg4vRWOMmMLvSbkBpXzJ0ruG1kqXJwB3lkoEbFFU5maBiH3dZF4RQtARQoexg30TTmaCalaivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288495; c=relaxed/simple;
	bh=leuZ8/a/9iCo5dLFBQyoF8wApHzQfSfOMnYUkefVFyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8XWT7oGFt0BMdBam5rIXV7/iA1XUnAO4BDVKjZNsq4e2DPgXJ6tOPQrLIfjpXsE/gqq57Qzap0oqOC3jEZvmRx2Jdr3AKDHmxHSHK9vfqnZ2c1VGl04UPKSiI2fEZMmwRE/O4FtZrXSjkEqOW3oWfLIEYUSIHofKpkUgisQ20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXLubzUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwodJjCIiLaOTp/teX5ZAIKMeNbNjhKNfqQerM1sSEU=;
	b=YXLubzUnlIl9pI/Lmp9wQkdhYChiE0XSnTv/YQXS17JKfU5aT02vN4XUJOajyk1G6ggbCE
	GIuTUSdIXrHVnXtFW6kHqUqMiJvmLjMy1k/GHtmXmsbYQhWP771JTJ7W1qzSgj5w64JYk2
	o4f/YI6jz1SR3HFG63MV9Rrk1s2WK48=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-FZCgQC-MMP6pyptJzc72yw-1; Sun, 10 Nov 2024 20:28:11 -0500
X-MC-Unique: FZCgQC-MMP6pyptJzc72yw-1
X-Mimecast-MFC-AGG-ID: FZCgQC-MMP6pyptJzc72yw
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7ea0069a8b0so3199048a12.0
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 17:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288490; x=1731893290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwodJjCIiLaOTp/teX5ZAIKMeNbNjhKNfqQerM1sSEU=;
        b=m6RqkmFXkCQ6+k+Sybu88LgdmxfagxZYCK8xx8tuOnvelDYyD3pd0eXQLK4aCXOJrh
         EGZ5N2+Qs87CwmLuJyVUBeY8BbPeWnuu0mLZ7x0LStKGlm28B+HRYiwRyvWhSLDS4yXq
         UGB5LwT94qOOX+ObI5SFn6DHYJeWcDZJHBl+/mkvUjdDWrhbKAw0C5LQbFM6f/tSRi8p
         2sk8XPVxzWjDPJTyh0MWkv1stv7Y7hrXdznhZ3LJAT37T6peB3hEIjmcBhsL/aJ00zLw
         uUmVIP5kgc/q8p48Cg785Wj1jHy8JO9QWEKbH1oITXCSdu8uX67xgnVmZrvnci0ZiNol
         1Nug==
X-Forwarded-Encrypted: i=1; AJvYcCU++D9j9MyX9xBvojKMG+KW1eot3G6/K9l8id2E/kZM0U2sdidILHLd3wQXtRex5GGVykhq4ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3z1vfYTyXN4SHPBYeb6IBaND0a0bdWOf63bs+tsKKF8U2WBh
	TMt9MhevlrvRmYqeJXoEDhe9lwp9RJWq+3FdHPW2hPZfmxT0vUCHcg1q+Y36ArekD9YAVo0hUeR
	qI0FW2kWrZaNRyrv9UpdZzkrHxOyvMQouRowxmuUE/nR2bnW88Ls3yiSDckId3NX1RqGYag5NHq
	ZFuVzpLJBzs7Ca9zdlyQv5Pw3XXuiA
X-Received: by 2002:a17:903:283:b0:20c:5cdd:a91 with SMTP id d9443c01a7336-211835d8f94mr142388605ad.41.1731288490276;
        Sun, 10 Nov 2024 17:28:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuUCilvl9/AQUv5pwsQJymlBnNl61KLcmkZ6nTf847m+d7BJWajr8P0LsOKCdKulbZKSlsGGD20yUrsvXzwVg=
X-Received: by 2002:a17:903:283:b0:20c:5cdd:a91 with SMTP id
 d9443c01a7336-211835d8f94mr142388255ad.41.1731288489838; Sun, 10 Nov 2024
 17:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com> <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
 <1730789499.0809722-1-xuanzhuo@linux.alibaba.com> <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
 <20241106024153-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106024153-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:27:58 +0800
Message-ID: <CACGkMEtbkPmikN3r2+kBpSq1UsbD-CcHF2GdfX+1zSSkt6X9sw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for
 indirect buffers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Nov 06, 2024 at 09:44:39AM +0800, Jason Wang wrote:
> > > > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > > > -               vring_unmap_one_split(vq, i);
> > > > > +               vring_unmap_one_split(vq, &extra[i]);
> > > >
> > > > Not sure if I've asked this before. But this part seems to deserve =
an
> > > > independent fix for -stable.
> > >
> > > What fix?
> >
> > I meant for hardening we need to check the flags stored in the extra
> > instead of the descriptor itself as it could be mangled by the device.
> >
> > Thanks
>
> Good point. Jason, want to cook up a patch?

Will do.

Thanks

>
> --
> MST
>


