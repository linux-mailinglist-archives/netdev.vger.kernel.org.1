Return-Path: <netdev+bounces-162700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD73A27A7F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196711654DC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61742218858;
	Tue,  4 Feb 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDWYIKMo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E721639B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694854; cv=none; b=iLugndFDXUP12KteM+SW3Q1gU8VOBCxZ0WFffCmtp4UDry4Npf45Cxt0ywcRXb5WAlQPxj60gJ+EBY0vUyMMUiY4pUeCwlbe1RdV9JLwenw+uNZApTWQg5fExtkIaLKtMhd4p//SxzebIQYKA6C4Zln/0wYQJWJCv8BJT/mjyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694854; c=relaxed/simple;
	bh=v4IGltEbXVCP4a94OCouiBWhgi6qNWTf6k50EQqiHBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwPM5C5vtF+X0/2nuJpXDFpRQeiNAcRk2/Fq9qEJagRWhBu/e9ZPUkYc4/p9KpaW5/oTzpNkXL+6jA3695OkX3SX0my3ZqriMChbSTQTFVe1mQhsPIj268rZ8yoGm7OGylFDwT0gm4gsVAO02Nv3bRFsiwFWEflpLqg7xKz8IG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDWYIKMo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f032484d4so171215ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738694852; x=1739299652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4IGltEbXVCP4a94OCouiBWhgi6qNWTf6k50EQqiHBU=;
        b=rDWYIKMoZCzlJCwCdBIMg3sLU7PfZEOkLIabj6tvxuxyoOxIRjVsGojF6ICqpim5Pq
         gAMzEBrgeQ8RfwCtC5xqruDtllhCdZJP9rwTrk+izmTufLQ9ZHTDhU0PkljoXoLxlYrE
         3zDm4SgkOi+gqeSxP+SLQV6hypjUxStvMWtc1v9CQeshj8Z4dk9v3AqJxwRl3q1ZdH/6
         oO0wFSxwB0fSgp9ragfDcowwIu64Zc1uMM/a7/9t1DYVg+H1KheXwnX0N6vOJcX0LxXP
         dDac/cHmuJap+PchRZhyC5TqsMFWvn6rV3PF+UHu4E5h30ObqDEzhmDNNVrJnhblFnfD
         +RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694852; x=1739299652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4IGltEbXVCP4a94OCouiBWhgi6qNWTf6k50EQqiHBU=;
        b=tG4rzn+BceLNQGhOsERSr5PDUk+M7hCOa1DqRLnukYJpFjBIkzCr6kl9qDBJjfQEYN
         lac6KDHlVlGjKJc9T/7KDZ0/F7X+NvO5auL0akEydnfschLRqafb2RSuFeFqGW0/GSL+
         TMG2+Q8isV3AuVs2DyfYvMRfKbi+LOrGD/RF1fkpMpCA3JYYG+gHC90zxDvsefo6rq6A
         aVcoHOUI3vjeWVPSdpZGpbqwyII3Bi2IJ2Ecj8KP1RVFhRgLe3C5+E5uQI5NR7XkcHcs
         HErPMP4rLLWebWtdC3l4xra1cqTCDs6RON8TCSswjMqJe5j3RBM2jkay07CsZJhVgmN+
         2REQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnlTUji1yqhGr6kXh6UuvMTng/sde54Dr4t8Q92eNIVPeIlkPUADEBRrU2LZiJLSxAO0O08sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZIqFisEkvZbCSYaQODZUClQCr0NUa1zU2CCNN5R/NHKuwfTC
	PAGQ3lZAZ8sUiwPrt4lRXsr8YRA71YXWX6EVh15Zqg/r8BPUwg2o2kR5PBCVmhyj+PW7pOuSwct
	tUtP0a5bSWqZlBFjEUPjjL0pv70649G5sUqh7
X-Gm-Gg: ASbGncsp69iz0VcF753F5dk5L4KKeSitucOFZytnMnLExDbYRJ5mtnB1T55oHxYof2I
	8vnf7jGlW/i4dRCTGFFpTLc9jT660a5rXYadkTnFC3m5X5Zb7NXOol6MJl7A5eb34IgbRcva8
