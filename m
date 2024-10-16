Return-Path: <netdev+bounces-136065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA49A02E9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0481B1C244F4
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C8198856;
	Wed, 16 Oct 2024 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnU20OOP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8F18D634
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064738; cv=none; b=e08ngnFXRti3tyC9VcTtqILW9LEDwyfl/f01IsIaG1DamR+CIgfNvbY/ttgthTBPoETF2Xm7rRWZzkeAzJizliTLT+5RtaPqDvpqSrYjlIWWfGVtfHINbtJrg3xhppekaVSRgxM6DxO4Hgk1toFuuR/toqwZcGM6pl9DvcNnmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064738; c=relaxed/simple;
	bh=hvpn7Zq0g7b19gkei2vMe8mTUwIxVVWTIW3821uGK8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/qLuumzjvBDnp8XTS9/Nb59WeLAsFqBI76oXuaSLMtpeqy6UEdhGsnhvT/H0av8S1VewvJb5j3qSSVeE9cpmOl3bOm1v59pUlj3Q3QZgoPUbcjB0cDH1N7eawxs2m/4EYXzeGL9zFHyCWb0EsHHajSp3iP8xHVFEnxSbbvDQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnU20OOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729064736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZMNDygscP0ApBl6B4+OOT2D1feT61VkI6S/fm7lJGw=;
	b=MnU20OOPJFRnG82c3s1t1x1Srv8emy25akJGHUK4T7Ngl3Y7gebpH4OkoT28dzfZOLSGEn
	yygNh5xtKvAnCxSJ8M2ohTqw1k3Zk+cBihxhwaGWBehDDQ36S2RPGZ5FTtMNaIj828z+la
	zMRcY01gHhzUpz72e3hQRSocMoHg4Tg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ZBPiZjc3N_2_byiXPQfXuA-1; Wed, 16 Oct 2024 03:45:34 -0400
X-MC-Unique: ZBPiZjc3N_2_byiXPQfXuA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43117b2a901so53178795e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 00:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064733; x=1729669533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZMNDygscP0ApBl6B4+OOT2D1feT61VkI6S/fm7lJGw=;
        b=Xzs7jdnF4O86BctWI1FPmIWHM8+BudUVxdGv2zPg5ogzuXcNZl3zAcbEzZkW9q6R2C
         uag+1B1xNf9THIq4dto1ndbbrB+eUnVV6wGzfBiqMjDoc6PmOGQn4MqyyGrrhxxNGZkx
         0REKgR+86B/9QYyO36hRY/NpMKgpXmIrsf/+cHfnHzOuVXQcOwemSpsvixeERn6Pz+5u
         Lb+w+nhV612Xv+sQFV6vy8NgpZWj51NqMFdT43q1FmWaBkR48pE7y+FL/V5q2LB71nng
         RGJ2T9c1lpViFv/rZ6GWF/XC7m4+UNoRz/X/GxPw4SZ2ZcbftVpqlWoq4wP7St2FwUQx
         opmw==
X-Forwarded-Encrypted: i=1; AJvYcCUxc+zX2L0l3PBxxlWS5xkA/wWpG4Z+t4IkhGxWq+s0gH4oHaNKDJetH+HkpmSp6s8iK5Xtg0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/TOPXk7YPCNfidLqd2fIO4ontD0Z/IkQi+yaCevb+m0Tx8/8
	GyBzVrsCUiOD+oX71N40xjcmfhlfSO9720L4hkD9GeJk7TT/hn7m/n7htYDiFEyWfqFKeo8gP5U
	BI3mRgq0MdH6Fa4Ya0YjmuIWbI17Pp8NOM646fjSv9FW+y96xU5omOQ==
X-Received: by 2002:a05:600c:5023:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-431542d2d76mr4845495e9.22.1729064732932;
        Wed, 16 Oct 2024 00:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Grh0K1mhOgL5THYcEeem6rs7BDOGHqVGRx69/tRSiiZTYxkPx1ztq3HHC3X/R3P+Tvm3mw==
X-Received: by 2002:a05:600c:5023:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-431542d2d76mr4845205e9.22.1729064732519;
        Wed, 16 Oct 2024 00:45:32 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4315067a6f7sm13323655e9.0.2024.10.16.00.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:45:31 -0700 (PDT)
Message-ID: <7dde23ec-e813-4495-a0ca-6ed0f1276aa6@redhat.com>
Date: Wed, 16 Oct 2024 09:45:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/3] net/udp: Add 4-tuple hash list basis
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-3-lulie@linux.alibaba.com>
 <9d611cbc-3728-463d-ba8a-5732e28b8cf4@redhat.com>
 <2888bb8f-1ee4-4342-968f-82573d583709@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2888bb8f-1ee4-4342-968f-82573d583709@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 08:30, Philo Lu wrote:
> On 2024/10/14 18:07, Paolo Abeni wrote:
>> It would be great if you could please share some benchmark showing the
>> raw max receive PPS performances for unconnected sockets, with and
>> without this series applied, to ensure this does not cause any real
>> regression for such workloads.
>>
> 
> Tested using sockperf tp with default msgsize (14B), 3 times for w/ and
> w/o the patch set, and results show no obvious difference:
> 
> [msg/sec]  test1    test2    test3    mean
> w/o patch  514,664  519,040  527,115  520.3k
> w/  patch  516,863  526,337  527,195  523.5k (+0.6%)
> 
> Thank you for review, Paolo.

Are the value in packet per seconds, or bytes per seconds? Are you doing 
a loopback test or over the wire? The most important question is: is the 
receiver side keeping (at least) 1 CPU fully busy? Otherwise the test is 
not very relevant.

It looks like you have some setup issue, or you are using a relatively 
low end H/W: the expected packet rate for reasonable server H/W is well 
above 1M (possibly much more than that, but I can't put my hands on 
recent H/W, so I can't provide a more accurate figure).

A single socket, user-space, UDP sender is usually unable to reach such 
tput without USO, and even with USO you likely need to do an 
over-the-wire test to really be able to keep the receiver fully busy. 
AFAICS sockperf does not support USO for the sender.

You could use the udpgso_bench_tx/udpgso_bench_rx pair from the net 
selftests directory instead.

Or you could use pktgen as traffic generator.

Thanks,

Paolo


