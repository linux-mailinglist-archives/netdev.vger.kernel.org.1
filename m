Return-Path: <netdev+bounces-193063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0288EAC2496
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1105AA24549
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0C481B1;
	Fri, 23 May 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvSzQtlM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DA2DCC04
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008838; cv=none; b=Qetr8v3E1pH8/bQpatbkDe/+hwfx4MlPGw1UqaLFzEY+QgCZYS7GroHwo1MU0lHRd+4WRWgJGGLxUBlCVYRft8xW9+/C3qhGFF3VXOLvDiYEWTOB2tMTAc8AQBrQV2XnrAMUfDwIM//lEwoDhbavS7hxKRQ5SxrTZcqiGOJYFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008838; c=relaxed/simple;
	bh=MhPr9xR9H725Ak+yU7srWo/Hm51G0586MrjNNZJyKKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exRhHQLTRKmEOmJ2nmhoWGGV6Qvha7IFW63/N4xdS/Q/JiSi4c5wUT+61xI37yRQIm+XEXnzfD9GUud7xxa6gaEYs1GihnHYlVaAnn5jMcXBSaSqPom6Zl4afrdUJhAiqSQNcmMi8Up5srOysuSSBbHSxk/WHLX1yxU59G0WNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvSzQtlM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748008835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcD7juidVWOBiD0EuxyWNh/kEMjw23rL2sWiBeVphdk=;
	b=NvSzQtlM7OACwyYxaBApre0SlclQVkh+opHiFE/f79R/fbyN/0n5c7c0/IgYDOW1TxaPd2
	V/UxW6vSLWzHiWsY43DdbTPqhICMw7qpP72BNZ3aCaNkF9L2z2BqTKSYNhsvuvapSAtVBg
	rcNz4RxuChrGET8E09aag2MHeT7QTiQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-bzhFC6G5PtipNNFEUfU9Lg-1; Fri, 23 May 2025 10:00:34 -0400
X-MC-Unique: bzhFC6G5PtipNNFEUfU9Lg-1
X-Mimecast-MFC-AGG-ID: bzhFC6G5PtipNNFEUfU9Lg_1748008833
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-44b1f5b8e9dso5464095e9.2
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748008833; x=1748613633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcD7juidVWOBiD0EuxyWNh/kEMjw23rL2sWiBeVphdk=;
        b=J5RP0VTq2bvUKsXlAVzcesCCgQDorc4A2ZkKmv4oz9Y9P+F6mmMWhm2ULAxGRcUNHe
         6yCXOKegIldQfNIvaQN0UJerGEfp1qunxHp/VQbZXkkt6pfPVw/ghNPnejt7EnIC2wlH
         zxTLv+Hmn2sfB9C5PMeROfolUnPzIiHW4NqLl5Axx60DCQvamq3RVh/lCkwj4qbXYfc8
         mDUwCzN8M7g/bbyKbj3MniWP6VVcP9PcewUOsdu7Lcx3anXEr1SoTglg7tEJt7dRDw8z
         Nwebycqdf+WSpDHiEghy/J+cQKz3vbdrCWgb6MYRa1Z4xf7Oe0y5imUfzEw8xjlLKUPh
         6FKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi6rYWjaupYrPdGiFV9g2ltpZ74tVc9aKVZwh5DzThpqmEbZhYkY8/PRUNA58x1Q7/Xkxy6nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyden5xAlMTRbeXG/ZO9g84y4K2tUorgo2J8TZ4crMCgj195GZ1
	Gp+HYRAr4vKm7U3rciJNefZs2ZwSDMhA+VYe1wcMRvrmyMAFKf+twfJ3K/KxYgHbDthP/qxPpdc
	XnbXY6RLCCzVfl+483ZJ0tvBNrZ4cVmWPOHT3htW5n/wP455T6Ud8aMvQzw==
X-Gm-Gg: ASbGnctCvBukKJu4F4jd20xoJROlEs1zvtBY3YacqUcTiYg1+NE9o4891SbGeWlN18k
	WaTiQe5PE55oHFjWvfvEG4MG9/qR1N0yfh3oY53C0hDF9ekPjOy15LFIK7kiEdi7gXJg3JJecRJ
	h4kd2MSutvZUwc5804fC9kcNmViu89AKNviRf0XZy9WvtjDo8HqLdtDtOK1BQ62Ej7EuAU42uB5
	f6P/f06vwSI4JE7QKg/yJ8C8+FXkJf1bHIgDZC7X1ztyatxOC165sEMvIdub1A5HIRFBlu9P602
	heOo8sN2vVXczm2ITQ8=
X-Received: by 2002:a05:600c:1e1c:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-442fefef17emr267543035e9.9.1748008832815;
        Fri, 23 May 2025 07:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBOHR5APVWsXckrhaOg6b3tPiYFSz6Qu956CxEh9WKjcvs/uC4z6onjP4OVJ7XmXobSsw8tw==
X-Received: by 2002:a05:600c:1e1c:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-442fefef17emr267542615e9.9.1748008832355;
        Fri, 23 May 2025 07:00:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7baaf2asm142957145e9.34.2025.05.23.07.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 07:00:31 -0700 (PDT)
Message-ID: <ca169183-55af-43d2-b78d-db82c33c6643@redhat.com>
Date: Fri, 23 May 2025 16:00:30 +0200
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
 <2ccf883f-17f0-4eda-a851-f640fd2b6e14@redhat.com>
 <68307b4f745df_180c7829493@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <68307b4f745df_180c7829493@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 3:42 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> On 5/23/25 12:29 AM, Willem de Bruijn wrote:
>>> Paolo Abeni wrote:
>>>> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED	46
>>>> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED	47
>>>
>>> I don't quite follow this. These are not real virtio bits?
>>
>> This comes directly from the recent follow-up on the virtio
>> specification. While the features space has been extended to 128 bit,
>> the 'guest offload' space is still 64bit. The 'guest offload' are
>> used/defined by the specification for the
>> VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET command, which allows the guest do
>> dynamically enable/disable H/W GRO at runtime.
>>
>> Up to ~now each offload bit corresponded to the feature bit with the
>> same value and vice versa.
>>
>> Due to the limited 'guest offload' space, relevant features in the high
>> 64 bits are 'mapped' to free bits in the lower range. That is simpler
>> than defining a new command (and associated features) to exchange an
>> extended guest offloads set.
>>
>> It's also not a problem from a 'guest offload' space exhaustion PoV
>> because there are a lot of features in the lower 64 bits range that are
>> _not_ guest offloads and could be reused for mapping - among them the
>> 'reserved features' that started this somewhat problematic features
>> space expansion.
> 
> That's a great explanation thanks. Can you add it either in the commit
> message or as a comment at these definitions?

Sure, I'll add it to the commit message.

Thanks,

Paolo



