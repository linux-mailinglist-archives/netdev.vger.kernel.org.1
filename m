Return-Path: <netdev+bounces-191352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ECFABB182
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 22:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5516B189470F
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0E1F8750;
	Sun, 18 May 2025 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkYBZt6k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90354C8F
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747599056; cv=none; b=AXaaTH+RBZUrE+YhTEFw+thy8VOO1po3KXP0J8ozrEAd0roRUma/m0/W6DCL8zO9YRQEiuoxNh+y+tGGG2rQCmyssBLdVXhhrsc6YUk3xauCs2BpCDdeJ/eOkG/Q3UeeVVS/65kFOZmu4cu1Nf+R4fzYoo/AL/d0any+tT1Y6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747599056; c=relaxed/simple;
	bh=BZghFxnzXNSsmGXc+tWUOfKJ3tXV3mjjGNZeuOUUjHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGlZEyOHt1ve9fRWwKlByhkILIi1bVh+jUahxfMTBsRFIbvdTwh6C+ShfCyCsd9HKfX1BIU9/cEG8blY6nIR5WKsQH35qEUgG0GQ1XWhhSpy8C6noN+9DVvah0DUWXA9nLv9vpHqHIBf3ov6UPBl7J5+zy98nRPWzMPYpPDNhzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkYBZt6k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747599053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3OJIBHhQbvH4C7u2Xf44+7JcPKOKfrafXSUikraTic=;
	b=MkYBZt6kh8zX2DOq93FdRGfgaaTnZvLEJ8uhlCkuOK72tksb2vWzs731E/Lj+4lY4jLCFO
	qifwpD81rwD9x5c3bjoVtZDH/D5f2CrRYWBPgOXIZoxU/djHGjfqXjdEr4/o6bscllIJxd
	qUGEaJRr1RTABNKoSUSSUTc95/Cvizc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-ORrL8sihPzS5FguX4Au52w-1; Sun, 18 May 2025 16:10:52 -0400
X-MC-Unique: ORrL8sihPzS5FguX4Au52w-1
X-Mimecast-MFC-AGG-ID: ORrL8sihPzS5FguX4Au52w_1747599051
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so21609935e9.2
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 13:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747599051; x=1748203851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3OJIBHhQbvH4C7u2Xf44+7JcPKOKfrafXSUikraTic=;
        b=KaYuQkfwu7GHV6UNlKC1fcCvp+nBdfhkZcR7HTw2Mq+PDg72rNUiVT/Ud7qpUkDkzS
         a+IpjZ2oiK2E5I4srtW2cpLdXcJw53cTJfXrGe2EDyVtQNCzrXGqIu/WL8mIv9QSKU68
         ImZ01xghrumBoSkJFjD4SW54il/gL67ul5tuV6TJF3bEr4JwK6Bbnd+3U1JIdwmcNRH1
         P2/CmeseX3Y+HWNfE+TxQiLR2bVUfbLuCq9u7oTiZLuEpJ8II/Eobqju5rHCOWU4BY81
         r1Q4Rh8ASiaWh9rJawrKMZs0nRJuKJAeogM8Udcy5i78GyJ4WxZcYakkC+NjB93tgWN5
         3Jgw==
X-Forwarded-Encrypted: i=1; AJvYcCUVsWfbN4trgLPqK+qOueRKVYH1TAbcL7D/4/1IUhSdZVFYB5hAqQ7Fp44bZiwEHHKKWbMG2As=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVHW2wpRfuX4M2jqgz7h2ZKgJw5VaR1/Qg8mHDKlNYjj35dDD
	/xLjRu0uIx9WN4UWfinP2VwPKcxbloUwABjqlufh+tJzKuDKQkT1L4TDrloZw03YTRNTXGwm1D0
	wDljpDVB8qysNh8G76PDGDaXiUl/4QO/opALDL9H1pNSfPatD4qDqfCx5Dw==
