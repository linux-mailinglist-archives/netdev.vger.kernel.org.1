Return-Path: <netdev+bounces-238771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C831C5F3EC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA0034E1567
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4947C34678E;
	Fri, 14 Nov 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF66oFoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5B2FABE3
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152364; cv=none; b=oiCeAS69x0dIErAyBpxu+O6Oo42OzL/rcs14ottlBk5D2YWf6KM/gzjFUa2LYU/21aR6COVJmCbp8SfFfsg5eKzPucXj1VTb51Pg7CLl/64uPHoQrBiPFw5T84C7Q1ry59aIit2zb8GJlEaroqcVLlm62hWe2hAP/U8lHb/dHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152364; c=relaxed/simple;
	bh=qMVXn0/pBxfD94D7ztw7lMcKOUUwJxhPmOMbkqfJm7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cW3oFCq7WbT5vX+CwoqsNuPGMloe+fV7UW89qKk3wr6rKVgLK1UH5pHQ/hkaAtM3HtPb00pV15Rv8dJjK6FKj8tip9vH4VFtU0qtXat8i7uTzctcUyOq7iG/9mjmcDQJfzdDuwi1yoDWuzXXKkxQcejfUre3B1cPjxlXnMI77og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF66oFoZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711810948aso16429385e9.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763152361; x=1763757161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB/JsODbft6bUwFY61gbtF9VSesiLo/SIsj+xEcELmM=;
        b=EF66oFoZLxzphJYbIXAS/TUYZLEBAJyvXKCd4PIFvC90eHOkT2LxM0EPtRpytP4XYE
         HobF4I2ubvWDYPKcY5sO/K7nhwcPWziHkr9qhmWt1e67EM354/od+kal8thtf9S1dNxn
         FmynrsR6Cb3UcCf+7ziEe6z+HHfLTV/a//XHRwiQwBMP8/G3SlHGwCNaUHp1Ba6YGA8p
         58RFe5vFdhpCZHBrEbiStQSR/FTzl6c+a4dzJ5ksKfNmHvrvp/ii16Lao74zepqIswoH
         l5W60Dr+0z97DyCeV29UfaaxK21g9jTnx7vUes7uAqw/Krz4Sw1XszXkskRW8bfcrc2i
         mPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763152361; x=1763757161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wB/JsODbft6bUwFY61gbtF9VSesiLo/SIsj+xEcELmM=;
        b=ADdUcGslzS6LjC0K+f5nib19qwrTfFM5ZLRuwnR9a/2Bfl7HOEh83vMMlavFw4POqk
         SUqI4RkXB4I1XGMR5cT69Bu1cVn63rv77lD8Fdh2M4H9TcqX5FDcw+IqE1IItP6r9ub9
         3v4ZyQXq0oUUNqjelmcAw6eYmpj77xNYXLxrOR5LjHH38E26Pbmf79nwA1yPxnOkL9oi
         gFEFVa2pxmPGONi1MRKDtTwAkfCFKlHdHW0RoTAtySbXvtBqFg2GUUNbd+u3JBXrMRjM
         fBFkXyhC8SG/fTv4P2pNOW2v0+GWa4wQA+uLgfjgNdAY9DFu4Yxx3Och7zw7IwENvc2W
         188Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBcvUSPH9Kyd6BrJAr1hRpcVFVzTe/pQNDvmqNz94h8VGoJ++12Q2VY+YrT/RhG0mvv1c7RvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKpodlqsu5ahqZPrTT02s6mug73/LWK7yjBaB67CLaVNFl4Nt
	TgGnkpO7ZXHzpXQ13jqm8B26LV4nc8hD+t8DRmYk19LYiVoTaEv+WnEy
