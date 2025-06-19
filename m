Return-Path: <netdev+bounces-199576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F57AE0BE2
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1132B4A3010
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EE28B504;
	Thu, 19 Jun 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2+jSAqW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D8220686
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354062; cv=none; b=sOh/i3fP5QWuFyrKtugs3nN/0AGisR71UocOXN+mMlo2KOAWUudyRJ7T2BnhBp1qgP9Wgqykb6Ppd/mFVSU85nDpTe66SrEcZ7BqTo+GyhJdMjS3nja4DeXLG79asKFMqU5B0IXGGEgtRUmUJq2Uk/d9go2WFac5VJh5/6QImUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354062; c=relaxed/simple;
	bh=BOZRmogrsVd4OGO88eQIjuuU1D83VyZVvt/ty3knLIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV71PVaFlMPulUjSV9hzPtPNQa6rk036HkxYLXXA1tJcroQD3hNHcgCiH2I5F0os/IiKpRs/X5lraLKe+P3KHtmVA1VCS3mAzDpPdwAARtwpDDU9ezNJxEfGlpspmwdNPRXI4zk/seHsYvv0IEU3oWXFJFXJGb7fcT2LS63xHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2+jSAqW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750354059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrcnD8lhVnWbos35Jfw/0uEpdf0dybiMWT91AZ5J9zA=;
	b=i2+jSAqWlg/ScOhfaHy55TsyCbRqd9V/KqDtja2ILxTUxJm9FCPPLC+YsJ53odqcRvNp1w
	bMl15D3Mx5B9RME9DmZoMG43BdBD6mPEgbGiaqLVTTgMFaGuMVU0Sryw0g7euNe+vvl/st
	dgOsPjlVyg0JzoOiwuCA/g4RBsn2mr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-7zKKFxT0Pdu8mm-Zw4kIEw-1; Thu, 19 Jun 2025 13:27:38 -0400
X-MC-Unique: 7zKKFxT0Pdu8mm-Zw4kIEw-1
X-Mimecast-MFC-AGG-ID: 7zKKFxT0Pdu8mm-Zw4kIEw_1750354057
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f8fd1856so538801f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750354057; x=1750958857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrcnD8lhVnWbos35Jfw/0uEpdf0dybiMWT91AZ5J9zA=;
        b=uSs0YCA/bbxRRoVfU25cGkgJ0zC0JV1xTCL7TegtVdidC/NTQyEIx2RGA4ew0ZkquH
         bD6LvNMzlP/6OVbWp+1cenLRyw26S1SWdnirOKpfn1e7jRwFEJE3MtUeIkBmorzehzS7
         7G2fChreY8jin/qLeY4660FtfO0T01N5MqiVYMzw+GgxMuBKbrOkIDHPzn+PGFivKMcB
         CibzCArvEAX9jWffGBWVkksGLfISS8Ivh2mCbCxVRXrp8RbjbZmZExGKkefRyD+1J1N8
         c4Ntd37r493h589fz+bpes/ukhvzBuakleTTD/aBYTM2YFndXQh0bZ87h5miKBYeCoug
         1bWw==
X-Forwarded-Encrypted: i=1; AJvYcCWb2WCRKL2eVduNykYotzpfcMy0UBu3TZP5uCW5Vpw2kBtywpujfawRGv5qprGmQcbrKxOzNGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiCffKiUxlNPSew9vnkSHSLIvMkfO2cS64aO3T16sJsRSFQx6
	RW+yUNEaaTKc5cfQ4ak1uyw1Q8j2FlLER2hbqVssbkM4ttCMaewSrvCFQpErkHXtkK7jDhyQmF3
	MhV9zTpN3R7IV0GcYl8kiOhJwThWtO3x4mZl9v2CjvPDYkwwhKGeG/a1ChQ==
