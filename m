Return-Path: <netdev+bounces-203433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB5AF5E99
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5264E68A4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C622FC3BF;
	Wed,  2 Jul 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D76RsSKi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3E2D0C8D
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473729; cv=none; b=Oa02kSGjwkx/REkPQMYklNiP4MXBAVrbY9dtmzYkEilQ/F8q3soFE4b62ZN0gxE45E8A0pvvk/LBAznRKfdNeR7DDx1KnVo5PPtxygXL+Zs1ZjhTm3Mt6bXLJzCQMl39MZzsxg5F72cSlZ6++khXoR99JlKJTGTqOC1KpThWle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473729; c=relaxed/simple;
	bh=3cOhVNRurGPxaeIw/7+m+PZy6wlwiza6W0eLxC4gdvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be7KScMBgItsWZ41dBMQyyierY6x59U/LbDhd9Yn/5mgOQoptY18ZdFT6/zgttx0l+SbMONKkVHt/S/ABhx4iXfOB72IGjT7lH5vnZNqMGSCN4cWl51182CwjAPRsmxV86dSyu2uNWnRBp7d0OjJpJR1DcJxsubzqgfazsjI6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D76RsSKi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751473725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NG8jUsMOCdk8QP8hLYJJABR34rscESNoucVpKrlQhUA=;
	b=D76RsSKi5UdNhOK2u/eDpX6dsoV/IVUBGzETgyJdbx4ozIuT4txXQjVNz2Qec4PJEGyH+C
	J5Y8uByBNqVirQWD1SVM6SV8a/Na89mANZWRi90u3liRsCX9oAJkHUIoJJGn/dAFGsxF7O
	BfsFKjP3dA8JVe8JflPhjkqReyS0t6I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-6d_-EhskNKWZ1GMtfABSqQ-1; Wed, 02 Jul 2025 12:28:44 -0400
X-MC-Unique: 6d_-EhskNKWZ1GMtfABSqQ-1
X-Mimecast-MFC-AGG-ID: 6d_-EhskNKWZ1GMtfABSqQ_1751473723
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so1686255f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 09:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473723; x=1752078523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG8jUsMOCdk8QP8hLYJJABR34rscESNoucVpKrlQhUA=;
        b=LhrGQPCvkzhpVOwdMLTa6H+ft42EdfEGFUDDfF4ka9/eaJVH4oG5/a5BivnI1//CH0
         cLGwEGWHgDrw445Mww5fCA5x2SIXhPw5m87DTgbZX5sTv1EoTiKHjiFbAnBc408UzkgD
         zJb3ib9TMDgtG125BB7KV8mW5GM6yrvfKOOUZH08N0/Evl2JYywBJVVgvY0P48cbGEC8
         w0WjvscAMvKy1AiohnTFE2ayQYRkNY+uXBPO7h7oQs053cnAZKxc80NnTEEOoKUPJYCE
         4TWfuhD5pkKIr0L78ulyTfL0gOiPDUNF1PZcCjgXDuGpFLjxokFwcUtZGo6iJhE9KkkW
         dgnA==
X-Forwarded-Encrypted: i=1; AJvYcCW/zczCPqklM5r8rnG819AVqms3pcjHCqqua89O1fHD+2lKK7yNO7YSMEsUeTxcgU5xh44565o=@vger.kernel.org
X-Gm-Message-State: AOJu0YytSse9LZGD/gM6il9R7qrqJnLYADjnepjZQkJPyUrXEFQfELXA
	y4F9aYNMqSYyniwTvzfJRjhjUc5qSFDWwFMFNvjz3tZ1GkuNhm46WdNtsC3C/bdED1P8gJJs6Qd
	J3ooD05rs3fiN2769i2FGTzwFYrfS/HEV2ECotkhzv/lNeH1et+9wr8vmAg==
X-Gm-Gg: ASbGncuGEzxUkxB8aswiyY2gXVODtR3pXl8x7+kSw78XOOA+R/wSY4gDwNOAt7yf9WX
	A3J9nyyHr3GlU8nlIQGq8Ue2FGX8DMhCncMftN6UPI0+YtXPdE6sTENB3dHz9crbNm3oy1+m3Le
	YBO7f7CNNFl06yJP7NiX+PGtTbsGibKux+IlZ9ZV/oOY2Y0eF2pQ8CDM8jE++tKuXIJNmxgLgAq
	WJtExFjUeg5qzza6h9ccElnuMquPH51HSaeaXlJeT6gNBm9MpGyIBLsL2yQjcU+YXG0U1eMA7+n
	+532Iz+NS6HWCI/Lvhdorsd97JYy
X-Received: by 2002:a5d:5888:0:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3b1ff42f9b6mr2955399f8f.22.1751473722739;
        Wed, 02 Jul 2025 09:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH509kf9vFGj6z4R6xZfwGPmfKpg2fLP7ZQfSUt7IFbDwWC1CAH/5JCS3EUz2u2b0JuI21xGg==
X-Received: by 2002:a5d:5888:0:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3b1ff42f9b6mr2955367f8f.22.1751473722074;
        Wed, 02 Jul 2025 09:28:42 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.130.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c8esm16610161f8f.55.2025.07.02.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:28:41 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:28:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 3/8] vsock/virtio: Move length check to callers of
 virtio_vsock_skb_rx_put()
Message-ID: <g3h6k6vqfxwqsvojptaqy63qsn2vwo7i45segjgwjgmotysmwr@dmgbwacytag7>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-4-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701164507.14883-4-will@kernel.org>

On Tue, Jul 01, 2025 at 05:45:02PM +0100, Will Deacon wrote:
>virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
>packet header is not zero even though skb_put() handles this case
>gracefully.
>
>Remove the functionally redundant check from virtio_vsock_skb_rx_put()
>and, on the assumption that this is a worthwhile optimisation for
>handling credit messages, augment the existing length checks in
>virtio_transport_rx_work() to elide the call for zero-length payloads.
>Note that the vhost code already has similar logic in
>vhost_vsock_alloc_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> include/linux/virtio_vsock.h     | 4 +---
> net/vmw_vsock/virtio_transport.c | 4 +++-
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 36fb3edfa403..eb6980aa19fd 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -52,9 +52,7 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> 	u32 len;
>
> 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>-
>-	if (len > 0)
>-		skb_put(skb, len);
>+	skb_put(skb, len);

Since the caller is supposed to check the len, can we just pass it as 
parameter?

So we can avoid the `le32_to_cpu(virtio_vsock_hdr(skb)->len)` here.

Thanks,
Stefano

> }
>
> static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index bd2c6aaa1a93..488e6ddc6ffa 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -656,7 +656,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>-			virtio_vsock_skb_rx_put(skb);
>+			if (payload_len)
>+				virtio_vsock_skb_rx_put(skb);
>+
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


