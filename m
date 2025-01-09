Return-Path: <netdev+bounces-156733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A1A07B73
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5A41889166
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5621CA09;
	Thu,  9 Jan 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH++lgQP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017FD21C18E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435430; cv=none; b=DsKz0qPaMCBfxGuPLfYYlsiqVT8iqiDpaI4nOPYtM0/kk3zk+h+/ehE0hCIEiBg40hUuXtSmbgtxeWMQcerLGK8l+MYQDa2aeHDC60qh9xDZ8tnYZ+RYqVtQNzJklji5O18WumHZze9mN44e6/WpCu60ktg4pVUqMti6slH9ojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435430; c=relaxed/simple;
	bh=vsP0c7ZaqWOi3+/Hz/zeA+1FkoPMpZBvfDko8pxv4wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvOcv4qg/VnyCjqi2puWfpljKPF8MTHGWeTAOT71SOs6nzqU5C6YjNMCzIKcv35jowNoYx4NyHD/mzCfRmQKerbpI3fitDYDwmpteJg09QRNOqg15o7yVfysoHRtwRPDU+9LJgvRNAoU/L5hUUQwHWMCn6lZmv/x9adNcmmHPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gH++lgQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736435426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEX+RYiQOpyVgVwIOsW4QRUi5ZMAzd/B2xICiNLEvMU=;
	b=gH++lgQPss3MOnWW8SobsgCP7BIITRHeMalOqz98MCArbevCj1UVlD25d3XNY9BSOi0TFK
	A2s4rv7Ju8rrDus+tASDuU7dF3BaZRwVL587DM+C2a+W1+JwbN8VUGguxisC61LI1rxFjn
	QnrIzIYIzeDZ+4BSvJMusx7NpYNtBnI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-DLlfJ-R3PyCtSOLOg99uiw-1; Thu, 09 Jan 2025 10:10:25 -0500
X-MC-Unique: DLlfJ-R3PyCtSOLOg99uiw-1
X-Mimecast-MFC-AGG-ID: DLlfJ-R3PyCtSOLOg99uiw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38629a685fdso373949f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 07:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435424; x=1737040224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEX+RYiQOpyVgVwIOsW4QRUi5ZMAzd/B2xICiNLEvMU=;
        b=be4PQ0jNjXQexZdce+93746/fbBLV9q+3pPFz9pSKjtmZcuvZRC1kJgOM7a5HBOjGd
         S/Jf2KElrr1pKQ0KvHV24oAWxKV890nl9SMv5V4trCoivIIo4A6qbIUw6Tqa/kPlIhga
         TIwssC0QAGsvtEC+URqlc2tHRknrTd1Ai17Yua2ieAFS7QDsKLeRHvmIefE9lKq9Twu0
         Q+HKE1Na8Ls2BLbt3nRY714USUTApOwjIqeu+Q/ol82paXFUpoA8a8448rSN939r7pUW
         WMKLrLpzWGVe4hLQyXLpRChqr3E+cx6tLUTDNkiTiNxcPIATbkQaWnz3q3cxvifje6Bk
         Eo1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGi/JSvM/pxHsI4fjHMGPPLwBGNjTpRMHmknqUngMSSXUkhmmU3w6zIaEWzlTBcbGM5w4L628=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkjCo25d1OwPDg4LK1VGU2fFRIlfpw5Bjb9lVyREIF0xqzidm
	k7qMXC6xzoEfben2Zj5gBRKd5TxHXY7f8LGYEmpw1y3dhrHBxQgu+XpiVliDqlgctnjuYOUQ1pp
	atu8sEdD4sSL2o6iFSf4KIbVOBphWUiyPJYgPwXtkv0AdRYvwq6P0Iw==
X-Gm-Gg: ASbGncsCD6s8bAj3cnPS3E0mVP5WQk3WsJmvDoC/XO1o9Sv2v+RTbUXwUl1qHR6RO+9
	BnX/MJ8xlefg+K7ngiH2tgL1jEpE7HI9ghvcZJmO7WQi1W7fKSKeraPDxcNVhN+CBlJbXma1Xkx
	4s7b1ODFn1sEdO5aohQ1svLxFWVuSqi6Wp/55CFFjCQGh1e1XUC2Qxthlb7FV6wT1kkOtlI2x5K
	zVuTK7PbULNdQ8exoPq6KVA88uzL4bx4NeOLpMEHqtrumRuO/cEIiV0R4fNSCBErUN3gmzvNMwl
	ktaDsR35
X-Received: by 2002:a05:6000:144d:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38a873122edmr6638207f8f.54.1736435424220;
        Thu, 09 Jan 2025 07:10:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI3W/aycYGvq2vgzFdy5N1qkg17Mwcpw6cxanoONqMOVAI1uE8X+UusgFdIR5HQLm1ccfB1Q==
X-Received: by 2002:a05:6000:144d:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38a873122edmr6638174f8f.54.1736435423836;
        Thu, 09 Jan 2025 07:10:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc5csm23888985e9.2.2025.01.09.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 07:10:23 -0800 (PST)
Message-ID: <75bdc3f1-3de8-4b18-a1db-512fdb34a8af@redhat.com>
Date: Thu, 9 Jan 2025 16:10:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast
 addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20250109072245.2928832-1-yuyanghuang@google.com>
 <361414dc-3d7b-4616-a15b-3e0cb3219846@redhat.com>
 <CADXeF1G1G8F4BK2YienEkVHVpGSmF2wQnOFnE+BwzaCBexv3SQ@mail.gmail.com>
 <CADXeF1FxVt=xt+yk_SvLSYBYw07Vy6pssSfXqv8pOQuP7obPgg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADXeF1FxVt=xt+yk_SvLSYBYw07Vy6pssSfXqv8pOQuP7obPgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 4:01 PM, Yuyang Huang wrote:
>> Also, this will need a paired self-test - even something very simple
>> just exercising the new code.
> 
> After looking into the existing selftest, I feel writing C program
> selftests might be a little bit anti-pattern. The existing test cases
> primarily use iproute2. This approach appears to be more common and
> easier to implement. I do plan to migrate `ip maddress` to use netlink
> instead of parsing procfs, which enables me to write selftests using
> iproute2.
> 
> I intend to add similar selftests for my other patches
> (anycast/multicast notifications), which already have corresponding
> iproute2 patches under review or merged.
> 
> For this patch, my proposed steps for adding test are:
> 
> 1. Fix this patch and get it merged.
> 2. Update iproute2(`ip maddress`) to use netlink.
> 3. Write selftests using iproute2.
> 
> Please let me know if you have any concerns.

Fine by me. FTR we used the C program way for mptcp - before ynl advent
- and it was quite a pain.

Cheers,

Paolo


