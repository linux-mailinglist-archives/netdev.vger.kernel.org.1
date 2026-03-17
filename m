Return-Path: <netdev+bounces-268566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJOzHTc7uWmvwAEAu9opvQ
	(envelope-from <netdev+bounces-268566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:29:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B862A8B94
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088FD3039F7B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6E3932F0;
	Tue, 17 Mar 2026 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiD4dPhS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sWzBeiYU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86A34403D
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746965; cv=none; b=ooQGgdIwm5HwV7E674GVBvfJMiqCVOcHKQrAMTjRv7z8Yh3UCdSM9RTBZcb7GYyq0RuOQrYuV5dzlz/tEpMkt66feFV50KMK7enhQagAR9iNJFkk82BLP3sBedFwx6L23IYYLcePUQw12RMJR8+yTGxNBxET/yKQlIMWm1oTp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746965; c=relaxed/simple;
	bh=4CSx9ZjbeRXfiJMtz5ON1cC5JPSin5oI4O9rPe/Ec7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nnk5WdC1WxeEgzF1goSJsUmNkHyc5HaGihrtLPzX3hmm9pXWkmswzcPogHildNVmo9/38DSqsZTQ0FJoVLM4LdkrmxGKUoCdkGt7a4LxtKHZauNVUL5nY5CGmlxkza/iLZsBFaiDRDsstKfB2yp1awNMnW11CTH4XyT7O+JPt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiD4dPhS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sWzBeiYU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773746962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFs80zw2O4/2NJrV7I0/zYaOrXH4RPoeh7BrpBnFPW0=;
	b=PiD4dPhSmic8eSbnKmpg6kHiBFhUA0GuO6qOkVD9BBzZfEUA+/azLwKZoNN2/2SneBFj3U
	ze8FfldDeWAGTkS5b1vKJH3c7I+qSQ4HPuSzNNn5DjW0cnMZtNsBjA/PNhCJs75ag1SVcp
	miMJIDMfPtAR4hlbJo1ftDLRuPPkYf8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-v0ydwhs2Oau2_LtKPP_T4Q-1; Tue, 17 Mar 2026 07:29:21 -0400
X-MC-Unique: v0ydwhs2Oau2_LtKPP_T4Q-1
X-Mimecast-MFC-AGG-ID: v0ydwhs2Oau2_LtKPP_T4Q_1773746960
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so5651235e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773746960; x=1774351760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFs80zw2O4/2NJrV7I0/zYaOrXH4RPoeh7BrpBnFPW0=;
        b=sWzBeiYUy8H7s5XxDhNTm8JhTr3wPEQgGlQP3c3viaNdE90HLM3f96NJxqVT7MAtGa
         7a0EQ5XoI8atBx6RqDvpxhagFgDH5UNPbXtgSTxifTlQ/B2+qtukmDYb1I5HHs15JFzt
         s8f/nHnKAYRd1ip4042zgVFIXXazGb/CqIPReSFYGOV+r+ssDlIJ+fFl8sK4hIJJ/lQx
         LZwa6fFUCxlt4G96sniheg7joW+WQgVP48iv38YUe3FIS1Vsxni2XAXWXZSqVp5Od3WK
         gMyStnPTfcefdJ7JdDNsQDJ8PNIhpntaox2CHJy/JWsdLmZVYCjg30Q5NDZZOm/P3MYn
         wULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746960; x=1774351760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFs80zw2O4/2NJrV7I0/zYaOrXH4RPoeh7BrpBnFPW0=;
        b=jqnihRNepsqfzqWFJYzqY72Pt8exK0J5lKj91AvdSju1npyz+u8nf8oVqYYl7Qgv8B
         y3MLZCDBE/6Rkgc76rE7O7Dsbh6flg4tXX+h8Ki1k5AL0rJ0iRUG/fXFoqAkPAYOLAR+
         0k22+LqKNM9eRxk5j3uAANd0Vs7e+RvB9EcSP6c1YpCkYqTQCKqjAhAvSTcyo0BuardF
         e94AfBKsAZWd10jvJOA2EFi1Tt9r2XJVfx1f7RyLIR8HkT6b8kKQf8Sk+aLuzwZGu/ZN
         y/DQWdDkzEyC42X1EFxtCqCWU47hNmkoehbFGveFG5S5+CciLkkzBWk22I18HNv0M1G/
         w4ew==
X-Forwarded-Encrypted: i=1; AJvYcCVBqhrklXnrLK+TdkX/DirXpDdopQnA4Z2/goXbXZbXZlcKtgKkXvUD6mF91a7DxED3/5vYVfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIECVHrtmKi0TqjP+R8/e0ojDHjdFbVTLL26YhfzABWo/JqAyx
	vdrOkDvlettOSdHy+RjI0xiRfNILn1CBt6U2UGWMhkX0AMjR5QY2QVdGmR1Qz2z8Rk4sI4oFZ0J
	+GEjRNPB0h9F1rVB9enBiLE2zwn2L22TjzktMPIp/W4Fank2X7MUMQZEi9g==
X-Gm-Gg: ATEYQzw4jYynhD5BVD+BHG+oNLnoKY73H58yV5CK5kXWwrmgnZfb0JHGmaxam14B1F9
	KuvSRaFI+kkggM/4HAOF7DJTWyBGZZ1sSZeSf8d3eRjTDapcsRhFrbUVVNNP+9bF++wXn+aT66Z
	uIglyW2dXh1y+JlPYOLgbImqG+goERYfFCr5xKGn86FaA08UMMxDaikfqNy1ToO7tFVs50h4URX
	UxOEr0RcZcejxA1yCF5PxaLDPs7+5FWZYMz3aR8oHYIhi6tU/IrtC7TZsyrylkHMelQ/y7rfybs
	eZytU1530utl3fAd9luBiQZsJZe5uza+FIO/dHAb/aJMr76pQVE5flbcv7QWu8OeIBdUjR4KCi0
	1qOKyBiFLuxkt/UcTdVfXrANXeMznJj6D/lfEefWcEUUfHOJNkdL6Q9g=
X-Received: by 2002:a05:600c:5249:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-4856eac2b35mr51298685e9.7.1773746959754;
        Tue, 17 Mar 2026 04:29:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5249:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-4856eac2b35mr51298285e9.7.1773746959237;
        Tue, 17 Mar 2026 04:29:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4857f224d5asm16069915e9.24.2026.03.17.04.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 04:29:18 -0700 (PDT)
Message-ID: <bc3a66a1-8c0d-4038-9b92-0fe3d10b1555@redhat.com>
Date: Tue, 17 Mar 2026 12:29:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,solid-run.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-268566-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 13B862A8B94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 8:59 AM, Xuan Zhuo wrote:
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
> 
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  6 +++++-
>  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index a5f93b6c4482..fa5cab9d3e55 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen, true)) {
> +					vlan_hlen, true, false)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7106333ef904 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	struct virtio_net_hdr_v1_hash_tunnel *hdr;
>  	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
> +	bool feature_hdrlen;
>  	bool can_push;
>  
> +	feature_hdrlen = virtio_has_feature(vi->vdev,
> +					    VIRTIO_NET_F_GUEST_HDRLEN);
> +
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>  
>  	/* Make sure it's safe to cast between formats */
> @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>  					virtio_is_little_endian(vi->vdev), 0,
> -					false))
> +					false, feature_hdrlen))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..48de4a16a96a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
>  }
>  
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +					 struct virtio_net_hdr *hdr,
> +					 bool little_endian)
> +{
> +	u16 hdr_len;
> +
> +	hdr_len = skb_transport_offset(skb);
> +
> +	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +		hdr_len += sizeof(struct udphdr);
> +	else
> +		hdr_len += tcp_hdrlen(skb);
> +
> +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +}

The series LGTM, let's wait for Jason and or Michael.

If another revision is needed, please consider factoring out a
__virtio_net_set_hdrlen() helper taking an additional explicit
transport_offset argument, to deduplicate a bit the code between patch
1/2 and 2.2. Not a blocked anyway for me.

/P


