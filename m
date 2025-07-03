Return-Path: <netdev+bounces-203706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D697AF6CBE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB8016894D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264122D027E;
	Thu,  3 Jul 2025 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjV1FxQY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB3295523
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531041; cv=none; b=ObujlhCBwdF5NwVHV0Xtt/Ik43+gyPouJz1/JFAx0+nSzgroWPgDgsTGpscfuZXJlSErpqu4mHGUkhUDa/7oNZ/wcy6FvHx5VND/KkLu4J59aS1kzfI7LtSrrAyTiEVEFE877V8XIHVVtDk8QUdyRzbblDb8/J+TpGKyrClpfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531041; c=relaxed/simple;
	bh=o+NkW4UjRCYC3Ox02bP9Grs2dJLcAnd5IKgqdCW1eLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHI9QuVBqtXDInKqAg3HiLVjEJXbTlyP4O1O9ENX5yZBe2/coHm6Ax74Ge681pk2lA4VSsGtebu8FfSKR1YTNOc5oaVy+MxCvVESEDMypc6BY3tH2FMcniyemru6v7rC7phzqL+gHCtjthzYAIGZCMowtcNGo2+yYjiJyvo7TVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjV1FxQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751531038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ke2YfmZqQvuyIhOn4BkIuW587OZjecPx0SDiI46FKLs=;
	b=UjV1FxQYOzeF7AaP7vOQxhOdSUUWce/+WMEvzwcmzefzINybr07xZQJwH/cVFANv1AnOcr
	CT0xHJ2sW64nBBwc1uUWHjLqb9YANr9kNXaqr0aUOwKMLnG1MhpDZbOej+vGO8wdn+e39b
	xEeLx1aR6M1Y1/1GO/BXmg/evhUXJLk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-GEV2yYpwP6u5TyY__p4qlg-1; Thu, 03 Jul 2025 04:23:56 -0400
X-MC-Unique: GEV2yYpwP6u5TyY__p4qlg-1
X-Mimecast-MFC-AGG-ID: GEV2yYpwP6u5TyY__p4qlg_1751531035
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so3573846f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531035; x=1752135835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke2YfmZqQvuyIhOn4BkIuW587OZjecPx0SDiI46FKLs=;
        b=s6il8cLZmiTFDJ9jTPuuD/1kJSz30DpeMsou5KaftZhxcJLVIIH7tWnvQPusX8SeUn
         sn9zcRR1mGZ63XIRxju9F/PJ31kebmCNXpjsLGvMTjiCo8SpubbvwVVWpZR5pf3T7726
         Vbna47nIts3Ltf1Vi/IIOa52hp3gxMzhfyArEiUjPze3UD5bwvy+zgFNwsNuHzB2CrDu
         WPT99M71qRMc9xWaiiRuOH4W6MKSiFOTilWk8Vh9QDAjF15rzi4QhxNtp9vo4PKyCq/2
         qLdcKp/t3aPXUIOyeaSjZpYZsWnrtAhLzCRTqJJhN5548rq0HhSDXYdtF0bpjr66gw0J
         2iGA==
X-Forwarded-Encrypted: i=1; AJvYcCXcqZhXPVq1xTVCXlkC4MOX1ms5rzyQjBHWN8f3B9lC1pvg2QYuxgi5n5TMGFzkd6nLWfJXfko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgX/SlPq/6fc8TXDmjK8f1YPxCVopzcf7Vvru2WXhk5VEnlZox
	mBCV+VtISi02ToKpV/CtcTHKE169BP6WcwhMf5KRbwfcUdr+E9qihJbU2vosTKnEbEGILhCzjbu
	mHX5neg0fP5t4HJde6CYmb9wdESzu8DmYfd9ga5uOb0Nyi4gWjtyPpSifsw==
X-Gm-Gg: ASbGncsAStk2Z/Ha8yk4aGVEBNauLfMEvNe8t8gqf5asJj6rzwkMrd3wzB3dkEb/EbJ
	PXrnYJu9EN41GhOOIj1HW/wYXHxOIwMxUrLEVIfah1jQRHAvXrVAVFkRN7IUbXHh+wBAKxYfGyx
	6W8j/23R/HIE68YYhyGomSJVTfmHETbkxvPZ3IEnG3Vt7QGBk/gPZLfslb0A4rkxcxBIId3ryrx
	cxk0Z4UlMfYlFD8Uyyfr2hRcZpGT1kAgjaO0RtFd5Nlq2e7EMKABRr5ezBIBwpwSRhLQRan1NK7
	4TddJuCBsU9XyqmcIqhGYqyjvDI=
X-Received: by 2002:a05:6000:18ae:b0:3b3:9c75:c4cf with SMTP id ffacd0b85a97d-3b39c75c60dmr972426f8f.51.1751531034880;
        Thu, 03 Jul 2025 01:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCYV82hCMNv406EdS8av4JOq7IBDVQLti9dcL/h1KSI+kswFV5uEQ+Wn0KudAapNB0JCaiDw==
X-Received: by 2002:a05:6000:18ae:b0:3b3:9c75:c4cf with SMTP id ffacd0b85a97d-3b39c75c60dmr972392f8f.51.1751531034265;
        Thu, 03 Jul 2025 01:23:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f92esm18167611f8f.90.2025.07.03.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:23:53 -0700 (PDT)
Date: Thu, 3 Jul 2025 10:23:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to
 check also `transport_local`
Message-ID: <34n3no6ip55yftyqtdpww6jzsse4mhnk3pjmd5sfqhpp5nt3my@wiql5wlf3zzp>
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
 <20250702-vsock-transports-toctou-v3-3-0a7e2e692987@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250702-vsock-transports-toctou-v3-3-0a7e2e692987@rbox.co>

On Wed, Jul 02, 2025 at 03:38:45PM +0200, Michal Luczaj wrote:
>Support returning VMADDR_CID_LOCAL in case no other vsock transport is
>available.
>
>Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9b2af5c63f7c2ae575c160415bd77208a3980835..c8398f9cec5296e07395df8e7ad0f52b8ceb65d5 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2581,6 +2581,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 		cid = vsock_registered_transport_cid(&transport_g2h);
> 		if (cid == VMADDR_CID_ANY)
> 			cid = vsock_registered_transport_cid(&transport_h2g);
>+		if (cid == VMADDR_CID_ANY)
>+			cid = vsock_registered_transport_cid(&transport_local);
>
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
>
>-- 
>2.49.0
>


