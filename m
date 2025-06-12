Return-Path: <netdev+bounces-196925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472ABAD6E85
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196357A3652
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97298234971;
	Thu, 12 Jun 2025 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfbYWuG9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABD230D0E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726204; cv=none; b=KrHOkfN3zR5iN/qtvfCqEMvDdEtSYyPOzuexUKxIzs/l5PTyFBmazaouqq2ZwYN4VZpuY0WLR6GSJjDRodRaMmFuIXuxUf6ev5IO6TvGQgIgLGDgHLwmp242uUSDLXdu0sv3R2HPJthis0mWEySYk5P6mm6xGs5j3QjCh2cky8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726204; c=relaxed/simple;
	bh=ftyRV/3Dnfm11uGtUEyVfcf17GQi3dPbSkW/DrNTQEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENE9Z5gq8KV8ET3Mqllk+9i/PohcfFTaX8aDLMtprkRU6IkMC0PE/vvY/hYqadQGOJLvUYZdeqBc8xXkzajIeeMaAMalvH8QGnlW5YMKz7vKUgMadaI3l9B7ik/nQsEPD5ka7j+uNmKc2Wp9B/0lu+YQtPXBavxJm5CspULvdjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfbYWuG9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749726200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/cF36MipnT13oIfuAAMyoLU874U2EkOxT3Yws9jDWY=;
	b=YfbYWuG98iVpZPxwi1k4L9Obqk7fQ36hiHK5+5qa6MsJQ3cpBTZeG/K6sRdT95236BT/+9
	yFYRxa8hoGmcIH2X1QScxW7EcxnQIESyewgDw211Y5MMjQLPBeYLXIm4W9R2zXi5Yv5tdF
	W+JmvtYxp4d08YydpswSK4KgiidVE/A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ZgtfZweeOa25MpKADUdnUg-1; Thu, 12 Jun 2025 07:03:19 -0400
X-MC-Unique: ZgtfZweeOa25MpKADUdnUg-1
X-Mimecast-MFC-AGG-ID: ZgtfZweeOa25MpKADUdnUg_1749726199
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso412619f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749726198; x=1750330998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/cF36MipnT13oIfuAAMyoLU874U2EkOxT3Yws9jDWY=;
        b=fntJL7EUEeijM+2UvJ9jiViJ9W5oANcA8itPJnvT2XvKd8+ORhXc66ZFaiPeIerMRq
         bTqyrl8NRmcGdqht5lzXCDEVIm25RHqL0YCPc/xm8dcbznb4sijn/cHxn1s6eKzXo5HP
         0v2C1p8tplYSuoB081KknKeu0yT68fkyU4L9pib79VDX0d8DXw1Qvj5vKichTqo4lM/e
         Ajb0W77/PLF2FWXEqPowQr+JnvbSn8AjAQDznjq7NlNWevWunh14oIZvoCUIiUAZDfa8
         GCwYFImlblOgc51nNvLtKl4Byzj8C7c2Zb8MoSYx0RjZMguctz0sEoFc2WuoN8gdv5Pj
         Ld3Q==
X-Gm-Message-State: AOJu0YzPtXTMxT1ZVgj08zIpRUcc59/76fxOKih9C3IoGKm+UGEjogVg
	PmdXy76hSOeNJchFIR/NcvKUiPjlNmyFb87HsjmQGA7bz8L4WWjCOa9vWLZBJchPu8hNwJc6Y+5
	yFrNRFjMNDwNiipyC4vj5LwEIYiODN49w1Uuo0yCjw+omXl3rETPjVQRwaQ==
