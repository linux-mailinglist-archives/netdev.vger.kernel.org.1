Return-Path: <netdev+bounces-236326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533FC3AE76
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 13:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8868D4E44A2
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1868E2EC0A2;
	Thu,  6 Nov 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMMBk+XV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJnOLx48"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891518D65C
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432485; cv=none; b=gFZKKXpnBhm7xHJK37miKzb8b+TZQGbgQi7s0zsyCXTnsSPo/KYbZJqYy0gNwT0flhr14IFxz1/us/jYT6NgqgQjJfia4lhJBugvevSXt4V2pBD76aYSph1duhRMOO3W0Bhprk8CZztAGbmAqClkbN8O9a4ICoQFLvPj77t6is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432485; c=relaxed/simple;
	bh=51ExLM1pk4NSXeseTpJkJeYEGf61RrRO8KWtop/b2lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQNglvCh9ZTQgY68dZSY1F/fOpx90rEbNm+zyQumoO/HgU02zHAJ2pASD2kpJFuK+ZxCWxdS4X5MLyAHtndAYh9M+aVGwig9eKpjrWmJGgifS7Y7aroU44XiJXaoNGcFN5OP9NcuMIOOoHjhqT1TvRtim3N3uPdDjqE0K1Ifz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMMBk+XV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJnOLx48; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762432482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQG0I7YPyMShn1ZWxqGsKjkrUskkpZAfg6mpl32NzTI=;
	b=hMMBk+XV2kUW6cn3KSC8fxqfwMEgwzm0eLghglo+Jl11xGhzUVZgPlNF5i7pDcGhI56Fk8
	MfDVTy7iDDhTSZbzzj3ZFkyx8/yfpJv7skKa3l+RxT4KjuLqHYU/fr56PQ23fkjPb519KK
	2pOntTpAz9s+j9UphqUp8j9hQMiHusI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-rNxzWJGQN4-2Qf16UTA2Ow-1; Thu, 06 Nov 2025 07:34:41 -0500
X-MC-Unique: rNxzWJGQN4-2Qf16UTA2Ow-1
X-Mimecast-MFC-AGG-ID: rNxzWJGQN4-2Qf16UTA2Ow_1762432480
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b72ad85ee9aso30659066b.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762432480; x=1763037280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQG0I7YPyMShn1ZWxqGsKjkrUskkpZAfg6mpl32NzTI=;
        b=YJnOLx4832nQLrEmAI7b39+pwAzJqiURgbF/2xmLE1ihq9N1qU0sAh05jle8BkxdKB
         qqVBDQT+MmzR9cjvPbqGyANHV+Gaelo9ho8mOFM/I7VDLC3n2d9cELw+F+nituCGLxKK
         e8nUCqZKfSDV/xlZC1gbwfxxDXoThCXcBMOk8+ZkNqvLAFvojLmrogPavbXB2Sw8xFq0
         CaFO4RZQhtvZgjBDVlkHMxz1IyhxHTfHzuB9/ap2LHaRlLev8e8d3eF+jXxwlxtDoxRf
         Mj6EtdMUzmN0PEeMbQMG2rE+I7Nd/WF4mtKq9c33V2vpNIj9Z66S4KX7E6LGUiubPblH
         UvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762432480; x=1763037280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQG0I7YPyMShn1ZWxqGsKjkrUskkpZAfg6mpl32NzTI=;
        b=LnUCKU1K5b1zBxF2Op/D7L3VTT8eCNgOSgo5DOB8kjQZ+V4+dJSaF9opLoLYTDMWVl
         oI5uuvtjb6j5AJrVncZ3Mqp2q+2R7KwV1j4Gst27hWOKwfqKYKBRnpsnfcDcguWMquKn
         u2Vi1fGh02vjrYs4gfnUiaXtIhDL9HRNixTb2Cwz00b7dlQnGirIDOig5tpNe4G723jL
         gSEaJnXwGtOz/W4Nm+CVUXvpHdUpzX+IVGW8+e6xJgoJir77vUnmtQnkT4hXSgbVZnFk
         1uT6I82sjKlBeEKjJMt/fQqp8wf1bR8p9z82kkP6rugIeJE9akOcI2uTI+EbvxYmvTP5
         ID2g==
X-Forwarded-Encrypted: i=1; AJvYcCUFowX421xq+HgSGivYqtSHZf+JekEc1H/bnIFPYeaYnjx4S/S0/ASO6uCGe3gQ99Vtmmu7bpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLn6LmO5x7FKlmqdfvjCTYM7rWWSZk6w6Ok+mpBd565XxeSxVR
	s5wQYz4F+oKuOTVGpiJE9SDNn4TEBnSHpbTO6jcUJE+sX64ZZ+4RPb+gWtWVse85Siv9HI09lN1
	OxUKbFbkF1VnMxSoXj3m0lDHXs8KDBPiCOWE+rdcCUQomGE0c11Oe21lsZw==
