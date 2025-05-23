Return-Path: <netdev+bounces-192949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B55AC1CC8
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C71E1BC7B2D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 06:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A3215181;
	Fri, 23 May 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edQyIJBI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDE17A2F6
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747980574; cv=none; b=e73pGYylsalyWFyEIBLK+mlIE4bXiZB61zQmM4QE+bxFtoNumUe+FskuJHrH6YFqxzXtKmfUv42wHhwWyGGxnBHcb9EejKapkXygN8S0oX3NuVN7FTvGK/05aj02K2eIQbSDgyLf9FfTt7Mi/fVAQ2Gvkrk4d3zzEFoS1ihmMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747980574; c=relaxed/simple;
	bh=aarnJrl9irk6wOck4Lne1B72AKPvEc6OxSpnd5XAxKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPTuP8J4TAmkgVP0A+G6RFCQihWu+cjVfTwzMq2DBXKQcsRlnzL4n0vRMCaFyBH3xZaE7o0nSy/pN+4upOa/DInEpYdVUy4hYIyGT2gzlMolkVNWVH2GWrQQLOCahnlaFtrlc/07Lqj/llCMqnUGWzkfMOJcmrqUHJtKVtg4rF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edQyIJBI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747980570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NC6t/B9/6a5n6eTVI1VnjzQesQchVPse5FLfnPy9UN0=;
	b=edQyIJBID3vXTOPfHY8Ple8e0YhMNZ7DP/CyLQXOIndfe2rt5RP8S5yR5fteea5HDyRMiB
	YUKBthgKGgIrrIblm72XBVW2NREDWZUdvpalGwoJtCgQ2nFTn0TvWR+kssfT1h475RZQw4
	rVMaUiAbB6d3TQf61xXX/MGUkyfmA9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Ykh7oPeJMIOjYpSfO8x01Q-1; Fri, 23 May 2025 02:09:28 -0400
X-MC-Unique: Ykh7oPeJMIOjYpSfO8x01Q-1
X-Mimecast-MFC-AGG-ID: Ykh7oPeJMIOjYpSfO8x01Q_1747980567
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-44a3b5996d2so7338195e9.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747980567; x=1748585367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NC6t/B9/6a5n6eTVI1VnjzQesQchVPse5FLfnPy9UN0=;
        b=V7GD6bBh7FRa6nPEidWcMOxu1OOF8ZavzintwMIPilNCLfRRYbuZS4fdGq5Tk1HpoQ
         zq2cajfvlLJIEpxSR4IBcGBd7M24iCCTHT6+58jhlgXKyB86uORPrz+odvQpX9sqdhye
         ICI19jg9tZqyuS0p1LqC4VvyV3TmKuuBsF6HbpsuDvuSS3UieJnDGwd3vgjI9L+1w5LM
         a5xAbXXFB06SBdU8LgNBqkKR8XQGpNAjm5ZK3whAkqcv7orLwD4FxTRMiwlWmfv8Soe+
         VRVMWbB1lu+3cXQI02HgAk6anHN1Ruu9S/traxxWTkh5iR9sN8w7q7IS1q4qDXnbrwC8
         UjNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAnGs/MBgcFaMqCHcA5qkUWQgPKWTqsaaA5GKedxD4O2Vcxu2ArBYuqYSyT6G4ghv4kW/2zuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fpCQC1nv7IF2LEcNHktIqeV4vrRuljU4squY4oItcE4Qnjh1
	5Gkgj5UdHmCs/QvSKW4ab9IpTgxiIJKwncy/X/Qh68VSNfeMI3hKFxKAFW76VgpM/2e5ZK0JeAd
	b9pZyp980gl3A4K6Tv44Di3ZFStFnw310sTQN7lSuJGY+kECZ/jsmFtdLfQ==
X-Gm-Gg: ASbGncvxPa8JBGeUovYi0orMQdyK7mpDp7U3hzS3LRmEiznx6qbIsYWG0j5Fwk9qm3n
	XXeo9d1nIJDUXKEcO2U/2zEK3RLFgcjwhKKlu42gVnQaNyVVBBRerv39tpIspv6KseT43pTqpVH
	uF3Neu21MiWt5pcsBGyue4Ujno6ujnYWRqtRKV5xxHXCqtCXHW3BUD2a4fFYOZAe7YhwX3JF7ze
	uUXa++Z8Ui3ouiw2cSSoZIVcSFfHILJFYf1craxgX7K+o8c8YFBk/iOgf1RCtKtHk5VtQuAaokS
	Rd/jmbHyLlmzayiptjw=
X-Received: by 2002:a05:600c:4ecc:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-44b6e85f1e4mr18153535e9.23.1747980567322;
        Thu, 22 May 2025 23:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZKGmut/99WjApZptUfE53JkXxuPe5DsFCTS00pa/G0raU7aZFlQHzLqGYTW1YSrcwJE9paQ==
X-Received: by 2002:a05:600c:4ecc:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-44b6e85f1e4mr18153315e9.23.1747980566879;
        Thu, 22 May 2025 23:09:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6210asm25146459f8f.41.2025.05.22.23.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 23:09:26 -0700 (PDT)
Message-ID: <2ccf883f-17f0-4eda-a851-f640fd2b6e14@redhat.com>
Date: Fri, 23 May 2025 08:09:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
 <682fa555b2bcc_13d837294a8@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <682fa555b2bcc_13d837294a8@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/23/25 12:29 AM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> The virtio specification are introducing support for GSO over
