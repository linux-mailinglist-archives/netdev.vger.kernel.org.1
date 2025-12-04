Return-Path: <netdev+bounces-243548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F14FCCA362A
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2A2930263E8
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734B92EA178;
	Thu,  4 Dec 2025 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLcgvcWI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwSiACeD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B102D0C92
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846558; cv=none; b=kQRxok0oZvG+2ko4sBqpOZGA+c5O7zAOwZvRx2DHc8vS0lwv7PgZnX/QFD3WjtyDy8exfbmAjVlY1qX/RWqVnnBjxaBlHDw+nySgO7kj1o4Q80PMdoF45VT7CkNDitpsFGBFgY5sDsEnxNeY5e6iPf2xqNIvoQyh+gs6edQUteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846558; c=relaxed/simple;
	bh=iEcJS1ImshZ6zlxJ5JYGXmza23VWEf3D5XGgBdYeHbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2AgmJ1R/S8ABcobnvWF2Ixk+qy2wVMA8dAHF8ugdu1TM8UAauJMa01ZiIH+AQxjKABLeGpMVDBZ1zpPey5JXZdpd3NXnAhT3vWbVwImxiJBZrEUtMhuirumOCDSn3kmScj7eTNX8eejK0JDJZLAO5mjQWEq2yPRl9OY1MUZnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLcgvcWI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwSiACeD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764846555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T82ZSvq1AhTv0DjkR4v78xLPKykCUc2Mvpo6gNcCnXU=;
	b=JLcgvcWIxDgojAutaNFVnqh4jpC1a5YPdb8jZ2JPsRE1bVhrnHAFrOx9iZ2BhvaoHT2lgD
	WqSyMTBR/Bw6+W+HgvV52xRQtBDzIAnOHlw27UbKgVPK+SbcDeNnB6w0i9LCbVCK0ARjan
	FegSoguMqywBaUJXMee+vK+8uRWT8t0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-nk8W8XVPM2uASxkz5PnVhA-1; Thu, 04 Dec 2025 06:09:14 -0500
X-MC-Unique: nk8W8XVPM2uASxkz5PnVhA-1
X-Mimecast-MFC-AGG-ID: nk8W8XVPM2uASxkz5PnVhA_1764846553
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42e2e447e86so453891f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764846553; x=1765451353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T82ZSvq1AhTv0DjkR4v78xLPKykCUc2Mvpo6gNcCnXU=;
        b=OwSiACeD8ounek8OQuYf0PMTi7e1BC7atDD9N3Bl6h8rkY5mdFbf1/f8Un7gwplO9N
         QdQW300HZes3jmbifvpkNdneravTzXKH6fHzRmlfh7+zGrZb3jPM5R2LpmhXCQH2Hunb
         bNwgmXhVU01npAuQCooSanMViwBUUoxN45wNplxdV0U37Dzx03Krtm0z1xCV9ahdJmGx
         6FMzOr2l6rL0P2T81PS8zYikJb8OzMLoL6peXm2glRrzG5HhS7dY+5EAc9FtOl5I/bwg
         ao2KTwaP4+pz6Q0X/Dwa1Cy05GCTR4JSgm0FbAiJYNY/EvVUCUMt1lH+1kaPDQzdcKeZ
         elMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764846553; x=1765451353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T82ZSvq1AhTv0DjkR4v78xLPKykCUc2Mvpo6gNcCnXU=;
        b=VRfqCWDgk80G10gtBA40EQyJSIoLELjw6dm0ZHjJta0T/jmu1dJrE0beri/uKmKchn
         cX4Qyuw7hJ8fEyHBd0UjMxAUI3PQBY4DAbYZV3wS4BSh8vHjbjJhFStZrmGXHNV38ikZ
         UNSj3T/oi/C4Qh0p3EqN3zi43MoBWOzoREuxQlKl2MmXfkddg3ofxVf8pFZnniIH8pDp
         4pWfemP044TknDxKuOw3x7QO0BvD7WH4xbr8MrQI+LySmFMh68qALLIkIgWsLzKTDiSo
         jaqTkn3GvOrhnRxUl4P/rnPxNoUkDoxgkUATmt6AV56pN69rni5zZTHcfxhVjMM8zisA
         V+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzQubBvvLg054mtoczWPJu70nA0wrjrf/EsRj7cDT/vn+qbQAN9uzUZGxFKtSwZQeM9wp0l9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1cbK36OuTRxw/+RJfg7NTklzzuqA1GoX7Cu4r/pEJ5hoV0G7
	wDL98RXw0J4Uqy97dgI5d9aNpDlW+1JpGB6IphicwjHQC+rKQCFLtn0hc/oIxKRgPXtLHGQhw4O
	O3UezLGo0bRU6hprxaA0XzkaivQVxL/srmsLYI2dpdFdNftG/LMKg+EHc5Q==
