Return-Path: <netdev+bounces-236446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C88C3C602
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 283CC351F18
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B1350A2F;
	Thu,  6 Nov 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmhtNpeU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VymvqmNg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D5350A04
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445818; cv=none; b=BtV8gZWyk3xiHNWhIPXYVaNMRlb56xW37drh1scTbijGNTSMgDFZfC5IHL6KMj7pgcHXRTKhZSWR/Mowee4GVTqYObVz48GqI4q/xo1yUWZH0sEDvsvuR78n8ePouHrx4YncM0N1ABx//VCaHeIcyGJFHQWaHhvbm8FMnmgPdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445818; c=relaxed/simple;
	bh=Z7eSKPc3txhBUxRtndXMLROsssDroOhR9kPjB1j/JTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVKHUfndvWS3afTIGu+NJLwK5IWW8q812CUVRgmb3ocCrjGg9m4VilR1b8rjO65w9VfSNcQ0Qusk7QUzeLAPN6xz5NsW96Q8ofsoY2kY5Rs0VvFGE+ObR7LLyeHFSfQBypRiiFnyvQisdozBfd4lZoVffOIJC0Vm+II1j9b5wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmhtNpeU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VymvqmNg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
	b=OmhtNpeUs+PM6bBH7kVV2nG6vkeEkmaNL//dvm1595BdP3FIHc/CaddHzqyTU6Fkb89F0b
	nyLrPG4EYYhhsTfemJDnijIgfqNq7OS22pZA9bLt1g/Bj6JcuTH7ejy5WZuV9ECa8J+HGH
	kFV8xeGbwH2fUxcNPXZecuXhU08nS9E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Q52VwIBROgiUEa8rJK809g-1; Thu, 06 Nov 2025 11:16:53 -0500
X-MC-Unique: Q52VwIBROgiUEa8rJK809g-1
X-Mimecast-MFC-AGG-ID: Q52VwIBROgiUEa8rJK809g_1762445813
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47717c2737bso6517515e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445812; x=1763050612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
        b=VymvqmNg37y7eS2CDMedoy/aiAdzCNcQO87H+g09/o6vS7bajlOfh61Na8jNasEcVJ
         r3TTVcdnMz462HK3JQM+Gv/tA6qdQMLyapqammQItHrgHNpMRbbmhDDuRvjA8s6G3sex
         rfGJyPY7TeB6WRfQqAyNc+N+bwIVwsURvQf54EiF/GmhyOKUXzNfgI02JUDVei/8FB0t
         6AEJdGsohKvsfqoSA8iXHUs+ReG7y57B8KBmUWyeFZhG3ghv6AnQ0L/BvlpfodwqMW5o
         sjWHsdySeJYbUo5czTerygXBXvqWCwiDjR+G4cjPKsYX+2jSpUKNoN2eCLcZadHrOn6X
         yUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445812; x=1763050612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
        b=VbVikUn97azkYBoDhh+53jLnck1pZawi+WD/kzp4+U1nNCJ4fDIk8RtKD/y+1eVGhE
         WKr2vfwh/od2nFmAWe0B9yKZXZGNqCvCe7WUY4gOkrHG/Tm8odjzkcqg67e7uMUEKL8i
         YtY/hIDikp+EyKjoFh46lrh8ZdYNRo/eTu2GyUxFmm/SgbqP1JOw2mr1ID0oNx6+RjcZ
         YuGc/4HtzHIRl4VmBGskiS60EKPOsV+MsGr/tKmz1P7FlpWkdxwcZDmV+ZhPxVDXL74R
         nPwEkutR1Gq4WAcA1RfA7/oe13Ly4zqr7+ArcTt3Anz7Gbf3nfnAWL9MpH3c5p3ka96Z
         GQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeUaF6u1998PnOMwRsBT4vJ/o9MyRdHLAxy+bBz5WJ2UW678N5VLfXDntbScl/Qiu1tu0GtD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqZOLny2DM/yhLfDwAEk70kNvQ2xIv6ZtFWeRiLuT1Fmk3NvG
	loR7nQjcZyTFi22szjZl4+2828PITulUWYF3ZCGT7KC30FKJW9Sjw17UHCDbqA0uzf0Bfi5/tvT
	wMIG4wy8muPiIAt3ZYV16dMNlpDNjyj4lHUfgflq2EsYhoHLxJ/Civx8h4g==
