Return-Path: <netdev+bounces-245784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE6CD79EE
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 02:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35FB3034A17
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 01:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971821D3CC;
	Tue, 23 Dec 2025 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frAnAsCj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fF6rbvVi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA513D891
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452617; cv=none; b=F5n4EOZ2RMsUSufzSpeaaPSCaqO/UfVgG043p1YbwmeAnQrp/qb0gFRALjaaOwOkzrL7d+YncnMXV0LnUSBgGMAC5yY2vXWWQJZLOAcxvRl//VXebCgJLh1qqK7e+GrR+aENK3OOfWqDvyS1Eg0mbxdzwJtu+eo8yqNmB6y73TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452617; c=relaxed/simple;
	bh=8kavS/IpGbpS8t4JnXK8FZtjo5KbcXSe8SCEx6230Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ak8/VGvacooQkEdKyU5d8cBq7qOB9WSCWTNeuKmWyCzz13GjSRM7++bBqH2ZEstqICJvK8dOan3aWvZbYqClAZOfEgPmb2VnrK2iUEqhYnHifKY2IerYJ7wqpP2YFz2uerL91eKYkQVTEY1HJW+/W4sKeFcjbV2mR7QPs3AtAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frAnAsCj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fF6rbvVi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766452614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kavS/IpGbpS8t4JnXK8FZtjo5KbcXSe8SCEx6230Fc=;
	b=frAnAsCjAovivn13rds7bBcd40kD879BTTJWEyFhnv7/y74ims7X8GxxNTy5Qye6we4LdZ
	FxydmCpotdPHn7HnfyXOgphv2Csa2WLEtVf4RWz2zjnzeNfbNjA4WVQnEHiawaTh25iiac
	ctT/wLuvMQt/uzVlXazGet6L/d+gfOg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-oVkg0-9kOkexctUCOZCwvg-1; Mon, 22 Dec 2025 20:16:53 -0500
X-MC-Unique: oVkg0-9kOkexctUCOZCwvg-1
X-Mimecast-MFC-AGG-ID: oVkg0-9kOkexctUCOZCwvg_1766452612
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c6cda4a92so9451645a91.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 17:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766452612; x=1767057412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kavS/IpGbpS8t4JnXK8FZtjo5KbcXSe8SCEx6230Fc=;
        b=fF6rbvViBcbUC1Kb084n1eTXLxM+ThYB0fcrdBY3Eth6zFSinpfJdnJ7+5IAwK3PNA
         5AU9Sk7IQwbi2CEZLo8sgS/SDgjyPlLrk/Blt4bqxoEFDDPc5rPaiha0EQB5IeXY+oWA
         emdGqo3S47GPD5H8YKovWyp6/to6gnMvEy74TxuvEUqC+etnpsJRPQ2z4X7F1ruKoFwB
         UFjjNIfyzIAbULBWZROegtlF07ByUGaGSOv1G1fEdXVLX2Oaqb55gJmfmlYe2P8kxOTN
         qSsFeB0e/Cbr4liQNB37bovzoUznEpPL+apcDeU0ymOv0EjA5ApfLdrhLlwf2iDZzqP+
         3fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766452612; x=1767057412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kavS/IpGbpS8t4JnXK8FZtjo5KbcXSe8SCEx6230Fc=;
        b=sEpxi75V310x2ZRsIAEe/ufYufp011JAwUHcRcMA7/FYN8Efjr0TmZ0q+P3JJAk1k5
         SQLdcdTl2BYFS3qywF04S4YmNwdnfBJQwm2JDLR82QSMqJ7M9HwxLgAhYZw9ZjFHH3XR
         K83dwr01N8eHkUhVQgvt569Jc5UmWxSdBZ4QAHjV6kKiR0s89gm7imtkXZBbY4t/vLRP
         cERN36Obs0jsUxAMP7KZcG2qrCAv+xtjThfpk53MLnIF9VixcIx/3sM8vcJQCOycyeq/
         g1IEI2svJ1UfSGyHjcBt1C4U/z8c9s3yy/GY7nXYGZ3WFqcZ11OWA7sA87NBQ1zSKaQ4
         YSaw==
X-Forwarded-Encrypted: i=1; AJvYcCUZAT3hDZc4kegn9edpUJy1+QNkyxbACB62V0L7Uf/kJAdsTXQwRQ3h8uT9ixZwUIPEomZU9qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhmrD7N9RbRlrTQx1HOWj+N1wQdXp7nURVOIiVI/REMc/dpkw
	hE5hE1PtDotAleOBg7g8C6c9vXsz5hzmzstDrm2JGVNz/9jA1fEj8EKzeNN6HCKWI8Lxe4uI9Vn
	TEuxf+FBY1Qk4MTLvVa5W3SZdXDJKvNYSV3zNEciSA+KAyPyQn9Dqt7wu6ygw5ZcKdelZjc1fbq
	+5QouvC8VhSq21N58XV4CZUqHA4WelrrFD
X-Gm-Gg: AY/fxX7SUIHuglTvEWSuAfufIkYWcN4lP9exB9l+/xBg41ap8xY1Q9GXdmg/3BE3j0U
	255p7mc2eqCoDLZlYBruNZk1+taZcJM3aQbiaCi+QmNUQAyWuMh931oRm+pbuk8mg+5A9zWlW4E
	8w7qO9sUGYmTALdfqbZxLOI8PkuS1dQktn+xpNtCvO9U55lBdeUgS3iWiDBsqfn87uNiQ=
X-Received: by 2002:a17:90b:278d:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34e921f0439mr10789729a91.35.1766452612379;
        Mon, 22 Dec 2025 17:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn7x/SBWzm7wQBhQmpSlijwdbERX85H67QKAbR4g2R9+j0TmYDnQ/NNpfbhl0rxAVecwANEG5GhCi8Yj5MAis=
X-Received: by 2002:a17:90b:278d:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-34e921f0439mr10789709a91.35.1766452611983; Mon, 22 Dec 2025
 17:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218091050.55047-1-15927021679@163.com>
In-Reply-To: <20251218091050.55047-1-15927021679@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Dec 2025 09:16:40 +0800
X-Gm-Features: AQt7F2qZ13vyIVUk_vjRbH6oyWkePM18LxZIXnO-FMhdbQs8hi0QxoGynHxgcT8
Message-ID: <CACGkMEvbrF=g0_yedXKsccVN6vmfm+oQVbRkR1PGtQgFHH+v3g@mail.gmail.com>
Subject: Re: Implement initial driver for virtio-RDMA device(kernel)
To: Xiong Weimin <15927021679@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
	David Marchand <david.marchand@redhat.com>, Luca Boccassi <bluca@debian.org>, 
	Kevin Traynor <ktraynor@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xueming Li <xuemingl@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Chenbo Xia <chenbox@nvidia.com>, Bruce Richardson <bruce.richardson@intel.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:11=E2=80=AFPM Xiong Weimin <15927021679@163.com> =
wrote:
>
> Hi all,
>
> This testing instructions aims to introduce an emulating a soft ROCE
> device with normal NIC(no RDMA), we have finished a vhost-user RDMA
> device demo, which can work with RDMA features such as CM, QP type of
> UC/UD and so on.
>

I think we need

1) to know the difference between this and [1]
2) the spec patch

Thanks

[1] https://yhbt.net/lore/virtio-dev/CACycT3sShxOR41Kk1znxC7Mpw73N0LAP66cC3=
-iqeS_jp8trvw@mail.gmail.com/T/#m0602ee71de0fe389671cbd81242b5f3ceeab0101


