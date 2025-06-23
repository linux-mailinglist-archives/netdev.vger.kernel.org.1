Return-Path: <netdev+bounces-200160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B35AE37D4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6997A18E8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ED01FF7BC;
	Mon, 23 Jun 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcY2WHNS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA31FCFE7
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666037; cv=none; b=uAlMxC7vvQxE99F5SOSJqrIYG3QGY3urFF2GN1kkkdY1JgK0wu6Wzams+ol/yB2wVpBrCcJyZk8nENV//H53CoG8+XdGIki/c7x2dSlxp9jznnd+xX4rWaU1KEe78g7yeUr5t3jk+PRYQGbKvg/cuxPh9N+dUluQ2xQFPwZKi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666037; c=relaxed/simple;
	bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJKfg65LAJH74WGA6w6urtqx23YyyFI9XCFjh5QhNorg8hjLexIQyyPc0J1HMxviA33OM4x6yvDRR+366mC4pnBNlCueZPJD3emuCNN5zr34BGN24LWpJYzuoTiYACDXhrMvSNVTCePCqQMfznKfQtihdSzQr/6+/LxeogqQ3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcY2WHNS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750666034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
	b=RcY2WHNSiDo2HhsIMDVKPuNauhTHbM7AfvkR9kZSo1acGTzV7E1vYVK4plGfaIjYx7FjUA
	Oze7uAKV5iSAHbw245SjNI01o3V4J2xUiHB3Zcf8ufXatk4zWlSkhufhkiiLDDzZ3q3TmI
	wr1k709bcP8Wp2V9t3p6MumAa4tJemw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-dEc5wOm7M7C-FaeFMDTxyA-1; Mon, 23 Jun 2025 04:07:12 -0400
X-MC-Unique: dEc5wOm7M7C-FaeFMDTxyA-1
X-Mimecast-MFC-AGG-ID: dEc5wOm7M7C-FaeFMDTxyA_1750666032
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so3647241a91.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 01:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666031; x=1751270831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
        b=p7AzV8Qah8obtD0WLxLt4ZXPSpsheDpKqEDcu9kUByPdN3+Nde1GKkZV2w7uLcZXhv
         Mzfdflu32ajofO1U5svyT/0nGTU8qOXRiqbm4ODaHkNs7aRm3KUOso34MLdjl63eoc71
         wu/CBTDY/AqJfDK+93yP/wz+igjVHehWQUoiEaF0W5pruNNZquF5jVGEIvAfQyaYDHug
         hDf2bJvq3lo0MY1LqE2pSwZ2+WDYtLeAfMQQjIcrNs/g0GHq+sCbaWn5TYk5Ankz21BS
         A7HMZbDNzpgFcOYh13icF8X57J594WiQ5MGIXQ9MCMkchIdMxW9NvNxwYVhMaIvdlF9y
         itcA==
X-Forwarded-Encrypted: i=1; AJvYcCU4bznBR623cmXwyV+FLhFLfq/a8QTn/iXBnzSxExontXBooTK+ivhFhmRdzvAlLwxgr04VJOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtS7KhO/FfTgcUeajskpzePgm15ygciSaWfWXY5fxP0SzwM3f
	lgte5dJLxDtK9diFkJtc+U0mFy73UxE8xHgyP4UOHc5RZefhn/kSAlBXDveVI5RXx2bYfxDv/xR
	uvE3b+u28nJbUQUy7Fu7oYsh+EkV5YRHH71u/tWvMdozeBxcXXjcacUlzeNMsHZoGADVUu5//h1
	DLjjnRYV1lIa9dYddnOZgVrMvOLj4ZMY14
X-Gm-Gg: ASbGncuihutf4zLjECojrgDaVRRR/nqMe3uy7T+G+rywOc+Gi3NIBha7uwa7NJt2HIW
	VZDvdNiOpIR08fH9dE9HUk5jwAAaExzu/fCjloO1FFoBiDCTSxh6AxGCc4zJxeiR/NzK8cgJCEm
	j6C8Bh
X-Received: by 2002:a17:90b:5444:b0:30e:9349:2da2 with SMTP id 98e67ed59e1d1-3159d628b59mr18126473a91.4.1750666031639;
        Mon, 23 Jun 2025 01:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVQTOppEHtAfsayyJvo34GLVedX6rLC/x06Rbxlu1q0T6P50V9CQroeozuTXZMW8lnTkCwwxrOBTsZCaXXqkM=
X-Received: by 2002:a17:90b:5444:b0:30e:9349:2da2 with SMTP id
 98e67ed59e1d1-3159d628b59mr18126445a91.4.1750666031289; Mon, 23 Jun 2025
 01:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
In-Reply-To: <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Jun 2025 16:07:00 +0800
X-Gm-Features: AX0GCFtKGLSh9bwOyNMqm1wsTSYXIq66dXiloWDLmA7vjP1FAzXUnFKbCzTNLUI
Message-ID: <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> > Yuri, can you help to clarify this?
>
> I see here several questions:
> 1. Whether it is ok for the device not to indicate support for XXX_EX has=
h type?
> - I think, yes (strictly speaking, it was better to test that before
> submitting the patches )
> 2. Is it possible that the guest will enable some XXX_EX hash type if
> the device does not indicate that it is supported?
> - No (I think this is part of the spec)

There's another question, is the device allowed to fallback to
VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?

> 3. What to do if we migrate between systems with different
> capabilities of hash support/reporting/whatever
> - IMO, at this moment such case should be excluded and only mechanism
> we have for that is the compatible machine version
> - in some future the change of device capabilities can be communicated
> to the driver and _probably_ the driver might be able to communicate
> the change of device capabilities to the OS

Are you suggesting implementing all hash types? Note that Akihiko
raises the issue that in the actual implementation there should be a
limitation of the maximum number of options. If such a limitation is
different between src and dst, the difference could be noticed by the
guest.

> 4. Does it make sense to have fine configuration of hash types mask
> via command-line?
> - IMO, no. This would require the user to have too much knowledge
> about RSS internals
>
> Please let me know if I missed something.
>

Thanks