>> UDP tunnel.
>>
>> This patch brings in the needed defines and the additional
>> virtio hdr parsing/building helpers.
>>
>> The UDP tunnel support uses additional fields in the virtio hdr,
>> and such fields location can change depending on other negotiated
>> features - specifically VIRTIO_NET_F_HASH_REPORT.
>>
>> Try to be as conservative as possible with the new field validation.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> No major concerns from me on this series. Much of the design
> conversations took place earlier on the virtio list.
> 
> Maybe consider test coverage. If end-to-end testing requires qemu,
> then perhaps KUnit is more suitable for testing basinc to/from skb
> transformations. Just a thought.

My current idea is to follow-up on:

https://lore.kernel.org/netdev/20250522-vsock-vmtest-v8-1-367619bef134@gmail.com/

extending such infra to vhost/virtio, and implement GSO-over-UDP-tunnel
transfer with/without negotiated features on top of that.

In the longer term such infra could be used to have good code coverage
for virtio/vhost bundled into the kernel self-tests.

I hope it could be a follow-up, because I guess this series (and
especially the user-land counter-part) is going to b̵e̵ ̵a̵n̵ ̵h̵u̵g̵e̵
̵b̵l̵o̵o̵d̵b̵a̵t̵h̵  to take some time and effort in the current form.

>> ---
>>  include/linux/virtio_net.h      | 177 ++++++++++++++++++++++++++++++--
>>  include/uapi/linux/virtio_net.h |  33 ++++++
>>  2 files changed, 202 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index 02a9f4dc594d0..cf9c712a67cd4 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -47,9 +47,9 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>>  	return 0;
>>  }
>>  
>> +static inline int virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>> +					    const struct virtio_net_hdr *hdr,
>> +					    unsigned int tnl_hdr_offset,
>> +					    bool tnl_csum_negotiated,
>> +					    bool little_endian)
>> +{
>> +	u8 gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
>> +	unsigned int inner_nh, outer_th, inner_th;
>> +	unsigned int inner_l3min, outer_l3min;
>> +	struct virtio_net_hdr_tunnel *tnl;
>> +	u8 gso_inner_type;
>> +	bool outer_isv6;
>> +	int ret;
>> +
>> +	if (!gso_tunnel_type)
>> +		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
>> +
>> +	/* Tunnel not supported/negotiated, but the hdr asks for it. */
>> +	if (!tnl_hdr_offset)
>> +		return -EINVAL;
>> +
>> +	/* Either ipv4 or ipv6. */
>> +	if (gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 &&
>> +	    gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
>> +		return -EINVAL;
>> +
>> +	/* No UDP fragments over UDP tunnel. */
> 
> What are udp fragments and why is TCP with ECN not supported?

"udp fragments" is the syncopated form of "UDP datagrams carryed by IP
fragments". I'll use UFO to be clearer ;)

The ECN part is cargo cult on my side from my original implementation
which dates back to ... a lot of time ago. A quick recheck makes me
think I could drop it. I'll have a better look and either document the
choice or drop the check in the next revision.

>> +	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
>> +					   gso_tunnel_type);
>> +	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
>> +		return -EINVAL;
>> +
>> +	/* Relay on csum being present. */
> 
> Rely
> 
>>  #endif /* _LINUX_VIRTIO_NET_H */
>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> index 963540deae66a..1f1ff88a5749f 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -70,6 +70,28 @@
>>  					 * with the same MAC.
>>  					 */
>>  #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
>> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO 65 /* Driver can receive
>> +					      * GSO-over-UDP-tunnel packets
>> +					      */
>> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM 66 /* Driver handles
>> +						   * GSO-over-UDP-tunnel
>> +						   * packets with partial csum
>> +						   * for the outer header
>> +						   */
>> +#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO 67 /* Device can receive
>> +					     * GSO-over-UDP-tunnel packets
>> +					     */
>> +#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM 68 /* Device handles
>> +						  * GSO-over-UDP-tunnel
>> +						  * packets with partial csum
>> +						  * for the outer header
>> +						  */
>> +
>> +/* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSUM}
>> + * features
>> + */
>> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED	46
>> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED	47
> 
> I don't quite follow this. These are not real virtio bits?

This comes directly from the recent follow-up on the virtio
specification. While the features space has been extended to 128 bit,
the 'guest offload' space is still 64bit. The 'guest offload' are
used/defined by the specification for the
VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET command, which allows the guest do
dynamically enable/disable H/W GRO at runtime.

Up to ~now each offload bit corresponded to the feature bit with the
same value and vice versa.

Due to the limited 'guest offload' space, relevant features in the high
64 bits are 'mapped' to free bits in the lower range. That is simpler
than defining a new command (and associated features) to exchange an
extended guest offloads set.

It's also not a problem from a 'guest offload' space exhaustion PoV
because there are a lot of features in the lower 64 bits range that are
_not_ guest offloads and could be reused for mapping - among them the
'reserved features' that started this somewhat problematic features
space expansion.

For more details:

https://lore.kernel.org/virtio-comment/6af50c9ada76d8168d248827e4af7c44bdfa34a8.1747826378.git.pabeni@redhat.com/T/#u
https://lore.kernel.org/virtio-comment/68c4e73a-fa9e-4e2e-8c38-ed4a322bf47e@redhat.com/

Thanks,

Paolo


