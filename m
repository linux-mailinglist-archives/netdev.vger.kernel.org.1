Return-Path: <netdev+bounces-142308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DFF9BE2E3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901DF1F215A4
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5231DA63C;
	Wed,  6 Nov 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnDm0zCU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82F1DA31D
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886134; cv=none; b=WF3C9xWV2aHSmGJhaYBZsq++5zrSCzfoHrMd0O4kecNhY8JsJHmjrvkHgfJgAPViZUo44JBJ5SQsXVBNt9kJ+YZ8vq+aJ5skAmUDnIxJ7l0KKmH8mxzYW9Jaja+N4h0XLRv4+Fe2tdTbZl1913ZgkMRNKIwmAE4uI/RhiJsZMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886134; c=relaxed/simple;
	bh=eJnazqtfisg5f/3fPRDD9Fy2ZdH6bfCsFKpXlRHSPn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcfiR/53N5YzEZssEc0SBMg36ButNkxlLcAeG4VBRtD72qYvTZqIeT2ivVxA7R8xE8UkLIyoyqB1oW45fgzhkJIL5Y3+1mDR2edfRS9g999l1MUlWsolW6XNBKLYxrkD1LoVkh4RrZd1F1hAv0QZMRdzgUgn1IqI9h8Y7c7LZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnDm0zCU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730886132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTb9RMAx8DKPix4c+Y4T2Jp1EEKIyizogKHRWnrW5Hk=;
	b=YnDm0zCUBfKR/vaXIM2kEPoLtXIp7DpbyEQPfs2vhbK2Fl7XgDfMzITPjsoXHfYXFxkfmW
	rbtZGVluqHY8rcQNyRAFiZlGW5qutMdTQ91Iev7WAtLdhUS+sAtrJGtf6/vqse/owv7i5f
	TJSCDZAQ400km/5FuvemfILqRR/CqNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-1x6hvuKZNOSfsatEM8fpcg-1; Wed, 06 Nov 2024 04:42:10 -0500
X-MC-Unique: 1x6hvuKZNOSfsatEM8fpcg-1
X-Mimecast-MFC-AGG-ID: 1x6hvuKZNOSfsatEM8fpcg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43154a0886bso43799315e9.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886130; x=1731490930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTb9RMAx8DKPix4c+Y4T2Jp1EEKIyizogKHRWnrW5Hk=;
        b=hxS01fDX/ULI0oN4OlXnc1cPsq0P6q/19/5GoNhVP1oOg1+2+4kyKRTVUljcmmldIN
         6/qgZBqgdTBK+Qp8rxVl3ubhvdzm1ljVtN3/FYHADZmT7fRAfg/pOU2CC4CakUjCYaip
         5G8ugdmVSau3r0dNfHnvlMLwMLLsUjvqDnE4jpgWT+rxRvJ05IBeom7T4VPF7bcY0fqK
         Ay7dA1MJi412haRSz5+RbOB/Jz895wCxbnRZpysJiyAcETQoDxr2ObQodSBA+Upp33Pz
         O4IBmaCT9gFIAidb9xLAy7UJVKGnDxIZMqGmQj63rylwHcErzdYPNQPLKZn1zFGVFEbl
         VJJg==
X-Forwarded-Encrypted: i=1; AJvYcCWoFEDcPBAg0lXPTxi1INTz+rYfWoUqK2XWvnIYK7vs7LIHQEPOTjRG7ceJXtrFJuNBVlVwW20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAd5Yu9BkpL/Z30ZuFZ4GwLsj/SNFShbpJpwi+W3FB5ki5pCel
	CHeOWgzzXYWpvw1lDw3WtEol+CqjAKyI4iKQNIcc1KJubeXWH2BvxfcQK61wrH3FU6ITqMNOoLR
	YMzzBzV/ZEctVRDTd2t0Ehw+PIQogsw9RjIbps3v9vuYbmccY5gl15Q==
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr16648300f8f.42.1730886129692;
        Wed, 06 Nov 2024 01:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhiTlCs5X+WxmoKrn9dj4wmjNiR44pmWH55V8O3pKkQuJK0IIZ3ybymz5MvkgSK1/I1NWjag==
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr16648281f8f.42.1730886129342;
        Wed, 06 Nov 2024 01:42:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a7a6sm18566549f8f.92.2024.11.06.01.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:42:08 -0800 (PST)
Date: Wed, 6 Nov 2024 04:42:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <20241106044145-mutt-send-email-mst@kernel.org>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Nov 06, 2024 at 04:36:04AM -0500, Hyunwoo Kim wrote:
> When hvs is released, there is a possibility that vsk->trans may not
> be initialized to NULL, which could lead to a dangling pointer.
> This issue is resolved by initializing vsk->trans to NULL.
> 
> Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> v1 -> v2: Add fixes and cc tags
> ---
>  net/vmw_vsock/hyperv_transport.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index e2157e387217..56c232cf5b0f 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
>  		vmbus_hvsock_device_unregister(chan);
>  
>  	kfree(hvs);
> +	vsk->trans = NULL;
>  }
>  
>  static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
> -- 
> 2.34.1


