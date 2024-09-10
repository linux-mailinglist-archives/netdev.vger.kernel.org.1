Return-Path: <netdev+bounces-126857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5702972B17
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0712B1C23D7C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E717E00A;
	Tue, 10 Sep 2024 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyqyJgbF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4D142911
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954329; cv=none; b=X8tdbotc3IVSDYJhfcZ5C7JmZ0snpcVew0/ynHSQFmIukEhHDKdvxrvq0SKs0ETBbZ3SZi7YS+k2L0vHU8oPYy1NlQp9rmBQ9inS0xK4INeJAXXuePvXf0bmUHYm+Le9+e+3B9qZPZDxpV960DPbtUsf8oXU+DaxDeXTyQ1rkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954329; c=relaxed/simple;
	bh=KjxziAPMJH7XpUkX59IHTW2TElMkxQwAxNE3C3QrpNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwYfEQ19U123j4h1FsOvtI8CMl5/S/hjM4R1Cs5lQzLCoj0M2I7vBX3vIJtJDAnl1gUVug481XMnJnSgAEUnTaSkACHbieQHWIMtWRHChy0GzUSvmfLnBWmGcAlDLjFCYjTg4IOFUZuBtABGfOkC+UW4Ian9wDjN7Xp7qLAG/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyqyJgbF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725954326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZY2hbwdDZWp3ZKXagSr/ks4mrYd/DJjs9ZEgcgEszQE=;
	b=hyqyJgbFMFOmHpDTmDsTSTOVmgLdZoLyXUdzdMAEva55iGKOlhZMkj5SRu/Hf9CdvWA+xT
	nLf/rTmE8qeEK1c3aJojrvY1K4zp4TqVZyBlo0dHS5rwqlfADQbGO0e2oweOkpYM1Rzho3
	rLTILEhmwNASIkDwMuNRmnm/1jdYKH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-hukku9tNOu-ldDyzivnQdw-1; Tue, 10 Sep 2024 03:45:25 -0400
X-MC-Unique: hukku9tNOu-ldDyzivnQdw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c44e58a9so2765751f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954324; x=1726559124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY2hbwdDZWp3ZKXagSr/ks4mrYd/DJjs9ZEgcgEszQE=;
        b=mOzXC0majPSltpQqEynsrlCU1ArV6Kl5F3fvxurBqDmw8yduhtDS3ABt3Z21NsK5/f
         1NgN/gYVIfNAL+D59fc/fc4YBX2XnWIFE2ZRKlILwDZI8SyjfV2b69jOZktYtwJazWYB
         T7tZLm1rlzesqoipb3T8Vixpq+ex6igp73wUmD7I7ceNtlM4oUYYdedDK80tmZMk/xME
         8G5o1frPsg6f2Rbka+CDCy1iug1V0r6HU+uLk9QIMVBeuHeUm4ypo59mNaRRTam7TMKg
         0ojVYzF2XssEvwv1o5/2cWhi+YJMd84Y2+QfGoJJvOTohaAiVkhxRAtXLdxAsu7pcWbC
         lI2Q==
X-Gm-Message-State: AOJu0YzFWliB0dkiyRBntOEebdiJtQRlYWo5MrkK4GQeajmLPfJrx2i1
	8Ihba0htoTH/wSFdOFl/sfqbE+21SymxoC+aT7gCKOXxBtu76Sm5o0ZBO1boBt+98wDL5SGdfoT
	N81N1k4IT08l8U6Q3ScNcnNrJr9LQ3PXg/haoBSVPSn2BSzd9Jev7oWPgRlsy6Q==
X-Received: by 2002:a5d:424f:0:b0:377:6073:48df with SMTP id ffacd0b85a97d-3788969b01amr7703102f8f.58.1725954323892;
        Tue, 10 Sep 2024 00:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWDL9tgANDclkVxU5vdzqdALHkrR9Hg/jxAu04KYel7psjHeGvoe6UCCwbI2QhFieeBHfZg==
X-Received: by 2002:a5d:424f:0:b0:377:6073:48df with SMTP id ffacd0b85a97d-3788969b01amr7703073f8f.58.1725954323213;
        Tue, 10 Sep 2024 00:45:23 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm8066576f8f.56.2024.09.10.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:45:22 -0700 (PDT)
Date: Tue, 10 Sep 2024 03:45:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
	nsz@port70.net, jasowang@redhat.com, yury.khrustalev@arm.com,
	broonie@kernel.org, sudeep.holla@arm.com,
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.net
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in
 virtio_net_hdr
Message-ID: <20240910034415-mutt-send-email-mst@kernel.org>
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>

On Mon, Sep 09, 2024 at 08:38:52PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The referenced commit drops bad input, but has false positives.
> Tighten the check to avoid these.
> 
> The check detects illegal checksum offload requests, which produce
> csum_start/csum_off beyond end of packet after segmentation.
> 
> But it is based on two incorrect assumptions:
> 
> 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.
> True in callers that inject into the tx path, such as tap.
> But false in callers that inject into rx, like virtio-net.
> Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
> 
> 2. TSO requires checksum offload, i.e., ip_summed == CHECKSUM_PARTIAL.
> False, as tcp[46]_gso_segment will fix up csum_start and offset for
> all other ip_summed by calling __tcp_v4_send_check.
> 
> Because of 2, we can limit the scope of the fix to virtio_net_hdr
> that do try to set these fields, with a bogus value.
> 
> Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port70.net/
> Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Cc: <stable@vger.kernel.net>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

But I think netdev maintainers ask contributors not to CC
stable directly.

> ---
> 
> Verified that the syzbot repro is still caught.
> 
> An equivalent alternative would be to move the check for csum_offset
> to where the csum_start check is in segmentation:
> 
> -    if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
> +    if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb) ||
> +                 skb->csum_offset != offsetof(struct tcphdr, check)))
> 
> Cleaner, but messier stable backport.
> 
> We'll need an equivalent patch to this for VIRTIO_NET_HDR_GSO_UDP_L4.
> But that csum_offset test was in a different commit, so different
> Fixes tag.
> ---
>  include/linux/virtio_net.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 6c395a2600e8d..276ca543ef44d 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  			break;
>  		case SKB_GSO_TCPV4:
>  		case SKB_GSO_TCPV6:
> -			if (skb->csum_offset != offsetof(struct tcphdr, check))
> +			if (skb->ip_summed == CHECKSUM_PARTIAL &&
> +			    skb->csum_offset != offsetof(struct tcphdr, check))
>  				return -EINVAL;
>  			break;
>  		}
> -- 
> 2.46.0.598.g6f2099f65c-goog


