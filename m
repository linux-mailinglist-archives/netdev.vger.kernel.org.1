Return-Path: <netdev+bounces-194772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4FACC53F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5A5164730
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF69221714;
	Tue,  3 Jun 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvJzm9EO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5D149C41
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949809; cv=none; b=UmJ7RsCfxQqmGNkvLryB680xFOIc7OaQjCJq5TSmvrpyqliUyg26rjW8j6KZQ4u7+R3VPdqn7IsTkNL+dO1pUUatwBav42w0YAYCkauvLsMbxI7jmuCQCktxdjkLeJsMyFCA1h+9m+ALWHynFZOrejqtQuEURnogYuw/Em24oRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949809; c=relaxed/simple;
	bh=EEfb1n0jSbcHtuK02QRnwKtnaxq+GHglK72eHN1XR+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dv5+XispViHfRHj4jt/fFFPlXOUNhPLtXbz2K5wEkBV5T4kTHsO5eKXRFTqnnjyWlDBJs6DseoyKDcKTitQyG2yna6eALjFfuYkA3FbjfnQm81kGJBxUDAJTyOAsOXMvcpRiOP9/EcEDSiWtVbSij2MVuY+jcEVmw6n967nuRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvJzm9EO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748949806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bvlY+rIl2tF1486WY43gg3Xc4gehhSPHX/tzq5wgF8=;
	b=SvJzm9EOIBJGv7SYnZaFWsbmRfKsVmJFSmcHTaFrRWpuHLfWcLpgXkce90VhWjK0eVs7pW
	xU+A4ol1vRhhXjRKkbpeDfvzb4wf41qujkncx3KcSWKCmhG/tsUWYRWtH6AMdOgZf+U4je
	yXSGeZcxZL4GKZVYUloUjVlU6YDlSnk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-P0WdALEZM3CjQEQog88oYQ-1; Tue, 03 Jun 2025 07:23:25 -0400
X-MC-Unique: P0WdALEZM3CjQEQog88oYQ-1
X-Mimecast-MFC-AGG-ID: P0WdALEZM3CjQEQog88oYQ_1748949804
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d30992bcso21222265e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949803; x=1749554603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bvlY+rIl2tF1486WY43gg3Xc4gehhSPHX/tzq5wgF8=;
        b=eCQoqsvFoNtBsw2G6rbFE8nDLEfpjFnzzio3H5opPenAN12cKRFyEpaHiS4cUW1EOq
         PXwIPSfOb+Hxei65aZClLfHXEN4gcR6XCnjXKp9+TycmIy4fAmoWoXzra9jrLhUlTRf4
         XPTQgnFSAB5RXUd42Px7fg4fXKJLfklBA0bab6GYJVvLIAJnY8YwyHfxUbBsicR18wr3
         YRDAbT7i8ffSMO4OGWbV2AAljcMsUZDtSlc/sejfU54+37Kan6GOgaD0PFCx02CEsVeL
         QfU1Nq5hoi7SkJN9X7KQybTEmqrHmQ1HlWRumamJTAQVSMItDiWPsHnFOfmFAg2nCOgQ
         fCUA==
X-Forwarded-Encrypted: i=1; AJvYcCUoeX/6YDalIZ3L62SAMBig30ZiOla/ZDi69MU2jb0PARDJF0R0AXzTHRHI2udAvEEIcw3659Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOtyjbReB8m1ewZOzNuGY+2yqzW8FQ9v0xIUW1rp4nC4oxd6Z
	7wyxsSPWnVm5+wca4lDfnWCRfLlY6h5HiHXyPmlNaWeTS7S0JY1aRaGO9uT+6s0M+t4gH6t/eMR
	EYaDhp6nDEhTloxmPT9mEdsmk8Pym7OS88lslyoF5B+8hZ3Nakbo/5yi0KxoRwJDoJw==
X-Gm-Gg: ASbGncve7ml2/3cB68j4Nft5LaeIXiT46I31AsC66ShP1BTYCBYqq7mUxXN+Nz9xR5s
	FIikf3rYSMXV5gmItfiTFBgZ1J0+FdGzGnSyHzSh8IlZ3c80FDUr642KFhddlMMXQCcaUd3q8tl
	hqgSA6N5VE4r5p0EIPi7Mv0kECxYhGMrLS0NTuBAOk+hfmHCDQpMPtm5Tyst+ac8C3eyxQVQGsv
	UecMm7rUMk0saldjZ7UEQemmzCUdGAHBwtGxJ3G6/E9cXOE7USz3yFhOKt3uDHTWOm4BuYzY/f7
	9rAZe3hjDwyymEg6APiEcDgPqgMwpSFpxf/6shsh9XmlYXmFmxet0uJv
X-Received: by 2002:a05:600c:4f05:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-4511ee13fb8mr120980055e9.18.1748949803620;
        Tue, 03 Jun 2025 04:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpF1ExRPT+wYK497RpCeQmKjhfnc1tw+jN10WApgYc3qFpsAQTV+zDHBlWzVmpEF68D3RNBg==
X-Received: by 2002:a05:600c:4f05:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-4511ee13fb8mr120979875e9.18.1748949803200;
        Tue, 03 Jun 2025 04:23:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe7415asm18108840f8f.57.2025.06.03.04.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 04:23:22 -0700 (PDT)
Message-ID: <0f128f83-d4fa-462b-bcd0-2309e3c2c212@redhat.com>
Date: Tue, 3 Jun 2025 13:23:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
To: David J Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
References: <20250603035243.402806-1-wilder@us.ibm.com>
 <20250603035243.402806-3-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603035243.402806-3-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:51 AM, David J Wilder wrote:
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 1a3d17754c0a..78d41b7b28b5 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -288,13 +288,21 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>  		bond_option_arp_ip_targets_clear(bond);
>  		nla_for_each_nested(attr, data[IFLA_BOND_ARP_IP_TARGET], rem) {
>  			__be32 target;
> +			char target_str[1024 + 1];

This buffer is too big to be placed on the stack. Also please respect
the reverse christmas tree order.

/p


