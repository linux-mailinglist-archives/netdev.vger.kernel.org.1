Return-Path: <netdev+bounces-240050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6168DC6FAD8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50732367B4D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E6366576;
	Wed, 19 Nov 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMqZlOiI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h998WXFQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8896366DBA
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566076; cv=none; b=VO2ex9WQHz/bINdK7uVy8G1hl3DHolIbRPSHxMsGKTHrEjyXjizgAg7vtUAil/t9WHa3wUVXNazLfqMlYKjh7tK2U40YfppNVV7zQCDyQZvBzONvEpp2YfG8u6vAVT5+zd89g1cqVXxjjHvcO12o0WpcDEkPne+99P4MtVDyhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566076; c=relaxed/simple;
	bh=2AHtk/lQXbNZZpPx6nfAIJ2au2S7m30j106Z1+vqVM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sho5gWrczfJzWVoDexbqi3qFuMTkf2b0rFFSrrcIGa95lhddddX7USZZelBn+ww3WKoaWGen58it815CtKfBB9ppnnC42Wq7Rt6d7C/xnxxLCROl2pu59KFp/DcvYZFfsQBLxbf0j5GAL/MRDo6svyBiDvJnv58ekvBOchqpaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMqZlOiI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h998WXFQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763566073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHlhvFLfyKP0IuFGERbeyuWea/xjnUWPpjGJ0qsZJv4=;
	b=SMqZlOiIREFo0N5yrWffs4SOw7KFs36JDcJQTTa5OX3tObiu6R6qcnn77E1QHSQHCMlB2U
	mMO5X/lkwEBAP1cZM0O0Dv0Jp8jhIQq7sOJ6H0mQ8YteMz7DNb03qBZUGCM+bu4ZQ/WO+G
	LR8e4xQRMl15ClUI43qh3c6lUiOzrVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-4hm87lR2NSSIIvRKfFhCrw-1; Wed, 19 Nov 2025 10:27:52 -0500
X-MC-Unique: 4hm87lR2NSSIIvRKfFhCrw-1
X-Mimecast-MFC-AGG-ID: 4hm87lR2NSSIIvRKfFhCrw_1763566071
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b432aecso23065375e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763566071; x=1764170871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHlhvFLfyKP0IuFGERbeyuWea/xjnUWPpjGJ0qsZJv4=;
        b=h998WXFQTuoanL01DxaiBGeL/ApLdENouheMxa19oz7f9DSFjyNP0C84DUh3Js9E88
         voF56mK3GPUPD5n2plSOyInUg2IWEOfbY/3+NyrBW/B2sV42WoBl6iSevIWbUm4qzgEE
         wqbVbu3Z5wJLejpBQSqaVNucBQ3QaEifY91B74elD2H0+EzQeD/TAWE+6PNVBBwuZ5D4
         c4F6+cztouUiRpbcqi8sv7UFiM9warfUglqwGEiFb/IhXBC3J+y0CgcrTcaGANyPnROO
         QrDwvf3ZrZUZhJpARBoAM6O7iNxKPK4nvu7v1A+noe4Tzy6ohlXMVSQzT3xGYU+CdIK/
         Kp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566071; x=1764170871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHlhvFLfyKP0IuFGERbeyuWea/xjnUWPpjGJ0qsZJv4=;
        b=eOM7C3M+mTELP/dns8HOItXj9Qb8PO9NN6dExBdwI8VEjjOanyV26J70pEiSij4gj4
         40qJzWtbdJkU5KPU53QhCO7humK3m3m8M9jyTNEvyqGM/PbBxd1QxG/V4kCruVf4wP13
         +yWyvLYgmdPL2KdaQtOGByz6CnZHgSR9WKLLez8yI44WdMYrVpaNRx8ubFbRMyXFl3Oi
         /4aeWGqcd5T5wBRFDBL1PGoOCPsr7ix72a2ZfLRl7iP4BC8Mt+nxVEDWKZ78YYVktCRH
         0AScAnirSzya6lKeRK8ne6a857WVaKOquXtsBPQLql5oGL9EByv+mTAsXp5V9e3WURgJ
         HoqA==
X-Gm-Message-State: AOJu0YyTJfiojVKIWtykA2Z20s/aLaZFWM7el34xGi3/cz9vDZpwp9Kb
	CuletoLlr5Ir1fgZkklXVEzm/nWEvGHFnL9jbuFklPOY3D7rGbRooIvSCx4QLiHDMyPegr5+y0G
	IjvxE8+rM/IV5/CazJR1ZW0F3T82JGEs9q56F/nMssn1MV6H6bFuXChl2Gg==
