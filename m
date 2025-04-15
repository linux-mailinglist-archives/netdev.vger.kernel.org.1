Return-Path: <netdev+bounces-182838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B10A8A0C3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2781A189EB6D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB0481C4;
	Tue, 15 Apr 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="IaUPPj1c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990533DF
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726528; cv=none; b=HoDYBOIjyXXVjjmFxQuEnEC2af1fdk9aEFEejeT/Sv1pXAUZlqOYjeNjpDgLtmIQG8FLduVIpEOtW7abQXJcqwj6HDzjq/u1XJMUmK3XQ03yO3ZIdBWOI2N2pjrbLbAwolBhiReXKX/un8p01bwMtPQj1Zowh9ZE+zvSkUYz37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726528; c=relaxed/simple;
	bh=BQe6hrKpPjrnt4dZoFjYNYMBV5HC0cL0TjpEohWVhfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS2srRAk4JNla/eGKTw+j2rXo7oKWVgE1cLnjCq/gNtrSWLf32pmcTlfOJkiyQwGcn+cgIfv8oTKH0JKSuJZkTQgo6URwIwe1iKXHZ2HBhm1uen4Z8cO1+hvYvqbx8RAuJKe8tqbU1jVwFZUptjh2sk1ADkLk1/LDX16LKpdYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=IaUPPj1c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so56202855e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744726524; x=1745331324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GMvoLkqS8ZYF6jPRz+Ka+ADJm85noYAL9pIJhCxRK4=;
        b=IaUPPj1cT01ZtQ8BgI8qimyPlrXEChXrkiAHbSP1IvtJbb5as4dbAE/okdY/HavJHB
         9LZ/RWpNj1hTUxxecOnzUdoski6FOUXd08oWEl380D90lqCzVA7HTyxrWKM4l+gyPVtI
         MLyTe0F3JfjYcPw+o2XFzQp8Gdy56rbRtHgzJgQTTXtZo8+4k4U9q/R0Y7H58rI1yg+c
         E3p3oIGX04c6el0gC3eLjuyHOvgrdW+zVvpEq7mAQthjBAWqyQHSBb0Oaveza7aXUj8b
         yEtECON9OTo5GydNlGR9DRbbQDUYk4ME/m7RM0M5HJXgJAGOZ9am5B0PAwaRNmRKPjMA
         u6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744726524; x=1745331324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GMvoLkqS8ZYF6jPRz+Ka+ADJm85noYAL9pIJhCxRK4=;
        b=bFNnzJoHtQToS69AqvgyyGwlXM9XcMc+KBafqNBgr8Yp+91mEjLujdwV0WfQLjIrkZ
         WwQnZrgAoc1JEziEs5GRx7c9kHhEsF/6GHiJhQM1GEQIzihxXK0JkeKSQbM+zfo35a/Q
         rKTRKPBXALeb+pXCu9cW1aL5Xmk6n8CqMXovMMGcK8TKeG1ZiGindqIK1r9cI4dsbE2K
         vCv5IalzNOiIDsD/FNl74GOOBagcgFG+LM/ewR19KHq2W+1AfZnBW0lgT9GgxcoWuOz6
         8SxJJZjPYw3cRqn9Z2EwQuy8eo7ow0+ZAzPJ8mQNVoOL6ylUom9lDMXs9/hxdJ40gFX7
         yEbw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Gp+2H6yrrFQyGLmnsca6vr8vOU/lFI+dpXto9lj2UfP8ag2C1oc1Ur3VSimvNMPF/hnHLuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjq850NkXT2MOC96OxCBct9x2HRgSP579N2dzhr07g+4eBeMiX
	+9musbUTlpcGWu/KI2eK7TdSVkLviVlyzpPPd14ouK9L06quDQZYM3TdY6tl49sDbXO+0W45obE
	O
X-Gm-Gg: ASbGncsAM2oo+FywzK5dObDcFLiHNMdpHOqLIKzNRbOyxkQKvj/d+yTCyRoiKPAi2Fp
	IiENAJll2rlCsEjhKFJOJ9ZI8i0UR43JRT6831mjmJPYQktQ6U2/jdcW94c/pPWpDFC75smKgIV
	2ucK10eJhYgzxsBLNmmmXEUV49+aElHYQm3wQwt+N93fDyLk7/rEPDAQ9SbFkCO80+kbC+DPjPt
	zKHdPpswvMDVwfyWrnYqm9ojAOCyliLkPHJgpFpj+J+4PMJSjlv9qo1B/odL7wAOsH7qBxp0FAs
	H1++VhxyF3upzfssQXdsenx3FKK3UutnUfa0ueOjV7oyTlm873bzJ2NBCOw0upYYuYmqceVa
