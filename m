Return-Path: <netdev+bounces-198074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D47ADB2B1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72147A7254
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1BE2DBF7B;
	Mon, 16 Jun 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKsPWt/a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9C2877C2
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082048; cv=none; b=i4k2GVQf97hrkPJe/2xrmGnrGvhu4vZTpNqw/h7OnrtMB2yRk8e+pjaNnAfKRKe6afyvBpYhF+LWTG/3Gv6KDuXxVUAL2Os2quaajDIALLIeBcLU4J+LXPPjSPgTYNldE+P1rePaHW7/hgpN847WB5IlWYRWNGlH2eCcz1W1fw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082048; c=relaxed/simple;
	bh=ALufLifN8ET5GUUo9VdmBMb2kiTd+JEXg3vJP9CcLJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD9mWj7859ZS/exsoGrXoPu9IhAANeF+4Y6PTp6u0DbaLzPcS5xs4xL2mSb/zoCtfujWIYpEJi4Z6875QT2DwrUnZMa/y0GdknRMYTWPVEjASiPR+648rvDWHNvnsh7ebSY/ltH538TpYXtNulQVFg7NJObm8afahjwZM2qAc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKsPWt/a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750082046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXRSgHsBoykaoCkGaODkCk80Pz+wKzFt/0k3tccKi30=;
	b=SKsPWt/auj94o3oxociEKTbn3gyiqW6mIYADHOlH/C0fFTvvFQkZcCS05YkwAP5egfpy5E
	eZH2/uCV13bZ35J1WHzpHrrzhTSr0VMeNkc/VZJL2+v5c7qn3+PjoVHdqSjQB6/j4J1+8a
	er05MbLCm1RFQ/1ocpWWQFcBdxht4NU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-KsU8BImBNgiDcP-80Yi2tg-1; Mon, 16 Jun 2025 09:54:02 -0400
X-MC-Unique: KsU8BImBNgiDcP-80Yi2tg-1
X-Mimecast-MFC-AGG-ID: KsU8BImBNgiDcP-80Yi2tg_1750082041
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so2768556f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 06:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082041; x=1750686841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXRSgHsBoykaoCkGaODkCk80Pz+wKzFt/0k3tccKi30=;
        b=duT575myrh05W8WdqQpsfH7PEu4s5JVilpk4t2zo8Ak37yTigiwq7qTimLFlD7u1d9
         5KSExVpW1RBQvxq7aCw9HjI0L2oySQB/cIypgN0xSq64X7TBpyhFcq1zgN3l42v3tAPB
         qtwYc75jXQ+PLtRvi91UTidjZyFI2JOs6bGN42CN3EKw9htQFmFheBJHNPkzKF9P6u9D
         Y5QezqxRcRs2JdFXYKxebFvknk+pW5oP4pFquIA8ZweDvpZbOMkiMaeYOSeapIQKi4fo
         gMlo1XZeGXrVriRq/s1S2wBVCtGA/tilpc0juNqK1FzKvl1XTzwxecFkNYy391BTMuFK
         ZfCA==
X-Forwarded-Encrypted: i=1; AJvYcCXRBKYZPFX/6VzzkvQnV+WGvmtwHUNy5d3AlMYOGNGDya99PVk8r2tGXGRpSNWQbQIj5ln1MDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SKJv6lK1iqLV4pcR15cFEHGzsrCUWPPZIR9djsEQNjKLmJX4
	GOC+grYwcUROEbuGuPL1XrCjXIJkjpGPO9Lz/Ew7DaeGyiIFGHFJsx1gUG02qwS22iq1uQ4dpiL
	TLPDcgkDA7W2zN/K3BVZyjVzLfXSblFe3HNvHHK6IRA+uxQ6q+iDIInxhEw==
X-Gm-Gg: ASbGncsRdunuNJNscUTCT0IKJcm1aAVsHIt6Fp/VMOlQHfAoZ9pr/OchmvAJ+9jkXLk
	5G+nkm8NXuFdpRW/IQiZqm89taYJIjSaWg5Lulyz48FpwaR88cZ6mYnUZlY7JyKuoJfDNuQcodq
	cYJ/gGM1I2pEymTdgr5+NAYG4YIzToAIVy6YipU+aBg1xrQ1W6l24h+fktu1M75mnwIHwpRyr7q
	Se4qXmseQPr14ds8r8bio6gyWn8V/HXBMxZzmZbgomt/uoqcHiIsBOPZBqCbUXQZAM2ykYG4n5k
	WH2fV0c2YaS5r7EXwWEoMMi38Pw=
X-Received: by 2002:a5d:5f8d:0:b0:3a4:fa6a:9174 with SMTP id ffacd0b85a97d-3a5723a36b1mr7744977f8f.33.1750082041413;
        Mon, 16 Jun 2025 06:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9KK52CE4TM7xQev5LOLheuW7Ek08zbqpia8Xus0jUc0uv2rsRw4izzQxnWbncAFqkbNkuqg==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:fa6a:9174 with SMTP id ffacd0b85a97d-3a5723a36b1mr7744946f8f.33.1750082040864;
        Mon, 16 Jun 2025 06:54:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.202.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b403b4sm10933571f8f.80.2025.06.16.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:54:00 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:53:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <xshb6hrotqilacvkemcraz3xdqcdhuxp3co6u3jz3heea3sxfi@eeys5zdpcfxb>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
 <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>

On Fri, Jun 13, 2025 at 11:11:50AM +0800, Xuewei Niu wrote:
>This patch adds support for SIOCINQ ioctl, which returns the number of
>bytes unread in the socket.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/net/af_vsock.h   |  2 ++
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 2 files changed, 24 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d56e6e135158..723a886253ba 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -171,6 +171,8 @@ struct vsock_transport {
>
> 	/* SIOCOUTQ ioctl */
> 	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
>+	/* SIOCINQ ioctl */
>+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);

Instead of adding a new callback, can we just use 
`vsock_stream_has_data()` ?

Maybe adjusting it or changing something in the transports, but for 
virtio-vsock, it seems to me it does exactly what the new 
`virtio_transport_unread_bytes()` does, right?

Thanks,
Stefano

>
> 	/* Shutdown. */
> 	int (*shutdown)(struct vsock_sock *, int);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965..466b1ebadbbc 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport || !vsk->transport->unread_bytes) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsk->transport->unread_bytes(vsk);
>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>-- 
>2.34.1
>


