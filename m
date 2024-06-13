Return-Path: <netdev+bounces-103111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC269064F0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB136B22ECF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A912F592;
	Thu, 13 Jun 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV6LWUK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62317E0F6
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263508; cv=none; b=dMNxslSk5epqFd3mwSSGrJTCF8EWHX/xnowv0+WeJPyi9JVVeobrQFq3FEAXy9mqAS/ss4ztjuw/jBPpMYRyZZT+VX/JU9yCzRWvbxEvxs/Myek/FlS3uZscrt3Srij4dmaL94aH2Pr51MNTHd9WX29P+/ZEos1i2V+/OB4m9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263508; c=relaxed/simple;
	bh=M/P9xg59j+wLf4SfZ6wObo597oRHkyv5hAFbY3pd9Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1E3PGIi7QKi3UR69sJjZYBlUQew9N1lPEWk7X2raXht3tnJJemPpPPkh5ugx6QOe7QQbhoHlaMu+B7jY7Cx2wtCT5eHwxUXYQ/6I0xh41rNrzQbSGZuL2KHgN5foDgrztoI/BQBFCHhW+c2ZGlVfSmbIL0FaQGIXqYNrsIQmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV6LWUK/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cad452f8bso562718a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718263505; x=1718868305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/P9xg59j+wLf4SfZ6wObo597oRHkyv5hAFbY3pd9Oo=;
        b=RV6LWUK/5Q5/lM1ngWafxYyYVPks2HkKX+zlCHsLzpQZMq5/sxOqqXl+Z2Bv7/MBvt
         3fGWGQ5sB2tS1KAQL2CdEcHgQL0v9825ivbVi4u2iAMguq1a63NasOr5oFLrp79r/eYM
         o8nxJuEh2L8Iw20+Ls9r0Ra2QMJLhO2gQgIBQXnDzbdvKACJ5KD5NexCHZoacTzgEn6E
         PDXpmbOITxJlQiTz3fxkcMKCAyrj35h2rbjAF/m9H+H2cTfXoARt8judtw3rZ1PnF8UG
         jXwnF23ZW2R37EffMxtJEipE33JCowxwb/XNRPrii5lhk7D1HW/60syJY6u8aslMHH/4
         wazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263505; x=1718868305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/P9xg59j+wLf4SfZ6wObo597oRHkyv5hAFbY3pd9Oo=;
        b=kynD3pcyxWaXPVExm/t5VbmpgOvtrbN7mitw5jCw9aKSL8ahudcdzeZuL6keyAzgoQ
         pkwcvFvrZjlwramsUwNn0nYaEraQ1LZRty5im38iMW+CCSG+FrzsP4VCGjqxdq2N9LnJ
         li6lcwjFpeS3tebL5hVbYq0iEcNolcDv9Z5ozbcNyuRDzN4W3hIa2zBRVv9Z8LXsN2zh
         oVV4F6a4tXJURU99v3Va9I/bI8W4ZW0vXEN1fC5ptYsWxPtNFHxkDHS9jqBNt8C4i8Gb
         Gw3PZxT2E5pIWV4mmjEiWT2PVsjcH4gCug5dBYLZlLhAKETk2bo4ZjjJIbXJn7XEF37r
         BmDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRanP1lt9hl3crbsBqO4W5Px98H6djqgkfuF8niV23TTFvpBxGXl2E5EFaFR3KkHyhhTr7tRR81naHBSaXs6vNKGZPFrU+
X-Gm-Message-State: AOJu0YzKHHJ4U1ZVELkAPPjv7yVj+ahr35fcvcF6wuUu9nRx+u5ZgRds
	6pbXG05JEj0I8j0Z5CS05AvwfBsdsjV1Y/ci3HrDgTY7XFiezxRBx+6pSjOl6fvecDz+iwo46WL
	cRbwFfffeTdFT6EF2TlQRHgLOOpg=
X-Google-Smtp-Source: AGHT+IEVFr6IA1xTP0udfWHq9xfFYhlD4+fdDqfx2t0vfNBpcqZbuDnrQVwvhqdSBSpN6uxZMProXRy6d7pJNF/JZ7k=
X-Received: by 2002:a50:d5c9:0:b0:57c:acf4:c6c5 with SMTP id
 4fb4d7f45d1cf-57cacf4c8efmr2139562a12.24.1718263504916; Thu, 13 Jun 2024
 00:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion> <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion>
In-Reply-To: <Zmqdb-sBBitXIrFo@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 15:24:27 +0800
Message-ID: <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jiri Pirko <jiri@resnulli.us>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:19=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
> >On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
> >> >From: Jason Xing <kernelxing@tencent.com>
> >> >
> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
> >> >BQL device") limits the non-BQL driver not creating byte_queue_limits
> >> >directory, I found there is one exception, namely, virtio-net driver,
> >> >which should also be limited in netdev_uses_bql(). Let me give it a
> >> >try first.
> >> >
> >> >I decided to introduce a NO_BQL bit because:
> >> >1) it can help us limit virtio-net driver for now.
> >> >2) if we found another non-BQL driver, we can take it into account.
> >> >3) we can replace all the driver meeting those two statements in
> >> >netdev_uses_bql() in future.
> >> >
> >> >For now, I would like to make the first step to use this new bit for =
dqs
> >> >use instead of replacing/applying all the non-BQL drivers in one go.
> >> >
> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can ad=
d
> >> >new non-BQL drivers as soon as we find one.
> >> >
> >> >After this patch, there is no byte_queue_limits directory in virtio-n=
et
> >> >driver.
> >>
> >> Please note following patch is currently trying to push bql support fo=
r
> >> virtio_net:
> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.=
us/
> >
> >I saw this one this morning and I'm reviewing/testing it.
> >
> >>
> >> When that is merged, this patch is not needed. Could we wait?
> >
> >Please note this patch is not only written for virtio_net driver.
> >Virtio_net driver is one of possible cases.
>
> Yeah, but without virtio_net, there will be no users. What's the point
> of having that in code? I mean, in general, no-user kernel code gets
> removed.

Are you sure netdev_uses_bql() can limit all the non-bql drivers with
those two checks? I haven't investigated this part.

>
>
> >
> >After your patch gets merged (I think it will take some time), you
> >could simply remove that one line in virtio_net.c.
> >
> >Thanks.

