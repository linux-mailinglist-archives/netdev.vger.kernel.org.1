Return-Path: <netdev+bounces-287011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEJjIOLqAmpKygEAu9opvQ
	(envelope-from <netdev+bounces-287011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:54:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADA51D17D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17EB33009E1D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0839D6F6;
	Tue, 12 May 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVakvSMy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg+Zx+RI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28C38B15E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576088; cv=none; b=nj96VMBSlk/vu14fHQFHYbbZMH5PTQp2dR/VI6Xt4jr5ZoUXHJhlS9GXQde56alT5E0lriPdJzVSWDbODS8dD5OJHTZGRocrWZ5OyM32FVNTnyv3XGqC3QLIaUEtQStyzlM8lpWMYXX2bCwhUr0HO8LwjXcqu7BkUJQmrJgh6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576088; c=relaxed/simple;
	bh=0qkr1rENvV+pyeBAMi1jVWzvQVzUp0uGCFQaBamt9gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HehwcCyKc3j3GFWSFTLm1sLRGCWA0pDj1mzSBTAn7LYKy0yDe2YycwBrooWj20v8kNOQz6A4JcG7E8NYG3f6aD+rM8h4wzWQ9bg4lDst2XPinaYrRKzvvKE/a4igb+1lnAMX81EgGWAltj/7FBoSKLTJXjn83p+9VTkbuhsmL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVakvSMy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg+Zx+RI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778576081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
	b=jVakvSMy1AhZF6UNF94QF6T4dgV/Daviy/OZbkl6vhoY0vrX9ZhFa7Vmk+NZUlLy/7CzNN
	DmKgnnLjK4UA+jk4dLJk8zAGkJbmzVCqPMOmoxDPZIniS9f9ks9Gx2ItYOAD1dUUBltfm/
	Sldr3mpvLZIGFG7PcG+48jtxRZgOYZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-oow8Gh5EPwuYtCddvBuREg-1; Tue, 12 May 2026 04:54:39 -0400
X-MC-Unique: oow8Gh5EPwuYtCddvBuREg-1
X-Mimecast-MFC-AGG-ID: oow8Gh5EPwuYtCddvBuREg_1778576079
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48ebd55644eso766115e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778576078; x=1779180878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
        b=bg+Zx+RIWVRh7I/YGSd/26iZnRZEhEHXiRvTlID+SUfjBpSOmO8pYwqqp09uXCsY/W
         6/VeQqwR3TurQUfKHAdF4TbF7jjTzmaCFNB9tiYxc3M+TO+XcKo1ixYMQ65NQs/7/19S
         fktWErdgtPZaX7gQpETN6K9romTF9G3GbGTo/JaPCs1v21Fk9NQ0Y+I9mgbxkdRUmnSI
         geUqB3JGoXk/s2qQ2ZptNuvuMBy/dNE5jFBCX0M7ymjrucGxX2qSiOvt5PXSWki9wf/L
         LtUgz60MDmMnZeeduBQfMNuusssz2as5xnq5zwCWEtrXbM9UUPaiyjfdFozR45Y0mR5d
         5mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576078; x=1779180878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
        b=rrweE7eu1Ah7YIQqZ3DmILnFBL5AodfeQuX2bmwVAaYYl+KBk4yyIV/+J9xKd/Jtwv
         aJLKaPzzUa15TCXA4qO8koQg7rAKo1tnKOnIOkXmzV4ASpjNzWIvd0piumjzKrpb5ib+
         9iPqftCzlrnlEs0c5QQsVqgDe+eXXFs4eiZlhzd4kjzokkBCNRDhQt+c7QBQ7zGRVuxs
         Q9D6aVgbksQlbJUKGSB8okCBrsjrgewfCT8i0B7jccrquEZQcLasaUMU9J0W6tLEVRjE
         bavRsJgdv/BfPqO1zvj036XX0+3lmvhLlU+pkTvizH95ZlaFUWy+Nu4PW3sJZRjG80PQ
         YU/w==
X-Gm-Message-State: AOJu0YzWD6nsGPYMePE26uebKfEBnc7rMiaPJYUaQzyoNrs+TwiGbghD
	9ILFilKVCg6rN7pW4OE/LEX/qh4TjO7DljAv++wJfIs4IJfPwrjBUNtLvt2sLrf4AB9CLfjCvDW
	NRq+8vJ9zZbUvBs2hU5ZC2etjmqxHFHEWuBckO/CrBFaxhAmaJPrMbyaclg==
X-Gm-Gg: Acq92OHAi7xQj3cW8t4wyzMOAyluqbUr+GO63MKYn3GUtM2NLj6hlSEr4iLHI5Yyh03
	8U1zBFrXcjLkBncby/pE8sVTt/I6G8uu9qHJ3F5yw4/QjcbVen0A9lrnGK6zvYLV8ulZhnhRd2r
	IsgE4UgI1Swd5sxGdLmLdiT9B/18fypnxaQ/9saAwP88maNrLJt7cbMZR+jKAUnXDOrTa7cdduc
	jHf7uUD0gKILJ+0Hszv9mvsBnvRHFqjrxQTKS2HsvQxJR2CTrJq/YJbYVCIiLxT2poREzXHbLky
	3upk4IYTnhQ+tlMlxUfGmfevhQwj0kAA0iJlPVdChhkZj42k/fTqSQpwJz4jHbv8oCBb6EloIH7
	93vBC7dDoWN1Sp7dAXav20NTlknfpK8DFvzyBRRk7
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-48e51f4934cmr277143105e9.24.1778576078362;
        Tue, 12 May 2026 01:54:38 -0700 (PDT)
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-48e51f4934cmr277142775e9.24.1778576077739;
        Tue, 12 May 2026 01:54:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f410d9fsm17755735e9.6.2026.05.12.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:54:37 -0700 (PDT)
Date: Tue, 12 May 2026 04:54:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260512044008-mutt-send-email-mst@kernel.org>
References: <20260512080737.36787-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512080737.36787-1-sgarzare@redhat.com>
X-Rspamd-Queue-Id: 84ADA51D17D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> buf_alloc when checking whether a new packet fits. This reduces the
> effective receive buffer below what the user configured via
> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> silently dropped and applications that rely on the full buffer size
> to deadlock.
> 
> Also, the reduced space is not communicated to the remote peer, so
> its credit calculation accounts more credit than the receiver will
> actually accept, causing data loss (there is no retransmission).
> 
> With this approach we currently have failures in
> tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
> test 22 always fails in this way:
>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> 
>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>     Resource temporarily unavailable
> 
> Fix this by using `buf_alloc * 2` as the total budget for payload plus
> skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
> is doubled to reserve space for sk_buff metadata. This preserves the
> full buf_alloc for payload under normal operation, while still bounding
> the skb queue growth.
> 
> When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
> flooding where overhead dominates), the connection is reset and local
> socket error set to ENOBUFS, so both peers are explicitly notified of
> the failure rather than silently losing data.
> 
> With this patch, all tests in tools/testing/vsock/vsock_test.c are
> now passing again.
> 
> A solution to handle small-packet overhead efficiently also for
> SEQPACKET (we already do that for STREAM) is planned as follow-up work.
> This patch is needed in any case to prevent silent data loss, because
> even if we reduce the overhead, we can't eliminate it entirely.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for the patch!  I'd like to split this: 
1. buf alloc boost
2. reset when out of credits

