Return-Path: <netdev+bounces-211655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8401EB1AF40
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36B316A2E1
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13108238C0D;
	Tue,  5 Aug 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMjmTOyZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABB217F36
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378158; cv=none; b=m717c+W2QE1cGdA68CeDl1RMRxQUTBZatFdOT7nwqbUopN1WXT8QbI3DesBVfwD0k6nexm5NjVBeX459jGexmM57T8wbEr2P9BLffT693jaloyDkNFfreklE6e9daAmbKRvTqL+pRluDLC960En3nymTGqQVmwmO8n1CIxDjbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378158; c=relaxed/simple;
	bh=ftuIf5p693pbIE28Ca6q+2oPAzEBuJqq8byNCo2RqCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvFAseXwVDmnLd2r4TUIIIpxAhumg3Xl91nYuKxFs0ICpj33Z2bx6470nET75oMcABsGMN99awHqfZ8UTNuJ0KZ/8t9a8TDLJMHDzJwOu+z4Mh3OxqmDH/yiYFfkwQnNJWevztUopg2+0RmUPrfUcclmCTDYK2sy+8XnB/BKp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMjmTOyZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754378155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1lfQQck/gEfvghhrXvc2lp4TNPtdu8JSj2lFK/nD/A=;
	b=dMjmTOyZeOW5kJHDQH0mYMR8T0v4i6L89cmBUbE8s5qvskEZWjGtC0TRiUgkoDCUTgL1IG
	M1Z5WdAMZCHkSFOsltzQe8cGrSYuMntVicvd3jljbWQhihg59LOaX/jieK5uU5msY+MhA7
	f/lIdDgUmNp4qWyekyWstql9VGVKXGo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-1omSHB3fOsCDolLQt_aCTg-1; Tue, 05 Aug 2025 03:15:53 -0400
X-MC-Unique: 1omSHB3fOsCDolLQt_aCTg-1
X-Mimecast-MFC-AGG-ID: 1omSHB3fOsCDolLQt_aCTg_1754378153
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70743a15d33so85968726d6.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 00:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754378153; x=1754982953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1lfQQck/gEfvghhrXvc2lp4TNPtdu8JSj2lFK/nD/A=;
        b=fJB3Fbile/z8NEraJ9IFwwho3bBCs/srqN7Tdt6ZwNTZ+3JS+RLkZO1quCkTf9K7b6
         fQGf4I3NGYRvd2Ag9Cl8r+X65YERt2Ilr+poT3NOqgLw+/sXBXhHyQRowIBlsDu53Q5m
         BCTtTVbFz0JC4BZmdixVYCdDF19xXW4JluZAKbuxA/iQ64qLV9BRUxAXO4cbn0DfluEp
         jQnjb+FOEhOu2HmgqCEBiZTIFu+HlVhnk7YbDYgcTn1QhyzvivsPMAULn1RiOoS1tj8H
         BVz+Veq1QcJGIw8c/E0q9N1P5uYtXTPzu/gseLguff7XqhlCAHzpEJ1Co5nauCSqZ3WE
         zTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu+DWxNZr8uG2teiWTSIfSwum40qFEQavlq6JMg4EDzu8T659ruMGDUn2z5O2qtHAzEGyeCSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznApAAQAXu1mBZpc7yVEuqpfVyLQPX7RK/1AMlCqe74VXXzUnb
	6EmarKeqQsT9N/Z7NNw29fRIdtynmxJnXSyTmp20ddGq1lStQjM+Na3Dt+a2BlscCwtKZ69Vot7
	AcSleD6+12UMPHPZgtzVKfonjmJ6C+G9N0qmA4DVIyBU+7ThuwVl4w8GRhA==
