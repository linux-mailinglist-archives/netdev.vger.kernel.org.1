Return-Path: <netdev+bounces-196889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEFBAD6D67
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B1816F085
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588A231848;
	Thu, 12 Jun 2025 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReXW+NGQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03E231853
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723483; cv=none; b=mrrI2AmJG174UVm50KPGIF8OWIO+2Nq9IH5x44LvL+hO2CjC9xf/Tdjo48yJwSrSvQup2psw826IlqZD8ok7r9Az4txv+vHVQreqKWboQVUhUGa/7EbEo8SlHcmqaZE9ljmLQXbOzB8nxVUOFMswNkHLmjoRZ1RmU2puENLRPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723483; c=relaxed/simple;
	bh=COrrFwIiThpm7d94NvzpRlqXyGmSvjNqYT8WBny5iwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sunbDBStHLy+oSZYdzc6npVVd8oSWEllI3oR2so+PaNwDR8GdBJilF68MV7bkkUCLq6hblmDBfdvYCiXLkOlilZEIld75YV4hZsg6AEZrnWAsN/kPHhw0rf8/8jU/fnq0KTEa8RpEPsSgDBIy3c7DZexboae4KNkeEFG4MOjxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReXW+NGQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749723480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0+9NeZl/IX3Ols2NzLjhizxSXYdZ4q2FzqWRLBBhvc=;
	b=ReXW+NGQ8G2z6sKHYIw8R9n1DoLDYq4lG6cLEPEOyZQkLvHorGDSNiNISS+NGVqkobBWS7
	QYI3Gyi2UjU10V3htVoR6Li6B3098ALGWYu5nFuSlVTzurB/FW75htPJDkdM6EYoSfbnUf
	i9u3iwwtIh/nJkuq9TC210RlldHdHz4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-cpSxpVAAO2StnADfJw_VkA-1; Thu, 12 Jun 2025 06:17:59 -0400
X-MC-Unique: cpSxpVAAO2StnADfJw_VkA-1
X-Mimecast-MFC-AGG-ID: cpSxpVAAO2StnADfJw_VkA_1749723478
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d64026baso4620655e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723478; x=1750328278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0+9NeZl/IX3Ols2NzLjhizxSXYdZ4q2FzqWRLBBhvc=;
        b=tUfErhu5TGap/N7UzvQon5F63VYcZBg5J4UltoJbO2aVdNq+QU+K3lUVUy9iY8H6wm
         xZYpO4aqGgXJdB5OsNR7elOm3dL+CDD6nAhCIr5A4qTKemBQy/BGgtjkhbtRC8QECegT
         DINcE2dEhke567oFgrO2g4xjaPUoeicOHwM0WRgPGGVaH1OSvKoWnLoa6/cEN3QGoSSI
         N9gIp0xel5uGJ+Nzto0TD+vBbQ6lrpwo5ED6bDfdR7AW+MAbesXijxQk8cqKgI0q+M3t
         FXpPBXrgn/TwLfnJSzazcBe2de6VpEpb20/6weLV49V9EvzyeAF4/LNm/joEWq+lq38Q
         fEiw==
X-Gm-Message-State: AOJu0Yzb3x/XDXwG+8MsgZkzcAdmD7BYEtSROjnRf2Dj4K/DBT53xmSp
	n0BIncDlA9XY56gsPmJ8Os49EmKRjfTAf6PKb0uiAXQMMiGdHaIOY2W2INtuiZ390xPtTf4U1Nr
	moa6PnuboBg9YXfZCrjWZ0UHzxPkJ/QKJhv7DQyQS00aYf2hszVRGNFDhlA==
X-Gm-Gg: ASbGnct3rpdbJlHEX1rYgUJHoDyF5l/OU7bNInZGn7NJ37CgRzMNuQcHwcs3u+PFPa1
	/kE8C240rxW+IPY7e3t2C57crbsGFJtSE/rdIxSOeyJNYFhL2+x+COa4KXnH4DpnvA+MUpJ0wzk
	TVMN+ShWpvs6Oe/uE0Klypsv/soD2oYFMBF9oCcMC1JXyk34FweQ3VHbVH+hrINWcs95pFg2BUo
	PnDQy+ZZzH6eTWEZDCKW4BAmR57kSwsyIt795lMWMzmlNWGQPi+2qrvgYZADOrT9TQMTSyrdOZ3
	7hxAfqu+LOofQcAoo3qUj5gFWIf7YBy66zo/eJRDldbvAvggABrD4vBW
X-Received: by 2002:a05:6000:2409:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3a5586cb148mr5689696f8f.34.1749723478501;
        Thu, 12 Jun 2025 03:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFESdDJbhx5/VQcpnHpsepwLtotF1M6RNAqmThCRcLpi4WkCRB4psjWoU7e8j+448I45YHJaA==
