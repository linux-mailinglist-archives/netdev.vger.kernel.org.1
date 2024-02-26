Return-Path: <netdev+bounces-75081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF478681A8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE18B2339E
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87767130AF0;
	Mon, 26 Feb 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP0fYwh8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC539129A91
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977687; cv=none; b=t3OpQDnO5DKJ4TVQOOF4J1ozhA6I4tfN9dRWSCTHaeZzxwoERb5AP3ZEGWaKBDFyGpmSyRfaNr9hEcN48vLhHDbsO6FXxmwb4WW3nIso3BtTIOscLOPeo4AGtjlCjwWAZlwICcRZRyTtyqTnVBfk19yuA8i8BuRV2QR3TTyuUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977687; c=relaxed/simple;
	bh=zGlJ3EiOXR/34ioCepx5r0FEC6F58ty99m/GrlzjQAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhAbjftQ2hxYHghn5T2sNonklhdwhFSPZlF//aUyApA92ZsVvD6xhBpARxutjSQWmLVqjalHCLlNh7nV0z4kqQeFdfHvLo69nYHVyG4L89vq9GelB3UVQT99h0slrK+rZnl/3icvTEm09RaQthJkM/BxcNxWRZs7QhbVHLpZUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP0fYwh8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708977684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYxGw25SGI76GYgAampCb+LamaCZ5XgpHA2NlSjROPE=;
	b=IP0fYwh801S6XdAGmipoA5eoYIh6Rey1jo/xy6XJ5zScbFX/cVV1iQf6iRKMzuzleclsEC
	214DuuzkZmaUIzWAL+Cvuu68/vdf3JkdV7HmzcFJkHx3p5jVKo7PFQ1QLApEe/BKG222Sy
	P3aRcPXJ7NJzN7dWwaq7tZKZJrm01kg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-GPb1aWbCOfOg3H48DPq8_Q-1; Mon, 26 Feb 2024 15:01:23 -0500
X-MC-Unique: GPb1aWbCOfOg3H48DPq8_Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-565ad4513d9so1302355a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 12:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977682; x=1709582482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYxGw25SGI76GYgAampCb+LamaCZ5XgpHA2NlSjROPE=;
        b=vguF0dUcf4fG8I03sptWxIQ6aDeFlIeQ1B99UsiDaF82ngAbi/ixAcRGEPsGweelhU
         G9IHKAF7lyA2IVrKr8RXw9iYE/PQC2eyehT1iOTQ+O11sFl6/zSDCbkjZXiH7NNKHkQj
         YeiUVpHZMH7ahBP/mm860zVfscQtpfrNoJBTMiCV0v3cV8qwdRHin4kDT+M9GzrC8PzK
         4cSMd2XdJUJUl0wiMB1zN8zIeGsho8Tys6Q5Lmsv+xmDIZPwlRjubN0x535aXTbxczj5
         ejBqQVV6HdWK7WPZ+geaa4jhC0xMSoXeBv8oxyY5r/0NSlQl+j35dNLzXl7s2bZRRwOJ
         V5zw==
X-Forwarded-Encrypted: i=1; AJvYcCUpXkfdjzSBiinwNrM3AVilpOKZZK7Ga80/2ec5XZjJ8XzVtCDOMIHeBBZ/7ly+Q/qjPgn/U6cv3MCddqq5ojXHz0+zrXHb
X-Gm-Message-State: AOJu0YwyAtObe8tstxlzlcobVOG2aJxQZPzZJPCYehVwYFoXDp4p5K27
	0fOErQ30tJ4kQII/KPYyxlSFvK+iaIHysKlXDZvdlDDioHBSWFJdfBFX9jhzu8fR+9RGN9ZAHJm
	c8MBLvCXaSEP8IzxDunO1geB9q5BUlDAQJU8SklsSMpIv/lKOyiNGkfIlOJPJs8u4UKmLwUf6Af
	qEE2bQsVZp1qv9NIPIoGXOe9RNNzNo
X-Received: by 2002:a17:906:470e:b0:a3e:4d4c:d120 with SMTP id y14-20020a170906470e00b00a3e4d4cd120mr5377374ejq.12.1708977681803;
        Mon, 26 Feb 2024 12:01:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP8eld4XKjdHNinbhF+/WCSbrZBK7KYuAHXWGrSWsn9IST28vNpm+5g3NJMnd2r8qUxtdXhS8woALmCut452Q=
X-Received: by 2002:a17:906:470e:b0:a3e:4d4c:d120 with SMTP id
 y14-20020a170906470e00b00a3e4d4cd120mr5377360ejq.12.1708977681508; Mon, 26
 Feb 2024 12:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226151125.45391-1-mschmidt@redhat.com> <83a3cc75-a8c8-446b-a083-0ef62134d850@intel.com>
In-Reply-To: <83a3cc75-a8c8-446b-a083-0ef62134d850@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 26 Feb 2024 21:01:10 +0100
Message-ID: <CADEbmW2cncmVNkNLdrd_zq6CGLNOB_O0BvmGowZMbB1ZTyo8DA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] ice: lighter locking for PTP time reading
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:17=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> On 2/26/2024 7:11 AM, Michal Schmidt wrote:
> > This series removes the use of the heavy-weight PTP hardware semaphore
> > in the gettimex64 path. Instead, serialization of access to the time
> > register is done using a host-side spinlock. The timer hardware is
> > shared between PFs on the PCI adapter, so the spinlock must be shared
> > between ice_pf instances too.
> >
> > Michal Schmidt (3):
> >   ice: add ice_adapter for shared data across PFs on the same NIC
> >   ice: avoid the PTP hardware semaphore in gettimex64 path
> >   ice: fold ice_ptp_read_time into ice_ptp_gettimex64
> >
>
> Glad to see some fix and improvement in this place. I had been
> considering switching the hardware semaphore entirely to be a shared
> mutex instead, but this direction also seems reasonable and fixes most
> of the issues. We could actually extend this to replace the semaphore
> with a mutex in order to avoid the PCIe transactions required to handle
> the hardware semaphore register.

Thanks for the review. I'm glad you mentioned replacing the hw
semaphore with a mutex, because I was already going in that direction
:)
Michal


