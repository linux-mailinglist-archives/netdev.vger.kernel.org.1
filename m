Return-Path: <netdev+bounces-179058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D564DA7A490
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D113A51A1
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A7824E4AC;
	Thu,  3 Apr 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O169bmn9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68709433D1
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688964; cv=none; b=V9k4LLLg4BZJLeBbeun9uHnQDtwCRLIMkmHXhNmh3VNJ+NQ/tlqVmmQ8MY57Lds6x5I+OMccWEn/SlxyEbePCTt7KWBB4b6uPkV/hJsskRaGVr1L4ZZhA1blBNoSOeUU2Olp6CYgeOSxIjiY98fdQaICV9wzfaA/fMpe2o11vAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688964; c=relaxed/simple;
	bh=S2I5uMGMmzaswrHxMNr8vYNfkMq3kEcFyspItbcpvic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqmucMEjukyCXsLbTnZ9ywWuvP377+HsUtfg4El0h5Im7dqjs8fSvgxZGdG/amANw5SmzT4rk8WF/zw9/z/I10Dl+OoTR26S+h05fKGYIk+uu0unZqG2lDnUVJ1xQzemwryHO7ArE7B6866bG4Qxq2bNEqPqjf4CacAQ9WtvLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O169bmn9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743688961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kWqXe38cLRXw8rlot99ne3jbC4BOsP79Qw7Xj1goMU=;
	b=O169bmn9WDd1eI+syv3gii335dHdmeatx75fCdAhPxn135p7WbKOa6CYwEHsJfGE+1Znlv
	JR8nM7J7DSrMcOlGFbFGxX6v85SZ92OVDDPsG6DySbIYVAzv/Oa+Jk0U/l5NCeTApaEn4H
	uKWsykX9fglGCsI4dB5TcY4cOsiV6vY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-bsODjmkjMMyFfbl-rkS3oQ-1; Thu, 03 Apr 2025 10:02:40 -0400
X-MC-Unique: bsODjmkjMMyFfbl-rkS3oQ-1
X-Mimecast-MFC-AGG-ID: bsODjmkjMMyFfbl-rkS3oQ_1743688956
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso11135875e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 07:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688956; x=1744293756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kWqXe38cLRXw8rlot99ne3jbC4BOsP79Qw7Xj1goMU=;
        b=RmbQxuqoSFSwRlmTyfKp8NImhbJH9SYviCRUvhXE6F6PvbNzz3ohuGH900wCKscuPP
         boZefxDVvSc5J0NIzcKNXwZwJZTivWTmNn3MgPkouHOOEPMkCtAcnulXH5OPAYGaEh9C
         JBQ0ViNOHNWzgnSBVurUGCrTW10sCGv87iT/LAVke9mEaK5Qgfc+ZvXoLsVnOYqcam62
         3wNJBxFZxYxwXN7qUETWqq/ALXO3Ir0P+TPpVGMiJcP0z77YdXS4vTQomaOZHblRrC5T
         TT9SO1w5zFQ5ygVQ2PjNYluLSUAhBL+aj5k34Jlti7PcTZXMYY4fBf1FoBaasuDMHbjg
         EX8w==
X-Forwarded-Encrypted: i=1; AJvYcCX5hhU5CI1zeGPbY8JOmZ6t/q8ilPe8a3nToGJbyW9J7nKO6UDn06rqijuN7y+kZjdiBM5d7Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBGyTZxMw+pJ48Tkhw6zpZHoxNIWAnCM0K6k7/um2luByftVP
	dhIFhELTXZ5HhRf5O4AhyKoH8bXrwaiH0GIzw26R305zVDwgvCe/HIlm6x/ryJpdu1UuN9kprqQ
	8rMgZCOhXNFftkgFyfp156+Lmfbof6+1tk+ilFXIsP9WII02qykinxQ==
X-Gm-Gg: ASbGncsX1PqeyUUfpcWhdlNvNWKj94pPmlbWBbW7FYbmDy/MGfIZtsxZIn0ut4V+oOl
	teL+Mrx5bbCfiuBzsuotuFhNF8YlfowhpPDHSxAlDfmh9ksAU6fLIWtskfKFXy4FKD2XrLqKA1Q
	EORqmKcWsQJpjM2pDllHYEmUqJ84HLFC9Ik8Y2odWkX/GZBjucIfLUSPAx2AuiZWscR4GEj2DNL
	UVVrfh+2r5esioYy2fh+E8yTzb7Vzl3wTTweRVF9C8ba0G3WaB9kz1p/IlvCeEwGZAYromN9TF2
	h9J2ghiI+TizZYsrm6ZXMFKXI9RJ7AoNjwtYZRKkB33cww==
X-Received: by 2002:a05:600c:1e0d:b0:43d:2313:7b54 with SMTP id 5b1f17b1804b1-43db61d78c9mr209456395e9.3.1743688956067;
        Thu, 03 Apr 2025 07:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEcH3URdYpyXxENBkWaOZCl6SCATd9gstr45DnynhqDGmUUru1LNLrjf8EszoAacInIZ8pkg==
X-Received: by 2002:a05:600c:1e0d:b0:43d:2313:7b54 with SMTP id 5b1f17b1804b1-43db61d78c9mr209455765e9.3.1743688955644;
        Thu, 03 Apr 2025 07:02:35 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea978378esm51169005e9.1.2025.04.03.07.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 07:02:35 -0700 (PDT)
Message-ID: <d99b52d7-bdd7-4c67-9be5-f5c48edc8afa@redhat.com>
Date: Thu, 3 Apr 2025 16:02:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if
 device address is same
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250319080947.2001-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:09 AM, Hangbin Liu wrote:
> Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
> fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
> active slave to swap MAC addresses with the newly active slave during
> failover. However, the slave's MAC address can be same under certain
> conditions:
> 
> 1) ip link set eth0 master bond0
>    bond0 adopts eth0's MAC address (MAC0).
> 
> 1) ip link set eth1 master bond0
>    eth1 is added as a backup with its own MAC (MAC1).
> 
> 3) ip link set eth0 nomaster
>    eth0 is released and restores its MAC (MAC0).
>    eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.

It was not immediately clear to me that the mac-dance in the code below
happens only at failover time.

I second Jakub's doubt, I think it would be better to change eth0 mac
address here (possibly to permanent eth1 mac, to preserve some consistency?)

Doing that in ndo_del_slave() should allow bonding to change the mac
while still owning the old slave and avoid races with user-space.

WDYT?

Thanks,

Paolo


