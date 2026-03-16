Return-Path: <netdev+bounces-268057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFJFCVDKt2kRVQEAu9opvQ
	(envelope-from <netdev+bounces-268057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED0296D06
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A5F23002D37
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D050386577;
	Mon, 16 Mar 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eysbEojl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQizGpbS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605A38655B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652553; cv=none; b=KmxXznduw0unWqQqEliBZjCZSsKq4otae7OTVV153Dh26p5JyNfcRMRzU92qjI8S8yOK+fEUjvGpzHQQQKoucaGlr32laOnz2yUrfO0xsncY0del3ZKwCy3uo3nR6Z+M55VQY9+eaioZHPyVwKDPFsc0UGaS/hBjblTu/1NHv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652553; c=relaxed/simple;
	bh=O2SS18rlSUcdzi98lp2IyIdV6D0lACHf6IBFjWpTWwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUPzBoF88Eg8qASbSLHDq5UKKZvP9oeKwlOKgl10MUYTaQivLDHCupst6XJfAZPMJrVMcY439DlGDH6uKG7vfeCOEL5lWziyPgLo1eppe5o/OROcduiW9172XniIdXF2j2g5lCyA3Cuc7qhH3vl+66ZMrOYXSirNT/MkpZ73lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eysbEojl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQizGpbS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773652550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ep6TcvjqLGgLknc4tGkbaa/0WsAO+G7kPe/z8Cm1bsI=;
	b=eysbEojlMob8fCmS0lCbVbIkHxQ/4RClmBXwL43N/E+KikXjekeauCHn2XpmQsExiVmXHZ
	zqofbckKWUga8inPqkBJhtnZzgUfEva7m/U223oPRUpQ/W3TtGJY9X1cXg8UgQuJPMcMZ5
	35uMvnvSsw6CkvY2RoE3msU6ogO9IxM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-AgkUBfGkOWyMZV1FGSGU4g-1; Mon, 16 Mar 2026 05:15:47 -0400
X-MC-Unique: AgkUBfGkOWyMZV1FGSGU4g-1
X-Mimecast-MFC-AGG-ID: AgkUBfGkOWyMZV1FGSGU4g_1773652546
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b42fe9031so602251f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773652546; x=1774257346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ep6TcvjqLGgLknc4tGkbaa/0WsAO+G7kPe/z8Cm1bsI=;
        b=VQizGpbSbt2G3kKzf2bCYb7Dn0WUe6gGDUowfCpW0Wj2VcQYfFrVZCuFESvsNMbhe5
         lUOg5qdzSpR/kpDlizmt6unqRMQDBRx6wFPUz88HxNb2rPbg9jlkfOVma5IeHBjvYLiL
         KLj2dDTKUTYR/CNbhg+a/xGhgVxahrHGeuW0asBIHUPPfnwwzsCujMcDIRdRvZxKk9Ro
         IUyYsiPfteQn3o1dWkJ1WuVAuCf7QJfcYA+Z1Y58x91/IpADrHWpLrxCg5PWTBxmczYU
         ZTChrUrPTj2yIrJyUDfnsFFdoqqdWVH7HriEzFHuIe2ttnopjy2KgFeCkmJOGyPgk13A
         dgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652546; x=1774257346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep6TcvjqLGgLknc4tGkbaa/0WsAO+G7kPe/z8Cm1bsI=;
        b=FciAI5vcv1mb0CByg8xisy0ljI2Z7ooJ1zQy3Ia6TSmirAeqq8DSFNqTWtGvXjwbC4
         GCKd03WN2JZxErfrcFoKcbwwUVwa9XZgBFZ+LpAhQiI0GEfRNfJ6TgdsmhNglxUitrfL
         BFk2HTtnlTcaMuzn+Co1JiDgIbszdQuJn0n21+X/lo8bxEJQoPZ40gANfTTSuxW3tbFs
         GkDBP5aTOAIdFb6Go/Fi8XUDcp86o7OvSycKnrC5vIX/FqbeuIn8W/f2V6SzrhB7jaR2
         E4bCnDoBjeEIyHKOPRKQKWcq3+aT55IKn9M21nimm07Bp69hZOKXZOqXdEA6DDm0nv1i
         4RzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVasX88cXq+5r7wVr3O20FEs6nOWt3En+q90nc0YRpyY63LXwXcXFo52q/Yi3pX67B3VWvPhio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemgHe4SLuMRMyZ/5g1WmaBxetkodW3/zh05IWq4TrKNemno7H
	sSHvy4Ay28xNZL/Eec/Ht0uKyTyCs9GXompRmTuCkTVxdOxPcIhSE/cw08FvqNNqtWrOwFFCT87
	d2PUu0xCzkFq/yOTqgz94iM0dmYJULiBBiYQosMlvR5lKB/t0PUGHDAHQVg==
X-Gm-Gg: ATEYQzyPerkrrrJRcpktUXUNpF8zs9aqF7RDZf7uSIsptg26yKHlu3NaaMvQOOc5atS
	euUYvWATGqM8iVvG3aQs0PxWtuj3GKJUSaD1Qr5Lh+kQKLfFBrtRMHl0ocwG6t4J4hi5R5BhbEl
	32i0juRT7hRJkA1moA831s8dzBr5QoBU8VSGfsIPkYeBR0cyr8NbGqPAo6KcUv1hZdt2bkqsuA6
	LH+3CFmnTlTJUPOXzX9aGgz7TTEuZph6KCIfyTsL0l4zHjasTNYWPFyp2Oh46ZRaqTeRCoa1YrL
	2i4D4B1qs3GnFkH6ctKbAVbbOuruNOw3xNX1zvUsqYKjTg69ENHlW7yHKozxSlUs0cea2XOeURH
	HH/bfLG5qfU3L25YPnh44Vk1t8jlpG+Bi65JNTI5hCxPCjQ==
X-Received: by 2002:adf:f349:0:b0:43b:3b80:6781 with SMTP id ffacd0b85a97d-43b3b8068cfmr9071732f8f.49.1773652545930;
        Mon, 16 Mar 2026 02:15:45 -0700 (PDT)
X-Received: by 2002:adf:f349:0:b0:43b:3b80:6781 with SMTP id ffacd0b85a97d-43b3b8068cfmr9071675f8f.49.1773652545370;
        Mon, 16 Mar 2026 02:15:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe228986sm37539616f8f.35.2026.03.16.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:15:44 -0700 (PDT)
Date: Mon, 16 Mar 2026 05:15:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Di Zhu <zhud@hygon.cn>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	lijing@hygon.cn, yingzhiwei@hygon.cn
Subject: Re: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260316051327-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316072152.910857-1-zhud@hygon.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268057-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28ED0296D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks! Yes something to improve:

On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which indicates
> the device supports dynamic control of guest offloads, it does not
> necessarily mean the device supports specific hardware GRO features.
> 
> If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
> TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
> device effectively lacks the hardware capability to perform GRO.

So what is the user-visible problem this is trying to address?

> 
> So, making NETIF_F_GRO_HW conditional on these feature bits ensures the
> stack does not enable an unsupported hardware offload configuration.

I guess the assumption is that without this, something
enables such a config? Which stack is this and what happens then?



> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> Signed-off-by: Di Zhu <zhud@hygon.cn>

judging by this, has something to do with LRO?

> ---
> /* v2 */
>   -make the modified logic clearer
> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..b233c99925e9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
>  		dev->features |= NETIF_F_GRO_HW;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> -		dev->hw_features |= NETIF_F_GRO_HW;
>  
>  	dev->vlan_features = dev->features;
>  	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> +		dev->hw_features |= NETIF_F_GRO_HW;
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> -- 
> 2.34.1
> 


