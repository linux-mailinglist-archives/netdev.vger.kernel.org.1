Return-Path: <netdev+bounces-201791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BDDAEB129
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35B056238D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65733236A79;
	Fri, 27 Jun 2025 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4kCz8t9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A0237164
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012529; cv=none; b=tDbnIwULaqYTKVTzrDEDx9Ft86sn4e+ZLQf/+sZw9ycP3wjEMbTslHD4baX8hcphgHevZL8Kd6hmWBHQDkl/ydIr9ZorzaG7mn17Z2EEaGJom2EfmhzSg9k0JKyJLqs7XRDmr0PxMkNxvPuoXUsmWj3ht/7Ohf7SxZKisAejqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012529; c=relaxed/simple;
	bh=7L7gnA+PMqOvFzB9aOAb6Z3I8wPBf+AMV/Vnk3gf7KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHoJzG2V7A523yE4z8i8cqJZozFUVJwYrifKiYlyTq5BqMKcV4pp/IbEY2msWC5Dfd2jtagivijtOHU9Z1sUNF9g/VFnPFj+s7EBJKqhyYxs7c8/KhZy+YYV06+CyzrkviQPe7VxpvkMfbAKMqI9cnloL7c1yYfDAb6u8xdfxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4kCz8t9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751012526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdhaPmsWFArhsXFsISpX5ZipUl19a5SM0RfIr3emwGI=;
	b=h4kCz8t9918FeB2B47Kp/LfQUPldYKkkKrJKnyw4K2hv5VOwJx6J5Urg3sywplWP3Ft/iU
	0A6+v3fc/cGSPXdpczA3wrGTyuYaW0WkfZzG8OnGNKD0VJ0BPocGJzzupRMoZt1GLW6FJA
	1K7mMR9OCqDFBjAyB8iwzC2IeVhcG2I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-3VmI-TXTNXGFCVtMNKzLxw-1; Fri, 27 Jun 2025 04:22:05 -0400
X-MC-Unique: 3VmI-TXTNXGFCVtMNKzLxw-1
X-Mimecast-MFC-AGG-ID: 3VmI-TXTNXGFCVtMNKzLxw_1751012524
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so1470309f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 01:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751012524; x=1751617324;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdhaPmsWFArhsXFsISpX5ZipUl19a5SM0RfIr3emwGI=;
        b=TmI+MMaA3xQUuh59pCC17RUPQAeRUhmL/Ts93RxGQNKnch8EiG6qMoe8iYhoFgbQ9R
         Hk2vqqXfG4zpYUJ2a0BP6COSgOWTqldyTdBp+cUs3wWx+2/dBskE6ESFO75gPtH/ELwO
         hbZoFfhXW8VVvWp6Evf36XY8eU1sJpjmsFOP0hyYDKYoSO8Kbvfnq4BUUoBfBWkVEngc
         xq8thvyh8kPUybGPkcFyaL+JjlUsoCnvhn7XRiUYaDQ6QuSvMCm4NaYKu+Jtcsgb1JK7
         oO/JGRlbSNtusYlPmyjGhJ6HyEeI0LFv8Y9c0rfTSTO8yK6uFvum1GzIzlst80gY2495
         /X9A==
X-Forwarded-Encrypted: i=1; AJvYcCXPImPrG1ImhMiE/DkKcgHM0/KcQiOowoYJqHqW0O9Ac0lPpDg5pQk63TpJcroXLUJIeKIcNRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzlkf+YAKgstsOcqOu23aMabCtuvEJXyxq9xgFLF30SbUTKjKb
	Iqje/w9Q21OYh0kX+eap0twWsbgYbZ/J3VRjGzDPPCqxMoYatzaD6arIhPoQhnb7+giDhAbzMg/
	hyT8M8WCHib2Iz0th+m25kcwlA56uWgIQ6PBfu9OTWYz3IkT4d3R3zzir
X-Gm-Gg: ASbGncu0A1C2rLTYSP5RGnIX8MjlbHp/1zREa3MfiEjMAGCEzh3mlXxOcFFBjezRXJK
	9cZiz575QCGLfHfW2n/wfb6yal0RMhqQOoaJk4aJTPguWqVQIMMNUqiYIjgpDZ+lf/Ee3PQAUxj
	6qw40RcGcdM8CVGIc+uP/mRLvBSUhheY2UDkmICdgsM6GNK/1Rb/04KzzPefEErHfg5hk8WHj3+
	2ACXEm+HwqO3ac62ADQTXddAr4C7InyqYN9e4H3JB1LunLOHI2+biU6v5tiyPyqGOt18zo9YxPQ
	nkSiHf0waEl0zOHNEC3jR9qNiBKcs57UE21mvC9KdGfQHqXIzCg=
X-Received: by 2002:adf:9cc9:0:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3a6f3153609mr4583315f8f.24.1751012523788;
        Fri, 27 Jun 2025 01:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE6kxl77BfW2oseBFkSC1JtOT5bepuvfPux+euP6AbKgN4iSeaZr6ihXIz7XSCpkAgQOS7Lw==
X-Received: by 2002:adf:9cc9:0:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3a6f3153609mr4583297f8f.24.1751012523368;
        Fri, 27 Jun 2025 01:22:03 -0700 (PDT)
Received: from [192.168.1.108] (ip73.213-181-144.pegonet.sk. [213.181.144.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52b9esm2024043f8f.61.2025.06.27.01.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 01:22:02 -0700 (PDT)
Message-ID: <bdca5369-57dd-4db4-82db-a2622d26c550@redhat.com>
Date: Fri, 27 Jun 2025 10:22:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250627174759.3a435f86@canb.auug.org.au>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20250627174759.3a435f86@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 09:47, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> kernel/bpf/helpers.c:3465: warning: expecting prototype for bpf_strlen(). Prototype was for bpf_strnlen() instead
> kernel/bpf/helpers.c:3557: warning: expecting prototype for strcspn(). Prototype was for bpf_strcspn() instead
> 
> Introduced by commit
> 
>   e91370550f1f ("bpf: Add kfuncs for read-only string operations")

Oh, good catch, thanks for the report.

Just sent a fix to bpf-next [1].

Viktor

[1]
https://lore.kernel.org/bpf/20250627082001.237606-1-vmalik@redhat.com/T/#u


