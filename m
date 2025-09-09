Return-Path: <netdev+bounces-221218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06913B4FC60
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95804E34AE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B04340D8F;
	Tue,  9 Sep 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix8GFlWK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E443376A7
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424127; cv=none; b=LLEatjWnJ6oroHppyDplwUBBvC4FmHC8Z0rM7u/oHkWZwVQtZeOX3nnGoenYvlqNJixfBG6PfBkN/4UCDanVoxCETH0LOSuRMKiD3LEw+EQzPKY1S/n6Dt5N1bt+5yf0PMrSKpBiadHE4kFkzxd5vAnIg+e83uvio2PZKdPVKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424127; c=relaxed/simple;
	bh=jowkVgL+vgnpq9pMmGbJPkUmoug0Lsb2yWYpNEUGdKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXXchW/15gei64/llaDM3bLKz3Z0/CEjiS5DoNVPQxV/I9n7Ho0HByvmY+pqxiibk+FN+Z1FOyIP4iaU7wfgz4wdYe96kNlD42Bzxr3E2w3Y0kSj7kXlYLX3YLlYlHfDvwIRdzK2n7NG12W27jGi6fCVrHWXjScCWSBZB1Xrx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix8GFlWK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757424124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPhyPk85G2UxdEoSOFqgbpjtqOUyQGnpd0nIPVma3p0=;
	b=ix8GFlWKM30WuttTytzI/E0xM0lTLHjcq+hsKOsLL4dH6uwV9aWC3tDUI/5mvVCh8gLx9z
	0i6EeSG7NzKqmwzu0aRIEgep+8+sfVcI0Nj5DFg3Xauqa6am+j8XACsPVHXkuCitBWkxiW
	oJ8izRFKDQhsew7F7/IX5QJY0FrkR1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-iR6BW5EhNDy4e3TjtqvJ8w-1; Tue, 09 Sep 2025 09:22:02 -0400
X-MC-Unique: iR6BW5EhNDy4e3TjtqvJ8w-1
X-Mimecast-MFC-AGG-ID: iR6BW5EhNDy4e3TjtqvJ8w_1757424121
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e68a54dac2so947924f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424121; x=1758028921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPhyPk85G2UxdEoSOFqgbpjtqOUyQGnpd0nIPVma3p0=;
        b=TwNWejnguwmK9V2KfoipeEtyXUP4AP/evGmfH2SnA77yv/08fI8TVc2kbv+iV8pyet
         rZG6nXpQ3fssC27m2LpPEfn+S1QubRCiuh2f1kNMAbv2jz/aTbG9BxGh6ppFASxoXSBZ
         NlAY9MVQtPae56o1u5MKaH3gjVkX1CCICPP4FLMeVqTTNKx9d4TgBKw8eB36MbMAaMXS
         vJl0rDpt1vtakIOEYzLFfx6R5RZ9TwfysFMAp1i5o3hKt+AdU0JmHV3ftK1kVdcejd9p
         3nLlYiYAqCWFwb5WrAFpHpEKOMtgrRWNyoyrZdygmI+LT4wyRtGR7aUBjcGT9hFSxa2X
         VdVw==
X-Forwarded-Encrypted: i=1; AJvYcCXWC0NzIkihJBTb9MZzB60AjsjFcVqit4HCLD9Vpuyb+3BwlhfZi2EHevRebD4QVPZdKDtWfYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpd9eL06ffAgNcUfUZYcPTN5YlXb6naAm66tAOrmEEmNePupk
	P58TgAzQFwUdSpWwS4r7P5j34K+x23HMcV+1CoQYsBDVQZN7mrKiXqsj7Mb/1XtTui4ViwPY5nf
	XfwmKKhzEzL4Si1Dsh9dmKbdTgIEJoLLXOhhIo9iiOvSJpp7S1to/OJ4m4A==
X-Gm-Gg: ASbGncvlkYKJUQYr/j1PpAJ1xzNRQBDgfNZqSS2TEM0EI2zRlZ2G1aqHQHUDCZArBEf
	WKfUspOqZZe8Wa6nsYeyVEZ+TzzmMRbwa7F72tdiipdEtKlclHgADxpXFhUaa2kXbJDljvffYYr
	SqonrSnP3C5jOHZeyHVCMZmgXce4RGFmX22yX1yO1z+CB+qM6D+/DOOMwxT+cE4rXYw6J+BzZVH
	bCCzMaayXWc9YDUoXh9keU7SOXmr2Bhzfz/yo2N1SXqUQ3FU2REUa1VCCdCEi7Q35DMPSCxvsLQ
	5bWicPTZXzF5diuZQe34/F0/aNuEq1ai4DZnwVFCUkooN7pQTQwFqy0N4rzB+zbNgodbBd4Fkvs
	OhD8ZPNcg0AA=
X-Received: by 2002:adf:eb8f:0:b0:3e5:5261:9fae with SMTP id ffacd0b85a97d-3e55261a1ccmr8379620f8f.12.1757424121339;
        Tue, 09 Sep 2025 06:22:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIuTsIwWmyL//YyGrGKDOHklJNgFnkja+mD63yS586+OgbIJCPnMQAAqkhlazUCV4LKCrvFg==
X-Received: by 2002:adf:eb8f:0:b0:3e5:5261:9fae with SMTP id ffacd0b85a97d-3e55261a1ccmr8379588f8f.12.1757424120499;
        Tue, 09 Sep 2025 06:22:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df4fadb02sm6355255e9.12.2025.09.09.06.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:22:00 -0700 (PDT)
Message-ID: <dbc791a9-7b87-42a8-abba-fa63e5812008@redhat.com>
Date: Tue, 9 Sep 2025 15:21:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/7] bonding: Adding struct bond_arp_target
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-2-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714225533.1490032-2-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 12:54 AM, David Wilder wrote:
> Replacing the definition of bond_params.arp_targets (__be32 arp_targets[])
> with:
> 
> struct bond_arp_target {
> 	__be32			target_ip;
> 	struct bond_vlan_tag	*tags;
> 	u32			flags;
> };

The above struct is going to be allocated on the stack and has 2 holes 4
bytes each.

If you change the layout as follow:

struct bond_arp_target {
 	__be32			target_ip;
 	u32			flags;
 	struct bond_vlan_tag	*tags;
};

the struct size will be 8 bytes less.

/P


