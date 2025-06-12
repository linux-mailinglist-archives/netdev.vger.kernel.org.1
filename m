Return-Path: <netdev+bounces-196888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1218AD6D36
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BD73A0C22
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B6D22DA19;
	Thu, 12 Jun 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCJ/THnW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F523027C
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723008; cv=none; b=Re6mVlGBhKf5rV3g3E5xY7P79JSg0lWPrxwPS2SJcz0P3gzrVUQ6qyD3NNVcKi6C+dQaPmRPEJUrs2Fd+NjjK3lwxJ4agig3QhkcfCynX/JWMMHCbI2rvrCCIaETrCWfd/63yawtuP6/F9dezeuIseY7LTq799Nfj+Et6tR7Ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723008; c=relaxed/simple;
	bh=ZKjCioljUKG5fh+VtzGCuA/2dfXZu4vx/wbPudUxtrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUTor8ueFsrlN4/JL4yrHicoV4yITQEmkS6VCeR7v6pL79vFHhb90kYmvosPRzXf5GQ3D7sU6J0v9W0pManD53bXJIA2LDUqS5BsLy9fI86fmuCECp+6+MrGpsBx/OIyo4lgZg+jQ/kLBAC9D0+bLCHooLEg4Jir0hYjhTrmg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCJ/THnW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749723005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piy/IsMSN3oRHGmuOLoC7uROS6ercngAdul2W1/pvaU=;
	b=gCJ/THnWWijDZy+fJQxKutV6enNFHK+VWSq3MEsq92xqIZPCRW9sNDA/tvYlyg6WonmDRY
	CjOK237lzvGP24aaBv0MX30SX0AeQtiefXbypDobCCrHDLr3Wiy6BHSRBxnVjgaYWVhmwP
	R+WEx/2gtzU2cEgW3YgT2C35zTf5WX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Z13HdpTVMcCnu40rbPBGlA-1; Thu, 12 Jun 2025 06:10:04 -0400
X-MC-Unique: Z13HdpTVMcCnu40rbPBGlA-1
X-Mimecast-MFC-AGG-ID: Z13HdpTVMcCnu40rbPBGlA_1749723003
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-441c122fa56so3781065e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723003; x=1750327803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piy/IsMSN3oRHGmuOLoC7uROS6ercngAdul2W1/pvaU=;
        b=EaLP+GxWp839nvIN2HY66yNLd5Az2wtFWWg0BWtrrcUYvJf7kI7CSVUmdLmd00wlm9
         4ZV9vZ7lrKJQRkWvgF8kZIyP6Z/LmFB0x8AFXRIw7Y37bhwBbVLGjMxKA5P0RlUbqlVu
         VHUexGIQsQNqt8dXcgSdBNNi75PdxfPBnll4LK64eFazDLjGXleIyFH8itVJXBoecL1Q
         IrPEyIzHKmy+pz2sOTpUueQRM5/eMpJLgJHGYd9ZccdTdROfvQMktj8Kn0vOjhPHtvIm
         Z6mvzyOWX/PGcPRAozWuPe3kcFHuJGICZakxEKK0LAAKS2vyx0rwqftVSvmd7D+P3GkA
         9tMA==
X-Gm-Message-State: AOJu0YxG1MitUnBdvVd5PWZlQqcDOeXB1O1U9CJ9Lbzi0eCW6PmUKze4
	D2qg5fHi9R8MImhrSH0m+HS7rVop2ay5ksHnFO+TNUdk/hxA/fLGhVnbpbuYyQo19b0khLM5iT+
	Ws7mIHKD1gW1Su0o3w6iWuTT39YFZq2bJq2fIo1Lvwrc7BqjsP6xKFiI/uA==
X-Gm-Gg: ASbGncsJN0H7DyOOROrzinHTlxQNnEf+brfjoDyc9UGxkhq23nF7BY5Ux8ycpt0Eyn1
	rZdnrxxSBoUIlqZYfTUzI5stdVKG2P121naHPv6bSSYLALJ2R/gzf4nlUgaA1nT9LZpd9KdaOz1
	ljIZte+OOjcsSUCXxeosqRGJrDaFOpJUmybnZ5uX8Vf9fEnLVK3EpCSkZoThIAEMvKcgXqnfG3b
	5RWjQdAqEgb3lhboxZVfNegdthzTg7G854y2MN7CEPap9mZWBhLx313Ot+eeXn4YeerSqh1I1u0
	Pie11mY4yUlrnzR1C5z2m6gHRy/IyD0wqTbYyuL9xg4cfbgaxchwqNgi
X-Received: by 2002:a05:600c:3511:b0:450:c210:a01b with SMTP id 5b1f17b1804b1-453248be488mr63422205e9.17.1749723002937;
        Thu, 12 Jun 2025 03:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmE0g3w0L+yZtcdplbt2DUeG4t+J2RSWARggcOf/huHjLqbO8cA8k67o51yoTesGfTwZ1Y6Q==
