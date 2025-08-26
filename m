Return-Path: <netdev+bounces-216831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3522B355F2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8AD16A79D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440C2D0C82;
	Tue, 26 Aug 2025 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2v0EndX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337638DD8
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194294; cv=none; b=VF3uO49i0V1AUw/xBWjXi4PDDlxD/nAmwYEOY6MXBg4wUmMNgCSDizd7L60+juStU+yhzl7NZrd7wLOCoBvELrmN/uLsXFULunCV2tDpsdg03u7nsjazggJrotyZ+AcN6t2+yx1qHWYKfnluAp+E0VgEewBNGkB0Dz+hjAp1gCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194294; c=relaxed/simple;
	bh=8dyCErOJFKMfMFMV8P3CLlAWn122UXxDe8qbu+MAWT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V31KE4sKis5594ExTfTrJVaDIJK3fHfxqIFmdXTNK6j8u/TW4SIbOUtAhEwjsfK6deGCWazYRujqZfC4qQuDMHw5LrfMcFW+eXzYHDN2Lva5lvWJv/AyzCC5GM6USaPAYv1mWY2m/59NNHpV+llzTQp/NzUOwgmE1njX0CyCOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2v0EndX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756194291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDrWwBla1QrTDzNI7yFzBveJvJXRu3aajUikrOKKqUc=;
	b=P2v0EndX5f6L8Cin+TnR13MOinHlYGKlsjdi5B8mRl1vSP4B5EOsqeLNP7NpuXaZCOqidl
	Whf2KoM+WDcQcrgtcIHduLcnniE6m6cLob03hq64x/XaRG39J1wgW+RsG56XzmwlGz9l7F
	lPoo/howNPwfCw52dQtq6zf+i27KkgY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-PSmYvBINMmiv36WQ_1YvlA-1; Tue, 26 Aug 2025 03:44:50 -0400
X-MC-Unique: PSmYvBINMmiv36WQ_1YvlA-1
X-Mimecast-MFC-AGG-ID: PSmYvBINMmiv36WQ_1YvlA_1756194289
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d9a65c355so84805526d6.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 00:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756194288; x=1756799088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDrWwBla1QrTDzNI7yFzBveJvJXRu3aajUikrOKKqUc=;
        b=YMLEf/++E9g6nIoFW4Bftv6N65c0Wk+5pv8K0WOszKsbaIrZB7tEwXhfQOriBqm4Rl
         tUVptXJlTJQI9pnw6o8pEL9Ngfa/+Gs/gTzaoI4D9TMj/nmDJcBxucJH2X7wL65ivJCE
         f/OAyJdSHkEwEO8wqMTNUKQs80P5qlQom3VIAJJr/E0dKCo7YRItEJIPNX5oAUN9Wdxy
         hq3vUnW4McSq3BIwn3JavN5PFxZRIB357uMr4DwEGzmNrgp+6jTxQXtQk+MrWR35yNEK
         vlH5lj7elsGaa+YASiV1kU/CnTyEDnmr+1/H4Y69dzekBPihWDPAXNqYwXCOrPvJf6xH
         maDA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Zljcdbhi/McOyDj4XTKDEsoa+oxITAUqRdwJAej3i2ge9q1L8HhjkzIUaM88cLaNQJAdwt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDhqPKG240d0g+F8/uQBTzqxaHY/jJvNABpElGh5/Llm+WhZw
	Vv4/yTfWC7d1m+DaQB+xQ4cEiom0YgMh1rFkdiyMfg02PvYEdke8R78QDezbelonuodYRn5yJVs
	E4GBqt0582GaVa21hqZlvBMoxu4pVezN7B8zf/vLLaCdvs3DWb8zw6mupae9bB8hyCw==