X-Gm-Gg: ASbGncuWhGF/vBvST9JuaOA3nSrQsIbv0vOhDawL0OmnyV4Pg/Zow3zUAsdpNlDhGdU
	m80fXltFYEYrC8fV79Sj6CY4WmW1E63cw54EAbI4wjJSyn9k2yCgDTtzP9xzKuB1aeNDN+6+6d5
	8mZcdwE+nJAGzQCBW8EfOq0XroliRuVpFmG2jyhCXHHIOWyC7SXqZ9eldzIaijeMJXrqxrralYA
	3qGSzNH60kMQiu+uG3gcfnorA4UcDhl3hWXHwI52jN8eJVlK7t8lFhzaZ6eEH3cSIVDKPQxRvMh
	xoXk+U5Yqlk+gh4pfDRg93qb5fNRiHWpuqGK22MtzFN3gg6upobvxD7MKTwWaMA5vo8T9oapKX6
	neQ==
X-Received: by 2002:a05:600c:8216:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-4775ce208a3mr70634155e9.41.1762445812531;
        Thu, 06 Nov 2025 08:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW3IYi/YdprfC2n+fzLAs5f0/Jy2gRulDCDLn2/BkchwC+aok0NFWkDfKX3ED9iPmszk8KKA==
X-Received: by 2002:a05:600c:8216:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-4775ce208a3mr70633685e9.41.1762445812098;
        Thu, 06 Nov 2025 08:16:52 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2fb8sm54077105e9.10.2025.11.06.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:51 -0800 (PST)
Date: Thu, 6 Nov 2025 17:16:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
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
Subject: Re: [PATCH net-next v8 02/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Message-ID: <ruxocfuprofj3mktmjulqy5dhnzkbad3fetqrg2f6kw4gh4wwj@x2mb2dw7pjk5>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:41AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
>grow, we want to keep it trimmed down so it doesn't exceed the size of
>skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
>additional two bytes for new fields at the end of the structure. It does
>not shrink the total size, however.
>
>Future work could include combining fields like reply and tap_delivered
>into a single bitfield, but currently doing so will not make the total
>struct size smaller (although, would extend the tail-end padding area by
>one byte).
>
>Before this patch:
>
>struct virtio_vsock_skb_cb {
>	bool                       reply;                /*     0     1 */
>	bool                       tap_delivered;        /*     1     1 */
>
>	/* XXX 2 bytes hole, try to pack */
>
>	u32                        offset;               /*     4     4 */
>
>	/* size: 8, cachelines: 1, members: 3 */
>	/* sum members: 6, holes: 1, sum holes: 2 */
>	/* last cacheline: 8 bytes */
>};
>;
>
>After this patch:
>
>struct virtio_vsock_skb_cb {
>	u32                        offset;               /*     0     4 */
>	bool                       reply;                /*     4     1 */
>	bool                       tap_delivered;        /*     5     1 */
>
>	/* size: 8, cachelines: 1, members: 3 */
>	/* padding: 2 */
>	/* last cacheline: 8 bytes */
>};
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/linux/virtio_vsock.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Yeah, thanks for that!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..87cf4dcac78a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -10,9 +10,9 @@
> #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
>
> struct virtio_vsock_skb_cb {
>+	u32 offset;
> 	bool reply;
> 	bool tap_delivered;
>-	u32 offset;
> };
>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>
>-- 
>2.47.3
>


