Return-Path: <netdev+bounces-194206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE32CAC7D76
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 13:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749A81C02D19
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F5221FBD;
	Thu, 29 May 2025 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgtvfwTv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD1155335
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519738; cv=none; b=Zki+fVKK7d8i8VlVBE3+SQGUokfFg6DBOPSmaRedXTV902CY1wZjfl1cCDz4JNNi8od9u7lY+4gcsQSH267b4sasgjOo5/8Ndir0OnJTm+mb7muYEK4Fdz4fRtmOQZJXRCK3OnVL3ygwSHxBmz2PhlxJAtPGC8yh6Sg4juKQj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519738; c=relaxed/simple;
	bh=QsCZjDGKcN9uNP96WinViSVdXRUjA7wXw2Rnl/j+z0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssDcr8tQnwUb9gCuX8ajDy3/ujvjP/tcbxdCa5LqOZsDJhzPJsjc7z1hqNOpTYdjKJC55V+bQYJPW4pFJDS12Xjla/a9XY+a4tgjkTC3sDZu+ntT23WRtBqxBNzMYZBs32unRkjAzId83ykZs8+rAl8OFc3EoxPD6irxRcxQ8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgtvfwTv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748519735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwIHWeO/XfGOBnUwDOPj7CmbGm2KCXTfOQI9s8iUKYA=;
	b=UgtvfwTv/M7BvDC20j61tVuLUK3T9Dpreo2f+4L0cnO9rOnqCJPjLwG45oCE1Fu7j1IBs/
	HHqjmCUPFUOko4vLUOnNWr5FUCs1inMM4EFA0FQNYyOgFK9+tD9cy5io59up7MKg7QBXyw
	vzt+PQ3f/b0BicKHFeYUyxOuAypBzzU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-A3rk_YdcPzOlkAhohJBJsg-1; Thu, 29 May 2025 07:55:34 -0400
X-MC-Unique: A3rk_YdcPzOlkAhohJBJsg-1
X-Mimecast-MFC-AGG-ID: A3rk_YdcPzOlkAhohJBJsg_1748519733
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a364394fa8so297343f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 04:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748519733; x=1749124533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwIHWeO/XfGOBnUwDOPj7CmbGm2KCXTfOQI9s8iUKYA=;
        b=MXI8e/vxnPZk477n1yxuHNzESbJUpz8kwTQPeMZ9S5rcXovithXfwRLxd86nMrHN/n
         bE19vw5BNGdfstkoYDs0y4UvipCgEDfGV0ZZ78BMVZ9BU6Xf1/Bp4Lr9boJJ5ZFo/hvu
         ICQ39+0MpuKeW2my0YRNCtH+RPQVhoHorzWGYaWOxumOR6soEtRTN9mvih3KHJ4+WI1F
         fWLw77g2tJHqaQrqxMAhGd2e+XD9L78gBXV68CRaJjL1B8aAPHP1ptpApHIm4ve0D0O5
         YwctNXnYymPZZN6ZO7s8540F3Ytl2d8EEtUIIEUpyNRyYync5dtLs81ZtY4222m6YQj8
         CYag==
X-Gm-Message-State: AOJu0YzFli8mO5MkkrR84ODmnPYPPxREUkgGEamM4EnkgIOPxKpJs9AR
	2re5FqOkPv1zlX2Wvo2Eb3msuMxnxZIDpvC3KHXLEHR/nfgNf7w0/tCBOEXsS7a70eFjhI4Ttax
	I0nB5DvDQQpAUNzmpI5UwbBLxPUptM2iQ/B2kQtjy8tJEowgISBuxnbjv2Q==
X-Gm-Gg: ASbGnctscUY1BxRphuhVaZXa3V0ozWOIQpgnkgzWAF50/CWqqwjS4Xscjw7pu3tRd9f
	lt2yt6iBI8LZUmZ1y51AoDJ1E6F3NsMEE8+dSqott7T54Y64Jn/UbAF6THuh+dHw9tNapqIggya
	yi2az/jISctoJ//7a7MMLEKRxtZN0TVAJxoWCDkSsbHpMrjp1u6BZOeRvecPXfuiGVGg8prcXWQ
	tKOnK3J0AL2Hoan9Nahh0LZXBceAG0zerIkeasiPRtxSPyuWEWU7E/p+YMyyN7LfPU3c2ITEkAO
	tyPdGKoH85c0lGz8Fto=
