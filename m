Return-Path: <netdev+bounces-112617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B7693A304
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73A9285D00
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB5155C94;
	Tue, 23 Jul 2024 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWIqpL9c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C8155C8C
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745735; cv=none; b=Wp+7AnTdTqGxRwJOTdraemtRUQayXwAbL+4aZQ8QI+EVHLkbOzfCaPctnRcA3KZa+CXU7A4e9fMpn1ATn6UTqPXEYZrLXw32CVxCkHsIVZl7xQ98r81FM+vqvwQtIYvCtvtkwT41YqsdcEDbk2iOcC5pbDHaMO4YtSQ+ZnV7AKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745735; c=relaxed/simple;
	bh=CHALTMCrX1vY5jlI9iPcWZs2oNv9LvUYT1e9X1sN7+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBfibGICaZuyA0TFT8ZK5s0UAC509RBsbCOvupXMfTqrexGMUfae4xOwHVXlXCopyWKCKwImdBa0HxuhlV2aY5LnEeTNYAJHg3Y/XwG2mNbpAgRsaYtDaWQRDMcgmRJd6EuOwKB0soG8x2yG0Fs34DZMFYRVaXfeMZgurSTWGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWIqpL9c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721745733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbUg7e/tJ5pOz4Dg3u16mJqy+HPalD6htYuhg6ITzCM=;
	b=AWIqpL9cXXnj996WN+Y6P8W5L9e3LIjB/rAbtAZEUOKekP/6Y/6pMBfDKcYrS6MlX8PtLQ
	Rh1m/E6N/bNX09OOdXtdhv7kmx5KroJEimCosGMA4vu/CSMgFHHI273Uz0jjVlHDLazRUX
	THxKKymtLYWL0Z9jn+163A16lxtr3Tk=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-kwoAPSoINLS9xRlXfk7CRQ-1; Tue, 23 Jul 2024 10:42:09 -0400
X-MC-Unique: kwoAPSoINLS9xRlXfk7CRQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4f519ea76e5so889881e0c.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 07:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745729; x=1722350529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbUg7e/tJ5pOz4Dg3u16mJqy+HPalD6htYuhg6ITzCM=;
        b=q3CMU2JZGKlrnCjCF3uIwoAFU+/hQfvjaQjpwlCEYpFMBHyAAk2e7/NvnlJ+c8aM7c
         F9JG6iV4G8I5UFNdSQSFvijHrooVzkVOUMWF0qOmaT7my7+ccCY1VwJ8tfGdzLzFvDL8
         Mk9rilCxb5mKuO4sCRh3DCjzzqOuImLpaaLLfqNP774ddPTZY+oOYKQRLdVoPJrgamRH
         Cuteaxbc2d3YWMfK88/atXhUX8wEwCyICBYo+cbI8k7xiS93+4wAZoKJa9TDoX+ZvRCl
         KThlKSw2vRCom8R32KI0gH2XLutyiF8dejoe+eItc2rR2mVfDWnBuJ8C6jOKEROJUpFn
         x91w==
X-Forwarded-Encrypted: i=1; AJvYcCXv/4xqYtWpC/6cQ9hAG/I2lsnW13V7UQ1lLRZ+7ghJ0urnv8NamcLRvmaDNv7wn+386TbyNZuSGYlTYFDlfPiA/Prc5KSl
X-Gm-Message-State: AOJu0YwUwds3/R7lvIAxACWiD4Aim2UuEn5j268vXELymV3eD8bGK3Lr
	yQnrBgByqktza1m9jsyQDhue1DcgmJwMq+4A/ORkwrsKZTzcTnMGfD9Fkpn1EWP6RDaiqMeyxdN
	UurkuCtiWCteYiw6u6kp/n/VgiqV63CVAoaSk6wob0SXTP85vONXOUA==
X-Received: by 2002:a05:6122:411b:b0:4f5:254e:e111 with SMTP id 71dfb90a1353d-4f5254ee847mr7883012e0c.7.1721745729284;
        Tue, 23 Jul 2024 07:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBLlNaASMpCBTCeROjh0z7+DMfFqI5ijim7b74MbzA0Jd6atMGmiEs2Wq/F8Wn5UYNq4Bt9g==
X-Received: by 2002:a05:6122:411b:b0:4f5:254e:e111 with SMTP id 71dfb90a1353d-4f5254ee847mr7882948e0c.7.1721745728733;
        Tue, 23 Jul 2024 07:42:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd505d9sm45142171cf.58.2024.07.23.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:42:08 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:42:00 +0200
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
Message-ID: <bpb36dtlbs6osr5cudvwrbagt7bls3cllg35lsusrly5pxwe7o@kjphrbuc64ix>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-8-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240710212555.1617795-8-amery.hung@bytedance.com>

