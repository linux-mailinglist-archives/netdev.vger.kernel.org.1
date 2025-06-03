Return-Path: <netdev+bounces-194773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B2ACC543
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBDE1641EE
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529AB223DD1;
	Tue,  3 Jun 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDCElWwh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D691F5E6
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949926; cv=none; b=Pbi/fxCGt7JexNU+rwyBm4hi59DNzfF/Ya9etPcrgZKKAbhEYgPhCRClFfceDNJnWC2W/mU0g9H/Lcikqa7vDID/zeC9f26qrXBQOjU+lEqvOT99xq4mvUMehI2ZHO4Is7y9fHlXvCx5vOWAH84ySs/o0ylCOsPTI6JKaCQE+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949926; c=relaxed/simple;
	bh=RtjqlcRotddY9cuLdBeFBTfBuuwQsJ56K3saJP1Rxbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A/NSHmDGSXB4T9Ept8it4TIwjbq+Nwa2nYvmFphsrBtN1bapkE4WYxXG85FhsawlbrD/SweiGJfAdTs7uw3GBmIdJ3vnlJ6RLEpvtL7srrPKHevfIhQwkha7qqN6eRoByu2TYPab1YtK/Nag96TPnNTFeuUzvL0IGkCnewlAEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDCElWwh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748949923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw5gWK7yNxNGpXr25Zj+mFBYI0NPKXqvVPIKPVgmyJs=;
	b=UDCElWwht5qb96+pqzVSW9JRfVp9iCI3ZUN+AWbpNUSTMVURF3DXGWJZS0PorkTepf/94y
	L2YRtgopZtX7ArkBuIobGsuLliNqybNf/ZWvpIGBvqcJl6jI5+ede3QeUrPKyz9alVA7yd
	WJ3/IyYUDeuyKgOlxE3vLohVvw25tdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-5AzxuRNnP_Kg4a3BclAxCQ-1; Tue, 03 Jun 2025 07:25:21 -0400
X-MC-Unique: 5AzxuRNnP_Kg4a3BclAxCQ-1
X-Mimecast-MFC-AGG-ID: 5AzxuRNnP_Kg4a3BclAxCQ_1748949921
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso3698386f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949920; x=1749554720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw5gWK7yNxNGpXr25Zj+mFBYI0NPKXqvVPIKPVgmyJs=;
        b=O/mXeSROBnki0X+BruU0XABuvPwqlhfk8qzdDGGRMSk7guTYEiiYbG1lFlS+dkA/Of
         IcJh6173oLzEf085zxa+HcAehe5OZXn//d15h2+c5AHyskIl0MGkK00hBnp+xkw31S4m
         SNGx7BWEZTLMVe95U3H8l6Y09B/EEkEXiVu5ab9Oo+dKZzDhF4PjMBubCtQR4KCpFt+H
         /D1Gm5KwqjIAYw/6FPIBaumgHf1tiYnLrqaLZ5k3RT8dshfYUZFNFvnKcgSMDEs4BG58
         hKfJTYubiEEE0awtcfQ8LuUiig6H0Co5PHa6HXKNrRXm177s51ov6JJK3AML5Av4TqRo
         ApPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJdxPdGskdnezNNRbo2GlLK/OGse0CBvecLNV9MShdCeuP9ETm9n388XjyT4QNOYqumIKUuYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUm94i0d6XsVUmanVN0zOZimlmdAN0+L7KwsPDLko1eHQql+mp
	kGeAUQgUL/gus19l7IW9xwlg52K0leYcT9dfmmXAnE7DYrC7pe4keRJTzNuucnVsS61YozcjULF
	ptv+dcFjRf4PSKAV3KrVtanfhI4XA0JeRwNFQix5U/ZrrD1WvPsvVAKhG0nvLNw20lQ==
X-Gm-Gg: ASbGnctTYkm8nO5AbhU4DhCFg8E8JiN+qdyA4LScwHBbpKdDKy4e4la9bSm7pCK+4Ru
	ATyEb26g9NVU0+Yv6Yo2RTXF5MOajwP+PUZiFIpF72wmhJl03gtFoCarm889cKIy5WPINyI3tb6
	gfxd+kBz+FBPbhAo2ZZi/RHFFqKOqgbo0XZiuENK0zFDkHRgQdIpDTZVkwlllGtPDnqHLk9tJuC
	axgtJyKmSbc71U2RYWNyc3o8rQFjoD4L0P+3qAYypbG6wEGXiFhlIRV1j4lhrSxKtfVGeJ8+aGC
	a1yDWEi2poHhfSNRUIGBwjtwzHuIPDvx4khlMsuqXX7sD26piiGrfezH
X-Received: by 2002:a5d:588a:0:b0:3a4:d79a:35a6 with SMTP id ffacd0b85a97d-3a4fe178e45mr8908615f8f.14.1748949920519;
        Tue, 03 Jun 2025 04:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjh2WEW3uL+O2hoixHc8aiHYyOMA+1/XmATlP+pR0OSNsRTcMM/oh6ezbo9jKKqulG3FYX8w==
X-Received: by 2002:a5d:588a:0:b0:3a4:d79a:35a6 with SMTP id ffacd0b85a97d-3a4fe178e45mr8908599f8f.14.1748949920135;
        Tue, 03 Jun 2025 04:25:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb00ccsm158363775e9.17.2025.06.03.04.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 04:25:19 -0700 (PDT)
Message-ID: <0f22133f-2eda-4cc9-9ac3-002a067c986e@redhat.com>
Date: Tue, 3 Jun 2025 13:25:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/4] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
To: David J Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
References: <20250603035243.402806-1-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603035243.402806-1-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:51 AM, David J Wilder wrote:
> The current implementation of the arp monitor builds a list of vlan-tags by
> following the chain of net_devices above the bond. See: bond_verify_device_path().
> Unfortunately with some configurations this is not possible. One example is
> when an ovs switch is configured above the bond.
> 
> This change extends the "arp_ip_target" parameter format to allow for a list of
> vlan tags to be included for each arp target. This new list of tags is optional
> and may be omitted to preserve the current format and process of gathering tags.
> When provided the list of tags circumvents the process of gathering tags by
> using the supplied list. An empty list can be provided to simply skip the the
> process of gathering tags.
> 
> The new optional format for arp_ip_target is:
> arp_ip_target=ipv4-address[vlan-tag\...],...
> 
> Examples:
> arp_ip_target=10.0.0.1,10.0.0.2 (Determine tags automatically for both targets)
> arp_ip_target=10.0.0.1[]        (Don't add any tags, don't gather tags)
> arp_ip_target=10.0.0.1[100/200] (Don't gather tags, use supplied list of tags)
> arp_ip_target=10.0.0.1,10.0.0.2[100] (add vlan 100 tag for 10.0.0.2.
>                                       Gather tags for 10.0.0.1.)
> 
> This set of patches updates the arp_ip_target functionality.
> 
> This new functional is yet to be included to the ns_ip6_target feature.
> 
> The iprout2 package will also need to be updated with the following change:
> 
> 
> diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> index 19af67d0..b599cbae 100644
> --- a/ip/iplink_bond.c
> +++ b/ip/iplink_bond.c
> @@ -242,9 +242,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>                                 int i;
>  
>                                 for (i = 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
> -                                       __u32 addr = get_addr32(target);
> -
> -                                       addattr32(n, 1024, i, addr);
> +                                       addattrstrz(n, 1024, i, target);
>                                         target = strtok(NULL, ",");
>                                 }
>                                 addattr_nest_end(n, nest);
> 
> Signed-off-by: David J Wilder <wilder@us.ibm.com>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


