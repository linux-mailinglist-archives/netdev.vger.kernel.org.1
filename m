Return-Path: <netdev+bounces-182695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F228A89B85
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83843189E2CA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71428A1DE;
	Tue, 15 Apr 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtsodRGN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6228BAA2
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715389; cv=none; b=bUr9QfGT1sZ2IZUVGY0g5AT1v1Z+D5dP/GkW/VHib7ejavI9EHTdTmSRxbcMWjbIioS4AFuYuYiX/LsB6li5n/49SZ9LnN/uZYJ19QVOL5+mn8LHLKj/t2IO+YRP4eF29QqASe6VNGQxKoNCrpxe/4q6+FzS3KIUZkTGXolX7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715389; c=relaxed/simple;
	bh=pO/orhA4CZkpIQOEAHrMBfFRKYVsaK4BFhuTXpXsFyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiTM5FMCp4WIICd1gFzUPqTbT/ISKV3f4g1a/FohTq/R0K1xF4rMh4zZFiwf5PmrvWjGOW2Xpd4cPuJ5YBBVXziDOxMIMljrJtYK5LULG2zkH4LH6ISRSJ7xocDqzY7xXMKwkCddfq+4GMgytHz8Qc1dUrN7Y53jcR+6LiY9Aqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtsodRGN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744715386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfg6hG/K/bUlTifslFe0q0e0tS/Hfe18LY4wSrh6Bck=;
	b=TtsodRGNZ9ue2rsXY3vY+GH8J6ZaRx/KQBrOGfN6vh1d1sECINHNOMAsSPwEjDvnhrb/zN
	fBUiglxjBJVZ0i3NnWymOpE/R0clBl1e8hnCazMbUSOZtvhqZO6MZemPTvC3yBZC1GXuSx
	F0IAIBLWi2mc5e0B0rEtvjLR9YwHs5w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-iGE73qpnMquu5KdzWwdjpQ-1; Tue, 15 Apr 2025 07:09:45 -0400
X-MC-Unique: iGE73qpnMquu5KdzWwdjpQ-1
X-Mimecast-MFC-AGG-ID: iGE73qpnMquu5KdzWwdjpQ_1744715384
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fc9861cso1922355f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715384; x=1745320184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfg6hG/K/bUlTifslFe0q0e0tS/Hfe18LY4wSrh6Bck=;
        b=TorpvlNQdE5n08roGV0HDWARzYC7w5x0P7w6gVwKUi3NJ3TsWsD0bBld6U8CEzCZA+
         hJYnjtry36ksfLE0kLOrpxD9x+NDaFR9O6lWSuzeUMw8p3FNivRNyzFo+TBvadav+Yq4
         TvfhDB2i+QCckV3stQI/+xaRYocScEtpq/71ob7ko/01UNnuB5c3+ox6Hl2/1XZ/4Pa0
         WLMUEWEaJZVbT7g5QBH7jJPAKqKKv5POC+5bcp4hnxpOEUQOTWR4O9MJlFrRoNQQ6q+3
         dc27UJ3FWef2dSQvHi1EQyfeNZCA7iAEU5+toa/WQbVceTD+aZSkm9kpACztuObPxvqe
         7bNg==
X-Forwarded-Encrypted: i=1; AJvYcCXQr7VhMPCc7A3B6aw1cqfiaeawgjAi0NXVxbKzP2UcsGvfvvTWuHEbIYMlbcSeSiMZzmrqglo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOefJ9L4l4oCZmuPB4mZ6fApUzOG4m8wFwHvwomONYcDLmLav
	PrFQWH1zl6O12epk1NXRP8dRv4RJmXYwn7n5sJbS7V3Zz0WFvwvp1s726EChj4PEAtso2PstVn3
	zZpp5gfnkFB8ZqHkqdMmNDkslGAW1RENn8XRJcxe3ovRRethCTtblLQ==
X-Gm-Gg: ASbGncuOfegRNMo6Z56u3GVZV9KE99x/siJLS7fncQfUAcUhSMHqawlzE7FnKjJ3QYw
	gofrt2LpJndasqJy9nuwywHnhPCNaxAE33b8OvPIEtdEmFv87GJFwFGxCqEZxW7Cvzc0zrCO8DV
	qR1Ztsj+knqepPufHeTyv+EQzAC7oPNdr4EHrSIJOZyGqCgYaEyLcEq9aYrMgkCPRGQhtqO1h9k
	ckNs4GE4GgGvqog8BsW6K2aYvDu3Y+mJ3QwUHh57WtIMseoIWUUr2gBRfDYGQX9Lu81wa6+Byrb
	8xOjGY+GO5o+TktxeRfqCTh9/0XdXnTk+lSA7nc=
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr11800061f8f.2.1744715383965;
        Tue, 15 Apr 2025 04:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHanO8hlN3E2sYMOBJM/QMDt/pr4AiCH7Bh4HhFQVy1kY1F4hzOAbHErMxD96ZS7aMhWnOulw==
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr11800043f8f.2.1744715383632;
        Tue, 15 Apr 2025 04:09:43 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce3bsm14172785f8f.66.2025.04.15.04.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 04:09:43 -0700 (PDT)
Message-ID: <ed49eed8-3e0f-4bda-aa30-f581005c4865@redhat.com>
Date: Tue, 15 Apr 2025 13:09:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: ncsi: Fix GCPS 64-bit member variables
To: Paul Fertser <fercerpav@gmail.com>, kalavakunta.hari.prasad@gmail.com
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, npeacock@meta.com, akozlov@meta.com,
 hkalavakunta@meta.com
References: <20250410172247.1932-1-kalavakunta.hari.prasad@gmail.com>
 <Z/j7kdhvMTIt2jgt@home.paul.comp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z/j7kdhvMTIt2jgt@home.paul.comp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 1:22 PM, Paul Fertser wrote:
> On Thu, Apr 10, 2025 at 10:22:47AM -0700, kalavakunta.hari.prasad@gmail.com wrote:
>> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
>>
>> Correct Get Controller Packet Statistics (GCPS) 64-bit wide member
>> variables, as per DSP0222 v1.0.0 and forward specs. The Driver currently
>> collects these stats, but they are yet to be exposed to the user.
>> Therefore, no user impact.
>>
>> Statistics fixes:
>> Total Bytes Received (byte range 28..35)
>> Total Bytes Transmitted (byte range 36..43)
>> Total Unicast Packets Received (byte range 44..51)
>> Total Multicast Packets Received (byte range 52..59)
>> Total Broadcast Packets Received (byte range 60..67)
>> Total Unicast Packets Transmitted (byte range 68..75)
>> Total Multicast Packets Transmitted (byte range 76..83)
>> Total Broadcast Packets Transmitted (byte range 84..91)
>> Valid Bytes Received (byte range 204..11)
>>
>> v2:
>> - __be64 for all 64 bit GCPS counters
>>
>> v3:
>> - be64_to_cpup() instead of be64_to_cpu()
> 
> Usually the changelog should go after --- so it's not included in the
> final commit message when merged. I hope in this case the maintainers
> will take care of this manually so no need to resend unless they ask
> to.
> 
> Other than that,
> 
> Reviewed-by: Paul Fertser <fercerpav@gmail.com>

@Paul: it's not clear to me if as a consequence of the discussion
running on v2 of this patch you prefer reverting back to be64_to_cpu().

The packet alignement should yield to the correct code in both cases.

/P


