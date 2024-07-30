Return-Path: <netdev+bounces-114194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48F941486
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849161F240DE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA91A2569;
	Tue, 30 Jul 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSvIglSM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB519DF41
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350239; cv=none; b=DXS33v8ZpY7AUT/3FZ/5sy3dsiDJfEiX3EiLGsIs/IoR6wlGwyE59jWtIC+W5+OF/PS1Bp1aZFE9xxe34iSChoz1p2WRSaCwNURLC8J4pu3rGUM346A9T4jIOHDA9EVi/SUQLPuLBxx878wrtoqxlITureRDmgfuUCd7uP2DDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350239; c=relaxed/simple;
	bh=2220mRmsBdPbnrlH0O3ngRVroC/gqpFoARwG7spPtF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz71/Ism4mUn3+tMMxJyL5HLY+QimV3UPbruGVnY6KQwD1EZOCwqUCdY3N5mqhATyqgQDj4f1TyUd4diGEMfN9bsOKRTNfQ04jtAdZYTtEGIBCI7OAbLVrZLF3Fy+5NJOD+3r2tyHiFlIJAac1tyvE23Oq+ayhAKbSTK5/b86bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSvIglSM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722350236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikljcTHexIDBMyNR92pUQ/YO+yhTveDLqi0ZIqDt33w=;
	b=bSvIglSMVIZEXGDU2CX9Zx3etcvksCZW8yMOyFZUEJRxkJUgBaLgmFzjoIShV2dhIOn2Ym
	YktmwvX+ojpNMkXdAlaZoESFlb2xSknGsGYOMxCg6tvW/fb+ARbWBfKmllmMEV/VmCi9kI
	Q0TR3yz1P6MSlFWEVj7BJah2XxiNzQA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-7ReOMslxM8WChveBpp-sHQ-1; Tue, 30 Jul 2024 10:37:15 -0400
X-MC-Unique: 7ReOMslxM8WChveBpp-sHQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428087d1ddfso6746325e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 07:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722350234; x=1722955034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikljcTHexIDBMyNR92pUQ/YO+yhTveDLqi0ZIqDt33w=;
        b=eGlEHhpxhOIFphP7VPr41a+pMwMy+S0Jafl8IXL2MO8oZXzReG0vqFQ7TwquhFL94b
         qElA/BPQoa4N1oeOCDYNEz0SrzH7Pkg1WHw7SIw4+vJrdKOG+pJjIY2aBL7DQo73+8fo
         Xoz5sBmXfm8aIOrGrnk82wRZ80xTm1G4HbGbeJdXL9ms6+R3/8S/QDmDwW8KvQKeB7P2
         R5aEuZtnSUnV9EH4aQJsxS1jZNGJg+F2CkRVtF8Q34I8snfxNKv4TEkJQVTZgy4h8C+J
         FkYZNjxmWcENSQ/L9A6x18ahTi4nSm6pZOtRmvLeK6bsD4RLcYyB/72j4T9NxXLG1XNW
         d+MA==
X-Forwarded-Encrypted: i=1; AJvYcCXUNY8hhPtc/O9FPALeIFy/M5ZkUqdyv1BrWZw+DPQtEIn+dnDawZHzyELV87zPkaBxffqGT70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6rUMyZ90seIgBouuO2oPq2ltTb1QwtWNSqMLqHFA9f7PIdPs
	DVtLhwB9hO3o8hpMflS7k6OMUkAKarhQC+WpY3Dq/nF6RDi+GoHqijqPq48Lb0PThQQsarqNcEB
	clvSW5dhpkR38LvM02Z39OLerRy8nobNbglstTpMc0jS3tIsrIkkcrQ==
X-Received: by 2002:a05:600c:1c2a:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-428053c9004mr79505765e9.0.1722350234010;
        Tue, 30 Jul 2024 07:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGjutbFZQsLRkFpS+PdV2H7EJeGf8aKRgk1uyh7gUQm72atjOR+MfaZHQlc7AFes2qCJ6LPw==
X-Received: by 2002:a05:600c:1c2a:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-428053c9004mr79505595e9.0.1722350233418;
        Tue, 30 Jul 2024 07:37:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42817d2d29esm107198425e9.35.2024.07.30.07.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 07:37:12 -0700 (PDT)
Message-ID: <16add5c4-b1c2-4242-8b71-51332c3bae44@redhat.com>
Date: Tue, 30 Jul 2024 16:37:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when
 debugging
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Breno Leitao <leitao@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 leit@meta.com, Chris Mason <clm@fb.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240729104741.370327-1-leitao@debian.org>
 <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
 <20240730105012.GA1809@breakpoint.cc>
 <c61c4921-0ddc-42cf-881d-4302ff599053@redhat.com>
 <20240730071033.24c9127c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240730071033.24c9127c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 16:10, Jakub Kicinski wrote:
> On Tue, 30 Jul 2024 13:15:57 +0200 Paolo Abeni wrote:
>>> I was under impression that entire reason for CONFIG_DEBUG_NET was
>>> to enable more checks for fuzzers and the like, i.e. NOT for production
>>> kernels.
>>
>> I feel like I already had this discussion and I forgot the outcome, if
>> so I'm sorry. To me the "but is safe to select." part in the knob
>> description means this could be enabled in production, and AFAICS the
>> CONFIG_DEBUG_NET-enabled code so far respects that assumption.
> 
> I believe the previous discussion was page pool specific and there
> wasn't as much of a conclusion as an acquiescence (read: we had more
> important things on our minds than that argument ;)).
> 
> Should we set a bar for how much perf impact is okay?

I think that better specifying the general guidance/expectation should 
be enough. What about extending the knob description with something alike:
---
diff --git a/net/Kconfig.debug b/net/Kconfig.debug
index 5e3fffe707dd..058cf031913b 100644
--- a/net/Kconfig.debug
+++ b/net/Kconfig.debug
@@ -24,3 +24,5 @@ config DEBUG_NET
         help
           Enable extra sanity checks in networking.
           This is mostly used by fuzzers, but is safe to select.
+         This could introduce some very minimal overhead and
+         is not suggested for production systems.