X-Gm-Gg: ASbGnctgo7ZyyVfVOEREb4//GGcgxJN45FG+I6FR1k0pkVZoQhkO5sCnZCFBSYch7R5
	YEw7zkFHYpAB3FBBXaySnpw1g+FXrjl0r+712ndLtCzNnYl4/tMbmmwTbCeFivX94i9xJiRiihv
	XTY3DYwzftdvhvpLHytOMzb92pPx4jKTpb/SUjh6u0U+rijQHEg0AcIzwetcG0Ll/sswp5AyxIB
	VzmtrZQb5pW+1VD2v5AJbsXXfsSiKsNgnZLDDDe2KX+ZAeHf+uDynDTJypuvgUveXWJgqOcEs+V
	mP5ZIb1K+gNFE1c4PHGMAbB4IXn2z7afxiL/DqTZLi86gf8OuBPrjJkYzQQnSf1Ka8/nJ4Uuhw=
	=
X-Received: by 2002:a17:906:730f:b0:b72:58b6:b26f with SMTP id a640c23a62f3a-b72654dd582mr665486766b.42.1762432479986;
        Thu, 06 Nov 2025 04:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUrc9fXO7+kZmqdy1gEr5plHW60/edHd0GK4nylYguo45A6GR77oMwSudLdLcMBGgaaEPHtA==
X-Received: by 2002:a17:906:730f:b0:b72:58b6:b26f with SMTP id a640c23a62f3a-b72654dd582mr665484066b.42.1762432479538;
        Thu, 06 Nov 2025 04:34:39 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937faedsm204572166b.27.2025.11.06.04.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:34:38 -0800 (PST)
Message-ID: <4c9aef06-cb97-460c-8cf8-d162648e7748@redhat.com>
Date: Thu, 6 Nov 2025 13:34:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] dpll: Add dpll command
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, jiri@resnulli.us
References: <20251105190939.1067902-1-poros@redhat.com>
 <74b77b89-4359-4955-8560-f4284fbb03f1@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <74b77b89-4359-4955-8560-f4284fbb03f1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/6/25 08:19, Ivan Vecera wrote:
> On 11/5/25 8:09 PM, Petr Oros wrote:
>> Add a new userspace tool for managing and monitoring DPLL devices via 
>> the
>> Linux kernel DPLL subsystem. The tool uses libmnl for netlink 
>> communication
>> and provides a complete interface for device and pin configuration.
>>
>> The tool supports:
>>
>> - Device management: enumerate devices, query capabilities (lock status,
>>    temperature, supported modes, clock quality levels), configure 
>> phase-offset
>>    monitoring and averaging
>>
>> - Pin management: enumerate pins with hierarchical relationships, 
>> configure
>>    frequencies (including esync), phase adjustments, priorities, 
>> states, and
>>    directions
>>
>> - Complex topologies: handle parent-device and parent-pin relationships,
>>    reference synchronization tracking, multi-attribute queries 
>> (frequency
>>    ranges, capabilities)
>>
>> - ID resolution: query device/pin IDs by various attributes 
>> (module-name,
>>    clock-id, board-label, type)
>>
>> - Monitoring: real-time display of device and pin state changes via 
>> netlink
>>    multicast notifications
>>
>> - Output formats: both human-readable and JSON output (with pretty-print
>>    support)
>>
>> The tool belongs in iproute2 as DPLL devices are tightly integrated with
>> network interfaces - modern NICs provide hardware clock synchronization
>> support. The DPLL subsystem uses the same netlink infrastructure as 
>> other
>> networking subsystems, and the tool follows established iproute2 
>> patterns
>> for command structure, output formatting, and error handling.
>>
>> Example usage:
>>
>>    # dpll device show
>>    # dpll device id-get module-name ice
>>    # dpll device set id 0 phase-offset-monitor enable
>>    # dpll pin show
>>    # dpll pin set id 0 frequency 10000000
>>    # dpll pin set id 13 parent-device 0 state connected prio 10
>>    # dpll pin set id 0 reference-sync 1 state connected
>>    # dpll monitor
>>    # dpll -j -p device show
>>
>> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>
> Petr, could you please add corresponding entry to MAINTAINERS file?

Yes, I'll add that to v2. I'm now waiting for additional review and will 
send v2 after 24 hours.

Thanks

>
> Thanks,
> Ivan
>


