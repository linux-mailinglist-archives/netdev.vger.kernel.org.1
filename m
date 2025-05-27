Return-Path: <netdev+bounces-193671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B423AC5094
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2AF176986
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A49278E53;
	Tue, 27 May 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itjyUriX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BD277808
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355263; cv=none; b=m1+haGdWMZOTuDT35juShx0ZJtEuhhFqAcZoPjMRGumL4lu0BLafw2svi93rsIMB9oGaJhPaG4kD3K2LHhWNj5u4BQ+CxPGA4WqcyvrR8gglgSrOcG1ShYyn37m1lk3zlA9yvyRlfHGz9oftgw4dER8UV5KZcswQqmQNI671E0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355263; c=relaxed/simple;
	bh=uGDxL6NoOAWqEVaEuf37LGjdZ3OBf8FaUrRF5Pz5lAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRKqHr9mBsrDk+dmBs/2epbDgzpZsV0wVEMq5MDK9AXGGmfkMkLEul6hCeSN6W6tOd9j96HkUVnPkZJsDoac5VXDarpjvPcxopKhJbyXG0ZqEuMfSicipCDpAKgwHdYDNz9J+E5+sARjwsnevB37wXMLtLZW8EquvE2TeK+oixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itjyUriX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748355260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJboAKDayZ+nUPKd/wLjGeoCMi+C4va3WlmfVaYSkrY=;
	b=itjyUriX+lchTIEAU+DfcA3NxeA0HdIkYcAyjR0in/k8SJVvY0UQPkY4fMuchmYASmHPiY
	tPeF2UuubT2CQ/u6hYfCEOYP+1nhQuVOIvrHXyzITi11hqZOuZC6Sej8pZCRXvmjwxIt0j
	grFuzJNCZkeSbCCnYffa+Op+c65oaFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-IXHlEhuMMPGc_9d5_rx7YQ-1; Tue, 27 May 2025 10:14:15 -0400
X-MC-Unique: IXHlEhuMMPGc_9d5_rx7YQ-1
X-Mimecast-MFC-AGG-ID: IXHlEhuMMPGc_9d5_rx7YQ_1748355254
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso28687225e9.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355254; x=1748960054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJboAKDayZ+nUPKd/wLjGeoCMi+C4va3WlmfVaYSkrY=;
        b=UU79f7p6Erz8X9d6jF8aGICHtd7btyVmLYFqWtJM0Ben6oYm3MaVUugEtKyH9/J4mS
         Fj0L5wAAL+VSQAjvLQpULLFwgaOjxo91JzY908xYLEtSk4UPA7H3YfRqwvRFsp66zB6G
         tFuooKy+lTFwXYSheC+0dPUfQdVuvtEgSzLhNkz6ae4riH5L7/q6nuiwnDcans681IVf
         U8NtxXCYWEZmHBzbPGZmlP5OpuTKRgj0m0hXAxP8PL3NjItvxGGKqfuJTvkJOa9VpTmb
         0Emphwz9GzpzJ528F76656m+K3COIV5dZ3tGGP5CRzyQCv7L35SDvBjagl1yf/OWHGAd
         WC4w==
X-Forwarded-Encrypted: i=1; AJvYcCXhtUb6TLZZeFLIUU44rjLHXZezj4G6YS85bo5WzqBPJkjcX/SK3bfP/A5QLnc2aiFO6jQLp6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJi3OJP+qSqkdw6dtaZVNyZ2KUi010NxTngvEfji72moTb0Aa
	0IH5e91BAU/oHCtyfy33xFLZSk8vuroSwZ9mgjhdQ7cETaZoivaq7w3sE99C4TQPqMpzvSsLc+G
	5oSwDqRy+dF49J0EtYe7UkUuyIx+bgJowfcVfFI7A5SDht8R9fnVm0bK0bQ==
X-Gm-Gg: ASbGncv8oyNpdbqhdoCaD/tRdhAJDoJ0hyGrO39AhswebHy/5egwXTdBSAfhuRsVDUT
	SBGdEkjRJCCNAFCQ0lCVDIxaoUfE7kdmexTnPdc6LWcYR9ZWcwFNAwor01dkGXX3mL5cJIsk5JG
	ztIKEMYEjKhqLC4wNMYNvkxpBB9I6gpLmbw7mHtdzNZtGSMRxw5SH+AGKHQi5cvEkGVKR6cRcZj
	TKv7aTe6PeBuQB4IIFRPfrnsWIA2yf1UW7y7B/VhMc8e/kM4dU+urzqrxpXJd0F9JAFmj+SE+Xj
	kIPeHw==
X-Received: by 2002:a05:600c:c1c8:10b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-44cc0725a12mr65102145e9.27.1748355254399;
        Tue, 27 May 2025 07:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAoXhx4gZIoeK91icwDDWTluoykbi1Qz6GgjYz88NE8Ydk1cFgciKX/AoC/psNetPTRi8NFw==
X-Received: by 2002:a05:600c:c1c8:10b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-44cc0725a12mr65101895e9.27.1748355253919;
        Tue, 27 May 2025 07:14:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0556bsm268010055e9.12.2025.05.27.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:14:13 -0700 (PDT)
Date: Tue, 27 May 2025 10:14:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
Message-ID: <20250527101312-mutt-send-email-mst@kernel.org>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com>
 <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com>

On Mon, May 26, 2025 at 09:20:50AM +0200, Paolo Abeni wrote:
> On 5/26/25 2:43 AM, Jason Wang wrote:
> > On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
> >> new file mode 100644
> >> index 0000000000000..2f742eeb45a29
> >> --- /dev/null
> >> +++ b/include/linux/virtio_features.h
> >> @@ -0,0 +1,23 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _LINUX_VIRTIO_FEATURES_H
> >> +#define _LINUX_VIRTIO_FEATURES_H
> >> +
> >> +#include <linux/bits.h>
> >> +
> >> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
> >> +#define VIRTIO_HAS_EXTENDED_FEATURES
> >> +#define VIRTIO_FEATURES_MAX    128
> >> +#define VIRTIO_FEATURES_WORDS  4
> >> +#define VIRTIO_BIT(b)          _BIT128(b)
> >> +
> >> +typedef __uint128_t            virtio_features_t;
> > 
> > Consider:
> > 
> > 1) need the trick for arch that doesn't support 128bit
> > 2) some transport (e.g PCI) allows much more than just 128 bit features
> > 
> >  I wonder if it's better to just use arrays here.
> 
> I considered that, it has been discussed both on the virtio ML and
> privatelly, and I tried a resonable attempt with such implementation.
> 
> The diffstat would be horrible, touching a lot of the virtio/vhost code.
> Such approach will block any progress for a long time (more likely
> forever, since I will not have the capacity to complete it).
> 
> Also the benefit are AFAICS marginal, as 32 bits platform with huge
> virtualization deployments on top of it (that could benefit from GSO
> over UDP tunnel) are IMHO unlikely, and transport features space
> exhaustion is AFAIK far from being reached (also thanks to reserved
> features availables).
> 
> TL;DR: if you consider a generic implementation for an arbitrary wide
> features space blocking, please LMK, because any other consideration
> would be likely irrelevant otherwise.
> 
> /P

Let's just say, I'm fine with starting with this, and
we can move to an array later. The nice thing here
is that there's this typedef, it can later be changed to be
any struct at all.


