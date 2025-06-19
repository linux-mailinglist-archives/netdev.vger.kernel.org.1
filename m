Return-Path: <netdev+bounces-199520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF5AAE094A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8643BD1A4
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A421CC79;
	Thu, 19 Jun 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4rE7gjR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158082135D1
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344786; cv=none; b=IjYCPp0ixzQvVvoDKxApHeeZPUIfxMLQCF1bmy9rp/8Lo9QaainyTetkK0m/gL1WrFsbk/G00hEHe3nV7SYANyx2EstZQ5vgayRmm12xZuT0ghlEmw1YsdRhDkLW3AqdJQma1PJn7T3+2BQUF0/IQv3iDrSJ8/UIvqoyQqUzelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344786; c=relaxed/simple;
	bh=qOOQGEPMtUllPGvx1kY0LdvJiw0QFQF1kWktVuSQSuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjMVYcdae9cbo/PMtTPSFGuUkyptJzT1cA+axmiVy0Q8DAwH0rrBi8kaHmM5UqCVd+JXmqgAu7zYUc+PXIbHpX57wwz4wreP0uvUnKbLtmGVm1aquGhNBNRlAVJijCM9eDKNM4Wq31/Xb/D2afVr2OXwJUTuvBGXL41z5EMeUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4rE7gjR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750344783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bglq/ZSqoTowSTVZgvyAFjZJuM21WtYfXR3hJE+ZxTE=;
	b=I4rE7gjRYUQ8C1c79s1vUY1UjW4fDhkdnpwo5X6e6fivFjgsAICZMhJK/6q0iJE213jjrv
	Sau+tdHzdj5V7/uDkZ2bgJYFPbrOI+xE0nRKWUpX6Fce5fXsnV6vHftfo4/SyLF5F6UsWh
	Oqks1O8IwLpPFzLUFplSLd9FvxIJd7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-fBjn13RwOWS_TiXEmPbJqg-1; Thu, 19 Jun 2025 10:53:02 -0400
X-MC-Unique: fBjn13RwOWS_TiXEmPbJqg-1
X-Mimecast-MFC-AGG-ID: fBjn13RwOWS_TiXEmPbJqg_1750344781
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so464078f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344780; x=1750949580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bglq/ZSqoTowSTVZgvyAFjZJuM21WtYfXR3hJE+ZxTE=;
        b=cT0rO79aghi8f7y/wdekqG1pVPqWZfzu7GtNYhBWErlgIK1VBbaXeP0W2qk9ekTh1o
         4OhuUCBJJZyNED61tKj0IAQPJrbWjtcu7brDkzfUjnv1l0OiYTUqfERnZASgQQZSg47X
         aqAypfNq60yyRdTGaXPthCgFbFFOtpVjDUYkzMlT9ZR330TEFMVq4wY+G9D1OyIjlpIj
         Tt6uHpstPYWi4gvNAVSPkn4j+12K95OdPb9/0rrmZjvaR+ihAAPjG6ti8k86G46VFSG+
         5xDv6WT+X31oO1wp39mjKNrjBqwqRAw+m/bQ1P718olZsNXr2yUXzTgeyS/KwMOfpV8i
         GyCg==
X-Forwarded-Encrypted: i=1; AJvYcCV4+xiPZLjaSja1kE4/JgLdWi3etKhcxUfjL5ZBX3Nhx3vnFOvGsFdYWzkzLrwUS1ENzvHA/bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5J7oWmJzuvrhdJlactieQSjnCMwwNbOZRipXDjhYKDwkiQQh7
	rw7fXm0WYy8wVXXuBwSmCq4ElAlVi1aRmtQNmoG3/zjg5QWQto3ezd1FZ6WK2ejNv+pwJa1/rBX
	5pmPu2SvwoCHmQBQByjWhHGto0Xzn+DX8wczidbodc64smZNrTEfk0VTXoQ==
X-Gm-Gg: ASbGncuRPmWV8BJ7Bas06UIea8ossVpMHk+7XbZArRoX0IJQtN5a2qfF4/K+3ao0P3g
	VnpoHWZ6lA8xL59COFCtXDmvFq2sGvlbRO4/bXq2fv2mANINAOP3QwTNlm8/2+ftUbtscHRw0sY
	HVqjaYD9DFGKlUNN7iv1RqjDwlS0LFTTwpxUmhJCbGzYPoO4N5diZjjqjPlrxv+vpo2RWr9xqXi
	qwPxk4W6X/fQxi0X3yVmxicY+5hDGmeP0qMcgLozCj9z4lBBUcfK9eeAMiez9bcExEgVAn9wg2R
	selL84PrWiwbFWah6yBAgBTrPk6c3A==
X-Received: by 2002:a05:6000:178a:b0:3a5:2cb5:63fa with SMTP id ffacd0b85a97d-3a57236654amr19572355f8f.2.1750344780573;
        Thu, 19 Jun 2025 07:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpjSu6CKN7YvDKY5xyr9O3K85SlPbejO/Vb8QIhLdkNfxAZ90NpxfSZm5bXwYxa87WYFvOxg==
X-Received: by 2002:a05:6000:178a:b0:3a5:2cb5:63fa with SMTP id ffacd0b85a97d-3a57236654amr19572331f8f.2.1750344780151;
        Thu, 19 Jun 2025 07:53:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08c99sm19943176f8f.63.2025.06.19.07.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:52:59 -0700 (PDT)
Message-ID: <4e0a0a37-9164-465a-b18b-7d97c88d444e@redhat.com>
Date: Thu, 19 Jun 2025 16:52:58 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6505a764-a3d2-4c98-b2b3-acc2bb7b1aae@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 4:42 PM, Akihiko Odaki wrote:
> On 2025/06/18 1:12, Paolo Abeni wrote:
>> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>   	if (tun->flags & IFF_VNET_HDR) {
>>   		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>   
>> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
>> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
>> +			features = NETIF_F_GSO_UDP_TUNNEL |
>> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;
> 
> I think you should use tun->set_features instead of tun->vnet_hdr_sz to 
> tell if these features are enabled.

This is the guest -> host direction. tun->set_features refers to the
opposite one. The problem is that tun is not aware of the features
negotiated in the guest -> host direction.

The current status (for baremetal/plain offload) is allowing any known
feature the other side send - if the virtio header is consistent.
This code follows a similar schema.

Note that using 'tun->set_features' instead of 'vnet_hdr_sz' the tun
driver will drop all the (legit) GSO over UDP packet sent by the guest
when the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO has been negotiated and
VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO has not.

/P


