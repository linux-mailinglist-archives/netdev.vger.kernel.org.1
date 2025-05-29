Return-Path: <netdev+bounces-194246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7ACAC804E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7519A4A24FC
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC181D63E1;
	Thu, 29 May 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkXmtQZx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87503193062
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532655; cv=none; b=LIj9r4Iw8OY/SAgMs68/JSGBdLbMfMWbFjl3bHMOHXlLutGLJmfAxvGVf90ABnKXgusDtL9KcQz+E/gNX57+6/bJ36KZHjzjHcHHUSzfjkJSTh83Ds9oLn7oFjj4CFD54QM5JsMBAaEiw0v35V17cE/oUqJ0+BRmyU4lXmf4FsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532655; c=relaxed/simple;
	bh=yXmp9K+013p9LLuzzuH3yxFdzNG5YsJQez5mslbvnco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2v6Jddbum4UJ67uUdj4cZ3mK22fwM47/W9lkD7mM4qgpW8iDv7+M22lYNsLNN7w2DkwGfTKnVwPTxyfy38vO3lmgGhLbUs6FLh9T/CEyedwGNrlEiMWCia2A6got0slelupapCJLHZF3yKsfxIkLIRT/iKbUO9YXaC12yoTzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkXmtQZx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748532651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90X/e10Xiz+GjbdOMX8hvB8ApZWLNBhEVzTpn7CBFHU=;
	b=TkXmtQZxf9tMlOUmnGbSib5jsJl8PCDPUPu4nzdL7Geqv6i/2ZBshiW7aIDkObS78RllI3
	hwvcs6dC3PrBgj4K6oS9mrqPujrAYoIf41AVP681l0XzmKmoNKkJdOXO3hIv0UXTwN0mRx
	yrhPEQ8y6Ifq+z/gXihIVFCdI9/qD7A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-LjzTwwHkP7G5VxfTa38pDQ-1; Thu, 29 May 2025 11:30:48 -0400
X-MC-Unique: LjzTwwHkP7G5VxfTa38pDQ-1
X-Mimecast-MFC-AGG-ID: LjzTwwHkP7G5VxfTa38pDQ_1748532647
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so632593f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 08:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748532647; x=1749137447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90X/e10Xiz+GjbdOMX8hvB8ApZWLNBhEVzTpn7CBFHU=;
        b=TKACAD++hgbkBIeCTdiDouLwTzDSLOMp4y6o0FQ4Sp+gRpc6a3qI+ucb/o+/kzODcW
         p2zYFVORI2UkQlaaAYr1VYq5jtZfeZKO2Qk/7s8ldJQfml4KAK32OHhgIEhXmWHoZFTK
         HPYp8l/oDJ5XCPQqKfgHjhx8b+Ayp0PNnRIVabvou4RXSTB57HVjXVsfFX/bGaH4QX0f
         qcBIw1Q45EBRhx+wa3lEl+LRY6tn2rK4yrjiJVuc0/hhY77gw3WO0UPAF6V3qZZHDJC7
         Ze9AcUrok9JhFVytpByuEEvqozBn55OfTKQIvT0Ri8PuSL5unSgcihEWK1cROzB1R/w1
         ct9A==
X-Gm-Message-State: AOJu0YyXF3InP633PmWgR/9OgEtfZfZNtECx9a2d5EGRu7Yx24fktThh
	q8BI+jSUjsOvP+qYa0PbF5yweD1bscQrTrypZfmp3PTdmDjc+Nd1q5s1MlZtVP2aKoyK7oJmqxJ
	5YRgbDQuQ4buFZCHLIPBf9Jci64IwekOi8jWwnp3aEA+N0rp/vF8dt083Uw==
X-Gm-Gg: ASbGncv3JxliMQ7oiJifJw7iMyaR4dVl1rBjUeTIQy6uTjeAEdg030vaoic4uNcmyfm
	u4p0g6UIOnOurzY1nxN5JvuiwXmiuVt+4O192/ROgs667x6fpAFjhZjpDxdWK5+AgvebFs0NOaS
	Z1gNfjKR5au08s5dNjoWk99gffbuV+R2TUUmoqHz4OgiFwvMcN2mVfqY1vu6N768JcJQSkG2rho
	WUVRoz4Kn1Tzp+aBVEkc7XAPCTXmnr79zH82MjHYQHWVvfXIIjnjvnYW00O3DWxK+kBLz6KIYbE
	nYZzXfWuGYaNuEfTy+A=
X-Received: by 2002:a05:6000:1a8e:b0:3a4:e706:530c with SMTP id ffacd0b85a97d-3a4e70654d3mr7159470f8f.48.1748532646755;
        Thu, 29 May 2025 08:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR1Kldf3lsgro3dy9ynfDXT3CbuGyXEkBFU7Pb1dYF+M1q5LT58zP4UnWxibx+2c7UVLCd+A==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:e706:530c with SMTP id ffacd0b85a97d-3a4e70654d3mr7159438f8f.48.1748532646320;
        Thu, 29 May 2025 08:30:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10::f39? ([2a0d:3341:cce5:2e10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c43asm2275112f8f.21.2025.05.29.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 08:30:45 -0700 (PDT)
Message-ID: <1f852603-5585-4c3d-9689-b89daba8fee1@redhat.com>
Date: Thu, 29 May 2025 17:30:43 +0200
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
>> @@ -242,4 +249,158 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>>         return 0;
>>  }
>>
>> +static inline unsigned int virtio_l3min(bool is_ipv6)
>> +{
>> +       return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>> +}
>> +
>> +static inline int virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>> +                                           const struct virtio_net_hdr *hdr,
>> +                                           unsigned int tnl_hdr_offset,
>> +                                           bool tnl_csum_negotiated,
>> +                                           bool little_endian)
> 
> Considering tunnel gso requires VERSION_1, I think there's no chance
> for little_endian to be false here.

If tnl_hdr_offset == 0, tunnel gso has not been negotiated, and
little_endian could be false. I can assume little_endian is true in the
!!tnl_hdr_offset branch.

/P


