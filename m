Return-Path: <netdev+bounces-285742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMwbL6iz/WkrhwAAu9opvQ
	(envelope-from <netdev+bounces-285742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:58:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9FF4F49B2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0655130A2428
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E3388360;
	Fri,  8 May 2026 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyBJviON";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7IyCD+C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D33815C2
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233999; cv=none; b=eGmN1Xj/AiMouJyHLiRsKNrSLRRnvzPEb/gWPH90LUecVyX21mymPt8oiTwFLGXCiW2qj01TqSctbfi5CSmYpmRpbVoJj/lr6JKHFK/CFqCqVAdW+Fy4nnFQMPFYErlZHk9lLqQLbXELGsqR8JgQZbYTaR6BIXWx9p5JaFPmWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233999; c=relaxed/simple;
	bh=/OQGL9Ug5guHVsgSUU3ndeXFHMMS3syMhC0ocsSKEXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz4I9XAAcj0PfNZRB+IA1n8hz9gtBxq1o0lnuKzfbjSG0mOkm5rGYr5vgZF0u+D4ajQWh/0w+oAjdUeJ1DXoSClpau0OzV4PDwcT8pQdP67X566ci/HwCOoEu2OaAVpPJG1utQDGmCm0UwM1jkQWs8iSPpmIE+jQr7rSRTJHTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyBJviON; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7IyCD+C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778233994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClGJlcvL8tePgqMC/W/O2L5Yb8uwFAsbIWgSrr8FGUs=;
	b=WyBJviONYowjwS0T+S5sg2WMb0VuXuU54Ui9vuE0mo3RM27WqYdgIDt6/IaTiwzH+w2W5o
	VvFz5zWd3KAkoYk2G6MFWrwlTcAwyJXDqmEFXIJQEd0/Tv9UNGaqyovQlQczclI0Zio8Km
	zqdJc5uPWA9e6CDDlyzTfb6+tC1VT0g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-hAVaLRyBOpORgj2cr-eNQA-1; Fri, 08 May 2026 05:53:13 -0400
X-MC-Unique: hAVaLRyBOpORgj2cr-eNQA-1
X-Mimecast-MFC-AGG-ID: hAVaLRyBOpORgj2cr-eNQA_1778233993
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44b2b38648eso1428595f8f.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778233992; x=1778838792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ClGJlcvL8tePgqMC/W/O2L5Yb8uwFAsbIWgSrr8FGUs=;
        b=Q7IyCD+CUyZ8g895Wu2sFa3+JI+jqnAcrSDpEd02FBmshjmRKhw/UOhMhCCLVjXn+K
         ik+Dw30++0HSdM/Rgcsi5q2YaxPlQeHYdIdYD4M4I9wYtj9JC1SeBQeAfjVJkhGpa5qJ
         rZ0qDOvtBep/Jm6+0Dr1x6VKor6FNRac2SBQiFq6tSydACZRv79xzPT90mCt/BIDLSvr
         OQFyjdp8ZV0ZWPpEGO2Dj2ON7hCvONU3NYvf8VALzupN6cNSRhO+rY5/nr8TO7h/uHw4
         HDwgcpEh3KIYXoe5W17H6KI05dU+xUoX1+ICxEVqMRSwio5dq3/WY9Jgvn/xcj1pxPED
         LW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778233992; x=1778838792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClGJlcvL8tePgqMC/W/O2L5Yb8uwFAsbIWgSrr8FGUs=;
        b=KRzlssaqkCS7BLyf0zVXPTkHwtuihKoH1Ww4tt9mCuFB+eHM4dlLMOjHHKqtlIPXC+
         t346S9DKsNssUfJS1lA5diTqm+SMlJKR7wYZWYR6yWZVXTVPo6+FR0Hk/e/t6S9P2WaQ
         ofQQic7t4wFjym0fvjkJ8I8/UAv26VPR2wPw04NBFq7UOJnSSg41tA0m+ubY32ibpKrq
         sbkaXhsrOgcBCCw+QGy2oVsxSX5ntzVUE9Wwo9+g27CFVLVHs//0EH8zlurvrG4OXhFm
         PZdoD6kriNGhRFgAjqCIcs/zpsLcR0/9vO4r+SfLjNotnTp0KamoQKwW0Eiwi3w9TNgX
         hufg==
X-Gm-Message-State: AOJu0YwEafpN9VdoG9dzOkdzJpszN9BmYvN6rbaQiK0jLBIK/eyXpI7O
	WohI3JULO3u9WdCbMvTBIj+91nZ7zHwPW/KRUUjIDVvwz3xg1liBa5EBgpf7AEmb2ROq+mzl45T
	SrSYGCXqVsWaaxjNlF5qI5WhLAk0Hju2ewfsg+qV97uljgUEEdF3i1QggBZCLmudXYw==
X-Gm-Gg: Acq92OEo9zz7t52yzSJorWqRg0sozBQqYPXWZl4xcuFDpnbMZNJ2W/OGMWFVTSOK18r
	ad1zFo9XRnN9F2Of8D3e83zdvBh3qPLWvVa2zgWAKjNVXqnQEsZQXOBNGUUhKW6XqvA40SulLK0
	stb1pxsBQOE48h6io2aSKT6yLWcCZJNQnFs/zFkO/R1/dAHu4RsaMfDqhaTOLieXKDhD4D2xEJJ
	UMSc4uqX70VzKRDfjh7pAvBOZkQ6xJGVVI/U3FXX5exvWb0hqYbCB+1aiHpcsLjbV/whD4I1Yk2
	SHHERjJJJzU40OMI2qVJivdYY4X0fNN7MKsOsl3A7O5jvN3ql0zxrx6Jy64CwEy0XxwAINOUfLB
	TOhZrWVvOOw/l2wLV/wkpjFfdm85rkGJpFb+MF103
X-Received: by 2002:a5d:5f48:0:b0:43f:e43a:f4a6 with SMTP id ffacd0b85a97d-4515b056ca6mr18864527f8f.6.1778233991930;
        Fri, 08 May 2026 02:53:11 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:43f:e43a:f4a6 with SMTP id ffacd0b85a97d-4515b056ca6mr18864455f8f.6.1778233991308;
        Fri, 08 May 2026 02:53:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm3110679f8f.14.2026.05.08.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:53:10 -0700 (PDT)
Date: Fri, 8 May 2026 05:53:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260508055125-mutt-send-email-mst@kernel.org>
References: <20260508092330.69690-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508092330.69690-1-sgarzare@redhat.com>
X-Rspamd-Queue-Id: 5D9FF4F49B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285742-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
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
> This also causes failures in tools/testing/vsock/vsock_test.c.
> Test 18 sometimes fails, while test 22 always fails in this way:
>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> 
>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>     Resource temporarily unavailable
> 
> Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> size of the RX buffer based on the overhead. Using it in the acceptance
> check, the advertised buf_alloc, and the credit update decision.
> Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> The function returns buf_alloc as long as overhead fits within the
> reservation, then gradually reduces toward 0 as overhead exceeds
> buf_alloc (e.g. under small-packet flooding), informing the peer to
> slow down.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


unfortunately, this is a bit of a spec violation and there is no guarantee
it helps.

a spec violation because the spec says:
Only payload bytes are counted and header bytes are not
included

and the implication is that a side can not reduce its own buf_alloc.

no guarantee because the other side is not required to process your
packets, so it might not see your buf alloc reduction.

as designed in the current spec, you can only increase your buf alloc,
not decrease it.

what can be done:
- more efficient storage for small packets (poc i posted)
- reduce buf alloc ahead of the time

> ---
>  net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..94a4beb8fd61 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	return ret;
>  }
>  
> +/* vvs->rx_lock held by the caller */
> +static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
> +{
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
> +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> +	 */
> +	u64 total_budget = (u64)vvs->buf_alloc * 2;
> +
> +	/* Overhead within buf_alloc: full buf_alloc available for payload */
> +	if (skb_overhead < vvs->buf_alloc)
> +		return vvs->buf_alloc;
> +
> +	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
> +	if (skb_overhead < total_budget)
> +		return total_budget - skb_overhead;
> +
> +	return 0;
> +}
> +
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
>  
> -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> +	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
>  		return false;
>  
>  	vvs->rx_bytes += len;
> @@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
>  	spin_lock_bh(&vvs->rx_lock);
>  	vvs->last_fwd_cnt = vvs->fwd_cnt;
>  	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
> -	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
> +	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
>  	spin_unlock_bh(&vvs->rx_lock);
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
> @@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	bool low_rx_bytes;
>  	int err = -EFAULT;
>  	size_t total = 0;
> +	u32 rx_buf_size;
>  	u32 free_space;
>  
>  	spin_lock_bh(&vvs->rx_lock);
> @@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	}
>  
>  	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> -	free_space = vvs->buf_alloc - fwd_cnt_delta;
> +	rx_buf_size = virtio_transport_rx_buf_size(vvs);
> +	free_space = rx_buf_size > fwd_cnt_delta ?
> +		     rx_buf_size - fwd_cnt_delta : 0;
>  	low_rx_bytes = (vvs->rx_bytes <
>  			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>  
> -- 
> 2.54.0