X-Gm-Gg: ASbGnctLrLgOoRoCtNWSBURTEeDHLfLrwibVAiY76tTCP1ZmnlmkSUmkZTJWZYKyKbu
	TLnjITwDO+4TJtRWKtCoukTnYQUi0kgwi2wcRwiTfOFnRATZfadb17f6zzWVCBNMy3qXuOBLvV6
	nYF0zNGINx2mWSjOpd0J681kG5bPvCYgBNik+rRPpcP42WEZo2fSdvEzkZ9kCAYTzgZ0U237QW/
	OSPv2abH4RPSrCAYqponb1YjVPj6NLUc/QH+2aPUKRyXmqHzvw6ibwGHnG1KO+ZrC1L0eEO5RGt
	tKSgWsfkwTD5UDva+SgLfHPyYMIjjw==
X-Received: by 2002:a05:6000:290c:b0:3a4:f35b:d016 with SMTP id ffacd0b85a97d-3a572367993mr16760441f8f.11.1750354056764;
        Thu, 19 Jun 2025 10:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaQmVtkXm4bie/T0lbfaPJNgYEztdSO9uQQkombBw66IqTcuxkoD6NcNvP1riO720+JNRj4A==
X-Received: by 2002:a05:6000:290c:b0:3a4:f35b:d016 with SMTP id ffacd0b85a97d-3a572367993mr16760420f8f.11.1750354056310;
        Thu, 19 Jun 2025 10:27:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b1eb9bsm20263846f8f.69.2025.06.19.10.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 10:27:35 -0700 (PDT)
Message-ID: <74f6f0ea-6f2d-4520-b103-d4388a0916d6@redhat.com>
Date: Thu, 19 Jun 2025 19:27:34 +0200
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
 <6505a764-a3d2-4c98-b2b3-acc2bb7b1aae@daynix.com>
 <4e0a0a37-9164-465a-b18b-7d97c88d444e@redhat.com>
 <bc579418-646f-4ccc-bf9c-976b264c4da2@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bc579418-646f-4ccc-bf9c-976b264c4da2@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 5:46 PM, Akihiko Odaki wrote:
> On 2025/06/19 23:52, Paolo Abeni wrote:
>> On 6/19/25 4:42 PM, Akihiko Odaki wrote:
>>> On 2025/06/18 1:12, Paolo Abeni wrote:
>>>> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>>>    	if (tun->flags & IFF_VNET_HDR) {
>>>>    		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>>>    
>>>> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
>>>> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
>>>> +			features = NETIF_F_GSO_UDP_TUNNEL |
>>>> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;
>>>
>>> I think you should use tun->set_features instead of tun->vnet_hdr_sz to
>>> tell if these features are enabled.
>>
>> This is the guest -> host direction. tun->set_features refers to the
>> opposite one. The problem is that tun is not aware of the features
>> negotiated in the guest -> host direction.
>>
>> The current status (for baremetal/plain offload) is allowing any known
>> feature the other side send - if the virtio header is consistent.
>> This code follows a similar schema.
>>
>> Note that using 'tun->set_features' instead of 'vnet_hdr_sz' the tun
>> driver will drop all the (legit) GSO over UDP packet sent by the guest
>> when the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO has been negotiated and
>> VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO has not.
> 
> This explanation makes sense. In that case I suggest:
> - creating a new function named tun_vnet_hdr_tnl_get() and
> - passing vnet_hdr_sz to tun_vnet_hdr_tnl_to_skb()
> 
> tun_vnet.h contains the virtio-related logic for better code 
> organization and reuse with tap.c. tap.c can reuse the conditionals on 
> vnet_hdr_sz when tap.c gains the UDP tunneling support.

Instead of repeating the test twice (in both tun_vnet_hdr_tnl_to_skb()
and tun_vnet_hdr_tnl_to_skb(), what about creating a new helper:

tun_vnet_hdr_guest_features(unsigned int vnet_hdr_len)

encapsulating the above logic? That will make also easier to move to the
'correct' solution of having the tun/tap devices aware of the features
negotiated in the guest -> host direction.

/P


