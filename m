Return-Path: <netdev+bounces-114011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13B9940B2A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C721C22D73
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4081922FD;
	Tue, 30 Jul 2024 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGkpZbVp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB41922E9
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327730; cv=none; b=qMjtMXOj4S7tnJU251tnUu3pfvq9FV2bb4ITK12Tga3Ejk0Y8ef+mn1YPWVUIJTVxV662JWgzgJKI4v6RvgQNwnYfA+WBi+TSS0UiMh+rymlRBYiZZkhtD7JD/uqFswhfnywLmZ4JxqbnHJk0xeJDIzshWRF01ovGVwykLobrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327730; c=relaxed/simple;
	bh=zlLvkfB6nHfIqOkTOl9zHCG1pW4blpqkJHvz6DHFM6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEC4FMm2CDiZW6IC2ttLW/R+5FpeSjza8SFhY5L0zQ5td/7zZW4GZUIqCuQO84wYL1VR/LP6ki7Z7S1A/8jZm3mGq9hu75A5XHc85tsY2+R4xb0fwsFVdJxHd2F0jxEPMRBeryF+zKxWUl/1RT3NsBL4xjKlq7fSw/4waG69RhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGkpZbVp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722327727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/IhPTVrwNuelKzGXqZiTkO3FsriRH/0wyKH+Wqzb38=;
	b=CGkpZbVppZh28Oi50sCbV9J2NgNluHoTxTJHIgisVuEU1r+h15NkDzujUWvgHyNExhrgzx
	hI5xN4AzPEQayp/VcTPYrKA9MGp/XzaM/7jqFoSyQmQGetLQ7CbK96TPEUOyczXhCEb0ZM
	uepk1zAS6Ub+iLTrU19qT1AYwb6ehJY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Lb7VvDwkNna9bgWKVABENQ-1; Tue, 30 Jul 2024 04:22:06 -0400
X-MC-Unique: Lb7VvDwkNna9bgWKVABENQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso23598085e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 01:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722327725; x=1722932525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/IhPTVrwNuelKzGXqZiTkO3FsriRH/0wyKH+Wqzb38=;
        b=NMMNwCRcwk0phhKJ35tfxu5E2PeicswngQM6dzTJx6TBA/tduP3gBRHN4HLrc+2V4m
         GV5wPelhdod5jArPDJb4j+U+BZv6EcPUPGT6SJNU00GbfBC0lwgnDL+zaICY75yJzkKr
         Sv6Yl3AwR6u8ZpBh8+meXmkELb2ALPyDxRQ94TNVvjz831Dgbar9lO589epHG1i5VfPu
         WPyILqr28eGKHRLLKyLXeck1LgXL9G9RdRblqsITgWnuDUYshpgwYt+iDxRCvdcp5VNa
         rU0iNU5PmqA72R+Crxyrc2/hgjUZGB+Dv4BmJyD4dNovArHscoTIiDwGw7b3TK2Q4bgZ
         VD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFO/yNjozTHxQ6BP+WAgr99Hqrx8po1MBsTmTkGlVF1XjrnuZSFO50Cgd6PHelrcc6DQVIv+/d+FQotMCtelFzmbdRZwv2
X-Gm-Message-State: AOJu0YxAX6qnDcdz8VMg+C/wCdNVlr9TpfJYvaC9Sb2dPukUoNGfXGyH
	+dI2RaAZAIxOZIieZrJt02VFEcxpS+lHE0C+6edNdtVRO8+KmnVtyZ3ygHBY25qsP1MNB5cXfFO
	RWT1auh3CUA7e9ua/F2yTkq62ErMARpqGIFLEqxfoeBSiXfKYUoZVCQ==
X-Received: by 2002:a05:600c:1551:b0:426:59fe:ac2d with SMTP id 5b1f17b1804b1-42811df6feemr91230795e9.32.1722327724761;
        Tue, 30 Jul 2024 01:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG73W9sSA9j5TadFSq8iKvQdv6b7fO7acNXZOSHElpNXTnzHiZQyX55WqKLZtnIzVAJf9toA==
X-Received: by 2002:a05:600c:1551:b0:426:59fe:ac2d with SMTP id 5b1f17b1804b1-42811df6feemr91230145e9.32.1722327723937;
        Tue, 30 Jul 2024 01:22:03 -0700 (PDT)
