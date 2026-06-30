Return-Path: <netdev+bounces-303065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kUz/NiWSQ2qrcQoAu9opvQ
	(envelope-from <netdev+bounces-303065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:53:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8926E27B8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=C5umb2BG;
	dkim=pass header.d=redhat.com header.s=google header.b=flG5IDJ2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303065-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303065-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66AB13046C57
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6443E5EF3;
	Tue, 30 Jun 2026 09:53:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE438C437
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:53:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813195; cv=none; b=gT09+clc5czb7JwsXUPjA9JaMAq19eJJk+uTvN4tzFjuPkxBD0vyy2vMwRFAVBf3h+sAAVUF/vcBvqfvrEH1kdj9cHozPRxaYzxChaaTH1uUrYwdmV+9iA4nNemJqJXCyl0N+QQ2e0jsFb6ZNq4nff79arKpQ6cX55LjktkUoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813195; c=relaxed/simple;
	bh=NbDEHp0gquR5Nq2A/cm+7E2L5SZ1Jhgmv94kZhkUywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5OcmtHP8kJ5+r7QCj8zR0qwpYw2Gc2P4bxvtLkrANvCtkb238MuYN/ENt0TRKH5t2q60foORRjIxiAdYQLxPic3DXg3Sg5Ixcom+OXoTF1etj2oMnCCWDjAJxAAFAPnJTz/ZHsGmMzFBdPjRk3mSTW/4aZsdvgTxZWvjqPWoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5umb2BG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=flG5IDJ2; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782813192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
	b=C5umb2BGPMCRvH/AL2ijiS3Iy2RTgFJyXyE2AQmrw4nv273PJAV/8bLBAf21d5oeMWTcc7
	Y7NXcaq9vtEjPi7NU+Y2CI1HOFaY9COuAwFATAjL0AWE2NdOBl3Rcbb9wsOrvrgX2NmEmz
	6dMeiw8oDooP6bpOg74y/vcMmkZUeRg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-tM1qpzlGP-SOms5jchVBFA-1; Tue, 30 Jun 2026 05:53:09 -0400
X-MC-Unique: tM1qpzlGP-SOms5jchVBFA-1
X-Mimecast-MFC-AGG-ID: tM1qpzlGP-SOms5jchVBFA_1782813188
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4729d2a64efso275751f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782813188; x=1783417988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
        b=flG5IDJ2hqHW0esT+mbR1XlgzZp+A3gpWkh+I4LyDmUY21Ok86j1MXal/n3wpcvbPa
         EUfEzabuf4xebj87SDEHm8gtvrsUe3JJlOhC9XW/naZdU/qAdYABRt3JRjgiB6uS5eSN
         oQ8mCFg7JRyQGhnLjuOtQtZKIZJ15+bFVGrDmPlSAZOStGKRQAH3f+lwHDGwlDQKtyy/
         DnjcGAoFMdNagtSMyCZbOVIkxB5EOadqirFKlR1d8lZjD5MiAEB3IMBD0VMu6U5Cmq0j
         ZvPNlaeiVYrLdXgLH5msXPaVcUDBr9u8IZ3BCiKtFgBf0Dg7/FE/gq1cGS24n3hUHYut
         OYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813188; x=1783417988;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
        b=qi/eMJt5Ze9tKhIiVDjw7XiW2t/RCtdMQKSLMM2K6bvhuDKwstBP8pXBhHBzoTsgGg
         C/DM0rD8tHvCXeI1MJjz9AbikZoHC5+GrlAIkYW/Un2tfIcqWlAzIPutU3PHljSt42OA
         q8U8fA4nF19GvEdTe24FjS/iL/3vTc4wKxxOtuZh1aD5ceXqGlFRAW51O207XDj5+kzG
         ahA+XXlfbmpIPtJDlolacjqnd1qOPxIWY0H2468Q+16Z75Ru5SwBDwaeeGWay8y5hU8M
         Jh1kmAETqfzcqjQJQDY2lzyIrHGu6umo4vOSPw4iS+enaWaYUvNhGtqK/cqNX0RTDAXe
         ypDg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6TVSD62xkbMOWGu9zrFXYmnaQZwJTgranGICgQ46o2jSyIlClW05NEV6dsxMbPwEDzLyqPtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyclt+N/WvNMhIt9DEjyoc8y4lJOGN26yewKDJtbHfGeRrpZLr5
	hJ/4Gam5/iNec+7dzwrMMiozxO3IZHkRURmXRqTA08VeASoAAObw0vw859j/K+QA8lQSndnoIS2
	6rlJwhTHL1BcOsAkdBmcqyhe1HhFGc8XOpQUumuC5Sj6RtMK4RPW/AIn0dw==
X-Gm-Gg: AfdE7cmmkBQoi2n4m3BdM2JjVVzdeWG9CPYLBVHM6Mg8g0TmrJTsb4nzz/N2/oQP6EP
	u1I4KvQz/j7fMP0ko4MRJrGjTShzcyKmY8W0DXgzAhWhpqqOQ6UtVBvK/5QSlxx42EaqDUexzWp
	r1MtfmZq1OV/Ja0owcvzBiZHS0pSvRE4xY82MKwWCHZHZ9Tb2XgOBjrDIGNrYCMa+TrYZFMLCpy
	6IvmmKCqpTklEHL0k3MUJ8isXIiXaYzGqEFHVgikijT7kPp6BQIPla1aKUsj14DGSLrjC0XMrtU
	LGVi8K+Vfb+hK2VBPl+gdq3QSPvAf56SCW99wSCSeCK05pcLQ86dE0csqIJp1fylz+yL3AiXWP1
	6H602+JEHiCdZvS0fFOHAMRx32LPBr1XVyWF0AznbTM2b28NaNc5j26GRneMNFTUvRFIjZwRDg5
	cJmXWxXX9weQ==
X-Received: by 2002:a05:6000:1847:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-475f4fb5d50mr1344060f8f.5.1782813188245;
        Tue, 30 Jun 2026 02:53:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1847:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-475f4fb5d50mr1344016f8f.5.1782813187784;
        Tue, 30 Jun 2026 02:53:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf65sm6669391f8f.21.2026.06.30.02.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:53:05 -0700 (PDT)
Message-ID: <6a6be4b0-e02d-46ca-b8bf-c27bd681d253@redhat.com>
Date: Tue, 30 Jun 2026 11:53:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under memory
 pressure
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, stable@vger.kernel.org,
 Brien Oberstein <brienpub@gmail.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260626134823.206676-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303065-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,vger.kernel.org,lists.linux.dev,linux.alibaba.com,google.com,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:kuba@kernel.org,m:mst@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:eperezma@redhat.com,m:stable@vger.kernel.org,m:brienpub@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C8926E27B8

On 6/26/26 3:48 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When many small packets accumulate in the receive queue, the skb overhead
> can exceed buf_alloc even while the payload is within bounds. This causes
> virtio_transport_inc_rx_pkt() to reject packets, leading to connection
> resets during large transfers under backpressure.
> 
> The issue was reported by Brien, who has a reproducer, but it is also
> easily reproducible with iperf-vsock [1] using a small packet size:
> 
>   iperf3 --vsock -c $CID -l 129
> 
> which fails immediately without this patch but with commit 059b7dbd20a6
> ("vsock/virtio: fix potential unbounded skb queue").
> 
> Inspired by TCP's tcp_collapse() which solves a similar problem, add
> virtio_transport_collapse_rx_queue() that walks the receive queue and
> re-copies data into compact linear skbs to reduce the overhead.
> 
> The collapse is triggered from virtio_transport_recv_enqueue() when
> virtio_transport_inc_rx_pkt() fails. A pre-scan counts the eligible bytes
> to size each allocation precisely, avoiding waste for isolated small
> packets. Partially consumed skbs are kept as-is to preserve
> buf_used/fwd_cnt accounting, EOM-marked skbs to maintain SEQPACKET
> message boundaries, and skbs already larger than the collapse target
> because they already have a good data-to-overhead ratio.
> 
> [1] https://github.com/stefano-garzarella/iperf-vsock
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Cc: stable@vger.kernel.org
> Reported-by: Brien Oberstein <brienpub@gmail.com>
> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
> Tested-by: Brien Oberstein <brienpub@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..304ea424995d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -420,6 +420,137 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	return ret;
>  }
>  
> +static bool virtio_transport_can_collapse(struct sk_buff *skb,
> +					  unsigned int size)

