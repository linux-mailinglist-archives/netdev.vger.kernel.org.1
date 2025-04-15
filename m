Return-Path: <netdev+bounces-182836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12297A8A098
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D0189E22E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBECF292908;
	Tue, 15 Apr 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKxb5ptz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FC1E1DEF
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725892; cv=none; b=fwhuuh0USZvkHgLbmm9nCFMck81Yjaxc09GSTJi2QKwnqwuekMxZPWFkwi1NzMBPRk9RzUO4MZ1eVwgt0Nmo8CmtulCvPxDlLBxqm5aq84Kp8oUqG65ues6bvK7xaiRIm5sytLV8Bc7CD8xykKaluykV5/xgkA5lCVIahHYMWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725892; c=relaxed/simple;
	bh=QXP9FxMrw7KNSGwJPkQN8Q4+F9sKVBVOP6V3LiUSFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neR+m3dmplBhcMss33gEpLxsQMR5hDMMVRmMQ6pBpiBytNRFqzVPsYDw7vEEVo5/AZ42CoVTpA9ToCLPtlQti10ybFmsXM0sqilIH0b1Q3ZuBv0gfR9imTmM3Kp0GOqbYXxRz2CSZFVikvoSgqE9SL1AQ8rszQOdiJNXCIAkOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKxb5ptz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744725890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJjI0lY/xyReq3ZmWkhvSF6/rYPEyl6oWq19qSKGU2Q=;
	b=BKxb5ptzYCieGjbhUBpuISLlRTjvhxhXtdxZTgHmQf43cyAOnm2dRBLFH56ZhaI0kHb4g4
	0ibdiTKEMUOfg2uleC+LGKTdP+pwH7cR56SZLE4afWiYEJMyLaD6xSIDLIrnAnpb0tE9Dk
	0ZfvbVmcHe9jaHxZkfRqvCA3/TTQ0Rc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-T0-ziyGyN-m6q4g3-UVRwQ-1; Tue, 15 Apr 2025 10:04:48 -0400
X-MC-Unique: T0-ziyGyN-m6q4g3-UVRwQ-1
X-Mimecast-MFC-AGG-ID: T0-ziyGyN-m6q4g3-UVRwQ_1744725888
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d733063cdso45650495e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744725888; x=1745330688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJjI0lY/xyReq3ZmWkhvSF6/rYPEyl6oWq19qSKGU2Q=;
        b=LGhA+zLkRfY1dsfYVYr/pdWXInrjsK+16A11GShrrAhheDoWzvhqtt2seq9Cx4e9Y4
         76DnV8kqOCW/RVHU3Ayds+AXBs6npNTsRF+BJ0f+MAhajachRF+jCdEAb3yaFB9xS82V
         2E0OyUuAh2+JXiy8Oai6qeBEsGqHmfcORxBmf5osDxHCvFAnOAXdlGUpq293lbJVHsoI
         FYgfHrsWNlESloLcRVE8ZmknDt+2WRR7LNGhn/4dr5gR5l8KOMtQvMc8AbuxnUkBfQfa
         h4EpViuq0cOYICG7F54UzfGS57h1Zr9Zh45r7RUzVkOK2uUMAIOS1phRfhFRuZkTkZuH
         2tDA==
X-Forwarded-Encrypted: i=1; AJvYcCX5/cPCZdpls0JaL9sgXgQ/BdtPKyNzQSxINhX7lZjXCoeDxjjIU36Ehy5rJLe9ESuUayWaPPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqpMJlkaiwUrR2wvQjipOZVHrp/XNlX0uNrIw64ih7WuaTwehT
	5QVweVTnxoCT4TAiisNFMTL4Jw2pQfap/CcEx+K/1amv283z4VpvUMZsiYwq64evLv3AIuMu7Yp
	DxGtrU0s/SAVRpGMIrTIIAIF+VpH5TjcwKbH36jBfY5atcTJEcMiKbg==
X-Gm-Gg: ASbGncvPdOhNVdEP7QM+qdsVsjaXAa+rOZhvBUQ1LQKkKy+Ey4+s4YQx6yUgWBJlbAQ
	pbTtrqd7t30LUZCM39OCneOpngSK2BsEMBD4h22xwDORcgLTBtnfmjXqOeGR2aCrUAck7Iu4tSP
	tNuNnUSOzJjzcaT7nr7vow4Nf6tRwLwRPjQnQaxjW/zg5h+g9ySwU1QGa2GKPEGBmaMbBu337wj
	wJ2saLbgKxMJJqz3OOKsnqAaaMVZkcI1sRFc64Lb7J7mxdQtFX7OGK6ttl4xa2+m8pXPoYQ+WEP
	XvaBIQ==
X-Received: by 2002:a05:600c:3b93:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43f3a93ce18mr130332835e9.8.1744725887401;
        Tue, 15 Apr 2025 07:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHITYoM+E4rIVBkVC+Zy7bnyx80+fEMQuQMdwZhPsCxD1+xYR+TZ77Lv7xvd8u4v2RkPh0L7w==
X-Received: by 2002:a05:600c:3b93:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43f3a93ce18mr130331785e9.8.1744725886545;
        Tue, 15 Apr 2025 07:04:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ed041sm210253075e9.2.2025.04.15.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 07:04:45 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:04:41 -0400
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
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250415100425-mutt-send-email-mst@kernel.org>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415074341.12461-1-minhquangbui99@gmail.com>

On Tue, Apr 15, 2025 at 02:43:38PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This series tries to fix a deadlock in virtio-net when binding/unbinding
> XDP program, XDP socket or resizing the rx queue.
> 
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi. When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
> 
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
> 
> This fix adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Bui Quang Minh (3):
>   virtio-net: disable delayed refill when pausing rx
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add a virtio_net deadlock selftest
> 
>  drivers/net/virtio_net.c                      | 69 +++++++++++++++----
>  tools/testing/selftests/Makefile              |  2 +-
>  tools/testing/selftests/drivers/net/Makefile  |  2 -
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  .../selftests/drivers/net/virtio_net/Makefile |  2 +
>  .../selftests/drivers/net/virtio_net/config   |  1 +
>  .../drivers/net/virtio_net/lib/py/__init__.py | 16 +++++
>  .../drivers/net/virtio_net/xsk_pool.py        | 52 ++++++++++++++
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../{drivers/net => net/lib}/xdp_helper.c     |  0
>  11 files changed, 133 insertions(+), 17 deletions(-)
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)
> 
> -- 
> 2.43.0