X-Gm-Gg: ASbGnctaW83Cv/dH4EGQNZAx2sA0V6H+f7YRs/eUjYh43Q4f+2clWQr1/kw5gCHADqa
	R/JuzIXamfq0mz+NAkduC0r2Cqgv0Ai+1dwZq6OILeM0++6SIq6do7Qhsnilq/rjCZQrxyaiLGK
	JHoxn01l3ux/n/swFx6vRs8wzR1d4s3gno8aRmvUI76EKCiHcV8H/w0DNbGosnBf1SW3wLGVQ6W
	sLacJLew7ESxesIBDpHNUUETh+5fcGnNpiy3p7QjxyiqsBetyWSiF2DXQ6vyJXE9IA+kVDAnwTh
	1uEInCSI/jwDT2iX4a4isvOud3cnd9KP3+GjTWZIVYmA2ZChBpKPlTrSlRUo28nFT48Y/o+h9SP
	jtZuak8msVOY=
X-Received: by 2002:a05:6214:acc:b0:70d:c4b3:9443 with SMTP id 6a1803df08f44-70dd59c1759mr4350856d6.31.1756194287953;
        Tue, 26 Aug 2025 00:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhzhn5+Yg77HtcZk5KiF7sJitx0Vz2y9+jpRKcTifYsTOJze6b9AG3bPnC6Fl6hT2Uuy6Org==
X-Received: by 2002:a05:6214:acc:b0:70d:c4b3:9443 with SMTP id 6a1803df08f44-70dd59c1759mr4350726d6.31.1756194287545;
        Tue, 26 Aug 2025 00:44:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72d6a53sm60101456d6.72.2025.08.26.00.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:44:46 -0700 (PDT)
Message-ID: <fcd38381-b5d8-412e-bc22-f1f5e4fc0b4a@redhat.com>
Date: Tue, 26 Aug 2025 09:44:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v4] ibmvnic: Increase max subcrq indirect
 entries with fallback
To: Mingming Cao <mmc@linux.ibm.com>, netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
References: <20250821130215.97960-1-mmc@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250821130215.97960-1-mmc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/21/25 3:02 PM, Mingming Cao wrote:
> POWER8 support a maximum of 16 subcrq indirect descriptor entries per
>  H_SEND_SUB_CRQ_INDIRECT call, while POWER9 and newer hypervisors
>  support up to 128 entries. Increasing the max number of indirect
> descriptor entries improves batching efficiency and reduces
> hcall overhead, which enhances throughput under large workload on POWER9+.
> 
> Currently, ibmvnic driver always uses a fixed number of max indirect
> descriptor entries (16). send_subcrq_indirect() treats all hypervisor
> errors the same:
>  - Cleanup and Drop the entire batch of descriptors.
>  - Return an error to the caller.
>  - Rely on TCP/IP retransmissions to recover.
>  - If the hypervisor returns H_PARAMETER (e.g., because 128
>    entries are not supported on POWER8), the driver will continue
>    to drop batches, resulting in unnecessary packet loss.
> 
> In this patch:
> Raise the default maximum indirect entries to 128 to improve ibmvnic
> batching on morden platform. But also gracefully fall back to
> 16 entries for Power 8 systems.
> 
> Since there is no VIO interface to query the hypervisor’s supported
> limit, vnic handles send_subcrq_indirect() H_PARAMETER errors:
>  - On first H_PARAMETER failure, log the failure context
>  - Reduce max_indirect_entries to 16 and allow the single batch to drop.
>  - Subsequent calls automatically use the correct lower limit,
>     avoiding repeated drops.
> 
> The goal is to  optimizes performance on modern systems while handles
> falling back for older POWER8 hypervisors.
> 
> Performance shows 40% improvements with MTU (1500) on largework load.
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Brian King <bjking1@linux.ibm.com>
> Reviewed-by: Haren Myneni <haren@linux.ibm.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> --------------------------------------
> Changes since v3:
> Link to v3: https://www.spinics.net/lists/netdev/msg1112828.html

For future memory: please use lore links instead.

Thanks,

Paolo


