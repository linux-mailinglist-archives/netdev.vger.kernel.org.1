Return-Path: <netdev+bounces-205828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307CDB004FE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0233E165662
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805622727F1;
	Thu, 10 Jul 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sj+3OTJ2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021E24677A
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157239; cv=none; b=lvJPh0L1MyKadkkNSsp8cRjtAU6lJiI1BKEtNeufquEOdKjbE+oK+oWRnP8yJmAjmKOl6vjhJjHvRJ0yEo1QcdvTGvjhSnpj7SosqSC/nkKVs74ocFvildGjCQBwE7gwdrWYTX6nLI8ohghSGLLmW64OQYuIFBVy2p9QhQm03/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157239; c=relaxed/simple;
	bh=H+W6MZTGTC8b6KoFGEsXhh33XmcZnNEGn+9/3uzcB7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQZg5UtpQ3NBJi25U44YlGGTPbr4AhfBtnhKF6wV14gJP2ceP8mYCDnA5kanHEqedOe8iBvMUaUguBYNsQlZvkcQLCnno0Sc4DoygDmoRO6nY+X/RaywkD/tp/pFHvwwV+89AsnX/v+4nIvOkT8PsLfYWStAI7IUdXjkEc0FEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sj+3OTJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752157234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dg07EnLkF7vG0n2UhzEV54yOcgWLfRsNgXzhWHq/zf0=;
	b=Sj+3OTJ2sEQrTJq99Ca/qZZHT7nrRi3dXqx6YDAsN2zoSUVunhBmebYG8y8Ez56bWm9Hho
	S8rgEkMquVnGH8JAxoHm6bUXZJNAfc6NvqwZ2N1JNFok7TJ0/BrdWs/sXBqyl7HbJOxFjl
	DiVs6/6izq6EW0aktcHifYSKtPZCIHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-EcbbM2qLOVGAOYYfoleNOg-1; Thu, 10 Jul 2025 10:20:31 -0400
X-MC-Unique: EcbbM2qLOVGAOYYfoleNOg-1
X-Mimecast-MFC-AGG-ID: EcbbM2qLOVGAOYYfoleNOg_1752157231
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a58939191eso579360f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 07:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157230; x=1752762030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg07EnLkF7vG0n2UhzEV54yOcgWLfRsNgXzhWHq/zf0=;
        b=gn9d3P6e1pVrzxQc7ur9XKU2el+i2Om3FPQk3JC1a8AMQwKNwjRXLGjakb+G5jZbfc
         Oz+mNI1QJdCzq01ppozjv9gpE4zCysjhoR7WKSy0q7SByIx1TP5FnkXvc9DwXNZYc3+k
         tr9zmGmyj+WL2xi1vO5BTwVxLo1EuPywrEsrIBwZWdtoApOY5AgIrYwG+khTA1rHmmoi
         OwJ9iOi6LGcRuEGLe/sHE66a8uiZ+nnJ+IVH8Onx5EdGYI232r+vYtwys3cocRV5cgr9
         Dd+u5D1XEdc8pFm/0o8NdWpGJW7w9+P8Sk/ak1wFCJsHWz9+BjPA2vWoTRO7/3tate3N
         o4+A==
X-Gm-Message-State: AOJu0YztjBLwAeufVbAwHJTjGeZUdcyqJIgPOsO35rZ/RPc42XFtktMU
	cHPd4F5lroB1F9/oTM9AWGYZ3R4PJsajkY6u+yb09EpNoVdk/iX1temhfnCtEsDWX6Qce8xDuhW
	sIUXxulpKMJXnEWa3nUnSM+xZQ4ckZjO2NuZn0UXQfDV60sIjFjSBhfNqgw==
X-Gm-Gg: ASbGncuyEQigQwTRQ9osF49tRpf38wMspcgWz6N/pO3DAvbGFfxtyksDYvapEyWfiZL
	Sd9aGFJn0mar81UR6uf7dQ9rWXumdDJ4/EGSXyay3wq4Oj2/mSaEVn45mHLR8scVO4kIGU1nS4j
	UPOp6oW7aYnZPoSNYOVBA9xQNaLEBpMsyeKrK7tb2Ap6OZt1WCYSxM7WVMEVmPfxjxIARNzjxjb
	okLhM/rFMWmffd+fj8txE9vHrMH/oCmA8sQrDmIJAn3flwm9G1KjblkfgGzSCneB+Bzx5bbhRwi
	4+jLc2SqFzKQq2dbs6rUiKdOHLwqsudbGz7gmXmvUYjQB7zIXEnGNSLfixSStoLZRSaoVQ==
X-Received: by 2002:a05:6000:2b02:b0:3a8:6262:e78 with SMTP id ffacd0b85a97d-3b5e86aef04mr1845872f8f.37.1752157230442;
        Thu, 10 Jul 2025 07:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5MHh2lSwM1tMKcl0R4d8xjkyF+DWuQplkQGUz9oznluhkOT987/Wba+ND/eSCOxhnDHbefw==
X-Received: by 2002:a05:6000:2b02:b0:3a8:6262:e78 with SMTP id ffacd0b85a97d-3b5e86aef04mr1845849f8f.37.1752157229948;
        Thu, 10 Jul 2025 07:20:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1f4edsm1969234f8f.83.2025.07.10.07.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 07:20:29 -0700 (PDT)
Message-ID: <0455186e-290f-41b5-b2b3-78d5bfa2b74b@redhat.com>
Date: Thu, 10 Jul 2025 16:20:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] net/udpgro.sh is flaky on debug
To: Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
References: <20250710070907.33d11177@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710070907.33d11177@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 4:09 PM, Jakub Kicinski wrote:
> net/udpgro.sh has around 6% false positive rate on the debug kernels :(
> 
> Please see:
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=udpgro-sh&ld_cnt=200&pass=0
> for recent failures.
> 
> Is there anything we can do to make it more resilient ?

As most failures happen while waiting for the 'following' packets in non
GRO scenarios, a trivial attempt could increasing the inter-packet
timeout (currently 10ms).

Something alike the following. I can send a formal patch, and we can let
it stage in PW for a bit to observe if it actually helps.

/P
---
diff --git a/tools/testing/selftests/net/udpgro.sh
b/tools/testing/selftests/net/udpgro.sh
index 1dc337c709f8..43fcd4b0f6a2 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -48,7 +48,7 @@ run_one() {

        cfg_veth

-       ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10
${rx_args} &
+       ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 100
${rx_args} &
        local PID1=$!

        wait_local_port_listen ${PEER_NS} 8000 udp


