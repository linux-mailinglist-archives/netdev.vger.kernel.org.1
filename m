Return-Path: <netdev+bounces-223545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AEFB59771
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933FC1BC6C42
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53382313278;
	Tue, 16 Sep 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioam/oqf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703F30DEA5
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028982; cv=none; b=i1+udqtYYFvlp1DUGAP4x9Vxfo6zSRW4Yl+BnIJDRxg85U6AWnnExWLTsIesS83gmTHQG1fgPgVPA46ACf4ZMRAMvBuvNOZD1L5CIXqUxuMIzIC2N4t15BKc4EaHesyJ3QyO/WHHt1ma3d52/2kp4siGA0hU43Nx3KBbTo6Su/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028982; c=relaxed/simple;
	bh=1IguQoOXA8FrFKBeUbtVgSy6pYqlTs5cyzQln/TF98I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jFIUYYrq7XzG60Ay9+xi3zoiy1+bZDj4wf/BYBSOcSUn+HycDnmee2JW2vTEAu7laUh90dMO2lf1H5LnAR0CIr7tEOANgpefwppQpf1iIdV5bkx8oTWjf9lRWz/agOFtYaodR7WJYdXtjbVU6e96kN4U2ijhouKsEIl/f+axTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioam/oqf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758028979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oP4iLXlqo17dgLSrgkQgZcHvE5Do89KtwinnL3mfgo=;
	b=ioam/oqfK9PWUJUcgXrzHoH2jakDC+YhJHx5ffPzIvhSaSCNv6RNjCgeyAoh3ZBG8K16te
	M02DRFvSou+EstuGZX/AnKpJ1s6Qx4yxxzuYHKPzXiqq/+3WKjm8/Ch9Nm6wDazcdoBCzO
	hAarNXM9nMgRYnmKAnMbYEs/aNYd58w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-n0Ocw0-gN4CMNzv58ofHJA-1; Tue, 16 Sep 2025 09:22:58 -0400
X-MC-Unique: n0Ocw0-gN4CMNzv58ofHJA-1
X-Mimecast-MFC-AGG-ID: n0Ocw0-gN4CMNzv58ofHJA_1758028977
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e9c932a4dfso1276645f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028977; x=1758633777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oP4iLXlqo17dgLSrgkQgZcHvE5Do89KtwinnL3mfgo=;
        b=LLFyta/nIha67LdHn4+n1IJv+wJxsT4RkNSuSQKsW7smvzKE+SWF1aPBJgvqjUegM/
         UXuX+ebO3uX0L9bu8BILI5ECiVsLEReoEJhleSV73aizPRHj4Lx4IRZPvvB+3kgtunFl
         XLeMxTRnWpecZhX1oyI62Q6zj5bUVCS9RmNWY/LedyD4HopV+ay8ZzdqVeWo9/8mmxsA
         HvfGNcX1jU19gvcbFEuT0tuGH7MHDgyYXmEUWsutsSu+MjUAI9OTqnXGk5iGVqzJlY6J
         6wBwwa1Y+Iv0Vs32ThBNxLYw1SG5l4Cjjj/BfE7mtsvECgXOua9PyiswQq9jmbpaISVV
         P/pw==
X-Forwarded-Encrypted: i=1; AJvYcCVGBOxGB/P/SoqPzW3D4aFx9r2uAng+2yNs022dRVRuQhgC/izL2CbU/9JH/NGX5KKlXfT9fHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rxltx2VyV8iJnM4NSZKyvVXhGj3ieV1mjb82AzNOXvSdtrIA
	43T8E053u1jRUeFDgl/7sQEiyuc7pLhZgYyH5XigUOHbrfkZtKr2JlA2d8qgIB6hkpFmMuQq4kT
	p180BcHhtIHy6clp07Ffa2rXEJhb0qk8eZB08c4XlnSbsIViA3LEOnbnK2A==
X-Gm-Gg: ASbGnct0OzAANHk/p9PYtJqEAbqnrEIW4Gf6EbE9tSP9Bb037i5FhMc7M3nbhSzwN/A
	yLN8w86XT38qswP2CV4vIfwwNtj/w187XqSoZdxpvBjCmfdpdb6EzT/KrAQxhZNAtgp3poUVJgf
	V9Y1WnwMz8FwpNbJ5AH1FiWSr3IovypWtusWPaakJjqyg/AKSeM4izk70E0J/W1+dm3BvUFVf0w
	uSsa+22cuy34yiGzcrVW7858+zQAyVEGeE52/b2GjGb/rBOSqpLDs4J0h05ntXu4Ti4fyf9EBMc
	//8o2AB2Vn3lKpwubHiqh0Tek1kZ29yOKV+KWw7H7e7NYm8ZGqIl0o7Cae6rrse8pZKyg3o1Hi3
	mplzCrZCdylNO
X-Received: by 2002:a05:6000:1a87:b0:3ec:db87:e88f with SMTP id ffacd0b85a97d-3ecdb87ebbcmr933085f8f.58.1758028976912;
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ZY5gUmJ119iAt2SKTgVZxX4OPWSH9fLEx7WX7rL1qK5MveunydRadRnPWxfpxv4RDz+i+w==
X-Received: by 2002:a05:6000:1a87:b0:3ec:db87:e88f with SMTP id ffacd0b85a97d-3ecdb87ebbcmr933036f8f.58.1758028976410;
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e96dee54d8sm11914722f8f.12.2025.09.16.06.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:22:55 -0700 (PDT)
Message-ID: <0b5b0d1d-438a-4e41-99c8-a6f61d7581b4@redhat.com>
Date: Tue, 16 Sep 2025 15:22:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: mana: Add standard counter rx_missed_errors
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1757908698-16778-1-git-send-email-ernis@linux.microsoft.com>
 <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 5:58 AM, Erni Sri Satya Vennela wrote:
> Report standard counter stats->rx_missed_errors
> using hc_rx_discards_no_wqe from the hardware.
> 
> Add a dedicated workqueue to periodically run
> mana_query_gf_stats every 2 seconds to get the latest
> info in eth_stats and define a driver capability flag
> to notify hardware of the periodic queries.
> 
> To avoid repeated failures and log flooding, the workqueue
> is not rescheduled if mana_query_gf_stats fails.

Can the failure root cause be a "transient" one? If so, this looks like
a dangerous strategy; is such scenario, AFAICS, stats will be broken
until the device is removed and re-probed.

/P