On Wed, Jul 10, 2024 at 09:25:48PM GMT, Amery Hung wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This commit implements the common function
>virtio_transport_dgram_enqueue for enqueueing datagrams. It does not add
>usage in either vhost or virtio yet.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> include/net/af_vsock.h                  |  2 +
> net/vmw_vsock/af_vsock.c                |  2 +-
> net/vmw_vsock/virtio_transport_common.c | 87 ++++++++++++++++++++++++-
> 4 files changed, 90 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f749a066af46..4408749febd2 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -152,6 +152,7 @@ struct virtio_vsock_pkt_info {
> 	u16 op;
> 	u32 flags;
> 	bool reply;
>+	u8 remote_flags;
> };
>
> struct virtio_transport {
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 44db8f2c507d..6e97d344ac75 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -216,6 +216,8 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>+const struct vsock_transport *vsock_dgram_lookup_transport(unsigned int cid,
>+							   __u8 flags);

Why __u8 and not just u8?


>
> struct vsock_skb_cb {
> 	unsigned int src_cid;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ab08cd81720e..f83b655fdbe9 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -487,7 +487,7 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
> 	return transport;
> }
>
>-static const struct vsock_transport *
>+const struct vsock_transport *
> vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
> {
> 	const struct vsock_transport *transport;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a1c76836d798..46cd1807f8e3 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1040,13 +1040,98 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
>
>+static int virtio_transport_dgram_send_pkt_info(struct vsock_sock *vsk,
>+						struct virtio_vsock_pkt_info *info)
>+{
>+	u32 src_cid, src_port, dst_cid, dst_port;
>+	const struct vsock_transport *transport;
>+	const struct virtio_transport *t_ops;
>+	struct sock *sk = sk_vsock(vsk);
>+	struct virtio_vsock_hdr *hdr;
>+	struct sk_buff *skb;
>+	void *payload;
>+	int noblock = 0;
>+	int err;
>+
>+	info->type = virtio_transport_get_type(sk_vsock(vsk));
>+
>+	if (info->pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+		return -EMSGSIZE;
>+
>+	transport = vsock_dgram_lookup_transport(info->remote_cid, info->remote_flags);

Can `transport` be null?

I don't understand why we are calling vsock_dgram_lookup_transport()
again. Didn't we already do that in vsock_dgram_sendmsg()?

Also should we add a comment mentioning that we can't use
virtio_transport_get_ops()? IIUC becuase the vsk can be not assigned
to a specific transport, right?

>+	t_ops = container_of(transport, struct virtio_transport, transport);
>+	if (unlikely(!t_ops))
>+		return -EFAULT;
>+
>+	if (info->msg)
>+		noblock = info->msg->msg_flags & MSG_DONTWAIT;
>+
>+	/* Use sock_alloc_send_skb to throttle by sk_sndbuf. This helps avoid
>+	 * triggering the OOM.
>+	 */
>+	skb = sock_alloc_send_skb(sk, info->pkt_len + VIRTIO_VSOCK_SKB_HEADROOM,
>+				  noblock, &err);
>+	if (!skb)
>+		return err;
>+
>+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>+
>+	src_cid = t_ops->transport.get_local_cid();
>+	src_port = vsk->local_addr.svm_port;
>+	dst_cid = info->remote_cid;
>+	dst_port = info->remote_port;
>+
>+	hdr = virtio_vsock_hdr(skb);
>+	hdr->type	= cpu_to_le16(info->type);
>+	hdr->op		= cpu_to_le16(info->op);
>+	hdr->src_cid	= cpu_to_le64(src_cid);
>+	hdr->dst_cid	= cpu_to_le64(dst_cid);
>+	hdr->src_port	= cpu_to_le32(src_port);
>+	hdr->dst_port	= cpu_to_le32(dst_port);
>+	hdr->flags	= cpu_to_le32(info->flags);
>+	hdr->len	= cpu_to_le32(info->pkt_len);
>+
>+	if (info->msg && info->pkt_len > 0) {
>+		payload = skb_put(skb, info->pkt_len);
>+		err = memcpy_from_msg(payload, info->msg, info->pkt_len);
>+		if (err)
>+			goto out;
>+	}
>+
>+	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>+					 dst_cid, dst_port,
>+					 info->pkt_len,
>+					 info->type,
>+					 info->op,
>+					 info->flags,
>+					 false);
>+
>+	return t_ops->send_pkt(skb);
>+out:
>+	kfree_skb(skb);
>+	return err;
>+}
>+
> int
> virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> 			       struct sockaddr_vm *remote_addr,
> 			       struct msghdr *msg,
> 			       size_t dgram_len)
> {
>-	return -EOPNOTSUPP;
>+	/* Here we are only using the info struct to retain style uniformity
>+	 * and to ease future refactoring and merging.
>+	 */
>+	struct virtio_vsock_pkt_info info = {
>+		.op = VIRTIO_VSOCK_OP_RW,
>+		.remote_cid = remote_addr->svm_cid,
>+		.remote_port = remote_addr->svm_port,
>+		.remote_flags = remote_addr->svm_flags,
>+		.msg = msg,
>+		.vsk = vsk,
>+		.pkt_len = dgram_len,
>+	};
>+
>+	return virtio_transport_dgram_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
>
>-- 
>2.20.1
>