this way we can revert 2 easier later.


> ---
> v2:
> - Close the connection when we can no longer queue new packets instead
>   of losing data.
> - No longer announce the reduced buf_alloc to avoid violating the
>   spec. [MST]
> 
> v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
> ---
>  net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..f23bf8a11319 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -449,7 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  {
>  	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
> -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
> +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> +	 */
> +	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
>  		return false;
>  
>  	vvs->rx_bytes += len;
> @@ -1365,7 +1368,7 @@ virtio_transport_recv_connecting(struct sock *sk,
>  	return err;
>  }
>  
> -static void
> +static bool
>  virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  			      struct sk_buff *skb)
>  {
> @@ -1380,10 +1383,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_lock_bh(&vvs->rx_lock);
>  
>  	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> -	if (!can_enqueue) {
> -		free_pkt = true;
> +	if (!can_enqueue)
>  		goto out;
> -	}
>  
>  	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>  		vvs->msg_count++;
> @@ -1423,6 +1424,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_unlock_bh(&vvs->rx_lock);
>  	if (free_pkt)
>  		kfree_skb(skb);
> +
> +	return can_enqueue;
>  }
>  
>  static int
> @@ -1435,7 +1438,16 @@ virtio_transport_recv_connected(struct sock *sk,
>  
>  	switch (le16_to_cpu(hdr->op)) {
>  	case VIRTIO_VSOCK_OP_RW:
> -		virtio_transport_recv_enqueue(vsk, skb);
> +		if (!virtio_transport_recv_enqueue(vsk, skb)) {
> +			/* There is no more space to queue the packet, so let's
> +			 * close the connection; otherwise, we'll lose data.
> +			 */
> +			(void)virtio_transport_reset(vsk, skb);
> +			sk->sk_state = TCP_CLOSE;
> +			sk->sk_err = ENOBUFS;
> +			sk_error_report(sk);
> +			break;
> +		}
>  		vsock_data_ready(sk);
>  		return err;
>  	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> -- 
> 2.54.0