X-Gm-Gg: ASbGncsb0vZ3LiOwjNle+oqNHxYhPZi4x7ZZ4VtOCA/zsJk2BSr0ybWaafV5NPKW6HE
	pOkgaQmikCyQImGFVxVb3Rqajs4HtzdXwEXjfw1R5t0GQ06p9l5WD8yZr5jjoRzHOB+oICth2h0
	gYYxFPWkkYXOV1oik2+yMkNw911D69wTZ3LopeGcfj493uCPyz//jy8ql9NhbIfQv06FsvdzO/T
	0oPKNf32K/s+20fS3Q1531cYcVUlxIVLpqXezBAozHS2GhV/sdRgZMihIaV03MViWdFqwStWKIp
	/s4gsPDoJ0DCsr3/6si0Z44G1Gz1Cxy930las3NXvRPbgiHL60h6e8hoOEeCnF2zIi98Pvhb3Eo
	ihCVOEpJHYqQvijRfrEKS8rosYeyOyhZb56zJRZPztHrXTSOxAmBaJIl3s22aefyqBUjQmThcQ6
	gBBVXGHApEYBdVuxayWv3iM7qO65R9JcwUpAHqR5fcxmQgYoYrnNXx
X-Google-Smtp-Source: AGHT+IGJLwKUUv/e7XeLeB5KiDfpWDJD0SeEvFpkKuz3Fu0ygR96nzPtknGu6NvJHta64Jve5dWi4Q==
X-Received: by 2002:a05:600c:35c1:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-4778fe1170fmr49088345e9.0.1763152360456;
        Fri, 14 Nov 2025 12:32:40 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb2f9c8sm54699595e9.1.2025.11.14.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:32:40 -0800 (PST)
Date: Fri, 14 Nov 2025 20:32:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user()
 and put_user()
Message-ID: <20251114203238.51123933@pumpkin>
In-Reply-To: <2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>
References: <20251113005529.2494066-1-jon@nutanix.com>
	<20251114185424.354133ae@pumpkin>
	<2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 19:30:32 +0000
Jon Kohler <jon@nutanix.com> wrote:

> > On Nov 14, 2025, at 1:54=E2=80=AFPM, David Laight <david.laight.linux@g=
mail.com> wrote:
> >=20
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >=20
> > |-------------------------------------------------------------------!
> >=20
> > On Wed, 12 Nov 2025 17:55:28 -0700
> > Jon Kohler <jon@nutanix.com> wrote:
> >  =20
> >> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> >> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> >> ("vhost: new device IOTLB API"). In a heavy UDP transmit workload on a
> >> vhost-net backed tap device, these functions showed up as ~11.6% of
> >> samples in a flamegraph of the underlying vhost worker thread.
> >>=20
> >> Quoting Linus from [1]:
> >>    Anyway, every single __get_user() call I looked at looked like
> >>    historical garbage. [...] End result: I get the feeling that we
> >>    should just do a global search-and-replace of the __get_user/
> >>    __put_user users, replace them with plain get_user/put_user instead,
> >>    and then fix up any fallout (eg the coco code).
> >>=20
> >> Switch to plain get_user/put_user in vhost, which results in a slight
> >> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
> >>=20
> >> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> >> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> >> RX: taskset -c 2 iperf3 -s -p 5200 -D
> >> Before: 6.08 Gbits/sec
> >> After:  6.32 Gbits/sec
> >>=20
> >> As to what drives the speedup, Sean's patch [2] explains:
> >> Use the normal, checked versions for get_user() and put_user() instead=
 of
> >> the double-underscore versions that omit range checks, as the checked
> >> versions are actually measurably faster on modern CPUs (12%+ on Intel,
> >> 25%+ on AMD). =20
> >=20
> > Is there an associated access_ok() that can also be removed?
> >=20
> > David =20
>=20
> Hey David - IIUC, the access_ok() for non-iotlb setups is done at
> initial setup time, not per event, see vhost_vring_set_addr and
> for the vhost net side see vhost_net_set_backend ->=20
> vhost_vq_access_ok.

This is a long way away from the actual access....

The early 'sanity check' might be worth keeping, but the code has to
allow for the user access faulting (the application might unmap it).
But, in some sense, that early check is optimising for the user passing
in an invalid buffer - so not actually worth while,

> Will lean on MST/Jason to help sanity check my understanding.
>=20
> In the iotlb case, that=E2=80=99s handled differently (Jason can speak to
> that side), but I dont think there is something we=E2=80=99d remove there?

Isn't the application side much the same?
(But I don't know what the code is doing...)

	David


