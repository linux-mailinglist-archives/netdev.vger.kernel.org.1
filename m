Return-Path: <netdev+bounces-120902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FBA95B298
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B34283624
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD44517F4F2;
	Thu, 22 Aug 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyqSqpCZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65C16EB4B
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321131; cv=none; b=Ziw8DppVenfAAIv6usKaejNwVDoqUE9XeGTY75ir8HMeG+b6rALvwc3mAGnoXOV47q2eN+XpInvE6aaxQazRzjLXQMB9O7bD0F5gvQwl5NHYNE33WaKDG4Z5+LmiCPQJ4uG8D3y8Plw/iZX7y3a1sGJfSB4USATJr9dzqjJJbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321131; c=relaxed/simple;
	bh=qAUbTDOzk0zhiqxb6tWLJqxN1kgzvrXx4lodHtPt7WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjR22yAOOUKgLKe0rNxXnQtceuEtEkl9ERc6OvZDCtHEfE+XSYky+bBZ+SmLduCrl6roUAU0yVobfl91WFmyXA3T/B0U1kf8gDGI1mJg5zASljt75QPLEDhd/q3mhKltKPOZGDiKkngby4qSzE7kwurHZ1D1v6OLgcpAvtH9Zfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyqSqpCZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724321125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmsvyI30nD2zCrXLKRcTPe+eQYAntSELOFpP0acs7lU=;
	b=DyqSqpCZjgp/aShiWsil/D6Midrvf06Bwuy1qI8cZoagFvWgeqxZPq77O6JL95elqZiOod
	pJ+u4zJoB74DBf+OJ9+vcOKsDd1AlBpKMJivdQtT0ZFb3fH/5NDUtaGqGnMsxa7OmUtosU
	zE1Wc22aQjCUMOkYYCNq884dJ3+hIww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-eFd_E5sJMDCFZSjgN5jRAw-1; Thu, 22 Aug 2024 06:05:22 -0400
X-MC-Unique: eFd_E5sJMDCFZSjgN5jRAw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280291f739so4957685e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321120; x=1724925920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmsvyI30nD2zCrXLKRcTPe+eQYAntSELOFpP0acs7lU=;
        b=s8dJtFDESjyEjYC4de8zHSNx6jtOfR+bRalYaFz9h8NsbBY7RTugQUM25It4yhia+/
         efyeaj20/CXH0Vnpq468zeu3W62WmglKNWKFzV1ztfI9k7at0wEVuKEy7TPQaj/oP4Uw
         DBUl0uDY3R2OqjIV0RxfD4j8wejEijPHvXB5WMnmzFCHOIt2TfRSaivlUHWJjwsgv9+P
         hPlDAQtIgm1kVi57iMdMkoMOo70hn8JxFG7aC/ouDHZuT5TDBmg/nx90mLAhuAjTLH9D
         OVuCu2CVxjdBVEOqxPKgE/HiM62gB/O6o+WQK8xYZlw7G4RtnErA42ecrOfQ1QTUdgp1
         UNNw==
X-Forwarded-Encrypted: i=1; AJvYcCU79xYwCpNkEa5sQ4Ui1wF3tOsnsqCEF+Uiq56vpkglQYvM7zg6qhJi3eVzDBXzm72FyDEwIfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbcFhGfr4+NUED/vnu01tVBUxht4Dk2Y6e6exMJZYZiP4lVIi
	Bgj9QRGEB8k1h6oEl84W8Hsx9YdxJiuInQUbeYbcQT75uFh/dV9ryjLd+EM7qUeJ5qRhKWm5jdD
	28PzIHXwTW4rKxrtMAdzZZCbe8RjLWb4DjT9d0rKacLoV8K2/papZyg==
X-Received: by 2002:a05:600c:4755:b0:428:d83:eb6b with SMTP id 5b1f17b1804b1-42abf05917fmr35122975e9.15.1724321119901;
        Thu, 22 Aug 2024 03:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQwgmm9FuBsRBptjyF/Blm1gjCVTKlIsWCF4aU18+UfJb/reUv4GyHZYUqE7kfqsR+XjYeYw==
X-Received: by 2002:a05:600c:4755:b0:428:d83:eb6b with SMTP id 5b1f17b1804b1-42abf05917fmr35122815e9.15.1724321119435;
        Thu, 22 Aug 2024 03:05:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8d1d9sm56753095e9.22.2024.08.22.03.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 03:05:19 -0700 (PDT)
Message-ID: <0540a49d-40e2-45a7-a068-fd14b75584f0@redhat.com>
Date: Thu, 22 Aug 2024 12:05:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix csum calculation for encapsulated packets
To: =?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?= <amy.saq@antgroup.com>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240819111745.129190-1-amy.saq@antgroup.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240819111745.129190-1-amy.saq@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/19/24 13:17, 沈安琪(凛玥) wrote:
> This commit fixes the issue that when a packet is encapsulated, such as
> sending through a UDP tunnel, the outer TCP/UDP checksum is not
> correctly recalculated if (1) checksum has been offloaded to hardware
> and (2) encapsulated packet has been NAT-ed again, which causes the
> packet being dropped due to the invalid outer checksum.
> 
> Previously, when an encapsulated packet met some NAT rules and its
> src/dst ip and/or src/dst port has been modified,
> inet_proto_csum_replace4 will be invoked to recalculated the outer
> checksum. However, if the packet is under the following condition: (1)
> checksum offloaded to hardware and (2) NAT rule has changed the src/dst
> port, its outer checksum will not be recalculated, since (1)
> skb->ip_summed is set to CHECKSUM_PARTIAL due to csum offload and (2)
> pseudohdr is set to false since port number is not part of pseudo
> header. 

I don't see where nat is calling inet_proto_csum_replace4() with 
pseudohdr == false: please include more detailed description of the 
relevant setup (ideally a self-test) or at least a backtrace leading to 
the issue.

> This leads to the outer TCP/UDP checksum invalid since it does
> not change along with the port number change.
> 
> In this commit, another condition has been added to recalculate outer
> checksum: if (1) the packet is encapsulated, (2) checksum has been
> offloaded, (3) the encapsulated packet has been NAT-ed to change port
> number and (4) outer checksum is needed, the outer checksum for
> encapsulated packet will be recalculated to make sure it is valid.

Please add a suitable fix tag.

> Signed-off-by: Anqi Shen <amy.saq@antgroup.com>
> ---
>   net/core/utils.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/utils.c b/net/core/utils.c
> index c994e95172ac..d9de60e9b347 100644
> --- a/net/core/utils.c
> +++ b/net/core/utils.c
> @@ -435,6 +435,8 @@ void inet_proto_csum_replace4(__sum16 *sum, struct sk_buff *skb,
>   		*sum = ~csum_fold(csum_add(csum_sub(csum_unfold(*sum),
>   						    (__force __wsum)from),
>   					   (__force __wsum)to));
> +	else if (skb->encapsulation && !!(*sum))
> +		csum_replace4(sum, from, to);

This looks incorrect for a csum partial value, and AFAICS the nat caller 
has already checked for !!(*sum).

Thanks,

Paolo