X-Gm-Gg: ASbGncv7Cr67SHG0rB/qrHPvCaNR4yJkqON9LImLQhqK4GYq/n0Dt+zsdwJaH+TdzaW
	1QmPthIQgR11x6fr4dWUsHTrbnBGI0i4TxZKCwH7VbLtf+5U7BGboO6sul6wUs5yZ2v3JblN2Ms
	00V2tGvFxwZJrQ9VXUQb5AVcTxlMi5BjZDYBG6KyQGMAhX3HRu76axusg3dc3BFqKfsh/J5Ec0s
	/gJ3fOHc7pHGOkK8qOoMYaHxWGbKLtQCoNoBDEsDdAG1OY3ox4hUYSE886paDiEOVu04z21OHNo
	akAVCQ==
X-Received: by 2002:a05:600c:3c82:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-445229b42b7mr37633375e9.10.1747599050876;
        Sun, 18 May 2025 13:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9jnPJWyH4uHKeXx423hSexRvEamch9ljSyzfnly8GcWhHz5Jv8eYgLruUdeBR+mLa1dJkMw==
X-Received: by 2002:a05:600c:3c82:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-445229b42b7mr37633235e9.10.1747599050463;
        Sun, 18 May 2025 13:10:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951854sm183062725e9.24.2025.05.18.13.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 13:10:49 -0700 (PDT)
Date: Sun, 18 May 2025 16:10:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	David Matlack <dmatlack@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Yong He <alexyonghe@tencent.com>
Subject: Re: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
Message-ID: <20250518161024-mutt-send-email-mst@kernel.org>
References: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>

On Fri, May 16, 2025 at 04:07:26PM -0700, Sean Christopherson wrote:
> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a very simple concept (device signals
> eventfd; KVM listens to eventfd) unnecessarily difficult to understand.
> 
> Burying that simple behind a layer of obfuscation also makes the overall
> code more brittle, as callers can pass in literally anything. I.e. passing
> in a token that will never be paired would go unnoticed.
> 
> For the performance issue, use an xarray.  I'm definitely not wedded to an
> xarray, but IMO it doesn't add meaningful complexity (even requires less
> code), and pretty much Just Works.  Like tried this a while back[1], but
> the implementation had undesirable behavior changes and stalled out.
> 
> Note, I want to do more aggressive cleanups of irqbypass at some point,
> e.g. not reporting an error to userspace if connect() fails is awful
> behavior for environments that want/need irqbypass to always work.  And
> KVM shold probably have a KVM_IRQFD_FLAG_NO_IRQBYPASS if a VM is never going
> to use device posted interrupts.  But those are future problems.
> 
> v2:
>  - Collect reviews. [Kevin, Michael]
>  - Track the pointer as "struct eventfd_ctx *eventfd" instead of "void *token".
>    [Alex]
>  - Fix typos and stale comments. [Kevin, Binbin]
>  - Use "trigger" instead of the null token/eventfd pointer on failure in
>    vfio_msi_set_vector_signal(). [Kevin]
>  - Drop a redundant "tmp == consumer" check from patch 3. [Kevin]
>  - Require producers to pass in the line IRQ number.


VDPA bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v1: https://lore.kernel.org/all/20250404211449.1443336-1-seanjc@google.com
> 
> [1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
> [2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com
> 
> Sean Christopherson (8):
>   irqbypass: Drop pointless and misleading THIS_MODULE get/put
>   irqbypass: Drop superfluous might_sleep() annotations
>   irqbypass: Take ownership of producer/consumer token tracking
>   irqbypass: Explicitly track producer and consumer bindings
>   irqbypass: Use paired consumer/producer to disconnect during
>     unregister
>   irqbypass: Use guard(mutex) in lieu of manual lock+unlock
>   irqbypass: Use xarray to track producers and consumers
>   irqbypass: Require producers to pass in Linux IRQ number during
>     registration
> 
>  arch/x86/kvm/x86.c                |   4 +-
>  drivers/vfio/pci/vfio_pci_intrs.c |  10 +-
>  drivers/vhost/vdpa.c              |  10 +-
>  include/linux/irqbypass.h         |  46 ++++----
>  virt/kvm/eventfd.c                |   7 +-
>  virt/lib/irqbypass.c              | 190 +++++++++++-------------------
>  6 files changed, 107 insertions(+), 160 deletions(-)
> 
> 
> base-commit: 7ef51a41466bc846ad794d505e2e34ff97157f7f
> -- 
> 2.49.0.1112.g889b7c5bd8-goog


