Return-Path: <netdev+bounces-303576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jQ2qFXPoRGq52woAu9opvQ
	(envelope-from <netdev+bounces-303576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:14:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDBE6EBF9A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:14:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gtRUTBBJ;
	dkim=pass header.d=redhat.com header.s=google header.b=DPvHkkfH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303576-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7C823022913
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435FE403EBA;
	Wed,  1 Jul 2026 10:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A7403135
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:14:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900842; cv=none; b=c6rj4M2Ec5ec3Asd7tMnA3QjkN3os6ylH1rMFFLlw1reROw7rD6F/M8XZRfA1thoiqk3CO7dezU5M4r29YKuFSb3BiGCMJGWBoKzOj8si2Bt3cg/rbYF6G6k5WXthQSAuL6D16pEfHSgkhe2UwXOl3IUP5+R6zx0kaEdn86Afwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900842; c=relaxed/simple;
	bh=GBtUTmM/TptETllHS9g9icbUVF6l6FK8VygeaCK4Sl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYQyqkqQ5hQjyzICaHWZENLfJNlQWQ6Y7MN6aQAGJ0LKeh5ikik21XSi0zVpzGeJgj0mffsXHIgcS76kGwCFOiLzrRZHYz7DI+E73mBq/dGj58rVUpgd8iux7iHG0EGy/70R8yVxy5cll5wOvcEtaHvX0iACJvGiPxbYiTXVHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtRUTBBJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPvHkkfH; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782900839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZP4pVQuwbXb6A4JsfHgerWuH1Q6CnZ/ETjBsK07QGkY=;
	b=gtRUTBBJLBuQWUDXKV+tfNrjyl1UvzPifDaqwH0ShIEqvMLKWR9TmYSWaEGazDn2I2sNRN
	gUtAn0xO9x7LpcKs2uAXFnmA6vzVflMZ5M3T+MH8fUiv67EOX84PZet3RKI80FV7r7ewqF
	yXx/Fi0umMqYXM/K/obzWFnDescrAsk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-OJfXWee5M56RKt_dujnZkQ-1; Wed, 01 Jul 2026 06:13:58 -0400
X-MC-Unique: OJfXWee5M56RKt_dujnZkQ-1
X-Mimecast-MFC-AGG-ID: OJfXWee5M56RKt_dujnZkQ_1782900837
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so5159405e9.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782900837; x=1783505637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP4pVQuwbXb6A4JsfHgerWuH1Q6CnZ/ETjBsK07QGkY=;
        b=DPvHkkfHNwMOjDZcwEIuYacYuTY7o/OZrC7BLApt/+6KldTcxvKUGh+y65IOoauaaJ
         ToKPV0aQk9cZ0JJQUNCuFwjeAo7RVGvwW8lmymzgn6WSqS8V2EMlKtpf8B7N49Hz2vKY
         5v7rzzuVd1EBwMhU+rPvrd7d0kQbImXVNZnUpjEDvC9Tm6AP/2MmYI1O4+odJVVpFvuR
         JQtIDsqfougB2mZ8NRk+qKc8xXvPN2LRgHcEFy0WwXgzZunZsPNTM/7ovKp3adPiFZ35
         nmNE2v6nW7VgkSyq0WJw15jCeutWN52K3XDDWvJ6tQGL0eg1udv2ZDypMvGi13PL2UcL
         CPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782900837; x=1783505637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP4pVQuwbXb6A4JsfHgerWuH1Q6CnZ/ETjBsK07QGkY=;
        b=Bojwe5MNICbAfT6ytfhNtjkwSmAA1cCkvkNkULpYdaSqCIToVXFA+xY5J0y+15x3tB
         TsUKH2iXD/tCJwrXLcaU1lnoU7ZXBimlKuUsQaLmpdrLntNKbUUGPjWgaaSUHlr+tQ+1
         u1CRwPXDUGA8XB0ESu+uf/WJ4BZcaIyCNMX67mB/9vTjScuUerY2Fzsn7YFQl1kbHcEj
         yfG922ufDum+jpq6wr+MPw7TpOlazrmKBpO2W54mwHtOuq49mw9GbsSod7RkHr93Qg8N
         xe9sFcH8kSVACwr7nPo0SkvihbQOYBAsn+nRB+pEqiRNmbj9XS6CT0K6uND4PWqzx1EJ
         o+BQ==
X-Gm-Message-State: AOJu0YzAW1w/jgwde6/d4T8xv0j9FXFbN4D7XFeITxjiYFOOPztqYc/p
	jn4crmp3tePL9nycbE+ybrLnJ5Q8RR5aXQ1T6+T1ziJRB+ACuSsGYzSBu57XZ2TNqlaVfqYzmM7
	P+bJ/GsvJzVAR+nYOrhwvfPeZnUA/39VWvQwR9xAokgAtkiHxdE3NwsxxWw==
X-Gm-Gg: AfdE7clDpR3Wqp3tYBhHEdUndwtKZIRKXiEtbrvC5wq3OXPZf6V+Zvq8Jvw6Bu7Drit
	A1Wl17CpMu2jreG1ym8F8laKCQR08TyP4mNTaTf6YEONje9tmnUwXxWNBydIoPHVYpUkKg/AhXD
	9IP4wkmVMaIdboQbnMVxWMfkTE1tqfJCu5FRzUmj9kn60NUXnrE8rzCkwCehKe7HyGjbjkurUMg
	9iJW0BByQtaKOHdSPv4Z0tUGAJBGSwDyPWtkjig21TxIScwbe7Vsosd82OqZUeJ2r7+NUd4MUhl
	EVagBHkQHCa/oG1/0xwSuX7jn70X9Xyt+GmBkMbZbx4T/NAN65tLd75/qI34t4mVoPsC91+8Q2t
	Hg+QbfB+6eomw2Eqcf+3k9LH5YB01U7XyHCSMMR/LyRs/my31rrpZFAf/K92h
X-Received: by 2002:a05:600c:4f83:b0:493:c064:316f with SMTP id 5b1f17b1804b1-493c230bb07mr13955765e9.3.1782900835840;
        Wed, 01 Jul 2026 03:13:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4f83:b0:493:c064:316f with SMTP id 5b1f17b1804b1-493c230bb07mr13955285e9.3.1782900835180;
        Wed, 01 Jul 2026 03:13:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm91335615e9.15.2026.07.01.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:13:53 -0700 (PDT)
Date: Wed, 1 Jul 2026 12:13:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akTMf-DWZVAzYIPu@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <6a6be4b0-e02d-46ca-b8bf-c27bd681d253@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6a6be4b0-e02d-46ca-b8bf-c27bd681d253@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303576-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:kuba@kernel.org,m:mst@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:eperezma@redhat.com,m:stable@vger.kernel.org,m:brienpub@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,lists.linux.dev,linux.alibaba.com,google.com,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCDBE6EBF9A

On Tue, Jun 30, 2026 at 11:53:04AM +0200, Paolo Abeni wrote:
>On 6/26/26 3:48 PM, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When many small packets accumulate in the receive queue, the skb overhead
>> can exceed buf_alloc even while the payload is within bounds. This causes
>> virtio_transport_inc_rx_pkt() to reject packets, leading to connection
>> resets during large transfers under backpressure.
>>
>> The issue was reported by Brien, who has a reproducer, but it is also
>> easily reproducible with iperf-vsock [1] using a small packet size:
>>
>>   iperf3 --vsock -c $CID -l 129
>>
>> which fails immediately without this patch but with commit 059b7dbd20a6
>> ("vsock/virtio: fix potential unbounded skb queue").
>>
>> Inspired by TCP's tcp_collapse() which solves a similar problem, add
>> virtio_transport_collapse_rx_queue() that walks the receive queue and
>> re-copies data into compact linear skbs to reduce the overhead.
>>
>> The collapse is triggered from virtio_transport_recv_enqueue() when
>> virtio_transport_inc_rx_pkt() fails. A pre-scan counts the eligible bytes
>> to size each allocation precisely, avoiding waste for isolated small
>> packets. Partially consumed skbs are kept as-is to preserve
>> buf_used/fwd_cnt accounting, EOM-marked skbs to maintain SEQPACKET
>> message boundaries, and skbs already larger than the collapse target
>> because they already have a good data-to-overhead ratio.
>>
>> [1] https://github.com/stefano-garzarella/iperf-vsock
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Cc: stable@vger.kernel.org
>> Reported-by: Brien Oberstein <brienpub@gmail.com>
>> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
>> Tested-by: Brien Oberstein <brienpub@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
>>  1 file changed, 146 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 09475007165b..304ea424995d 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -420,6 +420,137 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	return ret;
>>  }
>>
>> +static bool virtio_transport_can_collapse(struct sk_buff *skb,
>> +					  unsigned int size)
>
>Why passing a `size` argument here? AFAICS the actual argument is always
>a constant and IMHO rightfully so.