X-Gm-Gg: ASbGncuQ5fdY14NfWYQk6o2G0TSPtsBRM536MgkL+UgyUYzqKdj3hNZzKU84mkXw598
	6ZWIRCYn1P+FqewpQqjm5wgDuQ2EBdwSNPrWvKHoI/DpJA6D+VdcKMdkdvrrGRjwNHtoc6P7olS
	VkIn65A61hQ5wuvkX4pqpgzojfJFEAjMbm6uN/emtocc5ydN/R0TSs9b6Ce4Je8147sVm2AokRr
	W4G4IDhD2+30d2bOtgNo2lakUGrSvu+Di6H+oujWj2L7w50yTvR93Br46GEiigJz1HpAOSdmd6o
	U8MlOqJ9gWTye8aJuDjjAXPPVztpTZBI+UubKmFKoC5u9Dsf2CkUP/lGk/oTd+Y6/WtjyZm28h9
	KWm0OyGHQMW4t
X-Received: by 2002:a05:6000:4011:b0:42f:760a:764e with SMTP id ffacd0b85a97d-42f760a79b7mr5483743f8f.32.1764846553317;
        Thu, 04 Dec 2025 03:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb4LHNT7hjSXHvt0Jn7DaTqIpQKrsWbA5DyirMeRYRCFtGpD+XfXdyxr4Htp0h2I3WX4xOjQ==
X-Received: by 2002:a05:6000:4011:b0:42f:760a:764e with SMTP id ffacd0b85a97d-42f760a79b7mr5483700f8f.32.1764846552842;
        Thu, 04 Dec 2025 03:09:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331e29sm2704209f8f.32.2025.12.04.03.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 03:09:12 -0800 (PST)
Message-ID: <de13a729-f590-44e8-8177-68bc43809048@redhat.com>
Date: Thu, 4 Dec 2025 12:09:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] ptp: vmclock: Add VM generation counter and ACPI
 notification
To: "Chalios, Babis" <bchalios@amazon.es>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20251203123539.7292-1-bchalios@amazon.es>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251203123539.7292-1-bchalios@amazon.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 1:35 PM, Chalios, Babis wrote:
> Similarly to live migration, starting a VM from some serialized state
> (aka snapshot) is an event which calls for adjusting guest clocks, hence
> a hypervisor should increase the disruption_marker before resuming the
> VM vCPUs, letting the guest know.
> 
> However, loading a snapshot, is slightly different than live migration,
> especially since we can start multiple VMs from the same serialized
> state. Apart from adjusting clocks, the guest needs to take additional
> action during such events, e.g. recreate UUIDs, reset network
> adapters/connections, reseed entropy pools, etc. These actions are not
> necessary during live migration. This calls for a differentiation
> between the two triggering events.
> 
> We differentiate between the two events via an extra field in the
> vmclock_abi, called vm_generation_counter. Whereas hypervisors should
> increase the disruption marker in both cases, they should only increase
> vm_generation_counter when a snapshot is loaded in a VM (not during live
> migration).
> 
> Additionally, we attach an ACPI notification to VMClock. Implementing
> the notification is optional for the device. VMClock device will declare
> that it implements the notification by setting
> VMCLOCK_FLAG_NOTIFICATION_PRESENT bit in vmclock_abi flags. Hypervisors
> that implement the notification must send an ACPI notification every
> time seq_count changes to an even number. The driver will propagate
> these notifications to userspace via the poll() interface.

Linux tagged 6.18 final, so net-next is closed for new code submissions
per the announcement at
https://lore.kernel.org/20251130174502.3908e3ee@kernel.org

/P


