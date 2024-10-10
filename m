Return-Path: <netdev+bounces-134117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D268998113
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00CB1F25C69
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C691BD027;
	Thu, 10 Oct 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V31P30iX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936021BD01A
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550325; cv=none; b=ki/LAlAdMZiFiquykE/vaZLjxJEydwdeBfZ+IQjXathdNf9wF6M+pvdBUgihtbLhO/LOC7+d/E5SILscaTJMczCqgOnSfAHtAIIPSSs0vx7NFDFv+SFBy054zVhaqctM5o+PQ5JsxM9WOhpjsnFMLkkDF1kWYmI+eshKTUt/Rro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550325; c=relaxed/simple;
	bh=5FkSym2zfh9gpYXqPQNVgOy2adJqzTdbKa/srQkqsak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2KbBkz6VhIpgxSzO7O1sANIYKXNg/dDlgfZaf0wn+XQlbiaRfzsXGaiJYw0PovG6UxBqUH7IpQitsQKMf5ajuE7ZvXgcYq/6j08+pAKaqMAS0a/qhsMh2XEmOrUh1BjJoRVJFGK55CMsgEdT2IW/UarSApiYD5YTIFV3FVgnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V31P30iX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2dejue6pSAQvTnG44RkXYEK41uwAaKUcsc0phbjvy4=;
	b=V31P30iXc3fb8dzrWbvBO3CJZZ6ztcS5GUIB3+/35RexgU/TC/J9Rg0bJAH2iTQDpEAtHQ
	8otIVRmDYRyg7XVoObcmnELbiS6zNLFIon1CoOXukfgcXWK4pgQoeEBg0NKCj2WoG3KWlA
	RWXwCkR+mxIB9U6x6dRggKatZ/VegHA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-139pOz6tMaG0LHqrT0YShg-1; Thu, 10 Oct 2024 04:51:59 -0400
X-MC-Unique: 139pOz6tMaG0LHqrT0YShg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99527bfb14so59976766b.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550318; x=1729155118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2dejue6pSAQvTnG44RkXYEK41uwAaKUcsc0phbjvy4=;
        b=UMVMV/43ua9znRgxbWaaMwsC2iqiPwvIH5V0bjG69pbVJJGxdYWP0X8OH5M9sJchLv
         jgGouisigd/XJkdf5Ja/ZwcUKMSRsmtkjH30FCzH8U1U5KZ8eEWIPYeOPv6OsPhfJZ9S
         ZEKYfRB9it6EmJAhIn/wTHnq1LCkx58xzI+osuc/4LxQAoRBDbIFjoq6DRqUPc+Dian4
         dkxv2I/wFuyd5bfYiizucQZXTfR7phwpIGQ8QSCptwQ0k+iH7DkSY4fFIKyH9+qOTSAs
         G0tODaLAsIwYCM+/fpA1bGIndlffYp2F986YLPwn280PfDDd2+W9LNynJdIY7FFx9ulz
         OHYA==
X-Forwarded-Encrypted: i=1; AJvYcCU0MFlf3CDDDvSV8zdgKt4h4Dtxq1l6pRngDvPyXPmrQu4buSvZc2rpsFLgAHg3TmqOG9hcWzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpxXRYbf9zz65IVMb4ch0dAI2bgH16++xTaB/tal2I33lhRSW
	SA519TYOhBZwpUudQYJnsplbui1f0ydoZLfqJBuY+Fx6rNerC2cJ4gcvBky3D8TS6mQLJn3eQ0a
	DHGAMrNOhQX5TSGlX7Y+5WNxbvg9YDoE2JuicIvmroxhBFo7vx2NhaQ==
X-Received: by 2002:a17:907:f7a9:b0:a99:6b71:299b with SMTP id a640c23a62f3a-a998d21956cmr521642366b.37.1728550317925;
        Thu, 10 Oct 2024 01:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXkxqLEEjeO5KbJNC9njO1BJ1d6ufsRlRJNPu7hJZf3nJ1CQw+5JlosH5E/PJf49c0mNK58A==
X-Received: by 2002:a17:907:f7a9:b0:a99:6b71:299b with SMTP id a640c23a62f3a-a998d21956cmr521638466b.37.1728550317125;
        Thu, 10 Oct 2024 01:51:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcdc3sm58131866b.172.2024.10.10.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:51:56 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:51:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 3/4] vsock: Update msg_count on read_skb()
Message-ID: <cg4lmct3plkgdvuasxuorbs65qylkmgrezw77phahsxf24hqts@nmubxtsarqnl>
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
 <20241009-vsock-fixes-for-redir-v1-3-e455416f6d78@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241009-vsock-fixes-for-redir-v1-3-e455416f6d78@rbox.co>

On Wed, Oct 09, 2024 at 11:20:52PM GMT, Michal Luczaj wrote:
>Dequeuing via vsock_transport::read_skb() left msg_count outdated, which
>then confused SOCK_SEQPACKET recv(). Decrease the counter.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 +++
> 1 file changed, 3 insertions(+)

Thanks for fixing this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ed1c1bed5700e5988a233cea146cf9fac95426e0..1d591b69ede3244a4f49aa44dc1f939d827dafc0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1723,6 +1723,9 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	}
>
> 	hdr = virtio_vsock_hdr(skb);
>+	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>+		vvs->msg_count--;
>+
> 	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
> 	spin_unlock_bh(&vvs->rx_lock);
>
>
>-- 
>2.46.2
>


