Return-Path: <netdev+bounces-219125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A88B40008
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2373E1890C05
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD812FDC3A;
	Tue,  2 Sep 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bbGjOoEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA72FDC2D
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815471; cv=none; b=Qm9cFwER2GM78Z4YJV+a8nlHSoe1u/9uxroDeqamEQNEZMb/pmXmmbwT8qs1oc7L2GnyT+v6jGGb26zfNaY1SOa71jEf1OvrTx7SrCuWzYY8GdcpSUYOGh/BWxvk4dfras5y29t5yaHECjsYJStDldAYHp8d5K1XpYR3TGaqo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815471; c=relaxed/simple;
	bh=ajCHXeRT9qUWoJVcprPMoTB/oi3drEXWgXorP+bs8B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws4+GFLB8JFW8XLuKdF+9DCmwlYOhYBGxAZVzCbc+xH0+L2n6yAwTrU7yWT7kdVwGCZDPPa/dVkCkv5Ak0MWNQckli/TFVsNOnBR+2k7yrvSXRjZzya2k6KhNWhb++iFxzHxiHkBsqv+VY09Bf57doyJm6E4FrzoDXspWQr25CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bbGjOoEw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f74c6d316so2707904e87.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756815467; x=1757420267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iCpQddMLJRrJQifhsXWY+Q2OGrCMHUTkuKYpkEDiO0=;
        b=bbGjOoEww0e6aMyDANuuK+bXaxqrS6NV705ikP+RXBEGdWP9VQsAChgmtsZzg5sFG/
         i1whUzNCJ+IW/CCiGF6rvyE2VRscb727yJRpMYrKo3ZzrDOLRkXWuFQLewtHYnL8Qs+x
         crlOoOz8rt/WoIu3b4Iz2JG8VHO/p2htP+Ez5K4n5Qk4KSE2FhxN6N7t8o2RiEd3OKyP
         3pjkh3O2sF9Cwi9ZSMQ6r4AG/9mvIXsL2DejasDbvtb5ks79xOGGKCSXbxALfYSg7RIm
         azXNhhO6fKRzPk4fRvk2Pt8Ym+hhGreb001TjyvFX1Fl19huyGpDvhks9yGm43+f0Q8l
         BXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815467; x=1757420267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iCpQddMLJRrJQifhsXWY+Q2OGrCMHUTkuKYpkEDiO0=;
        b=Bq08CZ5PiB9jPvKn82ltB0cMkDGuglZ/9KoDfD6zDz2TTnZCat0PFro0IfZxyQTW8u
         fmJ50/d18kM5Vd6IzALjP7f/RncFvCOLIUj7qy1mowyE0/w9cjRW3v90Ik5D+8aZc2BU
         slXisSAPPJdCbyUt0kOk8JKEq/MEhsPIG5Qjtw1ZOSurvyX6DNvNNpd+BcIclbLVjQ+G
         mOA48V2j3+kb/+hg4TuTl27AmR+B3CcqpDzrxjQ3GP2CUbCyWvGJ/8Ch5N5AUwRQZL7G
         IPEFauTVuY04DWi5Db03MKkon5fs1uCwSkjNs44ZwvI4+NQpk3gXVNDRQMSrakI5OouF
         R/5A==
X-Forwarded-Encrypted: i=1; AJvYcCWnhoVPw/CStw88Won1cuSqvwoey38OkYmMFoLqlYczKRQsr9n2Ng5RcwqjHW8HdN+z/DqxfwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EPFacKTQAZ1DTo52v2w0Tid6Bk7GEL/vp/kGyKnaAC8BM7U8
	7XewL9q6ZeiDHPNKYmCK9YdNwrRcUoo+6LE856SDORfsKQwYJsNXW3cCUmP0HhVLhgA=
X-Gm-Gg: ASbGncupcNOe/5dOhjENsc4WeOQHzrRFJ5zDwj0XDN5W41K0kU9tGlFK+q31C0lPtJt
	ZH0gzcUWQ331ar/5c661LVKFsLXpUWkqC7JBe6nk/wGgiq0CUR32XG58dFvgHOSrTUr9gbjLxJP
	w+LHAbuTDfzbKUHNac0/gkExi55boBEiqVtF17hhh/mMT6wyX420vhiC3/h2POPoCI/LiGDcIua
	d2POnXr0FKXsYuAsusWC5FOHo5qdbErQGDbG2O59/AbTX+g2mzfz88oO76Nxh595oy5BUj1DmPy
	cLQGaBRlPkWa9jWCAlMnfbuWd4I1gmpUTdG7y/34+vzYUE8fMBbMgWwrIFVYDsGt4AX8N9HhAL9
	5/kvnPTiQUD9Awqp+4AT/jlixi0SUmOlmK0EntKEIv6NHAADLmbQK+/h66ziiSva3GtHaoe73NJ
	24WA==
X-Google-Smtp-Source: AGHT+IG6Y2S6ttCc1rgioM8V2Bt7Rikb/yiDLeBmqbVMWUGE+lH7RxYzzvo/71Ksboa6WV04ez2Omw==
X-Received: by 2002:a05:6512:3caa:b0:55f:47a9:7d33 with SMTP id 2adb3069b0e04-55f7094fb14mr3953165e87.44.1756815465201;
        Tue, 02 Sep 2025 05:17:45 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827af424sm641016e87.139.2025.09.02.05.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:17:44 -0700 (PDT)
Message-ID: <d16e3744-96c3-46f6-9da8-e9341dcff1d9@blackwall.org>
Date: Tue, 2 Sep 2025 15:17:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] selftests: net: Add a selftest for VXLAN with FDB
 nexthop groups
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com, mcremers@cloudbear.nl
References: <20250901065035.159644-1-idosch@nvidia.com>
 <20250901065035.159644-4-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250901065035.159644-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/25 09:50, Ido Schimmel wrote:
> Add test cases for VXLAN with FDB nexthop groups, testing both IPv4 and
> IPv6. Test basic Tx functionality as well as some corner cases.
> 
> Example output:
> 
>   # ./test_vxlan_nh.sh
>   TEST: VXLAN FDB nexthop: IPv4 basic Tx                              [ OK ]
>   TEST: VXLAN FDB nexthop: IPv6 basic Tx                              [ OK ]
>   TEST: VXLAN FDB nexthop: learning                                   [ OK ]
>   TEST: VXLAN FDB nexthop: IPv4 proxy                                 [ OK ]
>   TEST: VXLAN FDB nexthop: IPv6 proxy                                 [ OK ]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   tools/testing/selftests/net/Makefile         |   1 +
>   tools/testing/selftests/net/test_vxlan_nh.sh | 223 +++++++++++++++++++
>   2 files changed, 224 insertions(+)
>   create mode 100755 tools/testing/selftests/net/test_vxlan_nh.sh
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