X-Gm-Gg: ASbGncu51bSveV0V7Ln/9vLVKhZqtFgseys7JaqxhbuBLiySzaMCExzUhmMyjjWN1K1
	cHC7MCzkeQVkzR4jsGrVp4FofpY1IS1wOUyPhukGkTaW1iro2E/cOqYvKN9YvAbqDjUWiFOqeIR
	kI6Lec9WrlLfFCHVB2P7wpZj3w/i0U9UM1ciLwbSHfQAdrgyLXmxsLPbNv/rK+lSx8sEQpPT+9W
	3I5AwbRbQ9XHn4iW0ETq2dtT5ckmWC/TGfZZEnPk+gTixqsPX0JhH4/wMC6qY7x+RZZwHNgTmFP
	xmcXXz9pf2svnNn4fnuEhpqBkj+EFl8tm7sHVzGG/xHJuAw/AiW4tWvw8kVswO8jGIJg5K22MgW
	3fDwvM2PmTxRX5vs2GRwOIkV9lQqhdQ==
X-Received: by 2002:a05:600c:4995:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-47796713b41mr111156675e9.35.1763566070984;
        Wed, 19 Nov 2025 07:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCuJHBRec3mpLMUz50uZ6t1pbpsWtDxU16tpLG7QVSudm09TacV9uCNP3CKm0YHndmXcfHlg==
X-Received: by 2002:a05:600c:4995:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-47796713b41mr111156385e9.35.1763566070324;
        Wed, 19 Nov 2025 07:27:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477afb54774sm26915625e9.3.2025.11.19.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:27:49 -0800 (PST)
Date: Wed, 19 Nov 2025 10:27:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v6 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251119102708-mutt-send-email-mst@kernel.org>
References: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
 <20251119055522.617-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119055522.617-2-xuanzhuo@linux.alibaba.com>

On Wed, Nov 19, 2025 at 01:55:21PM +0800, Xuan Zhuo wrote:
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
>  drivers/net/virtio_net.c   |  8 ++++--
>  include/linux/virtio_net.h | 58 ++++++++++++++++++++++++++++++--------
>  3 files changed, 54 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 81662328b2c7..b06aa6f2aade 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen)) {
> +					false, vlan_hlen)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0369dda5ed60..a62acfaf631b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3317,9 +3317,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> -	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
> +	bool guest_hdrlen;
>  	bool can_push;
> +	int num_sg;
> +
> +	guest_hdrlen = virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_HDRLEN);
>  
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>  
> @@ -3339,7 +3342,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> -					virtio_is_little_endian(vi->vdev), 0))
> +					virtio_is_little_endian(vi->vdev),
> +					guest_hdrlen, 0))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..ee960ec9a35e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
>  }
>  
> -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> -					  struct virtio_net_hdr *hdr,
> -					  bool little_endian,
> -					  bool has_data_valid,
> -					  int vlan_hlen)
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +					 struct virtio_net_hdr *hdr,
> +					 bool little_endian,
> +					 bool guest_hdrlen)
> +{
> +	u16 hdr_len;
> +
> +	if (guest_hdrlen) {
> +		hdr_len = skb_transport_offset(skb);
> +
> +		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +			hdr_len += sizeof(struct udphdr);
> +		else
> +			hdr_len += tcp_hdrlen(skb);
> +	} else {
> +		/* This is a hint as to how much should be linear. */
> +		hdr_len = skb_headlen(skb);
> +	}
> +
> +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +}


So this adds code that is broken for tunnels, then the follow up patch
fixes it up. I don't feel it's worth it, just squash the two patches
together please.


> +
> +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +					    struct virtio_net_hdr *hdr,
> +					    bool little_endian,
> +					    bool has_data_valid,
> +					    bool guest_hdrlen,
> +					    int vlan_hlen)
>  {
>  	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>  
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> -		/* This is a hint as to how much should be linear. */
> -		hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -						 skb_headlen(skb));
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
>  		if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>  		else
>  			return -EINVAL;
> +
> +		virtio_net_set_hdrlen(skb, hdr, little_endian,
> +				      guest_hdrlen);
> +
>  		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>  	} else
> @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +					  struct virtio_net_hdr *hdr,
> +					  bool little_endian,
> +					  bool has_data_valid,
> +					  int vlan_hlen)
> +{
> +	return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +					 has_data_valid, false, vlan_hlen);
> +}
> +
>  static inline unsigned int virtio_l3min(bool is_ipv6)
>  {
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> @@ -384,6 +418,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			    bool tnl_hdr_negotiated,
>  			    bool little_endian,
> +			    bool guest_hdrlen,
>  			    int vlan_hlen)
>  {
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
> @@ -394,8 +429,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> -					       vlan_hlen);
> +		return __virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> +						 guest_hdrlen, vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */
>  	if (!tnl_hdr_negotiated)
> @@ -408,7 +443,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
> -	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> +	ret = __virtio_net_hdr_from_skb(skb, hdr, true, false,
> +					guest_hdrlen, vlan_hlen);
>  	skb_shinfo(skb)->gso_type |= tnl_gso_type;
>  	if (ret)
>  		return ret;
> -- 
> 2.32.0.3.g01195cf9f