X-Google-Smtp-Source: AGHT+IFsAxL063Lqb/Rmz+tOwhk1MvAjIWN+Ok5+oHVVuVmkd2Z4762m7KfCrp1g7658G81V2iiC8w==
X-Received: by 2002:a05:600c:848d:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-43f4388e144mr118727025e9.11.1744726524285;
        Tue, 15 Apr 2025 07:15:24 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977a34sm14453368f8f.44.2025.04.15.07.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:15:23 -0700 (PDT)
Message-ID: <48c019b3-6748-4f89-9735-af66bbc7e65d@blackwall.org>
Date: Tue, 15 Apr 2025 17:15:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] vxlan: Convert FDB table to rhashtable
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250415121143.345227-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 15:11, Ido Schimmel wrote:
> The VXLAN driver currently stores FDB entries in a hash table with a
> fixed number of buckets (256), resulting in reduced performance as the
> number of entries grows. This patchset solves the issue by converting
> the driver to use rhashtable which maintains a more or less constant
> performance regardless of the number of entries.
> 
> Measured transmitted packets per second using a single pktgen thread
> with varying number of entries when the transmitted packet always hits
> the default entry (worst case):
> 
> Number of entries | Improvement
> ------------------|------------
> 1k                | +1.12%
> 4k                | +9.22%
> 16k               | +55%
> 64k               | +585%
> 256k              | +2460%
> 
> The first patches are preparations for the conversion in the last patch.
> Specifically, the series is structured as follows:
> 
> Patch #1 adds RCU read-side critical sections in the Tx path when
> accessing FDB entries. Targeting at net-next as I am not aware of any
> issues due to this omission despite the code being structured that way
> for a long time. Without it, traces will be generated when converting
> FDB lookup to rhashtable_lookup().
> 
> Patch #2-#5 simplify the creation of the default FDB entry (all-zeroes).
> Current code assumes that insertion into the hash table cannot fail,
> which will no longer be true with rhashtable.
> 
> Patches #6-#10 add FDB entries to a linked list for entry traversal
> instead of traversing over them using the fixed size hash table which is
> removed in the last patch.
> 
> Patches #11-#12 add wrappers for FDB lookup that make it clear when each
> should be used along with lockdep annotations. Needed as a preparation
> for rhashtable_lookup() that must be called from an RCU read-side
> critical section.
> 
> Patch #13 treats dst cache initialization errors as non-fatal. See more
> info in the commit message. The current code happens to work because
> insertion into the fixed size hash table is slow enough for the per-CPU
> allocator to be able to create new chunks of per-CPU memory.
> 
> Patch #14 adds an FDB key structure that includes the MAC address and
> source VNI. To be used as rhashtable key.
> 
> Patch #15 does the conversion to rhashtable.
> 
> Ido Schimmel (15):
>   vxlan: Add RCU read-side critical sections in the Tx path
>   vxlan: Simplify creation of default FDB entry
>   vxlan: Insert FDB into hash table in vxlan_fdb_create()
>   vxlan: Unsplit default FDB entry creation and notification
>   vxlan: Relocate assignment of default remote device
>   vxlan: Use a single lock to protect the FDB table
>   vxlan: Add a linked list of FDB entries
>   vxlan: Use linked list to traverse FDB entries
>   vxlan: Convert FDB garbage collection to RCU
>   vxlan: Convert FDB flushing to RCU
>   vxlan: Rename FDB Tx lookup function
>   vxlan: Create wrappers for FDB lookup
>   vxlan: Do not treat dst cache initialization errors as fatal
>   vxlan: Introduce FDB key structure
>   vxlan: Convert FDB table to rhashtable
> 
>  drivers/net/vxlan/vxlan_core.c      | 542 ++++++++++++----------------
>  drivers/net/vxlan/vxlan_private.h   |  11 +-
>  drivers/net/vxlan/vxlan_vnifilter.c |   8 +-
>  include/net/vxlan.h                 |   5 +-
>  4 files changed, 248 insertions(+), 318 deletions(-)
> 

Nice work!
For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
 Nik


