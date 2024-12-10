Return-Path: <netdev+bounces-150567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00B9EAAC1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD70E188A652
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4F2309A1;
	Tue, 10 Dec 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipRpvBeo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F200230982
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819570; cv=none; b=dA80Pq4isgx4Cy/SKBhnat0d4nPmlJbLjQ8o6kbCV2xelVQsXo0EiI5Ijk9Ovj87WLdsLseB3Yteq1mar4+BDfzZc2XdQfaXmFLcQeGkg5/ler7Vhjj2GINonR/72vxUzF7ygBNCcQnRMiE0zcc1qpKjgBgDkeNHYB5zmKlIs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819570; c=relaxed/simple;
	bh=C95Yp+TtH7hbaEHcFYsumRyKem0CNEcNHNuqx20MW78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z28DkcjX6g2vTrsYj5glT9rxgCe0eVGd3FCYYAiQ2zHhsQjetefgZRwh/TYieV1jNtkgUjIj4ch9Hcz8vgI3z97dyjw1y01/lqnmeWyIZSc3CH8DvBsfXYMWhHlf7DgwaTuZYo+g/m4YnFqUDvIzCYrn/V0eCUycvhb/IziHtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipRpvBeo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733819568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/P6lJeDrLZb+NYbzC1Fl4Z0gargyMkctdIvfmI6zLs=;
	b=ipRpvBeoCWUXl8nIEqdscdR4x9jkyj7182FXKXDqcUN5vGZyw7mNMmOUht61bxQxmoo27Y
	apJjbZP4w4vf1Qsp7HJf3GbQj6OuYjXsVkrN8nrDljsq6vNf7IQgWcbzaKjIrCtbsXEopl
	Lq7Yd2GNQltH7cj8OhkqEY9syPl22z4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-C0Lf8bDuPwKb3NddnTAaew-1; Tue, 10 Dec 2024 03:32:46 -0500
X-MC-Unique: C0Lf8bDuPwKb3NddnTAaew-1
X-Mimecast-MFC-AGG-ID: C0Lf8bDuPwKb3NddnTAaew
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4667e12c945so79226201cf.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733819566; x=1734424366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/P6lJeDrLZb+NYbzC1Fl4Z0gargyMkctdIvfmI6zLs=;
        b=dF3XJlSVA2uhZ8icq2HYQwVgy2BLZHNJgljuNwa5WeyyF+wABkBnQ1nw0X8WmFvDiB
         bjTC0A+THIDjL7xosV1mzOXYwmLj4pjI7XetZdOVja+Yi3RjrpLIPolgeh+Ux2Uj8M7K
         6QG9TefnAfqy/F8KIfppkrVKp59npl9MYELkmvN4gnr6AKKB2/76oeXY9CZpvnzWU07P
         MnbDyfZ5U0QBHHe5hMgLlgZ3OPEbuI+YZ+o5asaPrL/Q0gIJcHtgF39Y6WUEBt613llD
         KcH/4wmWehWJL6ugv+80hrsjHHGNW87iGBKfCMn4hMbxd5WkpwWIe3PWhBsb9/knlCp2
         jQ7Q==
X-Gm-Message-State: AOJu0YzhIc8bZon8gFifVJ5tdM3dUFTTJBc1n2mrrvWZ3A1L4jj49bpg
	tN+UAXKg3vux8Ohwc8XB30wzsxv45vjDqVw1vSFw2tsFZSZ397yFQ/zsm50yNytm0X4JmTI36tD
	vQn04QUx8m86Rp6oY290X1TsP5Ef634veMwBx/l+p5q+dVS8RExzN0g==
X-Gm-Gg: ASbGncuX3APpoXOUquyQxFpFFV80Fwpj4SNkAt56Fw3sM7VrMeeN3OyuHFHPXNZjvaH
	du5Gin7QXYISGUdRsiSXeCYdS0GcwZ088N1s04I98/XxESaeZxWiOQcuNlotFNtgFm+ku8drG+S
	/kHi/tYV77zZ/pHoDK73U59eSISi88gkaqoyjQV6C2z1BMo164DxV6VpOnSuqEPAZyOYaemi6Qf
	2I8bRxM663ElscRx6svd/NrwkTAax8uZC2wLJnGgRr9B2Z0ILxGHJCEUwm8x75WjTNWxMz+/4wn
	HKUissSLRNTspaKiUW6niSMhhg==
X-Received: by 2002:a05:6214:2507:b0:6d8:a822:2ee2 with SMTP id 6a1803df08f44-6d8e711808cmr320000226d6.16.1733819566454;
        Tue, 10 Dec 2024 00:32:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUT9a2JCpBxHLshOy1bi4Da9CvF3PHqUbdLxCpftdB6kAzNsOS8f7tP8acPEVY4uW+O1teyg==
X-Received: by 2002:a05:6214:2507:b0:6d8:a822:2ee2 with SMTP id 6a1803df08f44-6d8e711808cmr319999896d6.16.1733819566050;
        Tue, 10 Dec 2024 00:32:46 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da69591fsm58638106d6.31.2024.12.10.00.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 00:32:45 -0800 (PST)
Message-ID: <63b0f262-066a-4f7b-b55a-a7f0ed4aa7f4@redhat.com>
Date: Tue, 10 Dec 2024 09:32:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Philo Lu <lulie@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Willem de Bruijn
 <willemb@google.com>, Stefano Brivio <sbrivio@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
 <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
 <b46a7757-f311-4656-a114-68381d9856e3@redhat.com>
 <a4085013-daaf-4141-af56-cd438bf8b4c9@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a4085013-daaf-4141-af56-cd438bf8b4c9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/24 03:34, Philo Lu wrote:
> On 2024/12/7 00:23, Paolo Abeni wrote:
>> On 12/6/24 17:01, Eric Dumazet wrote:
>>> BTW, it seems that udp_lib_rehash() does the udp_rehash4()
>>> only if the hash2 has changed.
>>
>> Oh, you are right, that requires a separate fix.
>>
>> @Philo: could you please have a look at that? basically you need to
>> check separately for hash2 and hash4 changes.
> 
> This is a good question. IIUC, the only affected case is when trying to 
> re-connect another remote address with the same local address 

AFAICS, there is also another case: when re-connection using a different
local addresses with the same l2 hash...

> (i.e., 
> hash2 unchanged). And this will be handled by udp_lib_hash4(). So in 
> udp_lib_rehash() I put rehash4() inside hash2 checking, which means a 
> passive rehash4 following rehash2.

... but even the latter case should be covered from the above.

> So I think it's more about the convention for rehash. We can choose the 
> better one.

IIRC a related question raised during code review for the udp L4 hash
patches. Perhaps refactoring the code slightly to let udp_rehash()
really doing the re-hashing and udp_hash really doing only the hashing
could be worth.

Cheers,

Paolo


