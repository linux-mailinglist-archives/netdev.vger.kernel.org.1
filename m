Return-Path: <netdev+bounces-246960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FFDCF2DA0
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 10:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39E1E300294A
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA12749D9;
	Mon,  5 Jan 2026 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U6x72nMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43714F9D6
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606725; cv=none; b=NLD2Ce5jc61Zuvb5O9bBJ74L83//QrN6MXtG2zAXA30HdFW2kye3WeSANg26hVy2r0ZaTdwUlhTvFE0amsF3rmYnBpkOzu8JUiP6W9XsNXjCCmLeXnn7GCOTStkrGLhbGHPu2vCyZP8hPmh9+EFYctmwjG+TQ57dE5SloMfKfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606725; c=relaxed/simple;
	bh=5ejwvdViHGpZahmzeANBNrpoCx269JspGOeia0IssR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fqe3G4rlfwOWccAJn/nSEP1A7opR67hTbV9q9nLiIbV1neMFVQAjh8cXN7mEsQiXSLaQap+h0kQKdLKsSzw8YLqBSo5CJmj/IvARtSK1czUcq66rf1FzvmFFy+AUUV+4mUFjtDX5OqtRohaSs5wMwdVGx1Z10uGNmcb5qoPwwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U6x72nMH; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbb061a08so815130f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 01:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606721; x=1768211521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txMxKLJCIQFzStXgaX6zCY9uCsyn60vWSct+HXcfqZM=;
        b=U6x72nMHxpmbQRXs1gnsE0GzwU9BM8OMC8fDOUEuszh/7vfjE3AvoxufBx+ZjziY55
         j9XpiczMVZ2WuGt6gdThIsTQXQ4wJFmMRUuoK1Cd3WyYjsJK/oC6+Z3J4LosaJDZw9L0
         WK7R9vTUx8GashsEauSiZc27QN3PZPeKtbTjQTejebn2GdPST/MM2eS8CEtjk/VZ0BJe
         lAC5Q5bGVIZQ8YyAXXcu/d9ChWPDfUSWxCRTGDfGpmkRA9eYFooxD/yM76hPB3pEAzjQ
         JbSrEg6nhtP08npXldyRH8jEiJwwljOBkglCGAZ+2ihUdiCfnkYpre6UjJl+XUsvU/us
         a0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606721; x=1768211521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txMxKLJCIQFzStXgaX6zCY9uCsyn60vWSct+HXcfqZM=;
        b=Edbc140mp+XHHZYyrlQCZR/9Y+aKO0Dsj9y0b2r7epEp5nAEps8ZybeKo9JxG0D+WS
         fdyhJX7+byWyQcurkIFfVzGGY//vLQfpH3B1i2keNeJ02udsUIJSCK9iOdT5Vmb9WCLM
         fL+icxMDg6ngvUlIvRqtxt3Ud5YBeuUVFAPVll7YDBDQoWQlazPGXpElxxsCeo7fowV+
         FD9jI17bW0P4FGt4IiEXXtBaRtHfp/gF7oWTG8OQlDGR4GVieBUYuyI/wuo/gaY62DIr
         nP+C5rh5EmvvKQv+9Y8qyF1u16ND2UJuZIbTbVeQ1pgfYlnhPklcmwVh8qUbgohQYHXx
         hAnA==
X-Forwarded-Encrypted: i=1; AJvYcCUiuv0PlVrczdAdicPcrSWzuX1uhVfMKMMAG7LBk8QXXSFEOCELAFVI0vdyB+pXpntYQTGXzeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBe0HAJzx+1Kz7iXoe/l/aMsehopzzccSoqEZe3MOa7GAVUd9
	vXsygA6KlmI1WniLAsHQqElK6qD9Ul5UAtx0mLM47f0hhsIntzEjyOV5xQ632G+lZSE=
X-Gm-Gg: AY/fxX4hLeJZe5s2RoKBAL8STCIxwjtrFvkJEe4YylQvDH3gAStD0njJCVYxniAXGJM
	Q3iYslGL6jAIjStMQEzfteRTl849mVhwzJrYUA0sYsvn8rjMgWkBxPs2QC6N7Hj7CUrByaFvTVT
	F9sVO08/vbwSU7dhqHfMK0TufaTQmHPFmlezWmfNw7/FL2fJ4eYlxxB8F745uApl7/Sp8UOf3yG
	kovdOCh5IthBJv2v79lNsNP3iQ+HBlScGsXtVQRL5ZvxmLpkT4JbWJ40SYxtQJdB0p5mHgarmEH
	eLk6mNzGibei4NRaKStX5BkUqspCZP/JiuZNXHxvwGnyaL9Zmj+wX1bNHdODVH+iwHlEzxk2Yog
	8m5DBpFMlZvp+syUTlBwDLPrlC6iVvKpXev2utst+UNTnOl5Q6Nm7dYbbQcqUW/ZpR1/40wWCPx
	bKBDCFzGhtfhWAHaND1k5Ndmyh0Q7FthckLXPZEtuUTFJQxYexnEZOF/3H8zp6FJYu03ev9piNG
	M3+
X-Google-Smtp-Source: AGHT+IG/wqgOkqwXrB1rsCOv37yZ5+KfBZKuhJz5pDuTeJ4oXS1iaQsQoWFexgrkxGoC7pycuuDd5g==
X-Received: by 2002:a05:6000:2305:b0:429:cf2b:cb0a with SMTP id ffacd0b85a97d-4324e4bf220mr35541794f8f.2.1767606721058;
        Mon, 05 Jan 2026 01:52:01 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327778e27bsm66263511f8f.12.2026.01.05.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:52:00 -0800 (PST)
Date: Mon, 5 Jan 2026 10:51:58 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/15] docs: dma-api: document
 DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <20260105105158.248b4dd2@mordecai>
In-Reply-To: <0720b4be31c1b7a38edca67fd0c97983d2a56936.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<0720b4be31c1b7a38edca67fd0c97983d2a56936.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:23:05 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
> previous patch.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

LGTM. I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

> ---
>  Documentation/core-api/dma-attributes.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 0bdc2be65e57..1d7bfad73b1c 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
>  For architectures that require cache flushing for DMA coherence
>  DMA_ATTR_MMIO will not perform any cache flushing. The address
>  provided must never be mapped cacheable into the CPU.
> +
> +DMA_ATTR_CPU_CACHE_CLEAN
> +------------------------
> +
> +This attribute indicates the CPU will not dirty any cacheline overlapping this
> +DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> +multiple small buffers to safely share a cacheline without risk of data
> +corruption, suppressing DMA debug warnings about overlapping mappings.
> +All mappings sharing a cacheline should have this attribute.