X-Received: by 2002:a05:6000:2409:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3a5586cb148mr5689665f8f.34.1749723478094;
        Thu, 12 Jun 2025 03:17:58 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:8b:591b:3de:f160? ([2001:67c:1220:8b4:8b:591b:3de:f160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e151c3csm16233505e9.30.2025.06.12.03.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:17:57 -0700 (PDT)
Message-ID: <91fcc95c-8527-4b4c-9c19-6a8dfea010ac@redhat.com>
Date: Thu, 12 Jun 2025 12:17:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 6/8] virtio_net: enable gso over UDP tunnel
 support.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <d10b01bd14473ad95fb8d7f83ab1cd7c40c2a10e.1749210083.git.pabeni@redhat.com>
 <CACGkMEtP5PoxS+=veyQimHB+Mui2+71tpJUYg5UcQCw9BR8yrg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtP5PoxS+=veyQimHB+Mui2+71tpJUYg5UcQCw9BR8yrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 6:05 AM, Jason Wang wrote:
> On Fri, Jun 6, 2025 at 7:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> If the related virtio feature is set, enable transmission and reception
>> of gso over UDP tunnel packets.
>>
>> Most of the work is done by the previously introduced helper, just need
>> to determine the UDP tunnel features inside the virtio_net_hdr and
>> update accordingly the virtio net hdr size.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v2 -> v3:
>>   - drop the VIRTIO_HAS_EXTENDED_FEATURES conditionals
>>
>> v1 -> v2:
>>   - test for UDP_TUNNEL_GSO* only on builds with extended features support
>>   - comment indentation cleanup
>>   - rebased on top of virtio helpers changes
>>   - dump more information in case of bad offloads
>> ---
>>  drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++---------
>>  1 file changed, 54 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 18ad50de4928..0b234f318e39 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -78,15 +78,19 @@ static const unsigned long guest_offloads[] = {
>>         VIRTIO_NET_F_GUEST_CSUM,
>>         VIRTIO_NET_F_GUEST_USO4,
>>         VIRTIO_NET_F_GUEST_USO6,
>> -       VIRTIO_NET_F_GUEST_HDRLEN
>> +       VIRTIO_NET_F_GUEST_HDRLEN,
>> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED,
>> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED,
>>  };
>>
>>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>> -                               (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>> -                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>> -                               (1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
>> -                               (1ULL << VIRTIO_NET_F_GUEST_USO4) | \
>> -                               (1ULL << VIRTIO_NET_F_GUEST_USO6))
>> +                       (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>> +                       (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>> +                       (1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
>> +                       (1ULL << VIRTIO_NET_F_GUEST_USO4) | \
>> +                       (1ULL << VIRTIO_NET_F_GUEST_USO6) | \
>> +                       (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) | \
>> +                       (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED))
>>
>>  struct virtnet_stat_desc {
>>         char desc[ETH_GSTRING_LEN];
>> @@ -436,9 +440,14 @@ struct virtnet_info {
>>         /* Packet virtio header size */
>>         u8 hdr_len;
>>
>> +       /* UDP tunnel support */
>> +       u8 tnl_offset;
>> +
>>         /* Work struct for delayed refilling if we run low on memory. */
>>         struct delayed_work refill;
>>
>> +       bool rx_tnl_csum;
>> +
>>         /* Is delayed refill enabled? */
>>         bool refill_enabled;
>>
>> @@ -2531,14 +2540,22 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>>         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>>                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>>
>> -       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
>> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +       /* restore the received value */
> 
> Nit: this comment seems to be redundant
> 
>> +       hdr->hdr.flags = flags;
>> +       if (virtio_net_chk_data_valid(skb, &hdr->hdr, vi->rx_tnl_csum)) {
> 
> Nit: this function did more than just check DATA_VALID, we probably
> need a better name.

What about virtio_net_handle_csum_offload()?

> 
>> +               net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x rx_tnl_csum %d\n",
>> +                                    dev->name, hdr->hdr.flags,
>> +                                    hdr->hdr.gso_type, vi->rx_tnl_csum);
>> +               goto frame_err;
>> +       }
>>
>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>> -                                 virtio_is_little_endian(vi->vdev))) {
>> -               net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>> +       if (virtio_net_hdr_tnl_to_skb(skb, &hdr->hdr, vi->tnl_offset,
> 
> I wonder why virtio_net_chk_data_valid() is not part of the
> virtio_net_hdr_tnl_to_skb().

It can't be part of virtio_net_hdr_tnl_to_skb(), as hdr to skb
conversion is actually not symmetric with respect to the checksum - only
the driver handles DATA_VALID.

Tun must not call virtio_net_chk_data_valid()  (or whatever different
name will use).

/P


