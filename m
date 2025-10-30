Return-Path: <netdev+bounces-234254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E8C1E26A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7ED400D75
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68332BF46;
	Thu, 30 Oct 2025 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzEOCXLD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7C32ABFE
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792036; cv=none; b=RJr+fCg6XPMpWhWyahnQ8463VAZYk+jRaaxRVcRYK9m59zJvJ/vkI17BLpSzO+UK6OC13gAqsIBffv++G72W1AcbXK3haMjDbqJu37kA8K+OwZItO0p+0gYmtPWns8EwCA+UnnLaHck6ZbgTUqVpGwYaml7L93aqS9CtxVrVtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792036; c=relaxed/simple;
	bh=dM/PC+xgLDFQa74JGMOEWbPEyQbhx65hYn2Ifshodvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gchjPXrvbZTQEcrHSqlosp6JOn01d9EmUGNXkjIzjoUAB66ftjBhBRvIAYuXStigvruWvFHY8m4tb3digcY6wZjZdZ+10b7QwfxDEsQuMGQaFxONGdfBoRbu6yNV94ai8/fKxrSLdtf7gBYJ5bnWd71/4dfsDjL6GmBNKWT/7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzEOCXLD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s8hKYa9ITmFWQHj91VS7CotRvqtXLR4K9Qz/fibwBY=;
	b=YzEOCXLD9OKm5qisatFUDWQGGk46OUdtM4KFkFxnGzYhmqn4b1yMnVR2zlmLFcYm+41yGO
	KY4vcU4owCX+fSGRCutFik8qzEuWPPtvZUPuAvbvveiZ6Nqc/Bzb9nv2Uhpum7mtnZSh0O
	nh/YQDewipYOyMkAi7Mlw7+meCMcIZ4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103--dRFBhcjPkKvTJ5_woZddQ-1; Wed, 29 Oct 2025 22:40:28 -0400
X-MC-Unique: -dRFBhcjPkKvTJ5_woZddQ-1
X-Mimecast-MFC-AGG-ID: -dRFBhcjPkKvTJ5_woZddQ_1761792028
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33d8970ae47so602308a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792028; x=1762396828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s8hKYa9ITmFWQHj91VS7CotRvqtXLR4K9Qz/fibwBY=;
        b=TBfRteMp/1UpPnE/D3YEvH2Ga1Ggl8zAbKgvfOn6fmzHQuc2uu/46+vftOjqyLrRmD
         PAz1s0XYKM/p5ahbLt5S8yfagHuSsgjQfYaitEiRp/ULj7ufC6aREOPmqj512+JWG6i2
         kmTGjYJsSj3VRQAurgZWguF3YPVVz2j2bK6tUD5CfnxM4lNwd4szeiFXcyRsBPWtU3Sl
         SNf3pi5B8+C9WfzH5kiLfPmq/RzhCW7jm2LFNBzIPVck+QanEolJUqWtUvuEeQuVs1gB
         6N78ZwSaToNIs1+UzzM+JWpBg+0GDudZwZYO9aeaIll2BoVHBitei+VWVsTzqyUX1F1R
         n0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWBLLDV93paZxZN+2OoHJxRJl9fD4GJPp8cC1JDw9uu4yz4gGd/bFBDAOR+RFhfN9rJwzuqGpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQgffnQg/vBdh3A2SSvbrJUk4OnQOMEq7ZobCXIZHOs1I27G5
	BEsp88kIJUELgvg4r0RCNL7Sxnd2lP8ybwbzsfcsYd6a01fOCcuMR/X6NrwRKMA+SEnlAbdMY3u
	m66ofKiODFzTvVw+lejQ2mURdlEdLoIDKmM9elCJMdgmr5kf66BzTJW5UMr+CpAU79/n5dxaXiq
	75FeN6+gyg6V6+6L8qxmLQzEJI9ECyrvoG
X-Gm-Gg: ASbGncsXLYJFqi1QgRxEQuCL9nM2dEBBn3/iJLjs5BboNCBGf4Qnra4KVRVcQRnX2lY
	uGhVAn6DVcDdH6zfBHGyZ0Yh6PerckNTQZsvDl7E34WUW8Tx1ojBLcSnsnbiYx5vqOlM0IMjpOA
	t4EAZD4n/JBFb9Qd0b6qeg1kZSjNRu51Im18PtJyF24q/gnou9EU6EOTNf
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id 98e67ed59e1d1-3403a2a22a8mr5144781a91.22.1761792027556;
        Wed, 29 Oct 2025 19:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdZBU+hUTBze+ZZkKwu5UhZkdiKIT5O7KOjW1YBOrYbWd5C2ghkE1vXaxfsDpwDAAagjZ/xZ641rpd3lEA94=
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-3403a2a22a8mr5144766a91.22.1761792027079; Wed, 29 Oct 2025
 19:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029012434.75576-1-jasowang@redhat.com> <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
In-Reply-To: <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:40:13 +0800
X-Gm-Features: AWmQ_bkmfB-ebhx_3KwfLp1OlCEHIG3UAVOBmcyIQzJgycGoPag4AUi2K5pwkoM
Message-ID: <CACGkMEsTd6uCOCre8HK=5G14zu+xVOPOORZ2xcV_n9Kg6w8F5Q@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Paolo Abeni <pabeni@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/29/25 2:24 AM, Jason Wang wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > Changing alignment of header would mean it's no longer safe to cast a
> > 2 byte aligned pointer between formats. Use two 16 bit fields to make
> > it 2 byte aligned as previously.
> >
> > This fixes the performance regression since
> > commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> > virtio_net_hdr_v1_hash_tunnel which embeds
> > virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> > shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> >
> > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Whoops, I replied to the older thread before reading this one.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

I apologize, build will be broken since

commit b2284768c6b32aa224ca7d0ef0741beb434f03aa
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Oct 22 11:44:21 2025 +0800

    virtio-net: zero unused hash fields

I will prepare a new version.

Btw, it looks like there's an uAPI change that may break builds of the
userspace:

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h
index 8bf27ab8bcb4..1db45b01532b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {

 struct virtio_net_hdr_v1_hash {
        struct virtio_net_hdr_v1 hdr;
-       __le32 hash_value;
+       __le16 hash_value_lo;
+       __le16 hash_value_hi;

We can have a kernel only version for this but it probably means we
need a kernel only version for all the future extension of vnet
header?

Thanks

>