X-Received: by 2002:a05:6000:40cf:b0:3a1:fc6d:971c with SMTP id ffacd0b85a97d-3a4cb46d689mr17278735f8f.21.1748519733344;
        Thu, 29 May 2025 04:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJyt0Ps3ti7v0sQ9McrCrMEpoAYWVIW4qJpuPK+2U6Q++feHqBsBUfv7nJCGoyg2xcGst/kg==
X-Received: by 2002:a05:6000:40cf:b0:3a1:fc6d:971c with SMTP id ffacd0b85a97d-3a4cb46d689mr17278709f8f.21.1748519732764;
        Thu, 29 May 2025 04:55:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10::f39? ([2a0d:3341:cce5:2e10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972c1sm1817570f8f.68.2025.05.29.04.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 04:55:32 -0700 (PDT)
Message-ID: <3c2290f1-827c-452d-a818-bd89f4cbbcba@redhat.com>
Date: Thu, 29 May 2025 13:55:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
 <CACGkMEtkbx8VZ2HAuDUbO9LStzoM6JQVcmA+6e+jM1o=r9wKow@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtkbx8VZ2HAuDUbO9LStzoM6JQVcmA+6e+jM1o=r9wKow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 6:40 AM, Jason Wang wrote:
> On Wed, May 21, 2025 at 6:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> +       if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
>> +               return -EINVAL;
>> +
>> +       /* Relay on csum being present. */
>> +       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
>> +               return -EINVAL;
>> +
>> +       /* Validate offsets. */
>> +       outer_isv6 = gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
>> +       inner_l3min = virtio_l3min(gso_inner_type == VIRTIO_NET_HDR_GSO_TCPV6);
>> +       outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
>> +
>> +       tnl = ((void *)hdr) + tnl_hdr_offset;
>> +       inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
>> +       inner_nh = __virtio16_to_cpu(little_endian, tnl->inner_nh_offset);
>> +       outer_th = __virtio16_to_cpu(little_endian, tnl->outer_th_offset);
>> +       if (outer_th < outer_l3min ||
>> +           inner_nh < outer_th + sizeof(struct udphdr) ||
>> +           inner_th < inner_nh + inner_l3min)
>> +               return -EINVAL;
> 
> I wonder if kernel has already had helpers to validate the tunnel
> headers 

Not that I know of.

> or if the above check is sufficient here.

AFAICS yes. Syzkaller is out there just to prove me wrong...


>> +
>> +       /* Let the basic parsing deal with plain GSO features. */
>> +       ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
>> +                                     hdr->gso_type & ~gso_tunnel_type);
>> +       if (ret)
>> +               return ret;
>> +
>> +       skb_set_inner_protocol(skb, outer_isv6 ? htons(ETH_P_IPV6) :
>> +                                                htons(ETH_P_IP));
> 
> The outer_isv6 is somehow misleading here, I think we'd better rename
> it as inner_isv6?

There is bug above, thanks for spotting it. I should not use the
`outer_isv6` variable, instead I should compute separately `inner_isv6`

>> +       if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>> +               if (!tnl_csum_negotiated)
>> +                       return -EINVAL;
>> +
>> +               skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
>> +       } else {
>> +               skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
>> +       }
>> +
>> +       skb->inner_transport_header = inner_th + skb_headroom(skb);
> 
> I may miss something but using skb_headroom() means the value depends
> on the geometry of the skb and the headroom might vary depending on
> the size of the packet and other factors.  (see receive_buf())

Yes, that is correct: the actual inner_transport_header value depends on
the skb geometry, because the (inner) transport header is located at
skb->head + skb->inner_transport_header.

>> +       skb->inner_network_header = inner_nh + skb_headroom(skb);
>> +       skb->inner_mac_header = inner_nh + skb_headroom(skb);
> 
> This actually equals to inner_network_header, is this intended?

Yes. AFAICS the inner mac header field is used only for GSO/TSO.

