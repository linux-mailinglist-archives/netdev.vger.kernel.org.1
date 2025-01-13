Return-Path: <netdev+bounces-157575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0007A0ADB8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 04:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05273164830
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A413AD26;
	Mon, 13 Jan 2025 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq2SX+ww"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFA4315A
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737481; cv=none; b=n+Xw/NI3Rgxyv7QYJafSjLZW0NdSr9Fn6EsUwod1UqQBuwnuMVVY+L9anZg/neA6+zwJVk1YVBtBtpsaisxRg50oDefVBvkcF/FS2eSe2UJ/JK8Bc5p6rSxS3hqlsENezxS8qlFO8TpRytTE8QuHhjiXF7vzQG5vWTpXFov1nWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737481; c=relaxed/simple;
	bh=yRJfycwjDy0VxrwiaDvig/uV5jBkPvBFTkhNp60TiSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9jMUt1SQ/ZT/ilBBzBYsJX47BbbuOthWyHsn3uppuex6EqezVBYgQdJrwGvkAGq3J9LHrxADCDd4o0U4rNtgpkhojWQIWHJ+b2t9XUeC82dXdW8JfWguCWqoGvTUlsOWkH+NUZnmm2N0jS7TIIkrJ/UXALO3Z74BHRTWThaDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq2SX+ww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736737478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRJfycwjDy0VxrwiaDvig/uV5jBkPvBFTkhNp60TiSo=;
	b=Qq2SX+wwaCR2FbJ9dtiK2KIA9IBWMPykQoxaekGeb1I+QDy2/6sU5RZ2RBXC07sUOc31fr
	fzC2zoPxPZ923NuTWxUw+69zULPx5O+dApy9wTaD31cvpeZCT3CGVlSJVoRLhIEjah56px
	64sWZSy08ABE2bCJE17CPKP/TR8OvKs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-3_EZ5md0NumUAPSg4DgXlQ-1; Sun, 12 Jan 2025 22:04:37 -0500
X-MC-Unique: 3_EZ5md0NumUAPSg4DgXlQ-1
X-Mimecast-MFC-AGG-ID: 3_EZ5md0NumUAPSg4DgXlQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so6904354a91.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 19:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736737476; x=1737342276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRJfycwjDy0VxrwiaDvig/uV5jBkPvBFTkhNp60TiSo=;
        b=pom2scAgIvCjk0eRFy0Nq1tkSLTL5Id32YrUI211tHoUJ8xefD6iHwdrwMLWtgFuBd
         lrRljtLnsqPKNJg9xvLA5Cplu/znCg8ZHd8oaqvnHS7uBvKMSk7tmInrjSvdpe+UJ2nC
         Onp8M9zQrITR2F3aYHEUh9zo5JC8XTYiflTZ/ACSMlkBcB6WDnlRN4MxCAn3zKqd5I9H
         qv4MTbGWqa4SDeaSDvDYUrND0HQinLSr802YjNiIeqinZQ2mSVNocEPhZ6mcxOmmlWj7
         jkng8oCqjaEXj4epUoyqiOSII3T4wTcp/lBFqbR3zr4/5HcuwbBDZ0I1XFzil2jRBqaa
         fhKg==
X-Forwarded-Encrypted: i=1; AJvYcCV0mmQBXj9hbqdJpv9SFbxkfvBnInmaaXI6Yqrs9CKHiRG4zhhzlAOZh+q9ceNCA3FHPcR7+mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvxz7AMmDsxDOEYu2llrllX4j/7Z8qpvcgl9M3rt/cl0X4Qfj
	CFJryiMBWa2wFTHTRpW0bSnAdu4yToxtfn+6JGvOPOA4PXqzHgAlQefzGpy9HJPu8iiq5xAWzRK
	jRwkAbYPAqL4rj78t/I/1cVKef/+3pqloH1CMp4DRZTswH9QnIpn4tYhqvE017YnIwDESaSQLxH
	WWCN3auLBub3iISNkiUmcYxo3gYf27
X-Gm-Gg: ASbGncuMvFDzEIoAgNxgpLaVTanjmZHN7j4enpjAxbH/H4qJLFQDYeWoHke4WGCoVyI
	OEEF4kDSqTLDiSiTCfn8pd9eg18R7ZalibAyRoMM=
X-Received: by 2002:a17:90b:5145:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2f548eac588mr28389810a91.10.1736737476520;
        Sun, 12 Jan 2025 19:04:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3vQ4vRdPBx0guyoTg5ZpyZUQ/sA/eheHAAs75pTrkZhjd2AbRMvv82RBzJBTsua8lQjGaRuJEc2TbijFE4yM=
X-Received: by 2002:a17:90b:5145:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f548eac588mr28389757a91.10.1736737476052; Sun, 12 Jan 2025
 19:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org> <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
In-Reply-To: <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 11:04:24 +0800
X-Gm-Features: AbW1kvZHQU9iIwkWwKeABYuwHLZExY2G4KWx_BvVBrd2ec7v_BAcbnTLlgvVmZE
Message-ID: <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 7:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
> > On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
> >> On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>>
> >>> The specification says the device MUST set num_buffers to 1 if
> >>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> >>
> >> Have we agreed on how to fix the spec or not?
> >>
> >> As I replied in the spec patch, if we just remove this "MUST", it
> >> looks like we are all fine?
> >>
> >> Thanks
> >
> > We should replace MUST with SHOULD but it is not all fine,
> > ignoring SHOULD is a quality of implementation issue.
> >

So is this something that the driver should notice?

>
> Should we really replace it? It would mean that a driver conformant with
> the current specification may not be compatible with a device conformant
> with the future specification.

I don't get this. We are talking about devices and we want to relax so
it should compatibile.

>
> We are going to fix all implementations known to buggy (QEMU and Linux)
> anyway so I think it's just fine to leave that part of specification as i=
s.

I don't think we can fix it all.

Thanks

>