Received: from sgarzare-redhat ([62.205.9.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42824afbe9dsm6396745e9.1.2024.07.30.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:22:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:22:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 07/14] virtio/vsock: add common datagram
 send path
Message-ID: <obbppqyhstsuh3p3p4v6ipu7gl4z2ufeubvpv3dftyxubdvs5n@f7ugbp62xos7>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-8-amery.hung@bytedance.com>
 <bpb36dtlbs6osr5cudvwrbagt7bls3cllg35lsusrly5pxwe7o@kjphrbuc64ix>
 <CAMB2axPwUV9EusNPaemLVx5NN2_1wkq0ney4NazAj7P+WRo=NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axPwUV9EusNPaemLVx5NN2_1wkq0ney4NazAj7P+WRo=NQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 04:22:16PM GMT, Amery Hung wrote:
>On Tue, Jul 23, 2024 at 7:42 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jul 10, 2024 at 09:25:48PM GMT, Amery Hung wrote:
>> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >
>> >This commit implements the common function
>> >virtio_transport_dgram_enqueue for enqueueing datagrams. It does not add
>> >usage in either vhost or virtio yet.
>> >
>> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>> >---
>> > include/linux/virtio_vsock.h            |  1 +
>> > include/net/af_vsock.h                  |  2 +
>> > net/vmw_vsock/af_vsock.c                |  2 +-
>> > net/vmw_vsock/virtio_transport_common.c | 87 ++++++++++++++++++++++++-
>> > 4 files changed, 90 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> >index f749a066af46..4408749febd2 100644
>> >--- a/include/linux/virtio_vsock.h
>> >+++ b/include/linux/virtio_vsock.h
>> >@@ -152,6 +152,7 @@ struct virtio_vsock_pkt_info {
>> >       u16 op;
>> >       u32 flags;
>> >       bool reply;
>> >+      u8 remote_flags;
>> > };
>> >
>> > struct virtio_transport {
>> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> >index 44db8f2c507d..6e97d344ac75 100644
>> >--- a/include/net/af_vsock.h
>> >+++ b/include/net/af_vsock.h
>> >@@ -216,6 +216,8 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
>> >                                    void (*fn)(struct sock *sk));
>> > int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
>> > bool vsock_find_cid(unsigned int cid);
>> >+const struct vsock_transport *vsock_dgram_lookup_transport(unsigned int cid,
>> >+                                                         __u8 flags);
>>
>> Why __u8 and not just u8?
>>
>
>Will change to u8.
>
>>
>> >
>> > struct vsock_skb_cb {
>> >       unsigned int src_cid;
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index ab08cd81720e..f83b655fdbe9 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -487,7 +487,7 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
>> >       return transport;
>> > }
>> >
>> >-static const struct vsock_transport *
>> >+const struct vsock_transport *
>> > vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
>> > {
>> >       const struct vsock_transport *transport;
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index a1c76836d798..46cd1807f8e3 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -1040,13 +1040,98 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
>> > }
>> > EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
>> >
>> >+static int virtio_transport_dgram_send_pkt_info(struct vsock_sock *vsk,
>> >+                                              struct virtio_vsock_pkt_info *info)
>> >+{
>> >+      u32 src_cid, src_port, dst_cid, dst_port;
>> >+      const struct vsock_transport *transport;
>> >+      const struct virtio_transport *t_ops;
>> >+      struct sock *sk = sk_vsock(vsk);
>> >+      struct virtio_vsock_hdr *hdr;
>> >+      struct sk_buff *skb;
>> >+      void *payload;
>> >+      int noblock = 0;
>> >+      int err;
>> >+
>> >+      info->type = virtio_transport_get_type(sk_vsock(vsk));
>> >+
>> >+      if (info->pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>> >+              return -EMSGSIZE;
>> >+
>> >+      transport = vsock_dgram_lookup_transport(info->remote_cid, info->remote_flags);
>>
>> Can `transport` be null?
>>
>> I don't understand why we are calling vsock_dgram_lookup_transport()
>> again. Didn't we already do that in vsock_dgram_sendmsg()?
>>
>
>transport should be valid here sin)e we null-checked it in
>vsock_dgram_sendmsg(). The reason vsock_dgram_lookup_transport() is
>called again here is we don't have the transport when we called into
>transport->dgram_enqueue(). I can also instead add transport to the
>argument of dgram_enqueue() to eliminate this redundant lookup.

Yes, I would absolutely eliminate this double lookup.

You can add either a parameter, or define the callback in each transport 
and internally use the statically allocated transport in each.

For example for vhost/vsock.c:

static int vhost_transport_dgram_enqueue(....) {
     return virtio_transport_dgram_enqueue(&vhost_transport.transport,
                                           ...)
}

In virtio_transport_recv_pkt() we already do something similar.

>
>> Also should we add a comment mentioning that we can't use
>> virtio_transport_get_ops()? IIUC becuase the vsk can be not assigned
>> to a specific transport, right?
>>
>
>Correct. For virtio dgram socket, transport is not assigned unless
>vsock_dgram_connect() is called. I will add a comment here explaining
>this.

Thanks,
Stefano


