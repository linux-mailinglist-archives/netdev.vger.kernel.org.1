Return-Path: <netdev+bounces-183173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB4A8B46C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26100189CF13
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD322C336;
	Wed, 16 Apr 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnKmpc/3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844D5227
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793651; cv=none; b=juQjep+5MVOM+uOLs+rUXq9oiIcEFzQLXHHu848ar/aXLK/fOmCFs+IRzMLk7nhf7uEcEvwNuRN1vIjneov8dIz42k1BRBR/5UaHGsxk5/CKyIgqoOMxjohUR1nx4/7GSF1bjYlqYRXNCGMsl+zPnjVmsFZQ8xz0RYnLRexAj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793651; c=relaxed/simple;
	bh=cpF8JNxt1Bisma6JsAfdgTEnTqpYDJP+VgAMhMOOv2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNtaWXwUpCnHh5DmyDszkHTmrtaoovW3kcBmauazUW+aS9WululToKU+jYYDtP5n3pbrAd+qJhAEPWZpT5CNMYcB+2+yTGn3CtBbMYDuLsGSuBw2mq4M1wCJOoBx2ZbaO4hSa6Nh7j1gpquhWF5LWmNK6TPedy+98t27FAm2zbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnKmpc/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744793648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ldgeQck+tJsJgL5VRuAyS9N+Re0CKOApExZWKXiHxc=;
	b=TnKmpc/3jwPIb7bxMaqt1IkLaUYhaXFVirbPH8c/fwPOL434yNWCxM+jfqH8NapnYvifdz
	9rac5GFXAkgzdzGH/VTZIdwkbTValK3Jp92u6379BB3w52LPtC/GHnJSYMd3VFJ3Ajn9MN
	xDUOI/lWuRE/G7X2Yo00+gCLKS9+cYk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-9_8vlgPMNqOyjELV5ubiRQ-1; Wed, 16 Apr 2025 04:54:06 -0400
X-MC-Unique: 9_8vlgPMNqOyjELV5ubiRQ-1
X-Mimecast-MFC-AGG-ID: 9_8vlgPMNqOyjELV5ubiRQ_1744793646
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ee54d5a00so217585f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 01:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744793645; x=1745398445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ldgeQck+tJsJgL5VRuAyS9N+Re0CKOApExZWKXiHxc=;
        b=enOg8O6DrZgkZW6hqsXM09+9rjh/Z0NO5Vl7xZkib/9MdC9WgvPs9Tzk5ILeE8B0Xw
         eIGvrDs/ddiEsp+G6odw48757ZAGpHSV3vqC/Zqr+5+Gor1eBCq84ZyQHGIl2r/Uy1Kx
         YmDvR9R7WX4jSHhylOorENf7/HDNov8ls2JQ/pWoiGcjQQ4+vmFVVOIijkQJ751mN3OS
         tyNT/gfzyaTsVmRhDiEGUNFF23FPVOYx9rngqPuzOB3k9s9M2pE5ZcpKBFAtYNAAY0h2
         qQLOWh/eXF4yrbJBqunaly2rNxYpiPdYvpnl15lZfbrvIL8rmuViXnkfSb2Qm9/CHlND
         cGDA==
X-Forwarded-Encrypted: i=1; AJvYcCVLr6h2lS3fdGrx9NPKyE9vEFn8H7vseD1QrcL187nt38Q6k1oMdHyatTPUKkqxcEUPw/F71/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/Y42USy+EE7Z5jZaI4yVMcj5p4b+5cs41joGJ5ZZp8hDEtJO
	0lPwIqpbERn8Epfip8AyW8CbEKVnwNjNI/i7Yc+IgbW7WcK7/grv/nQYZ9nrSNtkZWuu28qzzt4
	mPwKTCrXLSTq3/4kEfmlf0r26sRLHu4TqPurwboiM9y3g05UxlROH6w==
X-Gm-Gg: ASbGncuBVlKHgzL3vY1hysOypUrnYN5nvt4EpKv0zOthFGI+XpVe53cuLjv0pqd9Ntg
	xZRzENv6aMTsICO1ycDNOomFq5wbwhd221bw74Th2rzLmJ8c7b0nEX5XL3FNZOtopq38fkLCdoo
	zk1gagFysDkiHEMOdUTZYQeQ7CmcfBeRWvPdIVkRDOdJGnHRksTpbY4Bp2fNR1MNH/Dh2Nop1H5
	H1icAF05Vz5NfOzpDS0Ivv8EzBxN1EbtNrBrNfCIo5aRTPkFrnKmwOqEJRDB6Iv6w1juxa6jUF7
	JIYQyvftTI2l+NvY8ReXd2y7209l0W8FEnhGHpw=
X-Received: by 2002:a5d:64ed:0:b0:39e:cbc7:ad38 with SMTP id ffacd0b85a97d-39ee5b1d0f5mr965445f8f.32.1744793645640;
        Wed, 16 Apr 2025 01:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ9IVzSljWiyrYjdXXGC/Mecb+w+DuNxNVf8N7iG96Q4GHBUJ7wBD2J6Ik8IrPIzpFngupGw==
X-Received: by 2002:a5d:64ed:0:b0:39e:cbc7:ad38 with SMTP id ffacd0b85a97d-39ee5b1d0f5mr965425f8f.32.1744793645339;
        Wed, 16 Apr 2025 01:54:05 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b58cc4csm14725395e9.25.2025.04.16.01.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 01:54:04 -0700 (PDT)
Message-ID: <a9616e0b-3c22-43ab-a8e3-42c239bc5441@redhat.com>
Date: Wed, 16 Apr 2025 10:54:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 03/14] ipv6: Move some validation from
 ip6_route_info_create() to rtm_to_fib6_config().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-4-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> ip6_route_info_create() is called from 3 functions:
> 
>   * ip6_route_add()
>   * ip6_route_multipath_add()
>   * addrconf_f6i_alloc()
> 
> addrconf_f6i_alloc() does not need validation for struct fib6_config in
> ip6_route_info_create().
> 
> ip6_route_multipath_add() calls ip6_route_info_create() for multiple
> routes with slightly different fib6_config instances, which is copied
> from the base config passed from userspace.  So, we need not validate
> the same config repeatedly.
> 
> Let's move such validation into rtm_to_fib6_config().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


