Return-Path: <netdev+bounces-192556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F47AC061A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E671BA0824
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0323F424;
	Thu, 22 May 2025 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxZTNZm5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9D23F421
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900170; cv=none; b=p+b4igJjtvqWimXv7bgMm9ibZDePWv/oGrCoiLXFog3dwWxCLxLij7B4g8jacCKYbERiEdSCSPhwAgR8Lw3RmLlphVvBWY4N27u1htG8YvtVbChrCgg7fHElKSWZlld+r/h/ekZdgcgEIYqbUAWbQVuA3YKupDto0L7nelX3PpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900170; c=relaxed/simple;
	bh=VirzS6sOhodeyGzpkHe7BXTTRXdq56nElnl5g9s9QFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXQVbo3e0/3wASJeyP1GNjzDTRMwzh0CsoxJsV0sliFJRolbv074nWhdqyIjAxWTuTd0/E5a6oQxfzn5NHEqfx71azloxjXG49pAU+vMC8fvPL8zqKHwxdpTespWlUBPtnSTAdZmecEc3dWr15lBPKb2EaPcIL9HJEDkCeXTtUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxZTNZm5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747900167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gmP2k89etmj0Mtdd8SDG3LT/MSQRKGivNj6KSCMQ3U=;
	b=cxZTNZm5VdKjfvma3iURJW/XXcz7W5QOeVzxDMXmGW2wFtLHk5tG11lOrMCLeqZaTQ2Xv0
	xyQynl8W7BrzV/ZqL7kWIbKwxi7MMKrKfPGYYV9t9fuLifS4/aauh8B1C5CxnDRj0Mcr4f
	UBW2eS2b0Rzw8hbIXC2EsE+AO8BxPbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-t-tilkSbNgSWNp5_3pJIVA-1; Thu, 22 May 2025 03:49:25 -0400
X-MC-Unique: t-tilkSbNgSWNp5_3pJIVA-1
X-Mimecast-MFC-AGG-ID: t-tilkSbNgSWNp5_3pJIVA_1747900164
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a360d01518so4735723f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 00:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747900164; x=1748504964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gmP2k89etmj0Mtdd8SDG3LT/MSQRKGivNj6KSCMQ3U=;
        b=dqnSEbGRqE5KyueYLMWvr15p5Vqyi7JtICVVa/fqozWg+WMleChlT9zR2prRStLB5R
         lxb6FCBVphk1IOOwceIc0gc8w32aA8x1Atth0BtfRyw+ow7KyJyPyG1CV7MHtNH6wvXy
         wS5B6JSS1jWrg8R+WUWPiVc9hT36uzj6AmCEtBA0ro6RK7U4zTAwdUh8OmQEWN1dOWpQ
         pbzkDukTHZbQ/WxpHGbagkMrIsxVa4GF6wNaXXkp244H/8Gw4npkwI5FFEw8gzbUuh1w
         X7TqoO+LfK/ykPZuYy7Z1eC42wK4sTPAMCEGd2SUEaGvS4mr0GjSKd9cxdW2tfKB3pTq
         oBwA==
X-Gm-Message-State: AOJu0YzdapbeQ5j9j3r2prfb7mmv8YiQyyROqvKOdf3M3SVclJzoh6/C
	bQjU7Hb0S/PpqQO95AVplCkIHNRWGpukLrQ7fJgkH6oulUfaW/Kv+bTfV1dXBA4Y/hbBeQ2I6jj
	VYcQ6tvN321TqZmyG1lHH+GoJ12svmSDYOkCKgT7rNUjlnVC20JHYZP2pxw==
X-Gm-Gg: ASbGncvLzjZhOXum++lKlghuT8mNbDb5Mpa75zXGXwAv4li2vjwf/mnHmHBTunmqzuu
	zZ1bd6SxecHN1JQBWD9CVYX3Ots7KshzU/HUL2HV27I5oCwZTeHkqVAHQXxxs5UPDO05S+4YYDK
	HwzaYhHF38jw5WpMY4Ji/27T3wMA+AvpHtlGGTjyX0ht+jdAXCjo3byiy6/1p2ZwvKo1A7d2FEA
	OQATXyiWMGAHcH6MAy55woXRD1rFF4iO6B2ddn2ygOhQx9XZPtgiSEH7DBz/u1TMGUQ874Cre1U
	HY9o/ywtUQaZBk0zmIo=
X-Received: by 2002:a05:6000:2407:b0:3a3:4baa:3ea3 with SMTP id ffacd0b85a97d-3a35ffd2ae4mr20058107f8f.41.1747900164093;
        Thu, 22 May 2025 00:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdvbJcHCzple+AOhQzYIbjiyobclI0Xt+rWg/pjSV+dduoQapQeRg9aumMH3q/kdA4KAxw0Q==
X-Received: by 2002:a05:6000:2407:b0:3a3:4baa:3ea3 with SMTP id ffacd0b85a97d-3a35ffd2ae4mr20058083f8f.41.1747900163744;
        Thu, 22 May 2025 00:49:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5bd80sm1398190f8f.38.2025.05.22.00.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 00:49:23 -0700 (PDT)
Message-ID: <9e4b56fd-425b-424a-b89a-57d7efc05a30@redhat.com>
Date: Thu, 22 May 2025 09:49:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 08/15] net: homa: create homa_pacer.h and
 homa_pacer.c
To: John Ousterhout <ouster@cs.stanford.edu>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-9-ouster@cs.stanford.edu>
 <a6b82986-52df-4d51-b854-a2eb5842a574@redhat.com>
 <CAGXJAmxbtj7x78KYNBWoZaCHbOf39ekeHQUX2bMZsipXUCau_Q@mail.gmail.com>
 <7e177e94-24cb-4090-81b9-d82b0c43a37d@lunn.ch>
 <CAGXJAmzfRJWv7tsw8jq-jR0ax3noQ9jMJEAkdtF8uki6DVDMzQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmzfRJWv7tsw8jq-jR0ax3noQ9jMJEAkdtF8uki6DVDMzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 10:46 PM, John Ousterhout wrote:
> get_link_ksettings is what I was thinking of. 

Note that dst->dev and the actual egress link could be different. The
first could be a virtual/stacked device or many kind of redirections
could be in place.

> Some of the issues you
> mentioned, such as switch egress contention, are explicitly handled by
> Homa, so those needn't (and shouldn't) be factored into the link
> "speed". And don't pretty much all modern datacenter switches allow
> all of their links to operate at full speed?

If you mean negotiating the link speed, likely yes.

If you mean actually allowing the connected peer to send data at link
speed and forwarding it without packet loss across the switch, no. i.e.
if 2 or more ports are sending traffic at full speed towards a 3rd one :)

Side note: please avoid top posting.

Thanks,

Paolo


