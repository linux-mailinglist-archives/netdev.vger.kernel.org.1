Return-Path: <netdev+bounces-244339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA1CB51C2
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A44830084DF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CCE2D7DCF;
	Thu, 11 Dec 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHiJIiDd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fc+tieC6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9E2BEC42
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441819; cv=none; b=n3hzrUjexT6A9s7YG3HFP9WeQeaV1frUfDeVJZY+s2Sy9lXjVgAiV4EqBqMgKmTKRxSvf7ZXsVckqBQWTVXLEPzY+Y0g7EA0bEmWQnDLlat90Z9ahRzQ+paMgp5y8yxThgzwyJW6P5o8WIc3BWdySBgVcpDD7456Qq5YKk59UVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441819; c=relaxed/simple;
	bh=vx2flSiC2ZzOI6DHmbaRJhsf8cDKzOr34NF/08N2QWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRGrGa9XmXFbJafSkYrx6JBI0zfblwGMsie8MxDCgFgYRiHgoHyCcrnqHSqul8S+1eBnCQ05+LSgn3XRy0YJ5ys9hLoY5rjanbJyEYhi5i8TQT9vYz8Foy27cVNOKPxSEIjw+fQc/ar9Lw+LAlCW1dmlAqoLxjQLAKGTmRrKY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHiJIiDd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fc+tieC6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765441816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3idtZY7mSmwvuTMlPGQ2Fz6MYA6aCNvj4wJ0sTbDzCg=;
	b=EHiJIiDdHyvOSAmmcGX3t5foQ8vZrG5kgY926VSPQ2ABvUO+4k8JTjWdKddnf3+CjeTrlr
	jLhiMGmPN/49YjiqHaHTHdleFTPUyCa7I/Z7a0Amhk90ZNJm0wZMFJFAPYIYRcbH4tZVdS
	0p7zlcB7uIJkKpTKgy6T25FKUSxDQ1k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-AyTvs82RNe63xJpjMYI7RA-1; Thu, 11 Dec 2025 03:30:14 -0500
X-MC-Unique: AyTvs82RNe63xJpjMYI7RA-1
X-Mimecast-MFC-AGG-ID: AyTvs82RNe63xJpjMYI7RA_1765441814
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64165abd7ffso1440750a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 00:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765441814; x=1766046614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3idtZY7mSmwvuTMlPGQ2Fz6MYA6aCNvj4wJ0sTbDzCg=;
        b=fc+tieC6P1z/rzyYPxLlVmEYMkUXnQAMEKDI9pDDyBUSDUiGFcJQplFZupXzqtFUzE
         +Nn2BxymCc5bkjrzdHcPZURYKv11aexFu4/MIiH3at1MLvL8JeOhlyNim158q9gSNsPl
         JvzS7yUZwfwJhhf2DMd67xHHQX/zT4dZXCwtgqpLBj2B5NfYLGvQD8nxwdEsP9se8Wm7
         1BHiZyorGTdLMg1bLRkQ0hcKGDUCupXmkaqPRO3qWbNB2nHh2Qkay9H9cR+fliKY0AGs
         NAKwXyAN4/dVubSks5KGltoheIDnsZmNLvkzGknua0WFY34Ct/0zs8h3VGxx3QxX2wXt
         vd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765441814; x=1766046614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3idtZY7mSmwvuTMlPGQ2Fz6MYA6aCNvj4wJ0sTbDzCg=;
        b=WPIZQyYdUGbIwJwR/fyHoAiRRVBDQiROT++cpqRNRa84RvwZyTW+w90mOmMuRERxo/
         qOZ5GhV9ahLEPvN1nHLW6sqKmctFwpNtWapULbaCSAMiwYqePwyW4E8vUQDC5/7RA+N4
         PDRSZu9LnE45y/IlrMW7LIVKkrDD/1sfIynJARXoudwy8dEafycA8JNZ1v8O0Ysmd75e
         d2I/MELMuKmBTBjkVG9b/zmcdM8uANL8XMQAzET1e1nlKdaL5grnQ2yaMiFOvEWSQpFv
         lVzJ5PIY9eroR42RVeXhOpGFxCsJXKkGxy6v5Ge7jhn5Q+/bKV+WSJHc/EFO6KYz8B84
         KeRg==
