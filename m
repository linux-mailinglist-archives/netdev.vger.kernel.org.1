Return-Path: <netdev+bounces-186645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D3AA00A3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48825A19DB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C38270EAF;
	Tue, 29 Apr 2025 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boH5feWJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFB25290E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897842; cv=none; b=AIZbfXmAHfOz2fGQ0TTd7O3Vw7gsgFdKz1glU0mr87ADrMfme1IO7fwB89Oex6WyE9Qt6AjVfCi85W2TNTP9fUKZTva4Frca8TLoh3Heo2gMY/t4wvpc40w0u6okUAk4JwIcsFxDZyAgov+NaDYOnooELGf+zXGLOPjEd+8r+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897842; c=relaxed/simple;
	bh=vZnrLPvp1SezavRSb+3blfciooE35zWcwCY/HASVrFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/0aY2VZaXbE1IVZjruedbsl1sZ4Cm0zQqZ7YNpRO7ATQ8lRfR6rXqGdpJZ7ofDhW7fNA9cQT7QLwEt/41Dm2Adz6SPmSLJnGWxXJ2Pp8z6qB9wGDYu+6dYXK9K6U7wZrT9tDK9/KmUoATAIlET7FPMaLMe30GOGJPi8VqwzMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boH5feWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745897838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtBx4B5toFccZ4nF29kycNJ0OC1KNDOrp48cQ3Ehw34=;
	b=boH5feWJT5Z4lS6HyrV6ftSRPQ61Ydqo/qgkuTnejJA6A6qHDAWXXK7C/1Xe+sjE5WBroC
	AcjzteHT0/Qc3FsLodoefbFuRk8mZAkp2BpK1O7kTetJ9/e4g/bSrAYSiaZNU/W2Zs2VDU
	uK6gCVXQ1nLJkZUH7T2ngMQ6BMw4k0o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-a7cbF4POPzWeOlDvZJS5rA-1; Mon, 28 Apr 2025 23:37:16 -0400
X-MC-Unique: a7cbF4POPzWeOlDvZJS5rA-1
X-Mimecast-MFC-AGG-ID: a7cbF4POPzWeOlDvZJS5rA_1745897836
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227a8cdd272so46104115ad.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 20:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897836; x=1746502636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtBx4B5toFccZ4nF29kycNJ0OC1KNDOrp48cQ3Ehw34=;
        b=gf1GXgEQZ1SuQ69tf5bfSujDG/Bo07IeIZk/IzojAD6g7AQ3xcY9YBruzIPj78y3il
         oDyx2eUW4evyo2mxo/8+EVQs+I/Skb137nfz3U2lb49w6C0TfyvD0PGNhdnZr+KSCeHw
         AnqLU4VOKRkzI8OUuK9HBbw3UHBaXWLlIG/e61nOcftVyYwB5j/oeuAMbZeNGGyuGFif
         W6Qk5sLsaNXy0qeQmoYUVm6hAjOuo+DhugZB7M5+zhRQrGWmN/eJTZv8sZk6AIsf8rEx
         jBiLb/fQ17BE3Hc4/YXusvZuzPNXdKmXLj8mskHqq0RtWy5W+pc7GfVNNWymetxSF7kp
         32Qg==
X-Forwarded-Encrypted: i=1; AJvYcCW3YDg2Ztn9AJI7UzdmT3Snu6pj/hRUE90qITqTrCIaC9r8/TQybmB9bDie8jeB0c9yAqrglJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JO/l6fSfGYHDuJBGiZEdiFm/9DZz0XM5Atd92VDxI1QtIDf+
	ru/oTy9PjqDWhnbaII4wcktCvXmh5cOadbsHTqhKl+GTYozXnPIEO279TGU3GxMMZv0tK5hE1fB
	WXCybKE9pRGe8r9Cp+X/mcEt3aI0FuUPoOi0fT1hruX7wri4HYuhBmDvZanp3ukjFWOdxCxXMwh
	czbqIMHaC3uA4D6cXd88xwM/lOFskP
X-Gm-Gg: ASbGncu50b//WKkBhzxsbmuohqe4mYwXSVXq4WCsqbEa859da6NG2yOqahZ3zz9mwiG
	2H//cfn1bUYyxJmjyVrh3aG4BSCU6HCqmVtO/1qT7P6MQAXy9E6Q0ZTbAPOOnKaDULg==
X-Received: by 2002:a17:902:cf05:b0:220:e1e6:4457 with SMTP id d9443c01a7336-22dc6a0f26dmr163635065ad.26.1745897835857;
        Mon, 28 Apr 2025 20:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLe9pBRSxy4N+dD8KJSBtALGak10QhPScgb+yK1nBfP5vXL9NgrfdYgJEs/q16qDKuA3cYH0GoD1aU/5P+RTM=
X-Received: by 2002:a17:902:cf05:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22dc6a0f26dmr163634775ad.26.1745897835513; Mon, 28 Apr 2025
 20:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426062214.work.334-kees@kernel.org>
In-Reply-To: <20250426062214.work.334-kees@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Apr 2025 11:37:03 +0800
X-Gm-Features: ATxdqUHKrokOvlJhfFqnRSp5WKJr5Ro9UGb-ViD4ru9HrHYYXv8eFZRyEkZAZdA
Message-ID: <CACGkMEtPmDBsyHTsAMZ7aygPQ1CVELd8H4_1u4ySH4sMQXe=qw@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Use matching allocation type in resize_iovec()
To: Kees Cook <kees@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 2:22=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.=
)
>
> The assigned type is "struct kvec *", but the returned type will be
> "struct iovec *". These have the same allocation size, so there is no
> bug:
>
> struct kvec {
>         void *iov_base; /* and that should *never* hold a userland pointe=
r */
>         size_t iov_len;
> };
>
> struct iovec
> {
>         void __user *iov_base;  /* BSD uses caddr_t (1003.1g requires voi=
d *) */
>         __kernel_size_t iov_len; /* Must be size_t (1003.1g) */
> };
>
> Adjust the allocation type to match the assignment.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