X-Google-Smtp-Source: AGHT+IFJdXh8ck83n4rc4Do2Ogq6GGTLEe+osME5dG/SgCsLyieOBoQ0D2ALRntzLsFX8hi9y9QT4/yUf821Olkgy8I=
X-Received: by 2002:a17:903:2a88:b0:20c:f40e:6ec3 with SMTP id
 d9443c01a7336-21f005bbe24mr3646635ad.22.1738694851632; Tue, 04 Feb 2025
 10:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com> <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch> <60550f27-ea6a-4165-8eaa-a730d02a5ddc@redhat.com>
In-Reply-To: <60550f27-ea6a-4165-8eaa-a730d02a5ddc@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Feb 2025 10:47:18 -0800
X-Gm-Features: AWEUYZl2dMuyJ4mkkA_bd8Ob9-LshOFjdqNfCtl85nK7UgZnTkQrQ8j9xNndrX8
Message-ID: <CAHS8izMkfQpUQQLAkyfn8=YkGS1MhPN4DXbxFM6jzCKLAVhM2A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/4/25 7:06 PM, Stanislav Fomichev wrote:
> > On 02/04, Mina Almasry wrote:
> >> On Tue, Feb 4, 2025 at 4:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>>
> >>> On 2/3/25 11:39 PM, Mina Almasry wrote:
> >>>> The TX path had been dropped from the Device Memory TCP patch series
> >>>> post RFCv1 [1], to make that series slightly easier to review. This
> >>>> series rebases the implementation of the TX path on top of the
> >>>> net_iov/netmem framework agreed upon and merged. The motivation for
> >>>> the feature is thoroughly described in the docs & cover letter of th=
e
> >>>> original proposal, so I don't repeat the lengthy descriptions here, =
but
> >>>> they are available in [1].
> >>>>
> >>>> Sending this series as RFC as the winder closure is immenient. I pla=
n on
> >>>> reposting as non-RFC once the tree re-opens, addressing any feedback
> >>>> I receive in the meantime.
> >>>
> >>> I guess you should drop this paragraph.
> >>>
> >>>> Full outline on usage of the TX path is detailed in the documentatio=
n
> >>>> added in the first patch.
> >>>>
> >>>> Test example is available via the kselftest included in the series a=
s well.
> >>>>
> >>>> The series is relatively small, as the TX path for this feature larg=
ely
> >>>> piggybacks on the existing MSG_ZEROCOPY implementation.
> >>>
> >>> It looks like no additional device level support is required. That is
> >>> IMHO so good up to suspicious level :)
> >>>
> >>
> >> It is correct no additional device level support is required. I don't
> >> have any local changes to my driver to make this work. I think Stan
> >> on-list was able to run the TX path (he commented on fixes to the test
> >> but didn't say it doesn't work :D) and one other person was able to
> >> run it offlist.
> >
> > For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl=
-F31@mini-arch/
> > I have similar internal patch for mlx5 (will share after RX part gets
> > in). I agree that it seems like gve_unmap_packet needs some work to be =
more
> > careful to not unmap NIOVs (if you were testing against gve).
>
> What happen if an user try to use devmem TX on a device not really
> supporting it? Silent data corruption?
>

So the tx dma-buf binding netlink API will bind the dma-buf to the
netdevice. If that fails, the uapi will return failure and devmem tx
will not be enabled.

If the dma-binding succeeds, then the device can indeed DMA into the
dma-addrs in the device. The TX path will dma from the dma-addrs in
the device just fine and it need not be aware that the dma-addrs are
coming from a device and not from host memory.

The only issue that Stan's patches is pointing to, is that the driver
will likely be passing these dma-buf addresses into dma-mapping APIs
like dma_unmap_*() and dma_sync_*() functions. Those, AFAIU, will be
no-ops with dma-buf addresses in most setups, but it's not 100% safe
to pass those dma-buf addresses to these dma-mapping APIs, so we
should avoid these calls entirely.

> Don't we need some way for the device to opt-in (or opt-out) and avoid
> such issues?
>

Yeah, I think likely the driver needs to declare support (i.e. it's
not using dma-mapping API with dma-buf addresses).

--
Thanks,
Mina