X-Forwarded-Encrypted: i=1; AJvYcCX2QR+YfVvccmQqsXbyMpsXuo+RYy4/yUhd4y3zJ0MrMvL9ZAYak6fMvMwmfJ+CbTmcoygnr5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklWoNkh/2h0pWXdrybaGV0Z/WcYyeLYcPCpBnrVrnvoa3r29t
	2yg6/Lw8WT+uFa7OooCBi7I29XQAL0y00CU8qMB/9KNR8lfCM+EHoZ8+gG1k3KxT/S7WCJZ5rEy
	0xltYn9PzKeT6znmvznHTPayxW2sp7lehnpUVYifnWtywR0uWxjCsL+6B3A==
X-Gm-Gg: AY/fxX7XZrCHomm7Q7H9y1kw7U/XRTWKJsYewnV/XqCmX/sPMIV3H7Auw8351AfCC9k
	kHXDOgHlEdCi3GP/tRjuNwqkKVXMCC4iQuJ4knfssQCe7V2pGeBTCAifoZgYCfsxh0rq3H/p/ja
	Yk71vJRuhKJ+n/jXNhR1KwJ77m1sQgtlC13TfZ6EJCEdXuKk0UV9bQDN+XAi/F9PfBI9IbGkj1d
	y+cGSA5ksmbhKYubrGT0aA2Lr8wViMrn3C37ZkIdxKJTh+ZSwZ5OHJ4G586qqSIlD0LgvdcOg4S
	CiX9pTRHZfBjXOQDZcpZDjU4KsuNQqTgWNICZRxQ8xfDTrf/9LaHMsfvfgs+BLOVzX5IdxT/ULV
	LeUhmrdhXAHH+QJoxt7arruk0mdMbqwz/mOcLiPpFW9m0mDQx0oMU+gQaNsw5Qw==
X-Received: by 2002:a05:6402:2786:b0:645:1078:22aa with SMTP id 4fb4d7f45d1cf-6496cbbc23cmr4596710a12.19.1765441813611;
        Thu, 11 Dec 2025 00:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuwQjT4UHTBmwDXqoTBxPbsneTQexl6Aw6I9Srmcye45B0nUYzXfaqL0GoFMZfWMLEuTvP7A==
X-Received: by 2002:a05:6402:2786:b0:645:1078:22aa with SMTP id 4fb4d7f45d1cf-6496cbbc23cmr4596676a12.19.1765441813080;
        Thu, 11 Dec 2025 00:30:13 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498204fbb3sm1831786a12.8.2025.12.11.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:30:12 -0800 (PST)
Date: Thu, 11 Dec 2025 09:30:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: Fix error code in
 virtio_transport_recv_listen()
Message-ID: <xz4ukol5bvxmk2ctrjtvpyncipntjlf4bdr7kjdam2ig5gf7ho@vuuwwu7asj7i>
References: <aTp2q-K4xNwiDQSW@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aTp2q-K4xNwiDQSW@stanley.mountain>

On Thu, Dec 11, 2025 at 10:45:47AM +0300, Dan Carpenter wrote:
>Return a negative error code if the transport doesn't match.  Don't
>return success.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>---
>From static analysis.  Not tested.
>
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..77fbc6c541bf 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1550,7 +1550,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		release_sock(child);
> 		virtio_transport_reset_no_sock(t, skb);
> 		sock_put(child);
>-		return ret;
>+		return ret ?: -EINVAL;

Thanks for this fix. I think we have a similar issue also in 
net/vmw_vsock/vmci_transport.c introduced by the same commit.
In net/vmw_vsock/hyperv_transport.c we have a similar pattern, but the 
calling function return void, so no issue there.

Do you mind to fix also that one?

Sending a v2 to fix both or another patch just for that it's fine by me,
so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


