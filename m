Return-Path: <netdev+bounces-246196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A3CE5833
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 23:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7871D3004B84
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 22:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE228D8D0;
	Sun, 28 Dec 2025 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPetPV5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599781C3BFC
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766962147; cv=none; b=BYSmvTtf0GWcDq6h0ovtzGR3APgWhD4Kkcq5NVTmuWvF9L67F5m1C8aRNi31IMbHdHUgpt6xta4K7++NHQTC63engs2OHuUodG1q+nYPYzzQtHrNHRirYzp3ER3KvXvtFgHoPD401iMzCsHZ0fLsZryrN5JptNDmKQTqyNFl1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766962147; c=relaxed/simple;
	bh=7xs7rBHCkEu0qSnjRBBkrDuWcff1dR9koDAyagfZn70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQpGIa5N/lueDD/XBYEyZXkk1PB5+w7vsKCjDNMy5/57xfqDVd3b24oTb58PstDN/W3/I7L86BlbSJBtNbObD/uGSCslT3mNjE6LBs5ypwbcy0HyjalumbgJgNN4y6vliPm5y9dorjrb9G3e6nsKnJQkc7vK55XnnGnuo8ChDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPetPV5i; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f1bc40b35so146215455ad.2
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 14:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766962145; x=1767566945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnVxB8hHP+UEx+EyrlcIpTFAKkUEwNTCu8Of5uWFpkg=;
        b=nPetPV5iEOKTg1X99grd64geyoYpeN4Aexbgs6Ab9dSP8ku/hSCne77nN4ic/KtHRe
         QeF1BxOq+zpVNa2hBhjMcTITqfxM2j5YLOqjp6vH4Scp5HIheECDkIxseNuIm6q88mYT
         5zfL8LAEMuihdNDx9B4KvoZb3yjGgnxApFfOxPfh+Q9KuWncQDcYv8MQ9Ct6cOCzC+Pu
         3HZjGlpZlLVZ7rZGQ3FYefIwvYTa+1D8y9Cp2d62mqDY1qxN670qHTEyhdA7kfklSyTg
         wr7bxMvXOAUeXPnS/N5fUg1zIEFh3EY81RoXkJwdDrUgI1H4J8UYxFbg8iLF9vohSa0M
         KNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766962145; x=1767566945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnVxB8hHP+UEx+EyrlcIpTFAKkUEwNTCu8Of5uWFpkg=;
        b=GkzTOETEivIzi4Hwl0UW8ZvnxtxT00lR53LPeZUfR5Qa6AsQDjUoWS2PYzJ0nUmsZ5
         zp3VHhdrtxx6uOCqSo5O+/iyTcFcuN0FkcZi4HOHWCT5kw4O/VT27d//AbWCBI4rOVhv
         AxN9XKFJL2S/vv6jUv3ZLH6QOYQ5pvhksfJPaeTFiK2hpmlkvQsgp7wDlARt19RXsHei
         dzbBSWw3kM6uC9dPaYn/HxnLzRi55gu7YE0MwM77+zimJB9PbSs7H0XS3Sx7hWLPnPkl
         Je3JGvWNPWF6FYVl1ETyhGi+1kWJvEg+AXBwYkYFR1WMbV1g+RC/M7sWj/tOLNS6rNdk
         g/dQ==
X-Gm-Message-State: AOJu0YyPD6nNOATel2w15Gy6yfIp1Kgj5WKY7TqL5+G+O5VrdTxe8kRK
	lScWSyZEjUq2poq45iyigt6DE7TYh3LkN7iVdvqPRLepfNttd6lIgi3l
X-Gm-Gg: AY/fxX7zzkpZ7mx4E7Hc8IJONxmwahlALxxx7rwuPkMCL1ZT7jIcktf33ROKBLwwCPN
	VQBO4BBaY9+2Drgx47BPGZv1UNHoHuDadYqk9iMsvAiPtoXXY6vIWaUKc4bGkLVoo+pwNKjb2sB
	XNi/tuZ42VRueH1fJS+5Xi5WWfxdIrTY98vBGvPsZbMlwil9c9vChqb2CnxNZKNBGB8NomKQ1uY
	A6J4m9eV0BHxCVT1Xs5xT9ws6yvvJHZxLlbnK31LnUYiPXDiM8u0FKAkuLVk74PrwJws7LVTN4D
	PWL8GYNtmolr6XJSNAmydwRZS4TEAsRrWy9lEz0gUG5imXpWuMDvE36ac4M1XgGcfOi6bVNTO73
	lbSB9FJTffx/CEjV5sa54YZIrItslV+X/kT/T4qXfXNbDbu3I46NVu8g2jpWjGIeKoRdxB1mlr/
	qv+l032pBpiQTD9Eg4
X-Google-Smtp-Source: AGHT+IFrZ0jqqyfa4w9leqRMWpvEB4wvR96T1u2WwgRjWIQZDJOokmhOcBM1uE4s/VnzQJrZGEFtuA==
X-Received: by 2002:a05:7022:4284:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-1217230b84amr31429073c88.48.1766962145520;
        Sun, 28 Dec 2025 14:49:05 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:79af:1f76:2f9:193d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm83886095c88.10.2025.12.28.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 14:49:04 -0800 (PST)
Date: Sun, 28 Dec 2025 14:49:03 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Cong Wang <cwang@multikernel.io>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix DMA cacheline overlap warning using
 coherent memory
Message-ID: <aVGz39EoF5ScJfIP@pop-os.localdomain>
References: <20251228015451.1253271-1-xiyou.wangcong@gmail.com>
 <20251228104521-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228104521-mutt-send-email-mst@kernel.org>

On Sun, Dec 28, 2025 at 02:31:36PM -0500, Michael S. Tsirkin wrote:
> On Sat, Dec 27, 2025 at 05:54:51PM -0800, Cong Wang wrote:
> > From: Cong Wang <cwang@multikernel.io>
> > 
> > The virtio-vsock driver triggers a DMA debug warning during probe:
> > 
[...]
> > This occurs because event_list[8] contains 8 struct virtio_vsock_event
> > entries, each only 4 bytes (__le32 id). When virtio_vsock_event_fill()
> > creates DMA mappings for all 8 events via virtqueue_add_inbuf(), these
> > 32 bytes all fit within a single 64-byte cacheline.
> > 
> > The DMA debug subsystem warns about this because multiple DMA_FROM_DEVICE
> > mappings within the same cacheline can cause data corruption: if the CPU
> > writes to one event while the device is writing another event in the same
> > cacheline, the CPU cache writeback could overwrite device data.
> 
> But the CPU never writes into one of these, or did I miss anything?
> 
> The real issue is other data in the same cache line?

You are right, it is misleading.

The CPU never writes to the event buffers themselves, it only reads them
after the device writes. The problem is other struct fields in the same
cacheline.

I will update the commit message.

> 
> You want virtqueue_map_alloc_coherent/virtqueue_map_free_coherent
> methinks.
> 
> Then you can use normal inbuf/outbut and not muck around with premapped.
> 
> 
> I prefer keeping fancy premapped APIs for perf sensitive code,
> let virtio manage DMA API otherwise.

Yes, I was not aware of these API's, they are indeed better than using
DMA API's directly.

Thanks!
Cong