Why passing a `size` argument here? AFAICS the actual argument is always
a constant and IMHO rightfully so.

> +{
> +	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
> +	 * or are already large enough should not be collapsed: they either
> +	 * need special accounting, carry protocol state, or already have a
> +	 * good data-to-overhead ratio.
> +	 */
> +	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
> +		return false;
> +	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
> +		return false;
> +	if (skb->len >= size)
> +		return false;
> +	return true;
> +}
> +
> +/* Iterate through the packets in the queue starting from the current skb to
> + * count the number of bytes we can collapse.
> + */
> +static unsigned int
> +virtio_transport_collapse_size(struct sk_buff *skb,
> +			       struct sk_buff_head *queue,
> +			       unsigned int max_size)
> +{
> +	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +	while ((skb = skb_peek_next(skb, queue)) &&
> +	       virtio_transport_can_collapse(skb, max_size)) {
> +		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +		if (len > max_size - target)
> +			return target;
> +
> +		target += len;
> +	}
> +
> +	return target;
> +}
> +
> +/* Called under lock_sock when skb overhead exceeds the budget. */
> +static void virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs)
> +{
> +	/* Use the same linear allocation threshold as virtio_vsock_alloc_skb()
> +	 * to avoid adding pressure on the page allocator.
> +	 */
> +	unsigned int collapse_max = SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM,
> +						  PAGE_ALLOC_COSTLY_ORDER);
> +	struct sk_buff *skb, *next_skb, *new_skb = NULL;
> +	struct sk_buff_head new_queue;
> +
> +	__skb_queue_head_init(&new_queue);
> +
> +	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {

If the queue is relevantly big, walking all of it may take a significant
amount of time/cache misses and causes traffic burstines. I think you
could add an additional stop condition, i.e. when the current queue size
is below a reasonable threshold (allowing the current packet to be
inserted plus some more slack).

/P

> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +		u32 src_len = skb->len - src_off;
> +		bool keep = false;
> +
> +		if (!virtio_transport_can_collapse(skb, collapse_max)) {

Minor nit, possibly something alike the following lead to more
compact/more readable code:


		keep = !virtio_transport_can_collapse(skb, collapse_max);
		if (keep) {

> +			/* Finalize pending collapsed skb to preserve packet
> +			 * ordering.
> +			 */
> +			if (new_skb) {
> +				__skb_queue_tail(&new_queue, new_skb);
> +				new_skb = NULL;
> +			}
> +			keep = true;
> +			goto next;
> +		}
> +
> +		/* Finalize if this packet won't fit in the remaining tailroom,
> +		 * so we can allocate a right-sized new_skb.
> +		 */
> +		if (new_skb && src_len > skb_tailroom(new_skb)) {
> +			__skb_queue_tail(&new_queue, new_skb);
> +			new_skb = NULL;

Possibly introduce an helper for the above 2 statements?

/P


