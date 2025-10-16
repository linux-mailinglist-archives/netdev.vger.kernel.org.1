Return-Path: <netdev+bounces-230034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC265BE31D0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8884C356C72
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC753164B0;
	Thu, 16 Oct 2025 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JozoOCie"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25C21C9F9
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614696; cv=none; b=aIJJvbOgv4dS9VxsFxgq34OBC+2nTuwVt3GOqIQQTkZQGdblu9A9Zz0UK4vcaHGI/D5jVIfWhm2x2UW79n1BZEBiboAk9/CIqcEdzN9UW+ZXMewiVrFY/Ryj4zdeA8D5O8KZa/UwnAP8BYiQFsKZkSbXEel7c9YN3zss+ZH6AFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614696; c=relaxed/simple;
	bh=mMns2NLuKvFzapDVIPj9BjrjeM9df/lrxjTiKmiHdzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is6LqlYykKEa+fgcqz74lOGMu5vpLJ5ZceXgY05zhPhnHZfRIQtC5XT0qrvnFvzkGAwqIxwLv1fUfQhQ9gR1KT5b1jud60MlovE3x9YORBpOIyjBDxCTMhrhU5B8PyWj5Vd8BVmPVmTUllg1rjF1o3IIO5ueFsKod/4JQd57eZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JozoOCie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760614694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxlH62rmLXxD25B6COVDNzPmfmbwucOAmPDOFM8kKCs=;
	b=JozoOCievUag3TPh771pQ/rX/gJEug7BaaeDbHMJqFZViOvcnF9p1j1BufHCIRnHUAOBIR
	PPsSSktnJKDYCQHqO25kul9CHzcyurPO5FZNEjV3eR+u/ZvuIN8TZiP541p3DpHqbvwcRL
	haJP2QisJViI1dcaEJ0PsUDlm3mAcbA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-TjBvz7RaMG-WR87_HvKNfg-1; Thu, 16 Oct 2025 07:38:12 -0400
X-MC-Unique: TjBvz7RaMG-WR87_HvKNfg-1
X-Mimecast-MFC-AGG-ID: TjBvz7RaMG-WR87_HvKNfg_1760614691
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4256fae4b46so429943f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614691; x=1761219491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxlH62rmLXxD25B6COVDNzPmfmbwucOAmPDOFM8kKCs=;
        b=gj3wfcX8WVJZ49XwQKPmA05RIRqEGmfr/0IYU7q8ySZxewOqbDzg176FMFugt4uFnR
         EFypVWWvXr9mSPa0ZDan4/Sj8enSATZ0CeD9YPZTOLmZAQBL7qYH627F0+bwcDXrHOjb
         aK+tTteUVZw/JKc5QV+oQXWKPD+mqiYqpBMQqbiPtdQ2QcfzTBL0qRmAxbZMQBCF2jHd
         cGpVJcjkoW5p2AMZctcuKcZO99uFvIGjAfG7WIF6pxmEjzXpW8klRCWtq47O0tHx2YCX
         WslChYyy/T9qrIyMGJGFP+15qO69ianN4EN+1W2nILxHe/Qv0fwM9pqWE/RfN82m8NEE
         MVYg==
X-Forwarded-Encrypted: i=1; AJvYcCVSMZyi4kxls/BIUKiPKSSRsmMaaiY/mGf/y8Kmrh6rJWsXkMSBw+zqTN8TbGen8myqsKKZBhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVJ3Bv6L0t+LFChTDZbECAUQrtDuZ4iR4kjFlQU7alyVkofZ2
	AP1tmNKNWZdjwntpeyTEJ0ZD8VjFWwwTXk2OzLx//97ErCIF9RVmyfI4s86TCN7uCW5xm7MfQcR
	2DcrYpL1mmvbBqxDVnBL/q37OY2DLMVG7EPERpq42oiXpi0EesL6OIdD6uQ==
X-Gm-Gg: ASbGncvjKX6N6TymtioA9MEWqYi5//fmkw7iPs5oBZzNYYpv4lM4aYoAm9XnnNYp9T7
	P4zVzl3g38rkS4hQ7JacrOtjm0elEKysP5VUIZdJuyOLIk3CmqisccbhgOWCE+RC+QnfRSa6uzh
	6VNJWHkkwv3UeXSAV3dAG7L5xVD0QJoBrCZz2cCFXE/X7dWeit9pxkAIbT4+hJxvPlG/vQ1NQVn
	vBdDvssUtKsIQPCNeL7A7+qvQde9ZiowLFOeUewhiaZtGNEymAhBqS8Y4IN8+KjnH1xuTgIAHhM
	c+w7H5xiSjKHi6I6/5IM/v/11dvwcdQRLl/G7fCDTI6oAZVemoS9CDaQUUGHhPWm4gOKt2e7Wwk
	C1kXeP7onpz1orGm51LO61ExXZk8E38pFurB5I9Eq7hhbO6c=
X-Received: by 2002:a05:6000:26cc:b0:425:8134:706 with SMTP id ffacd0b85a97d-42667177f6emr22365162f8f.16.1760614691317;
        Thu, 16 Oct 2025 04:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlbzfdodGlxEMQUBXyg95AbgC7ZM5TUhTD/KeOn7lRcc2boXF79zLjNFY0/GsL7i1rm/K/sQ==
X-Received: by 2002:a05:6000:26cc:b0:425:8134:706 with SMTP id ffacd0b85a97d-42667177f6emr22365139f8f.16.1760614690911;
        Thu, 16 Oct 2025 04:38:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426dac8691fsm25592121f8f.50.2025.10.16.04.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:38:10 -0700 (PDT)
Message-ID: <b2526050-acf6-451a-8f0a-17ce1a8261a0@redhat.com>
Date: Thu, 16 Oct 2025 13:38:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 5/7] bonding: Update to bond_arp_send_all()
 to use supplied vlan tags
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251013235328.1289410-1-wilder@us.ibm.com>
 <20251013235328.1289410-6-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013235328.1289410-6-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 1:52 AM, David Wilder wrote:
> @@ -3097,9 +3100,11 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
>  		if (rt->dst.dev == bond->dev)
>  			goto found;
>  
> -		rcu_read_lock();
> -		tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
> -		rcu_read_unlock();
> +		if (!tags) {
> +			rcu_read_lock();
> +			tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
> +			rcu_read_unlock();
> +		}
>  
>  		if (!IS_ERR_OR_NULL(tags))
>  			goto found;
> @@ -3115,7 +3120,8 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
>  		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
>  		ip_rt_put(rt);
>  		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
> -		kfree(tags);
> +		if  (!(flags & BOND_TARGET_USERTAGS))
> +			kfree(tags);

It's IMHO not obvious from the above code that `tags` is allocated (by
bond_verify_device_path() if and only if !(flags & BOND_TARGET_USERTAGS)

I think it would be more clear if you use the same condition for both
the allocation and the free calls.

/P