This comes from a previous implementation where this was not constant.
With the current code, I agree that a macro should be better.

I'll fix it.

>
>> +{
>> +	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
>> +	 * or are already large enough should not be collapsed: they either
>> +	 * need special accounting, carry protocol state, or already have a
>> +	 * good data-to-overhead ratio.
>> +	 */
>> +	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
>> +		return false;
>> +	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
>> +		return false;
>> +	if (skb->len >= size)
>> +		return false;
>> +	return true;
>> +}
>> +
>> +/* Iterate through the packets in the queue starting from the current skb to
>> + * count the number of bytes we can collapse.
>> + */
>> +static unsigned int
>> +virtio_transport_collapse_size(struct sk_buff *skb,
>> +			       struct sk_buff_head *queue,
>> +			       unsigned int max_size)
>> +{
>> +	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
>> +
>> +	while ((skb = skb_peek_next(skb, queue)) &&
>> +	       virtio_transport_can_collapse(skb, max_size)) {
>> +		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
>> +
>> +		if (len > max_size - target)
>> +			return target;
>> +
>> +		target += len;
>> +	}
>> +
>> +	return target;
>> +}
>> +
>> +/* Called under lock_sock when skb overhead exceeds the budget. */
>> +static void virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs)
>> +{
>> +	/* Use the same linear allocation threshold as virtio_vsock_alloc_skb()
>> +	 * to avoid adding pressure on the page allocator.
>> +	 */
>> +	unsigned int collapse_max = SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM,
>> +						  PAGE_ALLOC_COSTLY_ORDER);
>> +	struct sk_buff *skb, *next_skb, *new_skb = NULL;
>> +	struct sk_buff_head new_queue;
>> +
>> +	__skb_queue_head_init(&new_queue);
>> +
>> +	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {
>
>If the queue is relevantly big, walking all of it may take a significant
>amount of time/cache misses and causes traffic burstines. I think you
>could add an additional stop condition, i.e. when the current queue size
>is below a reasonable threshold (allowing the current packet to be
>inserted plus some more slack).

Makes sense, any suggestion on the threshold?

I was thinking something like this: merge until we have space for at 
least 2 skbs (because for now we estimate the overhead based on the 
number of skbs, but in the future I'd like to support truesize), but 
still trying to fill collapse_max as much as possible.

Does that make sense, or should we be more aggressive?

>
>/P
>
>> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
>> +		u32 src_len = skb->len - src_off;
>> +		bool keep = false;
>> +
>> +		if (!virtio_transport_can_collapse(skb, collapse_max)) {
>
>Minor nit, possibly something alike the following lead to more
>compact/more readable code:
>
>
>		keep = !virtio_transport_can_collapse(skb, collapse_max);
>		if (keep) {
>

Yeah, so I can remove the initialization to false. I'll change it.

>> +			/* Finalize pending collapsed skb to preserve packet
>> +			 * ordering.
>> +			 */
>> +			if (new_skb) {
>> +				__skb_queue_tail(&new_queue, new_skb);
>> +				new_skb = NULL;
>> +			}
>> +			keep = true;
>> +			goto next;
>> +		}
>> +
>> +		/* Finalize if this packet won't fit in the remaining tailroom,
>> +		 * so we can allocate a right-sized new_skb.
>> +		 */
>> +		if (new_skb && src_len > skb_tailroom(new_skb)) {
>> +			__skb_queue_tail(&new_queue, new_skb);
>> +			new_skb = NULL;
>
>Possibly introduce an helper for the above 2 statements?

Do you mean something like this?

static void virtio_transport_queue_skb(struct sk_buff_head *queue,
				       struct sk_buff **skb)
{
	__skb_queue_tail(queue, *skb);
	*skb = NULL;
}

Not sure, just for 2 places, but if you prefer it, I can change.

Thanks,
Stefano


