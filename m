Return-Path: <netdev+bounces-228680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC27BD1F37
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282B23BEB2B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B122ED15C;
	Mon, 13 Oct 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrMDkz1g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1E2EC564
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343104; cv=none; b=hkOl1Ixt3JSwqWcPlFfGfMlYUcdqGyAr0abXqOrPMuh2kB1TfXpmQw7zcNwXyVhqXxdiyCo2qBLmS0/4oB7va0JR9Isu+4Z3awC+WTdPwIMXDqipeXX+Eh9xVfPRN+dkWdbex1u2lAAnD+1Ok+c64a5ympjMLuC3bJW0Txe9+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343104; c=relaxed/simple;
	bh=9yCeUnVOh4PkNtq971jR4OvxcgQqKArslTOCky9HAQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LztEksIQEs8axj66Za+En+PKWahz3ktRiI6Bag59cAOe3FIBNL25xa/PvgRhcMUejc/KKyEC2WQkqv432qR85/0zJSVt5nxf0FaWGGiZgc1ZAeeluMSSuuQkV3Qg13SJSbYNrEdpDDwWYYb+cDjwMwnqvM1kBdYYNRTqADYldqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrMDkz1g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760343101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1tPp8YEljYMfDXm3ZuBVdpyd9eaR3nb2fIv3sUlkgA=;
	b=LrMDkz1g41hoUfjBS7RIXFSScTQiGibBNcRz/e+Sa5FB+AnKuWGG2ciN9UuasDwMyxrISZ
	F4EQBQMHpHyNQM0YilxPMadcKdGQtgime0bufBXQWs0XNLvs8a35HcNvUUbltTwszRNrRY
	f1dbRE2rJI4eKICGto18oNI18lZqA90=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-EupemKlQPg2FVuKGiHYaxw-1; Mon, 13 Oct 2025 04:11:39 -0400
X-MC-Unique: EupemKlQPg2FVuKGiHYaxw-1
X-Mimecast-MFC-AGG-ID: EupemKlQPg2FVuKGiHYaxw_1760343099
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee888281c3so4678420f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 01:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343099; x=1760947899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1tPp8YEljYMfDXm3ZuBVdpyd9eaR3nb2fIv3sUlkgA=;
        b=biQR9TRWxK6PqPlZhp/sp7lyH6OsEIzU70Immcfh+gPsTxTjEqsWeSajqAeCdGkbRn
         k33XfUKIshr5tbUkGmVWqTErToGRyK4GVZ2ezuFCpEEI9GHkm8uHEWUOinashH2TIf24
         iLfleka5IWSBXnHiTC8mCegK+I6eFZKNbX/1OZCzqB2+tXXOkjaHESao/lY1+9xrZVuM
         PusRW4Mc33wZh1Jy3HxIMi0KlyxELSZzFeDNEltwh3kefc6bNUd4H3gApC8NzW7zU+hs
         Pl5rov91tnNWsLAksvRTKRUBZw27PDJz7a/exbCQEswi/+m2aXoxJBV8qaVg28xDJ+nA
         JJZw==
X-Forwarded-Encrypted: i=1; AJvYcCUNekUVXa2wrhxrHOBO0j4N6zGAZlax+iFTNvLv71ZNZEBSSqilHT9i5N58gwL/yX8OJ1qz9J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDRAk1UKsMIhkiaKXCk/iL/975R1FwxIguljr/ss3WLwF1w65k
	wFN4BD/HuHSiA+BfHnCdKZEUhLn7fl62mVQXDXgshWZj2faFJqu1hLfx1p2imDrJWiAQkrj17sy
	s63B01vFX3n5xSc5NZYDG/p+0K0RDYdGrr0AfE1nGNQVOQWRsm4c1wf0xAw==
X-Gm-Gg: ASbGnctnu27Edb0wAWrU8VB/jRkbXTyoCp45UEMF+7zt+DiC0nUYvu1M2ey56Fxz2/2
	B7PrZ7z5LVQLqbLUfWQF5H1TJcwKa4fUS/8G4HG1UJMgfeKgH8qItTEGozoB5LYMYt6O2nDXMyn
	DQP/iAnJy9250A7FSwK9c93fnP+Go0WO6zUmuacB33nAwRsAQaVnXy3XuGvxpuqfO2cXizRiIgx
	KHzRoXIhDZS0LhmtX8jJtCQtPfIru7h9gqh0Y97gooQ284V0zqnmIsNqD8MBJncsPB66mQbJTot
	mMuDJaGU8SVg5/WgUfauIJVjBm0LPKUeCTrhL+cUJ1x8
X-Received: by 2002:a05:6000:603:b0:407:77f9:949e with SMTP id ffacd0b85a97d-42666ac7026mr12223996f8f.21.1760343098687;
        Mon, 13 Oct 2025 01:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7JlCWnkPct1cz9l8P3e2Ai1ZjwIQPTyoLeL4/jqXzDz+4utC6DGYywfrc0J3b6VB+SnU/BQ==
X-Received: by 2002:a05:6000:603:b0:407:77f9:949e with SMTP id ffacd0b85a97d-42666ac7026mr12223975f8f.21.1760343098309;
        Mon, 13 Oct 2025 01:11:38 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc03sm17518704f8f.4.2025.10.13.01.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:11:37 -0700 (PDT)
Message-ID: <27931e85-451f-4711-9681-38db2563efc2@redhat.com>
Date: Mon, 13 Oct 2025 10:11:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] virtio-net: correct hdr_len handling for
 tunnel gso
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
 <20251013020629.73902-4-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013020629.73902-4-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 4:06 AM, Xuan Zhuo wrote:
> The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> virtio-net.
> 
> The virtio spec says:
> 
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
>     all the headers up to and including the inner transport.
> 
> The commit did not update the hdr_len to include the inner transport.
> 
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Side note: qemu support for UDP GSO tunneling is available in qemu since
commit a5289563ad.

> ---
>  include/linux/virtio_net.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index e059e9c57937..765fd5f471a4 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -403,6 +403,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
>  	unsigned int inner_nh, outer_th;
>  	int tnl_gso_type;
> +	u16 hdr_len;
>  	int ret;
>  
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
> @@ -434,6 +435,23 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	outer_th = skb->transport_header - skb_headroom(skb);
>  	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
>  	vhdr->outer_th_offset = cpu_to_le16(outer_th);
> +
> +	switch (skb->inner_ipproto) {
> +	case IPPROTO_TCP:
> +		hdr_len = inner_tcp_hdrlen(skb);
> +		break;
> +
> +	case IPPROTO_UDP:
> +		hdr_len = sizeof(struct udphdr);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	hdr_len += skb_inner_transport_offset(skb);
> +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);

I'm not sure this is the correct fix.

virtio_net_hdr_tnl_from_skb() just called virtio_net_hdr_from_skb() on
the inner header. The virtio spec also specifies:

"""
 If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
 \field{hdr_len} indicates the header length that needs to be replicated
 for each packet. It's the number of bytes from the beginning of the packet
 to the beginning of the transport payload.
"""

If `hdr_len` is currently wrong for UDP GSO packets, it's also wrong for
 plain GSO packets (without UDP tunnel) and the its value should be
possibly fixed in virtio_net_hdr_from_skb().

Thanks,

Paolo


