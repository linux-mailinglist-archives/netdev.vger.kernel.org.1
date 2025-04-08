Return-Path: <netdev+bounces-180190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791CBA80336
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB54165B8F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676C269CE6;
	Tue,  8 Apr 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQiFfedf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5C2698BE
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113002; cv=none; b=nf7K/CDeN1OnxGq4ox/ObqQCDJfbvygQuS46Az5AMV2UWmKMeWBWeupnqBnEW2rSNPNNBQeASgM4YWGXID5BWt4GLsoXnB+4C0vF+qg0pkq225AaSX9a4PLDxlny38fVeLmAASC6UgHC50hjAyPKWj4DQXujtTC+tVwUCBzoTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113002; c=relaxed/simple;
	bh=juga/NFhbOp5HXMYDZ5mhk5mcegQzBe3II+n7ob2+yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/XhKg4P5y8aDE9WIWWfHf+jsrWYPOpo2809yuGNZNTO2iuXMd85x2i4xrqlH5tot99MYROF9hkqdmNejLtZfVHkCDYyCjfJJ3qy+LQktM+FkKA7nbNrJ34Imqy3zh9qvn28t8GK3O66Xte+20mfulfUZLO2ntWgew5LSFctdDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQiFfedf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744112999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y007czW7nolro/BBbr+wWrRJwbjuQk2oO7pcjblsRYQ=;
	b=bQiFfedfyAizi3YtNdTog7Nrze8OS4QaXJJfMyQ22tIfxC1zhOg3kZcTeBOXK8B7GbVuuA
	cibDoH+iPGSDYnvfmLQZxpWPzd5ULHFZQh3n2fYDrSVPx28lzUEg1OkKGQxHG2wmVADEAR
	k/fLE1gLF3GPWenMrGqTho+nHsE4tmI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-hKoIXXKhNsqrHi6kzDcxuw-1; Tue, 08 Apr 2025 07:49:44 -0400
X-MC-Unique: hKoIXXKhNsqrHi6kzDcxuw-1
X-Mimecast-MFC-AGG-ID: hKoIXXKhNsqrHi6kzDcxuw_1744112984
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39abdadb0f0so2849415f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 04:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112983; x=1744717783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y007czW7nolro/BBbr+wWrRJwbjuQk2oO7pcjblsRYQ=;
        b=ocnwPo3L2aS5DspQMZtHYGJtAstYhVO2Q2uugTQapcqsrL4BSZZVm0aaeTm+oiPy4q
         toZwIXIxmADKeLN9vTfDdRu5ZnfK/oViy8zdt8qTF0nZA7D4u8MWT9Yl0C+uvLczM7st
         YnRkKSRe5wIZJCKrh27Lw/rjhOstRIP7svbkF11WB4VyDv3JwCwZwQtDV6FC+BfBPWEO
         w4LG85QKssb/L0wYamiemv7b+O1bk2AUve/uQ6FCxuzRcTGiwLn0+TWausSEL47GniHI
         VdNlM0KzkTDVyNGQCQFRa8oJOkDeEGw7xLlx2jVvukhQGhlLDUsJjWKP59eNro3Pt4Ur
         +7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW9ueyfZUmXh32DZrqLIfAbVk/3Skfp40w2f9IwJM1CjICl8EFl5CCmnMu4i3e+iNVXjHFiC6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwucWGtSvMKfW8ZwXM6TJ9iDjgW+ZqsFihgHBODVD9AJFqD9GJE
	I6nb6A2z6/P+jHcaoPuH5zXf2XLuRFLH1RujRS97iPYpoHLg91q8F6XWiRflAo+3TM7JUa/LaPh
	sIdGx3OADBRlwGURxd45xSKWM4O2kdo9tf4vYPKLFczrWouiJvpLnVA==
X-Gm-Gg: ASbGncuPkLTkRLIyhXrefsa07OKen3/DGmSwoiDOg+l3YdW7wWkzet3nN28FwkisC0N
	RLgADKWhivH2WGd6kKTPFuMRpac+B1qO5G8OF4G+Wi4b0/6Z2Z87zSmnX3cNoS7GKHtgi4dacNc
	wO+al21Clc0ZbzXBOO2gSZHP2QcVtx2RANNP2Emv7M7Dx++JBU3q3JuUTp+oi/kaRxQ0yo1Cg9I
	u75cx7nYyKT+I+VpYZT5o1PNw453jurimjhS1cM38MIc5o11ouX3akpmEbCMAKjN0UmFP95Ker/
	5IZW/Cf94w==
X-Received: by 2002:a05:6000:1a8d:b0:397:8f09:5f6 with SMTP id ffacd0b85a97d-39cba93cd39mr15652803f8f.47.1744112983549;
        Tue, 08 Apr 2025 04:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+o1zR3VRcPlBcclW24I6ljtmxJ4Chpl0YFxpgvpmk6R76rTIbQ1hLofb7K+neh4PaWzsX0g==
X-Received: by 2002:a05:6000:1a8d:b0:397:8f09:5f6 with SMTP id ffacd0b85a97d-39cba93cd39mr15652780f8f.47.1744112983180;
        Tue, 08 Apr 2025 04:49:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b69c4sm14561074f8f.43.2025.04.08.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:49:42 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:49:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	David Matlack <dmatlack@google.com>,
	Like Xu <like.xu.linux@gmail.com>, Yong He <alexyonghe@tencent.com>
Subject: Re: [PATCH 0/7] irqbypass: Cleanups and a perf improvement
Message-ID: <20250408074907-mutt-send-email-mst@kernel.org>
References: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>

On Fri, Apr 04, 2025 at 02:14:42PM -0700, Sean Christopherson wrote:
> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a *very* simple concept (device signals
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
> To address the use case where huge numbers of VMs are being created without
> _any_ possibility for irqbypass, KVM should probably add a
> KVM_IRQFD_FLAG_NO_IRQBYPASS flag so that userspace can opt-out on a per-IRQ
> basis.  I already proposed a KVM module param[2] to let userspace disable
> IRQ bypass, but that obviously affects all IRQs in all VMs.  It might
> suffice for most use cases, but I can imagine scenarios where the VMM wants
> to be more selective, e.g. when it *knows* a KVM_IRQFD isn't eligible for
> bypass.  And both of those require userspace changes.
> 
> Note, I want to do more aggressive cleanups of irqbypass at some point,
> e.g. not reporting an error to userspace if connect() fails is *awful*
> behavior for environments that want/need irqbypass to always work.  But
> that's a future problem.
> 
> [1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
> [2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com

vdpa changes seem minor, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> Sean Christopherson (7):
>   irqbypass: Drop pointless and misleading THIS_MODULE get/put
>   irqbypass: Drop superfluous might_sleep() annotations
>   irqbypass: Take ownership of producer/consumer token tracking
>   irqbypass: Explicitly track producer and consumer bindings
>   irqbypass: Use paired consumer/producer to disconnect during
>     unregister
>   irqbypass: Use guard(mutex) in lieu of manual lock+unlock
>   irqbypass: Use xarray to track producers and consumers
> 
>  drivers/vfio/pci/vfio_pci_intrs.c |   5 +-
>  drivers/vhost/vdpa.c              |   4 +-
>  include/linux/irqbypass.h         |  38 +++---
>  virt/kvm/eventfd.c                |   3 +-
>  virt/lib/irqbypass.c              | 185 ++++++++++--------------------
>  5 files changed, 88 insertions(+), 147 deletions(-)
> 
> 
> base-commit: 782f9feaa9517caf33186dcdd6b50a8f770ed29b
> -- 
> 2.49.0.504.g3bcea36a83-goog


