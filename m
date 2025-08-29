Return-Path: <netdev+bounces-218147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF59B3B4C0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D122D3B76FE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E716285040;
	Fri, 29 Aug 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG/RkyfX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE7284B3E
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453991; cv=none; b=lSCmTx0gfvS7QVICKbNNRRnh+4jSzjjtd/AzFrDmmVC2K1V2LKzyA2G/r7hHonc442EsAr++oGF5MHdeFZornf5e9hUaiNcx45SDSCWh9oroHg2bCkd9aW+CqmCX3TPYPhW1OGf42qBtJCMJKyt6XVIgU1phHqYVuaIgHlCB4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453991; c=relaxed/simple;
	bh=lOdljMBmZ08JUxTdUwkStvF82Dgxs+e5sySHLs7UITM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Qo+9QZkJ2KjWklMY7hO9NvarSvRp1FrCUaHYyeay/8qoZ8/CaxF2Ej2X/xMuub01GLQqHyIyCMh9gP+kW0LARpicajNWgfucFZ+/FhLd1McMLGtG3FHxvW1qkmpElsemFjTEW5kdynCW9JW1mfHCR/cL4n22Aa/57iKVZdpgUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DG/RkyfX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756453988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khK/OsBEiqkVkrp5LCOYWIdXXWGkjo+1lkTK29BrBeM=;
	b=DG/RkyfXiO14IS7HCgOTlkgpC3fAWVerFEdqvhNWHCK1/GBP5TYqhAl9sCjBI08gzeOmR/
	3NWEoiJ3uvXvCK4978eCLCqd0xfk+8ilupp9xrI5+qagjohI3cBvtcb6UYHdNFjd9kmXla
	JWjvWPVtSsgFnyZ97Z2BIYrIS1m94Qc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-KZJaNYAoPt2KiYLc6PoJ7g-1; Fri, 29 Aug 2025 03:53:05 -0400
X-MC-Unique: KZJaNYAoPt2KiYLc6PoJ7g-1
X-Mimecast-MFC-AGG-ID: KZJaNYAoPt2KiYLc6PoJ7g_1756453984
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c9bf5c8b12so1022759f8f.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756453984; x=1757058784;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khK/OsBEiqkVkrp5LCOYWIdXXWGkjo+1lkTK29BrBeM=;
        b=SUP//D/k/StsZkUKezeSruSeIcpxCUTVfb+CitN9fnYZWuu0BSMc+gtUX0/wAuyHQy
         VN9BQlqz37VjcHdCiPH79j+9pNiE18c14BN+Njc0J1n0/iGmOUBhmpMgZGAGfuu6MAeb
         DQ9GoopjcMgfOcWd/Z01jHZvNAIOPlcmxYXm2bcpvLzufSA+pTggAZxLV0tj/xYN+dgG
         nRT/JYv2OwWF3wcUOhIloo2AnVaTAXdwSudpMF1mGVwIMsiLMa3mDZQc/ULmiOxeWKEz
         ysA/xDJZhn7p7pKRzNzh4ASapY43YLECzhp6Tm2j5uClQ/0nePhqnoWhXrzRl8wsWYUJ
         i3Nw==
X-Gm-Message-State: AOJu0YxTOk8O3oxUcwDSiCcuDJHE04ofQx9G/UX2fHIuqfrzOFE4RNR3
	IJN6WYuxn9QfBK6qeP/E48ITn3lFvmbPnWXvWPwBuBqaKgAGqORM+Dbbx6m6dT7WjQnktewztac
	RUGI73J9odygmE7Y7C5CtDbB14Jl1ZCGRYY3I72/RWrk9HeGQpCKUd3SvMA==
X-Gm-Gg: ASbGncufbDbJloy5kK1aowXK2kduFciqRU8P91X4BaH8JOBp2PZaPFKW1GtU7BKOyFC
	41VoZCwCc+7iF8HuQ98H1Y2vv5peJ90kqwnvAMMfyCER6EmrpDdwZvfTzN5l7hDeaHgp/usa2TU
	H1po2nLhEObvPgsFa3lDH5qzgre+Y8xs0Sb11+6aRxfcOaNfiGBO4z4lreIiVwc9jTgbMHZycff
	5XGdGz3nfiIMDNLI/c+IkaHAWwnjEVEPdDcUHyKqIIrUgsQrxbEXjAt+2BEpHyAZpXbhWbp3Tlq
	rlJs/gVvDCdmsHnB5AstsDeuurFTK1mu8u//1Y2jJudA0jUW+x8JQbppmJc7AMZMm4CzQSpKNf2
	+5O8aGekIl6I=
X-Received: by 2002:a05:6000:2187:b0:3cd:9b29:230e with SMTP id ffacd0b85a97d-3cd9b292d6cmr4469122f8f.2.1756453984052;
        Fri, 29 Aug 2025 00:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8fs7Us/i8mQikVCQVAJbo3XHRMXUO6YPfmgtePmE8wWucGlF/loPe8SZJhQKw/AYLpCKMMg==
X-Received: by 2002:a05:6000:2187:b0:3cd:9b29:230e with SMTP id ffacd0b85a97d-3cd9b292d6cmr4469110f8f.2.1756453983604;
        Fri, 29 Aug 2025 00:53:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276cc915sm2298309f8f.21.2025.08.29.00.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 00:53:03 -0700 (PDT)
Message-ID: <fd3b25a3-018b-4732-af42-289b3c7c4817@redhat.com>
Date: Fri, 29 Aug 2025 09:53:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-4-ouster@cs.stanford.edu>
 <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com>
 <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
 <6d99c24c-a327-471b-964f-cfe02aef7ce2@redhat.com>
 <CAGXJAmzpibzh+4FvM4mcvkXeT8f0AhMK00eqie7J8NEU9Z9xWg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
In-Reply-To: <CAGXJAmzpibzh+4FvM4mcvkXeT8f0AhMK00eqie7J8NEU9Z9xWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 5:03 AM, John Ousterhout wrote:
> On Wed, Aug 27, 2025 at 12:21 AM Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> The TSC raw value depends on the current CPU.
> 
> This is incorrect. There were problems in the first multi-core Intel
> chips in the early 2000s, but they were fixed before I began using TSC
> in 2010. The TSC counter is synchronized across cores and increments
> at a constant rate independent of core frequency and power state.

Please read:

https://elixir.bootlin.com/linux/v6.17-rc3/source/arch/x86/include/asm/tsc.h#L14

> You didn't answer my question about which time source I should use,
> but after poking around a bit it looks like ktime_get_ns is the best
> option?

yes, ktime_get_ns()

> I have measured Homa performance using ktime_get_ns, and
> this adds about .04 core to Homa's total core utilization when driving
> a 25 Gbps link at 80% utilization bidirectional. 

What is that 0.04? A percent? of total CPU time? of CPU time used by
Homa? absolute time?

If that is percent of total CPU time for a single core, such value is
inconsistent with my benchmarking where a couple of timestamp() reads
per aggregate packet are well below noise level.

> I expect the overhead
> to scale with network bandwidth, 

Actually it could not if the protocol does proper aggregation.

> so I would expect the overhead to be
> 0.16 core at 100 Gbps. I consider this overhead to be significant, but
> I have modified homa_clock to use ktime_get_ns in the upstreamed
> version.

My not so wild guess is that other bottlenecks will hit much more, much
earlier.

/P


