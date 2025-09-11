Return-Path: <netdev+bounces-222159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA5AB5352E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE233A97BC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63D6326D51;
	Thu, 11 Sep 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpZvaU7r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD243064A5
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600666; cv=none; b=f0wlIbWKfftF8QNKXGVuHruDUpsbR9emooDSkJ8nuNN7uATMwbvCqYlokusRiO2uDHX3hCZgRpj7rllg1WexXQvriv5EoUbXTk0IFKHvPfX0jVzqtqHB8dPnRzQBYOzYR+nxV7x3jnXVWnS6q0BUyS5HbXAnCm4SjQojtfqoeZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600666; c=relaxed/simple;
	bh=Y6a/86+wjytTrdNd1x/+Y3lFyfNxUHDS/sgjqthX3Ug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MB81VxweTy8UxAzMWQZmasaCK3ZNZqOaX77YZWePJnkSRulBw+cSSsnEWLaPuIwVFbJYbgvSbO/PuU8HqHvqwGY8j7LyBrHSE5YBMFYYqYI9YpQoARrM+uHy89gkc2eAjteZmlc+TQsn12t907zVOp5eL2NXFNYWC0yTklYOTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpZvaU7r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757600664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHsNAGKvOotxj7lLw2vsOxsdCk/iz2T3/ZLVYRgdaOw=;
	b=bpZvaU7rTwqjv8WCdTNQEQCovL15jQvr2w7cD2xj1SlSitphZE34rHdrhJqx6OaX+TwokC
	G5lnSthpfKc1+boK7djkJEypoe1oCdHWD7Zm+P91CGMkyE048bYAz6HeYiHWhlq6OSOUgl
	7SqzLBZBBf8HgW/fOKpZXb768J5pZgw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-1L_HhCAhPKe7trJ0Yu9xew-1; Thu, 11 Sep 2025 10:24:22 -0400
X-MC-Unique: 1L_HhCAhPKe7trJ0Yu9xew-1
X-Mimecast-MFC-AGG-ID: 1L_HhCAhPKe7trJ0Yu9xew_1757600661
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3df19a545c2so591698f8f.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 07:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757600661; x=1758205461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHsNAGKvOotxj7lLw2vsOxsdCk/iz2T3/ZLVYRgdaOw=;
        b=hogD9wIkxITtYxDhpKgzf080OEPGPssAB+FmDpNEj1OXWNN8pvz4G1b+npzVlm1h2j
         t+lLDUYkn+vDufzt3NuFT+z0EurU8yMeBOK2P7dgn2UzWGc1sZ8DoE7lnGZCbo07GZbn
         5qpm2tFErkSoAYMvqbyy21YL2MgYqEfX3pLEpeUKfO7t81WTHINXQh+X5EOOsMNdcAac
         TeoE+4B7QUTFTqmlydr6FhcgPWRFdozuaExEPsvWuHOV97Bs4D54z11PjoOfz5PIvCx+
         XWsetvusxZM38ggqiInBkpZK7coZH5uFWr880AJHappKToVLM/NC/lrNsCBBBspl25K7
         URWA==
X-Forwarded-Encrypted: i=1; AJvYcCVvCUfC9UIYRG1FbjFBOkcTdz2YtCc8jS9CDBS3/2uONWaHUPM86fAOntVjymQxc/DwLoiSq0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6iW9CcrpPI5WI3D+uBU/qi0OdFcYUwL6wgK/8wXvcGHKHii6
	E0wHiHhATg6MG29yC289TdILlbrBMrXTQJG9XWIzBPUQknyJmKXv66RKVO9aHTM2LHfYFziuHFi
	8c2rpDkwDHI0UPj+9wyXyYBIpLDuQxZ7HHujkNrUqFmDmapwt+iYw6Ys4Vw==
X-Gm-Gg: ASbGncsuZgicW2W8u8Q6c1ZbNTWkbbyQpCjf8AiJm9kVZN+6cK7cp3rpKFrcsrJluHv
	BOvg5RaGUj8o4xrxppquTwm/k7WgxUizwsdjSbHeEcYfhzPFTxqIL4x0YanP1XoIJ1VUNGIwMu+
	0DGK1QC66uHz0ErOwDnfZcb5HtPktuL9uQYeeta3YoV+lv72KYlf2+e1NMoXQ6xzuwarSNnuNBQ
	1B7SFqQOda7nRRSM4NbDrtgny4B7qKIjdeXvWKAKKjv3bk5bAN+ld80W48nLFIx6Z253KjjNw02
	Z6m+8XpzQlCQgxLuxb75MAAdm8w9vixnkR342g20agM=
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e741ac4939mr10290875f8f.55.1757600661474;
        Thu, 11 Sep 2025 07:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9vOlqkWFXwoDUxcYYpXeQRpsUkfeWLqOyZ0rHn85FAwejsWx3SKbDB72PCR7M/2FZa6TABA==
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e741ac4939mr10290856f8f.55.1757600661007;
        Thu, 11 Sep 2025 07:24:21 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372aea2sm26368435e9.7.2025.09.11.07.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:24:20 -0700 (PDT)
Message-ID: <45cd5086-193f-4344-a5f0-78dde71474d7@redhat.com>
Date: Thu, 11 Sep 2025 16:24:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.17-rc6
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250911131034.47905-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20250911131034.47905-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 3:10 PM, Paolo Abeni wrote:
> The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:
> 
>   Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc6
> 
> for you to fetch changes up to 62e1de1d3352d4c64ebc0335a01186f421cbe6e7:
> 
>   Merge tag 'wireless-2025-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-09-11 12:49:53 +0200)
> 
> ----------------------------------------------------------------

Please do not pull.

We just received a report about a change included here causing
regressions (usb, again).

I'll send a v2 soon with the blame commit reverted.

Thanks,

Paolo



