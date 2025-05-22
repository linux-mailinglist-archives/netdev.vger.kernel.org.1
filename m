Return-Path: <netdev+bounces-192503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26930AC01F3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7753A46EC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80578F44;
	Thu, 22 May 2025 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnqpNqYT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00263398B
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747878982; cv=none; b=oEfy04dC1hvbjut8t7wT3BPbGGf6khO+X9ydy11WwNP2fsf7gaL3+DjJ0Tp4d1wuLHxFQlOeCbOu5gdcP827q2Y02utlh0jx/i+XQYoAWaOcH9vNRMi7Aq3BtF9D8mXJA4x+2YZ0KB1wj7j381wVW1xay6KHZc9WkdkuziEIi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747878982; c=relaxed/simple;
	bh=H5AGpXFkOjiqm0mIQhiYkitJE6OcKeVywqSZXg2cGe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWFoQm/rIF0leCNsxQSm0uhYYz7X4YgFW8J71pU5vpXKNue8YZVFBgP+PXdguM1cj6GtjB53qxb9gsE9h2Mozoa1MuA+SBzYc49HumDR6j9Lt2s4gk94S1lX1EB4Y1CM7OfaDMto0Z2q5rSrz2eoOLda132QTBnfJRFQtNvFa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnqpNqYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747878978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NW1557HPhPEiq5XsZNPrPBkBNdkeXJBTcWKSIzVke6M=;
	b=ZnqpNqYTdvctxR8mZCP0NzjSOBakpT1GIKKMKApKq0WPGFf/Sr05Mdo57zXbsCimxksk1m
	qsoTPu7wE86Hdhustmcy+05/HFOt0IvOqsPGrwAUwNa7R38MRXJpuJadz089TcUugJYD9A
	G7+Yioksx4m7k23GXAmSlSuOvI/7Ksc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-SAT_rxqjNq-Ya6WB6vIvAA-1; Wed, 21 May 2025 21:56:15 -0400
X-MC-Unique: SAT_rxqjNq-Ya6WB6vIvAA-1
X-Mimecast-MFC-AGG-ID: SAT_rxqjNq-Ya6WB6vIvAA_1747878974
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30e6980471cso5986023a91.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 18:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747878974; x=1748483774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW1557HPhPEiq5XsZNPrPBkBNdkeXJBTcWKSIzVke6M=;
        b=Mn2B8MQH1CJrUaIqYoGDr1LaOrY0nViHjSvnDC6OY4v8DPNMQoSe00cvQGSMt7sFN9
         dazLKNvGWavwOdIBnFW7JhSQZm2f2V/tNG14lXOsuuDA4QW1j/tT97/zjub0Jf0gK0D9
         fiJLkqMXAj/B8u72zt8zkh19/bh3lo/nGUAO83O29W+kMdUptMcD2G6kEANlAQ+JJgLZ
         5MvkChdLOzIs5IZsmRnfFpga5+sz0WdzE0tSHdIWgTNWMbPzJE6wEGf1nnHSShLI3agy
         Jp/54vPzaywAMGbq7SuFEUmTcvFXnIBChkohan1/cs09E3pHV7e5n72svbBQ5wGFsAm5
         c3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHUOQa9cUAyi2VaKUUV45zOSRyDh2xKfmm1Unt0Lih8wanOXVVvD3OAse/Bwuv/CfiEPoBe28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxZuRBM/JpCCsYdnktPY5UtAjMIr7v+TfsxajIw8aPdQ9tyqp
	MHDsc0xvfd9dWCLHpjjC1qvXsWY+quixV/YmNW9ZMgQHw1SrjZqLwL6U4L72g/3FZpfRb3jwvXx
	6YrULOtF61AS/b8gNaltPNx2NZHUl2g+Cod8JxdLfWDK8+Dogy3vuNrw7cMj+AABoklL/YeR32Z
	h74y+mrTfCRWLQHwDShceDvRaToZ5iMsjG
X-Gm-Gg: ASbGncvRdSyUSHSRc+k5MPa04LTrpCJkgKMTM6fwmY3iL8eiYz2+VMiywAt7xNzyjna
	lbR5/jS2rlxlVDma2kxX3VN7pkR03RWj8u9JS1tOKiIFpeqT6io/lQU3SDyn24hrpUpKAwA==
X-Received: by 2002:a17:90a:dfc7:b0:310:89e8:c7ba with SMTP id 98e67ed59e1d1-31089e8c7e6mr9243386a91.2.1747878974134;
        Wed, 21 May 2025 18:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9nY1imNdOY1fcMkW5165nto+x/L6mYFFJjGVHS0ov9+6/DqssyAmH+DkYaeCMnk9KynCvxnLw2cMUX/UbDDA=
X-Received: by 2002:a17:90a:dfc7:b0:310:89e8:c7ba with SMTP id
 98e67ed59e1d1-31089e8c7e6mr9243348a91.2.1747878973727; Wed, 21 May 2025
 18:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521092236.661410-1-lvivier@redhat.com> <20250521092236.661410-2-lvivier@redhat.com>
In-Reply-To: <20250521092236.661410-2-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 May 2025 09:56:02 +0800
X-Gm-Features: AX0GCFvAN5m910f9nvI8DBz7vO_Z6Tqq5Z-RhLtNuP933xBCKM48QQKj3szEI_4
Message-ID: <CACGkMEvvNcnDvsowuEKOxK9W+un3dYWP+YxtNd4Z1XsUU-ZrUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] virtio_ring: Fix error reporting in virtqueue_resize
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:22=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> The virtqueue_resize() function was not correctly propagating error codes
> from its internal resize helper functions, specifically
> virtqueue_resize_packet() and virtqueue_resize_split(). If these helpers
> returned an error, but the subsequent call to virtqueue_enable_after_rese=
t()
> succeeded, the original error from the resize operation would be masked.
> Consequently, virtqueue_resize() could incorrectly report success to its
> caller despite an underlying resize failure.
>
> This change restores the original code behavior:
>
>        if (vdev->config->enable_vq_after_reset(_vq))
>                return -EBUSY;
>
>        return err;
>
> Fix: commit ad48d53b5b3f ("virtio_ring: separate the logic of reset/enabl=
e from virtqueue_resize")
> Cc: xuanzhuo@linux.alibaba.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


