Return-Path: <netdev+bounces-307031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YnzHLeGNVGoFnQMAu9opvQ
	(envelope-from <netdev+bounces-307031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393D747C5A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:04:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=elMGwtD5;
	dkim=pass header.d=redhat.com header.s=google header.b=SD0Q8H7E;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307031-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307031-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A553006B4B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C2364EB8;
	Mon, 13 Jul 2026 07:03:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2014F70
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:03:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926229; cv=none; b=Go0G/oDvPqKlzCtGFlyBekZdeP+hR+kU9xohDfhoPmSJN/UjN9vCBoxQ/Mm57+/n3HbTW0zRNLenp7MSGvGoX9R3LZsVlqZJELt5VHRQq4BEJUlxJm5I+IJZjQ2/gZVqYi9mjU+GwHOH70BCLVHRQ512TFkblzYmvgrPzJW0lK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926229; c=relaxed/simple;
	bh=XAltKV3y8FSdHL+jgeaepInAipLiHYDq4x4AsEj42uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR1zwKpbDUjarMuF5HXVEKsf3vcchv4/yv4KywiYfktl6JIe1T48EWE4arNVG2xB41XxySXDCVmZld3vZ4HS18InuK/rHDC7HMG8RbVT91elPXvMRaKCMM+0j0k/GVEaLIwN5XgHYFHnQFJmekugHIydM1vrUIhNORYwC7a3iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elMGwtD5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SD0Q8H7E; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783926226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TlwN6N65SeENNgPEenYu+0ZsVJI+NoJdLzgKi+aNRU=;
	b=elMGwtD5wn1rrDICEkW9/N5qE29+eqsgMgfCaxCNOjD+tIpe8b/wKgUe6onrXawpPXMLzA
	b0P4y8dFLtLlq/1wQE7ClklFHDaBmtm2AvBLZ5kBBdqbGNrxYywWp3sNZeFlTLI2ynZFgd
	07r4Bzn96vbcE01Q3/ICyrfVYEjPxpQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-OHKngwOaPhK0G1XnjRBY4Q-1; Mon, 13 Jul 2026 03:03:45 -0400
X-MC-Unique: OHKngwOaPhK0G1XnjRBY4Q-1
X-Mimecast-MFC-AGG-ID: OHKngwOaPhK0G1XnjRBY4Q_1783926224
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472c330e555so1108786f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783926224; x=1784531024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4TlwN6N65SeENNgPEenYu+0ZsVJI+NoJdLzgKi+aNRU=;
        b=SD0Q8H7Evpg6pBlpzJPnr95tLrAohfWp5+G6znlewe2Q5/v1/rQeSGGNgAysz2sbIK
         v2N00+0pnfOUAoTNxvP9Qmb/ks+ZuGKUGAG085OGQXBtucM/12dAdR/7GqEcjY3h7ide
         1cXqMJ7E9Muh8+FAKQdUHMoTsN+XZ9eWSRJjqHBDbtBm7+Dnoib3i8l989RwqyA3SAOM
         1jQiIHZnHZrBk1gAS0vmZpl0a+3uWcWWAyfEWf1P91P/zm3aYVHpQoDd6gE5Qt8Jd0X1
         S9L+YIMngcYgP83Lx/6JnQx4Jd/iRUtPV5IV8Sb42z5b3zvBLGKoTjNYkyurP3vqaG5d
         cd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783926224; x=1784531024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4TlwN6N65SeENNgPEenYu+0ZsVJI+NoJdLzgKi+aNRU=;
        b=a91khHF5IwMh3fo54+Z1CkZUd3f2E6KZ0WcWj3VO8CIDWpy8wIkyr9hSqlqZj2yk1K
         T9qXHDMBqnrQbqO+9KbKoCZo/i2DiT3LADCsFKJYloPt0WOottzZHt8MU24mD1YrPpCG
         LD/tZJ8zlYykze/niyo8t8wppmzSFUOXBkrt6TTwm5wljoILDk6BIdk+vnVwh2LelbJW
         JgJjNIkdeaW6jtB6Q1Cm33bkYYIln3E4c8rSMiaxnXek9uzpy14qE1qU9nmHfhnDJcvx
         bwF7HvOO6ycVAOzq2NZIL7VXZlD2eFlNeBWmLKMIoOXHVtVfovT/YRZ980lW/p6beoU5
         iAaw==
X-Forwarded-Encrypted: i=1; AHgh+RoG7h8y3+ks1CY71QTZuBr0DcmerieSH96K5CzLZrFMp2CL4QtaJnAsAG9OYlY4M/B7MP70yek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwADeoBouWd7vj9aIlBCckLC8bTwBCKgKoAFfo3J5OOjaU/8dVs
	BCM8ZeWVfECk9VlR+3+1DFs1RSa4ycWbgCmX9zs/e8kjOXu2vsrHPtJcE7zX28V9Bd6GPSM/xgM
	fcswPQ6z/dm5ZZJdYmEwhUayr8HUobeHNq8I2bEmdzxSbnjd+a4WJ0Vu8/6dKuVxDP6XzmZg=
X-Gm-Gg: AfdE7clePk4woFsNhn8j8e5XIgVy6EKtMslUWp3yob3wxClRtHOgqpiypm0egHokD9w
	85mnUYd8EXNyuIedD1DCdTKj7SoyUWFxM9NlvgC1tp3UZrq0dzgi9rVPkt50UCh1LW9fjdj6VIh
	gd1vHfdGmZgFbV/DQjOpGdFniG/5nukaJ4AWT7261JBMJFlKK54RjUtHmQAhbeSER6Zg5B9c9rV
	sNmvh3l4OqttUiSwYHYEldBOfcExlLHXn3wgPA8byE/tfrPEnGuQU+xTadkJLtYrZY2wW9wLeDj
	i4xr3ELWLwB41zBQfA2uJH/K4gSibH/Wqg88b8LNd0ltQYr8WHECOPXB2k/kEIO/yWtexaJ62fw
	rFbo=
X-Received: by 2002:a05:6000:430a:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47f2dca8a2amr9019180f8f.2.1783926223887;
        Mon, 13 Jul 2026 00:03:43 -0700 (PDT)
X-Received: by 2002:a05:6000:430a:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47f2dca8a2amr9019121f8f.2.1783926223225;
        Mon, 13 Jul 2026 00:03:43 -0700 (PDT)
Received: from redhat.com ([178.132.109.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm87600991f8f.7.2026.07.13.00.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:03:42 -0700 (PDT)
Date: Mon, 13 Jul 2026 03:03:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: weimin xiong <15927021679@163.com>
Cc: jasowang@redhat.com, virtualization@vger.kernel.org,
	netdev@vger.kernel.org, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] vhost/net: Fill virtio_net_hdr GSO/csum metadata on RX
Message-ID: <20260713025549-mutt-send-email-mst@kernel.org>
References: <20260713010442.331109-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713010442.331109-1-15927021679@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307031-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:15927021679@163.com,m:jasowang@redhat.com,m:virtualization@vger.kernel.org,m:netdev@vger.kernel.org,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0393D747C5A

On Mon, Jul 13, 2026 at 09:04:42AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> When VHOST_NET_F_VIRTIO_NET_HDR is set, vhost supplies virtio_net_hdr to
> the guest but previously always wrote a zeroed header (GSO_NONE). Guests
> that rely on GUEST_TSO*/GUEST_CSUM therefore never saw offload metadata.

Right. Question is why are you using VHOST_NET_F_VIRTIO_NET_HDR?

> 
> Peek the socket skb before recvmsg and populate the header with
> virtio_net_hdr_from_skb(). Also advertise the corresponding guest offload
> feature bits from VHOST_GET_FEATURES.
> 
> TX TSO toward backends without IFF_VNET_HDR is intentionally left for a
> follow-up series.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> 
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -73,6 +73,10 @@
>  	VHOST_FEATURES,
>  	VHOST_NET_F_VIRTIO_NET_HDR,
>  	VIRTIO_NET_F_MRG_RXBUF,
> +	VIRTIO_NET_F_GUEST_CSUM,
> +	VIRTIO_NET_F_GUEST_TSO4,
> +	VIRTIO_NET_F_GUEST_TSO6,
> +	VIRTIO_NET_F_GUEST_ECN,
>  	VIRTIO_F_ACCESS_PLATFORM,
>  	VIRTIO_F_RING_RESET,
>  	VIRTIO_F_IN_ORDER,
> @@ -644,7 +648,7 @@
>  static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
>  			    size_t hdr_size, int out)
>  {
> -	/* Skip header. TODO: support TSO. */
> +	/* Skip guest virtio_net_hdr; TX TSO handled in a follow-up. */
>  	size_t len = iov_length(vq->iov, out);
>  
>  	iov_iter_init(iter, ITER_SOURCE, vq->iov, out, len);
> @@ -1025,6 +1029,35 @@
>  	return len;
>  }
>  
> +/*
> + * When VHOST_NET_F_VIRTIO_NET_HDR is set, vhost supplies virtio_net_hdr.
> + * Populate GSO/checksum metadata from the socket skb so guests that
> + * negotiated GUEST_TSO*/GUEST_CSUM receive correct offload information.
> + */

this is a wrong type of multiline comment. this file follows net
convention:

/* AAA
 * BBB
 */

> +static int vhost_net_hdr_from_sock(struct vhost_virtqueue *vq, struct sock *sk,
> +				   struct virtio_net_hdr *hdr)
> +{
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +	int vlan_hlen = 0;
> +	int ret;
> +
> +	spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
> +	skb = skb_peek(&sk->sk_receive_queue);
> +	if (!skb) {
> +		spin_unlock_irqrestore(&sk->sk_receive_queue.lock, flags);
> +		memset(hdr, 0, sizeof(*hdr));
> +		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
> +		return 0;
> +	}
> +	if (skb_vlan_tag_present(skb))
> +		vlan_hlen = VLAN_HLEN;
> +	ret = virtio_net_hdr_from_skb(skb, hdr, vhost_is_little_endian(vq),
> +				      true, vlan_hlen);
> +	spin_unlock_irqrestore(&sk->sk_receive_queue.lock, flags);
> +	return ret;
> +}


This means the header will be wrong if something consumes
the skb after we drop the lock, no?

That's why in the end we put the header filling logic
in tun, it can avoid races there.


> +
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  				      bool *busyloop_intr, unsigned int *count)
>  {
> @@ -1239,10 +1272,18 @@
>  		/* We don't need to be notified again. */
>  		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
>  		fixup = msg.msg_iter;
> -		if (unlikely((vhost_hlen))) {
> -			/* We will supply the header ourselves
> -			 * TODO: support TSO.
> +		if (unlikely(vhost_hlen)) {
> +			/*
> +			 * Build virtio_net_hdr from the socket skb before
> +			 * recvmsg consumes it. Skip for ptr_ring backends
> +			 * where the skb is not on sk_receive_queue.
>  			 */
> +			if (!nvq->rx_ring &&
> +			    vhost_net_hdr_from_sock(vq, sock->sk, &hdr)) {
> +				vq_err(vq, "Failed to build vnet_hdr from skb\n");
> +				vhost_discard_vq_desc(vq, headcount, ndesc);
> +				continue;
> +			}
>  			iov_iter_advance(&msg.msg_iter, vhost_hlen);
>  		}
>  		err = sock->ops->recvmsg(sock, &msg,
> @@ -1270,7 +1311,6 @@
>  			 */
>  			iov_iter_advance(&fixup, sizeof(hdr));
>  		}
> -		/* TODO: Should check and handle checksum. */
>  
>  		num_buffers = cpu_to_vhost16(vq, headcount);
>  		if (likely(set_num_buffers) &&


