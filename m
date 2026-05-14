Return-Path: <netdev+bounces-288016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMvXEf7jBWoAdQIAu9opvQ
	(envelope-from <netdev+bounces-288016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:02:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50628543AC8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 246663061961
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D4E42846A;
	Thu, 14 May 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGuNL/tp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDVuhKSM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAC427A15
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770649; cv=none; b=TgwJEZJUVL+nr/PDRdVzqdl79cDD6Cjb3hW+sxwudqEff1cqX/lOLU/EArkeOd1xfdgZZb8gVwZt0rbs3j9dA95bUBhfuMykGpzGkv26uy3bgWKz2Q764DZXeWLc0ufKXww+2kcdJII0ux2C+GgSET0G7lql8eTI7jOFsdnryzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770649; c=relaxed/simple;
	bh=nLXZoA7D/cDYw43SD85/ZPvjSgooaZlgPDLded852xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn9TJIgFW7/c0nqZb8CrZwMrrTx6CLE+wAL2T1EeYtEyk/7c1Nx5HhCTfd2KcQ+EuqWV/hAe3JHK/DU15mAHVZ9IblW1mJdi6JtZTnAkrfuOyPK9/0PxPdkFkLmHlSC10anAPyuCVZbl8VsAqoAklsivkm43ibCoDCDNFnzm8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGuNL/tp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDVuhKSM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778770647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
	b=jGuNL/tpzLTKOftLKPCZIHI/J5mzwTa+Gu7S1F/8s9XnkG2YGPANop6aMCCfloocKbLDy8
	haqvBICpTodfgvIr5En5yoAzAmEv0tSod8M+Hv89VBEA0EELwybEXR9s4htU8RssCAm7jE
	8H7I+GSYVXvUt2N/IUeov3KXfk+Fpto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-brtuClJ4PQ2Ff9EP1bG3bA-1; Thu, 14 May 2026 10:57:25 -0400
X-MC-Unique: brtuClJ4PQ2Ff9EP1bG3bA-1
X-Mimecast-MFC-AGG-ID: brtuClJ4PQ2Ff9EP1bG3bA_1778770645
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so15293855e9.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778770644; x=1779375444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
        b=iDVuhKSM9t5MgrSgxZi+p2hWSo7fsdgj6B1hoHDHxuw9CRMIPC/muKehai7nM+OPHe
         FTM4Xva8X2gfTuCj9PPMvSOnf2ttzvBMsHOfqMCorpQ5zbCOphjA7p2KnWepZJGKFdr6
         Pi5PO9Q94eOrUqpHwO+eTRPv2bYw13VH83V8raZnBekj8kpWG/6Kxoi+5VGxzvI6NB0v
         Feo9jiTMWVwqMcbg3lYo1+8DSy7fBdw60E26XJVme2WpW/+jCf42LYShRW19IMyIV/j0
         mTjURLxh3ApRHG/wkB3zfaD0tNkQ3ZH4YOiy8YC2Ddcq4R6aQnCjwX9SvVjWa6tl7r+5
         F0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770644; x=1779375444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
        b=TcyF/2qbCQb9OxatgugK32FbZnLxZ6va+7qbjOVWTVuWJr7BD1lAJ3vVNQQ9rzfpSC
         2c0VXiflOoGB3hYC7XUjN8G6S34kuRZsClR3Sl/GRmI0l9iqieGzpc/jvqWnyVRP/tnx
         53dBYGXYFNOaoXjbO1YIBtuvxfjv39woCNYDAvg65b+ndLq/wTSEOMmgeqEV54oQRUVY
         pncMzeKR5jXD1uqfeTUFGEC3yzZkppgVxZjhggo17kTQDBpzUGQBQmC4MxY5cqIthKMr
         Mux5zkpf9tIW16e5D68HYaewYHv2qUNzRu+ab5GTJNkjfylYyeYeWrr5TatH6f4Lh+o9
         BDcQ==
X-Gm-Message-State: AOJu0YzzZrt9t/QuHxq+5pC4csk/48LJ1KaCzeoB9DSdjA3S7DcKoaf5
	OD8E1I7xn+dv++Gdijh77fwFdbgyMz1i3JE+F8FrVUqUmtScBALX77Z8lAgdceXNaCcNwKte8Tm
	BM+L833d9p5E7CjFYiwTDbM304Zamzg+9ZFPbEfKnig7pWARxBZrV7O7O9MYI22SrfearzKCt8/
	EkepcELyJs4/Ub7/PyNXo/kYGvfOXoMuIcGj/bZcZymg==
X-Gm-Gg: Acq92OEadXZUVDLPx4SBmHV6I5T2LwlPsceDa2dOCkZaumtlt2KlkfFxqZIQE38kQ4i
	cWPPy31cyiwPtJMSAwa6+jz2M0y4z4tNAJjVzZSluR6IjiKFBXnlKsF604h9KVZrl3yLC9Vb0ja
	fgratcpioTodZTE/p7mOJHa1ZtRoL8+P73h1/lBu8uq8m5ZLH/sANrLeYfBX5Mzr5+LaCM3oA8E
	GAT7X00OWTYRubwHjEjZgD8I5yW8Mrv89ZDYbejhhbiAcgGsKwvsfnhBRubHeF7CqWqGFBMyLYu
	LW8rYyzKaWrZ/OGRnui86bQEZHHPztT8AAHZpV5XjWTS8hLiLaLFb8e7mGxQJPBsxNNmnZrNDYt
	aKY7l58OeGmN9bwZkDP2RkFyn/YgWfwZ3vuiegn12vWg7QeI8bFoICyDvl3P3wMcnSUmfuP4Gug
	==
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fc9a3abb0mr125552905e9.19.1778770643914;
        Thu, 14 May 2026 07:57:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fc9a3abb0mr125552375e9.19.1778770643409;
        Thu, 14 May 2026 07:57:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4657f3fsm3313895e9.6.2026.05.14.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:57:22 -0700 (PDT)
Date: Thu, 14 May 2026 16:57:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <agXh36gUe1K6__Bk@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513105417.56761-2-sgarzare@redhat.com>
X-Rspamd-Queue-Id: 50628543AC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288016-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>When there is no more space to queue an incoming packet, the packet is
>silently dropped. This causes data loss without any notification to
>either peer, since there is no retransmission.
>
>Under normal circumstances, this should never happen. However, it could
>happen if the other peer doesn't respect the credit, or if the skb
>overhead, which we recently began to take into account with commit
>059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
>is too high.
>
>Fix this by resetting the connection and setting the local socket error
>to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
>packet, so both peers are explicitly notified of the failure rather than
>silently losing data.
>
>Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> 1 file changed, 14 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 989cc252d3d3..4a4ac69d1ad1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> 	return err;
> }
>
>-static void
>+static bool
> virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 			      struct sk_buff *skb)
> {
>@@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 	spin_lock_bh(&vvs->rx_lock);
>
> 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
>-	if (!can_enqueue) {
>-		free_pkt = true;
>+	if (!can_enqueue)
> 		goto out;
>-	}
>
> 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> 		vvs->msg_count++;
>@@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 	spin_unlock_bh(&vvs->rx_lock);
> 	if (free_pkt)
> 		kfree_skb(skb);
>+
>+	return can_enqueue;
> }
>
> static int
>@@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
>
> 	switch (le16_to_cpu(hdr->op)) {
> 	case VIRTIO_VSOCK_OP_RW:
>-		virtio_transport_recv_enqueue(vsk, skb);
>+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
>+			/* There is no more space to queue the packet, so let's
>+			 * close the connection; otherwise, we'll lose data.
>+			 */
>+			(void)virtio_transport_reset(vsk, skb);
>+			sk->sk_state = TCP_CLOSE;
>+			sk->sk_err = ENOBUFS;
>+			sk_error_report(sk);

sashiko reported some issues related to setting TCP_CLOSE state and not 
removing the socket from the connect table:
https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com

I'll change this by calling virtio_transport_do_close() and 
vsock_remove_sock() in the next version.

Stefano

>+			break;
>+		}
> 		vsock_data_ready(sk);
> 		return err;
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>-- 
>2.54.0
>