X-Gm-Gg: ASbGncvKLV22boEP6Mvq/G4S1utPSxtcAmmRRX97I5DNjo1UYSSqEN6dCgwsTXr0sBx
	5H1BdfohMj7ZfSWt43kLiGPJQ5AMmgh2RK5JL75H3Ygu0CpqkjJrxKFDNPTv7zAZ4nx3qy2HOI6
	7Iw2Lobf5FJJb7umOoOBrsyZ1LIg5XqtsA7lgMUNtUbz/EaxapGBki3zc7E10iC1fBuftK+TRZ4
	hxcvMPcqYS87tVRk4+55cYcW7sPb9qYKj6k8MooSDwF2nAHF08W+oOMuSE3eiGQNbtKe2mL3aGh
	+rtTlv1M17/SmTnjuGJe/UMum4pFE7a+U/hHvse7KwAL1efC/Za6sYnc
X-Received: by 2002:a5d:64c3:0:b0:3a4:d994:be7d with SMTP id ffacd0b85a97d-3a56130a6a1mr1941749f8f.23.1749726198479;
        Thu, 12 Jun 2025 04:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5N66FipX6+rlO0xsJbNkg0O5cwpxO3m2hmgji4JUwXODe/sbSwHg6OKmVR2aQ8H9Ar5Ireg==
X-Received: by 2002:a5d:64c3:0:b0:3a4:d994:be7d with SMTP id ffacd0b85a97d-3a56130a6a1mr1941709f8f.23.1749726198029;
        Thu, 12 Jun 2025 04:03:18 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:8b:591b:3de:f160? ([2001:67c:1220:8b4:8b:591b:3de:f160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56198c9absm1634833f8f.27.2025.06.12.04.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:03:17 -0700 (PDT)
Message-ID: <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com>
Date: Thu, 12 Jun 2025 13:03:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 6:55 AM, Jason Wang wrote:
> On Fri, Jun 6, 2025 at 7:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> @@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>
>>         if (tun->flags & IFF_VNET_HDR) {
>>                 int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>> +               int parsed_size;
>>
>> -               hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
>> +               if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {
> 
> I still don't understand why we need to duplicate netdev features in
> flags, and it seems to introduce unnecessary complexities. Can we
> simply check dev->features instead?
> 
> I think I've asked before, for example, we don't duplicate gso and
> csum for non tunnel packets.

My fear was that if
- the guest negotiated VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
- tun stores the negotiated offload info netdev->features
- the tun netdev UDP tunnel feature is disabled via ethtool

tun may end-up sending to the guest packets without filling the tnl hdr,
which should be safe, as the driver should not use such info as no GSO
over UDP packets will go through, but is technically against the
specification.

The current implementation always zero the whole virtio net hdr space,
so there is no such an issue.

Still the additional complexity is ~5 lines and makes all the needed
information available on a single int, which is quite nice performance
wise. Do you have strong feeling against it?

>> @@ -2426,7 +2460,16 @@ static int tun_xdp_one(struct tun_struct *tun,
>>         if (metasize > 0)
>>                 skb_metadata_set(skb, metasize);
>>
>> -       if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
>> +       /* Assume tun offloads are enabled if the provided hdr is large
>> +        * enough.
>> +        */
>> +       if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
>> +           xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
>> +               flags = tun->flags | TUN_VNET_TNL_MASK;
>> +       else
>> +               flags = tun->flags & ~TUN_VNET_TNL_MASK;
> 
> I'm not sure I get the point that we need dynamics of
> TUN_VNET_TNL_MASK here. We know if tunnel gso and its csum or enabled
> or not,

How does tun know about VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or
VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM?

The user-space does not tell the tun device about any of the host
offload features. Plain/baremetal GSO information are always available
in the basic virtio net header, so there is no size check, but the
overall behavior is similar - tun assumes the features have been
negotiated if the relevant bits are present in the header.

Here before checking the relevant bit we ensures we have enough vitio
net hdr data - that makes the follow-up test simpler.

> and we know the vnet_hdr_sz here, we can simply drop the
> packet with less header.

That looks prone migration or connectivity issue, and different from the
current general behavior of always accepting any well formed packet even
if shorter than what is actually negotiated (i.e. tun accepts packets
with just virtio_net_hdr header even when V1 has been negotiated).

/P