X-Received: by 2002:a05:600c:3511:b0:450:c210:a01b with SMTP id 5b1f17b1804b1-453248be488mr63421985e9.17.1749723002554;
        Thu, 12 Jun 2025 03:10:02 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:8b:591b:3de:f160? ([2001:67c:1220:8b4:8b:591b:3de:f160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea17d7sm15834965e9.10.2025.06.12.03.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:10:02 -0700 (PDT)
Message-ID: <e0e6139b-8afd-45ea-8396-b872245d398c@redhat.com>
Date: Thu, 12 Jun 2025 12:10:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <fa6c0bbe268dfdd6981741580efc084d101c1e7d.1749210083.git.pabeni@redhat.com>
 <CACGkMEsBsX-3ztNkQTH+J_32LcFaMwv-pOpTX0rXdLMmCj+JAA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsBsX-3ztNkQTH+J_32LcFaMwv-pOpTX0rXdLMmCj+JAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 5:53 AM, Jason Wang wrote:
> On Fri, Jun 6, 2025 at 7:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
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
>> +
SKB_GSO_UDP_TUNNEL_CSUM);
>> +       if (!tnl_gso_type)
>> +               return virtio_net_hdr_from_skb(skb, hdr,
little_endian, false,
>> +                                              vlan_hlen);
>
> So tun_vnet_hdr_from_skb() has
>
>         int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>         int tnl_offset = tun_vnet_tnl_offset(flags);
>
>         if (virtio_net_hdr_tnl_from_skb(skb, hdr, tnl_offset,
>                                         tun_vnet_is_little_endian(flags),
>                                         vlan_hlen)) {
>
>
> It looks like the outer vlan_hlen is used for the inner here?
vlan_hlen always refers to the outer vlan tag (if present), as it moves
the (inner) transport csum offset accordingly.

I can a comment to clarify the parsing.

Note that in the above call there is a single set of headers (no
encapsulation) so the vlan_hlen should be unambigous.
>> +
>> +       /* Tunnel support not negotiated but skb ask for it. */
>> +       if (!tnl_offset)
>> +               return -EINVAL;
>> +
>> +       /* Let the basic parsing deal with plain GSO features. */
>> +       skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>> +       ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);

Here I'll add:

	Here vlan_hlen refers to the outer headers set, but still affect
	the inner transport header offset.

>> @@ -181,6 +208,22 @@ struct virtio_net_hdr_v1_hash {
>>         __le16 padding;
>>  };
>>
>> +/* This header after hashing information */
>> +struct virtio_net_hdr_tunnel {
>> +       __le16 outer_th_offset;
>> +       __le16 inner_nh_offset;
>> +};
>> +
>> +struct virtio_net_hdr_v1_tunnel {
>> +       struct virtio_net_hdr_v1 hdr;
>> +       struct virtio_net_hdr_tunnel tnl;
>> +};
>> +
>> +struct virtio_net_hdr_v1_hash_tunnel {
>> +       struct virtio_net_hdr_v1_hash hdr;
>> +       struct virtio_net_hdr_tunnel tnl;
>> +};
>
> Not a native speaker but I realize there's probably an issue:
>
>         le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
negotiated)
>         le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
negotiated)
>         le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
negotiated)
>         le16 outer_th_offset    (Only if
> VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> negotiated)
>         le16 inner_nh_offset;   (Only if
> VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> negotiated)
>         le16 outer_nh_offset;   /* Only if VIRTIO_NET_F_OUT_NET_HEADER
> negotiated */
>         /* Only if VIRTIO_NET_F_OUT_NET_HEADER or VIRTIO_NET_F_IPSEC
> negotiated */
>         union {
>                 u8 padding_reserved_2[6];
>                 struct ipsec_resource_hdr {
>                         le32 resource_id;
>                         le16 resource_type;
>                 } ipsec_resource_hdr;
>         };
>
> I thought e.g outer_th_offset should have a fixed offset then
> everything is simplified but it looks not the case here. If we decide
> to do things like this, we will end up with a very huge uAPI
> definition for different features combinations. This doesn't follow
> the existing headers for example num_buffers exist no matter if
> MRG_RXBUF is negotiated.>> At least, if we decide to go with the
dynamic offset, it seems less
> valuable to define those headers with different combinations if both
> device and driver process the vnet header piece wisely

I'm a little confused here. AFAICT the dynamic offset is
requested/mandated by the specifications: if the hash related fields are
not present, they are actually non existing and everything below moves
upward.  I think we spent together quite some time to agree on this.

If you want/intend the tunnel header to be at fixed offset inside the
virtio_hdr regardless of the negotiated features? That would yield to
slightly simpler but also slightly less efficient implementation.

Also I guess (fear mostly) some specification clarification would be needed.

/P


