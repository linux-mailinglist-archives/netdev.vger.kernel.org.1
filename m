Return-Path: <netdev+bounces-239659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07596C6B234
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4477735981A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317B35FF66;
	Tue, 18 Nov 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbSD2g4i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgobyGdq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0953590BB
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489567; cv=none; b=mtAVqD741kiO/RKMXtcFCngFBkiTeH4QnyJQ8bEAxeDpgLLrMVbpmVZqenPd5EjusxUlqdZkiRhGD7/72HtqpB1yQR8mTqPaEKrbN83bkwMA/1wDBGkfmHa1Fh/0zfPgSZWm9Tq17rtYuiNBiFmlAhBxuLcNpgzG9AAjrurqGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489567; c=relaxed/simple;
	bh=er1J307+KJnRBNUgsTZ17cqFXn2zardiLpzpxp0mLOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGcI2wXteRWTQAz4M06FAadNd0Gx6UdpvTbq3RFyqRTYpBjnnz2lM4HpMlgtvTxyFyHUWF/u0dqsTfge7sWwrwnVM6lvX+9Fv8m0/gc71JOjdVrhbiKdXUnZSu4hCpy+SAXBPDct/3jKPTcOJLBpv3Aa9R+6m0XapCi4QozRxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbSD2g4i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgobyGdq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
	b=gbSD2g4iiIEB9AJFemhWr27zXXtkHP6FmT4PwYOBzzMjtFysavo332E3PD0FRKKTEyBUII
	eDAR/YXOgqACCBWPSaWDUgZrYrbmq/y4uXlwpa3Fh0BT58LAlunlms7R/rbi0lCCxgPn8c
	qyNWycF0aZWz/rTsPJpVxVKVZtaB/x0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-hopgynBuNy6q3Ip2rs1n-A-1; Tue, 18 Nov 2025 13:12:42 -0500
X-MC-Unique: hopgynBuNy6q3Ip2rs1n-A-1
X-Mimecast-MFC-AGG-ID: hopgynBuNy6q3Ip2rs1n-A_1763489561
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47106720618so67321635e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489561; x=1764094361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
        b=bgobyGdqdIbD62/NuL81F0Tvj+BcEyw97DZXBgJNbFZAg0aeRiTWj+2OVIubV2pksc
         8iujT4+gm/6CqOV2YwO1Q+p6mZhGQFD0EtnuutRLco1NI/LtVnpJVsv2iBtsP4XzaaqG
         pH3PvZCsozAuKHOThSbGn06chBFgB+zEzbMyGfbcerFCevVKy+ictSQCw2CXnueqUIH0
         e1NUNI9PBgG1/8XFw+lT33XYdZoTvlka2X+6whpne1F4vCwQWozeHo3hKx+ADbmV1FH3
         MuHQ15MRDQEj+FQAM9InHW8gbDAjdrOWJQcoTTJxx9BSFanNlKiB0+vngx5lgnwdBYP6
         /WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489561; x=1764094361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
        b=WXxMoHl1MncG8vZsp/u7kk0skmy70DBYD6jYlRjJkfhyDYXsvbnMZ5RpzzPaZbf3Bf
         MGN9ms9+/3690UvMjWRbexno5cAOIjc/KG4E9DidxYgY1zE4hBHIHSdlBCh9+OL8h+dZ
         52Y2ZaXkRIIgt1zXE3HA+P1MTtKWBkKLY3Fs4kZTB7wgzIJL8OrFAwmyFw+LwT2otGZC
         I83XZNNPZ8xsfDH7Ghx+EH8Ra/4IQY2hGvxzPl88oe05ue6tmDKvp0Dlti2uRziuQlpz
         8o67+A1VibLzhSG5gy9W2Fj4Od985Pk+Uv7oxBQQIFPTds8/V5Cnqzxp0dCpL2DtPIY0
         q+wg==
X-Forwarded-Encrypted: i=1; AJvYcCX5NkJf8xVIXzDj1iPZlelZHnvmk5bl2gjGro1zoIMFFOIiZe41K5zbQNtlVjPuUruQlv+I/bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkjl+iR8Vg/5vZKfmBQE5J/ISh1jzsOUbgMPoyijgS/YwjYr8A
	HV6h4iYHPqIpp2FgDz/WjgimWx29//kv7PFnzLRostAjL065KDIRXL3uzU4tCmwMQeAuttTP733
	J+EeGCKQ2lP/DkfD89PBuRjOsW7Sl0KZ8S21DOSno5YN+LeuINZr4+GmApg==
X-Gm-Gg: ASbGncv2A0OKnocN/5U2zfCEM+J7r8N7BIGb3FizWSR1wg7qNnDLBVFT5F3yEWvtwOr
	DmGaWXPKe2K0hmZaVdFNuWvK/OMEfdID2uoluFNJYDym0+wp4W0AQQZyzUVI3iqbPsLn9FQdkmH
	mePKvWHq2X+zIHmS0k35htvVdwbzC8WDXdjTukg7sPD2HEZI5B1KNrCzbmnkQvQorMkFvskkRs8
	00Ev+QYnrMTu/k8VJrxt/k3MPG4aLOZmk7plrm+BZrJfPrS3hmWWnG1/9vlXrDYvYidNUs2bxId
	HvI+RJYeLYJCq+0zwkCHATqXhKauJhCgtczO5nRXt+cF81+dJGzfeIjeCgE7JH1NKdgDrK0nXV7
	rVxmDB2QikGVmT7NaDhe3zPZBUtQzwc0Ub/NEfGqBF9Mv0RcZGuNyyEl/n90=
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144928345e9.32.1763489560846;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOpTmbeuBuF6OCuotMnf25yLK3sUbAbvYEMuVVlK2CBmGppKS9Ccp0DvA2VuQ7IZI1U9CwzQ==
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144927985e9.32.1763489560327;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10142d3sm4356375e9.5.2025.11.18.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:12:39 -0800 (PST)
Date: Tue, 18 Nov 2025 19:12:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 05/11] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <zwpwgzf6opt2qiqrnpas7bwyphpvrpjmy4pee5w6e3um557x34@wnqbvwofevcs>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:28PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Associate reply packets with the sending socket. When vsock must reply
>with an RST packet and there exists a sending socket (e.g., for
>loopback), setting the skb owner to the socket correctly handles
>reference counting between the skb and sk (i.e., the sk stays alive
>until the skb is freed).
>
>This allows the net namespace to be used for socket lookups for the
>duration of the reply skb's lifetime, preventing race conditions between
>the namespace lifecycle and vsock socket search using the namespace
>pointer.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- break this out into its own patch for easy revert (Stefano)
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++++
> 1 file changed, 6 insertions(+)

IIUC the previous patch only works well whit this one applied, right?

Please pay more attention to the order; we never want to break the 
bisection.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 168e7517a3f0..5bb498caa19e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1181,6 +1181,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>
>+		/* Set sk owner to socket we are replying to (may be NULL for
>+		 * non-loopback). This keeps a reference to the sock and
>+		 * sock_net(sk) until the reply skb is freed.
>+		 */
>+		.vsk = vsock_sk(skb->sk),
>+
> 		/* net or net_mode are not defined here because we pass
> 		 * net and net_mode directly to t->send_pkt(), instead of
> 		 * relying on virtio_transport_send_pkt_info() to pass them to
>
>-- 
>2.47.3
>