At this point we don't know if the inner mac header is actually present
nor it's len (could include vlan tag).

Still the above allows correct segmentation by the GSO stage because the
inner mac header is not copied verbatim in the segmented packets, alike
the tunnel header.

With the above code, the inner mac header if really present will be
logically considered part of the tunnel header by the GSO stage.

Note that some devices restrict the TSO capability to some fixed values
of the UDP tunnel sizes and inner mac header. In such cases, they will
fallback to S/W GSO.

>> +       skb->transport_header = outer_th + skb_headroom(skb);
>> +       skb->encapsulation = 1;
>> +       return 0;
>> +}
>> +
>> +static inline int virtio_net_chk_data_valid(struct sk_buff *skb,
>> +                                           struct virtio_net_hdr *hdr,
>> +                                           bool tun_csum_negotiated)
> 
> This is virtio_net.h so it's better to avoid using "tun". Btw, I
> wonder why this needs to be called by the virtio-net instead of being
> called by hdr_to_skb helpers.

I can squash into virtio_net_hdr_tnl_to_skb(), I kept them separated to
avoid extra long argument lists, but we are dropping an argument from
virtio_net_hdr_tnl_to_skb(), so should be ok.

>> +{
>> +       if (!(hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL)) {
>> +               if (!(hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID))
>> +                       return 0;
>> +
>> +               skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +               if (!(hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM))
>> +                       return 0;
>> +
>> +               /* tunnel csum packets are invalid when the related
>> +                * feature has not been negotiated
>> +                */
>> +               if (!tun_csum_negotiated)
>> +                       return -EINVAL;
> 
> Should we move this check above VIRTIO_NET_HDR_F_DATA_VALID check?

It could break existing setups. We can safely do extra validation only
when we know that the UDP tunnel features have been negotiated.

>> +               skb->csum_level = 1;
>> +               return 0;
>> +       }
>> +
>> +       /* DATA_VALID is mutually exclusive with NEEDS_CSUM,
> 
> I may miss something but I think we had a discussion about this, and
> the conclusion is it's too late to fix as it may break some legacy
> devices?

I'm not sure what should be fixed here? This check implements exactly
restriction you asked for while discussing the spec. We can't have a
similar check for non UDP tunneled packets, because it could break
existing setup.

> 
>> and GSO
>> +        * over UDP tunnel requires the latter
>> +        */
>> +       if (hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID)
>> +               return -EINVAL;
>> +       return 0;
>> +}
>> +
>> +static inline int virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>> +                                             struct virtio_net_hdr *hdr,
>> +                                             unsigned int tnl_offset,
>> +                                             bool little_endian,
>> +                                             int vlan_hlen)
>> +{
>> +       struct virtio_net_hdr_tunnel *tnl;
>> +       unsigned int inner_nh, outer_th;
>> +       int tnl_gso_type;
>> +       int ret;
>> +
>> +       tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>> +                                                   SKB_GSO_UDP_TUNNEL_CSUM);
>> +       if (!tnl_gso_type)
>> +               return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
>> +                                              vlan_hlen);
>> +
>> +       /* Tunnel support not negotiated but skb ask for it. */
>> +       if (!tnl_offset)
>> +               return -EINVAL;
> 
> Should we do BUG_ON here?

I don't think so. BUG_ON()s are explicitly discouraged to avoid crashing
the kernel on exceptional/unexpected situation.

The caller will emit rate limited warns with the relevant info, if this
is hit. The BUG_ON() stack trace will add little value.

>> +
>> +       /* Let the basic parsing deal with plain GSO features. */
>> +       skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>> +       ret = virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
>> +                                     vlan_hlen);
>> +       skb_shinfo(skb)->gso_type |= tnl_gso_type;
>> +       if (ret)
>> +               return ret;
> 
> Could we do the plain GSO after setting inner flags below to avoid
> masking and unmasking tnl_gso_type?

virtio_net_hdr_from_skb() will still receive a skb with UDP tunnel GSO
type and will error out.

The masking coudl be avoided factoring out a __virtio_net_hdr_from_skb()
helper receiving an explicit gso_type argument. I can do that if it's
preferred.

/P


