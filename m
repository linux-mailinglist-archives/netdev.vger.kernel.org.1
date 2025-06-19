Return-Path: <netdev+bounces-199578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D40AE0C08
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED831BC5E5C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E965528CF64;
	Thu, 19 Jun 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoPClVai"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871A2AF1C
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354923; cv=none; b=DgDVAEt0OpD+o+wOx9Sbp+R7+BEauBN0Q0N7PJJmBdp/ojBFee+Wc80lPxWBiwVbUq6uCiPgHDAw5UCI2u5AR29AanQcWoMnrqGt6HGWj7eOrYaRL6Bzh4To4J0YN/JZiG0U4QsgnJzCNYl0m7g5WH0dG2it2TxluVuynveuZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354923; c=relaxed/simple;
	bh=HoNHMlV5gs6ecsDXP820IMYKwSpwfRl0dDS1MLE+cpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=px9F3IBAsH2IkphzcJuEtQPN9mcKaXkpcKmDEYgMYuNM0PrFOVTJ88syY4cSWt5JcAa6zhzwWOK8GoMSLNq3wGiEvS4Y7Mq0Y8/pm7lKy7U3NN0bUXbClLwMVoV41wOaXBXTj3u46e0m3iIJUf2Xg8wL+w0KthKG+1SusoWLQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoPClVai; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750354920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OM8cmiyDXYsnLBv7gf1kXeS6mK5nAKw4busXyfTSMyo=;
	b=BoPClVaiE2QsAw2puBYogbQvbnjZcwFka7pGrdsmc0MzhQx0j+VyqzqdlM4ERF+sVvnY15
	jvIGwCGbEoKpebTu/SgjOM5491seW+kLMXUJPGnqBBjEEwkZ8Nlsya41rwtBWEAE3iyFpb
	JoXcbcaXBBv/JoN7bx440RnhxVd2t7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636--n0tkJ-JNgeZm26H1LDEdQ-1; Thu, 19 Jun 2025 13:41:59 -0400
X-MC-Unique: -n0tkJ-JNgeZm26H1LDEdQ-1
X-Mimecast-MFC-AGG-ID: -n0tkJ-JNgeZm26H1LDEdQ_1750354918
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4530ec2c87cso5343115e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750354918; x=1750959718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OM8cmiyDXYsnLBv7gf1kXeS6mK5nAKw4busXyfTSMyo=;
        b=ExfPm/Jw8zPVTSU77r5qToLeBKvRtY4hWKy1HWQrHOWk7ubF7wi6+je3JZwnh64Ht/
         PBwIiViW3/9xYvmonWvnCLU/GHvEhcaZBS4HU+74WAl/08w6DcNtvu1MwHZwKouhgRHz
         SRJmX4ZQGBpHAyRMuLmxbL6tQGLhcMUYXFaY4toZLASmbxIPLlPjORHur/cgo0SV5Dsx
         hiDk1PCI5N2oO+Xz7mQneVQSjy1IJ+U903Jyw/BK0i22IrkmOBVy+sK2A40zmQm6deFM
         ssPJrqKGuTN9nPcGPy0/3Jsui6I3O1ZUfy/YwwWlNo6IMnJv0eXHylIBm3VntG/w0lN+
         KHDw==
X-Forwarded-Encrypted: i=1; AJvYcCWyzhATFakvmkXoTc5iFrM+ya8XPVh78LA3BbLEEtJmR7UI0ru2LUgzesphkM+v85ZV4t2UfAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPsP5GWPENA11Y3gY6OBHVp+GD2jNzh0n9HyRhbenqtrfXCNz
	kFb4hw5nQsuLoVLpjk/vuD8A1W0h1N3stKJ9xL4JMrE754Q6+u5lRcJN0ubRXIouC3vRPEiLM0p
	OTWkWUvvbHgrMTLyoTbg6ojpTYIkXilMNGIjtNhUqqRozF54/qJOI7bAa+w==
X-Gm-Gg: ASbGncv9WuDnGkfVhv4CI7JNyWRG7Wg1hdDjH3fkf2P48QKbyzE2VqaHHS/qd/qouPx
	LoADd37YrNjb2CIsphz1f3WR1y6SRJPpMLz3BB78sngACFQi6L5DV6TCHehtw0Y0zXCTC9kPWaT
	OWUEEYofvP6LkJZ0C/fVT7reZ/cedav8aQPNQFLuIR4sXdq8iq2WDFHuO9wTQCaNUzgGwa+tLzG
	/OagfePR4Zfe76wqwbfuyH2nyLM4WrQX26N7D55MpoEqCz3wntyWTexf3oXUsT9i7lwO6TnIbjl
	23Yrpf7dnQXjSxPNBsZHQQ0pb08ssQ==
X-Received: by 2002:a05:600c:37c9:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-453513f2aa4mr125703655e9.6.1750354917890;
        Thu, 19 Jun 2025 10:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK85TAxo4jY4qAYOjEn/Uuvo/S7wUeq9KOofvTVRbYn9a3UiRCGLhInih9wBmLxl74spAHaA==
X-Received: by 2002:a05:600c:37c9:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-453513f2aa4mr125703445e9.6.1750354917457;
        Thu, 19 Jun 2025 10:41:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19b30sm16613f8f.37.2025.06.19.10.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 10:41:56 -0700 (PDT)
Message-ID: <0aa1055e-3e52-4275-a074-e6f27115a748@redhat.com>
Date: Thu, 19 Jun 2025 19:41:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Akihiko Odaki <akihiko.odaki@daynix.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <add3a48e-f16a-4e32-91d4-fc34b1ff3ce6@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <add3a48e-f16a-4e32-91d4-fc34b1ff3ce6@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 6:02 PM, Akihiko Odaki wrote:
> On 2025/06/18 1:12, Paolo Abeni wrote:
>> @@ -2426,7 +2453,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>>   	if (metasize > 0)
>>   		skb_metadata_set(skb, metasize);
>>   
>> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
>> +	/*
>> +	 * Assume tunnel offloads are enabled if the received hdr is large
>> +	 * enough.
>> +	 */
>> +	if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
>> +	    xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
>> +		features = NETIF_F_GSO_UDP_TUNNEL |
>> +			   NETIF_F_GSO_UDP_TUNNEL_CSUM;
> 
> xdp->data - xdp->data_hard_start may not represent the header size.
> 
> struct tun_xdp_hdr is filled in vhost_net_build_xdp() in 
> drivers/vhost/net.c. This function sets the two fields with 
> xdp_prepare_buff(), but the arguments passed to xdp_prepare_buff() does 
> not seem to represent the exact size of the header.

Indeed the xdp->data - xdp->data_hard_start range additionally contains
some padding and eventually the xdp specific headroom. The problem is
that both info are vhost_net specific and tun can't (or at least shoul)
not be aware of them.

The only IMHO feasible refinement could be using xdp->data_meta instead
of xdp->data when available. Alternatively I could drop entirely the test.

/P


