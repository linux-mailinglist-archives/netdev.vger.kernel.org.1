Return-Path: <netdev+bounces-226739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295DBA4950
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C08174D0A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145124E00F;
	Fri, 26 Sep 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hj/NhLVB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7D248F52
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903353; cv=none; b=sfKYNOpEBRFVLg77D8Yf9bCOvOPanUul2QxY0EMlg7Ai+jqzyUApkCyDIiPaw9H1t42DxEj1bHFZDAaqPwQZbxb55lUCnNiiBuNS9kR4X2MW4tFVXRky5BrcY5zfVj5HCWBwCWTJkj/+BLhk0WBSMIbycBYi7T9ANx62ft4nIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903353; c=relaxed/simple;
	bh=de5+oDDVsgvGv8gkgdX1kmDXXsYWScA7Vf9sIiPm1sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG/xcQv9rFHql2O95A97GzlzE/WY1R7WLSN7+iywKhpXnY9a3nHC/XzR5Arvuokbnpk6xG/7T+5pXSg2g6tTnCsPM4rjQJby1d5cweLJYL6OGIJ355YrlP2WKzhu29rBcRiqfMxwlnJBJ0JtRME4rQBpRtfPkt4qn5wWHkEJ75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hj/NhLVB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758903351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d1MsLjQnmPTfFCIHbux9eMDbdADdPspQOJNP4rI8N8o=;
	b=Hj/NhLVB1E5ZWq1MSO5Kd2FCgb8bHixvp7xSM1oJ2uUobqMm4BoR619/bK5f65yr54GTCD
	SPACY/+dsS9XypFrGdVrKfLfxlT5RW+2DBQ7qzb/wXa/RNUqvEJEmnFRdEZC1SYEsVrZrV
	M+ewdbIZgCv76H0vxhN/It5AMzprfkQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-yGTIBkFvNLSYR18jjI4SlQ-1; Fri, 26 Sep 2025 12:15:48 -0400
X-MC-Unique: yGTIBkFvNLSYR18jjI4SlQ-1
X-Mimecast-MFC-AGG-ID: yGTIBkFvNLSYR18jjI4SlQ_1758903348
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45df7e734e0so11303125e9.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903347; x=1759508147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1MsLjQnmPTfFCIHbux9eMDbdADdPspQOJNP4rI8N8o=;
        b=GQ4EE1DC4fiYzXRDvSoHxWX/nn3Oupg7m67D2Q1hYgfmA9WtaEZsxb1XycpiesVCou
         qWl/YrqRz+HP7chodBCyVKU3jZCpOduLrcBrtuqwcUAZuY2xqbqZ9BNQD5igocOO6Icw
         xRnjee8j/Ym+4oVyZcWKc2UhYlWvmbzEVjfrgkAZY9utQA0nTKP5gHLtiz4sicZvyviA
         QwexOlaaGtjPzsxtc7C2VmCoctrt+Rs1e6zog0eWTFFZ0vbpeoQPZHP83NntykcaoPCe
         xv9hxAz0KIOtACOYbOTvBoksY+MXmds2d01e28nmp5mBWl1obhpwdBKDHvKqBYx9SnjG
         lxHg==
X-Forwarded-Encrypted: i=1; AJvYcCUZID24zQGLw67rX1tpLoURprO0nGhQruusBDAw5PqN1HaoCZlOR7dHFPHi1qjwlx2WJ4zkegg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsZ/7AHkFNWaAOkLOIWtJoDnotU4wQ7qHjI8srs+HKi0fHrjc
	f1jp8L6ksh5fD7Oe7ED+u34QvVSH9WXEiUuSt5HHJ+LSvpHgTAXDiEPPOqvdd5/af9WRhY8BVkJ
	y+PzrXZpOoX4VvAFSO0Pn7ctyoNxlt4TwMXnipYPS/O1ElBLi09y33O8igg==
X-Gm-Gg: ASbGnctrzitXNIq4D69IPN/QmvPkaT/LEeSy4D4mOJ9ZdkzoGW0N+7uQPw3c5bUyjWe
	YlJf6a5PGy61EbkFXi8dsKahk6vseTKr0baOccj2UViDmivglDfaRokEkmfN3lAbC+0XWSyXuUD
	iCOYdlyPf2jQVyE9pjT86KgErsN0Das9kastSVrhXxZJtCDQojaSaD9eNSglEco4p3UhXSQ6Uk6
	zpjkdev3nJ8VoaZ/j03MRCaOH6ZrMm7UCdd2hz3BKFGUKnWoYd55/8Z+gKKfkrN52WQ3qV7tV1M
	RGBnVOu6FGrWfXfD4kikibnpIbGht1vJTdvYSw0S
X-Received: by 2002:a05:600c:444d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46e3299a5c0mr65455125e9.4.1758903347574;
        Fri, 26 Sep 2025 09:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTjqxVm23Seu1emihYmKwo45GTVLo85bMBuuc3NdcYCq5ID+za/F9XBnzGN2W1Z6Hc9IxXiQ==
X-Received: by 2002:a05:600c:444d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46e3299a5c0mr65454655e9.4.1758903347022;
        Fri, 26 Sep 2025 09:15:47 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf70dcsm78264455e9.23.2025.09.26.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:15:46 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:15:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	g@sgarzare-redhat.smtp.subspace.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 2/9] vsock: add net to vsock skb cb
Message-ID: <bnsgxged7onwkc4jxxttt6b5yb5ct5xekhybdhcduy75rwwprh@u5o6o3gtgvlj>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:46PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add a net pointer and orig_net_mode to the vsock skb and helpers for

Why? (Please try to always add the reason we are doing something in each 
commit to simplify the life of reviewers but also for the future).

It takes a lot of time to understand why we need to store these info for 
each skb.

>getting/setting them.  This is in preparation for adding vsock NS
>support.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v5:
>- some diff context change due to rebase to current net-next
>---
> include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..ea955892488a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -13,6 +13,8 @@ struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
> 	u32 offset;
>+	struct net *net;
>+	enum vsock_net_mode orig_net_mode;
> };

This structure starting to get big and isn't optimized in terms of 
layout. Since it's basically in every packet, should we start thinking 
about optimizing this structure?

Thanks,
Stefano

>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
>+}
>+
>+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
>+}
>+
>+static inline enum vsock_net_mode virtio_vsock_skb_orig_net_mode(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode;
>+}
>+
>+static inline void virtio_vsock_skb_set_orig_net_mode(struct sk_buff *skb,
>+						      enum vsock_net_mode orig_net_mode)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode = orig_net_mode;
>+}
>+
> /* Dimension the RX SKB so that the entire thing fits exactly into
>  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>  * rounding up to the next page order and also means that we
>
>-- 
>2.47.3
>


