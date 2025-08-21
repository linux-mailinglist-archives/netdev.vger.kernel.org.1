Return-Path: <netdev+bounces-215562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C1DB2F394
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCB81CE004C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D982ED87E;
	Thu, 21 Aug 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVrcnMpp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D722EE5E1
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767792; cv=none; b=N6SYY6yM6S2Ncurvp54Ld+dA19OPX/bofPmfGrJ6tLhRE1YpWlB0u4rSLwpBgyZl5QcsdKRqBdDP/3t4CrJZnjxWGIj7q1HcJO9Yokm7jYRrO2vXzvlICcrsSclW+nRgT6dk6rUAdA7HymMmgy1dsOWRD/SODBPOFKr+4ZpLpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767792; c=relaxed/simple;
	bh=pm14elPZ5G/j4V8ktFwqsKYTPh/bNpFOvdQNitNlm24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+RpRB/6lfF3HvKK2RvRKEnIja7spc6vngvO/8N1cxY/k4aKIMJLfR0zachpkst6XxzFwYhx5c01og5cjzMDEEjUY+DL083ko073V9zrGD+qXPMxSSt3902m3UA6tHfWsGzrkaLHhg6EK2+bSmLP4y6Y+p2XscYmtKRGsTPRU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVrcnMpp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755767790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFV43Vjpw2YCtuBdkEV7d+CUzzBS4M8wrUUVCTOwfBI=;
	b=hVrcnMppqmV0nfpU6NJB68igdtK9lCtqa/r9z64458cPQxKGtpZNjP+ZGF/HeM7eE6y0mn
	7ogY8YKhhpUvvrhl/NHlevS985GgrLZsYBSNhVIq72TD0VkzKp4g6gWeR7nzg8asrT6YSX
	854VAx31x8qJwc6ocsaxZbLBAGXBSpE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-k9iqYKLoO46w5rCuai-XIw-1; Thu, 21 Aug 2025 05:16:26 -0400
X-MC-Unique: k9iqYKLoO46w5rCuai-XIw-1
X-Mimecast-MFC-AGG-ID: k9iqYKLoO46w5rCuai-XIw_1755767786
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e8704ea619so181384585a.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767786; x=1756372586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFV43Vjpw2YCtuBdkEV7d+CUzzBS4M8wrUUVCTOwfBI=;
        b=JM7RgqCWRNp/6mHb8Z81+HfVQfcDFJ7Msjgsz8MrPeTpUgmghJp4Z5Of4S1F3zr5is
         sZZ2TtIDFT0iNUkpEolhCd/7oNkKQF9VggLiUKFxJpuRmO02kJU6Ek3wgWJKAs5N1x+s
         f9ZGatzEYKPknTiPyZoDzUc3DrfFAcE/nGUblJmnc/a+FkCT80MKBPmmgodkXXK20dvn
         OaM1p4EuPqG4s1mUeGemnEtHVkFVIXdLesyN8ntFsXIdrocVvCVFCbTvsIl/l04DC3jC
         TDA7JYLTa380ZZEq1jQ5Whqb/WDoYhM3MzuEeh11dn9XIFl/hODxHuQbnyUmnKtum9Fb
         N+PA==
X-Forwarded-Encrypted: i=1; AJvYcCXrjj45DWliMH57dPzMiw/2fg0Dx5FV7GjNi3HTpU3Mm5SGQIjcC3bYpuKVDx9pq2h5XWDa8Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAmRoQUr3yB1hc55f+BnkbNfteKm5apfxmo6lk0wO9BsrEw8x
	OloHtk2r0wd7HkLMU8hBNS+q+g4gwOGNRZdCNAenwz6vatAVkkzjzuRr9BY32QKwhq0erJuHmsQ
	dw2rovAkzsee2Ee7z/b/ccfXL4eUrrJRVo0hFIJvJYKkxn5xql0qKAosXPA==
X-Gm-Gg: ASbGncubF3GFxiW6pRaRkJoLI4zZVRWCkEZAzpUUc/LA3reUUIO1BjpC/W2MSBxrPpe
	DB5o0Gt8YLMDtD9ZYKPYqy9lGsTsuBbQpOSSCktlE42OghWYSd8sHMItdlegXFflbLy8V9WXB9N
	fc7QuLmza6tVtRXNBSfgAonC9FhdYWyRwGH/iyg8W4thy2q2zwUh4AoN5njlpsE/d/KYYtmzwHo
	fJjM84QPyVhrpgKJnfe8Dj9EVhko8RizQb4AFw+LsS1xTCo4J2+ejFdqBjCd5Ynnnx4QT26aI+2
	HyFxw7D1JGrX0wXRWshHbJGL3XFXLW1mOccGUBPZDIF/9zX9s93nVMf15tXmUgSVA+oSa8RM98j
	jtpjEshSM0bY=
X-Received: by 2002:a05:622a:2607:b0:4b0:74ac:db35 with SMTP id d75a77b69052e-4b29fa00e71mr17490401cf.12.1755767786298;
        Thu, 21 Aug 2025 02:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO59+xn+TEz6syN109Tg/E9Y9908A1mTpsNgURB+UWGfNs8GFE2O7XylT4YucYAMPXkXfNRg==
X-Received: by 2002:a05:622a:2607:b0:4b0:74ac:db35 with SMTP id d75a77b69052e-4b29fa00e71mr17490011cf.12.1755767785777;
        Thu, 21 Aug 2025 02:16:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c9b9dsm1089675885a.70.2025.08.21.02.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:16:25 -0700 (PDT)
Message-ID: <1ba2c580-6401-4f95-8d63-48634b834234@redhat.com>
Date: Thu, 21 Aug 2025 11:16:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 2/3] bonding: support aggregator selection
 based on port priority
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250818092311.383181-1-liuhangbin@gmail.com>
 <20250818092311.383181-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818092311.383181-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 11:23 AM, Hangbin Liu wrote:
> @@ -1707,6 +1719,9 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
>  	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
>  	 *     select by bandwidth.
>  	 *
> +	 * BOND_AD_PRIO: Select by total priority of ports. If priority
> +	 *     is equal, select by count.
> +	 *
>  	 * BOND_AD_STABLE, BOND_AD_BANDWIDTH: Select by bandwidth.
>  	 */
>  	if (!best)

Minor nit: I think the comment would be more readable placing
BOND_AD_PRIO before BOND_AD_COUNT, so that each value documentation
references only the following one.

Thanks,

Paolo


