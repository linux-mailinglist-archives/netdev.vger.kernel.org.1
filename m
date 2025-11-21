Return-Path: <netdev+bounces-240846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B4FC7B1A2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D007636571A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD12BE7B6;
	Fri, 21 Nov 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="XZNU9W9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787E26B760
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746860; cv=none; b=qFGbsGtOjgVCC8PaxRz7T//DiL8v65ZqvaP1zvnCwJgSW9WVR7XPJ4kqK3G+V5lF3YlrWxnsWENgDiX1gYyOH0999AW2Cf96tsMtwvomAoxoH7nCkAmP7nKU1mFM1VfltRaH0B/zRHCmd3h2SGOLUO3S3e4Y5yQaO3ZaESVWlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746860; c=relaxed/simple;
	bh=ZutscFVphoVwxYs5gF2MQsZoKb12i3GvOD2qvOYrz7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsDkgFNaYKB/Ae4U1lwwU1rfMmsHBsJuD1h/WtOzteV8tDZ9kfdzMh4f1VJ+eF3d8ELnHIG8VIwKqC2Dq/NyVdjeFajHZoGbqC4rjwG0XLbLZMwA+agmZvutZdSYNvFlFNh7L88MR3py7tGfv4kvllskqybfTsFN6SvGX/cnOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=XZNU9W9k; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29555415c5fso25067935ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763746858; x=1764351658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REIxK/xDCDKMu97XAKMXh0CuxxyUDwwarU6s0b7DaUQ=;
        b=XZNU9W9kjGoKyQfXdvz3cpPbpfBHTJF4Xxr32GFqxSzlth1rtV4WOSvOIueq3RjUlx
         VEabeqa62kzFKL1ONDL953DekaRLWRCCNi+TLikhv6WXXho+TVE1gtSSYZg+1V9zMl4c
         m3vfvBQ5u/DJOi/+lLSfotG91Aqh8ctwnCaxy3PeeizjJ1np/vFmEG4F0KigoebdNQ6z
         3ESMblqkCPBVPUicpuacPdI1NBL5iMoC4Yvx2NKEDl96JT7QIlTM1yYt11Z5znn7Ygvz
         I0qOkNsg9dHlNpN3WRdT1hmOYS1Uq7e+o9vDE9BGJiZu7H08rJ806g9TSICN+8+6tLpQ
         85Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763746858; x=1764351658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REIxK/xDCDKMu97XAKMXh0CuxxyUDwwarU6s0b7DaUQ=;
        b=LighBkvyIcjAuGhj1uwvtoRQ6QppOKr75E/InpzAXxgUUoPUpx+rp103DLbMNI8fgO
         gMtyqAh2ZcupvorwM7kx3RNEGKiYueCMKv63rttNMWTkQVB0Y59Ci5VKv6CamjxHKc6D
         5/FCTOR7sjoLDl9MKmGp3aG/+7UfVHT0gKjF+7Xsb0Z63AOJe1hWiha14hg+DVSIq0SU
         LCotzC2N8YnF04/p5hOfjpWf8asS25qjFQG3wYBYa/dM8qp7SKjPXNxWx0RD4vdaqRJM
         PmW+RDCYb6g2BQkKxmVgjoVbqdpr1STHCI1o+8AYqxJzoo/mhstz8xZU0drNZ8yol9ml
         R4RA==
X-Gm-Message-State: AOJu0Yy1qH9neUMMgy16RgTe1+Pu+mekV7u6IGh0jnAQVn9Jx37HxKUc
	0bcVrLfBd0jHU4T3JlMnmVLkZV05d4J8zWXFyHyo7RIU4SUwp+EAd9SL8/NgiknZ8qM=
X-Gm-Gg: ASbGncsBMawTUBW+82iWjry0Ha8WkfVSC/F7cZAI6CWZYLSdbofD5Up3krG1sDy1MI0
	M6ebDUwJnLEQJ0udUxwZqHMdhLisGmKBt9fUItO6mF6gOyQXiqYhOP9y+yCohmSmhRyOsvAjrsE
	eSE9jberabwOorbj1WNl+3w7FwvYctMPRtzemBe8tzn57Hi9Q04/cpFHsMrBrgdPw48W+f/ACL+
	qJ3ytkWh3J6rjGaclBs7m/j752KQU6pE8dQI2zy27LfnJ9GN7WlcHTAhXQDN5hZWNIK1iXU68WS
	zAq0k2LJOBffA4PnbiN5AoA6hecfHuwt44y6JPswYhuB5codDFjDPNpGbl3J4ZzsPBsI4X6V+dy
	ZH79PNcKOqlFSh/YK2F7na20vR8C1KWoVhdVgouM4/ZL7Pxnm2tKgPUBOrP+cUJ4xF7yAapglhX
	1V+6djZF89SsK8J2u9J5QAMb4zTrxfkP54uKOrZN60+hJ3/AsQ8QqHEyn1z9i70/r2z/A30Xrbh
	+SMEKxCvN2s8S/1JA==
X-Google-Smtp-Source: AGHT+IGY+IVffgmhZPDeTRIao/ddoa5fNa6WfhfDfVsueaZr82Yb0a8TnoWVmLontUo7vo2bJ+emRg==
X-Received: by 2002:a17:903:292:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-29b6c3dc29fmr38772065ad.4.1763746858342;
        Fri, 21 Nov 2025 09:40:58 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:9190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1075c6sm62975905ad.17.2025.11.21.09.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 09:40:57 -0800 (PST)
Message-ID: <214709f6-e9e8-471a-9913-26e2ee438fc1@davidwei.uk>
Date: Fri, 21 Nov 2025 09:40:56 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 5/7] selftests/net: add bpf skb forwarding
 program
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251120033016.3809474-1-dw@davidwei.uk>
 <20251120033016.3809474-6-dw@davidwei.uk>
 <20251120192045.1eb4a9b0@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251120192045.1eb4a9b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 19:20, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 19:30:14 -0800 David Wei wrote:
>> This is needed for netkit container datapath selftests. Add two things:
>>
>>    1. nk_forward.bpf.c, a bpf program that forwards skbs matching some
>>       IPv6 prefix received on eth0 ifindex to a specified netkit ifindex.
>>    2. nk_forward.c, a C loader program that accepts eth0/netkit ifindex
>>       and IPv6 prefix.
>>
>> Selftests will load and unload this bpf program via the loader.
> 
> Is the skel stuff necessary? For XDP we populate the map with bpftool.

I have no idea what I'm doing with bpf and was copying from
libbpf-bootstrap :D I'll use bpftool to attach the bpf prog to tc
ingress + set the vars. If xdp is using bpftool then I presume it is
already a dependency on the DUT?

