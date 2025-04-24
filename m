Return-Path: <netdev+bounces-185500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60766A9AB57
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF304A3425
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31A227574;
	Thu, 24 Apr 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqUlq72/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECB224AFB
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492598; cv=none; b=oT0+daF0Bov357rRkrE1iQbtJ9Ar+hEs6poYbHnlCMcKwApGFY5bJGdGc7C9d92jf3eFmcjgOh40vqNuw5Y/dX9mEIaI5FIu1r5ogr614t3SdswXctrjfc7pXYJePCxPbTsCkULvd5xZ1h0G70hHotq3V683jc9TBWqws2vU5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492598; c=relaxed/simple;
	bh=OnEK4+ktkuTBVd4LCgvO2/u1sSZlYN0t7X50RZpIPls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl9GpEVhEltPjxiBeVBijWnhFilIA5o4qVvR33EWPtHQo0uwf3zplwDudPxZjjXNHFiJc7jMHyHLpoNi33kN7A8BpR5K8VbJNVNIAtczjHbpQ53/i+bh7mnlR+0SKrMQWeDoDGT57qOvQ+IaPNhrkAVxbyULqKgbtp3IJay7QY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqUlq72/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745492594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OB+hDp/hkN/T5Zk53qLd2kwTdWBUeriKnar6WFmgAY8=;
	b=OqUlq72/cnUazuGjA5/AyJxgUHDrGr7gB8aizfTto6uoUVylNRokKp8es3Le0AJGBYOyak
	veQOMSDCLwSZuMeUzY3DkdGrIN05bxBT4XymdK7tz84Qyx5dbiKRCuVU4zGX/w9rQbvDyY
	tqMHzr/0ocDOkA50xovEqJZAiOhHHbg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-8-9bOGZUPeWtpZCJuXtZJw-1; Thu, 24 Apr 2025 07:03:10 -0400
X-MC-Unique: 8-9bOGZUPeWtpZCJuXtZJw-1
X-Mimecast-MFC-AGG-ID: 8-9bOGZUPeWtpZCJuXtZJw_1745492589
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so5423135e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492589; x=1746097389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB+hDp/hkN/T5Zk53qLd2kwTdWBUeriKnar6WFmgAY8=;
        b=Z9qdX2Fea6AV+UW7cTizpPg130bXn/28fwkhJqoSt5sFbaxsBMco9+ZFblBnCTyH63
         PC1VMttq3jw0jmhsQaNyhOVqStEE3MUHcnFKUAsUeupFt4WO37EpaVBG6fubAtuIvWc4
         yk1L23FrAFuwq+Qao9GikJ08Vwk7Kgy0/BoI/EvfwvnPvrglHMnBbZzSn28m2BqYnCTa
         gujERNBaZV6W6FNgmpgr/5PIFfAiqdcUfOP+QGCgSquAveHORtQ8RtTR/7hKhKLSY4GY
         IyO2UiQCTW8Fgg8GXJQDa45BncgYrhLzrjwSXJYYXa1TmqalFUidtMstrYXCYlxMSbEW
         1r1w==
X-Forwarded-Encrypted: i=1; AJvYcCXrCuSANq9znqQwu1Ag7ZQDwVZersIhshQqeFbXMJMcEk4Vc1DYqgFYH2OlvT7legSlmZa0bew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FE3O0qKbNdQsIH8wC1BixVab514Y121RlVYClHByyTUYdMRh
	RusHEEvHyAL7dXgTZYaAQw4C7/RRqCt1lTWrtxTocfMwlYvXMajurAvb4B3A6n3Q8Gp61bNHBCk
	2N/JLXwgzaSOSDR0aspfg65OVp87vsUx+16aVIeA29zRnqwvz3i6PxQ==
X-Gm-Gg: ASbGncsFAvynOg+L0QbOsGXh0CYD3Vi6jAzt+TqvecQDHXMMZdWR68UhFOUzaBIOOYV
	nd8hqPHBAO6Cf84L58ff30lio++K9K+/3lPQzhhKdLfggTw9KbVajAVV04zVwdH8cQwDy467Ee+
	aihd5j6T1rh060kKPBbwcZWyg7NrhBAanXBRji7IfU1P4ZnlfngP4yn0nXemphnCVpR/YdgLJFQ
	42Hx9FMxaX8/V6Y/2NxxbIsKezuITxTcN1x85mXUfJMHGOdT50pcIgSosOf6Yg71o+jujK5h2YR
	ayDISA==
X-Received: by 2002:a05:600c:3516:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-4409bda6055mr16048805e9.25.1745492589460;
        Thu, 24 Apr 2025 04:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtu0yCr7M7AP7EC3ZZSx9xsMrsn304Zj6V6BYFUjfak8chlhsmlR6+Poqw3gaQbMFvkrartg==
X-Received: by 2002:a05:600c:3516:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-4409bda6055mr16048345e9.25.1745492588928;
        Thu, 24 Apr 2025 04:03:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d839711sm57806515e9.0.2025.04.24.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:03:08 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:03:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250424070300-mutt-send-email-mst@kernel.org>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>

On Thu, Apr 24, 2025 at 05:47:13PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.
> 
> Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Version 5 changes:
> - Refactor the selftest
> 
> Version 4 changes:
> - Add force zerocopy mode to xdp_helper
> - Make virtio_net selftest use force zerocopy mode
> - Move virtio_net selftest to drivers/net/hw
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (3):
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add flag to force zerocopy mode in xdp_helper
>   selftests: net: add a virtio_net deadlock selftest
> 
>  tools/testing/selftests/drivers/net/Makefile  |  2 -
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/xsk_reconfig.py  | 68 +++++++++++++++++++
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../{drivers/net => net/lib}/xdp_helper.c     | 19 +++++-
>  7 files changed, 90 insertions(+), 6 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (90%)
> 
> -- 
> 2.43.0


