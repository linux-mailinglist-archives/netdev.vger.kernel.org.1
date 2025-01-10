Return-Path: <netdev+bounces-157109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C1A08F2F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C77A3ED8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B120D500;
	Fri, 10 Jan 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/hWQFu/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D720C019
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508324; cv=none; b=K3a6QEp0NWdIz3RdVpqNP34m9b/XddEfY6uiQ8yI9QK9rPH99xT7IaPpoAt1uiLEqUcvCdxyMIr3YoI+JfqMuLBD8z7SyOvpDL0JD2Drx5BV0uYf/JTZdxFSy9gg1Ey3/y2Qelvm7hRfURI2sg0wzOwoJm/YLAvwjuAorMtRcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508324; c=relaxed/simple;
	bh=h+3V8Dg/wI18YbTuYBPBYgVfFTOtZGjB+ocTQMzeqlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiu6DnJFYxLWXefnkSP19llrOhuXqULV1+OWpJTaqdxYpB1ZiG2L1Exz4p80pQOkRncHB1jn0ndxgA+2C9pWFNM7umX0Y5CzmStjIfLP+M7fPWWqhlR3qcY1uPOvRm/uyyPhZMExZxJVkxMDfp/9FUoG1wPrBccTkvaCnP6148c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/hWQFu/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736508322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ef2wLHVQGV1IsoMPeKXi5uZyvCqMew4uoHW3wntJAQ=;
	b=i/hWQFu/XlsmwkjawqwXRu2SzMhUYO+RllhSxgLCm/PdbijVCwwegj5tJdxhuNz3vjnLra
	ggXI3LPmSMtXUXjVK4wXemf57wDYuQU8WF1oHp1Tgc6MvpWSwg9O86mosVeSDZ0IB3HdJa
	ibY7DzglQFglss9gVxkZSfiUmAzDEYw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-N8l43eN_N-iwZ8vNmApwug-1; Fri, 10 Jan 2025 06:25:18 -0500
X-MC-Unique: N8l43eN_N-iwZ8vNmApwug-1
X-Mimecast-MFC-AGG-ID: N8l43eN_N-iwZ8vNmApwug
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso150359666b.3
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 03:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508318; x=1737113118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ef2wLHVQGV1IsoMPeKXi5uZyvCqMew4uoHW3wntJAQ=;
        b=QwTQGf9VqRpE39Bdwe3VoFQvtJfjmQ8aNssigprBKJoDhv7mIMxqwTq4ZmQD0BtwON
         wgnoMcs25DYo63mB5oEnpQNToL9radX6bPcNSUmS950XZ85fX7oRIbouprBoNaZWYLGW
         II2yE4LdXN8EuMTE4s94RxOwVjkGV4f2nDlmPK4hiAk7b7F6sHNMpJXcduSQGYYyPfHZ
         2OG/2zDzbEUO9ZErBS4blKsRviaBqGxq2Vy+VgVHsAj5QOWOpnbZcHAqZZi7gYBS6n61
         4cL3C6JNS/p2sZF5LdLGAGkJjNmTXGVp/w35ADfliR+ITmbYk+limCvdt52UAdV+RoYO
         2v0A==
X-Gm-Message-State: AOJu0YxHsEp20dFUh0gNsFHvqOFDf3aSBI8bD8qQEzGnVlB8V7NYPHgN
	BGfjSt3TtVE0kkn13e8goJ6LK6mKl/mcimcQgZYoSaTtU/ba4aI6ICAiGfpiYk7cHlpQSHBpSXB
	JX5P9U4LFUwuT1MoO6eRRR/2pTy26s76f+nzcD6E5JxCOo7C0ufiCHQ==
X-Gm-Gg: ASbGncsS9LQscej2vOAnzTh8JPxE1o7azzn/GaZ+dQcPz1ygMSEU/6KxF7HUO7xQz56
	cbf7ejd544B5YnPXHIzEhJ01rpCsi5ntLNJCEJpeOrpTAfIZuyOQBmcPx1tBTRj+S3QAeyvqn7H
	Gc0VH+fPuJJW4L7SYZd+A07PEAO5bbzwugjer+sm3/kcA3qpobZWLqGDokamb0Wtf4pBDsUWrnq
	2ODm/oARQAYnvNX+UK9/8nQ0JI5chgNVfJ5vCUc+NlcPSG3Z7YJ70S6WFfQX6M=
X-Received: by 2002:a05:6402:5194:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d972e0e341mr23290978a12.12.1736508317703;
        Fri, 10 Jan 2025 03:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3mqsKI2idLOS3bFseUHtOVmXbXG31Er639vFwFDT2akA/HfPxaQl8uNFpTeEdJZcPXxQTRg==
X-Received: by 2002:a05:6402:5194:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d972e0e341mr23290897a12.12.1736508317029;
        Fri, 10 Jan 2025 03:25:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.202.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95af694sm159293266b.144.2025.01.10.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:25:16 -0800 (PST)
Date: Fri, 10 Jan 2025 12:25:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 4/5] vsock: reset socket state when de-assigning
 the transport
Message-ID: <fjx4nkajq3cnaxdbvs3dd2sxtc35tkqlqti3h44t3xuefclwar@havkg6jfisxu>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-5-sgarzare@redhat.com>
 <esoasx64en34ixiylalt2hldqi5duvvzrpt65xq7nioro7gbbb@rhp6lth5grj4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <esoasx64en34ixiylalt2hldqi5duvvzrpt65xq7nioro7gbbb@rhp6lth5grj4>

On Fri, Jan 10, 2025 at 11:56:28AM +0100, Luigi Leonardi wrote:
>On Fri, Jan 10, 2025 at 09:35:10AM +0100, Stefano Garzarella wrote:
>>Transport's release() and destruct() are called when de-assigning the
>>vsock transport. These callbacks can touch some socket state like
>>sock flags, sk_state, and peer_shutdown.
>>
>>Since we are reassigning the socket to a new transport during
>>vsock_connect(), let's reset these fields to have a clean state with
>>the new transport.
>>
>>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>Cc: stable@vger.kernel.org
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>net/vmw_vsock/af_vsock.c | 9 +++++++++
>>1 file changed, 9 insertions(+)
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 5cf8109f672a..74d35a871644 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>		 */
>>		vsk->transport->release(vsk);
>>		vsock_deassign_transport(vsk);
>>+
>>+		/* transport's release() and destruct() can touch some socket
>>+		 * state, since we are reassigning the socket to a new transport
>>+		 * during vsock_connect(), let's reset these fields to have a
>>+		 * clean state.
>>+		 */
>>+		sock_reset_flag(sk, SOCK_DONE);
>>+		sk->sk_state = TCP_CLOSE;
>>+		vsk->peer_shutdown = 0;
>>	}
>>
>>	/* We increase the module refcnt to prevent the transport unloading
>>-- 
>>2.47.1
>>
>
>Hi Stefano,
>I spent some time investigating what would happen if the scheduled work
>ran before `virtio_transport_cancel_close_work`. IIUC that should do 
>no harm and all the fields are reset correctly.

Yep, after transport->destruct() call, the delayed work should have 
already finished or canceled.

>
>Thank you,
>Luigi
>
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>

Thanks for the review,
Stefano


