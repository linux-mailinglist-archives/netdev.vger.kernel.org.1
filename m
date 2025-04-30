Return-Path: <netdev+bounces-187004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E0AA4734
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D854C6BA7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291E23506E;
	Wed, 30 Apr 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGtDhnkG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51E19048A
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005331; cv=none; b=BG+rFISXLLNVtgfVcVlcTNFmA3MOYbFI1M8oJ/ypEfsizpcEbH9S+ikTRjhvvM8BEpinxZFwN0LjU8/fKCO4y2xRrZrlg1IJAia+V6iqFWCgZ+gLKcFcAbtAIWpX7l0ZOUaTL4BrrAA2YwVa9hopNpVHTFzDTJzFpzCyt05RLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005331; c=relaxed/simple;
	bh=CfCKT7csdC6kxz8qRaiEnDt65u+ulhVQn+dGe+7KfZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBdHaAxC8vjoA/K6bFW3xXDlk5gqkhfViRHwR9pJG3x3N13uClblU4kdvvBiw2KLMvME2o9OcgfzEttfUiz/Dy+kkGajQ9FanHkA44oL6hfds1ARWaL7FX4A7IKCPMuHonC4+hapYVpEV0zlK6eIDklhkb+0hzXeW7ZvDjBFrKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGtDhnkG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+iRdHR/016I7PiLqqexsMYXzIsBDeKqTco6kET+eEo=;
	b=bGtDhnkGiXcKpQOXTTwAZSU4uSl0TKmejjneENi0Mep5srnOF+ZubCzxZzBXEjGjd2F2ZZ
	9DyIQnyaHh7sSqNfKLGp5iKSjDWBv8fGW3Mniu96tPn1zY05cM5VVHGzmsY7e7sbqXxvV8
	ESXoanh4Bj97ZUgNO3ZyQsDIHJWqYFI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-n2uWDydyOyeZqnJsSbwPBw-1; Wed, 30 Apr 2025 05:28:46 -0400
X-MC-Unique: n2uWDydyOyeZqnJsSbwPBw-1
X-Mimecast-MFC-AGG-ID: n2uWDydyOyeZqnJsSbwPBw_1746005325
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac6b047c0dcso634424266b.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 02:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005325; x=1746610125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+iRdHR/016I7PiLqqexsMYXzIsBDeKqTco6kET+eEo=;
        b=YeRvw0Bm/gi56uRcdGOl6NI2l/Nea+2T8jyBR9kO39CmUM7PfOqrcftwvuRkPs2/WG
         DRdEL5J9T4c8iPhXfRAC4X5dJPh6EJ8MzPefUoOBwcD6ZtnkD9sH34emgqGBxVQIQy01
         VGE7s8r3LOSBXNlddvVpT6xsrtliZGWAvP2w9hgr12e0ueo8x01qyCznoX7Od0pPBPkx
         Zuv7EMtnnUSFWubl50o7rWT7FvFULUNJt/meGVjbmeJB9n/C3LDTq49SnEQZw2nas0fO
         casMG8o1sCqj34oWmBsqgBGLfmsoRwv/u78fP2CBRgQgmJ2tVGTDDzphrwIrO21VrCdl
         4zsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaKopUxHWo3DmYuH3HwVYzklZ2g5dV7ldt3EyxFMrN/thXiPeA2WxpaLnm+On0RZ0cLRQseDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJ/s/zIqNdPXOUWcksFc++hfDkqysyQ6IqxFr5DbsgyGiM0C+
	QRBWegraYBlKYeZR+UQSGPZKvpRrqQfZOmwJwlFkh086Maa5+3byKxPALuMgN39XKpSGLx7h6w9
	69wE+w+pTXPklDFAwJ7sxTopeVobbJvJrYzY/PNg7bFy3Koyo+J56gg==
X-Gm-Gg: ASbGncubDLhQ9a4v7GHsTCKhrsyXwgM5FkC4IINSVvlc+XcSy+IdG1sn7/jA2eSR+rY
	DQowYCpqO+YwhOhG06FzkOQz/xcb988MX8pSXS0Mu6hhctZkFIqHDiqCVTxuSDzy0qqJTRLuf+Y
	rZvmxBw9lyuyavEo86ind/eBLTsXvgdSNqcqYKDtv2ppB42uvFYWMYymzBw2HkYCxmAq2qsfqOR
	x0wQBrU9/Qtm78eon9HRNg2gVVdcA4opUJ+6Mc0WTr7nsQCQ8gwwfxkXTjNKNlwMxZw0K9/u2gU
	aCtjXUGmUcUIitM7pA==
X-Received: by 2002:a05:6402:3490:b0:5f7:eaf1:acd1 with SMTP id 4fb4d7f45d1cf-5f8aef99451mr1459109a12.10.1746005324749;
        Wed, 30 Apr 2025 02:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE81eWc8aL2LbvtLmC3j27kWn9yssNrgLAfG68UpEapDAHpJ7zaXyuHj+dnHphj20qrinwPqA==
X-Received: by 2002:a05:6402:3490:b0:5f7:eaf1:acd1 with SMTP id 4fb4d7f45d1cf-5f8aef99451mr1459078a12.10.1746005324176;
        Wed, 30 Apr 2025 02:28:44 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7e7e47be3sm5249067a12.30.2025.04.30.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:28:43 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:28:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: Reduce indentation in
 virtio_transport_wait_close()
Message-ID: <dlk4swnprv52exa3xs5omo76ir7e3x5u7bwlkkuecmrrn2cznm@smxggyqjhgke>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-2-ddbe73b53457@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250430-vsock-linger-v3-2-ddbe73b53457@rbox.co>

On Wed, Apr 30, 2025 at 11:10:28AM +0200, Michal Luczaj wrote:
>Flatten the function. Remove the nested block by inverting the condition:
>return early on !timeout.

IIUC we are removing this function in the next commit, so we can skip 
this patch IMO. I suggested this change, if we didn't move the code in 
the core.

Thanks,
Stefano

>
>No functional change intended.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 26 +++++++++++++-------------
> 1 file changed, 13 insertions(+), 13 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 49c6617b467195ba385cc3db86caa4321b422d7a..4425802c5d718f65aaea425ea35886ad64e2fe6e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1194,23 +1194,23 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
>
> static void virtio_transport_wait_close(struct sock *sk, long timeout)
> {
>-	if (timeout) {
>-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-		ssize_t (*unsent)(struct vsock_sock *vsk);
>-		struct vsock_sock *vsk = vsock_sk(sk);
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+	ssize_t (*unsent)(struct vsock_sock *vsk);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>
>-		unsent = vsk->transport->unsent_bytes;
>+	if (!timeout)
>+		return;
>
>-		add_wait_queue(sk_sleep(sk), &wait);
>+	unsent = vsk->transport->unsent_bytes;
>
>-		do {
>-			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0,
>-					  &wait))
>-				break;
>-		} while (!signal_pending(current) && timeout);
>+	add_wait_queue(sk_sleep(sk), &wait);
>
>-		remove_wait_queue(sk_sleep(sk), &wait);
>-	}
>+	do {
>+		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>+			break;
>+	} while (!signal_pending(current) && timeout);
>+
>+	remove_wait_queue(sk_sleep(sk), &wait);
> }
>
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>
>-- 
>2.49.0
>