X-Gm-Gg: ASbGncuUv0IIlcNntqN3bvWtpQU/Z9nh+hAq/1IFOlBjWjY05t1ou8Jh3qVHZXAw/op
	kCaHBwL4ycJrd+hryEehbgIyYDj5nW+yVdcSSeyHaO2UOGJpb2gCmZZxSEt6HPbDajfxWpIgjym
	rAC3bjq0viJLzByLhA5lmx4cSSCeXMUFGF0WsuSJNLgfphbLw2Vi5NlOaAkVmRPyy232tc4BXPM
	Ih7V8ouk2UJx8RzxUb1SUW0b1gfvHbfo9hu2/kwy2TcRfwxoLVB+1wIC/YcRQjTaWwxbl7NZYl3
	BZp6RSQVoVH9YuJK62BqfUkVeVz2lxSg2FMQlaoFHCBavb1AMqSQMl4SrZt9cxpXz5N5VoTcolA
	9nDGhQvxLkZIxf2Q=
X-Received: by 2002:a05:6214:c47:b0:700:c39c:9d12 with SMTP id 6a1803df08f44-70936327c52mr160762236d6.43.1754378152793;
        Tue, 05 Aug 2025 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFZ6fig7Xx657yIfyOJPg7qs7PE+/ypJzBtTrd0P+Slx/GHljmbFT9/ITIdPwSIwQdwRhc6g==
X-Received: by 2002:a05:6214:c47:b0:700:c39c:9d12 with SMTP id 6a1803df08f44-70936327c52mr160762006d6.43.1754378152227;
        Tue, 05 Aug 2025 00:15:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca464acsm68273536d6.36.2025.08.05.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:15:51 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:15:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: bsdhenrymartin@gmail.com
Cc: huntazhang@tencent.com, jitxie@tencent.com, landonsun@tencent.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Henry Martin <bsdhenryma@tencent.com>, 
	TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v1] VSOCK: fix Out-of-Bounds Read in
 vmci_transport_dgram_dequeue()
Message-ID: <jqgnivkquty3gdhhedbx3vub7wguhuxyorelkpvwhu6r3mfvzm@q7voouptegpt>
References: <20250805062041.1804857-1-tcs_kernel@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250805062041.1804857-1-tcs_kernel@tencent.com>

On Tue, Aug 05, 2025 at 02:20:41PM +0800, bsdhenrymartin@gmail.com wrote:
>From: Henry Martin <bsdhenryma@tencent.com>
>
>vmci_transport_dgram_dequeue lack of buffer length validation before
>accessing `vmci_datagram` header.
>
>Trigger Path:
>1. Attacker sends a datagram with length < sizeof(struct
>   vmci_datagram).

How?

>2. `skb_recv_datagram()` returns the malformed sk_buff (skb->len <
>   sizeof(struct vmci_datagram)).

The sk_buff is queued by vmci_transport_recv_dgram_cb() calling
sk_receive_skb(). And It is allocated with this code:

#define VMCI_DG_HEADERSIZE sizeof(struct vmci_datagram)
#define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)

static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
{
	...
	size = VMCI_DG_SIZE(dg);

	/* Attach the packet to the socket's receive queue as an sk_buff. */
	skb = alloc_skb(size, GFP_ATOMIC);
	...
	skb_put(skb, size);
	...
}

So I don't understand what this patch is fixing...

>3. Code casts skb->data to struct vmci_datagram *dg without verifying
>   skb->len.
>4. Accessing `dg->payload_size` (Line: `payload_len =
>   dg->payload_size;`) reads out-of-bounds memory.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: TCS Robot <tcs_robot@tencent.com>

Please fix your robot and also check your patches.
This is the second no-sense patch from you I reviewed today, I'll start
to ignore if you continue.

Stefano

>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>---
> net/vmw_vsock/vmci_transport.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 7eccd6708d66..0be605e19b2e 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1749,6 +1749,11 @@ static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
> 	if (!skb)
> 		return err;
>
>+	if (skb->len < sizeof(struct vmci_datagram)) {
>+		err = -EINVAL;
>+		goto out;
>+	}
>+
> 	dg = (struct vmci_datagram *)skb->data;
> 	if (!dg)
> 		/* err is 0, meaning we read zero bytes. */
>-- 
>2.41.3
>


