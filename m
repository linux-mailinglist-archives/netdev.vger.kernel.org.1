Return-Path: <netdev+bounces-184557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BBAA96339
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8322D189F846
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029B25E802;
	Tue, 22 Apr 2025 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWNyrIzC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3625DB12
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311572; cv=none; b=h4qn73G0/1+w2afn78Q0Z3IuP6pCznZvaEsnZA5VjmN0dut4pRZzdFuFDVFV5vHDUcxuoDgfSvxxAqcB1Kik4DRPHT7ideM55X4Uj3c1q+TK1kFMLq2POwkkRXZmdn1dhnghxEozVK7VCKWNHI0t35squJUe8oT57FPK40dwedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311572; c=relaxed/simple;
	bh=cq1x4HgKL/2SeFwu+N5ahoZNaLhskx9hR8Vr/uQfcVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiP4wWZH080/WkctfhOgCRIPfngOIccjhe8R3SuhD8xdLPbzllivJCcli3xRuIztTFlkLt+LPyVFrEO2rz4lQtJuojRlntTBO64gVKKYamKHjHXUjDGiLZbuVi8cGomuPNuP+IqXObq5sOs9cwWnZlqxACD0RJhDIiyMFE5xh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWNyrIzC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745311569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipG0IHZArrHhU1oGJQ30GHgQKs7sW/Yk2ttQT1aifFA=;
	b=TWNyrIzC8s98u044pGANBweKK6ffXtSI6TNFH0rOBrxIlsdeX5jEZDCu7eF8kcbx0F2MHy
	UcXuKSLdh5HA5ox2N1CyOSTIKO6KRJfXHmoFNz7V19GUi33wJK/bpm36SeznTVT8ARZmeA
	RsUbkOUtdZP6vwj/fGlKTnL5ItNi8fc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-RjO6u_ybMvCNKb6chPqK1w-1; Tue, 22 Apr 2025 04:46:05 -0400
X-MC-Unique: RjO6u_ybMvCNKb6chPqK1w-1
X-Mimecast-MFC-AGG-ID: RjO6u_ybMvCNKb6chPqK1w_1745311564
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d733063cdso36034785e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 01:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311564; x=1745916364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipG0IHZArrHhU1oGJQ30GHgQKs7sW/Yk2ttQT1aifFA=;
        b=htLgBQAkp6rzOTIu9IpNI9g++rKgzqRCGb+MtWS4FMaA0dxKMLDpSLs2vEE8tNtHle
         ypSOYk9Hq6yaFKv2qlzXjNDlDTkhiJoR1zen/WDads0jxAMEdE5GZqM5Hf0YIAutknmO
         /tIfurPAj//yFP1j2NrmkR7c00EjUU10Rl6xJi6aHy0ZfHt0xj3DLdIhF05cXnlBVhl3
         5gMQT67t0awyHrD1jnX00BaCI7BlTRT1VXboaJ12+t/sfl34iB/gebSG1CQSJPNtjwCL
         8/k2ugdzSXEs+5+92+HZHc/NHD7UYxdSe0/8tecZrWS5S0xG2pWLJ4J/3yX9aD5Glfu3
         zUbg==
X-Forwarded-Encrypted: i=1; AJvYcCVdA4iazu7v2H5x42jHJkeG7xUrgOUSsCm6Jgu+7zfTrjx39RQlGV9GNTf4/4G5tkPxhSsiZjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNoOw78INnxkrGzUUOpMBUs0QAVdhEQNZwFzepHPKUwcweZvE
	UDSEVA6FYPQ/xWxlhn77cUfPV0f6VkXQDgia2YsZ7KIGRYdJVJww7ohSotalqAsqS+MS04mzrjo
	2l641ek/3qHIVOGDuzpK7aFOi3ojo1g6DZ6WizhmnIE3x9onkvRMPqA==
X-Gm-Gg: ASbGncufdDKzqE+SdVTOw4j9gmARgeA9ZOmgaB4sR7rtt4RLZb3BvkRU1XRP8QOjxXc
	Qu0W6U3HCt7WCoCJIuydLyosg5UDsZCcbuXpvaOQDAsGQ5SPpw9mjYyb6ZepAZcebsPT0CA9TWw
	p1EPpbmBAgnyX/ClRVX6u9EOf7SBloYvlxVJo5eZNYAQWvNXpOPUhoINeTVmcbFHWktTfVAZpY0
	G0M6HpEJf2sJ4GOxklUqtfeOoctE+oYgpF+qVv7u9TjMUCcvsIDU0oqJIM/zBCxKnXA0VxQETNe
	2G7ytavCPswQqdKBaQedQA2iTQqNdG7vRwdm
X-Received: by 2002:a05:600c:3b8b:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-4406ac5fb72mr108648565e9.27.1745311564369;
        Tue, 22 Apr 2025 01:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg64TR1qM7WDQYhmv0bzxRlYT/qlJ0Cg0reEDRc6TijbC3LqW3nCaGEgZDfJ++mBRmaV1CcA==
X-Received: by 2002:a05:600c:3b8b:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-4406ac5fb72mr108648405e9.27.1745311564006;
        Tue, 22 Apr 2025 01:46:04 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acca9sm165144315e9.12.2025.04.22.01.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:46:03 -0700 (PDT)
Message-ID: <1887db7e-aa4b-4dd4-b297-dd6f8a31fb0b@redhat.com>
Date: Tue, 22 Apr 2025 10:46:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/15] vxlan: Create wrappers for FDB lookup
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 razor@blackwall.org
References: <20250415121143.345227-1-idosch@nvidia.com>
 <20250415121143.345227-13-idosch@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415121143.345227-13-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 2:11 PM, Ido Schimmel wrote:
> @@ -1286,7 +1300,7 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
>  	struct vxlan_fdb *f;
>  	int err = -ENOENT;
>  
> -	f = __vxlan_find_mac(vxlan, addr, src_vni);
> +	f = vxlan_find_mac(vxlan, addr, src_vni);

Minor note for a possible follow-up (not blocking this series): AFAICS
the above is safe because the caller held the hash lock (otherwise f can
be released as soon as vxlan_find_mac() returns). It could be possibly
useful to make the code more readable a vxlan_find_mac_locked() variant
do to this lookup without the RCU lock and with the proper lockdep
annotation.

I think even the previous lookup could use a similar helper.

Cheers,

Paolo


